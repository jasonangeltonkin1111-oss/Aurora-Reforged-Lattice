#ifndef __ASC_DOSSIER_DEEP_ACTIVATION_COVERAGE_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_ACTIVATION_COVERAGE_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierDeepActivationCoverageSection(const string deep_status_line,
                                                     const bool deep_completed,
                                                     const bool deep_preserved,
                                                     const bool shortlist_ranked,
                                                     const int shortlist_rank,
                                                     const bool normal_path_shell_only)
  {
   string activation_state = deep_completed ? "completed" : "awaiting completion";
   string preservation_state = deep_preserved ? "preserved" : "not preserved";
   string shortlist_state = shortlist_ranked ? StringFormat("ranked (rank %d)", shortlist_rank) : "not ranked";

   string section = "------------------------------------------------------------------------------\n";
   section += "Activation & Coverage\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Deep Status: %s\n", deep_status_line);
   section += StringFormat("Deep Completion State: %s\n", activation_state);
   section += StringFormat("Preservation State: %s\n", preservation_state);
   section += StringFormat("Shortlist State: %s\n", shortlist_state);
   section += StringFormat("Normal Path Shell Policy: %s\n", normal_path_shell_only ? "shell-first" : "payload-admissible");
   section += "Claim Evidence: dossier_section_claim_evidence_enabled=true | claim_subject=deep_selective_analysis_activation | section_is_trade_signal=false | diagnostic_is_actionable=false | deep_pending_is_not_rank_failure=true\n";
   section += "Claim Evidence Detail: " + ASC_ClaimEvidenceLine((deep_completed ? "available_current" : (deep_preserved ? "retained_last_good" : "pending_queue")),
                                                               "deep_selective_analysis_activation",
                                                               "ASC_DeepSelectiveAnalysisEngine",
                                                               (deep_completed ? "deep_payload_completed" : (deep_preserved ? "deep_payload_preserved_last_good" : "deep_payload_awaiting_selected_or_deep_trigger")),
                                                               "selected_symbol_deep_analysis_or_RUN125_live_proof",
                                                               (deep_completed ? "current" : (deep_preserved ? "retained_historical_not_current" : "pending_not_current")),
                                                               !deep_completed,
                                                               (deep_completed ? "none" : "select_symbol_or_wait"),
                                                               "medium",
                                                               "deep_activation_claim_evidence") + "\n";
   section += "\n";
   return section;
  }

#endif
