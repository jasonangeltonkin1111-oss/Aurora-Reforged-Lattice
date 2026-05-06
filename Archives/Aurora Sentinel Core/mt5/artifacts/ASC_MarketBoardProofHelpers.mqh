#ifndef __ASC_MARKET_BOARD_PROOF_HELPERS_MQH__
#define __ASC_MARKET_BOARD_PROOF_HELPERS_MQH__

#include "../core/ASC_RuntimeState.mqh"
#include "ASC_ArtifactTextHelpers.mqh"

string ASC_ProofNormalizeStatus(const string status_in)
  {
   string status = status_in;
   StringToLower(status);
   if(status == "valid" || status == "partial" || status == "failing")
      return status;
   return "partial";
  }

string ASC_ProofScenarioLine(const string label,
                             const string status_in,
                             const string reason)
  {
   string status = ASC_ProofNormalizeStatus(status_in);
   string detail = reason;
   if(StringLen(detail) <= 0)
      detail = "no detail provided";
   return StringFormat("- %s: %s | %s\n", label, status, detail);
  }

string ASC_ProofWarmupReadyStatus(const ASC_RuntimeState &state,
                                  string &reason_out)
  {
   bool warmup_observed = (state.l1_warmup_ready
                           || state.l1_bootstrap_completed_utc > 0
                           || state.l1_bootstrap_pass_counter > 0);
   if(state.l1_warmup_ready && state.l1_ready)
     {
      reason_out = StringFormat("warmup readiness landed and runtime is ready | bootstrap completed %s | posture %s",
                                ASC_ArtifactFormatUtc(state.l1_bootstrap_completed_utc),
                                ASC_TextOrUnavailable(state.l1_readiness_posture));
      return "valid";
     }

   if(warmup_observed)
     {
      reason_out = StringFormat("warmup evidence exists but runtime is not fully ready yet | warmup_ready=%s | ready=%s | posture %s",
                                state.l1_warmup_ready ? "yes" : "no",
                                state.l1_ready ? "yes" : "no",
                                ASC_TextOrUnavailable(state.l1_readiness_posture));
      return "partial";
     }

   reason_out = "runtime has not yet exposed a completed warmup/ready transition";
   return "failing";
  }

string ASC_ProofManualRefreshAcceptedExecutedStatus(const ASC_RuntimeState &state,
                                                    const ASC_PublicationBundleState &bundle,
                                                    string &reason_out)
  {
   string status = state.board_manual_refresh_last_status;
   StringToLower(status);

   if(status == "published_ready"
      || status == "published_nonfresh"
      || status == "published_continuity"
      || status == "failed")
     {
      reason_out = StringFormat("last served status %s | lifecycle %s | publish result %s",
                                ASC_TextOrUnavailable(state.board_manual_refresh_last_status),
                                ASC_TextOrUnavailable(bundle.board_lifecycle_state),
                                ASC_TextOrUnavailable(bundle.board_publish_result));
      return "valid";
     }

   if(status == "consumed")
     {
      reason_out = "manual refresh was admitted into the write lane and is awaiting final publication outcome";
      return "partial";
     }

   if(status == "deferred" || status == "rejected")
     {
      reason_out = state.board_manual_refresh_last_reason;
      return "failing";
     }

   reason_out = "no executed manual refresh outcome has been observed yet";
   return "failing";
  }

string ASC_ProofManualRefreshRejectedDeferredStatus(const ASC_RuntimeState &state,
                                                    string &reason_out)
  {
   string status = state.board_manual_refresh_last_status;
   StringToLower(status);

   if(status == "rejected" || status == "deferred")
     {
      if(StringLen(state.board_manual_refresh_last_reason) > 0)
        {
         reason_out = state.board_manual_refresh_last_reason;
         return "valid";
        }
      reason_out = "manual refresh rejection/defer status exists but runtime reason is missing";
      return "partial";
     }

   if(StringLen(status) <= 0 || status == "idle")
     {
      reason_out = "no rejected/deferred manual refresh has been observed in current runtime truth";
      return "partial";
     }

   reason_out = StringFormat("latest manual refresh path is %s, not rejected/deferred",
                             ASC_TextOrUnavailable(state.board_manual_refresh_last_status));
   return "failing";
  }

