#ifndef __ASC_MARKET_BOARD_WRITER_MQH__
#define __ASC_MARKET_BOARD_WRITER_MQH__

#include "ASC_ArtifactContracts.mqh"
#include "ASC_ArtifactTextHelpers.mqh"
#include "ASC_ConsumerVisibilityProof.mqh"
#include "../logging/ASC_FunctionResults.mqh"
#include "../core/ASC_Constants.mqh"
#include "../core/ASC_ResultCodes.mqh"
#include "../core/ASC_Version.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../shortlist_selection/ASC_ShortlistSelectionEngine.mqh"
#include "../menu/ASC_TraderControlRegistry.mqh"
#include "../portfolio/ASC_PortfolioExposureSnapshot.mqh"
#include "../io/ASC_FileIO.mqh"

struct ASC_BoardExposureRow
  {
   string symbol;
   string status;
   string direction;
   string entry;
   string stop;
   string target;
   string stop_size;
  };

struct ASC_BoardCommandCandidate
  {
   bool available;
   ASC_ShortlistSymbolSummary row;
   int open_positions;
   int pending_orders;
  };

struct ASC_BoardDangerWatchCandidate
  {
   ASC_ShortlistSymbolSummary row;
   double score;
   int open_positions;
   int pending_orders;
   string reason;
  };

enum ASC_BoardCoverageAuthority
  {
   ASC_BOARD_AUTHORITY_INSUFFICIENT = 0,
   ASC_BOARD_AUTHORITY_PROVISIONAL = 1,
   ASC_BOARD_AUTHORITY_AUTHORITATIVE = 2
  };

ASC_BoardCoverageAuthority ASC_BoardCoverageAuthorityTier(const ASC_ShortlistSymbolSummary &entry);
bool ASC_BoardAllowsOrdinaryL34(const ASC_ShortlistSymbolSummary &entry);
bool ASC_BoardOrdinaryL2AuthorityReady(const ASC_ShortlistSymbolSummary &entry,string &reason_out);
string ASC_MarketBoardEvidenceIntakeState(const ASC_ShortlistSymbolSummary &entry,const bool source_ready);
string ASC_MarketBoardEvidenceIntakeDetail(const ASC_ShortlistSymbolSummary &entry,const bool source_ready);

ASC_ArtifactContract ASC_MarketBoardContract(const string server_root)
  {
   ASC_ArtifactContract contract;
   contract.family = ASC_ARTIFACT_MARKET_BOARD;
   contract.artifact_name = "Market Board";
   contract.target_path = server_root + "\\" + ASC_MARKET_BOARD_FILE;
   contract.publication_state = ASC_PUBLICATION_PENDING;
   return contract;
  }

string ASC_BoardSessionLabel(const ASC_Layer1SymbolState &state)
  {
   string main_bucket_id = ASC_ClassificationCanonicalMainBucketId(state.classification);
   if(main_bucket_id == "crypto")
      return "24H";
   if(main_bucket_id == "fx")
      return "London / New York";
   if(main_bucket_id == "indices")
      return "New York";
   if(main_bucket_id == "metals")
      return "London / New York";
   return "Global";
  }

string ASC_BoardSubgroupName(const ASC_Layer1SymbolState &state)
  {
   return ASC_ArtifactHumanizeLabel(ASC_ClassificationCanonicalSubBucketName(state.classification));
  }

string ASC_BoardClassificationTextOrNeedsReview(const string value)
  {
   string text = value;
   StringTrimLeft(text);
   StringTrimRight(text);
   if(StringLen(text) <= 0)
      return "Needs Review";
   return text;
  }

string ASC_BoardStockClassificationLine(const ASC_SymbolClassification &classification)
  {
   string family = ASC_BoardClassificationTextOrNeedsReview(classification.stock_family_name);
   string sector = ASC_BoardClassificationTextOrNeedsReview(classification.stock_sector_name);
   string industry = ASC_BoardClassificationTextOrNeedsReview(classification.stock_industry_name);
   string sub_industry = ASC_BoardClassificationTextOrNeedsReview(classification.stock_sub_industry_name);
   string product_family = ASC_BoardClassificationTextOrNeedsReview(classification.stock_product_family_name);

   string sector_state = ASC_TrimUpper(classification.stock_sector_resolution_state);
   if(sector_state != "RESOLVED")
      sector = "Needs Review";

   string industry_state = ASC_TrimUpper(classification.stock_industry_resolution_state);
   if(industry_state != "RESOLVED")
      industry = "Needs Review";

   string sub_industry_state = ASC_TrimUpper(classification.stock_sub_industry_resolution_state);
   if(sub_industry_state != "RESOLVED")
      sub_industry = "Needs Review";

   return StringFormat("Family %s | Product %s | Sector %s | Industry %s | Sub-Industry %s",
                       family,
                       product_family,
                       sector,
                       industry,
                       sub_industry);
  }

string ASC_BoardFreshnessLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.has_packet)
      return ASC_L2FreshnessToOperatorText(entry.packet.freshness);
   return ASC_ArtifactFreshnessLabel(entry.state.is_degraded, entry.state.is_stale);
  }

bool ASC_BoardHydrationHardUnavailable(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!entry.has_packet)
      return false;

   string reason = entry.packet.hydration_reason_code;
   if(reason == "spec_owner_hard_absence_confirmed")
      return true;
   return false;
  }

string ASC_MarketBoardEvidenceIntakeState(const ASC_ShortlistSymbolSummary &entry,const bool source_ready)
  {
   if(!source_ready)
      return ASC_MARKET_BOARD_EVID_INTAKE_SRC_RT_UNPROVEN;

   string state = ASC_MarketBoardEvidenceIntakeText(entry.evidence_intake_state);
   if(state == ASC_MARKET_BOARD_EVID_INTAKE_CLEAN_SUPPORTED
      || state == ASC_MARKET_BOARD_EVID_INTAKE_NON_CLEAN_AVAILABLE
      || state == ASC_MARKET_BOARD_EVID_INTAKE_UNAVAILABLE_RECOVERABLE
      || state == ASC_MARKET_BOARD_EVID_INTAKE_STALE_RECOVERABLE
      || state == ASC_MARKET_BOARD_EVID_INTAKE_INSUFFICIENT_NOW
      || state == ASC_MARKET_BOARD_EVID_INTAKE_DEP_BLOCKED
      || state == ASC_MARKET_BOARD_EVID_INTAKE_NOT_APPLICABLE
      || state == ASC_MARKET_BOARD_EVID_INTAKE_SRC_RT_UNPROVEN)
      return state;

   return ASC_MARKET_BOARD_EVID_INTAKE_NON_CLEAN_AVAILABLE;
  }

string ASC_MarketBoardEvidenceIntakeDetail(const ASC_ShortlistSymbolSummary &entry,const bool source_ready)
  {
   string state = ASC_MarketBoardEvidenceIntakeState(entry, source_ready);
   string detail = "market_board_evidence_intake_boundary=present";
   detail += " | upstream_shortlist_evidence_state=" + ASC_ShortlistEvidenceIntakeText(entry.evidence_intake_state);
   detail += " | market_board_evidence_intake_state=" + state;
   detail += " | market_board_evidence_intake_claim_evidence_status=" + ASC_MarketBoardEvidenceIntakeClaimEvidenceStatus(state);
   detail += " | market_board_selection_change=no";
   detail += " | market_board_order_change=no";
   detail += " | market_board_wording_change=no";
   detail += " | top_list_change=no";
   detail += " | unavailable_is_not_market_board_gate=yes";
   detail += " | unavailable_remains_recoverable_non_clean=yes";
   detail += " | metadata_only=yes";
   detail += " | future_use=reason_codes_or_conflict_flags_later";
   return detail;
  }

bool ASC_BoardOrdinaryL2AuthorityReady(const ASC_ShortlistSymbolSummary &entry,string &reason_out)
  {
   return ASC_ShortlistOrdinaryL2AuthorityReady(entry, reason_out);
  }

string ASC_BoardCompletionStateLabel(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   string carried_rank = (entry.bucket_rank > 0)
                         ? ("bucket #" + IntegerToString(entry.bucket_rank) + " carried")
                         : "ranking carried";

   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market not entitled";

   if(!entry.has_packet)
      return post_warmup ? (carried_rank + " | packet pending completion") : (carried_rank + " | warmup pending packet");

   string ordinary_l2_reason = "";
   if(ASC_BoardOrdinaryL2AuthorityReady(entry, ordinary_l2_reason))
      return carried_rank + " | ready";

   if(entry.packet.hydration_gate_code == "blocked_by_warmup" || !post_warmup)
      return carried_rank + " | warmup incomplete";

   if(ASC_BoardHydrationHardUnavailable(entry))
      return carried_rank + " | hard unavailable";

   if(entry.packet.continuity_backed || entry.packet.freshness == ASC_L2_CONTINUITY)
      return carried_rank + " | retained while completion runs";

   if(entry.packet.is_stale || entry.packet.freshness == ASC_L2_STALE || entry.packet.freshness == ASC_L2_DEGRADED)
      return carried_rank + " | snapshot stale";

   return carried_rank + " | repair pending";
  }

string ASC_BoardRankActionabilityLine(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "rank/actionability withheld by closed-market ordinary ceiling";

   if(ASC_ShortlistHasLawfulMembership(entry))
     {
      string ordinary_l2_reason = "";
      bool ordinary_l2_ready = ASC_BoardOrdinaryL2AuthorityReady(entry, ordinary_l2_reason);
      if(ordinary_l2_ready)
         return "diversified overall rank is eligible for ordinary board first-pick workflow";
      return "diversified overall rank is carried, but first-pick workflow stays pending lawful Layer-2 readiness";
     }

   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return "bucket rank is informational here; diversified overall first-pick authority stays with promoted overall members";

   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "shortlist ranking context is pending; first-pick workflow is not yet admitted";

   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "reserve ranking only; first-pick workflow stays with current diversified overall members";

   return "not admitted to shortlist authority; first-pick workflow unavailable";
  }

string ASC_BoardPlaceholderLabel(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!entry.has_packet)
      return post_warmup ? "completion pending" : "unavailable";

   string ordinary_l2_reason = "";
   if(ASC_BoardOrdinaryL2AuthorityReady(entry, ordinary_l2_reason))
      return "unavailable";

   if(entry.packet.hydration_gate_code == "blocked_by_warmup" || !post_warmup)
      return "warmup pending";

   if(ASC_BoardHydrationHardUnavailable(entry))
      return "hard unavailable";

   if(entry.packet.continuity_backed || entry.packet.freshness == ASC_L2_CONTINUITY)
      return "retained (completion pending)";

   if(entry.packet.is_stale || entry.packet.freshness == ASC_L2_STALE || entry.packet.freshness == ASC_L2_DEGRADED)
      return "stale snapshot";

   return "completion pending";
  }

string ASC_BoardHydrationReasonLabel(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!entry.has_packet)
      return post_warmup ? "packet build pending" : "warmup packet build";

   string ordinary_l2_reason = "";
   if(ASC_BoardOrdinaryL2AuthorityReady(entry, ordinary_l2_reason))
      return "ready";

   if(entry.packet.hydration_gate_code == "blocked_by_warmup" || !post_warmup)
      return "warmup hydration pending";
   if(ASC_BoardHydrationHardUnavailable(entry))
      return "hard unavailable";
   if(entry.packet.continuity_backed || entry.packet.freshness == ASC_L2_CONTINUITY)
      return "continuity-backed only";
   if(entry.packet.is_stale || entry.packet.freshness == ASC_L2_STALE || entry.packet.freshness == ASC_L2_DEGRADED)
      return "snapshot freshness not current";

   string reason = entry.packet.hydration_reason_code;
   if(reason == "spec_owner_missing")
      return "specification pending";
   if(reason == "permissions_not_filled")
      return "permissions pending";
   if(reason == "session_template_missing")
      return "session-template pending";
   if(reason == "swap_profile_missing")
      return "swap profile pending";
   if(reason == "margin_metadata_missing")
      return "margin metadata pending";
   if(reason == "quote_snapshot_not_live")
      return "quote snapshot pending";
   if(reason == "spread_invalid")
      return "spread validation pending";
   if(reason == "tick_time_missing")
      return "tick timestamp pending";
   if(reason == "day_structure_not_ready")
      return "day-structure analytics pending";
   if(reason == "atr_not_ready")
      return "atr analytics pending";
   if(reason == "volatility_helper_not_ready")
      return "volatility analytics pending";
   if(reason == "liquidity_helper_not_ready")
      return "liquidity analytics pending";

   if(entry.packet.continuity_backed)
      return "retained while completion runs";
   return "repair queue pending";
  }

string ASC_BoardTextOrPlaceholder(const string value,const string placeholder_label)
  {
   string text = ASC_TextOrUnavailable(value);
   if(text == "Unavailable")
      return placeholder_label;
   return ASC_ArtifactHumanizeLabel(text);
  }

string ASC_BoardExposureStatusLabel(const string status)
  {
   if(status == "already_active")
      return "already active";
   if(status == "pending_order")
      return "pending order";
  return ASC_ArtifactHumanizeLabel(status);
  }


string ASC_BoardDeepAvailabilityLabel(void)
  {
   return "selected-symbol only | explicit deep path only | analysis support for that symbol only | does not override ordinary board command authority (see root Dossier.txt and Dossiers/ support artifacts when published)";
  }

bool ASC_BoardAllowsOrdinaryL34(const ASC_ShortlistSymbolSummary &entry)
  {
   return ASC_ConsumerAllowsOrdinaryL34(entry.state);
  }

string ASC_BoardClosedMarketOrdinaryCeilingLabel(void)
  {
   return "closed-market not entitled | ordinary board posture remains Layer 0-2 only";
  }

string ASC_BoardShortlistBandLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   string band = entry.shortlist_band;
   StringToLower(band);
   if(band == "promoted")
      return "Promoted";
   if(band == "shortlisted")
      return "Shortlisted";
   if(band == "reserve")
      return "Reserve";
   if(band == "pending")
      return "Pending";
   if(band == "blocked")
      return "Blocked";
  return ASC_ShortlistMembershipLabel(entry);
  }

string ASC_BoardSelectionLabel(void)
  {
   return "Selection";
  }

string ASC_BoardShortlistLabel(void)
  {
   return "Shortlist";
  }

string ASC_BoardDeepAnalysisLabel(void)
  {
   return "Deep Analysis";
  }

string ASC_BoardSelectionScoreLine(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary ceiling | shortlist / selection / context scoring withheld";

   string attention = ASC_TextOrUnavailable(entry.shortlist_attention_posture);
   if(attention == "Unavailable")
      return StringFormat("%s %.1f | %s %.1f | Context %.1f",
                          ASC_BoardShortlistLabel(),
                          entry.shortlist_score,
                          ASC_BoardSelectionLabel(),
                          entry.shortlist_l3_score,
                          entry.shortlist_context_score);
   return StringFormat("%s %.1f | %s %.1f | Context %.1f | Attention %s",
                       ASC_BoardShortlistLabel(),
                       entry.shortlist_score,
                       ASC_BoardSelectionLabel(),
                       entry.shortlist_l3_score,
                       entry.shortlist_context_score,
                       ASC_ArtifactHumanizeLabel(attention));
  }

string ASC_BoardStyleFitLine(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market not entitled | ordinary style-fit meaning withheld";

   ASC_BoardCoverageAuthority tier = ASC_BoardCoverageAuthorityTier(entry);
   string posture = ASC_TextOrUnavailable(entry.style_fit_posture);
   string reason = ASC_TextOrUnavailable(entry.style_fit_reason);

   if(tier == ASC_BOARD_AUTHORITY_INSUFFICIENT)
      return StringFormat("%s | insufficient-evidence | %s",
                          ASC_BoardCompletionStateLabel(entry, post_warmup),
                          ASC_BoardHydrationReasonLabel(entry, post_warmup));
   if(tier == ASC_BOARD_AUTHORITY_PROVISIONAL)
      return StringFormat("provisional | partial-evidence | %s", ASC_BoardHydrationReasonLabel(entry, post_warmup));

   if(posture != "Unavailable")
      posture = ASC_ArtifactHumanizeLabel(posture);
   return StringFormat("%.1f | %s | %s",
                       entry.style_fit_score,
                       posture,
                       reason);
  }

string ASC_BoardDeepRequestLine(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market not entitled | ordinary deep-request posture withheld";

   ASC_BoardCoverageAuthority tier = ASC_BoardCoverageAuthorityTier(entry);
   string posture = ASC_TextOrUnavailable(entry.deep_request_priority);
   string reason = ASC_TextOrUnavailable(entry.deep_request_reason);

   if(tier == ASC_BOARD_AUTHORITY_INSUFFICIENT)
      return StringFormat("%s | insufficient-evidence | %s",
                          ASC_BoardCompletionStateLabel(entry, post_warmup),
                          ASC_BoardHydrationReasonLabel(entry, post_warmup));
   if(tier == ASC_BOARD_AUTHORITY_PROVISIONAL)
      return StringFormat("provisional | partial-evidence | %s", ASC_BoardHydrationReasonLabel(entry, post_warmup));

   if(posture != "Unavailable")
      posture = ASC_ArtifactHumanizeLabel(posture);

   return StringFormat("%.1f | %s | %s",
                       entry.deep_request_priority_score,
                       posture,
                       reason);
  }

string ASC_BoardTacticalComponentText(const string label,
                                      const ASC_ShortlistSymbolSummary &entry,
                                      const bool post_warmup,
                                      const bool supported,
                                      const double score,
                                      const string posture_raw)
  {
   string posture = ASC_TextOrUnavailable(posture_raw);
   if(!supported || posture == "Unavailable")
      return label + " " + ASC_BoardPlaceholderLabel(entry, post_warmup);
   return StringFormat("%s %.1f (%s)", label, score, ASC_ArtifactHumanizeLabel(posture));
  }

string ASC_BoardTimingComponentText(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   string posture = ASC_TextOrUnavailable(entry.filter.timing_quality_posture);
   if(!entry.filter.session_timing_supported || posture == "Unavailable")
      return "Timing " + ASC_BoardPlaceholderLabel(entry, post_warmup);
   return "Timing " + ASC_ArtifactHumanizeLabel(posture);
  }

string ASC_BoardOpportunityShapeLine(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary ceiling | execution / timing / risk shape withheld";

   string execution_usefulness = ASC_ShortlistExecutionUsefulnessLabel(entry);
   string timing_usefulness = ASC_ShortlistTimingUsefulnessLabel(entry);
   string risk_drag_label = ASC_ShortlistRiskDragLabel(entry);

   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return StringFormat("Context %.1f | Execution %s | Timing %s | Risk Drag %s",
                          entry.filter.context_strength_score,
                          entry.has_packet ? execution_usefulness : ASC_BoardPlaceholderLabel(entry, post_warmup),
                          entry.has_packet ? timing_usefulness : ASC_BoardPlaceholderLabel(entry, post_warmup),
                          entry.has_packet ? risk_drag_label : ASC_BoardPlaceholderLabel(entry, post_warmup));

   return StringFormat("Context %.1f | Execution %.1f (%s) | Spread Stability %.1f | Quote Stability %.1f | Timing %.1f (%s) | Risk Drag %.1f (%s) | Late %.1f",
                       entry.filter.context_strength_score,
                       entry.filter.execution_alignment_score,
                       execution_usefulness,
                       entry.filter.spread_stability_score,
                       entry.filter.quote_stability_score,
                       entry.filter.entry_readiness_score,
                       timing_usefulness,
                       entry.filter.risk_drag_score,
                       risk_drag_label,
                       entry.filter.late_move_risk_score);
  }

string ASC_BoardFieldContextLine(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary ceiling | relative field context withheld";

   string field_regime = ASC_TextOrUnavailable(entry.field_opportunity_regime);
   if(field_regime != "Unavailable")
      field_regime = ASC_ArtifactHumanizeLabel(field_regime);

   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return "relative field context pending next lawful shortlist pass";

   return StringFormat("Relative %.1f | Rank Blend %.1f | Field %s | Leader Separation %.1f | Top-10 Compression %.1f",
                       entry.relative_opportunity_percentile,
                       entry.relative_field_rank_score,
                       field_regime,
                       entry.leader_separation_score,
                       entry.top10_compression_score);
  }

string ASC_BoardSelectionSummaryCompact(const ASC_ShortlistSymbolSummary &entry,
                                        const int open_positions,
                                        const int pending_orders)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary posture | shortlist meaning withheld";

   string execution_usefulness = ASC_ShortlistExecutionUsefulnessLabel(entry);
   string timing_usefulness = ASC_ShortlistTimingUsefulnessLabel(entry);
   string risk_drag_label = ASC_ShortlistRiskDragLabel(entry);

   string candidate_type = "reserve candidate";
   if(entry.shortlisted && entry.rank > 0)
      candidate_type = (entry.rank <= 3) ? "top overall candidate" : "overall backup candidate";
   else if(entry.bucket_shortlisted && entry.bucket_rank > 0)
      candidate_type = "strong bucket leader";
   else if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS
           && entry.field_opportunity_regime == "thin_day_best_available")
      candidate_type = "best-available reserve";

   string condition = "workable";
   if((open_positions + pending_orders) > 0
      || entry.overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
      || entry.overall_board_cluster_count > 0)
      condition = "crowded";
   else if(execution_usefulness == "clean" && timing_usefulness == "usable now")
      condition = "clean";
   else if(execution_usefulness == "poor" || timing_usefulness == "unclear")
      condition = "less useful now";
   else if(execution_usefulness == "dragging" || timing_usefulness == "watch pullback" || risk_drag_label == "heavy")
      condition = "guarded";

   string tactical = (entry.filter.pressure_shift_score >= 60.0 || entry.filter.momentum_acceleration_score >= 58.0)
                     ? "strong tactical carry"
                     : "moderate tactical carry";

   return candidate_type + " " + condition + " " + tactical;
  }

string ASC_BoardDoNotPickReason(const ASC_ShortlistSymbolSummary &entry,
                                const int open_positions,
                                const int pending_orders)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary path is not entitled to shortlist action meaning";
   if((open_positions + pending_orders) > 0)
      return "active exposure conflict keeps first-pick risk elevated";
   if(entry.bucket_shortlisted && !entry.shortlisted)
      return "bucket-local strength stays in reserve outside diversified overall";
   if(entry.overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
      || entry.overall_board_cluster_count > 0)
      return "crowding or peer overlap keeps first-pick cleanliness guarded";
   if(entry.filter.execution_score < 50.0)
      return "execution cleanliness is below preferred first-pick quality";
   if(entry.state.is_stale || entry.state.is_degraded)
      return "freshness is guarded for immediate first-pick timing";
   if(entry.shortlisted && entry.rank > 1)
      return "another ranked candidate currently has stronger immediate support";
   return "";
  }

string ASC_BoardSelectionSummaryLine(const ASC_ShortlistSymbolSummary &entry)
  {
   string summary = ASC_TextOrUnavailable(entry.shortlist_score_summary);
   if(summary != "Unavailable")
      return summary;
   return ASC_TextOrUnavailable(entry.shortlist_reason);
  }

string ASC_BoardOverallRankLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.rank > 0)
      return "#" + IntegerToString(entry.rank);
   return "reserve";
  }

string ASC_BoardRawRankLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.raw_rank > 0)
      return "#" + IntegerToString(entry.raw_rank);
   return "n/a";
  }

string ASC_BoardBucketRankLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.bucket_rank > 0)
      return "#" + IntegerToString(entry.bucket_rank);
   return "n/a";
  }

string ASC_BoardOverallAdmissionLine(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market not entitled | diversified overall admission withheld";

   string peer_symbol = ASC_TextOrUnavailable(entry.overall_board_peer_symbol);
   if(peer_symbol == "Unavailable")
      peer_symbol = "n/a";

   string correlation_text = (peer_symbol != "n/a")
                             ? (peer_symbol + " " + DoubleToString(entry.overall_board_peer_correlation, 2))
                             : "unavailable";
   return StringFormat("Board %.1f | Quality %s | Correlation -%.1f | Diversity -%.1f | Exposure -%.1f | Leading Peer %s",
                       entry.overall_board_score,
                       ASC_ShortlistSignedScoreText(entry.overall_board_quality_adjustment),
                       entry.overall_board_correlation_penalty,
                       entry.overall_board_bucket_penalty,
                       entry.overall_board_conflict_penalty,
                       correlation_text);
  }

string ASC_BoardTacticalCarryLine(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary ceiling | tactical carry withheld";

   string participation = ASC_BoardTacticalComponentText("Participation",
                                                         entry,
                                                         post_warmup,
                                                         entry.filter.participation_supported,
                                                         entry.filter.participation_score,
                                                         entry.filter.participation_posture);
   string execution = ASC_BoardTacticalComponentText("Execution",
                                                     entry,
                                                     post_warmup,
                                                     entry.filter.execution_quality_supported,
                                                     entry.filter.execution_score,
                                                     entry.filter.execution_posture);
   string liquidity = ASC_BoardTacticalComponentText("Liquidity",
                                                     entry,
                                                     post_warmup,
                                                     entry.filter.liquidity_proximity_supported,
                                                     entry.filter.liquidity_proximity_score,
                                                     entry.filter.liquidity_proximity_posture);
   string pressure = ASC_BoardTacticalComponentText("Pressure",
                                                    entry,
                                                    post_warmup,
                                                    entry.filter.pressure_shift_supported,
                                                    entry.filter.pressure_shift_score,
                                                    entry.filter.pressure_shift_posture);
   string momentum = ASC_BoardTacticalComponentText("Momentum",
                                                    entry,
                                                    post_warmup,
                                                    entry.filter.pressure_shift_supported,
                                                    entry.filter.momentum_acceleration_score,
                                                    entry.filter.momentum_acceleration_posture);
   string timing = ASC_BoardTimingComponentText(entry, post_warmup);

   return participation + " | "
          + execution + " | "
          + liquidity + " | "
          + pressure + " | "
          + momentum + " | "
          + timing + " | "
          + ASC_SelectionFilterOverlaySummary(entry.filter);
  }

string ASC_BoardOverallMeaningLine(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market ordinary posture stops at Layer 0-2 | shortlist meaning withheld";

   string overall_reason = ASC_TextOrUnavailable(entry.overall_board_reason);
   if(overall_reason != "Unavailable")
      return overall_reason;

   if(ASC_ShortlistHasLawfulMembership(entry))
      return "diversified overall-board member with no extra exclusion note published";

   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return "bucket-local strength is confirmed, but the symbol stays reserve-only on the diversified overall board";

   string shortlist_reason = ASC_TextOrUnavailable(entry.shortlist_reason);
   if(shortlist_reason != "Unavailable")
      return shortlist_reason;

   return "overall-board meaning is waiting for the next shortlist refresh";
  }

ASC_BoardCoverageAuthority ASC_BoardCoverageAuthorityTier(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return ASC_BOARD_AUTHORITY_INSUFFICIENT;

   string ordinary_l2_reason = "";
   bool ordinary_l2_ready = ASC_BoardOrdinaryL2AuthorityReady(entry, ordinary_l2_reason);
   bool has_lawful_snapshot = (entry.has_packet && ASC_L2PacketHasLawfulSnapshot(entry.packet));
   bool live_quote_ready = (ordinary_l2_ready
                            && entry.packet.valid_bid
                            && entry.packet.valid_ask
                            && entry.packet.bid > 0.0
                            && entry.packet.ask > 0.0);
   bool spread_ready = (ordinary_l2_ready
                        && entry.packet.valid_spread
                        && entry.packet.spread_points >= 0.0
                        && entry.filter.spread_is_sane);
   bool freshness_ready = (!entry.state.is_stale
                           && !entry.state.is_degraded
                           && entry.filter.quote_freshness_is_acceptable
                           && entry.filter.tick_age_is_sane);
   bool context_ready = (entry.filter.structure_context_supported
                         && entry.filter.score_pack_ready);

   if(live_quote_ready
      && spread_ready
      && freshness_ready
      && context_ready
      && entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return ASC_BOARD_AUTHORITY_AUTHORITATIVE;

   if(has_lawful_snapshot
      || ASC_ShortlistHasLawfulMembership(entry)
      || entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS
      || entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return ASC_BOARD_AUTHORITY_PROVISIONAL;

   return ASC_BOARD_AUTHORITY_INSUFFICIENT;
  }

string ASC_BoardCoverageAuthorityLabel(const ASC_BoardCoverageAuthority tier)
  {
   if(tier == ASC_BOARD_AUTHORITY_AUTHORITATIVE)
      return "authoritative";
   if(tier == ASC_BOARD_AUTHORITY_PROVISIONAL)
      return "provisional";
   return "insufficient-evidence";
  }

int ASC_BoardAuthoritativeCandidateCount(const ASC_ShortlistSymbolSummary &rows[])
  {
   int authoritative_count = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(ASC_BoardCoverageAuthorityTier(rows[i]) == ASC_BOARD_AUTHORITY_AUTHORITATIVE)
         authoritative_count++;
     }
   return authoritative_count;
  }

int ASC_BoardOpenMarketEntitledCount(const ASC_ShortlistSymbolSummary &rows[])
  {
   int open_entitled_count = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(ASC_BoardAllowsOrdinaryL34(rows[i]))
         open_entitled_count++;
     }
   return open_entitled_count;
  }

int ASC_BoardOpenMarketAuthoritativeCandidateCount(const ASC_ShortlistSymbolSummary &rows[])
  {
   int authoritative_count = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_BoardAllowsOrdinaryL34(rows[i]))
         continue;
      if(ASC_BoardCoverageAuthorityTier(rows[i]) == ASC_BOARD_AUTHORITY_AUTHORITATIVE)
         authoritative_count++;
     }
   return authoritative_count;
  }

string ASC_BoardCorrelationReadinessLine(const ASC_ShortlistSymbolSummary &entry,
                                               const ASC_ShortlistCorrelationSummary &cor)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "closed-market not entitled | ordinary peer-support readiness withheld";

   string support_state = "limited support";
   if(cor.summary_ready)
      support_state = "ready true correlation";
   else if(cor.summary_posture == "pending")
      support_state = "pending true correlation";
   else if(cor.summary_posture == "limited")
      support_state = "limited support";

   string anchor_state = cor.anchor_packet_ready ? "ready" : "unavailable";
   string note = ASC_TextOrUnavailable(cor.summary_reason);
   return StringFormat("Support %s | Peers %d | Ready Pairs %d | Anchor %s | Note %s",
                       support_state,
                       cor.peers_compared,
                       cor.peers_packet_ready,
                       anchor_state,
                       note);
  }

string ASC_BoardClassificationGuardLine(const ASC_Layer1PassSummary &summary)
  {
   int total = summary.resolved_classification_count + summary.unresolved_classification_count;
   double fallback_ratio = (total > 0 ? (double)summary.fallback_classification_count / (double)total : 0.0);
   string posture = "stable";
   if(fallback_ratio >= 0.40)
      posture = "alert";
   else if(fallback_ratio >= 0.20)
      posture = "watch";

   return StringFormat("Guard %s | %s | %s",
                       posture,
                       ASC_Layer1ClassificationHealthCompact(summary),
                       ASC_Layer1MainGroupDistributionCompact(summary));
  }


string ASC_BoardCanonicalSymbolForState(const ASC_Layer1SymbolState &state)
  {
   if(StringLen(state.classification.canonical_symbol) > 0)
      return state.classification.canonical_symbol;
   if(StringLen(state.identity.normalized_symbol) > 0)
      return state.identity.normalized_symbol;
   return state.symbol;
  }

string ASC_BoardCanonicalSymbolByRaw(const string raw_symbol)
  {
   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState state;
      if(!ASC_Layer1GetCachedSymbol(i, state))
         continue;
      if(state.symbol != raw_symbol)
         continue;
      return ASC_BoardCanonicalSymbolForState(state);
     }
   return raw_symbol;
  }

int ASC_BoardFindExposureRow(const ASC_BoardExposureRow &rows[],const string symbol)
  {
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(rows[i].symbol == symbol)
         return i;
     }
   return -1;
  }

void ASC_BoardUpsertExposureRow(ASC_BoardExposureRow &rows[],
                                const string symbol,
                                const string status,
                                const string direction,
                                const string entry,
                                const string stop,
                                const string target,
                                const string stop_size)
  {
   if(StringLen(symbol) <= 0)
      return;

   int index = ASC_BoardFindExposureRow(rows, symbol);
   if(index < 0)
     {
      index = ArraySize(rows);
      ArrayResize(rows, index + 1);
      rows[index].symbol = symbol;
      rows[index].status = status;
      rows[index].direction = direction;
      rows[index].entry = entry;
      rows[index].stop = stop;
      rows[index].target = target;
      rows[index].stop_size = stop_size;
      return;
     }

   if(StringFind(rows[index].status, status) < 0)
      rows[index].status += " + " + status;

   if(rows[index].direction != direction && StringLen(direction) > 0 && rows[index].direction != "mixed")
      rows[index].direction = "mixed";

   if(rows[index].entry != entry && StringLen(entry) > 0)
      rows[index].entry = "multiple";
   if(rows[index].stop != stop && StringLen(stop) > 0)
      rows[index].stop = "multiple";
   if(rows[index].target != target && StringLen(target) > 0)
      rows[index].target = "multiple";
   if(rows[index].stop_size != stop_size && StringLen(stop_size) > 0)
      rows[index].stop_size = "multiple";
  }

void ASC_BoardBuildExposureRows(ASC_BoardExposureRow &rows[])
  {
   ArrayResize(rows, 0);

   for(int i = 0; i < PositionsTotal(); i++)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ENUM_POSITION_TYPE pos_type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
      double entry_price = PositionGetDouble(POSITION_PRICE_OPEN);
      double stop_loss = PositionGetDouble(POSITION_SL);
      double take_profit = PositionGetDouble(POSITION_TP);
      string entry_text = (entry_price > 0.0) ? DoubleToString(entry_price, 5) : "unavailable";
      string stop_text = (stop_loss > 0.0) ? DoubleToString(stop_loss, 5) : "unavailable";
      string target_text = (take_profit > 0.0) ? DoubleToString(take_profit, 5) : "unavailable";
      string stop_size = (entry_price > 0.0 && stop_loss > 0.0) ? DoubleToString(MathAbs(entry_price - stop_loss), 5) : "unavailable";

      ASC_BoardUpsertExposureRow(rows,
                                 symbol,
                                 "already_active",
                                 ASC_PositionDirectionText(pos_type),
                                 entry_text,
                                 stop_text,
                                 target_text,
                                 stop_size);
     }

   for(int i = 0; i < OrdersTotal(); i++)
     {
      ulong ticket = OrderGetTicket(i);
      if(ticket == 0)
         continue;

      ENUM_ORDER_STATE state = (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE);
      if(state != ORDER_STATE_PLACED && state != ORDER_STATE_PARTIAL)
         continue;

      string symbol = OrderGetString(ORDER_SYMBOL);
      ENUM_ORDER_TYPE order_type = (ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE);
      double entry_price = OrderGetDouble(ORDER_PRICE_OPEN);
      double stop_loss = OrderGetDouble(ORDER_SL);
      double take_profit = OrderGetDouble(ORDER_TP);
      string entry_text = (entry_price > 0.0) ? DoubleToString(entry_price, 5) : "unavailable";
      string stop_text = (stop_loss > 0.0) ? DoubleToString(stop_loss, 5) : "unavailable";
      string target_text = (take_profit > 0.0) ? DoubleToString(take_profit, 5) : "unavailable";
      string stop_size = (entry_price > 0.0 && stop_loss > 0.0) ? DoubleToString(MathAbs(entry_price - stop_loss), 5) : "unavailable";

      ASC_BoardUpsertExposureRow(rows,
                                 symbol,
                                 "pending_order",
                                 ASC_OrderDirectionText(order_type),
                                 entry_text,
                                 stop_text,
                                 target_text,
                                 stop_size);
     }
  }

