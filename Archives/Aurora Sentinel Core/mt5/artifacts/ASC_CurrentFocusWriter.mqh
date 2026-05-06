#ifndef __ASC_CURRENT_FOCUS_WRITER_MQH__
#define __ASC_CURRENT_FOCUS_WRITER_MQH__

#include "ASC_ArtifactContracts.mqh"
#include "ASC_DossierWriter.mqh"
#include "../logging/ASC_FunctionResults.mqh"
#include "../core/ASC_Constants.mqh"
#include "../core/ASC_ResultCodes.mqh"
#include "../io/ASC_FileIO.mqh"

enum ASC_CurrentFocusPublicationAuthority
  {
   ASC_CURRENT_FOCUS_AUTHORITY_PASSIVE_MIRROR = 0,
   ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER = 30
  };

int ASC_CurrentFocusAuthorityFromPublicationId(const string publication_id)
  {
   if(StringLen(publication_id) <= 0)
      return ASC_CURRENT_FOCUS_AUTHORITY_PASSIVE_MIRROR;
   if(StringFind(publication_id, "deep-focus-") == 0)
      return ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER;
   return ASC_CURRENT_FOCUS_AUTHORITY_PASSIVE_MIRROR;
  }

string ASC_CurrentFocusAuthorityLabel(const int authority)
  {
   if(authority >= ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER)
      return "deep_trigger";
   return "non_publisher_readback_only";
  }

string ASC_CurrentFocusMirrorStateFromPayloadPair(const bool selected_symbol_known,
                                               const bool focus_exists,
                                               const bool focus_matches_selected,
                                               const bool dossier_exists,
                                               const bool dossier_matches_selected,
                                               const bool pair_aligned,
                                               const bool focus_current,
                                               const bool dossier_current,
                                               const string pair_reason)
  {
   if(!selected_symbol_known)
      return "no_selected_symbol";
   if(!focus_exists)
      return "mirror_pending";
   if(!focus_matches_selected || !dossier_matches_selected)
      return "mirror_failed";
   if(StringFind(pair_reason, "retained") >= 0 || StringFind(pair_reason, "continuity") >= 0)
      return "mirror_retained_last_good";
   if(!focus_current || !dossier_current)
      return "mirror_stale";
   if(!pair_aligned)
      return "mirror_degraded";
   return "mirror_current";
  }

