#ifndef __ASC_DOSSIERSESSIONSSECTION_MQH__
#define __ASC_DOSSIERSESSIONSSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierSessionsSection(const string quote_session_status,
                                       const string trade_session_status,
                                       const string quote_sessions,
                                       const string trade_sessions,
                                       const string session_notes,
                                       const bool session_state_available,
                                       const bool schedule_detail_available,
                                       ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = quote_session_status;
   values[1] = trade_session_status;
   values[2] = quote_sessions;
   values[3] = trade_sessions;
   values[4] = session_notes;

   status_out.section_name = "sessions";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !session_state_available || !schedule_detail_available)
      status_out.posture = "fallback";
   if(!session_state_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("session_state_available=%s schedule_detail_available=%s",
                                  session_state_available ? "yes" : "no",
                                  schedule_detail_available ? "yes" : "no");

   string quote_session_token = ASC_DossierNormalizeTokenText(quote_session_status);
   string trade_session_token = ASC_DossierNormalizeTokenText(trade_session_status);
   bool quote_session_closed = (StringFind(quote_session_token, "closed") >= 0);
   bool trade_session_closed = (StringFind(trade_session_token, "closed") >= 0);
   bool session_blocks_actionability = !session_state_available || quote_session_closed || trade_session_closed;
   string session_currentness = ASC_DossierCurrentnessFromEvidence(session_state_available && schedule_detail_available && !session_blocks_actionability,
                                                                 false,
                                                                 false,
                                                                 !schedule_detail_available,
                                                                 !session_state_available,
                                                                 quote_session_closed || trade_session_closed,
                                                                 !session_state_available);

   string section = "------------------------------------------------------------------------------\n";
   section += "Sessions\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Quote Session Status: %s\n", quote_session_status);
   section += StringFormat("Trade Session Status: %s\n", trade_session_status);
   section += StringFormat("Quote Sessions: %s\n", quote_sessions);
   section += StringFormat("Trade Sessions: %s\n", trade_sessions);
   section += StringFormat("Session Notes: %s\n", session_notes);
   section += "session_currentness=" + session_currentness + " | quote_session_state=" + ASC_TextOrUnavailable(quote_session_status) + " | trade_session_state=" + ASC_TextOrUnavailable(trade_session_status) + " | tradeability_owner=ASC_OpenSymbolSnapshotEngine/SymbolInfoSessionQuote/SymbolInfoSessionTrade | session_actionability_block=" + (session_blocks_actionability ? "true" : "false") + " | tradeability_next_check=next_open_symbol_snapshot_refresh\n";
   section += ASC_DossierActionabilityImpactLine("session",
                                                 session_currentness,
                                                 "ASC_OpenSymbolSnapshotEngine/SymbolInfoSessionQuote/SymbolInfoSessionTrade",
                                                 session_notes,
                                                 "next_open_symbol_snapshot_refresh",
                                                 session_blocks_actionability) + "\n";
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "sessions",
                                               "ASC_OpenSymbolSnapshotEngine/SymbolInfoSessionQuote/SymbolInfoSessionTrade",
                                               session_notes,
                                               "next_open_symbol_snapshot_refresh",
                                               "session_tradeability_currentness_claim_evidence") + "\n";
   section += "phase7_child_surface=boundary_only | phase7_symbol_gate_detail=pending_hydration | session_label_is_not_signal=true | timing_label_is_not_entry=true | session_timing_context_review_only=true | session_timing_evidence_required=true | stale_or_missing_timing_blocks_clean_review=true | session_closed_or_unknown_limits_review=true | run147_phase7_child_surface_finalized=true\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
