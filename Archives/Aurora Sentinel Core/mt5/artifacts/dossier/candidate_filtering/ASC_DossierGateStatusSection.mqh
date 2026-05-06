#ifndef __ASC_DOSSIERGATESTATUSSECTION_MQH__
#define __ASC_DOSSIERGATESTATUSSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierCandidateFilteringGateStatusSection(const string filter_state,
                                                           const string eligibility_status,
                                                           const string gate_freshness,
                                                           const string reason_summary,
                                                           const string decision_confidence,
                                                           const bool owner_truth_available,
                                                           const bool freshness_available,
                                                           const bool freshness_degraded,
                                                           ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = filter_state;
   values[1] = eligibility_status;
   values[2] = gate_freshness;
   values[3] = reason_summary;
   values[4] = decision_confidence;

   status_out.section_name = "candidate_filtering_gate_status";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = freshness_degraded;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !freshness_available)
      status_out.posture = "fallback";
   if(freshness_degraded)
      status_out.posture = "degraded";
   if(!owner_truth_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s freshness_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  freshness_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Candidate Score & Eligibility\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Candidate State: %s\n", filter_state);
   section += StringFormat("Readiness Posture: %s\n", eligibility_status);
   section += StringFormat("Evidence Freshness: %s\n", gate_freshness);
   section += StringFormat("Score / Context Summary: %s\n", reason_summary);
   section += StringFormat("Decision Confidence: %s\n", decision_confidence);
   section += "L3 Meaning Boundary: l3_meaning=candidate_ranking_support_only | l3_scope=lightweight_candidate_support | source_owner=Candidate Filtering | artifact_projection=projection_only | dossier_l3_projection=consumer_only\n";
   section += "Falsehood Boundary: trade_permission=false | entry_signal=false | execution_permission=false | final_rank=false | strategy_edge_proof=false | writers_do_not_own_l3_truth=true\n";
   section += "Phase 8 Candidate Filtering Boundary: " + ASC_Phase8CandidateFilteringReviewBoundaryLine() + " | " + ASC_Phase8CandidateFilteringBlockLimitLine() + " | " + ASC_Phase8CandidateFilteringExplicitReviewStateGateLine() + " | " + ASC_Phase8CandidateFilteringNoExecutionLine() + " | " + ASC_Phase8CandidateFilteringNoDriftLine() + "\n";
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "candidate_filtering_gate_status",
                                               "ASC_SelectionFilter",
                                               (!owner_truth_available ? "candidate_filtering_owner_truth_unavailable" : (!freshness_available ? "candidate_filtering_freshness_unavailable" : (freshness_degraded ? "candidate_filtering_freshness_degraded" : "candidate_filtering_gate_owner_reported"))),
                                               "next_candidate_filtering_refresh",
                                               "candidate_gate_status_claim_evidence") + "\n";
   section += "Phase 8 Candidate Filtering Source Lock: " + ASC_Phase8CandidateFilteringSourceReadyLine() + " | " + ASC_Phase8CandidateFilteringRun150ContractLine() + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