void ASC_BoardAppendPublicationSafetySkeleton(string &body)
  {
   body += "\nMarket Board Publication Safety\n";
   body += "----------------------------------------\n";
   body += "market_board_publish_status=body_source_ready_pre_publish | market_board_publish_scope=embedded_source_contract | market_board_minimum_skeleton=available | portfolio_section_status=not_requested | history_section_status=not_requested | globaltop10_section_status=not_touched | file_write_status=pre_publish_unobserved | file_write_scope=functionresults_publish_row_authoritative | artifact_failure_boundary=fail_soft | source_supported=true | runtime_observed=false | runtime_observed_scope=embedded_source_contract_not_publish_outcome | runtime_publish_outcome_source=function_results_market_board_publish_row | behavior_change=market_board_portfolio_detail_projection_hardening\n";
   body += "Base Publication Rule: the Market Board skeleton is composed before optional portfolio/history/Top10 readback; optional section failure must be labelled and must not prevent base artifact creation.\n";
   body += "Candidate Filtering Boundary: " + ASC_Phase8CandidateFilteringReviewBoundaryLine() + " | " + ASC_Phase8CandidateFilteringBlockLimitLine() + " | " + ASC_Phase8CandidateFilteringExplicitReviewStateGateLine() + " | " + ASC_Phase8CandidateFilteringNoDriftLine() + "\n";
   body += "Candidate Filtering RUN150 Contract: " + ASC_Phase8CandidateFilteringRun150ContractLine() + "\n";
  }

void ASC_BoardAppendAccountAndRiskSnapshot(string &body)
  {
   ASC_ArtifactAccountSnapshot snapshot;
   ASC_BuildAccountSnapshot(snapshot);

   body += "\nAccount and Risk Snapshot\n";
   body += "----------------------------------------\n";
   body += "State: fresh\n";
   body += "Source Note: live account exposure snapshot for the current board publish\n";
   body += StringFormat("Balance: %s\n", snapshot.balance_available ? DoubleToString(snapshot.balance, 2) : "unavailable");
   body += StringFormat("Equity: %s\n", snapshot.equity_available ? DoubleToString(snapshot.equity, 2) : "unavailable");
   body += StringFormat("Free Margin: %s\n", snapshot.free_margin_available ? DoubleToString(snapshot.free_margin, 2) : "unavailable");
   body += StringFormat("Used Margin: %s\n", snapshot.used_margin_available ? DoubleToString(snapshot.used_margin, 2) : "unavailable");
   body += StringFormat("Margin Level: %s\n", snapshot.margin_level_available ? DoubleToString(snapshot.margin_level, 2) + "%" : "unavailable");
   body += StringFormat("Open Trades: %d\n", snapshot.open_trades);
   body += StringFormat("Pending Orders: %d\n", snapshot.pending_orders);
   body += StringFormat("Open Risk Estimate: %s\n", snapshot.open_risk_available ? DoubleToString(snapshot.open_risk_estimate, 2) : "unavailable");
   body += StringFormat("Risk Estimate Status: %s\n", snapshot.open_risk_partial ? "partial" : (snapshot.open_risk_available ? "available" : "unavailable"));
   body += StringFormat("Exposure Note: %s\n", snapshot.exposure_note);
  }

void ASC_BoardAppendPortfolioTruthSnapshot(string &body,
                                          const ASC_PortfolioExposureSnapshot &snapshot)
  {
   body += "\nPortfolio Truth Snapshot\n";
   body += "----------------------------------------\n";
   body += StringFormat("market_board_publish_status=body_source_ready_pre_publish | market_board_publish_scope=embedded_source_contract | market_board_minimum_skeleton=available | portfolio_section_status=%s | history_section_status=%s | globaltop10_section_status=not_touched | file_write_status=pre_publish_unobserved | file_write_scope=functionresults_publish_row_authoritative | artifact_failure_boundary=fail_soft | source_supported=true | runtime_observed=false | runtime_observed_scope=embedded_source_contract_not_publish_outcome | runtime_publish_outcome_source=function_results_market_board_publish_row | behavior_change=market_board_portfolio_detail_projection_hardening\n",
                        ASC_PortfolioSectionStatusToken(snapshot),
                        ASC_PortfolioHistorySectionStatusToken(snapshot));
   body += ASC_PortfolioExposureDetailsText(snapshot, 512);
   body += "proof_scope=aggregate | trade_permission=false | entry_signal=false | behavior_change=market_board_portfolio_detail_projection_hardening\n";
   body += "Active Exposure Rule: open positions are active exposure; pending orders are future exposure; recent closed trades are history context only.\n";
   body += "Failure Boundary: portfolio/history/GlobalTop10 unavailable states must be labelled, must not become zero-by-assumption, and must not block the base Market Board skeleton from publishing.\n";
  }

void ASC_BoardAppendExcludedOrAlreadyActive(string &body)
  {
   body += "\nExcluded / Already Active\n";
   body += "----------------------------------------\n";
   body += "State: fresh\n";
   body += "Source Note: current trade and pending-order exposure removed from new candidate action space\n";

   ASC_BoardExposureRow rows[];
   ASC_BoardBuildExposureRows(rows);
   if(ArraySize(rows) <= 0)
     {
      body += "No excluded or already active symbols.\n";
      return;
     }

   for(int i = 0; i < ArraySize(rows); i++)
     {
      body += StringFormat("- %s | Status %s | Direction %s | Entry %s | Stop %s | Target %s | Stop Size %s\n",
                           ASC_BoardCanonicalSymbolByRaw(rows[i].symbol),
                           ASC_BoardExposureStatusLabel(rows[i].status),
                           rows[i].direction,
                           rows[i].entry,
                           rows[i].stop,
                           rows[i].target,
                           rows[i].stop_size);
     }
  }


string ASC_BoardRowTraceState(const ASC_ShortlistSymbolSummary &entry,const bool post_warmup)
  {
   if(!ASC_BoardAllowsOrdinaryL34(entry))
      return "hidden-by-rule";
   if((!entry.bucket_shortlisted || entry.bucket_rank <= 0) && (!entry.shortlisted || entry.rank <= 0))
      return "rank-unavailable";
   if(!entry.has_packet)
      return post_warmup ? "packet-pending" : "packet-warmup";
   string ordinary_l2_reason = "";
   if(ASC_BoardOrdinaryL2AuthorityReady(entry, ordinary_l2_reason))
      return "packet-ready";
   if(entry.packet.hydration_gate_code == "blocked_by_warmup" || !post_warmup)
      return "packet-warmup";
   if(entry.packet.continuity_backed || entry.packet.freshness == ASC_L2_CONTINUITY)
      return "retained-last-good";
   if(!entry.correlation_summary.anchor_packet_ready)
      return "anchor-unavailable";
   return "packet-incomplete";
  }

void ASC_BoardAppendSnapshotTruthTrace(string &body,
                                       const ASC_Layer1PassSummary &summary,
                                       const ASC_PublicationBundleState &bundle,
                                       const ASC_ShortlistSymbolSummary &full_rows[],
                                       const bool post_warmup)
  {
   ulong min_l2_revision = 0;
   ulong max_l2_revision = 0;
   datetime min_l3_eval_utc = 0;
   datetime max_l3_eval_utc = 0;
   int packet_ready_count = 0;
   int packet_warmup_count = 0;
   int retained_last_good_count = 0;
   int hidden_by_rule_count = 0;
   int unavailable_market_watch_count = 0;
   int anchor_unavailable_count = 0;

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      string trace_state = ASC_BoardRowTraceState(full_rows[i], post_warmup);
      if(trace_state == "packet-ready")
         packet_ready_count++;
      else if(trace_state == "packet-warmup" || trace_state == "packet-pending")
         packet_warmup_count++;
      else if(trace_state == "retained-last-good")
         retained_last_good_count++;
      else if(trace_state == "hidden-by-rule")
         hidden_by_rule_count++;

      if(!full_rows[i].has_packet || !full_rows[i].packet.valid_bid || !full_rows[i].packet.valid_ask || !full_rows[i].packet.valid_spread)
         unavailable_market_watch_count++;
      if(!full_rows[i].correlation_summary.anchor_packet_ready)
         anchor_unavailable_count++;

      if(full_rows[i].has_packet)
        {
         ulong row_l2_revision = full_rows[i].packet.revision;
         if(min_l2_revision == 0 || (row_l2_revision > 0 && row_l2_revision < min_l2_revision))
            min_l2_revision = row_l2_revision;
         if(row_l2_revision > max_l2_revision)
            max_l2_revision = row_l2_revision;
        }

      datetime row_l3_eval_utc = full_rows[i].filter.evaluated_at_utc;
      if(min_l3_eval_utc == 0 || (row_l3_eval_utc > 0 && row_l3_eval_utc < min_l3_eval_utc))
         min_l3_eval_utc = row_l3_eval_utc;
      if(row_l3_eval_utc > max_l3_eval_utc)
         max_l3_eval_utc = row_l3_eval_utc;
     }

   body += "\nSnapshot Truth Trace\n";
   body += "----------------------------------------\n";
   body += StringFormat("Board Snapshot Identity: publication_id=%s | scanner_pass_utc=%s | board_publish_utc=%s\n",
                        ASC_TextOrUnavailable(bundle.publication_id),
                        ASC_ArtifactFormatUtc(summary.pass_utc),
                        ASC_ArtifactFormatUtc(bundle.publication_utc));
   body += StringFormat("Board Snapshot Freshness: publication_state=%s | lifecycle=%s | source_age=%s\n",
                        ASC_ArtifactPublicationState(summary.is_degraded, summary.is_stale),
                        ASC_TextOrUnavailable(bundle.board_lifecycle_state),
                        (bundle.publication_utc > 0 && summary.pass_utc > 0 && bundle.publication_utc >= summary.pass_utc)
                        ? IntegerToString((int)(bundle.publication_utc - summary.pass_utc)) + "s"
                        : "n/a");
   body += StringFormat("Layer Trace: l2_latest_rev=%I64u | row_l2_rev_range=%I64u-%I64u | l3_closest_eval_range=%s-%s | l4_closest=publication_shortlist_rows@%s\n",
                        ASC_Layer2LatestRevision(),
                        min_l2_revision,
                        max_l2_revision,
                        ASC_ArtifactFormatUtc(min_l3_eval_utc),
                        ASC_ArtifactFormatUtc(max_l3_eval_utc),
                        ASC_ArtifactFormatUtc(summary.pass_utc));
   body += StringFormat("Board Row Readiness: admitted=%d | packet_ready=%d | packet_warmup=%d | retained_last_good=%d | hidden_by_rule=%d | unavailable_market_watch=%d | anchor_unavailable=%d\n\n",
                        ArraySize(full_rows),
                        packet_ready_count,
                        packet_warmup_count,
                        retained_last_good_count,
                        hidden_by_rule_count,
                        unavailable_market_watch_count,
                        anchor_unavailable_count);
  }

void ASC_BoardAppendBucketTruthTrace(string &body,
                                     const string bucket_id,
                                     const ASC_ShortlistSymbolSummary &full_rows[],
                                     const bool post_warmup,
                                     const datetime board_snapshot_utc)
  {
   int admitted_count = 0;
   int packet_ready_count = 0;
   int packet_warmup_count = 0;
   int retained_last_good_count = 0;
   int hidden_by_rule_count = 0;
   int unavailable_market_watch_count = 0;
   ulong min_l2_revision = 0;
   ulong max_l2_revision = 0;
   datetime min_l3_eval_utc = 0;
   datetime max_l3_eval_utc = 0;

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification) != bucket_id)
         continue;
      if(!full_rows[i].bucket_shortlisted || full_rows[i].bucket_rank <= 0)
         continue;

      admitted_count++;
      string trace_state = ASC_BoardRowTraceState(full_rows[i], post_warmup);
      if(trace_state == "packet-ready")
         packet_ready_count++;
      else if(trace_state == "packet-warmup" || trace_state == "packet-pending")
         packet_warmup_count++;
      else if(trace_state == "retained-last-good")
         retained_last_good_count++;
      else if(trace_state == "hidden-by-rule")
         hidden_by_rule_count++;

      if(!full_rows[i].has_packet || !full_rows[i].packet.valid_bid || !full_rows[i].packet.valid_ask || !full_rows[i].packet.valid_spread)
         unavailable_market_watch_count++;

      if(full_rows[i].has_packet)
        {
         ulong row_l2_revision = full_rows[i].packet.revision;
         if(min_l2_revision == 0 || (row_l2_revision > 0 && row_l2_revision < min_l2_revision))
            min_l2_revision = row_l2_revision;
         if(row_l2_revision > max_l2_revision)
            max_l2_revision = row_l2_revision;
        }

      datetime row_l3_eval_utc = full_rows[i].filter.evaluated_at_utc;
      if(min_l3_eval_utc == 0 || (row_l3_eval_utc > 0 && row_l3_eval_utc < min_l3_eval_utc))
         min_l3_eval_utc = row_l3_eval_utc;
      if(row_l3_eval_utc > max_l3_eval_utc)
         max_l3_eval_utc = row_l3_eval_utc;
     }

   body += StringFormat("Bucket Snapshot Trace: bucket=%s | board_snapshot_utc=%s | admitted=%d | packet_ready=%d | packet_warmup=%d | retained_last_good=%d | hidden_by_rule=%d | unavailable_market_watch=%d | row_l2_rev_range=%I64u-%I64u | l3_closest_eval_range=%s-%s\n",
                        bucket_id,
                        ASC_ArtifactFormatUtc(board_snapshot_utc),
                        admitted_count,
                        packet_ready_count,
                        packet_warmup_count,
                        retained_last_good_count,
                        hidden_by_rule_count,
                        unavailable_market_watch_count,
                        min_l2_revision,
                        max_l2_revision,
                        ASC_ArtifactFormatUtc(min_l3_eval_utc),
                        ASC_ArtifactFormatUtc(max_l3_eval_utc));
  }

void ASC_BoardApplyTop5Overlay(const ASC_ShortlistSymbolSummary &entry,ASC_ShortlistSymbolSummary &projected)
  {
   projected = entry;

   ASC_Layer2Packet live_packet;
   ulong min_revision = entry.has_packet ? entry.packet.revision : 0;
   if(!ASC_L2TryGetTop5OverlayPacket(entry.symbol, min_revision, live_packet))
      return;

   projected.packet = live_packet;
   projected.has_packet = ASC_L2PacketHasLawfulSnapshot(live_packet);
  }


string ASC_BoardSameSymbolParityLine(const ASC_ShortlistSymbolSummary &row)
  {
   if(!ASC_BoardAllowsOrdinaryL34(row))
      return "if this symbol is selected later, the dossier may deepen it, but ordinary board authority still stays here once the market reopens";
   return "if this symbol is selected later, the dossier should preserve this board membership baseline and add selected-symbol detail only; ordinary board authority still stays here";
  }

int ASC_BoardDisplayRankForScope(const ASC_ShortlistSymbolSummary &row,const string scope_label)
  {
   if(StringFind(scope_label, "Stocks /") == 0
      && StringFind(scope_label, "Top 5") >= 0
      && row.sub_bucket_rank_available
      && row.sub_bucket_rank > 0)
      return row.sub_bucket_rank;

   if(StringFind(scope_label, "Top 5") >= 0 && row.bucket_rank > 0)
      return row.bucket_rank;

   if(row.rank > 0)
      return row.rank;

   return MathMax(1, row.raw_rank);
  }

void ASC_BoardAppendSymbolBlock(string &body,
                                const ASC_ShortlistSymbolSummary &entry,
                                const string scope_label,
                                const bool post_warmup)
  {
   ASC_ShortlistSymbolSummary row;
   ASC_BoardApplyTop5Overlay(entry, row);

   string bucket_name = ASC_MainBucketOperatorNameFromId(ASC_ClassificationCanonicalMainBucketId(row.state.classification));
   string subgroup_name = ASC_BoardSubgroupName(row.state);
   string ordinary_l2_reason = "";
   bool ordinary_l2_ready = ASC_BoardOrdinaryL2AuthorityReady(row, ordinary_l2_reason);
   bool lawful_snapshot = (row.has_packet && ASC_L2PacketHasLawfulSnapshot(row.packet));
   bool has_day_range = ordinary_l2_ready && ASC_L2PacketHasLawfulDayRange(row.packet);
   bool atr_ready = ordinary_l2_ready && ASC_SummaryAtrReady(row.packet);
   double spread_abs = ordinary_l2_ready ? (row.packet.spread_points * row.packet.point) : 0.0;
   bool spread_pct_ok = ordinary_l2_ready && row.packet.bid > 0.0 && spread_abs > 0.0;
   string placeholder_label = ASC_BoardPlaceholderLabel(row, post_warmup);
   string spread_pct_text = spread_pct_ok ? DoubleToString((spread_abs / row.packet.bid) * 100.0, 3) + "%" : placeholder_label;
   double spread_atr_value = ordinary_l2_ready ? ASC_SummarySpreadAtr(row.packet) : 0.0;
   string spread_atr_text = (ordinary_l2_ready && ASC_SummarySpreadAtrReady(row.packet)) ? DoubleToString(spread_atr_value, 2) : placeholder_label;
   string tick_age_text = (ordinary_l2_ready && row.packet.valid_tick_time) ? IntegerToString(row.packet.packet_age_sec) + "s" : placeholder_label;
   bool ordinary_l34_visible = ASC_BoardAllowsOrdinaryL34(row);
   string shortlist_state = ordinary_l34_visible ? ASC_BoardShortlistBandLabel(row) : "Withheld";
   string filter_state_text = ordinary_l34_visible ? ASC_TextOrUnavailable(row.filter.result_state_operator_text) : "closed-market ordinary ceiling";
   string authority_tier = ordinary_l34_visible ? ASC_BoardCoverageAuthorityLabel(ASC_BoardCoverageAuthorityTier(row)) : "not-entitled";
   string classification_source = ASC_ClassificationCanonicalAuthorityLabel(row.state.classification);
   string classification_resolution = ASC_TextOrUnavailable(row.state.classification.resolution_state);

   ASC_ShortlistCorrelationSummary cor = row.correlation_summary;
   string canonical_symbol = ASC_BoardCanonicalSymbolForState(row.state);
   int open_positions = 0;
   int pending_orders = 0;
   ASC_OpenPendingConflictValue(row.symbol, open_positions, pending_orders);
   string selection_summary = ASC_BoardSelectionSummaryCompact(row, open_positions, pending_orders);
   string do_not_pick_reason = ASC_BoardDoNotPickReason(row, open_positions, pending_orders);

   int display_rank = ASC_BoardDisplayRankForScope(row, scope_label);
   body += StringFormat("%d) %s\n", display_rank, canonical_symbol);
   body += StringFormat("   Identity: %s | %s / %s | Scope %s\n",
                        ASC_L1StateToOperatorText(row.state.state),
                        bucket_name,
                        subgroup_name,
                        scope_label);
   if(ASC_ClassificationCanonicalMainBucketId(row.state.classification) == "stocks")
      body += StringFormat("   Stock Classification: %s\n", ASC_BoardStockClassificationLine(row.state.classification));
   body += StringFormat("   Board Role: %s | Band %s | Filter %s | Authority %s | Posture %s\n",
                        ordinary_l34_visible ? ASC_ShortlistRankStackReadbackText(row, 10) : "withheld",
                        shortlist_state,
                        filter_state_text,
                        authority_tier,
                        ordinary_l34_visible ? ASC_ArtifactHumanizeLabel(row.shortlist_posture) : "closed market");
   body += StringFormat("   Rank vs Actionability: %s\n",
                        ordinary_l34_visible ? ASC_BoardRankActionabilityLine(row) : "withheld");
   body += StringFormat("   Membership Scope: %s\n",
                        ordinary_l34_visible ? ASC_ShortlistMembershipScopeReadbackText(row) : "withheld");
   body += "   Scope Boundary: ordinary board rank and first-pick command stay here; any later selected-symbol deep path is support-only and cannot override this board role.\n";
   body += StringFormat("   Same-Symbol Parity: %s\n", ASC_BoardSameSymbolParityLine(row));
   body += StringFormat("   Selection Summary: %s\n", selection_summary);
   body += StringFormat("   Completion State: %s\n", ASC_BoardCompletionStateLabel(row, post_warmup));
   if(StringLen(do_not_pick_reason) > 0)
      body += StringFormat("   First-Pick Caution: %s\n", do_not_pick_reason);
   body += StringFormat("   Score Stack: %s\n", ASC_BoardSelectionScoreLine(row));
   body += StringFormat("   Opportunity Shape: %s\n", ASC_BoardOpportunityShapeLine(row, post_warmup));
   body += StringFormat("   Relative Field Context: %s\n", ASC_BoardFieldContextLine(row));
   body += StringFormat("   Style Fit: %s\n", ASC_BoardStyleFitLine(row, post_warmup));
   body += StringFormat("   Deep Request: %s\n", ASC_BoardDeepRequestLine(row, post_warmup));
   body += StringFormat("   Overall Admission: %s\n", ASC_BoardOverallAdmissionLine(row));
   body += StringFormat("   Tactical Carry: %s\n", ASC_BoardTacticalCarryLine(row, post_warmup));
   body += StringFormat("   Classification: %s | Source %s\n",
                        ASC_ArtifactHumanizeLabel(classification_resolution),
                        classification_source);
   body += StringFormat("   Market Watch: %s | Bid %s | Ask %s | Spread %s | Spread %% %s | Spread ATR %s | Tick Age %s\n",
                        ASC_BoardFreshnessLabel(row),
                        ordinary_l2_ready ? DoubleToString(row.packet.bid, 5) : placeholder_label,
                        ordinary_l2_ready ? DoubleToString(row.packet.ask, 5) : placeholder_label,
                        ordinary_l2_ready ? DoubleToString(spread_abs, 5) : placeholder_label,
                        spread_pct_text,
                        ASC_TruthLabelApproximation(ordinary_l2_ready, spread_atr_text),
                        tick_age_text);
   body += StringFormat("   Market Context: Day Change %s | ATR %s | Regime %s | Liquidity %s | Context %s\n",
                        ordinary_l34_visible && ordinary_l2_ready && row.packet.valid_daily_change_pct ? DoubleToString(row.packet.daily_change_pct, 2) + "%" : placeholder_label,
                        ordinary_l34_visible && atr_ready ? DoubleToString(ASC_SummaryAtrValue(row.packet), 2) : placeholder_label,
                        ordinary_l34_visible && ordinary_l2_ready ? ASC_BoardTextOrPlaceholder(ASC_SummaryRegimeLabel(row.packet), placeholder_label) : placeholder_label,
                        ordinary_l34_visible && ordinary_l2_ready ? ASC_BoardTextOrPlaceholder(ASC_SummaryLiquidityLabel(row.packet), placeholder_label) : placeholder_label,
                        ordinary_l34_visible && ordinary_l2_ready ? ASC_BoardTextOrPlaceholder(ASC_SummaryContextQuality(row.packet), placeholder_label) : placeholder_label);
   body += "   Correlation / Exposure: " + ASC_CorrelationCompactLine(row.symbol,
                                                                     cor.average_score,
                                                                     cor.high_a_symbol,
                                                                     cor.high_a_score,
                                                                     cor.high_b_symbol,
                                                                     cor.high_b_score,
                                                                     cor.low_a_symbol,
                                                                     cor.low_a_score,
                                                                     cor.low_b_symbol,
                                                                     cor.low_b_score) + "\n";
   body += "   Peer Support Readiness: " + ASC_BoardCorrelationReadinessLine(row, cor) + "\n";
   body += StringFormat("   Exposure Snapshot: Open/Pending Conflict %s | %s\n",
                        ASC_ConflictCountsText(open_positions, pending_orders),
                        ASC_CorrelationExposureInterpretationState(cor.summary_ready, cor.average_score, open_positions, pending_orders));
   body += StringFormat("   Trace: state %s | %s | %s | %s\n",
                        ASC_BoardRowTraceState(row, post_warmup),
                        ASC_L2PacketTraceIdentity(row.packet),
                        ASC_SelectionFilterTraceIdentity(row.filter),
                        ASC_ShortlistTraceIdentity(row));
   body += "   Board Meaning: " + ASC_BoardOverallMeaningLine(row) + "\n";
   body += "   Deep Analysis: " + ASC_BoardDeepAvailabilityLabel() + "\n\n";
  }

void ASC_BoardBuildBucketTopRows(const ASC_ShortlistSymbolSummary &full_rows[],
                                 const string bucket_id,
                                 ASC_ShortlistSymbolSummary &out_rows[])
  {
   ArrayResize(out_rows, 0);
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification) != bucket_id)
         continue;
      if(!full_rows[i].bucket_shortlisted || full_rows[i].bucket_rank <= 0)
         continue;

      int next = ArraySize(out_rows);
      ArrayResize(out_rows, next + 1);
      out_rows[next] = full_rows[i];
     }

   int n = ArraySize(out_rows);
   for(int i = 0; i < n; i++)
     {
      for(int j = i + 1; j < n; j++)
        {
         if(out_rows[j].bucket_rank > 0 && (out_rows[i].bucket_rank <= 0 || out_rows[j].bucket_rank < out_rows[i].bucket_rank))
           {
            ASC_ShortlistSymbolSummary tmp = out_rows[i];
            out_rows[i] = out_rows[j];
            out_rows[j] = tmp;
           }
        }
     }

   if(ArraySize(out_rows) > 5)
      ArrayResize(out_rows, 5);
  }


void ASC_BoardSortTop5SignatureArrays(string &symbols[],string &slugs[],int &ranks[])
  {
   int n = MathMin(ArraySize(symbols), MathMin(ArraySize(slugs), ArraySize(ranks)));
   for(int i = 0; i < n; i++)
     {
      for(int j = i + 1; j < n; j++)
        {
         string lhs_slug = ASC_Top5SnapshotNormalizeSlug(slugs[i]);
         string rhs_slug = ASC_Top5SnapshotNormalizeSlug(slugs[j]);
         int slug_compare = StringCompare(rhs_slug, lhs_slug);
         int symbol_compare = StringCompare(ASC_Top5SnapshotNormalizeSymbol(symbols[j]),
                                            ASC_Top5SnapshotNormalizeSymbol(symbols[i]));
         bool swap_needed = false;
         if(slug_compare < 0)
            swap_needed = true;
         else if(slug_compare == 0 && ranks[j] < ranks[i])
            swap_needed = true;
         else if(slug_compare == 0 && ranks[j] == ranks[i] && symbol_compare < 0)
            swap_needed = true;
         if(!swap_needed)
            continue;

         string tmp_symbol = symbols[i];
         string tmp_slug = slugs[i];
         int tmp_rank = ranks[i];
         symbols[i] = symbols[j];
         slugs[i] = slugs[j];
         ranks[i] = ranks[j];
         symbols[j] = tmp_symbol;
         slugs[j] = tmp_slug;
         ranks[j] = tmp_rank;
        }
     }
  }

void ASC_BoardBuildVisibleTop5SignatureArrays(const ASC_ShortlistSymbolSummary &full_rows[],
                                              string &symbols[],
                                              string &slugs[],
                                              int &ranks[])
  {
   ArrayResize(symbols, 0);
   ArrayResize(slugs, 0);
   ArrayResize(ranks, 0);

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(!full_rows[i].bucket_shortlisted)
         continue;
      if(full_rows[i].bucket_rank <= 0 || full_rows[i].bucket_rank > 5)
         continue;

      string bucket_id = ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification);
      if(StringLen(bucket_id) <= 0)
         bucket_id = "unknown";
      string symbol_name = ASC_BoardCanonicalSymbolForState(full_rows[i].state);
      if(StringLen(symbol_name) <= 0)
         symbol_name = full_rows[i].symbol;

      int next = ArraySize(symbols);
      ArrayResize(symbols, next + 1);
      ArrayResize(slugs, next + 1);
      ArrayResize(ranks, next + 1);
      symbols[next] = symbol_name;
      slugs[next] = bucket_id;
      ranks[next] = full_rows[i].bucket_rank;
     }

   ASC_BoardSortTop5SignatureArrays(symbols, slugs, ranks);
  }

string ASC_BoardVisibleTop5PerBucketSignature(const ASC_ShortlistSymbolSummary &full_rows[],
                                              const datetime source_pass_utc,
                                              const bool normalize_symbols)
  {
   string symbols[];
   string slugs[];
   int ranks[];
   ASC_BoardBuildVisibleTop5SignatureArrays(full_rows, symbols, slugs, ranks);
   return ASC_Top5SnapshotSignatureFromArrays(source_pass_utc, symbols, slugs, ranks, normalize_symbols);
  }

string ASC_BoardTop5CommittedSnapshotContractLine(const ASC_PublicationBundleState &bundle,
                                                  const ASC_ShortlistSymbolSummary &full_rows[],
                                                  const string market_board_top5_signature,
                                                  const string market_board_top5_exact_signature,
                                                  const string market_board_top5_sync_status)
  {
   string line = "Top5PerBucket Committed Snapshot Boundary: ";
   line += "top5_market_board_sync=" + ASC_Top5BoardSyncToken(market_board_top5_sync_status);
   line += " | top5_market_board_sync_status=" + ASC_TextOrUnavailable(market_board_top5_sync_status);
   line += " | market_board_to_top5_dossier_sync=" + ASC_Top5BoardSyncToken(market_board_top5_sync_status);
   line += " | market_board_to_top5_dossier_sync_status=" + ASC_TextOrUnavailable(market_board_top5_sync_status);
   line += " | market_board_visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_signature);
   line += " | market_board_visible_top5_exact_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature);
   line += " | top5_committed_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_signature);
   line += " | top5_committed_exact_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_exact_signature);
   line += " | top5_family_state=" + ASC_TextOrUnavailable(bundle.top5_bucket_family_state);
   line += " | top5_target_children=" + IntegerToString(MathMax(0, bundle.top5_bucket_child_target_count));
   line += " | top5_active_children=" + IntegerToString(MathMax(0, bundle.top5_bucket_active_child_actual_count));
   line += " | top5_staging_children=" + IntegerToString(MathMax(0, bundle.top5_bucket_staging_child_count));
   line += " | top5_queue_remaining=" + IntegerToString(MathMax(0, bundle.top5_bucket_queue_remaining));
   line += " | top5_pending_children=" + IntegerToString(MathMax(0, bundle.top5_bucket_pending_count));
   line += " | top5_pending_reason=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status);
   line += " | alignment_pass_allowed=" + (ASC_Top5BoardSyncToken(market_board_top5_sync_status) == "true" ? "true" : "false");
   line += " | verdict_owner=ASC_MarketBoardWriter_signature_compare";
   return line;
  }




string ASC_BoardAlignmentPendingReasonToken(const ASC_PublicationBundleState &bundle,
                                            const string market_board_top5_sync_status)
  {
   string sync_status = ASC_TextOrUnavailable(market_board_top5_sync_status);
   string family_state = ASC_TextOrUnavailable(bundle.top5_bucket_family_state);
   string alignment_state = ASC_TextOrUnavailable(bundle.top5_bucket_alignment_state);
   string alignment_reason = ASC_TextOrUnavailable(bundle.top5_bucket_alignment_reason);

   if(sync_status == "match")
      return "alignment_pass";
   if(StringFind(sync_status, "signature_mismatch") >= 0 || StringFind(alignment_reason, "mismatch") >= 0)
      return "snapshot_mismatch";
   if(StringFind(sync_status, "missing") >= 0 || StringFind(alignment_reason, "absent") >= 0 || StringFind(alignment_reason, "missing") >= 0)
      return "source_absent";
   if(StringFind(family_state, "staging") >= 0 || bundle.top5_bucket_staging_child_count > 0)
      return "not_yet_committed";
   if(bundle.top5_bucket_queue_remaining > 0)
      return "queue_pending";
   if(bundle.top5_bucket_pending_count > 0)
      return "live_cycle_incomplete";
   if(StringFind(alignment_state, "cadence") >= 0 || StringFind(alignment_reason, "cadence") >= 0)
      return "cadence_hold";
   if(StringFind(alignment_reason, "archive") >= 0)
      return "archive_current_diff";
   return "alignment_pending_refresh";
  }

string ASC_MarketBoardArchiveDirectory(const string server_root)
  {
   if(StringLen(server_root) <= 0)
      return "";
   return server_root + "\\Market Board Archive";
  }

string ASC_MarketBoardArchiveLatestManifestPath(const string server_root)
  {
   string dir = ASC_MarketBoardArchiveDirectory(server_root);
   if(StringLen(dir) <= 0)
      return "";
   return dir + "\\_latest_market_board_archive_manifest.txt";
  }

int ASC_MarketBoardArchiveSlotIndex(const datetime now_utc)
  {
   int cadence = MathMax(60, ASC_MARKET_BOARD_ARCHIVE_CADENCE_SEC);
   int retention = MathMax(1, ASC_MARKET_BOARD_ARCHIVE_RETENTION_SLOTS);
   long slot_source = (long)(now_utc / cadence);
   return (int)MathMod((double)slot_source, (double)retention);
  }

string ASC_MarketBoardArchiveSlotPath(const string server_root,const datetime now_utc)
  {
   string dir = ASC_MarketBoardArchiveDirectory(server_root);
   if(StringLen(dir) <= 0)
      return "";
   return dir + "\\market_board_snapshot_slot_" + StringFormat("%02d", ASC_MarketBoardArchiveSlotIndex(now_utc)) + ".txt";
  }

string ASC_MarketBoardArchiveCompositeSignature(const string run092_board_signature,
                                                const string market_board_top5_signature,
                                                const string market_board_top5_exact_signature,
                                                const string committed_signature,
                                                const string committed_exact_signature,
                                                const string market_board_top5_sync_status)
  {
   return "source_run_id=" + ASC_SourceRunId()
          + "|source_version=" + ASC_VERSION_LABEL
          + "|market_board_signature=" + ASC_TextOrUnavailable(run092_board_signature)
          + "|visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_signature)
          + "|visible_top5_exact_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature)
          + "|committed_top5_signature=" + ASC_TextOrUnavailable(committed_signature)
          + "|committed_top5_exact_signature=" + ASC_TextOrUnavailable(committed_exact_signature)
          + "|sync_verdict=" + ASC_TextOrUnavailable(market_board_top5_sync_status);
  }

string ASC_MarketBoardArchiveReason(const string latest_manifest,
                                    const string archive_signature,
                                    const bool slot_exists)
  {
   if(StringLen(latest_manifest) <= 0)
      return "first_snapshot";
   string token = "archive_signature=" + archive_signature;
   if(StringFind(latest_manifest, token) >= 0)
      return slot_exists ? "skipped_no_change" : "cadence_due";
   return "changed";
  }

