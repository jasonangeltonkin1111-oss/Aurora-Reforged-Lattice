#ifndef __ASC_MARKET_BOARD_PASS10_PROOF_MQH__
#define __ASC_MARKET_BOARD_PASS10_PROOF_MQH__

string ASC_Pass10VerdictLine(const string scenario,const string verdict,const string reason)
  {
   return StringFormat("%s: %s | %s\n", scenario, verdict, ASC_TextOrUnavailable(reason));
  }

string ASC_BuildPass10ProofSummary(const string server_root,
                                  const ASC_Layer1PassSummary &summary,
                                  const ASC_PublicationBundleState &bundle,
                                  const ASC_RuntimeState &runtime,
                                  const string board_tradeability_posture,
                                  const string publication_state)
  {
   string block = "\nPASS 10 Recovery Proof Summary\n";
   block += "----------------------------------------\n";

   string warmup_verdict = "partial";
   string warmup_reason = "warmup-to-ready transition not observed in current beat";
   if(summary.warmup_ready && (summary.is_ready || publication_state == "fresh"))
     {
      warmup_verdict = "valid";
      warmup_reason = StringFormat("warmup_ready=%s readiness=%s board_state=%s",
                                   summary.warmup_ready ? "yes" : "no",
                                   summary.is_ready ? "ready" : "partial",
                                   publication_state);
     }
   else if(!summary.warmup_ready)
      warmup_reason = "warmup is still pending";
   else
      warmup_reason = StringFormat("warmup is ready but board state is %s", publication_state);
   block += ASC_Pass10VerdictLine("warmup_to_ready", warmup_verdict, warmup_reason);

   string manual_exec_verdict = "partial";
   string manual_exec_reason = "manual refresh execution not yet observed";
   string manual_status = runtime.board_manual_refresh_last_status;
   if(manual_status == "published_ready" || manual_status == "published_nonfresh" || manual_status == "published_continuity")
     {
      manual_exec_verdict = "valid";
      manual_exec_reason = runtime.board_manual_refresh_last_reason;
     }
   else if(manual_status == "failed")
     {
      manual_exec_verdict = "failing";
      manual_exec_reason = runtime.board_manual_refresh_last_reason;
     }
   else if(manual_status == "queued" || manual_status == "consumed")
      manual_exec_reason = runtime.board_manual_refresh_last_reason;
   block += ASC_Pass10VerdictLine("manual_refresh_accept_execute", manual_exec_verdict, manual_exec_reason);

   string manual_reject_defer_verdict = "partial";
   string manual_reject_defer_reason = "rejected/deferred scenario not observed in current beat";
   if(manual_status == "rejected" || manual_status == "deferred")
     {
      if(StringLen(runtime.board_manual_refresh_last_reason) > 0)
        {
         manual_reject_defer_verdict = "valid";
         manual_reject_defer_reason = runtime.board_manual_refresh_last_reason;
        }
      else
        {
         manual_reject_defer_verdict = "failing";
         manual_reject_defer_reason = "manual refresh status is rejected/deferred but reason is missing";
        }
     }
   block += ASC_Pass10VerdictLine("manual_refresh_reject_defer_reason", manual_reject_defer_verdict, manual_reject_defer_reason);

   string bundle_verdict = "partial";
   string bundle_reason = "bundle is still pending";
   if(bundle.overall_bundle_status == "published_ready"
      || bundle.overall_bundle_status == "published_partial"
      || bundle.overall_bundle_status == "published_failed"
      || bundle.overall_bundle_status == "published_continuity")
     {
      bundle_verdict = "valid";
      bundle_reason = StringFormat("overall=%s market_board=%s dossiers ok=%d fail=%d",
                                   bundle.overall_bundle_status,
                                   bundle.market_board_status,
                                   bundle.dossier_success_count,
                                   bundle.dossier_failure_count);
     }
   else if(bundle.overall_bundle_status == "waiting_for_packet_support")
     {
      bundle_verdict = "partial";
      bundle_reason = "bundle is waiting for packet support";
     }
   block += ASC_Pass10VerdictLine("bundle_pending_resolution", bundle_verdict, bundle_reason);

   string relation_verdict = "partial";
   string relation_reason = "dossier relation is awaiting runtime publication evidence";
   string runtime_relation = "unavailable";
   if(StringLen(bundle.publication_id) > 0)
     {
      if(bundle.dossier_success_count > 0)
        {
         runtime_relation = "aligned";
         relation_verdict = "valid";
         relation_reason = StringFormat("relation=%s publish_id=%s dossiers_published=%d",
                                        runtime_relation,
                                        bundle.publication_id,
                                        bundle.dossier_success_count);
        }
      else if(bundle.dossier_attempted_count > 0 && bundle.dossier_failure_count > 0)
        {
         runtime_relation = "aligned_intent_unconfirmed";
         relation_reason = StringFormat("dossier publish failures prevent confirmed relation publish_id=%s fail=%d",
                                        bundle.publication_id,
                                        bundle.dossier_failure_count);
        }
      else if(runtime.l1_publish_pending_dossiers)
        {
         runtime_relation = "pending";
         relation_reason = StringFormat("dossier publication pending for publish_id=%s backlog=%d",
                                        bundle.publication_id,
                                        MathMax(0, runtime.dossier_pending_backlog_count));
        }
      else
        {
         runtime_relation = "not_observed";
         relation_reason = StringFormat("no dossier success observed for publish_id=%s in current bundle", bundle.publication_id);
        }
     }
   else
      relation_reason = (StringLen(server_root) > 0)
                        ? "bundle publication id is unavailable"
                        : "runtime output root is unavailable";
   block += ASC_Pass10VerdictLine("board_dossier_revision_relation", relation_verdict, relation_reason);

   string degraded_verdict = "partial";
   string degraded_reason = "degraded-board scenario not active";
   bool degraded_context = (publication_state == "degraded"
                            || publication_state == "stale"
                            || bundle.market_board_status == "degraded"
                            || bundle.board_lifecycle_state == "waiting_for_packet_support"
                            || bundle.board_lifecycle_state == "published_degraded"
                            || StringFind(bundle.overall_bundle_status, "partial") >= 0);
   if(degraded_context)
     {
      if(board_tradeability_posture == "watch_only" || board_tradeability_posture == "research_only")
        {
         degraded_verdict = "valid";
         degraded_reason = StringFormat("posture=%s manual_review=%s",
                                        board_tradeability_posture,
                                        ASC_BoardManualReviewRequired(board_tradeability_posture) ? "yes" : "no");
        }
      else
        {
         degraded_verdict = "failing";
         degraded_reason = StringFormat("degraded context has invalid posture (%s)", board_tradeability_posture);
        }
     }
   block += ASC_Pass10VerdictLine("degraded_board_watch_research_only", degraded_verdict, degraded_reason);

   string missed_verdict = "partial";
   string missed_reason = "no missed auto-refresh deadline is currently active";
   if(runtime.market_board_auto_refresh_deadline_missed)
     {
      if(runtime.market_board_auto_refresh_missed_since_utc > 0
         && StringLen(runtime.market_board_auto_refresh_miss_reason) > 0)
        {
         missed_verdict = "valid";
         missed_reason = StringFormat("missed_since=%s reason=%s",
                                      ASC_ArtifactFormatUtc(runtime.market_board_auto_refresh_missed_since_utc),
                                      runtime.market_board_auto_refresh_miss_reason);
        }
      else
        {
         missed_verdict = "failing";
         missed_reason = "deadline missed flag is set but timing/reason evidence is incomplete";
        }
     }
   else if(runtime.market_board_next_auto_refresh_due_utc <= 0)
      missed_reason = "next auto-refresh due is unobserved";
   block += ASC_Pass10VerdictLine("missed_auto_refresh_visible", missed_verdict, missed_reason);

   return block;
  }

#endif