string ASC_ProofBundleTruthStatus(const ASC_RuntimeState &state,
                                  const ASC_PublicationBundleState &bundle,
                                  string &reason_out)
  {
   bool pending_work = (state.l2_publish_pending
                        || state.l1_publish_pending_essentials
                        || state.l1_publish_pending_dossiers
                        || state.l1_publish_pending_manifest);

   string overall = bundle.overall_bundle_status;
   StringToLower(overall);

   bool valid_pending = (pending_work
                         && (overall == "publishing"
                             || overall == "published_partial"
                             || overall == "waiting_for_packet_support"));
   bool valid_resolved = (!pending_work
                          && (overall == "published_ready"
                              || overall == "published_partial"
                              || overall == "published_continuity"
                              || overall == "published_failed"));

   if(valid_pending || valid_resolved)
     {
      reason_out = StringFormat("overall=%s | pending_work=%s | board=%s | dossiers pending=%s | manifest=%s",
                                ASC_TextOrUnavailable(bundle.overall_bundle_status),
                                pending_work ? "yes" : "no",
                                ASC_TextOrUnavailable(bundle.market_board_status),
                                state.l1_publish_pending_dossiers ? "yes" : "no",
                                state.l1_publish_pending_manifest ? "yes" : "no");
      return "valid";
     }

   if(overall == "idle" && !pending_work)
     {
      reason_out = "bundle is idle with no pending publication work";
      return "partial";
     }

   reason_out = StringFormat("bundle status/pending-work mismatch | overall=%s | pending_work=%s",
                             ASC_TextOrUnavailable(bundle.overall_bundle_status),
                             pending_work ? "yes" : "no");
   return "failing";
  }

string ASC_ProofBoardDossierAlignmentStatus(const ASC_RuntimeState &state,
                                            const ASC_PublicationBundleState &bundle,
                                            string &reason_out)
  {
   bool revision_aligned = (state.market_board_last_published_l3_revision == state.publication_shortlist_source_l3_revision
                            && state.market_board_last_published_l4_revision == state.publication_shortlist_source_l4_revision
                            && state.market_board_last_published_l4_revision > 0);
   bool publish_recorded = (state.market_board_last_publish_utc > 0
                            || bundle.board_publish_finished_utc > 0);
   bool bundle_has_id = (StringLen(bundle.publication_id) > 0);

   if(revision_aligned && publish_recorded && bundle_has_id)
     {
      reason_out = StringFormat("runtime publish ledger aligns with bundle publication id %s and shortlist source revisions L3=%I64u L4=%I64u",
                                bundle.publication_id,
                                state.market_board_last_published_l3_revision,
                                state.market_board_last_published_l4_revision);
      return "valid";
     }

   if(revision_aligned)
     {
      reason_out = StringFormat("runtime revisions align but publish ledger is still incomplete | bundle id %s | publish recorded=%s",
                                ASC_TextOrUnavailable(bundle.publication_id),
                                publish_recorded ? "yes" : "no");
      return "partial";
     }

   bool startup_pending = (!publish_recorded
                           && state.market_board_last_published_l4_revision <= 0
                           && state.publication_shortlist_source_l4_revision <= 0);
   if(startup_pending)
     {
      reason_out = "alignment truth is pending initial publish/revision landing";
      return "partial";
     }

   reason_out = StringFormat("runtime revision mismatch | board L3/L4=%I64u/%I64u | shortlist source L3/L4=%I64u/%I64u | bundle id %s",
                                state.market_board_last_published_l3_revision,
                                state.market_board_last_published_l4_revision,
                                state.publication_shortlist_source_l3_revision,
                                state.publication_shortlist_source_l4_revision,
                                ASC_TextOrUnavailable(bundle.publication_id));
   return "failing";
  }