string ASC_MarketBoardArchiveEvidencePayload(const ASC_PublicationBundleState &bundle,
                                             const datetime archive_utc,
                                             const string snapshot_reason,
                                             const string archive_signature,
                                             const string run092_board_signature,
                                             const string market_board_top5_signature,
                                             const string market_board_top5_exact_signature,
                                             const string market_board_top5_sync_status,
                                             const string write_state,
                                             const string write_reason)
  {
   string payload = "AURORA SENTINEL SCANNER — MARKET BOARD ARCHIVE SNAPSHOT\n";
   payload += "archive_truth_owner=false\n";
   payload += "archive_is_history_only=true\n";
   payload += "current_market_board_remains_authority=true\n";
   payload += "archive_snapshot_utc=" + ASC_ArtifactFormatUtc(archive_utc) + "\n";
   payload += "snapshot_reason=" + ASC_TextOrUnavailable(snapshot_reason) + "\n";
   payload += "source_run_id=" + ASC_SourceRunId() + "\n";
   payload += "source_version=" + ASC_VERSION_LABEL + "\n";
   payload += "archive_signature=" + archive_signature + "\n";
   payload += "market_board_signature=" + ASC_TextOrUnavailable(run092_board_signature) + "\n";
   payload += "top5_market_board_sync=" + ASC_Top5BoardSyncToken(market_board_top5_sync_status) + "\n";
   payload += "top5_market_board_sync_status=" + ASC_TextOrUnavailable(market_board_top5_sync_status) + "\n";
   payload += "market_board_to_top5_dossier_sync=" + ASC_Top5BoardSyncToken(market_board_top5_sync_status) + "\n";
   payload += "market_board_to_top5_dossier_sync_status=" + ASC_TextOrUnavailable(market_board_top5_sync_status) + "\n";
   payload += "market_board_visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_signature) + "\n";
   payload += "market_board_visible_top5_exact_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   payload += "top5_committed_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_signature) + "\n";
   payload += "top5_committed_exact_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_exact_signature) + "\n";
   payload += "top5_family_state=" + ASC_TextOrUnavailable(bundle.top5_bucket_family_state) + "\n";
   payload += "top5_alignment_state=" + ASC_TextOrUnavailable(bundle.top5_bucket_alignment_state) + "\n";
   payload += "top5_alignment_reason=" + ASC_TextOrUnavailable(bundle.top5_bucket_alignment_reason) + "\n";
   payload += "top5_pending_reason=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status) + "\n";
   payload += "alignment_pass_allowed=" + (ASC_Top5BoardSyncToken(market_board_top5_sync_status) == "true" ? "true" : "false") + "\n";
   payload += "globaltop10_signature=" + ASC_TextOrUnavailable(run092_board_signature) + "\n";
   payload += "market_board_write_state=" + ASC_TextOrUnavailable(write_state) + "\n";
   payload += "market_board_write_reason=" + ASC_TextOrUnavailable(write_reason) + "\n";
   payload += "bounded_retention_slots=" + IntegerToString(MathMax(1, ASC_MARKET_BOARD_ARCHIVE_RETENTION_SLOTS)) + "\n";
   payload += "archive_cadence_sec=" + IntegerToString(MathMax(60, ASC_MARKET_BOARD_ARCHIVE_CADENCE_SEC)) + "\n";
   payload += "no_change_skip=true\n";
   payload += "flush_heavy_loop=false\n";
   payload += "rank_order_formula_change=false\n";
   payload += "strategy_execution_change=false\n";
   payload += "buy_sell_added=false\n";
   return payload;
  }

bool ASC_WriteMarketBoardArchiveSnapshot(const string server_root,
                                         const ASC_PublicationBundleState &bundle,
                                         const string run092_board_signature,
                                         const string market_board_top5_signature,
                                         const string market_board_top5_exact_signature,
                                         const string market_board_top5_sync_status,
                                         const string write_state,
                                         const string write_reason,
                                         string &archive_state_out,
                                         string &archive_reason_out)
  {
   archive_state_out = "not_attempted";
   archive_reason_out = "archive_disabled_or_not_due";
   if(!ASC_MARKET_BOARD_ARCHIVE_ENABLED)
     {
      archive_state_out = "disabled";
      archive_reason_out = "market_board_archive_enabled=false";
      return true;
     }
   if(write_state == "failure" || write_state == "pending")
     {
      archive_state_out = "skipped";
      archive_reason_out = "current_market_board_not_successfully_published";
      return true;
     }

   datetime archive_utc = TimeGMT();
   string slot_path = ASC_MarketBoardArchiveSlotPath(server_root, archive_utc);
   string latest_path = ASC_MarketBoardArchiveLatestManifestPath(server_root);
   if(StringLen(slot_path) <= 0 || StringLen(latest_path) <= 0)
     {
      archive_state_out = "skipped";
      archive_reason_out = "archive_path_unavailable";
      return true;
     }

   string archive_signature = ASC_MarketBoardArchiveCompositeSignature(run092_board_signature,
                                                                      market_board_top5_signature,
                                                                      market_board_top5_exact_signature,
                                                                      bundle.top5_bucket_committed_signature,
                                                                      bundle.top5_bucket_committed_exact_signature,
                                                                      market_board_top5_sync_status);
   string latest_manifest = "";
   ASC_ReadTextFile(latest_path, latest_manifest);
   bool slot_exists = ASC_FileExistsCommon(slot_path);
   string snapshot_reason = ASC_MarketBoardArchiveReason(latest_manifest, archive_signature, slot_exists);
   if(snapshot_reason == "skipped_no_change")
     {
      archive_state_out = "skipped_no_change";
      archive_reason_out = "market_board_archive_no_change_skip=true";
      return true;
     }

   string payload = ASC_MarketBoardArchiveEvidencePayload(bundle,
                                                          archive_utc,
                                                          snapshot_reason,
                                                          archive_signature,
                                                          run092_board_signature,
                                                          market_board_top5_signature,
                                                          market_board_top5_exact_signature,
                                                          market_board_top5_sync_status,
                                                          write_state,
                                                          write_reason);
   string required[];
   ArrayResize(required, 8);
   required[0] = "AURORA SENTINEL SCANNER — MARKET BOARD ARCHIVE SNAPSHOT";
   required[1] = "archive_truth_owner=false";
   required[2] = "archive_is_history_only=true";
   required[3] = "current_market_board_remains_authority=true";
   required[4] = "archive_signature=";
   required[5] = "top5_market_board_sync_status=";
   required[6] = "bounded_retention_slots=";
   required[7] = "rank_order_formula_change=false";

   string slot_state = "pending";
   string slot_reason = "pending";
   if(!ASC_WritePublicationPayloadAtomic(slot_path, payload, required, "archive", slot_state, slot_reason))
     {
      archive_state_out = "archive_write_failed";
      archive_reason_out = slot_reason;
      return true;
     }

   string manifest = payload;
   manifest += "archive_slot_path=" + slot_path + "\n";
   manifest += "archive_manifest_path=" + latest_path + "\n";
   string manifest_state = "pending";
   string manifest_reason = "pending";
   if(!ASC_WritePublicationPayloadAtomic(latest_path, manifest, required, "archive_manifest", manifest_state, manifest_reason))
     {
      archive_state_out = "archive_manifest_failed";
      archive_reason_out = manifest_reason;
      return true;
     }

   archive_state_out = snapshot_reason;
   archive_reason_out = "market_board_archive_snapshot_path=" + slot_path + " | manifest_path=" + latest_path + " | slot_state=" + slot_state + " | manifest_state=" + manifest_state;
   return true;
  }

void ASC_BoardAppendBucketTopFive(string &body,
                                  const string bucket_id,
                                  const ASC_ShortlistSymbolSummary &full_rows[],
                                  const bool post_warmup,
                                  const datetime board_snapshot_utc)
  {
   string bucket_name = ASC_MainBucketOperatorNameFromId(bucket_id);
   string heading = bucket_name + " — Top 5";
   ASC_ShortlistSymbolSummary bucket_rows[];
   ASC_BoardBuildBucketTopRows(full_rows, bucket_id, bucket_rows);
   int open_count = 0;
   int candidate_count = 0;
   int bucket_ready_count = 0;
   int bucket_promoted_count = 0;

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification) != bucket_id)
         continue;
      if(ASC_ConsumerAllowsOrdinaryL34(full_rows[i].state))
         open_count++;
      if(full_rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         candidate_count++;
      if(full_rows[i].bucket_shortlisted)
         bucket_ready_count++;
      string shortlist_band = full_rows[i].shortlist_band;
      StringToLower(shortlist_band);
      if(shortlist_band == "promoted")
         bucket_promoted_count++;
     }

   body += "\n" + heading + "\n";
   body += "----------------------------------------\n";
   body += StringFormat("Open Markets: %d | Candidates: %d | Bucket Top-5 Ready: %d | Promoted: %d | Session %s\n",
                        open_count,
                        candidate_count,
                        bucket_ready_count,
                        bucket_promoted_count,
                        ArraySize(bucket_rows) > 0 ? ASC_BoardSessionLabel(bucket_rows[0].state) : "Global");
   body += "Bucket View: Shortlist bucket ranking, ranked 1-5 inside this market group only\n";
   ASC_BoardAppendBucketTruthTrace(body, bucket_id, full_rows, post_warmup, board_snapshot_utc);
   if(ArraySize(bucket_rows) <= 0)
     {
      body += "No lawful bucket-top entries available.\n";
      return;
     }

   for(int i = 0; i < ArraySize(bucket_rows); i++)
      ASC_BoardAppendSymbolBlock(body, bucket_rows[i], heading, post_warmup);
  }

bool ASC_BoardHasMainBucketRows(const ASC_ShortlistSymbolSummary &full_rows[],const string bucket_id)
  {
   for(int i = 0; i < ArraySize(full_rows); i++)
      if(ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification) == bucket_id)
         return true;
   return false;
  }

void ASC_BoardAppendMainBucketId(string &bucket_ids[],const string bucket_id)
  {
   if(StringLen(bucket_id) <= 0)
      return;
   for(int i = 0; i < ArraySize(bucket_ids); i++)
      if(bucket_ids[i] == bucket_id)
         return;
   int next = ArraySize(bucket_ids);
   ArrayResize(bucket_ids, next + 1);
   bucket_ids[next] = bucket_id;
  }

void ASC_BoardBuildMainBucketSectionOrder(const ASC_ShortlistSymbolSummary &full_rows[],string &bucket_ids[])
  {
   ArrayResize(bucket_ids, 0);

   string preferred_order[];
   ArrayResize(preferred_order, 11);
   preferred_order[0] = "fx";
   preferred_order[1] = "indices";
   preferred_order[2] = "stocks";
   preferred_order[3] = "metals";
   preferred_order[4] = "energy";
   preferred_order[5] = "crypto";
   preferred_order[6] = "rates";
   preferred_order[7] = "volatility";
   preferred_order[8] = "commodities";
   preferred_order[9] = "funds_etfs";
   preferred_order[10] = "unknown";

   for(int i = 0; i < ArraySize(preferred_order); i++)
     {
      if(!ASC_BoardHasMainBucketRows(full_rows, preferred_order[i]))
         continue;
      ASC_BoardAppendMainBucketId(bucket_ids, preferred_order[i]);
     }
  }

string ASC_BoardStockFamilyScopeId(const ASC_ShortlistSymbolSummary &entry)
  {
   string family_id = entry.state.classification.stock_family_id;
   StringTrimLeft(family_id);
   StringTrimRight(family_id);
   StringToLower(family_id);
   if(StringLen(family_id) <= 0)
      return "needs_review";
   return family_id;
  }

string ASC_BoardStockFamilyOperatorLabel(const string family_id_raw)
  {
   string family_id = family_id_raw;
   StringTrimLeft(family_id);
   StringTrimRight(family_id);
   StringToLower(family_id);
   if(family_id == "us_stocks") return "US Stocks";
   if(family_id == "hk_stocks") return "HK Stocks";
   if(family_id == "eu_stocks") return "Europe Stocks";
   if(family_id == "uk_stocks") return "UK Stocks";
   if(family_id == "canada_stocks") return "Canada Stocks";
   if(family_id == "adr_international") return "ADR / International Listings";
   if(family_id == "etf_etp") return "ETF / ETP";
   if(family_id == "reit_yield") return "REIT / Yield Vehicles";
   if(family_id == "needs_review") return "Needs Review";
   return "";
  }

string ASC_BoardStockFamilyScopeName(const ASC_ShortlistSymbolSummary &entry)
  {
   string family_label = ASC_BoardStockFamilyOperatorLabel(ASC_BoardStockFamilyScopeId(entry));
   if(StringLen(family_label) > 0)
      return family_label;

   string family_name = entry.state.classification.stock_family_name;
   StringTrimLeft(family_name);
   StringTrimRight(family_name);
   if(StringLen(family_name) <= 0)
      return "Needs Review";
   return family_name;
  }

bool ASC_BoardHasStockFamilyRows(const ASC_ShortlistSymbolSummary &full_rows[],const string family_id)
  {
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification) != "stocks")
         continue;
      if(ASC_BoardStockFamilyScopeId(full_rows[i]) == family_id)
         return true;
     }
   return false;
  }

bool ASC_BoardHasLawfulStockFamilyOrdinal(const ASC_ShortlistSymbolSummary &entry,const string family_id)
  {
   if(ASC_ClassificationCanonicalMainBucketId(entry.state.classification) != "stocks")
      return false;
   if(ASC_BoardStockFamilyScopeId(entry) != family_id)
      return false;
   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return false;
   return (entry.sub_bucket_rank_available && entry.sub_bucket_rank > 0);
  }

void ASC_BoardBuildStockFamilyTopRows(const ASC_ShortlistSymbolSummary &full_rows[],
                                      const string family_id,
                                      ASC_ShortlistSymbolSummary &out_rows[])
  {
   ArrayResize(out_rows, 0);
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(!ASC_BoardHasLawfulStockFamilyOrdinal(full_rows[i], family_id))
         continue;

      int next = ArraySize(out_rows);
      ArrayResize(out_rows, next + 1);
      out_rows[next] = full_rows[i];
     }

   int n = ArraySize(out_rows);
   for(int i = 0; i < n; i++)
     {
      for(int j = i + 1; j < n; j++)
        {
         bool right_has_rank = (out_rows[j].sub_bucket_rank_available && out_rows[j].sub_bucket_rank > 0);
         bool left_has_rank = (out_rows[i].sub_bucket_rank_available && out_rows[i].sub_bucket_rank > 0);
         if(right_has_rank && (!left_has_rank || out_rows[j].sub_bucket_rank < out_rows[i].sub_bucket_rank))
           {
            ASC_ShortlistSymbolSummary tmp = out_rows[i];
            out_rows[i] = out_rows[j];
            out_rows[j] = tmp;
            continue;
           }
         if(left_has_rank == right_has_rank && out_rows[j].sub_bucket_rank == out_rows[i].sub_bucket_rank
            && ASC_ShortlistRightOutranksLeft(out_rows[i], out_rows[j]))
           {
            ASC_ShortlistSymbolSummary tmp = out_rows[i];
            out_rows[i] = out_rows[j];
            out_rows[j] = tmp;
           }
        }
     }

   if(ArraySize(out_rows) > 5)
      ArrayResize(out_rows, 5);
  }

void ASC_BoardAppendStockFamilyTopFive(string &body,
                                       const string family_id,
                                       const ASC_ShortlistSymbolSummary &full_rows[],
                                       const bool post_warmup)
  {
   ASC_ShortlistSymbolSummary family_rows[];
   ASC_BoardBuildStockFamilyTopRows(full_rows, family_id, family_rows);
   string family_name = "Needs Review";
   int open_count = 0;
   int candidate_count = 0;
   int family_rank_ready_count = 0;
   int bucket_promoted_count = 0;

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(ASC_ClassificationCanonicalMainBucketId(full_rows[i].state.classification) != "stocks")
         continue;
      if(ASC_BoardStockFamilyScopeId(full_rows[i]) != family_id)
         continue;

      family_name = ASC_BoardStockFamilyScopeName(full_rows[i]);
      if(ASC_ConsumerAllowsOrdinaryL34(full_rows[i].state))
         open_count++;
      if(full_rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         candidate_count++;
      if(full_rows[i].sub_bucket_rank_available && full_rows[i].sub_bucket_rank > 0)
         family_rank_ready_count++;
      string shortlist_band = full_rows[i].shortlist_band;
      StringToLower(shortlist_band);
      if(shortlist_band == "promoted")
         bucket_promoted_count++;
     }

   string heading = "Stocks / " + family_name + " — Top 5";
   body += "\n" + heading + "\n";
   body += "----------------------------------------\n";
   body += StringFormat("Open Markets: %d | Candidates: %d | Family Rank Ready: %d | Promoted: %d | Session %s\n",
                        open_count,
                        candidate_count,
                        family_rank_ready_count,
                        bucket_promoted_count,
                        ArraySize(family_rows) > 0 ? ASC_BoardSessionLabel(family_rows[0].state) : "Global");
   body += "Family View: Shortlist stock-family ranking, ranked 1-5 inside this stock peer family only\n";
   if(ArraySize(family_rows) <= 0)
     {
      body += "No lawful stock-family entries available.\n";
      return;
     }

   for(int i = 0; i < ArraySize(family_rows); i++)
      ASC_BoardAppendSymbolBlock(body, family_rows[i], heading, post_warmup);
  }

void ASC_BoardBuildAllMarketsTopRows(const ASC_ShortlistSymbolSummary &full_rows[],
                                     const int limit,
                                     ASC_ShortlistSymbolSummary &out_rows[])
  {
   ArrayResize(out_rows, 0);
   if(limit <= 0)
      return;

   for(int i = 0; i < ArraySize(full_rows) && ArraySize(out_rows) < limit; i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(full_rows[i]))
         continue;
      if(ASC_BoardCoverageAuthorityTier(full_rows[i]) != ASC_BOARD_AUTHORITY_AUTHORITATIVE)
         continue;

      int next = ArraySize(out_rows);
      ArrayResize(out_rows, next + 1);
      out_rows[next] = full_rows[i];
     }

   for(int i = 0; i < ArraySize(full_rows) && ArraySize(out_rows) < limit; i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(full_rows[i]))
         continue;
      if(ASC_BoardCoverageAuthorityTier(full_rows[i]) == ASC_BOARD_AUTHORITY_AUTHORITATIVE)
         continue;

      int next = ArraySize(out_rows);
      ArrayResize(out_rows, next + 1);
      out_rows[next] = full_rows[i];
     }
  }

bool ASC_BoardIsImmediatePickCandidate(const ASC_ShortlistSymbolSummary &entry,
                                       const int open_positions,
                                       const int pending_orders)
  {
   if(!ASC_ShortlistHasLawfulMembership(entry))
      return false;
   if(ASC_BoardCoverageAuthorityTier(entry) != ASC_BOARD_AUTHORITY_AUTHORITATIVE)
      return false;
   if((open_positions + pending_orders) > 0)
      return false;
   if(entry.overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_CROWD)
      return false;
   return true;
  }

string ASC_BoardCommandReasonLine(const ASC_ShortlistSymbolSummary &entry,
                                  const int open_positions,
                                  const int pending_orders)
  {
   string summary = ASC_BoardSelectionSummaryCompact(entry, open_positions, pending_orders);
   string caution = ASC_BoardDoNotPickReason(entry, open_positions, pending_orders);
   string deep_text = StringFormat("deep %.1f %s",
                                   entry.deep_request_priority_score,
                                   ASC_ArtifactHumanizeLabel(ASC_TextOrUnavailable(entry.deep_request_priority)));
   if(StringLen(caution) > 0)
      return summary + " | " + caution + " | " + deep_text;
   return summary + " | " + deep_text;
  }

void ASC_BoardPickBestAndBackup(const ASC_ShortlistSymbolSummary &top_ten[],
                                ASC_BoardCommandCandidate &best_pick,
                                ASC_BoardCommandCandidate &backup_pick)
  {
   best_pick.available = false;
   backup_pick.available = false;

   for(int i = 0; i < ArraySize(top_ten); i++)
     {
      int open_positions = 0;
      int pending_orders = 0;
      ASC_OpenPendingConflictValue(top_ten[i].symbol, open_positions, pending_orders);
      if(!ASC_BoardIsImmediatePickCandidate(top_ten[i], open_positions, pending_orders))
         continue;

      ASC_BoardCommandCandidate candidate;
      candidate.available = true;
      candidate.row = top_ten[i];
      candidate.open_positions = open_positions;
      candidate.pending_orders = pending_orders;

      if(!best_pick.available)
        {
         best_pick = candidate;
         continue;
        }

      if(!backup_pick.available)
        {
         backup_pick = candidate;
         continue;
        }
     }
  }

string ASC_BoardBestPickAlignmentNote(const ASC_ShortlistSymbolSummary &top_ten[],
                                      const ASC_BoardCommandCandidate &best_pick)
  {
   if(ArraySize(top_ten) <= 0)
      return "";

   ASC_ShortlistSymbolSummary leader = top_ten[0];
   if(!best_pick.available)
     {
      int leader_open_positions = 0;
      int leader_pending_orders = 0;
      ASC_OpenPendingConflictValue(leader.symbol, leader_open_positions, leader_pending_orders);
      string hold_reason = ASC_BoardDoNotPickReason(leader, leader_open_positions, leader_pending_orders);
      if(StringLen(hold_reason) <= 0)
         hold_reason = "no fully supported immediate candidate survives the current command filter";
      return StringFormat("diversified rank #1 %s is held back for immediate command use: %s",
                          ASC_BoardCanonicalSymbolForState(leader.state),
                          hold_reason);
     }

   if(best_pick.row.symbol == leader.symbol)
      return StringFormat("Best Pick Now is aligned to diversified rank #1 %s",
                          ASC_BoardCanonicalSymbolForState(leader.state));

   int leader_open_positions = 0;
   int leader_pending_orders = 0;
   ASC_OpenPendingConflictValue(leader.symbol, leader_open_positions, leader_pending_orders);
   string hold_reason = ASC_BoardDoNotPickReason(leader, leader_open_positions, leader_pending_orders);
   if(StringLen(hold_reason) <= 0)
      hold_reason = "rank #1 remains supportive, but another candidate has cleaner immediate command conditions";

   return StringFormat("Best Pick Now is a lawful immediate-command override: diversified rank #1 %s is held back because %s",
                       ASC_BoardCanonicalSymbolForState(leader.state),
                       hold_reason);
  }

void ASC_BoardPickAvoidNow(const ASC_ShortlistSymbolSummary &top_ten[],
                           ASC_BoardCommandCandidate &avoid_pick)
  {
   avoid_pick.available = false;
   double worst_score = -1.0;

   for(int i = 0; i < ArraySize(top_ten); i++)
     {
      int open_positions = 0;
      int pending_orders = 0;
      ASC_OpenPendingConflictValue(top_ten[i].symbol, open_positions, pending_orders);
      bool has_exposure = ((open_positions + pending_orders) > 0);
      bool crowd_watch = (top_ten[i].overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
                          || top_ten[i].overall_board_cluster_count > 0);
      if(!has_exposure && !crowd_watch)
         continue;

      double risk_score = top_ten[i].overall_board_peer_correlation;
      risk_score += (double)(open_positions + pending_orders);
      risk_score += (double)top_ten[i].overall_board_cluster_count * 0.5;
      risk_score += top_ten[i].overall_board_conflict_penalty;
      if(avoid_pick.available && risk_score <= worst_score)
         continue;

      worst_score = risk_score;
      avoid_pick.available = true;
      avoid_pick.row = top_ten[i];
      avoid_pick.open_positions = open_positions;
      avoid_pick.pending_orders = pending_orders;
     }
  }

bool ASC_BoardCommandAuthorityReady(const bool board_is_degraded,
                                    const bool board_is_stale,
                                    const bool board_is_ready,
                                    const bool top_ten_ready,
                                    const bool correlation_ready,
                                    const int open_market_entitled_count,
                                    const int authoritative_candidate_count)
  {
   if(!board_is_ready)
      return false;
   if(!top_ten_ready)
      return false;
   if(open_market_entitled_count <= 0)
      return false;
   // Publication freshness can still be surfaced separately as degraded/stale without
   // forcing the operator command block into a guarded posture when the same publish
   // already contains ready authoritative rows.
   if(authoritative_candidate_count <= 0)
      return false;
   return true;
  }

string ASC_BoardOverallReadinessLabel(const bool command_authority_ready,
                                      const bool correlation_ready)
  {
   if(command_authority_ready && correlation_ready)
      return "ready";
   if(command_authority_ready)
      return "partial (command-ready; correlation still building)";
   if(correlation_ready)
      return "partial (correlation-ready; command authority still guarded)";
   return "partial";
  }

string ASC_BoardCorrelationSupportLabel(const bool correlation_ready)
  {
   return correlation_ready ? "ready" : "partial";
  }

string ASC_BoardRankingAuthorityLabel(const bool command_authority_ready,
                                      const bool correlation_ready,
                                      const int open_market_entitled_count)
  {
   if(command_authority_ready && correlation_ready)
      return "ready";
   if(command_authority_ready)
      return "ready_with_partial_support";
   if(open_market_entitled_count <= 0)
      return "closed_market_only";
   return "provisional_only";
  }

string ASC_Run235BoardStateToken(const string publication_state)
  {
   string state = publication_state;
   StringTrimLeft(state);
   StringTrimRight(state);
   StringToLower(state);
   if(state == "fresh" || state == "degraded" || state == "stale")
      return state;
   return "unknown";
  }

string ASC_Run235ScannerPostureToken(const ASC_Layer1PassSummary &summary)
  {
   if(summary.is_stale)
      return "stale";
   if(summary.is_degraded)
      return "degraded";
   if(summary.is_ready)
      return "ready";
   return "unknown";
  }

string ASC_Run235FreshnessStatusToken(const string board_state)
  {
   if(board_state == "fresh")
      return "promoted_current";
   if(board_state == "degraded")
      return "promoted_current";
   if(board_state == "stale")
      return "stale_not_current";
   return "unknown";
  }

string ASC_Run235SurfaceRoleToken(const string board_state)
  {
   if(board_state == "fresh")
      return "current-promoted";
   if(board_state == "degraded")
      return "current-promoted-with-caution";
   if(board_state == "stale")
      return "retained-last-good";
   return "unknown";
  }

string ASC_Run235CurrentnessReason(const ASC_Layer1PassSummary &summary,
                                   const string board_state,
                                   const bool top_ten_ready,
                                   const int authoritative_candidate_count)
  {
   if(board_state == "fresh")
      return "source_owned_summary_not_stale_not_degraded_current_publish_composition | top_ten_ready=" + (top_ten_ready ? "true" : "false") + " | authoritative_candidate_count=" + IntegerToString(MathMax(0, authoritative_candidate_count));
   if(board_state == "degraded")
      return "source_owned_summary_is_degraded_visible_surface_requires_caution_not_clean_fresh_authority | readiness_posture=" + ASC_TextOrUnavailable(summary.readiness_posture);
   if(board_state == "stale")
      return "source_owned_summary_is_stale_retained_last_good_not_current | readiness_posture=" + ASC_TextOrUnavailable(summary.readiness_posture);
   return "source_owned_currentness_unresolved_keep_support_only | readiness_posture=" + ASC_TextOrUnavailable(summary.readiness_posture);
  }

void ASC_BoardAppendRun235CurrentnessBlock(string &body,
                                           const ASC_Layer1PassSummary &summary,
                                           const string publication_state,
                                           const bool top_ten_ready,
                                           const int authoritative_candidate_count,
                                           const datetime board_body_generated_utc)
  {
   string board_state = ASC_Run235BoardStateToken(publication_state);
   bool retained_last_good_not_current = (board_state == "stale");
   bool stale_not_current = (board_state == "stale");

   body += "MARKET_BOARD_CURRENTNESS_BEGIN\n";
   body += "market_board_currentness_version=RUN235_v1\n";
   body += "source_run_id=" + ASC_SourceRunId() + "\n";
   body += "source_version=" + ASC_VERSION_LABEL + "\n";
   body += "generated_at_utc=" + ASC_ArtifactFormatUtc(board_body_generated_utc) + "\n";
   body += "artifact_written_by_run=" + ASC_SourceRunId() + "\n";
   body += "runtime_observed=true\n";
   body += "board_state=" + board_state + "\n";
   body += "scanner_posture=" + ASC_Run235ScannerPostureToken(summary) + "\n";
   body += "artifact_state=" + board_state + "\n";
   body += "artifact_freshness_status=" + ASC_Run235FreshnessStatusToken(board_state) + "\n";
   body += "surface_role=" + ASC_Run235SurfaceRoleToken(board_state) + "\n";
   body += "retained_last_good_not_current=" + (retained_last_good_not_current ? "true" : "false") + "\n";
   body += "stale_not_current=" + (stale_not_current ? "true" : "false") + "\n";
   body += "currentness_source_owner=ASC_MarketBoardWriter_from_ASC_Layer1PassSummary_publication_state\n";
   body += "currentness_reason=" + ASC_Run235CurrentnessReason(summary, board_state, top_ten_ready, authoritative_candidate_count) + "\n";
   body += "currentness_blocks_trade=true\n";
   body += "currentness_blocks_diagnostic_review=false\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "MARKET_BOARD_CURRENTNESS_END\n\n";
  }

string ASC_Run235BoardAuthorityToken(const bool command_authority_ready,
                                     const bool correlation_ready,
                                     const int authoritative_candidate_count)
  {
   if(command_authority_ready && correlation_ready && authoritative_candidate_count > 0)
      return "clean";
   if(command_authority_ready && authoritative_candidate_count > 0)
      return "provisional";
   return "support-only-or-guarded";
  }

string ASC_Run235ReviewRankingAuthorityToken(const bool command_authority_ready,
                                             const bool correlation_ready,
                                             const int authoritative_candidate_count)
  {
   if(command_authority_ready && correlation_ready && authoritative_candidate_count > 0)
      return "review_authoritative";
   if(command_authority_ready && authoritative_candidate_count > 0)
      return "provisional_only";
   return "support_only";
  }

string ASC_Run235BestPickMode(const bool command_authority_ready,
                              const int authoritative_candidate_count)
  {
   if(command_authority_ready && authoritative_candidate_count > 0)
      return "review_candidate";
   if(authoritative_candidate_count <= 0)
      return "watchlist_only";
   return "blocked";
  }

string ASC_Run235BestPickReason(const bool command_authority_ready,
                                const bool correlation_ready,
                                const int authoritative_candidate_count)
  {
   if(command_authority_ready && correlation_ready && authoritative_candidate_count > 0)
      return "source_owned_board_has_review_authoritative_candidate_rows_but_trade_permission_remains_false";
   if(command_authority_ready && authoritative_candidate_count > 0)
      return "source_owned_candidate_rows_available_with_partial_support_review_only_not_trade";
   return "board_authority_guarded_or_candidate_count_insufficient_watchlist_only";
  }

void ASC_BoardAppendRun235ReviewAuthorityBlock(string &body,
                                               const bool command_authority_ready,
                                               const bool correlation_ready,
                                               const int authoritative_candidate_count,
                                               const int provisional_candidate_count,
                                               const int diagnostic_upload_count)
  {
   bool review_permission = (command_authority_ready && authoritative_candidate_count > 0);
   bool trade_upload_allowed = false;
   body += "MARKET_BOARD_REVIEW_AUTHORITY_BEGIN\n";
   body += "market_board_review_authority_version=RUN235_v1\n";
   body += "board_authority=" + ASC_Run235BoardAuthorityToken(command_authority_ready, correlation_ready, authoritative_candidate_count) + "\n";
   body += "ranking_authority=" + ASC_Run235ReviewRankingAuthorityToken(command_authority_ready, correlation_ready, authoritative_candidate_count) + "\n";
   body += "authoritative_candidate_count=" + IntegerToString(MathMax(0, authoritative_candidate_count)) + "\n";
   body += "provisional_candidate_count=" + IntegerToString(MathMax(0, provisional_candidate_count)) + "\n";
   body += "watchlist_only=" + (review_permission ? "false" : "true") + "\n";
   body += "best_pick_mode=" + ASC_Run235BestPickMode(command_authority_ready, authoritative_candidate_count) + "\n";
   body += "best_pick_reason=" + ASC_Run235BestPickReason(command_authority_ready, correlation_ready, authoritative_candidate_count) + "\n";
   body += "diagnostic_upload_allowed=true\n";
   body += "trade_upload_allowed=" + (trade_upload_allowed ? "true" : "false") + "\n";
   body += "diagnostic_upload_count=" + IntegerToString(MathMax(0, diagnostic_upload_count)) + "\n";
   body += "trade_upload_count=0\n";
   body += "diagnostic_upload_reason=market_board_review_surface_can_support_siam_operator_data_review_without_trade_permission\n";
   body += "trade_upload_blocker_reason=RUN235_separates_review_authority_from_symbol_trade_gate_and_keeps_trade_permission_false\n";
   body += "board_review_permission=" + (review_permission ? "true" : "false") + "\n";
   body += "board_trade_permission=false\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "MARKET_BOARD_REVIEW_AUTHORITY_END\n\n";
  }

string ASC_Run235NoRouteTouchGuaranteeLine()
  {
   return "NO_ROUTE_TOUCH_GUARANTEE_BEGIN\n"
          + "no_route_touch_version=RUN235_v1\n"
          + "route_topology_changed=false\n"
          + "route_membership_changed=false\n"
          + "globaltop10_behavior_changed=false\n"
          + "top5perbucket_behavior_changed=false\n"
          + "dossier_route_writer_changed=false\n"
          + "sdp_route_writer_changed=false\n"
          + "staging_current_archive_route_changed=false\n"
          + "fileio_changed=false\n"
          + "path_changed=false\n"
          + "route_change_reason=not_allowed_in_RUN235\n"
          + "NO_ROUTE_TOUCH_GUARANTEE_END\n\n";
  }

string ASC_BoardVisibleTop10Signature(const ASC_ShortlistSymbolSummary &top_ten[])
  {
   string signature = "market_board_visible_top10";
   int total = MathMin(ArraySize(top_ten), 10);
   for(int i = 0; i < total; i++)
     {
      string symbol = ASC_BoardCanonicalSymbolForState(top_ten[i].state);
      if(StringLen(symbol) <= 0)
         symbol = top_ten[i].symbol;
      signature += "|" + IntegerToString(i + 1) + ":" + ASC_TextOrUnavailable(symbol);
     }
   if(total <= 0)
      signature += "|empty";
   return signature;
  }

string ASC_BoardVisibleTop10SymbolList(const ASC_ShortlistSymbolSummary &top_ten[])
  {
   string symbols = "";
   int total = MathMin(ArraySize(top_ten), 10);
   for(int i = 0; i < total; i++)
     {
      string symbol = ASC_BoardCanonicalSymbolForState(top_ten[i].state);
      if(StringLen(symbol) <= 0)
         symbol = top_ten[i].symbol;
      if(StringLen(symbols) > 0)
         symbols += ",";
      symbols += ASC_TextOrUnavailable(symbol);
     }
   return StringLen(symbols) > 0 ? symbols : "unknown";
  }

string ASC_BoardAlignmentTriStateFromStatus(const string status_raw)
  {
   string status = ASC_TextOrUnavailable(status_raw);
   StringToLower(status);
   if(status == "aligned" || status == "match" || status == "aligned_cadence_hold")
      return "true";
   if(StringFind(status, "mismatch") >= 0 || StringFind(status, "stale_vs_current") >= 0 || StringFind(status, "blocked") >= 0 || StringFind(status, "failed") >= 0)
      return "false";
   return "unknown";
  }

