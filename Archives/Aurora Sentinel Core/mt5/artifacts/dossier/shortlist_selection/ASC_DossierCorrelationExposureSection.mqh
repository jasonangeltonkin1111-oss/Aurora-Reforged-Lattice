#ifndef __ASC_DOSSIERCORRELATIONEXPOSURESECTION_MQH__
#define __ASC_DOSSIERCORRELATIONEXPOSURESECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierShortlistCorrelationExposureSection(const string peer_similarity_score,
                                                           const string highest_correlations,
                                                           const string lowest_correlations,
                                                           const string exposure_conflict_status,
                                                           const string open_pending_conflict_notes,
                                                           const string portfolio_conflict_notes,
                                                           const bool owner_truth_available,
                                                           const bool peer_exposure_context_available,
                                                           ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = peer_similarity_score;
   values[1] = highest_correlations;
   values[2] = lowest_correlations;
   values[3] = exposure_conflict_status;
   values[4] = open_pending_conflict_notes;
   values[5] = portfolio_conflict_notes;

   status_out.section_name = "shortlist_peer_similarity_exposure";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !peer_exposure_context_available)
      status_out.posture = "fallback";
   if(!peer_exposure_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s peer_exposure_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  peer_exposure_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Peer Similarity & Exposure\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Peer Similarity Score: %s\n", peer_similarity_score);
   section += StringFormat("Closest Peers: %s\n", highest_correlations);
   section += StringFormat("Farthest Peers: %s\n", lowest_correlations);
   section += "Exposure Snapshot\n";
   section += StringFormat("Exposure Conflict Status: %s\n", exposure_conflict_status);
   section += StringFormat("Open / Pending Conflict Notes: %s\n", open_pending_conflict_notes);
   section += StringFormat("Portfolio Conflict Notes: %s\n", portfolio_conflict_notes);
   section += "Exposure Boundary: correlation_status=projection_support_only | correlation_not_available_if_unproven=true | open_positions_are_active_exposure=true | pending_orders_are_future_exposure=true | closed_history_context_only=true | closed_history_not_active_exposure=true | exposure_status=limitation_support_only | trade_permission=false | entry_signal=false | execution_permission=false | artifact_projection=projection_only\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
