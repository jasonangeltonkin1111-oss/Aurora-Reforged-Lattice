#ifndef __ASC_DOSSIERSORTINGINPUTSSECTION_MQH__
#define __ASC_DOSSIERSORTINGINPUTSSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierCandidateFilteringSortingInputsSection(const string spread_gate,
                                                              const string freshness_gate,
                                                              const string state_gate,
                                                              const string liquidity_gate,
                                                              const string volatility_gate,
                                                              const string quality_gate,
                                                              const string sorting_input_notes,
                                                              const bool owner_truth_available,
                                                              const bool gate_context_available,
                                                              ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 7);
   values[0] = spread_gate;
   values[1] = freshness_gate;
   values[2] = state_gate;
   values[3] = liquidity_gate;
   values[4] = volatility_gate;
   values[5] = quality_gate;
   values[6] = sorting_input_notes;

   status_out.section_name = "candidate_filtering_sorting_inputs";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 7 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !gate_context_available)
      status_out.posture = "fallback";
   if(!owner_truth_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s gate_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  gate_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Layer 3 Score Inputs\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Spread / Friction Carry: %s\n", spread_gate);
   section += StringFormat("Snapshot Freshness Carry: %s\n", freshness_gate);
   section += StringFormat("Market-State Carry: %s\n", state_gate);
   section += StringFormat("Quote / Participation Carry: %s\n", liquidity_gate);
   section += StringFormat("Volatility / Regime Carry: %s\n", volatility_gate);
   section += StringFormat("Confidence / Timing Carry: %s\n", quality_gate);
   section += StringFormat("Score Notes: %s\n", sorting_input_notes);
   section += "Score Validity Boundary: candidate_score=support_only | complete_evidence=false | fresh_evidence_when_stale=false | clean_evidence_when_partial_or_unavailable=false | score_formula_change=no\n";
   section += "Phase 8 Candidate Filtering Boundary: " + ASC_Phase8CandidateFilteringReviewBoundaryLine() + " | " + ASC_Phase8CandidateFilteringBlockLimitLine() + " | " + ASC_Phase8CandidateFilteringExplicitReviewStateGateLine() + " | " + ASC_Phase8CandidateFilteringNoExecutionLine() + " | " + ASC_Phase8CandidateFilteringNoDriftLine() + "\n";
   section += "Phase 8 Candidate Filtering Source Lock: " + ASC_Phase8CandidateFilteringSourceReadyLine() + " | " + ASC_Phase8CandidateFilteringRun150ContractLine() + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