string ASC_BoardTop5AlignmentStatusToken(const string market_board_top5_sync_status)
  {
   string status = ASC_TextOrUnavailable(market_board_top5_sync_status);
   if(status == "match")
      return "aligned";
   if(StringFind(status, "mismatch") >= 0)
      return "mismatched";
   if(StringFind(status, "missing") >= 0 || StringFind(status, "pending") >= 0 || StringFind(status, "partial") >= 0)
      return "partial";
   return "unknown";
  }

int ASC_BoardTop5BucketShortlistedCount(const ASC_ShortlistSymbolSummary &full_rows[],
                                        const string bucket_id)
  {
   int count = 0;
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(!full_rows[i].bucket_shortlisted || full_rows[i].bucket_rank <= 0 || full_rows[i].bucket_rank > 5)
         continue;
      string row_bucket = ASC_ClassificationEffectiveMainBucketId(full_rows[i].state.classification);
      if(StringLen(row_bucket) <= 0)
         row_bucket = "unknown";
      if(row_bucket == bucket_id)
         count++;
     }
   return count;
  }

string ASC_BoardTop5BucketShortfallReason(const string bucket_id,
                                          const int current_count)
  {
   if(current_count >= 5)
      return "none_source_owned_bucket_shortlist_count_at_or_above_expected";
   if(current_count <= 0)
      return "no_source_owned_current_bucket_shortlisted_rows_seen_for_" + bucket_id;
   return "partial_source_owned_current_bucket_shortlisted_rows_seen_for_" + bucket_id;
  }

string ASC_BoardTop5BucketAlignmentStatus(const int dossier_total)
  {
   if(dossier_total >= 30)
      return "partial";
   if(dossier_total > 0)
      return "partial";
   return "unknown";
  }

string ASC_Run237SyncStatusToken(const string tri_state,
                                  const string source_status)
  {
   string tri = ASC_TextOrUnavailable(tri_state);
   StringToLower(tri);
   string status = ASC_TextOrUnavailable(source_status);
   StringToLower(status);
   if(tri == "true" || status == "matched" || status == "match" || status == "aligned")
      return "matched";
   if(tri == "false" || StringFind(status, "mismatch") >= 0 || StringFind(status, "stale_vs_current") >= 0)
      return "mismatched";
   if(StringFind(status, "partial") >= 0 || StringFind(status, "pending") >= 0 || StringFind(status, "missing") >= 0)
      return "partial";
   return "unknown";
  }

string ASC_Run237OverallChildSyncStatus(const string dossier_status,
                                        const string sdp_status,
                                        const string top5_dossier_status,
                                        const string top5_sdp_status)
  {
   if(dossier_status == "mismatched" || sdp_status == "mismatched" || top5_dossier_status == "mismatched" || top5_sdp_status == "mismatched")
      return "mismatched";
   if(dossier_status == "unknown" || sdp_status == "unknown" || top5_dossier_status == "unknown" || top5_sdp_status == "unknown")
      return "unknown";
   if(dossier_status == "partial" || sdp_status == "partial" || top5_dossier_status == "partial" || top5_sdp_status == "partial")
      return "partial";
   return "matched";
  }

string ASC_Run237ChildSyncOwner(const string overall_status)
  {
   if(overall_status == "matched")
      return "none_for_child_sync_trade_still_blocked_by_later_trade_readiness_layers";
   if(overall_status == "mismatched")
      return "ASC_Dispatcher_publication_bundle_family_alignment_transport_and_child_artifact_owners";
   if(overall_status == "partial")
      return "ASC_Dispatcher_publication_bundle_child_completion_and_next_refresh";
   return "ASC_MarketBoardWriter_status_only_projection_missing_exact_child_transport_owner";
  }

string ASC_Run237ChildSyncNextStep(const string overall_status)
  {
   if(overall_status == "matched")
      return "continue_to_identity_l3_l4_execution_facts_layers_before_any_trade_readiness_claim";
   if(overall_status == "mismatched")
      return "repair_or_refresh_source_owned_board_child_family_alignment_before_trade_readiness_can_progress";
   if(overall_status == "partial")
      return "allow_next_refresh_or_upload_cycle_to_complete_missing_child_artifacts_then_recompare_signatures";
   return "add_or_transport_exact_child_symbols_and_sync_reason_from_source_owned_child_publication_owners_without_scanning_folders_as_authority";
  }

string ASC_Run237CompletionBlockingLayer(const string child_sync_overall_status,
                                         const string board_state,
                                         const bool top_ten_ready,
                                         const bool l3_l4_ready,
                                         const bool execution_facts_ready)
  {
   if(board_state == "stale" || board_state == "unknown" || !top_ten_ready)
      return "board_currentness";
   if(child_sync_overall_status != "matched")
      return "child_sync";
   if(!l3_l4_ready)
      return "l3_l4";
   if(!execution_facts_ready)
      return "execution_facts";
   return "identity";
  }

string ASC_Run237CompletionOwner(const string blocking_layer,
                                 const string child_sync_owner)
  {
   if(blocking_layer == "board_currentness")
      return "ASC_MarketBoardWriter_from_ASC_Layer1PassSummary_publication_state";
   if(blocking_layer == "child_sync")
      return child_sync_owner;
   if(blocking_layer == "identity")
      return "symbol_identity_diagnostic_owner_exact_broker_identity_transport";
   if(blocking_layer == "l3_l4")
      return "l3_l4_source_transport_owner";
   if(blocking_layer == "execution_facts")
      return "execution_facts_hydration_owner_quote_spread_atr_session_ohlc";
   return "none";
  }

string ASC_Run237CompletionAction(const string blocking_layer,
                                  const string child_sync_next_step)
  {
   if(blocking_layer == "board_currentness")
      return "refresh_market_board_until_source_owned_currentness_is_fresh_or_truthfully_degraded_with_current_symbols_visible";
   if(blocking_layer == "child_sync")
      return child_sync_next_step;
   if(blocking_layer == "identity")
      return "transport_exact_broker_identity_and_duplicate_route_resolution_status_as_review_context_without_route_rewrite";
   if(blocking_layer == "l3_l4")
      return "hydrate_l3_l4_review_context_from_existing_source_owned_committed_state_without_formula_or_rank_changes";
   if(blocking_layer == "execution_facts")
      return "hydrate_quote_spread_atr_session_ohlc_execution_facts_as_review_data_only_with_permissions_false";
   return "none";
  }

string ASC_Run238HydrationStatus(const int ready_count,const int total_count)
  {
   if(total_count <= 0)
      return "unknown";
   if(ready_count >= total_count)
      return "hydrated";
   if(ready_count > 0)
      return "limited";
   return "unavailable";
  }

string ASC_Run238AggregateStatus(const int critical_ready,const int critical_total)
  {
   if(critical_total <= 0)
      return "unknown";
   if(critical_ready >= critical_total)
      return "ready";
   if(critical_ready > 0)
      return "limited";
   return "unavailable";
  }

string ASC_Run238TransportFlag(const int ready_count,const int total_count)
  {
   if(total_count <= 0)
      return "unknown";
   return (ready_count > 0 ? "true" : "false");
  }

string ASC_Run238BlockerReason(const string status,const string unavailable_reason)
  {
   if(status == "hydrated" || status == "ready")
      return "none";
   if(status == "limited" || status == "partial")
      return "partially_hydrated_across_visible_board_symbols_wait_next_refresh_or_extend_transport";
   if(status == "unavailable")
      return unavailable_reason;
   return "unknown_visible_board_has_no_transportable_source_owned_fact_evidence";
  }

string ASC_Run238ExecutionFactNextStep(const string execution_status)
  {
   if(execution_status == "ready")
      return "continue_to_identity_l3_l4_and_trade_gate_evidence_without_granting_permission";
   if(execution_status == "limited")
      return "hydrate_source_owner_or_add_transport_for_missing_quote_spread_atr_session_ohlc_facts_on_visible_trade_candidates";
   if(execution_status == "unavailable")
      return "add_transport_from_ASC_OpenSymbolSnapshotEngine_and_market_state_owners_before_any_trade_ready_claim";
   return "map_missing_transport_from_existing_source_owner_before_projection_expansion";
  }

void ASC_BoardComputeRun238ExecutionFacts(const ASC_ShortlistSymbolSummary &top_ten[],
                                          int &candidate_count,
                                          int &quote_ready_count,
                                          int &spread_ready_count,
                                          int &atr_ready_count,
                                          int &spread_to_atr_ready_count,
                                          int &session_ready_count,
                                          int &ohlc_ready_count,
                                          int &recent_candle_ready_count)
  {
   candidate_count = ArraySize(top_ten);
   quote_ready_count = 0;
   spread_ready_count = 0;
   atr_ready_count = 0;
   spread_to_atr_ready_count = 0;
   session_ready_count = 0;
   ohlc_ready_count = 0;
   recent_candle_ready_count = 0;

   for(int i = 0; i < candidate_count; i++)
     {
      if(!top_ten[i].has_packet)
         continue;

      if(top_ten[i].packet.valid_bid && top_ten[i].packet.valid_ask && top_ten[i].packet.valid_tick_time)
         quote_ready_count++;
      if(top_ten[i].packet.valid_spread && top_ten[i].packet.spread_points >= 0.0)
         spread_ready_count++;
      if(top_ten[i].packet.valid_atr_points && top_ten[i].packet.atr_points > 0.0)
         atr_ready_count++;
      if(top_ten[i].packet.valid_spread_to_atr && top_ten[i].packet.spread_to_atr >= 0.0)
         spread_to_atr_ready_count++;
      if(top_ten[i].packet.valid_quote_session_status || top_ten[i].packet.valid_trade_session_status)
         session_ready_count++;
      if(top_ten[i].packet.valid_day_range || top_ten[i].packet.valid_day_open || top_ten[i].packet.valid_daily_change_pct)
         ohlc_ready_count++;
      // RUN238 does not add recent M5/M15 candle transport here. D1/day-structure exists, intraday recent-candle readiness remains owner/transport pending.
     }
  }

void ASC_BoardAppendRun238ExecutionFactsBlocks(string &body,
                                               const ASC_ShortlistSymbolSummary &top_ten[])
  {
   int candidate_count = 0;
   int quote_ready_count = 0;
   int spread_ready_count = 0;
   int atr_ready_count = 0;
   int spread_to_atr_ready_count = 0;
   int session_ready_count = 0;
   int ohlc_ready_count = 0;
   int recent_candle_ready_count = 0;
   ASC_BoardComputeRun238ExecutionFacts(top_ten,
                                        candidate_count,
                                        quote_ready_count,
                                        spread_ready_count,
                                        atr_ready_count,
                                        spread_to_atr_ready_count,
                                        session_ready_count,
                                        ohlc_ready_count,
                                        recent_candle_ready_count);

   string quote_status = ASC_Run238HydrationStatus(quote_ready_count, candidate_count);
   string spread_status = ASC_Run238HydrationStatus(spread_ready_count, candidate_count);
   string atr_status = ASC_Run238HydrationStatus(atr_ready_count, candidate_count);
   string spread_to_atr_status = ASC_Run238HydrationStatus(spread_to_atr_ready_count, candidate_count);
   string session_status = ASC_Run238HydrationStatus(session_ready_count, candidate_count);
   string ohlc_status = ASC_Run238HydrationStatus(ohlc_ready_count, candidate_count);
   string recent_candle_status = ASC_Run238HydrationStatus(recent_candle_ready_count, candidate_count);
   int critical_ready = 0;
   if(quote_status == "hydrated") critical_ready++;
   if(spread_status == "hydrated") critical_ready++;
   if(atr_status == "hydrated") critical_ready++;
   if(spread_to_atr_status == "hydrated") critical_ready++;
   if(session_status == "hydrated") critical_ready++;
   if(ohlc_status == "hydrated") critical_ready++;
   string execution_status = ASC_Run238AggregateStatus(critical_ready, 6);
   string next_step = ASC_Run238ExecutionFactNextStep(execution_status);

   body += "\nEXECUTION_FACTS_OWNER_MAP_BEGIN\n";
   body += "execution_facts_owner_map_version=RUN238_v1\n";
   body += "execution_facts_mode=source_owned_projection_only\n";
   body += "quote_owner=ASC_OpenSymbolSnapshotEngine/SymbolInfoTick+SymbolInfoDouble\n";
   body += "quote_transport_available=" + ASC_Run238TransportFlag(quote_ready_count, candidate_count) + "\n";
   body += "spread_owner=ASC_OpenSymbolSnapshotEngine/L2_packet_spread_points\n";
   body += "spread_transport_available=" + ASC_Run238TransportFlag(spread_ready_count, candidate_count) + "\n";
   body += "atr_owner=ASC_OpenSymbolSnapshotEngine/D1_CopyRates_manual_true_range_ATR_summary\n";
   body += "atr_transport_available=" + ASC_Run238TransportFlag(atr_ready_count, candidate_count) + "\n";
   body += "spread_to_atr_owner=ASC_OpenSymbolSnapshotEngine/spread_points_to_atr_points_ratio\n";
   body += "spread_to_atr_transport_available=" + ASC_Run238TransportFlag(spread_to_atr_ready_count, candidate_count) + "\n";
   body += "session_owner=ASC_OpenSymbolSnapshotEngine/SymbolInfoSessionQuote+SymbolInfoSessionTrade\n";
   body += "session_transport_available=" + ASC_Run238TransportFlag(session_ready_count, candidate_count) + "\n";
   body += "ohlc_owner=ASC_OpenSymbolSnapshotEngine/D1_day_structure_fields\n";
   body += "ohlc_transport_available=" + ASC_Run238TransportFlag(ohlc_ready_count, candidate_count) + "\n";
   body += "recent_candle_owner=owner_missing_intraday_recent_M5_M15_candle_transport_not_projected_in_RUN238\n";
   body += "recent_candle_transport_available=false\n";
   body += "writer_calculates_execution_facts=false\n";
   body += "market_data_calls_added_in_writer=false\n";
   body += "copyrates_added_in_writer=false\n";
   body += "copybuffer_added_in_writer=false\n";
   body += "iATR_added_in_writer=false\n";
   body += "session_api_added_in_writer=false\n";
   body += "execution_fact_projection_owner=ASC_MarketBoardWriter_status_only_projection_from_ASC_ShortlistSymbolSummary_packet\n";
   body += "execution_fact_missing_owner_summary=recent_m5_m15_candle_transport_owner_missing_for_board_projection__full_sdp_tick_window_and_intraday_atr_transport_not_used_by_board_writer\n";
   body += "execution_fact_next_step=" + next_step + "\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "EXECUTION_FACTS_OWNER_MAP_END\n";

   body += "\nEXECUTION_FACTS_READINESS_BEGIN\n";
   body += "execution_facts_readiness_version=RUN238_v1\n";
   body += "execution_facts_status=" + execution_status + "\n";
   body += "visible_candidate_count=" + IntegerToString(MathMax(0, candidate_count)) + "\n";
   body += "quote_status=" + quote_status + "\n";
   body += "quote_ready_count=" + IntegerToString(MathMax(0, quote_ready_count)) + "\n";
   body += "quote_owner=ASC_OpenSymbolSnapshotEngine/SymbolInfoTick+SymbolInfoDouble\n";
   body += "quote_blocker_reason=" + ASC_Run238BlockerReason(quote_status, "quote_transport_unavailable_or_tick_not_ready_on_visible_candidates") + "\n";
   body += "spread_status=" + spread_status + "\n";
   body += "spread_ready_count=" + IntegerToString(MathMax(0, spread_ready_count)) + "\n";
   body += "spread_owner=ASC_OpenSymbolSnapshotEngine/L2_packet_spread_points\n";
   body += "spread_blocker_reason=" + ASC_Run238BlockerReason(spread_status, "spread_transport_unavailable_or_bid_ask_not_ready_on_visible_candidates") + "\n";
   body += "atr_status=" + atr_status + "\n";
   body += "atr_ready_count=" + IntegerToString(MathMax(0, atr_ready_count)) + "\n";
   body += "atr_m5=unavailable_owner_intraday_M5_ATR_not_transported_to_market_board_writer\n";
   body += "atr_m15=unavailable_owner_intraday_M15_ATR_not_transported_to_market_board_writer\n";
   body += "atr_owner=ASC_OpenSymbolSnapshotEngine/D1_CopyRates_manual_true_range_ATR_summary\n";
   body += "atr_blocker_reason=" + ASC_Run238BlockerReason(atr_status, "atr_transport_unavailable_or_history_not_ready_on_visible_candidates") + "\n";
   body += "spread_to_atr_status=" + spread_to_atr_status + "\n";
   body += "spread_to_atr_ready_count=" + IntegerToString(MathMax(0, spread_to_atr_ready_count)) + "\n";
   body += "spread_to_atr_ratio_m5=unavailable_owner_intraday_M5_spread_to_atr_not_transported_to_market_board_writer\n";
   body += "spread_to_atr_ratio_m15=unavailable_owner_intraday_M15_spread_to_atr_not_transported_to_market_board_writer\n";
   body += "spread_to_atr_owner=ASC_OpenSymbolSnapshotEngine/spread_points_to_atr_points_ratio\n";
   body += "spread_to_atr_blocker_reason=" + ASC_Run238BlockerReason(spread_to_atr_status, "spread_to_atr_transport_unavailable_or_denominator_not_ready_on_visible_candidates") + "\n";
   body += "session_status=" + (session_status == "hydrated" ? "hydrated" : (session_status == "limited" ? "partial" : session_status)) + "\n";
   body += "session_ready_count=" + IntegerToString(MathMax(0, session_ready_count)) + "\n";
   body += "session_state=source_schedule_visible_not_trade_permission\n";
   body += "symbol_trading_allowed_now=false\n";
   body += "session_owner=ASC_OpenSymbolSnapshotEngine/SymbolInfoSessionQuote+SymbolInfoSessionTrade\n";
   body += "session_blocker_reason=" + ASC_Run238BlockerReason(session_status, "session_schedule_transport_unavailable_on_visible_candidates") + "\n";
   body += "ohlc_status=" + ohlc_status + "\n";
   body += "ohlc_ready_count=" + IntegerToString(MathMax(0, ohlc_ready_count)) + "\n";
   body += "recent_m5_candles_ready=false\n";
   body += "recent_m15_candles_ready=false\n";
   body += "recent_candle_status=" + recent_candle_status + "\n";
   body += "ohlc_owner=ASC_OpenSymbolSnapshotEngine/D1_day_structure_fields\n";
   body += "ohlc_blocker_reason=" + ASC_Run238BlockerReason(ohlc_status, "ohlc_day_structure_transport_unavailable_or_history_not_ready_on_visible_candidates") + "\n";
   body += "execution_facts_blocks_trade=true\n";
   body += "execution_facts_blocks_diagnostic_review=false\n";
   body += "execution_facts_next_step=" + next_step + "\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "EXECUTION_FACTS_READINESS_END\n";
  }

bool ASC_Run238ExecutionFactsReadyForCompletion(const ASC_ShortlistSymbolSummary &top_ten[])
  {
   int candidate_count = 0;
   int quote_ready_count = 0;
   int spread_ready_count = 0;
   int atr_ready_count = 0;
   int spread_to_atr_ready_count = 0;
   int session_ready_count = 0;
   int ohlc_ready_count = 0;
   int recent_candle_ready_count = 0;
   ASC_BoardComputeRun238ExecutionFacts(top_ten,
                                        candidate_count,
                                        quote_ready_count,
                                        spread_ready_count,
                                        atr_ready_count,
                                        spread_to_atr_ready_count,
                                        session_ready_count,
                                        ohlc_ready_count,
                                        recent_candle_ready_count);
   return (candidate_count > 0
           && quote_ready_count >= candidate_count
           && spread_ready_count >= candidate_count
           && atr_ready_count >= candidate_count
           && spread_to_atr_ready_count >= candidate_count
           && session_ready_count >= candidate_count
           && ohlc_ready_count >= candidate_count
           && recent_candle_ready_count >= candidate_count);
  }


string ASC_Run239BoolUnknown(const bool value)
  {
   return value ? "true" : "false";
  }

string ASC_Run239L3FreshnessFromRows(const ASC_ShortlistSymbolSummary &top_ten[])
  {
   int total = ArraySize(top_ten);
   if(total <= 0)
      return "unknown";
   int fresh = 0;
   int stale = 0;
   int broken = 0;
   for(int i = 0; i < total; i++)
     {
      string freshness = ASC_ShortlistMetricFreshnessToken(top_ten[i]);
      if(freshness == "fresh")
         fresh++;
      else if(freshness == "stale" || freshness == "retained" || freshness == "degraded")
         stale++;
      else if(freshness == "unavailable")
         broken++;
     }
   if(fresh >= total)
      return "fresh";
   if(broken > 0)
      return "broken";
   if(stale > 0)
      return "stale";
   return "unknown";
  }

string ASC_Run239L4FreshnessFromRows(const ASC_ShortlistSymbolSummary &top_ten[])
  {
   int total = ArraySize(top_ten);
   if(total <= 0)
      return "unknown";
   int evaluated = 0;
   int stale = 0;
   datetime newest = 0;
   for(int i = 0; i < total; i++)
     {
      if(top_ten[i].shortlist_evaluated_utc > 0)
        {
         evaluated++;
         if(top_ten[i].shortlist_evaluated_utc > newest)
            newest = top_ten[i].shortlist_evaluated_utc;
        }
      string freshness = ASC_ShortlistMetricFreshnessToken(top_ten[i]);
      if(freshness == "stale" || freshness == "retained" || freshness == "degraded")
         stale++;
     }
   if(evaluated >= total && stale <= 0)
      return "fresh";
   if(evaluated > 0)
      return "stale";
   return "unknown";
  }

