#ifndef __ASC_DOSSIERBLOCKERSDEPENDENCIESSECTION_MQH__
#define __ASC_DOSSIERBLOCKERSDEPENDENCIESSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierCandidateFilteringBlockersDependenciesSection(const string disqualifiers,
                                                                     const string dependencies,
                                                                     const string missing_confirmation,
                                                                     const string next_required_step,
                                                                     const string constraint_notes,
                                                                     const bool owner_truth_available,
                                                                     const bool blocker_dependency_context_available,
                                                                     ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = disqualifiers;
   values[1] = dependencies;
   values[2] = missing_confirmation;
   values[3] = next_required_step;
   values[4] = constraint_notes;

   status_out.section_name = "candidate_filtering_blockers_dependencies";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !blocker_dependency_context_available)
      status_out.posture = "fallback";
   if(!owner_truth_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s blocker_dependency_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  blocker_dependency_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Dependencies & Current Friction\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Current Friction: %s\n", disqualifiers);
   section += StringFormat("Required Dependencies: %s\n", dependencies);
   section += StringFormat("Corroboration State: %s\n", missing_confirmation);
   section += StringFormat("Next Evidence Step: %s\n", next_required_step);
   section += StringFormat("Constraint Notes: %s\n", constraint_notes);
   section += "Dependency Boundary: unavailable_or_partial_inputs_must_remain_labelled | unavailable_is_not_clean_truth=true | recovery_status=source_owned_by_candidate_filtering\n";
   section += "Phase 8 Candidate Filtering Boundary: " + ASC_Phase8CandidateFilteringReviewBoundaryLine() + " | " + ASC_Phase8CandidateFilteringBlockLimitLine() + " | " + ASC_Phase8CandidateFilteringExplicitReviewStateGateLine() + " | " + ASC_Phase8CandidateFilteringNoExecutionLine() + " | " + ASC_Phase8CandidateFilteringNoDriftLine() + "\n";
   section += "Phase 8 Candidate Filtering Source Lock: " + ASC_Phase8CandidateFilteringSourceReadyLine() + " | " + ASC_Phase8CandidateFilteringRun150ContractLine() + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