string ASC_CurrentFocusMirrorAuditLine(const string selected_symbol,
                                       const string current_focus_symbol,
                                       const string selected_dossier_symbol,
                                       const string mirror_state,
                                       const string pair_reason,
                                       const int mirror_contradiction_count,
                                       const string worst_mirror_contradiction)
  {
   return ASC_ArtifactRun093MirrorContractLine(selected_symbol,
                                               StringLen(selected_symbol) > 0 ? "selected_symbol_known" : "no_selected_symbol",
                                               selected_dossier_symbol,
                                               current_focus_symbol,
                                               mirror_state,
                                               (mirror_state == "mirror_current" ? "complete" : ("runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN)),
                                               (mirror_state == "mirror_current" ? "complete_or_not_requested_from_source" : "pending_or_degraded_or_unproven"),
                                               pair_reason,
                                               mirror_contradiction_count,
                                               worst_mirror_contradiction,
                                               mirror_contradiction_count > 0);
  }

string ASC_CurrentFocusPayloadCanonicalSymbol(const string payload)
  {
   string canonical = ASC_TextExtractLabeledLineValue(payload, "Canonical Symbol:");
   if(StringLen(canonical) > 0)
      return canonical;
   return ASC_TextExtractLabeledLineValue(payload, "Symbol:");
  }

int ASC_CurrentFocusPayloadAuthority(const string payload)
  {
   return ASC_CurrentFocusAuthorityFromPublicationId(ASC_PublicationPayloadId(payload));
  }


bool ASC_CurrentFocusPayloadMatchesSelectedSymbolDirect(const string payload,
                                                       const ASC_Layer1SymbolState &symbol_state,
                                                       const string canonical_symbol_hint)
  {
   if(StringLen(payload) <= 0)
      return false;

   string canonical_symbol = canonical_symbol_hint;
   if(StringLen(canonical_symbol) <= 0)
      canonical_symbol = ASC_CurrentFocusSelectedCanonicalSymbol(symbol_state);

   if(ASC_DossierPayloadMatchesSymbolContext(payload, symbol_state, canonical_symbol))
      return true;

   string payload_symbol = ASC_TextExtractLabeledLineValue(payload, "Symbol:");
   string payload_canonical = ASC_TextExtractLabeledLineValue(payload, "Canonical Symbol:");
   string payload_live_symbol = ASC_CurrentFocusPayloadCanonicalSymbol(payload);

   if(StringLen(payload_live_symbol) > 0 && ASC_DeepSymbolMatchesContext(symbol_state, payload_live_symbol))
      return true;
   if(StringLen(payload_symbol) > 0 && ASC_DeepSymbolMatchesContext(symbol_state, payload_symbol))
      return true;
   if(StringLen(payload_canonical) > 0 && ASC_DeepSymbolMatchesContext(symbol_state, payload_canonical))
      return true;

   if(StringLen(canonical_symbol) > 0 && ASC_DossierPayloadMatchesCanonicalSymbol(payload, canonical_symbol))
      return true;

   ASC_SymbolIdentity selected_symbol_identity = ASC_NormalizeSymbol(symbol_state.symbol);
   ASC_SymbolIdentity canonical_identity = ASC_NormalizeSymbol(canonical_symbol);
   ASC_SymbolIdentity payload_live_identity = ASC_NormalizeSymbol(payload_live_symbol);
   ASC_SymbolIdentity payload_symbol_identity = ASC_NormalizeSymbol(payload_symbol);
   ASC_SymbolIdentity payload_canonical_identity = ASC_NormalizeSymbol(payload_canonical);

   string selected_normalized = selected_symbol_identity.normalized_symbol;
   string canonical_normalized = canonical_identity.normalized_symbol;

   if(StringLen(selected_normalized) > 0)
     {
      if(payload_live_identity.normalized_symbol == selected_normalized
         || payload_symbol_identity.normalized_symbol == selected_normalized
         || payload_canonical_identity.normalized_symbol == selected_normalized)
         return true;
     }

   if(StringLen(canonical_normalized) > 0)
     {
      if(payload_live_identity.normalized_symbol == canonical_normalized
         || payload_symbol_identity.normalized_symbol == canonical_normalized
         || payload_canonical_identity.normalized_symbol == canonical_normalized)
         return true;
     }

   return false;
  }

int ASC_CurrentFocusPayloadVisibleSectionRichness(const string payload)
  {
   if(StringLen(payload) <= 0)
      return 0;

   int richness = 0;
   string headings[] =
     {
      "OPERATOR SNAPSHOT",
      "PUBLICATION HEALTH",
      "SYMBOL IDENTITY [L0]",
      "MARKET STATE [L1]",
      "MARKET WATCH [L2]",
      "TRADING CONDITIONS & CONTRACT [L2]",
      "SESSIONS, SWAP & MARGIN [L2]",
      "CANDIDATE FILTERING [L3]",
      "SHORTLIST SELECTION [L4]",
      "DEEP SELECTIVE ANALYSIS [L5]",
      ASC_DOSSIER_CONTRADICTION_SECTION_NAME,
      "LAYER 6 CURRENT FOCUS SUMMARY",
      "LAYER 6 STRATEGY SURFACE [L6]",
      "Layer 6 Maturity / Trigger Canon",
      "Layer 6 -> Layer 7 Interface"
     };

   for(int i = 0; i < ArraySize(headings); i++)
     {
      if(StringFind(payload, headings[i]) >= 0)
         richness += 10;
     }

   int search_from = 0;
   const string token = "Section Status:";
   while(true)
     {
      int pos = StringFind(payload, token, search_from);
      if(pos < 0)
         break;
      richness += 2;
      search_from = pos + StringLen(token);
     }

   if(ASC_DossierDeepSectionHasCompletedTruth(payload))
      richness += 40;
   else if(StringFind(payload, "DEEP SELECTIVE ANALYSIS [L5]") >= 0)
      richness += 8;

   if(StringFind(payload, ASC_DOSSIER_CONTRADICTION_SECTION_NAME) >= 0)
      richness += 12;
   if(StringFind(payload, "current_focus_mirror_only_if_selected_symbol_exists=true") >= 0)
      richness += 6;
   if(StringFind(payload, "Current Focus Mirror Boundary:") >= 0)
      richness += 14;
   if(StringFind(payload, "current_focus_role=dossier_derivative_mirror") >= 0)
      richness += 8;
   if(StringFind(payload, "current_focus_truth_owner=false") >= 0)
      richness += 4;
   if(StringFind(payload, "current_focus_recomputes_truth=false") >= 0)
      richness += 4;
   if(StringFind(payload, "current_focus_selects_symbol=false") >= 0)
      richness += 4;
   if(StringFind(payload, "selected_symbol_none_status=source_supported_runtime_unobserved") >= 0)
      richness += 4;
   if(StringFind(payload, "same_symbol_readback_required=true") >= 0)
      richness += 4;
   if(StringFind(payload, "cross_symbol_overwrite_forbidden=true") >= 0)
      richness += 4;
   if(StringFind(payload, "source_patched_live_unproven=true") >= 0)
      richness += 4;
   if(StringFind(payload, "source_supported_runtime_unobserved") >= 0)
      richness += 4;
   if(StringFind(payload, "l3_score_support_only") >= 0)
      richness += 3;
   if(StringFind(payload, "l4_rank_support_only") >= 0)
      richness += 3;
   if(StringFind(payload, "l5_deep_support_only") >= 0)
      richness += 3;
   if(StringFind(payload, "active_exposure=open_positions_only") >= 0)
      richness += 3;
   if(StringFind(payload, "future_exposure=pending_orders_only") >= 0)
      richness += 3;
   if(StringFind(payload, "closed_history_context_only=true") >= 0)
      richness += 3;
   if(StringFind(payload, "optional_section_may_block_current_focus=false") >= 0)
      richness += 6;
   if(StringFind(payload, "RUN093 Current Focus Mirror Contract:") >= 0)
      richness += 16;
   if(StringFind(payload, "current_focus_derivative_only=true") >= 0)
      richness += 8;
   if(StringFind(payload, "mirror_state_taxonomy=") >= 0)
      richness += 8;
   if(StringFind(payload, "partial_is_complete=false") >= 0)
      richness += 5;
   if(StringFind(payload, "file_exists_is_mirror_proof=false") >= 0)
      richness += 5;

   if(StringFind(payload, "Consumer Boundary: Layer 6 remains a bounded replay surface") >= 0)
      richness += 4;
   if(StringFind(payload, "Execution Boundary: handoff language is descriptive only") >= 0)
      richness += 4;

   return richness;
  }

bool ASC_CurrentFocusTryGetProtectedCompletedDeepPayload(const string server_root,
                                                         const ASC_Layer1SymbolState &symbol_state,
                                                         const string canonical_symbol_hint,
                                                         string &protected_payload_out,
                                                         string &payload_source_out)
  {
   protected_payload_out = "";
   payload_source_out = "";

   string canonical_symbol = canonical_symbol_hint;
   if(StringLen(canonical_symbol) <= 0)
      canonical_symbol = ASC_CurrentFocusSelectedCanonicalSymbol(symbol_state);

   ASC_ArtifactContract focus_contract = ASC_CurrentFocusContract(server_root);
   string focus_payload = "";
   if(StringLen(focus_contract.target_path) > 0
      && ASC_ReadTextFile(focus_contract.target_path, focus_payload)
      && StringLen(focus_payload) > 0
      && ASC_CurrentFocusPayloadMatchesSelectedSymbolDirect(focus_payload, symbol_state, canonical_symbol)
      && ASC_DossierDeepSectionHasCompletedTruth(focus_payload))
     {
      protected_payload_out = focus_payload;
      payload_source_out = "root_dossier_current_focus";
      return true;
     }

   return false;
  }


bool ASC_CurrentFocusVerifyDirectProtectedReadback(const string server_root,
                                                   const ASC_Layer1SymbolState &symbol_state,
                                                   const string canonical_symbol_hint,
                                                   string &verification_reason)
  {
   verification_reason = "pending";

   string protected_payload = "";
   string payload_source = "";
   if(!ASC_CurrentFocusTryGetProtectedCompletedDeepPayload(server_root,
                                                           symbol_state,
                                                           canonical_symbol_hint,
                                                           protected_payload,
                                                           payload_source))
     {
      verification_reason = "live_root_dossier_current_focus_protected_readback_failed";
      return false;
     }

   verification_reason = "live_root_dossier_current_focus_authority_verified source=" + payload_source;
   return true;
  }

bool ASC_CurrentFocusShouldBlockSameSymbolDowngrade(const string live_payload,
                                                    const string incoming_payload,
                                                    const ASC_Layer1SymbolState &symbol_state,
                                                    const string canonical_symbol,
                                                    const int incoming_authority,
                                                    string &block_reason)
  {
   block_reason = "";
   if(StringLen(live_payload) <= 0 || StringLen(incoming_payload) <= 0)
      return false;

   bool live_same_symbol = ASC_CurrentFocusPayloadMatchesSelectedSymbolDirect(live_payload, symbol_state, canonical_symbol);
   bool incoming_same_symbol = ASC_DossierPayloadMatchesSymbolContext(incoming_payload, symbol_state, canonical_symbol);
   if(!live_same_symbol || !incoming_same_symbol)
      return false;

   int live_authority = ASC_CurrentFocusPayloadAuthority(live_payload);
   bool live_deep_completed = ASC_DossierDeepSectionHasCompletedTruth(live_payload);
   if(live_deep_completed && live_authority < ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER)
      live_authority = ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER;

   bool incoming_deep_completed = ASC_DossierDeepSectionHasCompletedTruth(incoming_payload);
   string incoming_deep_status = ASC_TextExtractLabeledLineValue(incoming_payload, "Deep Analysis Status:");
   string incoming_deep_status_lc = incoming_deep_status;
   StringToLower(incoming_deep_status_lc);

   bool incoming_status_incomplete = (StringLen(incoming_deep_status_lc) <= 0
                                      || StringFind(incoming_deep_status_lc, "not yet available") >= 0
                                      || StringFind(incoming_deep_status_lc, "unavailable") >= 0
                                      || StringFind(incoming_deep_status_lc, "waiting") >= 0
                                      || StringFind(incoming_deep_status_lc, "queued") >= 0
                                      || StringFind(incoming_deep_status_lc, "request-awaiting") >= 0);

   int live_richness = ASC_CurrentFocusPayloadVisibleSectionRichness(live_payload);
   int incoming_richness = ASC_CurrentFocusPayloadVisibleSectionRichness(incoming_payload);
   bool weaker_authority = (incoming_authority < live_authority);
   bool backward_lifecycle = (live_deep_completed && (!incoming_deep_completed || incoming_status_incomplete));
   bool weaker_visible_surface = (incoming_richness < live_richness);

   if(!weaker_authority && !backward_lifecycle && !weaker_visible_surface)
      return false;

   if(weaker_authority && backward_lifecycle && weaker_visible_surface)
      block_reason = StringFormat("weaker_authority_backward_deep_lifecycle_and_lower_visible_richness live=%d incoming=%d",
                                  live_richness,
                                  incoming_richness);
   else if(weaker_authority && backward_lifecycle)
      block_reason = "weaker_authority_and_backward_deep_lifecycle";
   else if(weaker_authority && weaker_visible_surface)
      block_reason = StringFormat("weaker_authority_and_lower_visible_richness live=%d incoming=%d",
                                  live_richness,
                                  incoming_richness);
   else if(backward_lifecycle && weaker_visible_surface)
      block_reason = StringFormat("backward_deep_lifecycle_and_lower_visible_richness live=%d incoming=%d",
                                  live_richness,
                                  incoming_richness);
   else if(weaker_authority)
      block_reason = "weaker_authority";
   else if(backward_lifecycle)
      block_reason = "backward_deep_lifecycle";
   else
      block_reason = StringFormat("lower_visible_richness live=%d incoming=%d",
                                  live_richness,
                                  incoming_richness);
   return true;
  }

string ASC_CurrentFocusSelectedCanonicalSymbol(const ASC_Layer1SymbolState &symbol_state)
  {
   if(StringLen(symbol_state.classification.canonical_symbol) > 0)
      return symbol_state.classification.canonical_symbol;
   if(StringLen(symbol_state.identity.canonical_symbol) > 0)
      return symbol_state.identity.canonical_symbol;
   if(StringLen(symbol_state.identity.normalized_symbol) > 0)
      return symbol_state.identity.normalized_symbol;
   return symbol_state.symbol;
  }

ASC_ArtifactContract ASC_CurrentFocusContract(const string server_root)
  {
   ASC_ArtifactContract contract;
   contract.family = ASC_ARTIFACT_CURRENT_FOCUS;
   contract.artifact_name = "Root Dossier / Current Focus";
   contract.target_path = server_root + "\\" + ASC_CURRENT_FOCUS_FILE;
   contract.publication_state = ASC_PUBLICATION_PENDING;
   return contract;
  }

#endif