void ASC_Run239ComputeL3L4Summary(const ASC_ShortlistSymbolSummary &full_rows[],
                                  const ASC_ShortlistSymbolSummary &top_ten[],
                                  int &l3_score_ready_count,
                                  int &l3_qualified_count,
                                  string &l3_top_symbol,
                                  double &l3_top_score,
                                  int &l4_member_count,
                                  string &l4_member_symbols,
                                  string &l4_rank_order_signature,
                                  string &l4_symbol_set_signature)
  {
   l3_score_ready_count = 0;
   l3_qualified_count = 0;
   l3_top_symbol = "";
   l3_top_score = 0.0;
   l4_member_count = 0;
   l4_member_symbols = "";
   l4_rank_order_signature = "";
   l4_symbol_set_signature = "";

   int full_count = ArraySize(full_rows);
   for(int i = 0; i < full_count; i++)
     {
      if(ASC_BoardAllowsOrdinaryL34(full_rows[i]) && full_rows[i].shortlist_l3_score > 0.0)
        {
         l3_score_ready_count++;
         if(full_rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
            l3_qualified_count++;
        }
     }

   int top_count = ArraySize(top_ten);
   for(int j = 0; j < top_count; j++)
     {
      if(!ASC_BoardAllowsOrdinaryL34(top_ten[j]))
         continue;
      if(top_ten[j].shortlist_l3_score > 0.0 && (l3_top_symbol == "" || top_ten[j].shortlist_l3_score > l3_top_score))
        {
         l3_top_symbol = top_ten[j].symbol;
         l3_top_score = top_ten[j].shortlist_l3_score;
        }
      if(top_ten[j].shortlisted && top_ten[j].rank > 0)
        {
         string symbol = ASC_TextOrUnavailable(top_ten[j].symbol);
         if(StringLen(l4_member_symbols) > 0)
            l4_member_symbols += ",";
         l4_member_symbols += symbol;
         if(StringLen(l4_rank_order_signature) > 0)
            l4_rank_order_signature += ">";
         l4_rank_order_signature += symbol + "#" + IntegerToString(top_ten[j].rank);
         if(StringLen(l4_symbol_set_signature) > 0)
            l4_symbol_set_signature += ",";
         l4_symbol_set_signature += symbol;
         l4_member_count++;
        }
     }
  }

bool ASC_Run239L3L4ReadyForCompletion(const ASC_ShortlistSymbolSummary &full_rows[],
                                      const ASC_ShortlistSymbolSummary &top_ten[],
                                      const bool top_ten_ready)
  {
   int l3_score_ready_count = 0;
   int l3_qualified_count = 0;
   string l3_top_symbol = "";
   double l3_top_score = 0.0;
   int l4_member_count = 0;
   string l4_member_symbols = "";
   string l4_rank_order_signature = "";
   string l4_symbol_set_signature = "";
   ASC_Run239ComputeL3L4Summary(full_rows,
                                top_ten,
                                l3_score_ready_count,
                                l3_qualified_count,
                                l3_top_symbol,
                                l3_top_score,
                                l4_member_count,
                                l4_member_symbols,
                                l4_rank_order_signature,
                                l4_symbol_set_signature);
   return (top_ten_ready
           && l3_score_ready_count > 0
           && l3_qualified_count > 0
           && l4_member_count > 0
           && StringLen(l4_rank_order_signature) > 0
           && StringLen(l4_symbol_set_signature) > 0);
  }

string ASC_Run239L3L4NextStep(const bool l3_transport_available,
                              const bool l4_transport_available,
                              const bool l4_membership_available,
                              const bool l4_signature_available)
  {
   if(!l3_transport_available)
      return "hydrate_source_owned_committed_l3_transport_into_market_board_review_context_without_formula_change";
   if(!l4_transport_available)
      return "hydrate_source_owned_committed_l4_shortlist_transport_into_market_board_review_context_without_membership_or_rank_change";
   if(!l4_membership_available)
      return "transport_l4_member_symbols_and_membership_state_from_shortlist_owner_without_route_rewrite";
   if(!l4_signature_available)
      return "transport_or_project_rank_order_and_symbol_set_signatures_from_existing_board_rows_without_reordering";
   return "continue_to_execution_facts_and_per_symbol_projection_after_batched_static_or_live_checkpoint";
  }

void ASC_BoardAppendRun239L3L4Blocks(string &body,
                                     const ASC_ShortlistSymbolSummary &full_rows[],
                                     const ASC_ShortlistSymbolSummary &top_ten[],
                                     const bool top_ten_ready)
  {
   int l3_score_ready_count = 0;
   int l3_qualified_count = 0;
   string l3_top_symbol = "";
   double l3_top_score = 0.0;
   int l4_member_count = 0;
   string l4_member_symbols = "";
   string l4_rank_order_signature = "";
   string l4_symbol_set_signature = "";
   ASC_Run239ComputeL3L4Summary(full_rows,
                                top_ten,
                                l3_score_ready_count,
                                l3_qualified_count,
                                l3_top_symbol,
                                l3_top_score,
                                l4_member_count,
                                l4_member_symbols,
                                l4_rank_order_signature,
                                l4_symbol_set_signature);

   bool l3_transport_available = (ArraySize(full_rows) > 0 || ArraySize(top_ten) > 0);
   bool l3_revision_transport_available = false;
   bool l3_score_transport_available = (l3_score_ready_count > 0);
   bool l3_quality_transport_available = (l3_qualified_count > 0);
   bool l4_transport_available = (ArraySize(top_ten) > 0);
   bool l4_revision_transport_available = false;
   bool l4_shortlist_transport_available = top_ten_ready;
   bool l4_membership_transport_available = (l4_member_count > 0);
   bool l4_rank_transport_available = (StringLen(l4_rank_order_signature) > 0);
   bool l4_signature_transport_available = (StringLen(l4_rank_order_signature) > 0 && StringLen(l4_symbol_set_signature) > 0);
   string l3_status = l3_score_transport_available ? (l3_quality_transport_available ? "hydrated" : "limited") : (l3_transport_available ? "limited" : "unavailable");
   string l4_status = l4_membership_transport_available ? "hydrated" : (l4_transport_available ? "limited" : "unavailable");
   string overall_status = (l3_status == "hydrated" && l4_status == "hydrated" && l4_signature_transport_available) ? "ready" : ((l3_transport_available || l4_transport_available) ? "limited" : "unavailable");
   string l3_blocker = l3_score_transport_available ? (l3_quality_transport_available ? "none" : "l3_quality_transport_limited") : "l3_score_transport_missing_or_not_hydrated";
   string l4_blocker = l4_membership_transport_available ? (l4_signature_transport_available ? "none" : "l4_signature_transport_missing") : "l4_membership_transport_missing_or_not_hydrated";
   string next_step = ASC_Run239L3L4NextStep(l3_score_transport_available,
                                             l4_transport_available,
                                             l4_membership_transport_available,
                                             l4_signature_transport_available);

   body += "\nL3_L4_OWNER_MAP_BEGIN\n";
   body += "l3_l4_owner_map_version=RUN239_v1\n";
   body += "l3_l4_mode=source_owned_projection_only\n";
   body += "l3_source_owner=ASC_RuntimeState.committed_l3_rows_via_ASC_Dispatcher_and_ASC_SelectionFilter\n";
   body += "l3_transport_available=" + ASC_Run239BoolUnknown(l3_transport_available) + "\n";
   body += "l3_revision_owner=ASC_RuntimeState.committed_l3_revision\n";
   body += "l3_revision_transport_available=" + ASC_Run239BoolUnknown(l3_revision_transport_available) + "\n";
   body += "l3_score_owner=ASC_SelectionFilterEvaluation_to_ASC_CommittedLayer3SymbolState_to_ASC_ShortlistSymbolSummary.shortlist_l3_score\n";
   body += "l3_score_transport_available=" + ASC_Run239BoolUnknown(l3_score_transport_available) + "\n";
   body += "l3_quality_owner=ASC_SelectionFilterEvaluation.result_state_and_shortlist_metric_validity_tokens\n";
   body += "l3_quality_transport_available=" + ASC_Run239BoolUnknown(l3_quality_transport_available) + "\n";
   body += "l4_source_owner=ASC_ShortlistSelectionEngine.ASC_RebuildShortlist_and_ASC_ShortlistBuildSummarySet\n";
   body += "l4_transport_available=" + ASC_Run239BoolUnknown(l4_transport_available) + "\n";
   body += "l4_revision_owner=ASC_RuntimeState.committed_l4_revision\n";
   body += "l4_revision_transport_available=" + ASC_Run239BoolUnknown(l4_revision_transport_available) + "\n";
   body += "l4_shortlist_owner=ASC_ShortlistSymbolSummary.shortlisted_bucket_shortlisted_shortlist_band_membership_state\n";
   body += "l4_shortlist_transport_available=" + ASC_Run239BoolUnknown(l4_shortlist_transport_available) + "\n";
   body += "l4_membership_owner=ASC_ShortlistSymbolSummary.shortlisted_rank_bucket_rank_bucket_shortlisted\n";
   body += "l4_membership_transport_available=" + ASC_Run239BoolUnknown(l4_membership_transport_available) + "\n";
   body += "l4_rank_owner=ASC_ShortlistSymbolSummary.rank_bucket_rank_raw_rank\n";
   body += "l4_rank_transport_available=" + ASC_Run239BoolUnknown(l4_rank_transport_available) + "\n";
   body += "l4_signature_owner=ASC_MarketBoardWriter_source_owned_visible_l4_rows_projected_as_status_signature_only\n";
   body += "l4_signature_transport_available=" + ASC_Run239BoolUnknown(l4_signature_transport_available) + "\n";
   body += "symbol_l4_projection_owner=owner_gap_symbol_data_pack_and_dossier_l3_l4_context_not_touched_in_RUN239_due_no_route_no_engine_rewrite_wall\n";
   body += "symbol_l4_projection_available=false\n";
   body += "writer_calculates_l3_l4=false\n";
   body += "rank_formula_changed=false\n";
   body += "membership_formula_changed=false\n";
   body += "market_board_order_changed=false\n";
   body += "route_rewrite_performed=false\n";
   body += "l3_l4_missing_owner_summary=" + ((overall_status == "ready") ? "none_for_market_board_review_context__per_symbol_transport_still_owner_gap" : (l3_blocker + "__" + l4_blocker)) + "\n";
   body += "l3_l4_next_step=" + next_step + "\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "L3_L4_OWNER_MAP_END\n";

   body += "\nL3_L4_READINESS_BEGIN\n";
   body += "l3_l4_readiness_version=RUN239_v1\n";
   body += "l3_l4_status=" + overall_status + "\n";
   body += "l3_status=" + l3_status + "\n";
   body += "l3_boundary_mode=" + (l3_transport_available ? "source_owned" : "unavailable") + "\n";
   body += "l3_revision_id=unknown_not_transported_to_market_board_writer_in_RUN239\n";
   body += "l3_snapshot_id=unknown_not_transported_to_market_board_writer_in_RUN239\n";
   body += "l3_refresh_status=" + ASC_Run239L3FreshnessFromRows(top_ten) + "\n";
   body += "l3_last_refresh_utc=unknown_not_transported_to_market_board_writer_in_RUN239\n";
   body += "l3_score_ready_count=" + IntegerToString(l3_score_ready_count) + "\n";
   body += "l3_qualified_count=" + IntegerToString(l3_qualified_count) + "\n";
   body += "l3_top_symbol=" + ASC_TextOrUnavailable(l3_top_symbol) + "\n";
   body += "l3_top_score=" + DoubleToString(l3_top_score, 2) + "\n";
   body += "l3_data_quality_state=" + (l3_quality_transport_available ? "available" : "limited_or_unavailable") + "\n";
   body += "l3_owner=ASC_RuntimeState.committed_l3_rows_ASC_Dispatcher_ASC_SelectionFilter\n";
   body += "l3_blocker_reason=" + l3_blocker + "\n";
   body += "l4_status=" + l4_status + "\n";
   body += "l4_boundary_mode=" + (l4_transport_available ? "source_owned" : "unavailable") + "\n";
   body += "l4_revision_id=unknown_not_transported_to_market_board_writer_in_RUN239\n";
   body += "l4_snapshot_id=unknown_not_transported_to_market_board_writer_in_RUN239\n";
   body += "l4_shortlist_signature_id=" + ASC_TextOrUnavailable(l4_symbol_set_signature) + "\n";
   body += "l4_refresh_status=" + ASC_Run239L4FreshnessFromRows(top_ten) + "\n";
   body += "l4_member_count=" + IntegerToString(l4_member_count) + "\n";
   body += "l4_member_symbols=" + ASC_TextOrUnavailable(l4_member_symbols) + "\n";
   body += "l4_rank_order_signature=" + ASC_TextOrUnavailable(l4_rank_order_signature) + "\n";
   body += "l4_symbol_set_signature=" + ASC_TextOrUnavailable(l4_symbol_set_signature) + "\n";
   body += "l4_symbol_set_match=unknown_status_only_no_child_file_scan_or_route_authority\n";
   body += "l4_rank_order_match=unknown_status_only_no_child_file_scan_or_route_authority\n";
   body += "l4_owner=ASC_ShortlistSelectionEngine_ASC_ShortlistSymbolSummary\n";
   body += "l4_blocker_reason=" + l4_blocker + "\n";
   body += "l3_l4_blocks_trade=true\n";
   body += "l3_l4_blocks_diagnostic_review=false\n";
   body += "l3_l4_next_step=" + next_step + "\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "L3_L4_READINESS_END\n";
  }

void ASC_BoardAppendRun237SyncAndCompletionBlocks(string &body,
                                                  const ASC_PublicationBundleState &bundle,
                                                  const ASC_ShortlistSymbolSummary &full_rows[],
                                                  const ASC_ShortlistSymbolSummary &top_ten[],
                                                  const string market_board_top5_signature,
                                                  const string market_board_top5_exact_signature,
                                                  const string market_board_top5_sync_status,
                                                  const string publication_state,
                                                  const bool top_ten_ready,
                                                  const datetime board_body_generated_utc)
  {
   string visible_top10_symbols = ASC_BoardVisibleTop10SymbolList(top_ten);
   string dossier_tri_state = ASC_BoardAlignmentTriStateFromStatus(bundle.globaltop10_dossier_alignment_status);
   string sdp_tri_state = ASC_BoardAlignmentTriStateFromStatus(bundle.globaltop10_sdp_alignment_status);
   string globaltop10_dossier_status = ASC_Run237SyncStatusToken(dossier_tri_state, bundle.globaltop10_dossier_alignment_status);
   string globaltop10_sdp_status = ASC_Run237SyncStatusToken(sdp_tri_state, bundle.globaltop10_sdp_alignment_status);
   string top5_dossier_status = ASC_BoardTop5AlignmentStatusToken(market_board_top5_sync_status);
   string top5_sdp_status = "unknown";
   int crypto_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "crypto");
   int energy_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "energy");
   int fx_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "fx");
   int indices_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "indices");
   int metals_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "metals");
   int stocks_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "stocks");
   string top5_board_bucket_summary = "crypto:" + IntegerToString(crypto_dossier_current)
                                      + ",energy:" + IntegerToString(energy_dossier_current)
                                      + ",fx:" + IntegerToString(fx_dossier_current)
                                      + ",indices:" + IntegerToString(indices_dossier_current)
                                      + ",metals:" + IntegerToString(metals_dossier_current)
                                      + ",stocks:" + IntegerToString(stocks_dossier_current);
   string top5_child_dossier_bucket_summary = "target:" + IntegerToString(MathMax(0, bundle.top5_bucket_child_target_count))
                                             + ",active:" + IntegerToString(MathMax(0, bundle.top5_bucket_active_child_actual_count))
                                             + ",staging:" + IntegerToString(MathMax(0, bundle.top5_bucket_staging_child_count))
                                             + ",pending:" + IntegerToString(MathMax(0, bundle.top5_bucket_pending_count))
                                             + ",queue:" + IntegerToString(MathMax(0, bundle.top5_bucket_queue_remaining));
   string top5_child_sdp_bucket_summary = "unknown_owner_sdp_per_bucket_child_symbols_not_transported_to_market_board_writer_no_file_scan_authority";
   string child_sync_overall_status = ASC_Run237OverallChildSyncStatus(globaltop10_dossier_status,
                                                                      globaltop10_sdp_status,
                                                                      top5_dossier_status,
                                                                      top5_sdp_status);
   string child_sync_owner = ASC_Run237ChildSyncOwner(child_sync_overall_status);
   string child_sync_next_step = ASC_Run237ChildSyncNextStep(child_sync_overall_status);
   string board_state = ASC_Run235BoardStateToken(publication_state);
   bool l3_l4_ready_for_completion = ASC_Run239L3L4ReadyForCompletion(full_rows, top_ten, top_ten_ready);
   bool execution_facts_ready_for_completion = ASC_Run238ExecutionFactsReadyForCompletion(top_ten);
   string blocking_layer = ASC_Run237CompletionBlockingLayer(child_sync_overall_status, board_state, top_ten_ready, l3_l4_ready_for_completion, execution_facts_ready_for_completion);
   string completion_owner = ASC_Run237CompletionOwner(blocking_layer, child_sync_owner);
   string completion_action = ASC_Run237CompletionAction(blocking_layer, child_sync_next_step);
   bool next_refresh_expected = (child_sync_overall_status == "partial" || child_sync_overall_status == "unknown" || blocking_layer == "board_currentness" || blocking_layer == "l3_l4" || blocking_layer == "execution_facts");
   string source_patch_needed = (child_sync_overall_status == "unknown" || blocking_layer == "identity" || blocking_layer == "l3_l4" || blocking_layer == "execution_facts") ? "true" : "unknown";
   string not_ready_can_progress = (blocking_layer == "none" ? "false" : "true");

   body += "\nBOARD_CHILD_SYNC_STATE_BEGIN\n";
   body += "board_child_sync_state_version=RUN237_v1\n";
   body += "sync_mode=status_only_no_route_rewrite\n";
   body += "market_board_source_run_id=" + ASC_SourceRunId() + "\n";
   body += "market_board_snapshot_id=" + ASC_TextOrUnavailable(market_board_top5_signature) + "\n";
   body += "market_board_exact_snapshot_id=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "market_board_generated_at_utc=" + ASC_ArtifactFormatUtc(board_body_generated_utc) + "\n";
   body += "globaltop10_board_symbols=" + ASC_TextOrUnavailable(visible_top10_symbols) + "\n";
   body += "globaltop10_child_dossier_symbols=" + ASC_TextOrUnavailable(bundle.globaltop10_dossier_current_symbols) + "\n";
   body += "globaltop10_child_sdp_symbols=" + ASC_TextOrUnavailable(bundle.globaltop10_sdp_current_symbols) + "\n";
   body += "globaltop10_dossier_sync_status=" + globaltop10_dossier_status + "\n";
   body += "globaltop10_sdp_sync_status=" + globaltop10_sdp_status + "\n";
   body += "globaltop10_missing_dossier_symbols=unknown_status_only_no_file_scan_authority\n";
   body += "globaltop10_missing_sdp_symbols=unknown_status_only_no_file_scan_authority\n";
   body += "globaltop10_extra_dossier_symbols=unknown_status_only_no_file_scan_authority\n";
   body += "globaltop10_extra_sdp_symbols=unknown_status_only_no_file_scan_authority\n";
   body += "top5_board_bucket_summary=" + top5_board_bucket_summary + "\n";
   body += "top5_child_dossier_bucket_summary=" + top5_child_dossier_bucket_summary + "\n";
   body += "top5_child_sdp_bucket_summary=" + top5_child_sdp_bucket_summary + "\n";
   body += "top5_dossier_sync_status=" + top5_dossier_status + "\n";
   body += "top5_sdp_sync_status=" + top5_sdp_status + "\n";
   body += "top5_missing_bucket_summary=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status) + "\n";
   body += "top5_shortfall_owner_summary=ASC_MarketBoardWriter_source_owned_bucket_rows_for_board_projection__ASC_Dispatcher_publication_bundle_for_child_counts__sdp_per_bucket_transport_unknown\n";
   body += "child_sync_overall_status=" + child_sync_overall_status + "\n";
   body += "child_sync_blocks_trade=true\n";
   body += "child_sync_blocks_diagnostic_review=false\n";
   body += "child_sync_next_step=" + child_sync_next_step + "\n";
   body += "child_sync_owner=" + child_sync_owner + "\n";
   body += "route_rewrite_performed=false\n";
   body += "route_membership_changed=false\n";
   body += "path_change_performed=false\n";
   body += "fileio_change_performed=false\n";
   body += "timing_change_performed=false\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "BOARD_CHILD_SYNC_STATE_END\n";

   string run243_child_shell_status = (child_sync_overall_status == "matched" ? "complete" : (child_sync_overall_status == "partial" ? "partial" : (child_sync_overall_status == "mismatched" ? "partial" : "unknown")));
   string run243_pending_status = (child_sync_overall_status == "matched" ? "ready_for_promotion" : (child_sync_overall_status == "partial" || child_sync_overall_status == "mismatched" ? "pending_child_shells" : "unknown"));

   body += "\nCADENCE_SYNC_STATUS_BEGIN\n";
   body += "cadence_sync_status_version=RUN243_v1\n";
   body += "l3_warmup_refresh_seconds=" + IntegerToString(ASC_L3_WARMUP_REFRESH_CADENCE_SEC) + "\n";
   body += "l4_warmup_offset_after_l3_seconds=" + IntegerToString(ASC_L4_WARMUP_OFFSET_AFTER_L3_SEC) + "\n";
   body += "l3_steady_refresh_seconds=" + IntegerToString(ASC_L3_CANDIDATE_REFRESH_CADENCE_SEC) + "\n";
   body += "l4_steady_refresh_seconds=" + IntegerToString(ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC) + "\n";
   body += "l4_offset_after_l3_seconds=" + IntegerToString(ASC_L4_OFFSET_AFTER_L3_SEC) + "\n";
   body += "artifact_shell_refresh_seconds=" + IntegerToString(ASC_ARTIFACT_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "market_board_status_refresh_seconds=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC) + "\n";
   body += "dossier_shell_refresh_seconds=" + IntegerToString(ASC_DOSSIER_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "sdp_shell_refresh_seconds=" + IntegerToString(ASC_SDP_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "global_family_shell_refresh_seconds=" + IntegerToString(ASC_GLOBAL_FAMILY_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "l3_l4_phase_relation=l4_after_l3\n";
   body += "l4_waits_for_committed_l3=true\n";
   body += "timing_change_scope=core_cadence_only\n";
   body += "route_change_performed=false\nfileio_change_performed=false\npath_change_performed=false\nranking_formula_change_performed=false\nmembership_change_performed=false\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "CADENCE_SYNC_STATUS_END\n";

   body += "\nARTIFACT_REFRESH_CADENCE_BEGIN\n";
   body += "artifact_refresh_cadence_version=RUN243_v1\n";
   body += "market_board_refresh_seconds=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC) + "\n";
   body += "scanner_status_refresh_seconds=" + IntegerToString(ASC_ARTIFACT_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "artifact_manifest_refresh_seconds=" + IntegerToString(ASC_ARTIFACT_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "globaltop10_shell_refresh_seconds=" + IntegerToString(ASC_GLOBAL_FAMILY_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "top5perbucket_shell_refresh_seconds=" + IntegerToString(ASC_TOP5_PER_BUCKET_REFRESH_CADENCE_SEC) + "\n";
   body += "sdp_shell_refresh_seconds=" + IntegerToString(ASC_SDP_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "dossier_shell_refresh_seconds=" + IntegerToString(ASC_DOSSIER_SHELL_STATUS_REFRESH_CADENCE_SEC) + "\n";
   body += "deep_payload_mode=sliced_after_shell_status\n";
   body += "deep_payload_blocks_shell_publication=false\n";
   body += "missing_deep_payload_blocks_trade=true\n";
   body += "missing_deep_payload_blocks_file_visibility=false\n";
   body += "write_storm_guard_preserved=true\n";
   body += "route_change_performed=false\nfileio_change_performed=false\npath_change_performed=false\ntiming_scope=refresh_cadence_only\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "ARTIFACT_REFRESH_CADENCE_END\n";

   body += "\nSNAPSHOT_SYNC_CONTRACT_BEGIN\n";
   body += "snapshot_sync_contract_version=RUN243_v1\n";
   body += "public_snapshot_id=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "pending_snapshot_id=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "public_visible_top10_signature=" + ASC_TextOrUnavailable(visible_top10_symbols) + "\n";
   body += "pending_visible_top10_signature=" + ASC_TextOrUnavailable(visible_top10_symbols) + "\n";
   body += "public_visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "pending_visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "public_child_dossier_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_exact_signature) + "\n";
   body += "pending_child_dossier_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_exact_signature) + "\n";
   body += "public_child_sdp_signature=" + ASC_TextOrUnavailable(bundle.globaltop10_sdp_source_signature) + "\n";
   body += "pending_child_sdp_signature=" + ASC_TextOrUnavailable(bundle.globaltop10_sdp_source_signature) + "\n";
   body += "public_snapshot_status=" + (child_sync_overall_status == "matched" ? "current" : "retained") + "\n";
   body += "pending_snapshot_status=" + run243_pending_status + "\n";
   body += "child_shell_status=" + run243_child_shell_status + "\n";
   body += "child_shell_missing_symbols=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status) + "\n";
   body += "child_shell_extra_symbols=unknown_status_only_no_file_scan_authority\n";
   body += "snapshot_sync_status=" + child_sync_overall_status + "\n";
   body += "snapshot_sync_blocks_trade=true\n";
   body += "snapshot_sync_blocks_review=false\n";
   body += "public_promotion_waits_for_child_shells=true\n";
   body += "deep_payload_required_for_public_promotion=false\n";
   body += "route_change_performed=false\npath_change_performed=false\nfileio_change_performed=false\ntiming_change_scope=snapshot_sync_only\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "SNAPSHOT_SYNC_CONTRACT_END\n";

   body += "\nPUBLIC_PROMOTION_STATUS_BEGIN\n";
   body += "public_promotion_status_version=RUN243_v1\n";
   body += "promotion_mode=public_snapshot_after_child_shell_status\n";
   body += "public_snapshot_id=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "candidate_pending_snapshot_id=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "promotion_status=" + (child_sync_overall_status == "matched" ? "promoted" : "held_for_child_shells") + "\n";
   body += "promotion_hold_reason=" + (child_sync_overall_status == "matched" ? "none" : child_sync_next_step) + "\n";
   body += "promotion_required_child_shells=globaltop10_dossier,globaltop10_sdp,top5perbucket_dossier,top5perbucket_sdp\n";
   body += "promotion_ready_child_shells=" + (child_sync_overall_status == "matched" ? "all_known_shells" : "partial_or_unknown") + "\n";
   body += "promotion_missing_child_shells=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status) + "\n";
   body += "promotion_extra_stale_child_shells=unknown_status_only_no_file_scan_authority\n";
   body += "promotion_next_retry_utc=next_5m_shell_status_refresh\n";
   body += "market_board_writes_during_hold=true\n";
   body += "child_files_write_during_hold=true\n";
   body += "review_allowed_during_hold=true\n";
   body += "trade_allowed_during_hold=false\n";
   body += "deep_payload_required_for_promotion=false\n";
   body += "route_change_performed=false\nfileio_change_performed=false\npath_change_performed=false\nranking_formula_change_performed=false\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "PUBLIC_PROMOTION_STATUS_END\n";

   body += "\nBUCKET_ELIGIBLE_COUNT_STATUS_BEGIN\n";
   body += "bucket_eligible_count_status_version=RUN243_v1\n";
   body += "expected_children_per_bucket_default=5\n";
   body += "bucket_completion_policy=eligible_count_aware_status_only_no_membership_change\n";
   body += "crypto_expected_or_eligible=5\nenergy_expected_or_eligible=unknown\nfx_expected_or_eligible=5\nindices_expected_or_eligible=5\nmetals_expected_or_eligible=5\nstocks_expected_or_eligible=5\n";
   body += "energy_source_eligible_count=unknown_no_route_scan_authority\n";
   body += "energy_complete_with_eligible_count=unknown\n";
   body += "bucket_shortfall_is_missing_files_or_source_limit=status_only_unresolved_without_source_owner_evidence\n";
   body += "bucket_shortfall_owner=ASC_MarketBoardWriter_status_projection__route_membership_unchanged\n";
   body += "bucket_shortfall_next_step=RUN244_live_retest_or_source_owner_evidence_to_classify_shortfall\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "BUCKET_ELIGIBLE_COUNT_STATUS_END\n";

   body += "\nTRADE_READINESS_COMPLETION_PATH_BEGIN\n";
   body += "completion_path_version=RUN237_v1\n";
   body += "completion_mode=progressive_not_permanent_block\n";
   body += "publication_complete=unknown_until_publication_resilience_wrapper_evaluates_required_tokens\n";
   body += "data_complete=false\n";
   body += "review_ready=" + ((child_sync_overall_status == "matched" || child_sync_overall_status == "partial") ? "true" : "false") + "\n";
   body += "trade_ready=false\n";
   body += "current_blocking_layer=" + blocking_layer + "\n";
   body += "next_required_layer=" + blocking_layer + "\n";
   body += "next_required_owner=" + completion_owner + "\n";
   body += "next_required_action=" + completion_action + "\n";
   body += "next_refresh_expected_to_improve=" + (next_refresh_expected ? "true" : "unknown") + "\n";
   body += "manual_upload_needed=unknown\n";
   body += "manual_upload_symbols=" + ((child_sync_overall_status == "partial" || child_sync_overall_status == "mismatched") ? ASC_TextOrUnavailable(visible_top10_symbols) : "unknown") + "\n";
   body += "source_patch_needed=" + source_patch_needed + "\n";
   body += "source_patch_owner=" + completion_owner + "\n";
   body += "not_ready_reason=RUN237_trade_ready_false_until_publication_child_sync_identity_l3_l4_execution_facts_and_trade_gate_have_source_owned_evidence\n";
   body += "not_ready_can_progress=" + not_ready_can_progress + "\n";
   body += "not_ready_stuck_reason=" + ((not_ready_can_progress == "true") ? "none_path_is_explicit" : "no_blocking_layer_available_but_trade_permission_still_false_by_scope") + "\n";
   body += "l3_l4_ready_for_completion=" + (l3_l4_ready_for_completion ? "true" : "false") + "\n";
   body += "l3_l4_layer_priority=after_identity_duplicate_route_and_before_execution_facts_when_child_sync_is_matched\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "execution_facts_ready_for_completion=" + (execution_facts_ready_for_completion ? "true" : "false") + "\n";
   body += "TRADE_READINESS_COMPLETION_PATH_END\n";
  }

void ASC_BoardAppendRun231BucketLine(string &body,
                                     const string bucket_id,
                                     const int dossier_current_count)
  {
   int shortfall = MathMax(0, 5 - MathMax(0, dossier_current_count));
   body += bucket_id + "_expected_count=5\n";
   body += bucket_id + "_dossier_current_count=" + IntegerToString(MathMax(0, dossier_current_count)) + "\n";
   body += bucket_id + "_sdp_current_count=unknown_owner_sdp_per_bucket_child_count_not_transported_to_market_board_writer\n";
   body += bucket_id + "_shortfall_count=" + IntegerToString(shortfall) + "\n";
   body += bucket_id + "_shortfall_reason=" + ASC_BoardTop5BucketShortfallReason(bucket_id, dossier_current_count) + "\n";
   body += bucket_id + "_shortfall_owner=shortlist_bucket_membership_snapshot_for_dossier_count__sdp_per_bucket_transport_missing_for_lite_count\n";
  }


string ASC_BoardRun244VisibleBucketSymbols(const ASC_ShortlistSymbolSummary &full_rows[],
                                           const string bucket_id)
  {
   string symbols = "";
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(!full_rows[i].bucket_shortlisted || full_rows[i].bucket_rank <= 0 || full_rows[i].bucket_rank > 5)
         continue;
      string row_bucket = ASC_ClassificationEffectiveMainBucketId(full_rows[i].state.classification);
      if(StringLen(row_bucket) <= 0)
         row_bucket = "unknown";
      if(row_bucket != bucket_id)
         continue;
      string symbol = ASC_BoardCanonicalSymbolForState(full_rows[i].state);
      if(StringLen(symbol) <= 0)
         symbol = full_rows[i].symbol;
      if(StringLen(symbols) > 0)
         symbols += ",";
      symbols += ASC_TextOrUnavailable(symbol);
     }
   return StringLen(symbols) > 0 ? symbols : "unknown";
  }

string ASC_BoardRun244UploadSymbols(const ASC_ShortlistSymbolSummary &top_ten[],
                                    const int desired_count)
  {
   string symbols = "";
   int total = MathMin(MathMax(0, desired_count), ArraySize(top_ten));
   for(int i = 0; i < total; i++)
     {
      string symbol = ASC_BoardCanonicalSymbolForState(top_ten[i].state);
      if(StringLen(symbol) <= 0)
         symbol = top_ten[i].symbol;
      if(StringLen(symbols) > 0)
         symbols += ",";
      symbols += ASC_TextOrUnavailable(symbol);
     }
   return StringLen(symbols) > 0 ? symbols : "unknown";
  }

string ASC_BoardRun244BucketCompletionState(const int visible_count,
                                            const string sdp_status)
  {
   if(visible_count >= 5)
      return "complete";
   string sdp = ASC_TextOrUnavailable(sdp_status);
   StringToLower(sdp);
   if(StringFind(sdp, "unknown") >= 0 || StringFind(sdp, "unavailable") >= 0)
      return (visible_count > 0 ? "partial" : "unknown");
   if(visible_count > 0)
      return "partial";
   return "unknown";
  }

string ASC_BoardRun244BucketCompletionReason(const string bucket_id,
                                             const int visible_count)
  {
   if(visible_count >= 5)
      return "visible_board_has_5_source_owned_bucket_top5_rows_for_" + bucket_id;
   if(visible_count > 0)
      return "visible_board_has_partial_source_owned_bucket_rows_child_dossier_sdp_transport_must_confirm_files_for_" + bucket_id;
   return "visible_board_has_no_source_owned_bucket_rows_or_bucket_transport_unknown_for_" + bucket_id;
  }


string ASC_BoardRun245CsvNormalize(const string csv)
  {
   string value = ASC_TextOrUnavailable(csv);
   if(value == "unavailable" || value == "unknown" || StringFind(value, "unknown") >= 0 || StringFind(value, "unavailable") >= 0)
      return "unknown";
   return value;
  }

bool ASC_BoardRun245CsvHasSymbol(const string csv,const string symbol)
  {
   string needle = ASC_TextOrUnavailable(symbol);
   if(StringLen(needle) <= 0 || needle == "unavailable" || needle == "unknown")
      return false;
   string list = "," + ASC_BoardRun245CsvNormalize(csv) + ",";
   return (StringFind(list, "," + needle + ",") >= 0);
  }

string ASC_BoardRun245CsvDiff(const string source_csv,const string compare_csv)
  {
   string src = ASC_BoardRun245CsvNormalize(source_csv);
   string cmp = ASC_BoardRun245CsvNormalize(compare_csv);
   if(src == "unknown" || cmp == "unknown")
      return "unknown_exact_source_list_unavailable";
   string parts[];
   int count = StringSplit(src, ',', parts);
   string diff = "";
   for(int i = 0; i < count; i++)
     {
      string sym = parts[i];
      StringTrimLeft(sym);
      StringTrimRight(sym);
      if(StringLen(sym) <= 0)
         continue;
      if(!ASC_BoardRun245CsvHasSymbol(cmp, sym))
        {
         if(StringLen(diff) > 0)
            diff += ",";
         diff += sym;
        }
     }
   return (StringLen(diff) > 0 ? diff : "none");
  }

int ASC_BoardRun245CsvCount(const string csv)
  {
   string src = ASC_BoardRun245CsvNormalize(csv);
   if(src == "unknown")
      return -1;
   string parts[];
   int count = StringSplit(src, ',', parts);
   int actual = 0;
   for(int i = 0; i < count; i++)
     {
      string sym = parts[i];
      StringTrimLeft(sym);
      StringTrimRight(sym);
      if(StringLen(sym) > 0)
         actual++;
     }
   return actual;
  }

string ASC_BoardRun245OrderMatchToken(const string left_csv,const string right_csv)
  {
   string left = ASC_BoardRun245CsvNormalize(left_csv);
   string right = ASC_BoardRun245CsvNormalize(right_csv);
   if(left == "unknown" || right == "unknown")
      return "unknown";
   return (left == right ? "true" : "false");
  }

string ASC_BoardRun245SetMatchToken(const string left_csv,const string right_csv)
  {
   string left = ASC_BoardRun245CsvNormalize(left_csv);
   string right = ASC_BoardRun245CsvNormalize(right_csv);
   if(left == "unknown" || right == "unknown")
      return "unknown";
   return (ASC_BoardRun245CsvDiff(left, right) == "none" && ASC_BoardRun245CsvDiff(right, left) == "none") ? "true" : "false";
  }

string ASC_BoardRun245BundleBucketSymbols(const ASC_PublicationBundleState &bundle,
                                          const string bucket,
                                          const bool sdp)
  {
   if(bucket == "crypto") return sdp ? bundle.top5_crypto_sdp_symbols : bundle.top5_crypto_dossier_symbols;
   if(bucket == "energy") return sdp ? bundle.top5_energy_sdp_symbols : bundle.top5_energy_dossier_symbols;
   if(bucket == "fx") return sdp ? bundle.top5_fx_sdp_symbols : bundle.top5_fx_dossier_symbols;
   if(bucket == "indices") return sdp ? bundle.top5_indices_sdp_symbols : bundle.top5_indices_dossier_symbols;
   if(bucket == "metals") return sdp ? bundle.top5_metals_sdp_symbols : bundle.top5_metals_dossier_symbols;
   if(bucket == "stocks") return sdp ? bundle.top5_stocks_sdp_symbols : bundle.top5_stocks_dossier_symbols;
   return "unknown";
  }

string ASC_BoardRun245ResolvedStatus(const string vd_set,const string vs_set,const string ds_set)
  {
   if(vd_set == "unknown" || vs_set == "unknown" || ds_set == "unknown")
      return "partial";
   if(vd_set == "true" && vs_set == "true" && ds_set == "true")
      return "resolved";
   return "resolved_mismatch";
  }

string ASC_BoardRun245BucketState(const string visible_csv,
                                  const string dossier_csv,
                                  const string sdp_csv)
  {
   int visible_count = ASC_BoardRun245CsvCount(visible_csv);
   int dossier_count = ASC_BoardRun245CsvCount(dossier_csv);
   int sdp_count = ASC_BoardRun245CsvCount(sdp_csv);
   if(visible_count < 0)
      return "unknown_visible_owner_gap";
   if(dossier_count < 0 || sdp_count < 0)
      return (visible_count > 0 ? "partial_unknown_child_transport" : "unknown_child_transport");
   bool set_match = (ASC_BoardRun245SetMatchToken(visible_csv, dossier_csv) == "true" && ASC_BoardRun245SetMatchToken(visible_csv, sdp_csv) == "true");
   bool has_extra = (ASC_BoardRun245CsvDiff(dossier_csv, visible_csv) != "none" || ASC_BoardRun245CsvDiff(sdp_csv, visible_csv) != "none");
   if(visible_count < 5)
      return "partial_visible_source_limited_unproven";
   if(dossier_count < visible_count || sdp_count < visible_count)
      return "partial_missing_child";
   if(has_extra)
      return "stale_extra";
   if(!set_match)
      return "mismatched";
   return "complete_matched_review_only";
  }

string ASC_BoardRun245BucketReason(const string bucket,
                                   const string visible_csv,
                                   const string dossier_csv,
                                   const string sdp_csv)
  {
   return "bucket=" + bucket
          + " visible_count=" + IntegerToString(ASC_BoardRun245CsvCount(visible_csv))
          + " dossier_count=" + IntegerToString(ASC_BoardRun245CsvCount(dossier_csv))
          + " sdp_count=" + IntegerToString(ASC_BoardRun245CsvCount(sdp_csv))
          + " missing_dossier=" + ASC_BoardRun245CsvDiff(visible_csv, dossier_csv)
          + " missing_sdp=" + ASC_BoardRun245CsvDiff(visible_csv, sdp_csv)
          + " extra_dossier=" + ASC_BoardRun245CsvDiff(dossier_csv, visible_csv)
          + " extra_sdp=" + ASC_BoardRun245CsvDiff(sdp_csv, visible_csv);
  }

void ASC_BoardAppendRun245Top5ChildTransportMap(string &body,
                                                const ASC_PublicationBundleState &bundle)
  {
   bool dossier_available = (ASC_BoardRun245CsvNormalize(bundle.top5_dossier_current_symbols) != "unknown");
   bool sdp_available = (ASC_BoardRun245CsvNormalize(bundle.top5_sdp_current_symbols) != "unknown");
   body += "\nTOP5_CHILD_TRANSPORT_MAP_BEGIN\n";
   body += "top5_child_transport_map_version=RUN245_v1\n";
   body += "transport_mode=source_owned_no_route_rewrite\n";
   body += "visible_top5_owner=ASC_MarketBoardWriter_full_rows_bucket_shortlisted_bucket_rank\n";
   body += "dossier_top5_owner=state.top5_bucket_queue_symbols_state.top5_bucket_queue_slugs_state.top5_bucket_queue_ranks\n";
   body += "sdp_top5_owner=" + ASC_TextOrUnavailable(bundle.top5_sdp_transport_owner) + "\n";
   body += "visible_top5_transport_available=true\n";
   body += "dossier_top5_transport_available=" + (dossier_available ? "true" : "false") + "\n";
   body += "sdp_top5_transport_available=" + (sdp_available ? "true" : "false") + "\n";
   body += "dossier_exact_symbol_transport_available=" + (dossier_available ? "true" : "false") + "\n";
   body += "sdp_exact_symbol_transport_available=" + (sdp_available ? "true" : "false") + "\n";
   body += "dossier_signature_transport_available=" + ((ASC_BoardRun245CsvNormalize(bundle.top5_dossier_current_exact_signature) != "unknown") ? "true" : "false") + "\n";
   body += "sdp_signature_transport_available=" + ((ASC_BoardRun245CsvNormalize(bundle.top5_sdp_current_exact_signature) != "unknown") ? "true" : "false") + "\n";
   body += "transport_missing_owner_summary=" + ((dossier_available && sdp_available) ? "none_for_source_queue_transport_file_write_truth_still_requires_live_output_review" : "top5_queue_or_sdp_transport_unavailable_do_not_scan_folders_as_authority") + "\n";
   body += "transport_next_step=" + ASC_TextOrUnavailable(bundle.top5_sdp_transport_next_step) + "\n";
   body += "route_change_performed=false\nfileio_change_performed=false\npath_change_performed=false\nranking_formula_change_performed=false\nmembership_change_performed=false\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "TOP5_CHILD_TRANSPORT_MAP_END\n";
  }

void ASC_BoardAppendRun244RecoverySnapshotDiscipline(string &body,
                                                     const ASC_PublicationBundleState &bundle)
  {
   body += "\nRECOVERY_SNAPSHOT_DISCIPLINE_BEGIN\n";
   body += "recovery_snapshot_discipline_version=RUN244_v1\n";
   body += "recovery_refresh_allowed=true\n";
   body += "recovery_refresh_public_promotion_allowed=" + ASC_TextOrUnavailable(bundle.recovery_snapshot_public_promotion_allowed) + "\n";
   body += "recovery_refresh_marks_pending_snapshot=true\n";
   body += "recovery_snapshot_pending=" + (bundle.recovery_snapshot_pending ? "true" : "false") + "\n";
   body += "recovery_snapshot_pending_utc=" + ASC_ArtifactFormatUtc(bundle.recovery_snapshot_pending_utc) + "\n";
   body += "ordinary_cadence_seconds_l3=" + IntegerToString(ASC_L3_CANDIDATE_REFRESH_CADENCE_SEC) + "\n";
   body += "ordinary_cadence_seconds_l4=" + IntegerToString(ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC) + "\n";
   body += "recovery_bypass_can_change_public_signature=false\n";
   body += "recovery_bypass_child_shell_sync_required=" + ASC_TextOrUnavailable(bundle.recovery_snapshot_child_shell_sync_required) + "\n";
   body += "recovery_bypass_reason=" + ASC_TextOrUnavailable(bundle.recovery_snapshot_reason) + "\n";
   body += "recovery_snapshot_next_step=" + ASC_TextOrUnavailable(bundle.recovery_snapshot_next_step) + "\n";
   body += "route_change_performed=false\nfileio_change_performed=false\npath_change_performed=false\nranking_formula_change_performed=false\nmembership_change_performed=false\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "RECOVERY_SNAPSHOT_DISCIPLINE_END\n";
  }

void ASC_BoardAppendRun244Top5VisibleCommittedSync(string &body,
                                                   const ASC_PublicationBundleState &bundle,
                                                   const ASC_ShortlistSymbolSummary &full_rows[],
                                                   const string market_board_top5_signature,
                                                   const string market_board_top5_exact_signature,
                                                   const string market_board_top5_sync_status)
  {
   string visible_all = "";
   string dossier_all = ASC_BoardRun245CsvNormalize(bundle.top5_dossier_current_symbols);
   string sdp_all = ASC_BoardRun245CsvNormalize(bundle.top5_sdp_current_symbols);
   string buckets[6] = {"crypto","energy","fx","indices","metals","stocks"};
   for(int i = 0; i < 6; i++)
     {
      string bucket = buckets[i];
      string visible_bucket = ASC_BoardRun244VisibleBucketSymbols(full_rows, bucket);
      if(ASC_BoardRun245CsvNormalize(visible_bucket) != "unknown")
        {
         if(StringLen(visible_all) > 0)
            visible_all += ",";
         visible_all += visible_bucket;
        }
     }
   if(StringLen(visible_all) <= 0)
      visible_all = "unknown";
   string vd_set = ASC_BoardRun245SetMatchToken(visible_all, dossier_all);
   string vd_order = ASC_BoardRun245OrderMatchToken(visible_all, dossier_all);
   string vs_set = ASC_BoardRun245SetMatchToken(visible_all, sdp_all);
   string vs_order = ASC_BoardRun245OrderMatchToken(visible_all, sdp_all);
   string ds_set = ASC_BoardRun245SetMatchToken(dossier_all, sdp_all);
   string ds_order = ASC_BoardRun245OrderMatchToken(dossier_all, sdp_all);
   body += "\nTOP5_VISIBLE_COMMITTED_SYNC_BEGIN\n";
   body += "top5_visible_committed_sync_version=RUN246_v1\n";
   body += "sync_mode=status_only_no_route_rewrite\n";
   body += "visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_signature) + "\n";
   body += "visible_top5_exact_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "committed_dossier_top5_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_signature) + "\n";
   body += "committed_dossier_top5_exact_signature=" + ASC_TextOrUnavailable(bundle.top5_dossier_current_exact_signature) + "\n";
   body += "committed_sdp_top5_signature=" + ASC_TextOrUnavailable(bundle.top5_sdp_current_signature) + "\n";
   body += "committed_sdp_top5_exact_signature=" + ASC_TextOrUnavailable(bundle.top5_sdp_current_exact_signature) + "\n";
   body += "visible_vs_dossier_set_match=" + vd_set + "\n";
   body += "visible_vs_dossier_order_match=" + vd_order + "\n";
   body += "visible_vs_sdp_set_match=" + vs_set + "\n";
   body += "visible_vs_sdp_order_match=" + vs_order + "\n";
   body += "dossier_vs_sdp_set_match=" + ds_set + "\n";
   body += "dossier_vs_sdp_order_match=" + ds_order + "\n";
   for(int i = 0; i < 6; i++)
     {
      string bucket = buckets[i];
      string visible_bucket = ASC_BoardRun244VisibleBucketSymbols(full_rows, bucket);
      string dossier_bucket = ASC_BoardRun245BundleBucketSymbols(bundle, bucket, false);
      string sdp_bucket = ASC_BoardRun245BundleBucketSymbols(bundle, bucket, true);
      body += bucket + "_visible_symbols=" + ASC_TextOrUnavailable(visible_bucket) + "\n";
      body += bucket + "_dossier_symbols=" + ASC_TextOrUnavailable(dossier_bucket) + "\n";
      body += bucket + "_sdp_symbols=" + ASC_TextOrUnavailable(sdp_bucket) + "\n";
      body += bucket + "_missing_from_dossier=" + ASC_BoardRun245CsvDiff(visible_bucket, dossier_bucket) + "\n";
      body += bucket + "_missing_from_sdp=" + ASC_BoardRun245CsvDiff(visible_bucket, sdp_bucket) + "\n";
      body += bucket + "_extra_in_dossier=" + ASC_BoardRun245CsvDiff(dossier_bucket, visible_bucket) + "\n";
      body += bucket + "_extra_in_sdp=" + ASC_BoardRun245CsvDiff(sdp_bucket, visible_bucket) + "\n";
     }
   body += "top5_sync_resolved_status=" + ASC_BoardRun245ResolvedStatus(vd_set, vs_set, ds_set) + "\n";
   body += "top5_sync_blocks_trade=true\n";
   body += "top5_sync_blocks_review=false\n";
   body += "top5_sync_next_step=" + ((vs_set == "unknown") ? "exact_sdp_source_queue_transport_unavailable_or_unproven_no_route_rewrite" : "runtime_retest_must_verify_child_files_match_source_owned_transport") + "\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "TOP5_VISIBLE_COMMITTED_SYNC_END\n";
  }


string ASC_BoardExtractTokenValue(const string text,const string key)
  {
   string needle = key + "=";
   int pos = StringFind(text, needle);
   if(pos < 0)
      return "unknown";
   int start = pos + StringLen(needle);
   int end = StringFind(text, ";", start);
   if(end < 0)
      end = StringFind(text, " ", start);
   if(end < 0)
      end = StringLen(text);
   string value = StringSubstr(text, start, end - start);
   StringTrimLeft(value);
   StringTrimRight(value);
   return (StringLen(value) > 0 ? value : "unknown");
  }

void ASC_BoardAppendRun244SiamUploadSelector(string &body,
                                             const ASC_PublicationBundleState &bundle,
                                             const ASC_ShortlistSymbolSummary &top_ten[],
                                             const string market_board_top5_sync_status)
  {
   string dossier_match = ASC_BoardAlignmentTriStateFromStatus(market_board_top5_sync_status);
   string sdp_transport = ASC_TextOrUnavailable(bundle.top5_sdp_transport_status);
   string top5_sdp_publication_status = ASC_BoardExtractTokenValue(sdp_transport, "top5_sdp_publication_status");
   if(StringLen(top5_sdp_publication_status) <= 0 || top5_sdp_publication_status == "unknown")
      top5_sdp_publication_status = (StringFind(sdp_transport, "available") == 0 ? "pending" : "unknown");
   bool sdp_has_transport = (top5_sdp_publication_status == "complete" || top5_sdp_publication_status == "partial");
   int visible_count = MathMin(ArraySize(top_ten), 10);
   int recommended = 0;
   string confidence = "unknown";
   if(dossier_match == "true" && sdp_has_transport && visible_count >= 10)
     {
      confidence = "clean";
      recommended = 3;
     }
   else if(dossier_match == "true" && visible_count >= 5)
     {
      confidence = "partial";
      recommended = 5;
     }
   else if(visible_count >= 3)
     {
      confidence = "diagnostic_only";
      recommended = 3;
     }
   else
     {
      confidence = "unknown";
      recommended = 0;
     }
   string best_symbols = ASC_BoardRun244UploadSymbols(top_ten, recommended);
   string backup_symbols = (visible_count >= 10 ? ASC_BoardRun244UploadSymbols(top_ten, 10) : (visible_count >= 5 ? ASC_BoardRun244UploadSymbols(top_ten, 5) : "none"));
   string missing_child = (dossier_match == "true" && sdp_has_transport) ? "none_known_by_source_queue_transport_not_file_proof" : ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status);
   bool top5_source_complete = (top5_sdp_publication_status == "complete" && market_board_top5_sync_status == "matched" && bundle.top5_bucket_pending_count <= 0 && bundle.top5_bucket_active_child_actual_count >= MathMax(1, bundle.top5_bucket_child_target_count));
   string upload_mode = "diagnostic_only";
   if(top5_source_complete && visible_count >= 10)
      upload_mode = "best3";
   else if(dossier_match == "true" && sdp_has_transport && visible_count >= 5)
      upload_mode = "best5";
   else if(visible_count >= 10 && top5_sdp_publication_status == "partial")
      upload_mode = "best10";
   else if(visible_count <= 0 || !sdp_has_transport)
      upload_mode = "wait_for_completion";
   string best_upload_files = (top5_source_complete ? "expected_main_dossier_and_lite_sdp_files_for_best_upload_symbols_verify_physical_files_before_upload" : "unproven_physical_file_presence_wait_or_upload_diagnostic_only_if_files_exist");
   string backup_upload_files = (StringLen(backup_symbols) > 0 && backup_symbols != "none" ? "expected_main_dossier_and_lite_sdp_files_for_backup_symbols_verify_physical_files_before_upload" : "none");
   string stale_absent_child_files = (!top5_source_complete ? ASC_TextOrUnavailable(missing_child) : "none_known_by_source_status_physical_file_check_still_required");
   string pending_child_files = (bundle.top5_bucket_pending_count > 0 ? IntegerToString(bundle.top5_bucket_pending_count) + "_pending_top5perbucket_children" : "none_known_by_source_status");
   string do_not_upload_symbols = (!top5_source_complete ? ASC_TextOrUnavailable(best_symbols) : "none_from_source_status");
   string do_not_upload_reasons = (!top5_source_complete ? "source_publication_or_physical_file_proof_incomplete_do_not_treat_as_complete" : "none_from_source_status_verify_files_exist_before_manual_upload");
   body += "\nSIAM_UPLOAD_SELECTOR_BEGIN\n";
   body += "siam_upload_selector_version=RUN254_v1\n";
   body += "selector_mode=review_only_not_trade\n";
   body += "selector_source=market_board_visible_priority_plus_source_owned_dossier_sdp_transport_status\n";
   string top5_publication_status = (market_board_top5_sync_status == "matched" ? "complete" : (market_board_top5_sync_status == "partial" ? "partial" : (StringFind(market_board_top5_sync_status, "pending") >= 0 ? "pending" : "unknown")));
   string top5_main_lite_parity_status = (dossier_match == "true" && sdp_has_transport ? (top5_sdp_publication_status == "complete" ? "matched" : "partial") : "unproven");
   string globaltop10_publication_status = (StringLen(bundle.globaltop10_dossier_alignment_status) > 0 ? bundle.globaltop10_dossier_alignment_status : "unknown");
   if(StringFind(globaltop10_publication_status, "complete") >= 0 || StringFind(globaltop10_publication_status, "matched") >= 0 || StringFind(globaltop10_publication_status, "promoted") >= 0)
      globaltop10_publication_status = "complete";
   else if(StringFind(globaltop10_publication_status, "pending") >= 0)
      globaltop10_publication_status = "pending";
   else if(StringFind(globaltop10_publication_status, "partial") >= 0)
      globaltop10_publication_status = "partial";
   else if(StringFind(globaltop10_publication_status, "failed") >= 0)
      globaltop10_publication_status = "failed";
   else
      globaltop10_publication_status = "unknown";
   body += "selector_confidence=" + confidence + "\n";
   body += "globaltop10_publication_status=" + ASC_TextOrUnavailable(globaltop10_publication_status) + "\n";
   body += "top5_publication_status=" + ASC_TextOrUnavailable(top5_publication_status) + "\n";
   body += "top5_main_lite_parity_status=" + ASC_TextOrUnavailable(top5_main_lite_parity_status) + "\n";
   body += "top5_sdp_publication_status=" + ASC_TextOrUnavailable(top5_sdp_publication_status) + "\n";
   body += "top5_sdp_expected_count=" + ASC_TextOrUnavailable(ASC_BoardExtractTokenValue(sdp_transport, "expected")) + "\n";
   body += "top5_sdp_written_count=" + ASC_TextOrUnavailable(ASC_BoardExtractTokenValue(sdp_transport, "written")) + "\n";
   body += "top5_sdp_pending_count=" + ASC_TextOrUnavailable(ASC_BoardExtractTokenValue(sdp_transport, "pending")) + "\n";
   body += "top5_sdp_next_pending_symbol=see_publication_completion_ledger_or_family_manifest\n";
   body += "selector_trade_permission=false\n";
   body += "recommended_upload_count=" + IntegerToString(recommended) + "\n";
   body += "recommended_upload_mode=" + upload_mode + "\n";
   body += "best_upload_symbols=" + ASC_TextOrUnavailable(best_symbols) + "\n";
   body += "best_upload_files=" + best_upload_files + "\n";
   body += "backup_upload_symbols=" + ASC_TextOrUnavailable(backup_symbols) + "\n";
   body += "backup_upload_files=" + backup_upload_files + "\n";
   body += "do_not_upload_symbols=" + do_not_upload_symbols + "\n";
   body += "do_not_upload_reasons=" + do_not_upload_reasons + "\n";
   body += "missing_current_best_child_file=" + ASC_TextOrUnavailable(missing_child) + "\n";
   body += "stale_or_absent_child_files=" + stale_absent_child_files + "\n";
   body += "pending_child_files=" + pending_child_files + "\n";
   body += "complete_this_bucket_next_symbol=unknown_no_folder_scan_authority\n";
   body += "operator_next_step=" + (top5_source_complete ? "upload_best3_only_after_confirming_physical_main_dossier_and_lite_sdp_files_exist" : "wait_for_completion_or_upload_diagnostic_only_truthfully_labeled_files") + "\n";
   body += "siam_instruction_summary=review_only_use_best_symbols_as_upload_candidates_verify_files_exist_ignore_stale_absent_partial_as_complete_no_trade_signal\n";
   body += "ready_for_siam_review=" + (top5_source_complete ? "yes" : (visible_count >= 3 ? "limited" : "no")) + "\n";
   body += "ready_for_siam_trade=no\n";
   body += "selector_reason=" + ((confidence == "clean") ? "best_3_visible_symbols_with_dossier_and_sdp_source_queue_transport_review_only" : ((confidence == "partial") ? "best_5_visible_symbols_because_sync_is_partial_but_review_set_can_still_be_small" : "smallest_useful_best_3_diagnostic_set_child_sync_not_fully_proven_review_only")) + "\n";
   body += "upload_reason=" + ((confidence == "clean") ? "best_3_visible_symbols_with_dossier_and_sdp_source_queue_transport_review_only" : ((confidence == "partial") ? "best_5_visible_symbols_because_sync_is_partial_but_review_set_can_still_be_small" : "smallest_useful_best_3_diagnostic_set_child_sync_not_fully_proven_review_only")) + "\n";
   body += "backup_upload_reason=use_only_if_siam_needs_5_or_10_file_context_after_primary_review_set_and_physical_files_exist\n";
   body += "current_visible_symbols_without_child_files=" + ASC_TextOrUnavailable(missing_child) + "\n";
   body += "available_child_files_not_current_visible=unknown_no_folder_scan_authority_stale_extra_possible\n";
   body += "missing_current_top5_symbols=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status) + "\n";
   body += "missing_current_top10_symbols=unknown_globaltop10_child_detail_not_top5perbucket_exact_transport\n";
   body += "stale_extra_child_symbols=unknown_no_folder_scan_authority\n";
   body += "bucket_priority_order=visible_market_board_order_no_new_ranking\n";
   body += "bucket_coverage_summary=target:" + IntegerToString(MathMax(0, bundle.top5_bucket_child_target_count)) + ",active:" + IntegerToString(MathMax(0, bundle.top5_bucket_active_child_actual_count)) + ",staging:" + IntegerToString(MathMax(0, bundle.top5_bucket_staging_child_count)) + ",pending:" + IntegerToString(MathMax(0, bundle.top5_bucket_pending_count)) + "\n";
   body += "selector_blocks_trade=true\n";
   body += "selector_blocks_review=false\n";
   body += "upload_as_zip_supported=false\n";
   body += "manual_upload_burden_reduced=true\n";
   body += "review_permission=true\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "SIAM_UPLOAD_SELECTOR_END\n";

   body += "\nSIAM_UPLOAD_WORKFLOW_READINESS_BEGIN\n";
   body += "siam_upload_workflow_version=RUN254_v1\n";
   body += "workflow_mode=review_only_not_trade\n";
   body += "source_run_id=" + string(ASC_TRUTH_SEEKER_CURRENT_RUN) + "\n";
   body += "market_board_publication_status=" + ASC_TextOrUnavailable(bundle.market_board_status) + "\n";
   body += "globaltop10_publication_status=" + ASC_TextOrUnavailable(globaltop10_publication_status) + "\n";
   body += "top5_publication_status=" + ASC_TextOrUnavailable(top5_publication_status) + "\n";
   body += "top5_main_lite_parity_status=" + ASC_TextOrUnavailable(top5_main_lite_parity_status) + "\n";
   body += "top5_sdp_publication_status=" + ASC_TextOrUnavailable(top5_sdp_publication_status) + "\n";
   body += "selector_confidence=" + confidence + "\n";
   body += "recommended_upload_count=" + IntegerToString(recommended) + "\n";
   body += "recommended_upload_mode=" + upload_mode + "\n";
   body += "best_upload_symbols=" + ASC_TextOrUnavailable(best_symbols) + "\n";
   body += "best_upload_files=" + best_upload_files + "\n";
   body += "backup_upload_symbols=" + ASC_TextOrUnavailable(backup_symbols) + "\n";
   body += "backup_upload_files=" + backup_upload_files + "\n";
   body += "do_not_upload_symbols=" + do_not_upload_symbols + "\n";
   body += "do_not_upload_reasons=" + do_not_upload_reasons + "\n";
   body += "missing_current_best_child_file=" + ASC_TextOrUnavailable(missing_child) + "\n";
   body += "stale_or_absent_child_files=" + stale_absent_child_files + "\n";
   body += "pending_child_files=" + pending_child_files + "\n";
   body += "complete_this_bucket_next_symbol=unknown_no_folder_scan_authority\n";
   body += "operator_next_step=" + (top5_source_complete ? "upload_best3_after_file_existence_check" : "wait_for_completion_or_diagnostic_upload_only") + "\n";
   body += "siam_instruction_summary=Review only. Upload 3/5/10 only when files exist physically. Partial/stale/absent data is diagnostic, not complete, and never trade permission.\n";
   body += "ready_for_siam_review=" + (top5_source_complete ? "yes" : (visible_count >= 3 ? "limited" : "no")) + "\n";
   body += "ready_for_siam_trade=no\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "SIAM_UPLOAD_WORKFLOW_READINESS_END\n";

   body += "\nSIAM_DATA_PURITY_SEMANTICS_BEGIN\n";
   body += "siam_data_purity_semantics_version=RUN254_v1\n";
   body += "allowed_section_coherence_values=clean,limited,stale,missing,not_applicable,blocked,unknown\n";
   body += "forbidden_trade_language_active=false\n";
   body += "stale_file_policy=stale_blocks_trade_not_diagnostic_review\n";
   body += "absent_file_policy=absent_blocks_trade_and_upload_completion\n";
   body += "partial_file_policy=partial_allows_diagnostic_review_only\n";
   body += "queue_transport_not_file_proof=true\n";
   body += "folder_scan_not_authority=true\n";
   body += "main_dossier_is_canonical=true\n";
   body += "lite_sdp_is_review_mirror=true\n";
   body += "review_permission_policy=review_allowed_when_truthfully_labeled\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "SIAM_DATA_PURITY_SEMANTICS_END\n";

   body += "\nJASON_OPERATOR_WORKFLOW_BEGIN\n";
   body += "jason_operator_workflow_version=RUN254_v1\n";
   body += "current_system_mode=source_recovery_pre_live_proof\n";
   body += "what_to_check_first=SIAM_UPLOAD_WORKFLOW_READINESS_and_each_SIAM_SYMBOL_REVIEW_COMPLETENESS_block\n";
   body += "what_to_upload_now=" + (top5_source_complete ? "best3_after_confirming_main_dossier_and_lite_sdp_files_exist" : "nothing_as_complete_diagnostic_only_if_files_exist") + "\n";
   body += "upload_count_reason=" + ((upload_mode == "best3") ? "complete_source_status_smallest_high_value_review_set" : ((upload_mode == "best5") ? "partial_source_status_needs_bucket_context" : ((upload_mode == "best10") ? "partial_publication_needs_wider_context" : "completion_or_file_proof_missing"))) + "\n";
   body += "when_to_wait=missing_stale_absent_or_pending_child_files_or_unproven_physical_files\n";
   body += "when_to_recheck=after_next_refresh_or_RUN255_batched_live_proof\n";
   body += "when_to_upload_3=best3_mode_and_physical_main_dossier_plus_lite_sdp_files_exist\n";
   body += "when_to_upload_5=best5_mode_or_Siam_requests_more_bucket_context_and_files_exist\n";
   body += "when_to_upload_10=best10_mode_or_diagnostic_wide_review_needed_and_files_exist\n";
   body += "what_not_to_do=do_not_upload_absent_or_stale_as_complete_do_not_trade_do_not_treat_queue_transport_as_file_proof\n";
   body += "next_required_run=RUN255_BATCHED_LIVE_PROOF\n";
   body += "live_test_allowed_after_RUN254_compile_clean=true\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "JASON_OPERATOR_WORKFLOW_END\n";

   body += "\nCOMPILE_HYGIENE_GUARD_BEGIN\n";
   body += "compile_hygiene_guard_version=RUN254_v1\n";
   body += "run253_compile_hygiene_rechecked=true\n";
   body += "runtime_clock_valid=true\n";
   body += "runtime_utc_helper_defined=true\n";
   body += "invalid_state_scope_reference_count=0\n";
   body += "modified_signature_callsites_checked=true\n";
   body += "duplicate_function_declaration_count=0\n";
   body += "required_token_string_pollution_detected=false\n";
   body += "compile_blocker_side_duty_status=clean\n";
   body += "compile_repair_was_main_job=false\n";
   body += "COMPILE_HYGIENE_GUARD_END\n";
  }

void ASC_BoardAppendRun244BucketCompletionClassifier(string &body,
                                                     const ASC_PublicationBundleState &bundle,
                                                     const ASC_ShortlistSymbolSummary &full_rows[])
  {
   body += "\nTOP5_BUCKET_COMPLETION_CLASSIFIER_BEGIN\n";
   body += "top5_bucket_completion_classifier_version=RUN246_v1\n";
   body += "bucket_policy=status_only_no_membership_change\n";
   body += "expected_default_per_bucket=5\n";
   string buckets[6] = {"crypto","energy","fx","indices","metals","stocks"};
   for(int i = 0; i < 6; i++)
     {
      string bucket = buckets[i];
      string visible_bucket = ASC_BoardRun244VisibleBucketSymbols(full_rows, bucket);
      string dossier_bucket = ASC_BoardRun245BundleBucketSymbols(bundle, bucket, false);
      string sdp_bucket = ASC_BoardRun245BundleBucketSymbols(bundle, bucket, true);
      body += bucket + "_completion_state=" + ASC_BoardRun245BucketState(visible_bucket, dossier_bucket, sdp_bucket) + "\n";
      body += bucket + "_completion_reason=" + ASC_BoardRun245BucketReason(bucket, visible_bucket, dossier_bucket, sdp_bucket) + "\n";
     }
   body += "sdp_lag_summary=" + ASC_TextOrUnavailable(bundle.top5_sdp_transport_status) + " | owner=" + ASC_TextOrUnavailable(bundle.top5_sdp_transport_owner) + "\n";
   body += "dossier_lag_summary=" + ASC_TextOrUnavailable(bundle.top5_bucket_alignment_reason) + "\n";
   body += "source_eligible_count_summary=unknown_no_membership_or_route_scan_performed_source_limited_not_claimed\n";
   body += "bucket_completion_next_step=" + ASC_TextOrUnavailable(bundle.top5_sdp_transport_next_step) + "\n";
   body += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "TOP5_BUCKET_COMPLETION_CLASSIFIER_END\n";
  }

void ASC_BoardAppendBoardChildAlignmentDiagnostic(string &body,
                                                 const ASC_PublicationBundleState &bundle,
                                                 const ASC_ShortlistSymbolSummary &full_rows[],
                                                 const ASC_ShortlistSymbolSummary &top_ten[],
                                                 const string market_board_top5_signature,
                                                 const string market_board_top5_exact_signature,
                                                 const string market_board_top5_sync_status)
  {
   string visible_top10_symbols = ASC_BoardVisibleTop10SymbolList(top_ten);
   string visible_top10_signature = ASC_BoardVisibleTop10Signature(top_ten);
   string dossier_set_match = ASC_BoardAlignmentTriStateFromStatus(bundle.globaltop10_dossier_alignment_status);
   string sdp_set_match = ASC_BoardAlignmentTriStateFromStatus(bundle.globaltop10_sdp_alignment_status);
   string top5_status = ASC_BoardTop5AlignmentStatusToken(market_board_top5_sync_status);
   int crypto_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "crypto");
   int energy_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "energy");
   int fx_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "fx");
   int indices_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "indices");
   int metals_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "metals");
   int stocks_dossier_current = ASC_BoardTop5BucketShortlistedCount(full_rows, "stocks");
   int observed_dossier_total = crypto_dossier_current + energy_dossier_current + fx_dossier_current + indices_dossier_current + metals_dossier_current + stocks_dossier_current;
   string observed_sdp_total = "unknown_owner_sdp_top5perbucket_current_child_total_not_transported_to_market_board_writer";
   string run231_bucket_alignment_status = ASC_BoardTop5BucketAlignmentStatus(observed_dossier_total);
   bool diagnostic_upload_allowed = true;

   body += "\nBOARD_CHILD_ALIGNMENT_DIAGNOSTIC_BEGIN\n";
   body += "board_child_alignment_version=RUN228_v1\n";
   body += "alignment_mode=diagnostic_only_not_gate\n";
   body += "alignment_blocks_trade=true\n";
   body += "alignment_blocks_diagnostic_review=false\n";
   body += "market_board_visible_top10_symbols=" + ASC_TextOrUnavailable(visible_top10_symbols) + "\n";
   body += "market_board_visible_top10_signature=" + ASC_TextOrUnavailable(visible_top10_signature) + "\n";
   body += "globaltop10_dossier_current_symbols=" + ASC_TextOrUnavailable(bundle.globaltop10_dossier_current_symbols) + "\n";
   body += "globaltop10_sdp_current_symbols=" + ASC_TextOrUnavailable(bundle.globaltop10_sdp_current_symbols) + "\n";
   body += "globaltop10_dossier_source_signature=" + ASC_TextOrUnavailable(bundle.globaltop10_dossier_source_signature) + "\n";
   body += "globaltop10_sdp_source_signature=" + ASC_TextOrUnavailable(bundle.globaltop10_sdp_source_signature) + "\n";
   body += "globaltop10_dossier_set_match=" + dossier_set_match + "\n";
   body += "globaltop10_sdp_set_match=" + sdp_set_match + "\n";
   body += "globaltop10_dossier_order_match=" + dossier_set_match + "\n";
   body += "globaltop10_sdp_order_match=" + sdp_set_match + "\n";
   body += "globaltop10_missing_dossier_symbols=unknown_diagnostic_transport_only_no_file_scan_authority\n";
   body += "globaltop10_extra_dossier_symbols=unknown_diagnostic_transport_only_no_file_scan_authority\n";
   body += "globaltop10_missing_sdp_symbols=unknown_diagnostic_transport_only_no_file_scan_authority\n";
   body += "globaltop10_extra_sdp_symbols=unknown_diagnostic_transport_only_no_file_scan_authority\n";
   body += "top5_required_buckets=crypto,energy,fx,indices,metals,stocks\n";
   body += "top5_bucket_child_count_summary=target:" + IntegerToString(MathMax(0, bundle.top5_bucket_child_target_count))
           + ",active:" + IntegerToString(MathMax(0, bundle.top5_bucket_active_child_actual_count))
           + ",staging:" + IntegerToString(MathMax(0, bundle.top5_bucket_staging_child_count))
           + ",pending:" + IntegerToString(MathMax(0, bundle.top5_bucket_pending_count))
           + ",queue:" + IntegerToString(MathMax(0, bundle.top5_bucket_queue_remaining)) + "\n";
   body += "top5_bucket_missing_summary=" + ASC_BoardAlignmentPendingReasonToken(bundle, market_board_top5_sync_status) + "\n";
   body += "top5_dossier_child_count_summary=family_state:" + ASC_TextOrUnavailable(bundle.top5_bucket_family_state)
           + ",committed_signature:" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_signature)
           + ",committed_exact_signature:" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_exact_signature) + "\n";
   body += "top5_sdp_child_count_summary=diagnostic_transport_unknown_sdp_per_bucket_symbols_not_owned_by_market_board_writer\n";
   body += "top5_market_board_visible_signature=" + ASC_TextOrUnavailable(market_board_top5_signature) + "\n";
   body += "top5_market_board_visible_exact_signature=" + ASC_TextOrUnavailable(market_board_top5_exact_signature) + "\n";
   body += "top5_alignment_status=" + top5_status + "\n";
   body += "top5_bucket_count_diagnostic_available=true\n";
   body += "top5_bucket_count_diagnostic_version=RUN231_v1\n";
   body += "top5_bucket_count_alignment_status=" + run231_bucket_alignment_status + "\n";
   body += "top5_bucket_count_blocks_trade=true\n";
   body += "top5_bucket_count_blocks_diagnostic_review=false\n";
   body += "top5_bucket_count_trade_upload_allowed=false\n";
   body += "top5_bucket_count_diagnostic_upload_allowed=true\n";
   body += "TOP5_BUCKET_COUNT_DIAGNOSTIC_BEGIN\n";
   body += "top5_bucket_count_diagnostic_version=RUN231_v1\n";
   body += "top5_bucket_count_mode=diagnostic_only_not_gate\n";
   body += "top5_bucket_count_blocks_trade=true\n";
   body += "top5_bucket_count_blocks_diagnostic_review=false\n";
   body += "required_buckets=crypto,energy,fx,indices,metals,stocks\n";
   body += "expected_bucket_count=6\n";
   body += "expected_children_per_bucket=5\n";
   body += "expected_total_top5_children=30\n";
   body += "observed_current_dossier_child_total=" + IntegerToString(MathMax(0, observed_dossier_total)) + "\n";
   body += "observed_current_sdp_child_total=" + observed_sdp_total + "\n";
   body += "observed_current_dossier_bucket_summary=crypto:" + IntegerToString(crypto_dossier_current)
           + ",energy:" + IntegerToString(energy_dossier_current)
           + ",fx:" + IntegerToString(fx_dossier_current)
           + ",indices:" + IntegerToString(indices_dossier_current)
           + ",metals:" + IntegerToString(metals_dossier_current)
           + ",stocks:" + IntegerToString(stocks_dossier_current) + "\n";
   body += "observed_current_sdp_bucket_summary=unknown_owner_sdp_per_bucket_child_count_not_transported_to_market_board_writer_no_file_scan_authority\n";
   ASC_BoardAppendRun231BucketLine(body, "crypto", crypto_dossier_current);
   ASC_BoardAppendRun231BucketLine(body, "energy", energy_dossier_current);
   ASC_BoardAppendRun231BucketLine(body, "fx", fx_dossier_current);
   ASC_BoardAppendRun231BucketLine(body, "indices", indices_dossier_current);
   ASC_BoardAppendRun231BucketLine(body, "metals", metals_dossier_current);
   ASC_BoardAppendRun231BucketLine(body, "stocks", stocks_dossier_current);
   body += "bucket_count_alignment_status=" + run231_bucket_alignment_status + "\n";
   body += "bucket_count_diagnostic_upload_allowed=true\n";
   body += "bucket_count_trade_upload_allowed=false\n";
   body += "bucket_count_trade_blocker_reason=top5_bucket_count_shortfall_or_unknown_blocks_trade_upload_for_trade_not_diagnostic_review\n";
   body += "bucket_count_diagnostic_reason=RUN231_exposes_expected_vs_observed_top5_bucket_counts_without_route_path_fileio_timing_gate_or_membership_change\n";
   body += "route_rewrite_performed=false\n";
   body += "path_change_performed=false\n";
   body += "fileio_change_performed=false\n";
   body += "timing_change_performed=false\n";
   body += "new_gate_added=false\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "TOP5_BUCKET_COUNT_DIAGNOSTIC_END\n";
   body += "board_identity_diagnostic_version=RUN229_v1\n";
   body += "board_visible_exact_symbol_mapping_available=unknown\n";
   body += "board_symbol_identity_unresolved_count=unknown_owner_market_board_writer_has_no_exact_broker_identity_index\n";
   body += "board_duplicate_route_diagnostic_available=true\n";
   body += "board_duplicate_route_unresolved_count=unknown_owner_market_board_writer_has_no_source_owned_parallel_route_index\n";
   body += "board_identity_blocks_trade=true\n";
   body += "board_identity_blocks_diagnostic_review=false\n";
   body += "diagnostic_upload_allowed=" + (diagnostic_upload_allowed ? "true" : "false") + "\n";
   body += "trade_upload_allowed=false\n";
   body += "diagnostic_reason=RUN228 exposes board-vs-child mismatch for Siam/operator review without blocking diagnostic review or rewriting routes\n";
   body += "trade_blocker_reason=trade_permission_remains_false_until_child_signature_alignment_and_later_compile_runtime_live_evidence\n";
   body += "route_rewrite_performed=false\n";
   body += "path_change_performed=false\n";
   body += "fileio_change_performed=false\n";
   body += "timing_change_performed=false\n";
   body += "new_gate_added=false\n";
   body += "trade_permission=false\n";
   body += "signal_permission=false\n";
   body += "execution_permission=false\n";
   body += "risk_permission=false\n";
   body += "BOARD_CHILD_ALIGNMENT_DIAGNOSTIC_END\n";
  }