string ASC_ProofDegradedModePostureStatus(const ASC_PublicationBundleState &bundle,
                                          const string board_tradeability_posture,
                                          const bool command_authority_ready,
                                          const bool manual_review_required,
                                          const string manual_review_reason,
                                          string &reason_out)
  {
   string posture = board_tradeability_posture;
   StringToLower(posture);
   bool degraded_now = (bundle.market_board_status == "degraded"
                        || bundle.market_board_status == "continuity"
                        || bundle.board_lifecycle_state == "published_degraded"
                        || bundle.board_lifecycle_state == "published_with_stale_or_degraded_truth"
                        || bundle.board_lifecycle_state == "waiting_for_packet_support");

   if(!degraded_now)
     {
      reason_out = "board is not currently in a degraded/stale publication posture";
      return "partial";
     }

   bool posture_valid = ((posture == "watch_only" || posture == "research_only")
                         && !command_authority_ready
                         && manual_review_required);

   if(posture_valid)
     {
      reason_out = StringFormat("degraded board forces posture %s | manual review required | %s",
                                posture,
                                ASC_TextOrUnavailable(manual_review_reason));
      return "valid";
     }

   reason_out = StringFormat("degraded board posture mismatch | posture=%s | command_authority_ready=%s | manual_review_required=%s",
                             ASC_TextOrUnavailable(board_tradeability_posture),
                             command_authority_ready ? "yes" : "no",
                             manual_review_required ? "yes" : "no");
   return "failing";
  }

string ASC_ProofAutoRefreshMissStatus(const ASC_RuntimeState &state,
                                      string &reason_out)
  {
   if(state.market_board_auto_refresh_deadline_missed)
     {
      if(state.market_board_auto_refresh_missed_since_utc > 0
         && StringLen(state.market_board_auto_refresh_miss_reason) > 0
         && state.market_board_auto_refresh_miss_reason != "none")
        {
         reason_out = StringFormat("miss detected since %s | due %s | reason %s",
                                   ASC_ArtifactFormatUtc(state.market_board_auto_refresh_missed_since_utc),
                                   ASC_ArtifactFormatUtc(state.market_board_next_auto_refresh_due_utc),
                                   state.market_board_auto_refresh_miss_reason);
         return "valid";
        }

      reason_out = "deadline miss flag is raised but missed-since/reason fields are incomplete";
      return "partial";
     }

   if(state.market_board_next_auto_refresh_due_utc > 0
      && state.market_board_last_auto_refresh_success_utc > 0)
     {
      reason_out = StringFormat("auto-refresh timing is exposed and currently not missed | last success %s | next due %s",
                                ASC_ArtifactFormatUtc(state.market_board_last_auto_refresh_success_utc),
                                ASC_ArtifactFormatUtc(state.market_board_next_auto_refresh_due_utc));
      return "partial";
     }

   reason_out = "auto-refresh cadence truth has not fully initialized yet";
   return "failing";
  }

string ASC_BuildMarketBoardProofSummary(const ASC_RuntimeState &state,
                                        const ASC_PublicationBundleState &bundle,
                                        const string board_tradeability_posture,
                                        const bool command_authority_ready,
                                        const bool manual_review_required,
                                        const string manual_review_reason)
  {
   string reason = "";
   string body = "Recovery Proof Summary\n";
   body += "----------------------------------------\n";
   body += ASC_ProofScenarioLine("1. warmup -> ready transition",
                                 ASC_ProofWarmupReadyStatus(state, reason),
                                 reason);
   body += ASC_ProofScenarioLine("2. manual refresh accepted + executed",
                                 ASC_ProofManualRefreshAcceptedExecutedStatus(state, bundle, reason),
                                 reason);
   body += ASC_ProofScenarioLine("3. manual refresh rejected/deferred with reason",
                                 ASC_ProofManualRefreshRejectedDeferredStatus(state, reason),
                                 reason);
   body += ASC_ProofScenarioLine("4. bundle pending -> resolved / partial / failed truth",
                                 ASC_ProofBundleTruthStatus(state, bundle, reason),
                                 reason);
   body += ASC_ProofScenarioLine("5. board vs dossier revision alignment",
                                 ASC_ProofBoardDossierAlignmentStatus(state, bundle, reason),
                                 reason);
   body += ASC_ProofScenarioLine("6. degraded board posture forces watch_only / research_only",
                                 ASC_ProofDegradedModePostureStatus(bundle,
                                                                    board_tradeability_posture,
                                                                    command_authority_ready,
                                                                    manual_review_required,
                                                                    manual_review_reason,
                                                                    reason),
                                 reason);
   body += ASC_ProofScenarioLine("7. missed auto-refresh detected and exposed",
                                 ASC_ProofAutoRefreshMissStatus(state, reason),
                                 reason);
   body += "\n";
   return body;
  }

#endif
