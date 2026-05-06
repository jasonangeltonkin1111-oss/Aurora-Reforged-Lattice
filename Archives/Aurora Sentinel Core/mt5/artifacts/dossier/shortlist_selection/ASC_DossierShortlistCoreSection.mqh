#ifndef __ASC_DOSSIERSHORTLISTCORESECTION_MQH__
#define __ASC_DOSSIERSHORTLISTCORESECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierShortlistCoreSection(const string shortlist_status,
                                            const string shortlist_rank,
                                            const string priority_score,
                                            const string selection_posture,
                                            const string reason_summary,
                                            const string promotion_status,
                                            const bool owner_truth_available,
                                            const bool shortlist_context_available,
                                            ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = shortlist_status;
   values[1] = shortlist_rank;
   values[2] = priority_score;
   values[3] = selection_posture;
   values[4] = reason_summary;
   values[5] = promotion_status;

   status_out.section_name = "shortlist_core";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !shortlist_context_available)
      status_out.posture = "fallback";
   if(!shortlist_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s shortlist_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  shortlist_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Shortlist Selection Board Membership\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Shortlist Status: %s\n", shortlist_status);
   section += StringFormat("Overall / Bucket / Subgroup / Raw Rank: %s\n", shortlist_rank);
   section += StringFormat("Score Stack: %s\n", priority_score);
   section += StringFormat("Board / Membership Posture: %s\n", selection_posture);
   section += StringFormat("Overall-Board Readback: %s\n", reason_summary);
   section += StringFormat("Bucket / Promotion Readback: %s\n", promotion_status);
   section += "Authority Boundary: l4_meaning=shortlist_priority_ordering_only | l4_scope=contextual_priority_support | l3_score_is_support_input_only=true | rank_may_differ_from_raw_l3_score=true | score_vs_rank_mismatch=advisory_only | trade_permission=false | entry_signal=false | execution_permission=false | final_trade_decision=false | strategy_edge_proof=false | l4_not_deep_analysis=true | l5_not_implied_by_rank=true | artifact_projection=projection_only | dossier_l4_projection=consumer_only | writers_do_not_own_l4_truth=true\n";
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "shortlist_core",
                                               "ASC_ShortlistSelectionEngine",
                                               (!owner_truth_available ? "shortlist_owner_truth_unavailable" : (!shortlist_context_available ? "shortlist_context_pending_or_unavailable" : "shortlist_core_owner_reported")),
                                               "next_shortlist_selection_refresh",
                                               "shortlist_core_claim_evidence") + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