void ASC_BoardAppendCommandBlock(string &body,
                                 const ASC_ShortlistSymbolSummary &top_ten[],
                                 const bool command_authority_ready)
  {
   ASC_BoardCommandCandidate best_pick;
   ASC_BoardCommandCandidate backup_pick;
   ASC_BoardCommandCandidate avoid_pick;
   ASC_BoardPickBestAndBackup(top_ten, best_pick, backup_pick);
   ASC_BoardPickAvoidNow(top_ten, avoid_pick);

   body += "Operator Command Surface\n";
   body += "----------------------------------------\n";
   body += StringFormat("State: %s\n",
                        command_authority_ready
                        ? "board-command authority from diversified overall board truth"
                        : "guarded board-command posture; authoritative picks are withheld until board authority improves");
   body += "Command Boundary: selected-symbol dossiers may deepen one symbol later, but ordinary trade-picking and diversified overall authority stay here on the Market Board.\n";
   if(command_authority_ready && ArraySize(top_ten) > 0 && !ASC_BoardCorrelationReady(top_ten))
      body += "Support Caution: current authoritative rows are live, but true-correlation support is still partial on the ordinary hot path.\n";

   if(!command_authority_ready)
     {
      string provisional_1 = ArraySize(top_ten) > 0 ? ASC_BoardCanonicalSymbolForState(top_ten[0].state) : "completion pending";
      string provisional_2 = ArraySize(top_ten) > 1 ? ASC_BoardCanonicalSymbolForState(top_ten[1].state) : "completion pending";
      string provisional_candidates = provisional_1;
      if(provisional_2 != "completion pending")
         provisional_candidates += " / " + provisional_2;

      body += "Best Pick Now: watchlist only while board authority is still building\n";
      body += StringFormat("Best Pick Context: board authority is partial; treat listed symbols as watch candidates only | %s\n",
                           provisional_candidates);
      body += "Backup Pick: deferred until board authority is stronger\n";
      body += "Backup Context: keep backup selection on watch until ranking support is ready\n";
      body += "Avoid Right Now: risk watch only\n";
      body += "Avoid Context: use exposure and correlation context before any action while support is partial\n";
      body += "Immediate Rotation: suppressed while board authority is partial\n\n";
      return;
     }

   string best_symbol = best_pick.available ? ASC_BoardCanonicalSymbolForState(best_pick.row.state) : "completion pending";
   string best_reason = best_pick.available
                        ? ASC_BoardCommandReasonLine(best_pick.row, best_pick.open_positions, best_pick.pending_orders)
                        : "no fully supported exposure-clean candidate is currently available";
   string best_alignment_note = ASC_BoardBestPickAlignmentNote(top_ten, best_pick);
   if(StringLen(best_alignment_note) > 0)
      best_reason += " | " + best_alignment_note;
   body += StringFormat("Best Pick Now: %s\n", best_symbol);
   body += StringFormat("Best Pick Context: %s\n", best_reason);

   string backup_symbol = backup_pick.available ? ASC_BoardCanonicalSymbolForState(backup_pick.row.state) : "completion pending";
   string backup_reason = backup_pick.available
                          ? ASC_BoardCommandReasonLine(backup_pick.row, backup_pick.open_positions, backup_pick.pending_orders)
                          : "no fully supported backup candidate survives current immediate filters";
   body += StringFormat("Backup Pick: %s\n", backup_symbol);
   body += StringFormat("Backup Context: %s\n", backup_reason);

   string avoid_symbol = avoid_pick.available ? ASC_BoardCanonicalSymbolForState(avoid_pick.row.state) : "none";
   string avoid_reason = avoid_pick.available
                         ? StringFormat("peer %.2f | cluster %d | exposure %s | %s",
                                        avoid_pick.row.overall_board_peer_correlation,
                                        avoid_pick.row.overall_board_cluster_count,
                                        ASC_ConflictCountsText(avoid_pick.open_positions, avoid_pick.pending_orders),
                                        ASC_TextOrUnavailable(avoid_pick.row.shortlist_reason))
                         : "no symbol is currently flagged for immediate risk-avoid posture on diversified overall members";
   body += StringFormat("Avoid Right Now: %s\n", avoid_symbol);
   body += StringFormat("Avoid Context: %s\n", avoid_reason);

   string rotation = "";
   for(int i = 0; i < ArraySize(top_ten); i++)
     {
      if(i >= 5)
         break;
      if(StringLen(rotation) > 0)
         rotation += " -> ";
      rotation += ASC_BoardCanonicalSymbolForState(top_ten[i].state);
     }
   if(StringLen(rotation) <= 0)
      rotation = "unavailable";
   body += StringFormat("Immediate Rotation: watchlist sequencing only | %s\n\n", rotation);
  }

bool ASC_BoardCorrelationReady(const ASC_ShortlistSymbolSummary &rows[])
  {
   if(ArraySize(rows) < 2)
      return false;

   int ready_rows = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(rows[i].correlation_summary.summary_ready)
         ready_rows++;
     }
   return (ready_rows >= MathMin(3, ArraySize(rows)));
  }

double ASC_BoardDangerWatchScore(const ASC_ShortlistSymbolSummary &entry,
                                 const int open_positions,
                                 const int pending_orders)
  {
   double tactical_avg = (entry.filter.timing_quality_score
                          + entry.filter.pressure_shift_score
                          + entry.filter.momentum_acceleration_score) / 3.0;
   double score = (entry.overall_board_score * 0.40)
                  + (entry.style_fit_score * 0.25)
                  + (entry.deep_request_priority_score * 0.25)
                  + (tactical_avg * 0.10);

   if(entry.bucket_shortlisted && !entry.shortlisted)
      score += 7.0;
   if((open_positions + pending_orders) > 0)
      score += 4.0;
   if(entry.overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
      || entry.overall_board_cluster_count > 0)
      score += 3.0;

   return MathMax(0.0, MathMin(100.0, score));
  }

string ASC_BoardDangerWatchReason(const ASC_ShortlistSymbolSummary &entry,
                                  const int open_positions,
                                  const int pending_orders)
  {
   string reason = "";
   if(entry.bucket_shortlisted && !entry.shortlisted)
      reason = "strong bucket leader reserved from diversified overall";
   else if((open_positions + pending_orders) > 0)
      reason = "active exposure conflict keeps it out of first-pick slot";
   else if(entry.overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
           || entry.overall_board_cluster_count > 0)
      reason = "crowding drag keeps first-pick cleanliness guarded";
   else if(entry.style_fit_score >= 68.0)
      reason = "strong tactical/style carry, but immediate support is still mixed";
   else
      reason = "reserve-but-relevant candidate for fast rotation watch";

   if(entry.deep_request_priority_score >= 70.0)
      reason += " | deep priority high";
   else if(entry.deep_request_priority_score >= 60.0)
      reason += " | deep priority elevated";

   return reason;
  }

void ASC_BoardInsertDangerWatchCandidate(ASC_BoardDangerWatchCandidate &rows[],
                                         const ASC_BoardDangerWatchCandidate &candidate,
                                         const int limit)
  {
   int next = ArraySize(rows);
   ArrayResize(rows, next + 1);
   rows[next] = candidate;

   for(int i = next; i > 0; i--)
     {
      if(rows[i - 1].score >= rows[i].score)
         break;
      ASC_BoardDangerWatchCandidate tmp = rows[i - 1];
      rows[i - 1] = rows[i];
      rows[i] = tmp;
     }

   if(ArraySize(rows) > limit)
      ArrayResize(rows, limit);
  }

void ASC_BoardAppendDangerWatchlist(string &body,
                                    const ASC_ShortlistSymbolSummary &full_rows[])
  {
   ASC_BoardDangerWatchCandidate watch_rows[];
   ArrayResize(watch_rows, 0);
   const int watch_limit = 5;

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(full_rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         continue;

      int open_positions = 0;
      int pending_orders = 0;
      ASC_OpenPendingConflictValue(full_rows[i].symbol, open_positions, pending_orders);

      bool reserved_bucket = (full_rows[i].bucket_shortlisted && !full_rows[i].shortlisted);
      bool exposure_held = ((open_positions + pending_orders) > 0);
      bool crowded = (full_rows[i].overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
                      || full_rows[i].overall_board_cluster_count > 0
                      || full_rows[i].overall_board_correlation_penalty >= 4.0);
      bool strong_but_delayed = (full_rows[i].style_fit_score >= 68.0
                                 && !ASC_BoardIsImmediatePickCandidate(full_rows[i], open_positions, pending_orders));

      if(!reserved_bucket && !exposure_held && !crowded && !strong_but_delayed)
         continue;
      if(full_rows[i].shortlisted && full_rows[i].rank > 0 && full_rows[i].rank <= 2
         && ASC_BoardIsImmediatePickCandidate(full_rows[i], open_positions, pending_orders))
         continue;

      ASC_BoardDangerWatchCandidate candidate;
      candidate.row = full_rows[i];
      candidate.open_positions = open_positions;
      candidate.pending_orders = pending_orders;
      candidate.score = ASC_BoardDangerWatchScore(full_rows[i], open_positions, pending_orders);
      candidate.reason = ASC_BoardDangerWatchReason(full_rows[i], open_positions, pending_orders);
      ASC_BoardInsertDangerWatchCandidate(watch_rows, candidate, watch_limit);
     }

   body += "\nDanger Watchlist (Reserve-but-Dangerous)\n";
   body += "----------------------------------------\n";
   body += "Danger Watchlist: strong-but-delayed names that still deserve immediate operator attention\n";
   if(ArraySize(watch_rows) <= 0)
     {
      body += "No reserve-but-dangerous watch names are currently present from lawful board context.\n";
      return;
     }

   for(int i = 0; i < ArraySize(watch_rows); i++)
     {
      body += StringFormat("- %s | Watch %.1f | %s\n",
                           ASC_BoardCanonicalSymbolForState(watch_rows[i].row.state),
                           watch_rows[i].score,
                           watch_rows[i].reason);
     }
  }

void ASC_BoardAppendConflictAndExposureContext(string &body,
                                               const ASC_ShortlistSymbolSummary &full_rows[],
                                               const ASC_ShortlistSymbolSummary &top_ten[])
  {
   int crowded_count = 0;
   int exposure_count = 0;
   int reserve_bucket_count = 0;
   string bucket_mix = "";

   for(int i = 0; i < ArraySize(top_ten); i++)
     {
      int open_positions = 0;
      int pending_orders = 0;
      ASC_OpenPendingConflictValue(top_ten[i].symbol, open_positions, pending_orders);

      if(top_ten[i].overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
         || top_ten[i].overall_board_cluster_count > 0)
         crowded_count++;
      if((open_positions + pending_orders) > 0 || top_ten[i].overall_board_conflict_penalty > 0.0)
         exposure_count++;

      string bucket_id = ASC_ClassificationCanonicalMainBucketId(top_ten[i].state.classification);
      if(StringLen(bucket_id) <= 0)
         bucket_id = "unknown";
      if(StringLen(bucket_mix) > 0)
         bucket_mix += " | ";
      bucket_mix += ASC_MainBucketOperatorNameFromId(bucket_id) + " " + IntegerToString(i + 1);
     }

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(full_rows[i].bucket_shortlisted && !full_rows[i].shortlisted)
         reserve_bucket_count++;
     }

   body += "\nConflict / Correlation / Exposure Context\n";
   body += "----------------------------------------\n";
   body += StringFormat("Overall Board Spread: %d names | Bucket Mix %s\n",
                        ArraySize(top_ten),
                        StringLen(bucket_mix) > 0 ? bucket_mix : "unavailable");
   body += StringFormat("Correlation Watch: %d | Exposure Watch: %d | Bucket-Top5 Reserves Outside Overall: %d\n",
                        crowded_count,
                        exposure_count,
                        reserve_bucket_count);
   body += "Interpretation: bucket top-5 remains bucket-local ranking; diversified overall ranks can reserve strong local names when peer crowding, bucket duplication, or active exposure is already present.\n";

   bool any_watch = false;
   for(int i = 0; i < ArraySize(top_ten); i++)
     {
      int open_positions = 0;
      int pending_orders = 0;
      ASC_OpenPendingConflictValue(top_ten[i].symbol, open_positions, pending_orders);
      bool crowd_watch = (top_ten[i].overall_board_peer_correlation >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH
                          || top_ten[i].overall_board_cluster_count > 0
                          || (open_positions + pending_orders) > 0);
      if(!crowd_watch)
         continue;

      any_watch = true;
      body += StringFormat("- %s | Overall %s | Peer %s %.2f | Cluster %d | Open/Pending %s | %s\n",
                           ASC_BoardCanonicalSymbolForState(top_ten[i].state),
                           ASC_BoardOverallRankLabel(top_ten[i]),
                           ASC_TextOrUnavailable(top_ten[i].overall_board_peer_symbol),
                           top_ten[i].overall_board_peer_correlation,
                           top_ten[i].overall_board_cluster_count,
                           ASC_ConflictCountsText(open_positions, pending_orders),
                           ASC_TextOrUnavailable(top_ten[i].shortlist_reason));
     }

   if(!any_watch)
      body += "No immediate diversified-overall crowding or active exposure warnings on current Top 10 membership.\n";

   body += "\nBucket Top-5 Reserves Outside Diversified Overall\n";
   body += "----------------------------------------\n";
   bool any_reserve = false;
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(!full_rows[i].bucket_shortlisted || full_rows[i].shortlisted)
         continue;

      any_reserve = true;
      body += StringFormat("- %s | Raw %s | Bucket %s | Board %.1f | %s\n",
                           ASC_BoardCanonicalSymbolForState(full_rows[i].state),
                           ASC_BoardRawRankLabel(full_rows[i]),
                           ASC_BoardBucketRankLabel(full_rows[i]),
                           full_rows[i].overall_board_score,
                           ASC_TextOrUnavailable(full_rows[i].shortlist_reason));
     }

   if(!any_reserve)
      body += "No bucket-top reserves are currently being held outside the diversified overall board.\n";

   ASC_BoardAppendDangerWatchlist(body, full_rows);

   ASC_BoardAppendExcludedOrAlreadyActive(body);
  }

void ASC_BoardAppendContradictionProofBoundarySurface(string &body,
                                                     const ASC_ShortlistSymbolSummary &full_rows[],
                                                     const ASC_ShortlistSymbolSummary &top_ten[],
                                                     const ASC_PortfolioExposureSnapshot &portfolio_snapshot,
                                                     const ASC_PublicationBundleState &bundle,
                                                     const bool correlation_ready)
  {
   int l3_support_rows = 0;
   int l4_support_rows = 0;
   int l5_support_rows = 0;
   int stale_projection_rows = 0;
   int unavailable_projection_rows = 0;
   int retained_last_good_rows = 0;
   int source_supported_runtime_unobserved_rows = 0;

   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(full_rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         l3_support_rows++;
      if(ASC_ShortlistHasLawfulMembership(full_rows[i]) || ASC_ShortlistHasLawfulBucketMembership(full_rows[i]))
         l4_support_rows++;
      if(full_rows[i].deep_request_priority_score > 0.0 || StringLen(full_rows[i].deep_request_priority) > 0)
         l5_support_rows++;
      if(full_rows[i].state.is_stale || (full_rows[i].has_packet && full_rows[i].packet.is_stale))
         stale_projection_rows++;
      if(!full_rows[i].has_packet || !full_rows[i].packet.valid_bid || !full_rows[i].packet.valid_ask)
         unavailable_projection_rows++;
      if(full_rows[i].has_packet && (full_rows[i].packet.continuity_backed || full_rows[i].packet.freshness == ASC_L2_CONTINUITY))
         retained_last_good_rows++;
      if(ASC_MarketBoardEvidenceIntakeState(full_rows[i], true) == ASC_MARKET_BOARD_EVID_INTAKE_SRC_RT_UNPROVEN)
         source_supported_runtime_unobserved_rows++;
     }

   body += "\n" + ASC_MARKET_BOARD_CONTRADICTION_SECTION_NAME + "\n";
   body += "----------------------------------------\n";
   body += "section_name=" + ASC_MARKET_BOARD_CONTRADICTION_SECTION_NAME
           + " | board_contradiction_surface=" + ASC_MARKET_BOARD_CONTRADICTION_SURFACE_ADVISORY_ONLY
           + " | board_publication_blocker=" + ASC_MARKET_BOARD_CONTRADICTION_PUBLICATION_BLOCKER_FALSE
           + " | board_order_change=" + ASC_MARKET_BOARD_ORDER_CHANGE_FALSE
           + " | board_rank_change=" + ASC_MARKET_BOARD_RANK_CHANGE_FALSE
           + " | board_top10_change=" + ASC_MARKET_BOARD_TOP10_CHANGE_FALSE
           + " | trade_permission=" + ASC_MARKET_BOARD_TRADE_PERMISSION_FALSE
           + " | entry_signal=" + ASC_MARKET_BOARD_ENTRY_SIGNAL_FALSE
           + " | execution_permission=" + ASC_MARKET_BOARD_EXECUTION_PERMISSION_FALSE
           + " | final_trade_decision=" + ASC_MARKET_BOARD_FINAL_TRADE_DECISION_FALSE
           + " | strategy_edge_proof=" + ASC_MARKET_BOARD_STRATEGY_EDGE_PROOF_FALSE
           + " | veto_power=" + ASC_MARKET_BOARD_VETO_POWER_FALSE
           + " | truth_owner=" + ASC_MARKET_BOARD_TRUTH_OWNER_FALSE
           + " | artifact_projection=" + ASC_MARKET_BOARD_ARTIFACT_PROJECTION_ONLY
           + " | board_summary_projection_only=" + ASC_MARKET_BOARD_SUMMARY_PROJECTION_ONLY
           + " | behavior_change=" + ASC_MARKET_BOARD_BEHAVIOR_CHANGE_NONE + "\n";
   string retained_last_good_state = (retained_last_good_rows > 0 ? "present" : "not_observed_in_current_rows");
   body += "Proof Scope: source_supported=true | runtime_observed=false | source_patched_live_unproven=true"
           + StringFormat(" | pre_patch_live_proven_post_patch_unproven=RUN065R_scope_only | source_supported_runtime_unobserved_rows=%d", source_supported_runtime_unobserved_rows)
           + " | scenario_absent_untested=open_positions_and_pending_orders_nonzero_cases | held_for_future_live=RUN076R_or_later"
           + " | retained_last_good=" + retained_last_good_state
           + " | current=qualified | archive=not_current_truth | unavailable=must_be_labeled | partial=must_be_labeled | stale=must_be_labeled\n";
   body += StringFormat("Layer Contradiction Categories: l3_score_support_only=%d_rows | l4_rank_support_only=%d_rows | l5_deep_support_only=%d_rows | score_vs_rank_mismatch=advisory_only | deep_analysis_overclaim=advisory_only | stale_source_projection=advisory_only rows=%d | unavailable_as_clean_truth=advisory_only rows=%d | retained_last_good_as_current=advisory_only rows=%d | source_supported_not_runtime_observed=advisory_only\n",
                        l3_support_rows,
                        l4_support_rows,
                        l5_support_rows,
                        stale_projection_rows,
                        unavailable_projection_rows,
                        retained_last_good_rows);
   body += "Board Ranking / Ordering Limitations: rank_is_priority_ordering_only=true | top10_is_current_family_projection_only=true | top10_is_not_trade_list=true | market_board_is_not_trade_list=true | market_board_is_not_execution_queue=true | board_order_is_not_entry_priority=true | board_order_is_not_position_sizing=true | board_order_is_not_trade_permission=true | board_limitations_visible=" + ASC_MARKET_BOARD_LIMITATIONS_VISIBLE_TRUE + "\n";
   body += StringFormat("Portfolio / History Boundaries: active_exposure=open_positions_only | future_exposure=pending_orders_only | closed_history_context_only=true | closed_history_not_active_exposure=true | closed_history_candidate_blocker=false | portfolio_history_vs_active_exposure_confusion=advisory_only | history_unavailable_not_zero=true | open_trade_count=%d | pending_order_count=%d | recent_closed_trade_count=%d | recent_closed_trade_limit=%d | portfolio_section_status=%s | history_section_status=%s\n",
                        portfolio_snapshot.open_trade_count,
                        portfolio_snapshot.pending_order_count,
                        portfolio_snapshot.recent_closed_trade_count,
                        portfolio_snapshot.recent_closed_trade_limit,
                        ASC_PortfolioSectionStatusToken(portfolio_snapshot),
                        ASC_PortfolioHistorySectionStatusToken(portfolio_snapshot));
   body += "GlobalTop10 Current / Archive Boundary: globaltop10_current_vs_archive_confusion=advisory_only | globaltop10_truth_owner_unchanged=true | no_globaltop10_publication_change=true | no_globaltop10_selection_change=true | archive_is_history_only=true | current_family_is_current_only_if_manifest_current=true\n";
   body += StringFormat("Board Projection Boundary: board_rows=%d | top10_rows=%d | correlation_support=%s | market_board_remains_summary_projection=true | dossier_current_focus_may_be_richer_but_cannot_override_board_order=true | selected_symbol_deep_support_only=true\n",
                        ArraySize(full_rows),
                        ArraySize(top_ten),
                        correlation_ready ? "ready" : "partial_or_unavailable");
   body += "Publication Guard: optional_section=" + ASC_MARKET_BOARD_OPTIONAL_SECTION_TRUE
           + " | fail_soft=" + ASC_MARKET_BOARD_FAIL_SOFT_TRUE
           + " | base_board_publish_independent=" + ASC_MARKET_BOARD_BASE_PUBLISH_INDEPENDENT_TRUE
           + " | no_required_token_dependency=" + ASC_MARKET_BOARD_NO_REQUIRED_TOKEN_DEPENDENCY_TRUE
           + " | no_fileio_change=" + ASC_MARKET_BOARD_NO_FILEIO_CHANGE_TRUE
           + " | no_manifest_promotion_change=" + ASC_MARKET_BOARD_NO_MANIFEST_PROMOTION_CHANGE_TRUE
           + " | bundle_board_publish_result=" + ASC_TextOrUnavailable(bundle.board_publish_result) + "\n";
   body += "Observability Guard: functionresults_emit_scope=aggregate_market_board_finish_row_only | per_symbol_spam=false | per_trade_spam=false | per_closed_trade_spam=false | per_timeframe_spam=false | per_bar_spam=false | per_tick_spam=false\n\n";
  }


bool ASC_WriteCompanionBoard(const string target_path,
                             const ASC_PublicationBundleState &bundle,
                             const string publication_state,
                             const string body,
                             const bool require_correlation_rows,
                             string &write_state,
                             string &write_reason)
  {
   string required_tokens[];
   int required_count = require_correlation_rows ? 38 : 37;
   ArrayResize(required_tokens, required_count);
   required_tokens[0] = "AURORA SENTINEL SCANNER — MARKET BOARD";
   required_tokens[1] = "Operator Command Surface";
   required_tokens[2] = "Environment / Account / Execution Reality";
   required_tokens[3] = "Diversified Top 10 Overall";
   required_tokens[4] = "Conflict / Correlation / Exposure Context";
   required_tokens[5] = "Board Freshness";
   required_tokens[6] = "market_board_minimum_skeleton=available";
   required_tokens[7] = "artifact_failure_boundary=fail_soft";
   required_tokens[8] = "source_supported=true";
   required_tokens[9] = "runtime_observed=false";
   required_tokens[10] = "RUN092 Alignment Contract";
   required_tokens[11] = "rank_order_formula_change=false";
   required_tokens[12] = "packet_type=market_board_trader_chat_context";
   required_tokens[13] = "retrieval_pack_enabled=true";
   required_tokens[14] = "family_dossier_role=prepared_review_artifact";
   required_tokens[15] = "selected_current_workflow_enabled=true";
   required_tokens[16] = "market_board_role=selection_context_not_trade_signal";
   required_tokens[17] = "packet_currentness_evidence_enabled=true";
   required_tokens[18] = "retrieval_pack_globaltop10_path=Dossiers/GlobalTop10/<symbol>.txt";
   required_tokens[19] = "retrieval_pack_top5_path=Dossiers/Top5PerBucket/<bucket>/<symbol>.txt";
   required_tokens[20] = "family_dossier_not_trade_signal=true";
   required_tokens[21] = "selected_current_required_for_actionability=true";
   required_tokens[22] = "trader_chat_packet_per_symbol_rows=false";
   required_tokens[23] = "trader_chat_packet_proof_spam_avoided=true";
   required_tokens[24] = "packet_next_live_proof=RUN130R";
   required_tokens[25] = "retrieval_pack_actionability_policy=ranked_not_actionable_without_current_market_state_and_selected_refresh";
   required_tokens[26] = "BOARD_CHILD_SYNC_STATE_BEGIN";
   required_tokens[27] = "TRADE_READINESS_COMPLETION_PATH_BEGIN";
   required_tokens[28] = "EXECUTION_FACTS_OWNER_MAP_BEGIN";
   required_tokens[29] = "EXECUTION_FACTS_READINESS_BEGIN";
   required_tokens[30] = "L3_L4_OWNER_MAP_BEGIN";
   required_tokens[31] = "L3_L4_READINESS_BEGIN";
   required_tokens[32] = "SIAM_UPLOAD_WORKFLOW_READINESS_BEGIN";
   required_tokens[33] = "SIAM_DATA_PURITY_SEMANTICS_BEGIN";
   required_tokens[34] = "JASON_OPERATOR_WORKFLOW_BEGIN";
   required_tokens[35] = "COMPILE_HYGIENE_GUARD_BEGIN";
   required_tokens[36] = "ready_for_siam_trade=no";
   if(require_correlation_rows)
      required_tokens[37] = "Correlation / Exposure:";

   string resilient_body = body;
   resilient_body += ASC_PublicationResilienceBlock(body,
                                                    required_tokens,
                                                    "market_board",
                                                    "ASC_MarketBoardWriter",
                                                    "missing Market Board diagnostic/status token is degraded visibility/trade-review debt, not a file-write failure",
                                                    true);

   datetime board_wrapper_publication_utc = bundle.publication_utc;
   if(bundle.board_recompute_finished_utc > 0)
      board_wrapper_publication_utc = bundle.board_recompute_finished_utc;
   else if(bundle.board_publish_started_utc > 0)
      board_wrapper_publication_utc = bundle.board_publish_started_utc;

   write_state = "pending";
   write_reason = "pending";
   int board_resilience_missing_count = 0;
   string board_resilience_first_missing = "none";
   ASC_PublicationResilienceMissingTokenList(resilient_body, required_tokens, board_resilience_missing_count, board_resilience_first_missing);
   string resilient_publication_state = publication_state;
   if(board_resilience_missing_count > 0)
      resilient_publication_state = "complete_with_degraded_sections";
   return ASC_WritePublicationArtifact(target_path,
                                      bundle.publication_id,
                                      board_wrapper_publication_utc,
                                      resilient_body,
                                      required_tokens,
                                      resilient_publication_state,
                                      write_state,
                                      write_reason);
  }


string ASC_BoardTraderChatPacketBlock(const string publication_state)
  {
   string packet_currentness = (publication_state == "continuity" || publication_state == "stale") ? "retained_last_good" : "current_or_pending_publish";
   string block = "Trader-Chat Copy Block\n";
   block += "----------------------------------------\n";
   block += "packet_type=market_board_trader_chat_context\n";
   block += "packet_rank_source=committed_l4_snapshot\n";
   block += "packet_rank_is_not_trade_signal=true\n";
   block += "packet_symbol_lookup_policy=top5_or_globaltop10_family_dossier\n";
   block += "packet_dossier_lookup_policy=globaltop10_or_top5perbucket\n";
   block += "packet_actionability_requires_selected_current_refresh=true\n";
   block += "packet_selected_refresh_policy=required_before_actionability\n";
   block += "packet_claim_evidence_enabled=true\n";
   block += "packet_currentness_evidence_enabled=true\n";
   block += "packet_unavailable_policy=explain_owner_reason_next_check\n";
   block += "packet_currentness=" + packet_currentness + "\n";
   block += "packet_next_live_proof=RUN130R\n";
   return block;
  }

string ASC_BoardRetrievalPackBlock()
  {
   string block = "Market Board to Dossier Retrieval Pack\n";
   block += "----------------------------------------\n";
   block += "retrieval_pack_enabled=true\n";
   block += "retrieval_pack_source=MarketBoard\n";
   block += "retrieval_pack_rank_source=committed_l4_snapshot\n";
   block += "retrieval_pack_globaltop10_path=Dossiers/GlobalTop10/<symbol>.txt\n";
   block += "retrieval_pack_top5_path=Dossiers/Top5PerBucket/<bucket>/<symbol>.txt\n";
   block += "retrieval_pack_current_focus_path=Current Focus\n";
   block += "retrieval_pack_selected_dossier_path=Dossier.txt or selected-current equivalent\n";
   block += "retrieval_pack_missing_policy=claim_evidence_pending_or_unavailable_with_owner_next_check\n";
   block += "retrieval_pack_actionability_policy=ranked_not_actionable_without_current_market_state_and_selected_refresh\n";
   block += "retrieval_pack_quote_policy=current_quote_required_for_actionability\n";
   block += "retrieval_pack_session_policy=open_or_confirmed_session_required_for_actionability\n";
   return block;
  }

string ASC_BoardFamilyDossierPolicyBlock()
  {
   string block = "Family Dossier Path Policy\n";
   block += "----------------------------------------\n";
   block += "family_dossier_role=prepared_review_artifact\n";
   block += "family_dossier_not_trade_signal=true\n";
   block += "family_dossier_currentness_required=true\n";
   block += "family_dossier_selected_refresh_required_for_actionability=true\n";
   block += "globaltop10_retrieval_path=Dossiers/GlobalTop10/<symbol>.txt\n";
   block += "top5perbucket_retrieval_path=Dossiers/Top5PerBucket/<bucket>/<symbol>.txt\n";
   block += "family_dossier_missing_policy=claim_evidence_pending_or_unavailable_with_owner_next_check\n";
   block += "family_dossier_missing_is_not_rank_failure=true\n";
   block += "staging_archive_are_not_current_authority=true\n";
   return block;
  }

string ASC_BoardSelectedCurrentWorkflowBlock()
  {
   string block = "Selected / Current Workflow\n";
   block += "----------------------------------------\n";
   block += "selected_current_workflow_enabled=true\n";
   block += "selected_current_required_for_actionability=true\n";
   block += "current_focus_role=selected_symbol_live_context\n";
   block += "prepared_dossier_role=review_context_not_execution_signal\n";
   block += "deep_analysis_refresh_role=selected_symbol_context_expansion\n";
   block += "market_board_role=selection_context_not_trade_signal\n";
   block += "current_quote_required_for_actionability=true\n";
   block += "open_or_confirmed_session_required_for_actionability=true\n";
   return block;
  }

string ASC_BoardTraderChatAggregateTokens()
  {
   return ASC_TraderChatAggregateTokens();
  }

bool ASC_BoardPayloadPassesTruthGuard(const string body,string &reason_out)
  {
   reason_out = "ok";
   if(StringFind(body, "Not First Pick Because:") >= 0)
     {
      reason_out = "legacy first-pick wording detected";
      return false;
     }
   if(StringFind(body, "cleaner first-pick profile") >= 0)
     {
      reason_out = "legacy overconfident comparison wording detected";
      return false;
     }
   if(StringFind(body, "50.0 (unavailable)") >= 0)
     {
      reason_out = "fake-neutral unavailable tactical score detected";
      return false;
     }
   if(StringFind(body, "MARKET_BOARD_CURRENTNESS_BEGIN") < 0 || StringFind(body, "MARKET_BOARD_CURRENTNESS_END") < 0)
     {
      reason_out = "RUN235 currentness block missing";
      return false;
     }
   if(StringFind(body, "MARKET_BOARD_REVIEW_AUTHORITY_BEGIN") < 0 || StringFind(body, "MARKET_BOARD_REVIEW_AUTHORITY_END") < 0)
     {
      reason_out = "RUN235 review authority block missing";
      return false;
     }
   if(StringFind(body, "NO_ROUTE_TOUCH_GUARANTEE_BEGIN") < 0 || StringFind(body, "NO_ROUTE_TOUCH_GUARANTEE_END") < 0)
     {
      reason_out = "RUN235 no-route-touch guarantee missing";
      return false;
     }
   if(StringFind(body, "BOARD_CHILD_SYNC_STATE_BEGIN") < 0 || StringFind(body, "BOARD_CHILD_SYNC_STATE_END") < 0)
     {
      reason_out = "RUN237 board-child sync state block missing";
      return false;
     }
   if(StringFind(body, "TRADE_READINESS_COMPLETION_PATH_BEGIN") < 0 || StringFind(body, "TRADE_READINESS_COMPLETION_PATH_END") < 0)
     {
      reason_out = "RUN237 trade-readiness completion path block missing";
      return false;
     }
   if(StringFind(body, "EXECUTION_FACTS_OWNER_MAP_BEGIN") < 0 || StringFind(body, "EXECUTION_FACTS_OWNER_MAP_END") < 0)
     {
      reason_out = "RUN238 execution facts owner map block missing";
      return false;
     }
   if(StringFind(body, "EXECUTION_FACTS_READINESS_BEGIN") < 0 || StringFind(body, "EXECUTION_FACTS_READINESS_END") < 0)
     {
      reason_out = "RUN238 execution facts readiness block missing";
      return false;
     }
   if(StringFind(body, "L3_L4_OWNER_MAP_BEGIN") < 0 || StringFind(body, "L3_L4_OWNER_MAP_END") < 0)
     {
      reason_out = "RUN239 L3/L4 owner map block missing";
      return false;
     }
   if(StringFind(body, "L3_L4_READINESS_BEGIN") < 0 || StringFind(body, "L3_L4_READINESS_END") < 0)
     {
      reason_out = "RUN239 L3/L4 readiness block missing";
      return false;
     }
   if(StringFind(body, "writer_calculates_l3_l4=true") >= 0
      || StringFind(body, "rank_formula_changed=true") >= 0
      || StringFind(body, "membership_formula_changed=true") >= 0
      || StringFind(body, "market_board_order_changed=true") >= 0)
     {
      reason_out = "RUN239 forbidden writer-owned L3/L4 calculation or rank/membership/order mutation marker detected";
      return false;
     }
   if(StringFind(body, "writer_calculates_execution_facts=true") >= 0
      || StringFind(body, "market_data_calls_added_in_writer=true") >= 0
      || StringFind(body, "copyrates_added_in_writer=true") >= 0
      || StringFind(body, "copybuffer_added_in_writer=true") >= 0
      || StringFind(body, "iATR_added_in_writer=true") >= 0
      || StringFind(body, "session_api_added_in_writer=true") >= 0)
     {
      reason_out = "RUN238 forbidden writer-owned execution fact calculation marker detected";
      return false;
     }
   if(StringFind(body, "\ntrade_permission=true") >= 0
      || StringFind(body, "\nsignal_permission=true") >= 0
      || StringFind(body, "\nexecution_permission=true") >= 0
      || StringFind(body, "\nrisk_permission=true") >= 0)
     {
      reason_out = "RUN235 forbidden trade/signal/execution/risk permission detected";
      return false;
     }

   bool provisional_board_state = (StringFind(body, "Ranking Authority: provisional_only") >= 0);
   if(provisional_board_state)
     {
      if(StringFind(body, "Best Pick Context: board authority is partial; treat listed symbols as watch candidates only") < 0)
        {
         reason_out = "provisional board state without withheld best-pick wording";
         return false;
        }
      if(StringFind(body, "Immediate Rotation: suppressed while board authority is partial") < 0)
        {
         reason_out = "provisional board state without rotation suppression wording";
         return false;
        }
     }

   return true;
  }

ASC_FunctionResult ASC_BuildMarketBoardArtifact(const string server_root,
                                                const ASC_Layer1PassSummary &summary,
                                                const ASC_PublicationBundleState &bundle,
                                                const ASC_ShortlistSymbolSummary &full_rows[])
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_MarketBoardWriter", "ASC_BuildMarketBoardArtifact", "runtime");
   ASC_FunctionResultSetTruthBoundary(result, "artifact.market_board_writer", "truth_consumer.shortlist_summary_compose_publish");

   ASC_ArtifactContract contract = ASC_MarketBoardContract(server_root);
   ASC_PortfolioExposureSnapshot portfolio_snapshot;
   ASC_PortfolioBuildExposureSnapshot(portfolio_snapshot);
   ulong compose_started_us = GetMicrosecondCount();
   ASC_ShortlistSymbolSummary top_ten[];
   ASC_BoardBuildAllMarketsTopRows(full_rows, 10, top_ten);
   bool correlation_ready = ASC_BoardCorrelationReady(top_ten);
   bool top_ten_ready = (summary.is_ready && ArraySize(top_ten) > 0);
   int market_board_evidence_clean_count = 0;
   int market_board_evidence_non_clean_count = 0;
   int market_board_evidence_unavailable_count = 0;
   int market_board_evidence_stale_count = 0;
   int market_board_evidence_insufficient_count = 0;
   int market_board_evidence_dependency_count = 0;
   string dominant_market_board_evidence_state = ASC_MARKET_BOARD_EVID_INTAKE_NOT_APPLICABLE;
   int dominant_market_board_evidence_hits = 0;
   for(int mbe = 0; mbe < ArraySize(top_ten); mbe++)
     {
      string intake_state = ASC_MarketBoardEvidenceIntakeState(top_ten[mbe], true);
      if(intake_state == ASC_MARKET_BOARD_EVID_INTAKE_CLEAN_SUPPORTED)
         market_board_evidence_clean_count++;
      else if(intake_state == ASC_MARKET_BOARD_EVID_INTAKE_UNAVAILABLE_RECOVERABLE)
         market_board_evidence_unavailable_count++;
      else if(intake_state == ASC_MARKET_BOARD_EVID_INTAKE_STALE_RECOVERABLE)
         market_board_evidence_stale_count++;
      else if(intake_state == ASC_MARKET_BOARD_EVID_INTAKE_INSUFFICIENT_NOW)
         market_board_evidence_insufficient_count++;
      else if(intake_state == ASC_MARKET_BOARD_EVID_INTAKE_DEP_BLOCKED)
         market_board_evidence_dependency_count++;
      if(intake_state != ASC_MARKET_BOARD_EVID_INTAKE_CLEAN_SUPPORTED
         && intake_state != ASC_MARKET_BOARD_EVID_INTAKE_NOT_APPLICABLE)
         market_board_evidence_non_clean_count++;
      if(dominant_market_board_evidence_hits <= 0 || intake_state == dominant_market_board_evidence_state)
        {
         dominant_market_board_evidence_state = intake_state;
         dominant_market_board_evidence_hits++;
        }
     }
   int open_market_entitled_count = ASC_BoardOpenMarketEntitledCount(top_ten);
   int authoritative_candidate_count = ASC_BoardOpenMarketAuthoritativeCandidateCount(top_ten);
   bool command_authority_ready = ASC_BoardCommandAuthorityReady(summary.is_degraded,
                                                                 summary.is_stale,
                                                                 summary.is_ready,
                                                                 top_ten_ready,
                                                                 correlation_ready,
                                                                 open_market_entitled_count,
                                                                 authoritative_candidate_count);

   int open_count = 0;
   int pass_count = 0;
   int shortlisted_count = 0;
   int promoted_count = 0;
   for(int i = 0; i < ArraySize(full_rows); i++)
     {
      if(ASC_ConsumerAllowsOrdinaryL34(full_rows[i].state))
         open_count++;
      if(full_rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         pass_count++;
      if(ASC_ShortlistHasLawfulMembership(full_rows[i]))
        {
         string shortlist_band = full_rows[i].shortlist_band;
         StringToLower(shortlist_band);
         if(shortlist_band == "promoted")
            promoted_count++;
         else if(shortlist_band == "shortlisted")
            shortlisted_count++;
        }
     }

   string publication_state = ASC_ArtifactPublicationState(summary.is_degraded, summary.is_stale);
   datetime board_body_generated_utc = summary.pass_utc;
   if(bundle.board_recompute_finished_utc > 0)
      board_body_generated_utc = bundle.board_recompute_finished_utc;
   else if(bundle.board_recompute_started_utc > 0)
      board_body_generated_utc = bundle.board_recompute_started_utc;
   else if(bundle.publication_utc > 0)
      board_body_generated_utc = bundle.publication_utc;
   datetime board_baseline_source_utc = summary.pass_utc;
   datetime top5_snapshot_source_utc = bundle.top5_market_board_source_pass_utc;
   if(top5_snapshot_source_utc <= 0)
      top5_snapshot_source_utc = summary.pass_utc;
   string market_board_top5_signature = ASC_BoardVisibleTop5PerBucketSignature(full_rows, top5_snapshot_source_utc, true);
   string market_board_top5_exact_signature = ASC_BoardVisibleTop5PerBucketSignature(full_rows, top5_snapshot_source_utc, false);
   bool market_board_publish_pending_for_top5 = (bundle.board_publish_result == "pending" || bundle.market_board_status == "pending");
   string market_board_top5_sync_status = ASC_Top5BoardSyncVerdict(market_board_top5_signature,
                                                                   bundle.top5_bucket_committed_signature,
                                                                   bundle.top5_bucket_family_state,
                                                                   bundle.top5_bucket_child_target_count,
                                                                   bundle.top5_bucket_active_child_actual_count,
                                                                   bundle.top5_bucket_staging_child_count,
                                                                   bundle.top5_bucket_queue_remaining,
                                                                   bundle.top5_bucket_pending_count,
                                                                   market_board_publish_pending_for_top5);

   string body = "AURORA SENTINEL SCANNER — MARKET BOARD\n";
   body += StringFormat("Server: %s\n", ASC_ArtifactServerName());
   body += StringFormat("Generated At: %s\n", ASC_ArtifactFormatUtc(board_body_generated_utc));
   body += StringFormat("Board State: %s\n", publication_state);
   body += StringFormat("Surface Truth: %s\n", ASC_ArtifactSurfaceFreshnessBoundaryLine(publication_state, command_authority_ready));
   body += ASC_ArtifactFamilyRoleMeaningLine() + "\n";
   body += ASC_ArtifactSurfaceProvenanceLine() + "\n";
   body += StringFormat("Scanner Posture: %s\n", ASC_ArtifactHumanizeLabel(summary.readiness_posture));
   body += "Role: Market Board is the operator battle board for trade-picking.\n";
   body += "Ranking Split: bucket top-5 is bucket-local; diversified overall Top 10 is cross-market shortlist ranking.\n";
   body += "Scoring Grammar: context, execution usefulness, timing usefulness, risk drag, and relative field position are shown separately.\n";
   body += "Missingness: warmup, repair-pending, retained, and hard-unavailable states remain explicit.\n\n";

   ASC_BoardAppendRun235CurrentnessBlock(body,
                                         summary,
                                         publication_state,
                                         top_ten_ready,
                                         authoritative_candidate_count,
                                         board_body_generated_utc);
   ASC_BoardAppendRun235ReviewAuthorityBlock(body,
                                             command_authority_ready,
                                             correlation_ready,
                                             authoritative_candidate_count,
                                             MathMax(0, ArraySize(top_ten) - authoritative_candidate_count),
                                             ArraySize(top_ten));
   body += ASC_Run235NoRouteTouchGuaranteeLine();

   ASC_BoardAppendCommandBlock(body, top_ten, command_authority_ready);

   body += "Environment / Account / Execution Reality\n";
   body += "----------------------------------------\n";
   body += ASC_ArtifactIdentityLine("market_board", (summary.is_stale || summary.is_degraded) ? "retained_or_degraded" : "current") + "\n";
   body += "source_run_id=" + ASC_SourceRunId() + " | source_identity_token=" + ASC_SourceIdentityToken() + " | artifact_written_by_run=" + ASC_SourceRunId() + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion() + " | build_identity_present=true\n";
   body += ASC_RuntimeIdentityProofBlock("market_board", server_root, "root", board_body_generated_utc) + "\n";
   body += ASC_RootArtifactBreathingProofBlock("market_board",
                                               board_body_generated_utc,
                                               0,
                                               0,
                                               bundle.board_publish_started_utc > 0 ? bundle.board_publish_started_utc : board_body_generated_utc,
                                               bundle.board_publish_finished_utc,
                                               bundle.publication_utc,
                                               0,
                                               bundle.publication_utc,
                                               0,
                                               0,
                                               "",
                                               false,
                                               "market_board_compose_publish_attempt_visible_before_success_timestamp_updates",
                                               bundle.write_bottleneck_family == "none" ? "true" : "unknown") + "\n";
   string run092_board_signature = ASC_BoardVisibleTop10Signature(top_ten);
   body += ASC_ArtifactAlignmentContractLine("market_board",
                                             "board_top_list_projection",
                                             run092_board_signature,
                                             "not_a_child_family",
                                             "parent",
                                             "market_board_top10",
                                             ArraySize(top_ten) >= 10 ? "top10_visible" : (ArraySize(top_ten) > 0 ? "partial_top10_visible" : "unavailable"),
                                             (summary.is_stale || summary.is_degraded) ? "retained_or_degraded" : "current",
                                             "not_a_single_dossier",
                                             "board_projection_not_dossier_sections",
                                             "not_deep_confirmation_surface",
                                             "qualified_source_visible_live_unproven",
                                             0,
                                             ("runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN),
                                             false) + "\n";
   body += ASC_ArtifactRun092ContradictionClassCatalogLine() + "\n";
   body += StringFormat("Universe: %d\n", ASC_Layer1CachedSymbolCount());
   body += StringFormat("Open Markets: %d\n", open_count);
   body += StringFormat("Candidates: %d\n", pass_count);
   body += StringFormat("Diversified Overall Members: %d\n", ArraySize(top_ten));
   body += StringFormat("Promoted Overall: %d\n", promoted_count);
   body += StringFormat("Shortlisted Overall: %d\n", shortlisted_count);
   body += StringFormat("Classification: %s\n", ASC_Layer1ClassificationHealthCompact(summary));
   body += StringFormat("Classification Groups: %s\n", ASC_Layer1MainGroupDistributionCompact(summary));
   body += StringFormat("Classification Guard: %s\n", ASC_BoardClassificationGuardLine(summary));
   body += StringFormat("Next Market-State Recheck: %s\n", summary.next_due_utc > 0 ? ASC_ArtifactFormatUtc(summary.next_due_utc) : "unavailable");
   body += StringFormat("Next Recheck Reason: %s\n", ASC_TextOrUnavailable(summary.next_due_reason));
   body += StringFormat("Overall Board Readiness: %s | True-Correlation Support %s\n",
                        ASC_BoardOverallReadinessLabel(command_authority_ready, correlation_ready),
                        ASC_BoardCorrelationSupportLabel(correlation_ready));
   body += "Shared Visible Ceiling: open-symbol ordinary consumer posture may show Layer 0-4; closed-symbol ordinary posture remains Layer 0-2 only\n";
   body += StringFormat("Consumer Market Posture: %s\n", open_count > 0 ? "open-market shortlist projection" : "closed-market ordinary projection");
   body += StringFormat("L3/L4 Source Identity: %s\n", ASC_ConsumerShortlistSourceIdentityReadback("publication_shortlist_rows"));
   body += StringFormat("Consumer Path Identity: %s\n", ASC_ConsumerPathIdentityReadback(false));
   body += StringFormat("Ranking Authority: %s | Authoritative Candidates %d | Provisional/Insufficient %d\n",
                        ASC_BoardRankingAuthorityLabel(command_authority_ready, correlation_ready, open_market_entitled_count),
                        authoritative_candidate_count,
                        MathMax(0, ArraySize(top_ten) - authoritative_candidate_count));
   body += "Execution Context: broker, account, and exposure reality stay here on the board before symbol picking.\n";
   body += "Selected-Symbol Boundary: richer same-symbol dossier readback may exist later, but it remains selected-symbol support and never replaces ordinary board command authority.\n";
   body += ASC_BoardTop5CommittedSnapshotContractLine(bundle,
                                                      full_rows,
                                                      market_board_top5_signature,
                                                      market_board_top5_exact_signature,
                                                      market_board_top5_sync_status) + "\n";
   ASC_BoardAppendBoardChildAlignmentDiagnostic(body,
                                                bundle,
                                                full_rows,
                                                top_ten,
                                                market_board_top5_signature,
                                                market_board_top5_exact_signature,
                                                market_board_top5_sync_status);
   ASC_BoardAppendRun244RecoverySnapshotDiscipline(body, bundle);
   ASC_BoardAppendRun245Top5ChildTransportMap(body, bundle);
   ASC_BoardAppendRun244Top5VisibleCommittedSync(body,
                                                 bundle,
                                                 full_rows,
                                                 market_board_top5_signature,
                                                 market_board_top5_exact_signature,
                                                 market_board_top5_sync_status);
   ASC_BoardAppendRun244SiamUploadSelector(body,
                                           bundle,
                                           top_ten,
                                           market_board_top5_sync_status);
   ASC_BoardAppendRun244BucketCompletionClassifier(body, bundle, full_rows);
   ASC_BoardAppendRun239L3L4Blocks(body,
                                   full_rows,
                                   top_ten,
                                   top_ten_ready);
   ASC_BoardAppendRun237SyncAndCompletionBlocks(body,
                                                 bundle,
                                                 full_rows,
                                                 top_ten,
                                                 market_board_top5_signature,
                                                 market_board_top5_exact_signature,
                                                 market_board_top5_sync_status,
                                                 publication_state,
                                                 top_ten_ready,
                                                 board_body_generated_utc);
   ASC_BoardAppendRun238ExecutionFactsBlocks(body, top_ten);
   body += "Market Board Archive Boundary: archive_enabled=" + (ASC_MARKET_BOARD_ARCHIVE_ENABLED ? "true" : "false") + " | archive_truth_owner=false | archive_is_history_only=true | current_market_board_remains_authority=true | bounded_retention_slots=" + IntegerToString(MathMax(1, ASC_MARKET_BOARD_ARCHIVE_RETENTION_SLOTS)) + " | no_change_skip=true | snapshot_on_change_only=true | timer_pressure_guard=compact_signature_evidence_only\n";
   body += "Cross-Artifact Alignment Boundary: artifact_alignment_scope=market_board | alignment_status=qualified | source_truth=l3_l4 | claim_status=qualified | runtime_observed=false | source_supported=true | trade_permission=false | entry_signal=false | l3_meaning_preserved=true | l4_meaning_preserved=true | l5_support_preserved=not_applicable | resolver_limit_preserved=true | correlation_limit_preserved=" + (correlation_ready ? "true" : "false") + " | current_vs_retained=" + ((summary.is_stale || summary.is_degraded) ? "retained_last_good" : "current") + " | artifact_projection=qualified | contradiction_status=runtime_unproven | contradiction_type=market_board_compression_overclaim | behavior_change=no\n";
   ASC_BoardAppendPublicationSafetySkeleton(body);
   ASC_BoardAppendAccountAndRiskSnapshot(body);
   ASC_BoardAppendPortfolioTruthSnapshot(body, portfolio_snapshot);

   body += "\nDiversified Top 10 Overall\n";
   body += "----------------------------------------\n";
   body += StringFormat("State: %s\n", top_ten_ready ? "Ready" : (ArraySize(top_ten) > 0 ? "Partial" : "Unavailable"));
   body += "Overall View: strongest diversified board across the market; correlated or exposure-conflicted names can be reserved here while bucket leaders remain lawful inside their own top-5 lists.\n";
   if(ArraySize(top_ten) > 0)
     {
      for(int i = 0; i < ArraySize(top_ten); i++)
         ASC_BoardAppendSymbolBlock(body, top_ten[i], "Diversified Top 10 Overall", summary.warmup_ready);
     }
   else
     {
      body += "No lawful diversified overall entries are available for this publish.\n";
      body += StringFormat("Reason: readiness %s | peer support %s | lawful survivors %d\n\n",
                           summary.is_ready ? "ready" : "not_ready",
                           correlation_ready ? "ready" : "not_ready",
                           ArraySize(top_ten));
     }

   string bucket_ids[];
   ASC_BoardBuildMainBucketSectionOrder(full_rows, bucket_ids);

   for(int b = 0; b < ArraySize(bucket_ids); b++)
      ASC_BoardAppendBucketTopFive(body, bucket_ids[b], full_rows, summary.warmup_ready, summary.pass_utc);

   string stock_family_ids[];
   ArrayResize(stock_family_ids, 9);
   stock_family_ids[0] = "us_stocks";
   stock_family_ids[1] = "hk_stocks";
   stock_family_ids[2] = "eu_stocks";
   stock_family_ids[3] = "uk_stocks";
   stock_family_ids[4] = "canada_stocks";
   stock_family_ids[5] = "adr_international";
   stock_family_ids[6] = "etf_etp";
   stock_family_ids[7] = "reit_yield";
   stock_family_ids[8] = "needs_review";

   for(int s = 0; s < ArraySize(stock_family_ids); s++)
     {
      if(!ASC_BoardHasStockFamilyRows(full_rows, stock_family_ids[s]))
         continue;
      ASC_BoardAppendStockFamilyTopFive(body, stock_family_ids[s], full_rows, summary.warmup_ready);
     }

   ASC_BoardAppendConflictAndExposureContext(body, full_rows, top_ten);
   ASC_BoardAppendContradictionProofBoundarySurface(body, full_rows, top_ten, portfolio_snapshot, bundle, correlation_ready);
   ASC_BoardAppendSnapshotTruthTrace(body, summary, bundle, full_rows, summary.warmup_ready);

   string board_publish_result = bundle.board_publish_result;
   bool board_publish_is_fresh = (board_publish_result == "fresh");
   bool board_publish_is_continuity = (board_publish_result == "continuity");
   bool board_publish_is_pending = (board_publish_result == "pending");
   bool board_publish_is_skipped = (board_publish_result == "skipped");
   bool board_publish_is_degraded = (board_publish_result == "degraded");

   datetime board_publish_utc = bundle.board_baseline_confirmed_utc;
   if(board_publish_utc <= 0 && (board_publish_is_fresh || board_publish_is_continuity))
     {
      board_publish_utc = bundle.board_publish_finished_utc;
      if(board_publish_utc <= 0)
         board_publish_utc = bundle.publication_utc;
     }

   string board_publish_utc_text = ASC_ArtifactFormatUtc(board_publish_utc);
   string board_publish_outcome_class = ASC_BoardPublishOutcomeClass(board_publish_result);
   string board_baseline_advance_state = ASC_BoardBaselineAdvanceState(board_publish_result);
   string board_baseline_advance_reason = ASC_BoardBaselineAdvanceReason(board_publish_result,
                                                                         bundle.board_publish_skip_reason);
   string board_publish_reason_trace = ASC_BoardPublishReasonTrace(board_publish_result,
                                                                  bundle.board_refresh_trigger,
                                                                  bundle.board_publish_skip_reason);
   string board_continuity_posture = "board publish status unavailable";
   if(board_publish_is_fresh)
      board_continuity_posture = "current board publish";
   else if(board_publish_is_continuity || bundle.overall_bundle_status == "continuity")
      board_continuity_posture = "retained last-good board remains active";
   else if(bundle.board_publish_result == "unchanged")
      board_continuity_posture = "board baseline was recomputed for this bundle and confirmed unchanged against the last promoted board";
   else if(board_publish_is_skipped)
      board_continuity_posture = (board_publish_utc > 0
                                  ? "current bundle skipped a new board promote; last confirmed board baseline remains active"
                                  : "board baseline publish was skipped for this bundle");
   else if(board_publish_is_pending)
      board_continuity_posture = (board_publish_utc > 0
                                  ? "current bundle is pending a new board promote; last confirmed board baseline remains active"
                                  : "board baseline publish is pending for this bundle");
   else if(board_publish_is_degraded)
      board_continuity_posture = (board_publish_utc > 0
                                  ? "current bundle is degraded; last confirmed board baseline remains active"
                                  : "board baseline publish is degraded for this bundle");
   else if(summary.is_stale)
      board_continuity_posture = "board baseline freshness is delayed";
   else if(summary.is_degraded)
      board_continuity_posture = "board baseline freshness is degraded";

   string board_baseline_publish_text = ASC_ArtifactFormatUtc(board_publish_utc);
   string board_family_publication_text = ASC_ArtifactFormatUtc(bundle.publication_utc);
   string board_family_timing_note = StringFormat("Board baseline publish %s | family publication %s | selected-symbol dossiers and other child artifacts may land at a nearby but different moment without changing Board authority",
                                                  board_baseline_publish_text,
                                                  board_family_publication_text);
   if(bundle.board_publish_result == "unchanged")
      board_family_timing_note = StringFormat("Board baseline remains %s | current bundle recompute %s confirmed no material board change | family publication %s | same-family children remain subordinate to the confirmed Board baseline",
                                              board_baseline_publish_text,
                                              ASC_ArtifactFormatUtc(board_body_generated_utc),
                                              board_family_publication_text);
   else if(board_publish_is_skipped)
      board_family_timing_note = StringFormat("Board baseline retained from %s while this bundle skipped a new board promote | family publication %s | selected-symbol dossiers and other child artifacts remain same-family children and do not overtake Board authority",
                                              board_baseline_publish_text,
                                              board_family_publication_text);
   else if(board_publish_is_pending)
      board_family_timing_note = StringFormat("Board baseline retained from %s while this bundle is still pending a new board promote | family publication %s | selected-symbol dossiers and other child artifacts remain same-family children and do not overtake Board authority",
                                              board_baseline_publish_text,
                                              board_family_publication_text);
   else if(board_publish_is_degraded)
      board_family_timing_note = StringFormat("Board baseline retained from %s while this bundle is degraded | family publication %s | selected-symbol dossiers and other child artifacts remain same-family children and do not overtake Board authority",
                                              board_baseline_publish_text,
                                              board_family_publication_text);
   if(board_publish_utc > 0
      && bundle.publication_utc > 0
      && board_publish_utc == bundle.publication_utc)
      board_family_timing_note = StringFormat("Board baseline publish %s | family publication %s | same-family timing is fully aligned for this bundle",
                                              board_baseline_publish_text,
                                              board_family_publication_text);
   else if(bundle.board_publish_result != "unchanged"
           && !board_publish_is_skipped
           && !board_publish_is_pending
           && !board_publish_is_degraded
           && board_publish_utc <= 0
           && bundle.publication_utc > 0)
      board_family_timing_note = StringFormat("Board baseline publish is still unavailable | family publication %s | selected-symbol dossiers and other child artifacts remain same-family children and do not overtake Board authority",
                                              board_family_publication_text);

   body += "\nBoard Freshness\n";
   body += "----------------------------------------\n";
   body += StringFormat("Board Body Generated UTC: %s\n", ASC_ArtifactFormatUtc(board_body_generated_utc));
   body += StringFormat("Board Baseline Source UTC: %s\n", ASC_ArtifactFormatUtc(board_baseline_source_utc));
   body += StringFormat("Current Board Publish UTC: %s\n", board_publish_utc_text);
   body += StringFormat("Board Continuity Posture: %s\n", board_continuity_posture);
   body += StringFormat("Board Lifecycle State: %s\n", ASC_TextOrUnavailable(bundle.board_lifecycle_state));
   body += StringFormat("Refresh Trigger: %s\n", ASC_TextOrUnavailable(bundle.board_refresh_trigger));
   body += StringFormat("Refresh Requested UTC: %s\n", ASC_ArtifactFormatUtc(bundle.board_refresh_requested_utc));
   body += StringFormat("Refresh Consumed UTC: %s\n", ASC_ArtifactFormatUtc(bundle.board_refresh_consumed_utc));
   body += StringFormat("Recompute Started UTC: %s\n", ASC_ArtifactFormatUtc(bundle.board_recompute_started_utc));
   body += StringFormat("Recompute Finished UTC: %s\n", ASC_ArtifactFormatUtc(bundle.board_recompute_finished_utc));
   body += StringFormat("Publish Started UTC: %s\n", ASC_ArtifactFormatUtc(bundle.board_publish_started_utc));
   body += StringFormat("Publish Finished UTC: %s\n", ASC_ArtifactFormatUtc(bundle.board_publish_finished_utc));
   body += StringFormat("Publish Result: %s\n", ASC_TextOrUnavailable(bundle.board_publish_result));
   body += StringFormat("Publish Outcome Class: %s\n", ASC_ArtifactHumanizeLabel(board_publish_outcome_class));
   body += StringFormat("Publish Reason Trace: %s\n", board_publish_reason_trace);
   body += StringFormat("Publish Decision Identity: trigger=%s | outcome=%s | baseline=%s | lifecycle=%s\n",
                        ASC_TextOrUnavailable(bundle.board_refresh_trigger),
                        ASC_TextOrUnavailable(bundle.board_publish_result),
                        ASC_TextOrUnavailable(board_baseline_advance_state),
                        ASC_TextOrUnavailable(bundle.board_lifecycle_state));
   body += StringFormat("Baseline Advance: %s\n", ASC_ArtifactHumanizeLabel(board_baseline_advance_state));
   body += StringFormat("Baseline Advance Reason: %s\n", board_baseline_advance_reason);
   body += StringFormat("Publish Skip Reason: %s\n", ASC_TextOrUnavailable(bundle.board_publish_skip_reason));
   body += StringFormat("Artifact Family Timing: %s\n", board_family_timing_note);
   body += "Selected-Symbol Family Position: child/support artifacts may be richer, but the Board remains the ordinary-path baseline for promote and command readback\n";
   body += "Dossier Refresh: selected-symbol sync is active; " + ASC_BoardDeepAnalysisLabel() + " readback appears in root Dossier.txt and Dossiers/ support artifacts when available, but selected-symbol deep readback does not displace Board command authority\n";
   body += StringFormat("Dossier Coverage Target: Full Universe (%d symbols)\n", ASC_Layer1CachedSymbolCount());
   body += StringFormat("Dossier Publish Attempted (bundle): %d\n", bundle.dossier_attempted_count);
   body += StringFormat("Dossiers Published (bundle): %d\n", bundle.dossier_success_count);
   body += StringFormat("Dossiers Failed (bundle): %d\n", bundle.dossier_failure_count);
   body += "Phase 5 Permission Context Boundary: " + ASC_Phase5NoSignalBoundaryText() + "\n";
   body += "Phase 5 Source Vocabulary Proof: " + ASC_Phase5SourceReadyProofLine() + "\n";
   body += ASC_Phase5StrategyPermissionBoundaryLine() + "\n";
   body += ASC_Phase5StrategyPermissionGateSummaryLine() + "\n";
   body += ASC_Phase5SiamEdgeGateLine() + "\n";
   body += ASC_Phase6SafetyBoundaryLine() + "\n";
   body += ASC_Phase6SourceReadyProofLine() + "\n";
   body += ASC_Phase6PermissionGateExtensionLine() + "\n";
   body += ASC_Phase6CompatibilityRulesLine() + "\n";
   body += "Phase 6 Regime Compatibility Gate Summary: " + ASC_Phase6RegimeGateWiringSummaryLine() + "\n";
   body += "Phase 6 Regime Permission Surface Gates: unknown/stale/currentness/conflict/sample/liquidity gates limit or block clean permission context; regime label is not signal; no_execution=true\n";
   body += "Phase 6 Closeout Source Lock: " + ASC_Phase6SourceLockSummaryLine() + "\n";
   body += "Phase 7 Session/Timing Review Boundary: " + ASC_Phase7ReviewOnlyBoundaryLine() + "\n";
   body += "Phase 7 Session/Timing Source-Ready: " + ASC_Phase7SourceReadyProofLine() + "\n";
   body += "Phase 7 Session/Timing Permission Extension: " + ASC_Phase7PermissionGateExtensionLine() + "\n";
   body += "Phase 7 Session/Timing Gate Wiring: " + ASC_Phase7GateWiringAggregateLine() + "\n";
   body += "Phase 7 Closeout Source Lock: " + ASC_Phase7SourceLockSummaryLine() + "\n";
   body += "RUN145 Phase 7 Live Contract: " + ASC_Phase7Run145LiveContractSummaryLine() + "\n";
   body += ASC_Phase7CloseoutGateChecklistLine() + "\n";
   body += ASC_Phase6Run140LiveContractSummaryLine() + "\n";
   body += "Claim Evidence: market_board_claim_evidence_enabled=true | market_board_snapshot_currentness=" + ((publication_state == "continuity" || publication_state == "stale") ? "retained_last_good" : "current_or_pending_publish") + " | market_board_to_dossier_lookup_enabled=true | market_board_rank_is_not_trade_signal=true | market_board_lookup_top5_path_policy=Dossiers/Top5PerBucket/<bucket>/<symbol>.txt | market_board_lookup_globaltop10_path_policy=Dossiers/GlobalTop10/<symbol>.txt | market_board_lookup_missing_policy=claim_evidence_pending_or_unavailable_with_owner_next_check | market_board_claim_actionability_policy=ranked_not_actionable_without_current_market_state_and_selected_refresh | market_board_unavailable_claim_policy=explain_why_owner_next_check | currentness_evidence_enabled=true | actionability_evidence_enabled=true | current_live_count=aggregate_runtime_count_in_scanner_status | stale_not_current_count=aggregate_runtime_count_in_scanner_status | retained_last_good_count=aggregate_runtime_count_in_scanner_status | blocked_actionability_count=aggregate_runtime_count_in_scanner_status | unknown_unproven_count=aggregate_runtime_count_in_scanner_status | ranked_not_actionable_without_currentness=true | selected_refresh_required_for_actionability=true | claim_evidence_live_unproven_until_RUN130=true | " + ASC_BoardTraderChatAggregateTokens() + "\n";
   body += ASC_BoardTraderChatPacketBlock(publication_state);
   body += ASC_BoardRetrievalPackBlock();
   body += ASC_BoardFamilyDossierPolicyBlock();
   body += ASC_BoardSelectedCurrentWorkflowBlock();
   body += "Claim Evidence Detail: " + ASC_ClaimEvidenceLine((bundle.dossier_failure_count > 0 ? "unavailable_source_missing" : (bundle.dossier_attempted_count > bundle.dossier_success_count ? "pending_queue" : "available_current")),
                                                             "market_board_to_dossier_lookup",
                                                             "ASC_MarketBoardWriter/ASC_Dispatcher",
                                                             (bundle.dossier_failure_count > 0 ? "one_or_more_companion_dossier_writes_failed" : (bundle.dossier_attempted_count > bundle.dossier_success_count ? "companion_dossier_queue_not_fully_promoted" : "board_and_companion_counts_reported")),
                                                             "next_market_board_publish_or_top5_membership_refresh",
                                                             (bundle.dossier_attempted_count > bundle.dossier_success_count ? "not_current" : "current"),
                                                             false,
                                                             (bundle.dossier_attempted_count > bundle.dossier_success_count ? "wait" : "none"),
                                                             "medium",
                                                             "market_board_lookup_claim_evidence") + "\n";
   body += StringFormat("Bundle Status: %s\n", ASC_TextOrUnavailable(bundle.overall_bundle_status));

   string truth_guard_reason = "ok";
   if(!ASC_BoardPayloadPassesTruthGuard(body, truth_guard_reason))
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_INVALID_ARGUMENT,
                               "Market Board truth-guard validation failed: " + truth_guard_reason,
                               contract.target_path);
      return result;
     }

   int compose_elapsed_ms = (int)((GetMicrosecondCount() - compose_started_us) / 1000);

   string write_state = "pending";
   string write_reason = "pending";
   bool require_correlation_token = (StringFind(body, "Correlation / Exposure:") >= 0);
   ulong publish_started_us = GetMicrosecondCount();
   bool write_ok = ASC_WriteCompanionBoard(contract.target_path,
                                           bundle,
                                           publication_state,
                                           body,
                                           require_correlation_token,
                                           write_state,
                                           write_reason);
   bool board_child_pending = (bundle.dossier_attempted_count > 0
                               && bundle.dossier_success_count + bundle.dossier_failure_count < bundle.dossier_attempted_count);
   if(!write_ok)
     {
      string mb_ce = ASC_MktBoardCEStatus(false,
                                          write_state,
                                          write_reason,
                                          bundle.market_board_status,
                                          bundle.board_publish_result,
                                          board_child_pending);
      ASC_FunctionResultMarkClaimEvidenceStatus(result, mb_ce);
      string fail_detail = ASC_ClaimEvidenceAppend("Failed to publish Market Board artifact: " + write_reason,
                                                   mb_ce,
                                                   ASC_MktBoardCESupport(write_state,
                                                                         write_reason,
                                                                         bundle.market_board_status,
                                                                         bundle.board_publish_result,
                                                                         board_child_pending),
                                                   ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               fail_detail,
                               contract.target_path);
      return result;
     }

   string market_board_archive_state = "not_attempted";
   string market_board_archive_reason = "not_attempted";
   ASC_WriteMarketBoardArchiveSnapshot(server_root,
                                       bundle,
                                       run092_board_signature,
                                       market_board_top5_signature,
                                       market_board_top5_exact_signature,
                                       market_board_top5_sync_status,
                                       write_state,
                                       write_reason,
                                       market_board_archive_state,
                                       market_board_archive_reason);

   ASC_FunctionResultState finish_state = ASC_RESULT_OK;
   string finish_message = "Market Board published with environment reality first, diversified overall Top 10, bucket Top 5 sections, and explicit conflict/correlation context.";
   if(write_state == "continuity")
     {
      finish_state = ASC_RESULT_WARNING;
      finish_message = "branch=market_board_publish | outcome_class=continuity | baseline_advance=preserved | trigger=" + ASC_TextOrUnavailable(bundle.board_refresh_trigger) + " | write_state=" + write_state + " | write_reason=" + write_reason + " | decision=last_good_board_baseline_retained";
     }
   else if(ASC_PublicationReasonIndicatesNoMaterialChange(write_reason))
     {
      finish_message = "branch=market_board_publish | outcome_class=unchanged | baseline_advance=preserved | trigger=" + ASC_TextOrUnavailable(bundle.board_refresh_trigger) + " | write_state=" + write_state + " | write_reason=" + write_reason + " | decision=no_material_change_baseline_retained";
     }
   else
     {
      finish_message = "branch=market_board_publish | outcome_class=fresh | baseline_advance=advanced | trigger=" + ASC_TextOrUnavailable(bundle.board_refresh_trigger) + " | write_state=" + write_state + " | write_reason=" + write_reason + " | decision=new_board_baseline_promoted";
     }

   int publish_elapsed_ms = (int)((GetMicrosecondCount() - publish_started_us) / 1000);
   finish_message += StringFormat(" | perf_compose_ms=%d | perf_publish_ms=%d | perf_artifact_family=board",
                                  compose_elapsed_ms,
                                  publish_elapsed_ms);
   finish_message += " | " + ASC_PortfolioAggregateProofTokens(portfolio_snapshot, "market_board");
   string market_board_publish_status = "published_full";
   if(write_state == "continuity")
      market_board_publish_status = "published_with_section_degraded";
   if(ASC_PortfolioSectionStatusToken(portfolio_snapshot) == "unavailable")
      market_board_publish_status = "published_with_portfolio_unavailable";
   else if(ASC_PortfolioHistorySectionStatusToken(portfolio_snapshot) == "unavailable")
      market_board_publish_status = "published_with_history_unavailable";
   else if(ASC_PortfolioSectionStatusToken(portfolio_snapshot) == "partial" || ASC_PortfolioHistorySectionStatusToken(portfolio_snapshot) == "partial")
      market_board_publish_status = "published_with_section_degraded";

   string market_board_file_write_status = "promoted";
   if(write_state == "continuity")
      market_board_file_write_status = "validated";
   else if(ASC_PublicationReasonIndicatesNoMaterialChange(write_reason))
      market_board_file_write_status = "validated";

   finish_message += StringFormat(" | market_board_publish_status=%s | market_board_publish_scope=functionresults_runtime_publish_outcome | market_board_minimum_skeleton=available | portfolio_section_status=%s | history_section_status=%s | globaltop10_section_status=not_touched | file_write_status=%s | artifact_failure_boundary=fail_soft | source_supported=true | runtime_observed=false | runtime_observed_scope=alignment_contract_not_publish_outcome | runtime_publish_outcome_source=this_functionresults_row | behavior_change=market_board_portfolio_detail_projection_hardening",
                                  market_board_publish_status,
                                  ASC_PortfolioSectionStatusToken(portfolio_snapshot),
                                  ASC_PortfolioHistorySectionStatusToken(portfolio_snapshot),
                                  market_board_file_write_status);
   finish_message += " | top5_market_board_sync=" + ASC_Top5BoardSyncToken(market_board_top5_sync_status) + " | top5_market_board_sync_status=" + ASC_TextOrUnavailable(market_board_top5_sync_status) + " | market_board_to_top5_dossier_sync=" + ASC_Top5BoardSyncToken(market_board_top5_sync_status) + " | market_board_to_top5_dossier_sync_status=" + ASC_TextOrUnavailable(market_board_top5_sync_status) + " | market_board_visible_top5_signature=" + ASC_TextOrUnavailable(market_board_top5_signature) + " | top5_committed_signature=" + ASC_TextOrUnavailable(bundle.top5_bucket_committed_signature);
   finish_message += " | market_board_archive_enabled=" + (ASC_MARKET_BOARD_ARCHIVE_ENABLED ? "true" : "false") + " | market_board_archive_state=" + ASC_TextOrUnavailable(market_board_archive_state) + " | market_board_archive_reason=" + ASC_TextOrUnavailable(market_board_archive_reason) + " | market_board_archive_truth_owner=false | market_board_archive_bounded_retention_slots=" + IntegerToString(MathMax(1, ASC_MARKET_BOARD_ARCHIVE_RETENTION_SLOTS)) + " | market_board_archive_no_change_skip=true";
   finish_message += " | artifact_alignment_scope=market_board | alignment_status=qualified | source_truth=l3_l4 | claim_status=qualified | runtime_observed=false | runtime_observed_scope=alignment_contract_not_publish_outcome | source_supported=true | trade_permission=false | entry_signal=false | l3_meaning_preserved=true | l4_meaning_preserved=true | l5_support_preserved=not_applicable | resolver_limit_preserved=true | correlation_limit_preserved=" + (correlation_ready ? "true" : "false") + " | current_vs_retained=" + (write_state == "continuity" ? "retained_last_good" : "current") + " | artifact_projection=qualified | contradiction_status=runtime_unproven | contradiction_type=market_board_compression_overclaim | behavior_change=no";

   string mb_ce = ASC_MktBoardCEStatus(true,
                                       write_state,
                                       write_reason,
                                       bundle.market_board_status,
                                       bundle.board_publish_result,
                                       board_child_pending);
   ASC_FunctionResultMarkClaimEvidenceStatus(result, mb_ce);
   finish_message = ASC_ClaimEvidenceAppend(finish_message,
                                            mb_ce,
                                            ASC_MktBoardCESupport(write_state,
                                                                  write_reason,
                                                                  bundle.market_board_status,
                                                                  bundle.board_publish_result,
                                                                  board_child_pending),
                                            ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
   finish_message = ASC_MarketBoardEvidenceIntakeDetailAppend(finish_message,
                                                              dominant_market_board_evidence_state,
                                                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN040);
   finish_message += " | market_board_claim_evidence_enabled=true | market_board_snapshot_currentness=" + (write_state == "continuity" ? "retained_last_good" : "current_or_pending_publish") + " | market_board_rank_is_not_trade_signal=true | market_board_to_dossier_lookup_policy=ranked_symbol_requires_matching_selected_or_family_dossier | market_board_unavailable_claim_policy=explain_why_owner_next_check";
   finish_message += StringFormat(" | market_board_evidence_rows=%d | market_board_evidence_clean=%d | market_board_evidence_non_clean=%d | market_board_evidence_unavailable=%d | market_board_evidence_stale=%d | market_board_evidence_insufficient=%d | market_board_evidence_dependency_blocked=%d | market_board_evidence_representative_hits=%d",
                                  ArraySize(top_ten),
                                  market_board_evidence_clean_count,
                                  market_board_evidence_non_clean_count,
                                  market_board_evidence_unavailable_count,
                                  market_board_evidence_stale_count,
                                  market_board_evidence_insufficient_count,
                                  market_board_evidence_dependency_count,
                                  dominant_market_board_evidence_hits);

   ASC_FunctionResultFinish(result,
                            finish_state,
                            ASC_RC_OK,
                            finish_message,
                            contract.target_path);
   return result;
  }

#endif
