#ifndef __ASC_SYMBOL_DATA_PACK_COMPOSER_MQH__
#define __ASC_SYMBOL_DATA_PACK_COMPOSER_MQH__

#include "ASC_SymbolDataPackRouting.mqh"
#include "../../core/ASC_Types.mqh"
#include "../../symbols/ASC_ClassificationBridge.mqh"
#include "../../symbols/ASC_SymbolSpecification.mqh"
#include "../../core/ASC_RuntimeState.mqh"

// RUN162R composition foundation. It creates a factual layout, route map, section freshness contract,
// researched depth/window contract, and atomic publication contract only.
// No live market values are generated here.


// RUN247: runtime-owned L3/L4 transport override bridge.
// These strings are prepared by the writer from ASC_RuntimeState immediately before compose.
// The composer still only emits source-owned facts; it does not calculate L3/L4 score, rank, membership, or signatures.
bool g_asc_sdp_run247_runtime_join_override_active = false;
string g_asc_sdp_run247_runtime_join_map_override = "";
string g_asc_sdp_run247_owner_map_override = "";
string g_asc_sdp_run247_context_override = "";
string g_asc_sdp_run247_review_readiness_override = "";

void ASC_SymbolDataPackRun247ClearRuntimeOverrides()
  {
   g_asc_sdp_run247_runtime_join_override_active = false;
   g_asc_sdp_run247_runtime_join_map_override = "";
   g_asc_sdp_run247_owner_map_override = "";
   g_asc_sdp_run247_context_override = "";
   g_asc_sdp_run247_review_readiness_override = "";
  }

string ASC_SymbolDataPackRun247BoolText(const bool value)
  {
   return value ? "true" : "false";
  }

string ASC_SymbolDataPackRun247IntText(const int value)
  {
   return (value > 0 ? IntegerToString(value) : "unavailable");
  }

string ASC_SymbolDataPackRun247UlongText(const ulong value)
  {
   return (value > 0 ? StringFormat("%I64u", value) : "unavailable");
  }

string ASC_SymbolDataPackRun247UtcText(const datetime value)
  {
   return (value > 0 ? TimeToString(value, TIME_DATE | TIME_SECONDS) : "unknown");
  }

string ASC_SymbolDataPackRun247TextOrUnknown(const string value)
  {
   string v = value;
   StringTrimLeft(v);
   StringTrimRight(v);
   return (StringLen(v) > 0 ? v : "unknown");
  }

bool ASC_SymbolDataPackRun247SymbolEquals(const string a,const string b)
  {
   if(StringLen(a) <= 0 || StringLen(b) <= 0)
      return false;
   return (a == b);
  }

bool ASC_SymbolDataPackRun247CommittedL3Matches(const ASC_CommittedLayer3SymbolState &row,
                                                const string exact_broker_symbol,
                                                const string canonical_symbol_id,
                                                string &match_key_out)
  {
   match_key_out = "none";
   if(ASC_SymbolDataPackRun247SymbolEquals(row.symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:row.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.canonical_symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:row.canonical_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:row.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.canonical_symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:row.canonical_symbol";
      return true;
     }
   return false;
  }

bool ASC_SymbolDataPackRun247ShortlistMatches(const ASC_ShortlistSymbolSummary &row,
                                              const string exact_broker_symbol,
                                              const string canonical_symbol_id,
                                              string &match_key_out)
  {
   match_key_out = "none";
   if(ASC_SymbolDataPackRun247SymbolEquals(row.symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:summary.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:state.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.identity.normalized_symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:state.identity.normalized_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.identity.canonical_symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:state.identity.canonical_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.classification.canonical_symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:state.classification.canonical_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:summary.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:state.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.identity.normalized_symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:state.identity.normalized_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.identity.canonical_symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:state.identity.canonical_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.state.classification.canonical_symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:state.classification.canonical_symbol";
      return true;
     }
   return false;
  }

bool ASC_SymbolDataPackRun247CommittedL4Matches(const ASC_CommittedLayer4SymbolState &row,
                                                const string exact_broker_symbol,
                                                const string canonical_symbol_id,
                                                string &match_key_out)
  {
   match_key_out = "none";
   if(ASC_SymbolDataPackRun247SymbolEquals(row.symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:committed_l4.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.canonical_symbol, exact_broker_symbol))
     {
      match_key_out = "exact_broker_symbol:committed_l4.canonical_symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:committed_l4.symbol";
      return true;
     }
   if(ASC_SymbolDataPackRun247SymbolEquals(row.canonical_symbol, canonical_symbol_id))
     {
      match_key_out = "canonical_symbol_id:committed_l4.canonical_symbol";
      return true;
     }
   return ASC_SymbolDataPackRun247ShortlistMatches(row.summary, exact_broker_symbol, canonical_symbol_id, match_key_out);
  }

string ASC_SymbolDataPackRun247FilterStateText(const int result_state)
  {
   if(result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "pass";
   if(result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "fail";
   if(result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   return "unknown";
  }

string ASC_SymbolDataPackRun247L4Role(const ASC_ShortlistSymbolSummary &row)
  {
   if(row.shortlisted && row.rank > 0 && row.rank <= 3)
      return "promoted";
   if(row.shortlisted && row.rank > 0)
      return "shortlisted";
   if(row.bucket_shortlisted && row.bucket_rank > 0)
      return "reserve";
   if(row.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   if(row.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "fail";
   return "unknown";
  }

void ASC_SymbolDataPackRun247AppendAmbiguousSymbol(string &symbols,const string value)
  {
   if(StringLen(value) <= 0)
      return;
   if(StringLen(symbols) > 0 && symbols != "none")
      symbols += ",";
   if(symbols == "none")
      symbols = "";
   symbols += value;
  }

void ASC_SymbolDataPackRun247PrepareRuntimeOverrides(const string symbol,
                                                     const ASC_SymbolDataPackFamilyRoute route,
                                                     const ASC_RuntimeState &state)
  {
   ASC_SymbolDataPackRun247ClearRuntimeOverrides();

   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string visible_symbol = ASC_TextOrUnavailable(symbol);
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol);
   string exact_broker_symbol = ASC_TextOrUnavailable(identity.raw_symbol);
   string join_key_primary = (exact_broker_symbol != "Unavailable") ? exact_broker_symbol : visible_symbol;
   string join_key_secondary = ASC_TextOrUnavailable(canonical_symbol_id);

   ASC_CommittedLayer3SymbolState l3_row;
   bool l3_found = false;
   bool l3_ambiguous = false;
   int l3_matches = 0;
   string l3_match_key = "none";
   string ambiguity_symbols = "none";
   for(int i = 0; i < ArraySize(state.committed_l3_rows); i++)
     {
      string key = "none";
      if(!ASC_SymbolDataPackRun247CommittedL3Matches(state.committed_l3_rows[i], join_key_primary, join_key_secondary, key))
         continue;
      l3_matches++;
      ASC_SymbolDataPackRun247AppendAmbiguousSymbol(ambiguity_symbols, state.committed_l3_rows[i].symbol);
      if(!l3_found)
        {
         l3_row = state.committed_l3_rows[i];
         l3_found = true;
         l3_match_key = key;
        }
     }
   l3_ambiguous = (l3_matches > 1);

   ASC_ShortlistSymbolSummary l4_summary;
   ASC_CommittedLayer4SymbolState l4_committed;
   bool l4_found = false;
   bool l4_from_publication = false;
   bool l4_ambiguous = false;
   int l4_matches = 0;
   string l4_match_key = "none";
   string l4_owner = "ASC_RuntimeState.publication_shortlist_rows_or_committed_l4_rows";
   if(state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
     {
      for(int i = 0; i < ArraySize(state.publication_shortlist_rows); i++)
        {
         string key = "none";
         if(!ASC_SymbolDataPackRun247ShortlistMatches(state.publication_shortlist_rows[i], join_key_primary, join_key_secondary, key))
            continue;
         l4_matches++;
         ASC_SymbolDataPackRun247AppendAmbiguousSymbol(ambiguity_symbols, state.publication_shortlist_rows[i].symbol);
         if(!l4_found)
           {
            l4_summary = state.publication_shortlist_rows[i];
            l4_found = true;
            l4_from_publication = true;
            l4_match_key = key;
            l4_owner = "ASC_RuntimeState.publication_shortlist_rows";
           }
        }
     }
   if(!l4_found && state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0)
     {
      for(int i = 0; i < ArraySize(state.committed_l4_rows); i++)
        {
         string key = "none";
         if(!ASC_SymbolDataPackRun247CommittedL4Matches(state.committed_l4_rows[i], join_key_primary, join_key_secondary, key))
            continue;
         l4_matches++;
         ASC_SymbolDataPackRun247AppendAmbiguousSymbol(ambiguity_symbols, state.committed_l4_rows[i].symbol);
         if(!l4_found)
           {
            l4_committed = state.committed_l4_rows[i];
            l4_summary = state.committed_l4_rows[i].summary;
            l4_found = true;
            l4_from_publication = false;
            l4_match_key = key;
            l4_owner = "ASC_RuntimeState.committed_l4_rows.summary";
           }
        }
     }
   l4_ambiguous = (l4_matches > 1);

   bool l3_transport = (l3_found && !l3_ambiguous);
   bool l3_score_transport = (l3_transport && l3_row.score_pack_ready);
   bool l3_quality_transport = (l3_transport && (StringLen(l3_row.score_posture) > 0 || StringLen(l3_row.attention_posture) > 0));
   bool l4_transport = (l4_found && !l4_ambiguous);
   bool l4_membership_transport = l4_transport;
   bool l4_rank_transport = (l4_transport && (l4_summary.rank > 0 || l4_summary.bucket_rank > 0 || l4_summary.raw_rank > 0));
   string l4_signature_transport = l4_transport ? "partial" : "unknown";

   string l3_match_status = l3_ambiguous ? "ambiguous" : (l3_found ? "matched" : ((state.committed_l3_ready && ArraySize(state.committed_l3_rows) > 0) ? "not_found" : "unavailable"));
   string l4_match_status = l4_ambiguous ? "ambiguous" : (l4_found ? "matched" : (((state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0) || (state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0)) ? "not_found" : "unavailable"));
   string market_board_status = l4_transport ? "matched" : l4_match_status;
   string join_resolution_reason = "runtime_rows_examined_exact_or_canonical_source_owned_keys_only_no_fuzzy_no_filename_authority";
   if(l3_ambiguous || l4_ambiguous)
      join_resolution_reason = "ambiguous_source_owned_symbol_key_match_no_silent_selection";
   else if(!l3_found && !l4_found)
      join_resolution_reason = "no_source_owned_runtime_row_matched_symbol_keys";

   string l3_status = l3_score_transport ? (l3_quality_transport ? "hydrated" : "limited") : (l3_transport ? "limited" : "unavailable");
   string l4_status = l4_membership_transport ? "hydrated" : (l4_transport ? "limited" : "unavailable");
   string overall_l3_l4_status = (l3_status == "hydrated" && l4_status == "hydrated") ? "hydrated" : ((l3_transport || l4_transport) ? "limited" : "unavailable");

   string l3_score = l3_score_transport ? DoubleToString(l3_row.score_net, 1) : "unavailable";
   string l3_quality = l3_quality_transport ? (ASC_SymbolDataPackRun247TextOrUnknown(l3_row.score_posture) + "/" + ASC_SymbolDataPackRun247TextOrUnknown(l3_row.attention_posture)) : "unavailable";
   string l3_reason = l3_transport ? "source_owned_committed_l3_row_joined_no_writer_calculation" : (l3_ambiguous ? "ambiguous_committed_l3_symbol_key_match" : "committed_l3_row_not_joined_for_symbol_key");
   string l3_blocker = l3_transport ? "none_review_only_trade_still_false" : "per_symbol_l3_source_row_missing_or_ambiguous";

   string l4_member = l4_membership_transport ? ((l4_summary.shortlisted || l4_summary.bucket_shortlisted) ? "true" : "false") : "unknown";
   string l4_rank = l4_rank_transport ? ASC_SymbolDataPackRun247IntText(l4_summary.rank) : "unavailable";
   string l4_bucket_rank = l4_rank_transport ? ASC_SymbolDataPackRun247IntText(l4_summary.bucket_rank) : "unavailable";
   string l4_global_rank = l4_rank_transport ? ASC_SymbolDataPackRun247IntText(l4_summary.raw_rank) : "unavailable";
   string l4_role = l4_transport ? ASC_SymbolDataPackRun247L4Role(l4_summary) : "unknown";
   string l4_reason = l4_transport ? "source_owned_l4_shortlist_row_joined_no_membership_recalculation" : (l4_ambiguous ? "ambiguous_l4_symbol_key_match" : "l4_shortlist_row_not_joined_for_symbol_key");
   string l4_blocker = l4_transport ? "none_review_only_trade_still_false_signature_exact_match_unproven" : "per_symbol_l4_source_row_missing_or_ambiguous";
   string l4_revision = (l4_transport && !l4_from_publication) ? ASC_SymbolDataPackRun247UlongText(l4_committed.committed_revision) : ASC_SymbolDataPackRun247UtcText(state.publication_shortlist_pass_utc);
   string l4_snapshot_id = l4_transport ? (l4_from_publication ? ("publication_shortlist_pass_utc=" + ASC_SymbolDataPackRun247UtcText(state.publication_shortlist_pass_utc)) : l4_committed.source_lineage) : "unavailable";

   string join_map = "SYMBOL_L3_L4_RUNTIME_JOIN_MAP_BEGIN\n";
   join_map += "symbol_l3_l4_runtime_join_map_version=RUN247_v1\n";
   join_map += "join_mode=source_owned_runtime_rows_no_formula_no_route_rewrite\n";
   join_map += "symbol=" + visible_symbol + "\n";
   join_map += "visible_symbol=" + visible_symbol + "\n";
   join_map += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   join_map += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   join_map += "join_key_primary=" + join_key_primary + "\n";
   join_map += "join_key_secondary=" + join_key_secondary + "\n";
   join_map += "l3_row_owner=ASC_RuntimeState.committed_l3_rows\n";
   join_map += "l3_row_available=" + ((state.committed_l3_ready && ArraySize(state.committed_l3_rows) > 0) ? "true" : "false") + "\n";
   join_map += "l3_row_match_key=" + l3_match_key + "\n";
   join_map += "l3_row_match_status=" + l3_match_status + "\n";
   join_map += "l4_row_owner=" + l4_owner + "\n";
   join_map += "l4_row_available=" + (((state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0) || (state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0)) ? "true" : "false") + "\n";
   join_map += "l4_row_match_key=" + l4_match_key + "\n";
   join_map += "l4_row_match_status=" + l4_match_status + "\n";
   join_map += "market_board_row_owner=ASC_RuntimeState.publication_shortlist_rows_or_committed_l4_rows\n";
   join_map += "market_board_row_available=" + (((state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0) || (state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0)) ? "true" : "false") + "\n";
   join_map += "market_board_row_match_status=" + market_board_status + "\n";
   join_map += "join_ambiguity_count=" + IntegerToString((l3_ambiguous ? l3_matches : 0) + (l4_ambiguous ? l4_matches : 0)) + "\n";
   join_map += "join_ambiguity_symbols=" + ambiguity_symbols + "\n";
   join_map += "join_resolution_reason=" + join_resolution_reason + "\n";
   join_map += "join_next_step=" + ((l3_transport || l4_transport) ? "runtime_retest_must_confirm_published_sdp_hydrates_same_source_owned_rows" : "bind_upstream_row_export_or_wait_for_runtime_rows_no_writer_calculation") + "\n";
   join_map += "writer_calculates_l3_l4=false\n";
   join_map += "rank_formula_changed=false\n";
   join_map += "membership_formula_changed=false\n";
   join_map += "route_rewrite_performed=false\n";
   join_map += "trade_permission=false\n";
   join_map += "signal_permission=false\n";
   join_map += "execution_permission=false\n";
   join_map += "risk_permission=false\n";
   join_map += "SYMBOL_L3_L4_RUNTIME_JOIN_MAP_END\n\n";

   string owner = "SYMBOL_L3_L4_OWNER_MAP_BEGIN\n";
   owner += "symbol_l3_l4_owner_map_version=RUN247_v1\n";
   owner += "symbol_l3_l4_mode=source_owned_projection_only\n";
   owner += "symbol=" + visible_symbol + "\n";
   owner += "visible_symbol=" + visible_symbol + "\n";
   owner += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   owner += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   owner += "l3_source_owner=ASC_RuntimeState.committed_l3_rows_ASC_SelectionFilter_ASC_Dispatcher\n";
   owner += "l3_transport_available=" + ASC_SymbolDataPackRun247BoolText(l3_transport) + "\n";
   owner += "l3_score_owner=ASC_CommittedLayer3SymbolState.score_net_or_ASC_ShortlistSymbolSummary.shortlist_l3_score\n";
   owner += "l3_score_transport_available=" + ASC_SymbolDataPackRun247BoolText(l3_score_transport) + "\n";
   owner += "l3_quality_owner=ASC_CommittedLayer3SymbolState.score_posture_attention_posture\n";
   owner += "l3_quality_transport_available=" + ASC_SymbolDataPackRun247BoolText(l3_quality_transport) + "\n";
   owner += "l4_source_owner=" + l4_owner + "\n";
   owner += "l4_transport_available=" + ASC_SymbolDataPackRun247BoolText(l4_transport) + "\n";
   owner += "l4_membership_owner=ASC_ShortlistSymbolSummary.shortlisted_bucket_shortlisted_membership_state\n";
   owner += "l4_membership_transport_available=" + ASC_SymbolDataPackRun247BoolText(l4_membership_transport) + "\n";
   owner += "l4_rank_owner=ASC_ShortlistSymbolSummary.rank_bucket_rank_raw_rank\n";
   owner += "l4_rank_transport_available=" + ASC_SymbolDataPackRun247BoolText(l4_rank_transport) + "\n";
   owner += "l4_signature_owner=MarketBoard_RUN239_L3_L4_signature_context_board_level_only\n";
   owner += "l4_signature_transport_available=" + l4_signature_transport + "\n";
   owner += "l4_rank_order_transport_available=unknown\n";
   owner += "l4_set_transport_available=unknown\n";
   owner += "per_symbol_l3_l4_projection_owner=ASC_SymbolDataPackComposer_RUN247_runtime_override_prepared_by_writer_from_ASC_RuntimeState\n";
   owner += "per_symbol_l3_l4_projection_available=true\n";
   owner += "writer_calculates_l3_l4=false\n";
   owner += "rank_formula_changed=false\n";
   owner += "membership_formula_changed=false\n";
   owner += "market_board_order_changed=false\n";
   owner += "route_rewrite_performed=false\n";
   owner += "l3_l4_missing_owner_summary=" + ((l3_transport || l4_transport) ? "runtime_join_partially_or_fully_hydrated_from_source_owned_rows" : join_resolution_reason) + "\n";
   owner += "l3_l4_next_step=" + ((l3_transport && l4_transport) ? "runtime_retest_published_sdp_fields_against_source_rows_no_trade_permission" : "resolve_remaining_missing_or_ambiguous_runtime_join_rows") + "\n";
   owner += "trade_permission=false\n";
   owner += "signal_permission=false\n";
   owner += "execution_permission=false\n";
   owner += "risk_permission=false\n";
   owner += "SYMBOL_L3_L4_OWNER_MAP_END\n\n";

   string ctx = "SYMBOL_L3_L4_CONTEXT_BEGIN\n";
   ctx += "symbol_l3_l4_context_version=RUN247_v1\n";
   ctx += "symbol=" + visible_symbol + "\n";
   ctx += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   ctx += "symbol_l3_l4_status=" + overall_l3_l4_status + "\n";
   ctx += "symbol_l3_status=" + l3_status + "\n";
   ctx += "symbol_l3_score=" + l3_score + "\n";
   ctx += "symbol_l3_rank=unavailable\n";
   ctx += "symbol_l3_quality=" + l3_quality + "\n";
   ctx += "symbol_l3_reason=" + l3_reason + "\n";
   ctx += "symbol_l3_blocker_reason=" + l3_blocker + "\n";
   ctx += "symbol_l3_source_revision=" + (l3_transport ? ASC_SymbolDataPackRun247UlongText(l3_row.committed_revision) : "unavailable") + "\n";
   ctx += "symbol_l3_snapshot_id=" + (l3_transport ? ("committed_l3_pass_utc=" + ASC_SymbolDataPackRun247UtcText(state.committed_l3_pass_utc)) : "unavailable") + "\n";
   ctx += "symbol_l3_match_key=" + l3_match_key + "\n";
   ctx += "symbol_l3_owner=ASC_RuntimeState.committed_l3_rows\n";
   ctx += "symbol_l4_status=" + l4_status + "\n";
   ctx += "symbol_l4_member=" + l4_member + "\n";
   ctx += "symbol_l4_rank=" + l4_rank + "\n";
   ctx += "symbol_l4_bucket_rank=" + l4_bucket_rank + "\n";
   ctx += "symbol_l4_global_rank=" + l4_global_rank + "\n";
   ctx += "symbol_l4_role=" + l4_role + "\n";
   ctx += "symbol_l4_signature_match=unknown\n";
   ctx += "symbol_l4_rank_order_match=unknown\n";
   ctx += "symbol_l4_set_match=unknown\n";
   ctx += "symbol_l4_reason=" + l4_reason + "\n";
   ctx += "symbol_l4_blocker_reason=" + l4_blocker + "\n";
   ctx += "symbol_l4_source_revision=" + l4_revision + "\n";
   ctx += "symbol_l4_snapshot_id=" + l4_snapshot_id + "\n";
   ctx += "symbol_l4_match_key=" + l4_match_key + "\n";
   ctx += "symbol_l4_owner=" + l4_owner + "\n";
   ctx += "symbol_l3_l4_blocks_trade=true\n";
   ctx += "symbol_l3_l4_blocks_diagnostic_review=false\n";
   ctx += "symbol_l3_l4_next_step=" + ((l3_transport && l4_transport) ? "review_only_runtime_retest_then_RUN248_final_review_gate_if_compile_clean" : "resolve_remaining_l3_l4_runtime_join_gap_no_trade_permission") + "\n";
   ctx += "trade_permission=false\n";
   ctx += "signal_permission=false\n";
   ctx += "execution_permission=false\n";
   ctx += "risk_permission=false\n";
   ctx += "SYMBOL_L3_L4_CONTEXT_END\n\n";

   string missing_layers = "none";
   if(!l3_transport) missing_layers = "l3_runtime_join";
   if(!l4_transport) missing_layers = (missing_layers == "none" ? "l4_runtime_join" : missing_layers + ",l4_runtime_join");
   if(!l4_rank_transport) missing_layers = (missing_layers == "none" ? "l4_rank" : missing_layers + ",l4_rank");
   if(l4_signature_transport != "true") missing_layers = (missing_layers == "none" ? "l4_signature_exact_match" : missing_layers + ",l4_signature_exact_match");
   string review_ready = (l3_transport && l4_transport) ? "yes" : ((l3_transport || l4_transport) ? "limited" : "no");
   string recommended = (review_ready == "yes") ? "upload_review" : ((review_ready == "limited") ? "recheck_after_refresh" : "source_gap");
   string review = "SIAM_SYMBOL_REVIEW_READINESS_BEGIN\n";
   review += "siam_symbol_review_readiness_version=RUN247_v1\n";
   review += "review_readiness_mode=review_only_not_trade_gate\n";
   review += "ready_for_siam_review=" + review_ready + "\n";
   review += "ready_for_siam_trade=no\n";
   review += "review_reason=" + ((review_ready == "yes") ? "source_owned_l3_l4_rows_joined_review_only" : "missing_or_ambiguous_source_owned_l3_l4_runtime_join") + "\n";
   review += "review_blocker_summary=" + ((missing_layers == "none") ? "none" : missing_layers) + "\n";
   review += "current_missing_layers=" + missing_layers + "\n";
   review += "identity_status=" + ((exact_broker_symbol != "Unavailable" && join_key_secondary != "Unavailable") ? "resolved" : "limited") + "\n";
   review += "duplicate_route_status=route_context_only_not_parallel_route_authority\n";
   review += "l3_l4_status=" + overall_l3_l4_status + "\n";
   review += "execution_facts_status=unchanged_RUN246_execution_facts_owner_map_still_source_owned\n";
   review += "top5_sync_status=unchanged_RUN246_top5_sync_status_preserved\n";
   review += "recommended_siam_action=" + recommended + "\n";
   review += "trade_permission=false\n";
   review += "signal_permission=false\n";
   review += "execution_permission=false\n";
   review += "risk_permission=false\n";
   review += "SIAM_SYMBOL_REVIEW_READINESS_END\n\n";

   g_asc_sdp_run247_runtime_join_override_active = true;
   g_asc_sdp_run247_runtime_join_map_override = join_map;
   g_asc_sdp_run247_owner_map_override = owner;
   g_asc_sdp_run247_context_override = ctx;
   g_asc_sdp_run247_review_readiness_override = review;
  }

string ASC_SymbolDataPackPlannedLine(const string section_name,const string future_run,const string owner_trace)
  {
   return "Section: " + section_name + "\n"
          + "State: route_planned_run\n"
          + "Future Run: " + future_run + "\n"
          + "Owner Trace: " + owner_trace + "\n"
          + "Numeric Contract: value/formula/threshold/timeframe/source/freshness/sample_count required before factual fill\n\n";
  }

string ASC_SymbolDataPackSectionPlanLine(const string section_name,
                                         const string future_run,
                                         const string owner_trace,
                                         const int cadence_seconds,
                                         const string recalculation_rule)
  {
   return "Section: " + section_name + "\n"
          + "State: route_planned_run\n"
          + "Future Run: " + future_run + "\n"
          + "Owner Trace: " + owner_trace + "\n"
          + "Section Cadence Target: " + ASC_SymbolDataPackCadenceText(cadence_seconds) + "\n"
          + "Recalculation Rule: " + recalculation_rule + "\n"
          + "Numeric Contract: value/formula/threshold/timeframe/source/freshness/sample_count required before factual fill\n\n";
  }

string ASC_SymbolDataPackHistoryDepthContractText()
  {
   string text = "History Depth Contract\n";
   text += "| Family | Timeframes | Default Bars | Minimum / Candidate | Future Fill Run | Contract Reason |\n";
   text += "|---|---|---:|---|---|---|\n";
   text += "| LTF | M1/M5/M15 | " + IntegerToString(ASC_SDP_LTF_BARS_DEFAULT) + " | min=" + IntegerToString(ASC_SDP_LTF_BARS_MIN) + "; candidate=" + IntegerToString(ASC_SDP_LTF_BARS_RESEARCH_CANDIDATE) + " | RUN164R | enough closed-bar sequence/range context without making every packet a full archive |\n";
   text += "| MTF | M30/H1/H4 | " + IntegerToString(ASC_SDP_MTF_BARS_DEFAULT) + " | fixed_default | RUN164R | covers standard indicator warmups and multi-session context with bounded payload |\n";
   text += "| D1 | D1 | " + IntegerToString(ASC_SDP_D1_BARS_DEFAULT) + " | expansion_after_indicator_need | RUN164R/RUN167R | supports Lite daily range/context now; larger MA context remains later measured expansion |\n";
   text += "| W1 | W1 | " + IntegerToString(ASC_SDP_W1_BARS_DEFAULT) + " | fixed_default | RUN164R | near one-year weekly range context without heavy output |\n";
   text += "| MN1 | MN1 | " + IntegerToString(ASC_SDP_MN1_BARS_DEFAULT) + " | expansion_candidate=" + IntegerToString(ASC_SDP_MN1_BARS_EXPANSION_CANDIDATE) + " | RUN164R | two-year monthly context now; 50-month expansion only if payload budget holds |\n\n";
   return text;
  }

string ASC_SymbolDataPackTickSpreadContractText()
  {
   string text = "Tick / Spread Window Contract\n";
   text += "| Contract | Seconds | Future Fill Run | Contract Reason |\n";
   text += "|---|---:|---|---|\n";
   text += "| Primary tick rolling window | " + IntegerToString(ASC_SDP_TICK_WINDOW_PRIMARY_SECONDS) + " | RUN163R | stable micro-activity sample, less reactive to single quote bursts |\n";
   text += "| Primary spread rolling window | " + IntegerToString(ASC_SDP_SPREAD_WINDOW_PRIMARY_SECONDS) + " | RUN163R | spread is cost/liquidity evidence; five-minute window dampens bid-ask bounce noise |\n";
   text += "| Immediate tick window | " + IntegerToString(ASC_SDP_TICK_WINDOW_IMMEDIATE_SECONDS) + " | RUN163R | short-lens freshness and sudden-dislocation evidence only |\n";
   text += "| Immediate spread window | " + IntegerToString(ASC_SDP_SPREAD_WINDOW_IMMEDIATE_SECONDS) + " | RUN163R | current stress lens; secondary to primary stable window |\n";
   text += "| Quote refresh target | " + IntegerToString(ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS) + " | RUN163R | selected/displayed factual refresh without full-system recalc every beat |\n";
   text += "| Tick refresh target | " + IntegerToString(ASC_SDP_TICK_REFRESH_TARGET_SECONDS) + " | RUN163R | CopyTicks window refresh contract only, not tick spam |\n";
   text += "| Spread refresh target | " + IntegerToString(ASC_SDP_SPREAD_REFRESH_TARGET_SECONDS) + " | RUN163R | aggregate min/max/avg/stability refresh target |\n\n";
   return text;
  }

string ASC_SymbolDataPackRecalculationContractText()
  {
   string text = "No Unnecessary Recalculation Contract\n";
   text += "| Data Family | Refresh / Recalc Rule | Preview Allowed? | Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| quote/tick/spread | refresh target " + IntegerToString(ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS) + "s; aggregate windows only | yes | due-only and no full-file publish unless material change/proof heartbeat |\n";
   text += "| M1 | recalc on new M1 closed bar | yes | preview must be labelled and separate from closed-bar values |\n";
   text += "| M5 | recalc on new M5 closed bar | yes | preview must be labelled and separate from closed-bar values |\n";
   text += "| M15 | recalc on new M15 closed bar | yes | preview must be labelled and separate from closed-bar values |\n";
   text += "| H1/H4 | recalc on new source timeframe closed bar | labelled preview only | H1 ATR last-closed does not recalc before new H1 bar |\n";
   text += "| D1/W1/MN1 | recalc on new period closed bar or explicit hydration repair | labelled preview only | closed-bar values identify bar time/index |\n";
   text += "| indicators | recalc only when source timeframe changes unless preview is labelled | labelled preview only | handle/buffer lifecycle owned by RUN167R |\n";
   text += "| full pack | recomposed atomically after changed section or proof heartbeat | n/a | " + string(ASC_SDP_RECALC_RULE_FULL_PACK) + " |\n\n";
   return text;
  }

string ASC_SymbolDataPackAtomicPublicationContractText()
  {
   string text = "Atomic Publication Contract\n";
   text += "| Capability | Contract | Existing Pattern | Side Effect Guard |\n";
   text += "|---|---|---|---|\n";
   text += "| target path | route-aware helpers support flat transition, GlobalTop10 mirror, and Top5PerBucket/<bucket> mirror | writer path helper | empty root/symbol/bucket guards |\n";
   text += "| temp path | final_path + .tmp | ASC_WriteTextFileAtomic | no public tiny section files |\n";
   text += "| readback validation | required token contract | ASC_ReadAndCheckPayloadTokenContractAgainstExpected | payload rejected before promote |\n";
   text += "| promote/final path | FileMove with rewrite inside existing FileIO | ASC_WritePublicationPayloadAtomic | FileIO not rewritten |\n";
   text += "| last-good | retained final file is continuity baseline | existing continuity outcome | no extra operator-facing last-good file |\n";
   text += "| no-change | material payload comparison before write | ASC_PublicationPayloadMateriallyEqual | skip unchanged writes |\n";
   text += "| writer mode | " + string(ASC_SDP_PUBLICATION_STATUS_SHADOW) + " | compile-visible route-aware helpers | family publication callsites wait for RUN191R/RUN192R |\n\n";
   return text;
  }

string ASC_SymbolDataPackSectionFreshnessPlanText()
  {
   ASC_SymbolDataPackSectionRefreshContract c;
   string text = "Section Freshness Metadata Plan\n";
   text += "| Section | Cadence | Last Refresh UTC | Next Due UTC | Source Owner | Status | Retry State | Last Good Age | Content Changed | Recalc Due | Included In Full Pack | Future Run |\n";
   text += "|---|---:|---|---|---|---|---|---:|---:|---:|---:|---|\n";

   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_PUBLICATION, ASC_SDP_SECTION_CADENCE_PUBLICATION_SECONDS, "SymbolDataPackWriter + ASC_FileIO", string(ASC_SDP_PUBLICATION_STATUS_READY), "retry_not_started", "RUN162R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_IDENTITY, ASC_SDP_SECTION_CADENCE_IDENTITY_SECONDS, "ClassificationBridge + SymbolSpecification", "hydration_required", "retry_not_started", "RUN163R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_L4_CONTEXT, ASC_SDP_SECTION_CADENCE_L4_CONTEXT_SECONDS, "L4 committed membership snapshot", "context_route_planned", "retry_not_started", "RUN163R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_MARKET_STATE, ASC_SDP_SECTION_CADENCE_MARKET_STATE_SECONDS, "MarketStateEngine", "hydration_required", "retry_not_started", "RUN163R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_QUOTE, ASC_SDP_SECTION_CADENCE_QUOTE_SECONDS, "OpenSymbolSnapshotEngine", "hydration_required", "retry_required", "RUN163R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_SPREAD, ASC_SDP_SECTION_CADENCE_SPREAD_SECONDS, "OpenSymbolSnapshotEngine + LiquidityFrictionSummary", "hydration_required", "retry_required", "RUN163R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_RECENT_CANDLES, ASC_SDP_SECTION_CADENCE_M1_SECONDS, "CopyRates wrapper", "route_planned_run", "retry_not_started", "RUN164R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_MULTI_TF, ASC_SDP_SECTION_CADENCE_H1_SECONDS, "DeepSelectiveAnalysisEngine + series wrappers", "route_planned_run", "retry_not_started", "RUN164R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_DWM, ASC_SDP_SECTION_CADENCE_D1_SECONDS, "CopyRates/iHigh/iLow wrapper", "route_planned_run", "retry_not_started", "RUN164R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_ATR, ASC_SDP_SECTION_CADENCE_M15_SECONDS, "CopyRates/MqlRates manual true range wrapper", "route_ready", "retry_required", "RUN165R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_SWING_RANGE, ASC_SDP_SECTION_CADENCE_M15_SECONDS, "CopyRates/MqlRates high-low and range wrapper", "route_ready", "retry_required", "RUN165R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_ATR, ASC_SDP_SECTION_CADENCE_H1_SECONDS, "ATRSummaryEngine + OpenSymbolSnapshotEngine", "route_planned_run", "retry_not_started", "RUN165R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_VWAP, ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS, "CopyRates M1 MqlRates VWAP wrapper", "route_ready", "retry_required", "RUN166R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_INDICATORS, ASC_SDP_SECTION_CADENCE_H1_SECONDS, "future handle/buffer wrapper", "route_planned_run", "retry_not_started", "RUN167R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   ASC_SymbolDataPackSetSectionRefreshContract(c, ASC_SYMBOL_DATA_PACK_SECTION_HEALTH, ASC_SDP_SECTION_CADENCE_HEALTH_SECONDS, "writer/routing health owner", "route_planned_run", "retry_not_started", "RUN168R");
   text += ASC_SymbolDataPackSectionRefreshLine(c);
   text += "\n";
   return text;
  }


string ASC_SymbolDataPackQuoteSnapshotText(const string symbol)
  {
   ASC_SymbolDataPackQuoteSnapshot q;
   ASC_SymbolDataPackReadQuoteSnapshot(symbol, q);
   string text = "Quote Snapshot Factual Section\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_QUOTE) + "\n";
   text += "State: " + q.quote_hydration_state + "\n";
   text += "Owner Trace: OpenSymbolSnapshotEngine + SymbolInfoTick + SymbolIsSynchronized + SYMBOL_SELECT\n";
   text += "quote_refresh_target_seconds: " + IntegerToString(q.quote_refresh_target_seconds) + "\n";
   text += "quote_last_refresh_utc: " + ASC_SymbolDataPackUtcText(q.quote_last_refresh_utc) + "\n";
   text += "quote_age_seconds: " + ASC_SymbolDataPackIntText(q.quote_age_seconds) + "\n";
   text += "symbol_info_tick_success: " + ASC_SymbolDataPackBoolText(q.symbol_info_tick_success) + "\n";
   text += "symbol_info_tick_error_code: " + IntegerToString(q.symbol_info_tick_error_code) + "\n";
   text += "bid: " + ASC_SymbolDataPackDoubleText(q.bid) + "\n";
   text += "ask: " + ASC_SymbolDataPackDoubleText(q.ask) + "\n";
   text += "last: " + ASC_SymbolDataPackDoubleText(q.last) + "\n";
   text += "last_price_available: " + ASC_SymbolDataPackBoolText(q.last_price_available) + "\n";
   text += "last_price_status: " + q.last_price_status + "\n";
   text += "last_price_raw: " + ASC_SymbolDataPackDoubleText(q.last_price_raw) + "\n";
   text += "spread_points: " + ASC_SymbolDataPackDoubleText(q.spread_points) + "\n";
   text += "spread_price: " + ASC_SymbolDataPackDoubleText(q.spread_price) + "\n";
   text += "spread_percent: " + ASC_SymbolDataPackDoubleText(q.spread_percent) + "\n";
   text += "tick_time: " + ASC_SymbolDataPackUtcText(q.tick_time) + "\n";
   text += "tick_age_seconds: " + ASC_SymbolDataPackIntText(q.tick_age_seconds) + "\n";
   text += "market_watch_selected_state: " + ASC_SymbolDataPackBoolText(q.market_watch_selected_state) + "\n";
   text += "symbol_synchronized_state: " + ASC_SymbolDataPackBoolText(q.symbol_synchronized_state) + "\n";
   text += "quote_hydration_state: " + q.quote_hydration_state + "\n";
   text += "quote_retry_attempts: " + IntegerToString(q.quote_retry_attempts) + "\n";
   text += "quote_retry_due: " + q.quote_retry_due + "\n";
   text += "quote_last_good_bid: " + (q.quote_last_good_time > 0 ? ASC_SymbolDataPackDoubleText(q.quote_last_good_bid) : string(ASC_SDP_LAST_GOOD_PENDING)) + "\n";
   text += "quote_last_good_ask: " + (q.quote_last_good_time > 0 ? ASC_SymbolDataPackDoubleText(q.quote_last_good_ask) : string(ASC_SDP_LAST_GOOD_PENDING)) + "\n";
   text += "quote_last_good_time: " + ASC_SymbolDataPackUtcText(q.quote_last_good_time) + "\n";
   text += "quote_last_good_age_seconds: " + ASC_SymbolDataPackIntText(q.quote_last_good_age_seconds) + "\n";
   text += "hard_absence_reason: " + q.hard_absence_reason + "\n";
   text += "absence_state: " + q.absence_state + "\n";
   text += "absence_reason: " + q.absence_reason + "\n";
   text += "Signal Safety: quote facts are freshness/cost/liquidity data only; not permission, not instruction.\n\n";
   return text;
  }

string ASC_SymbolDataPackTickStatsText(const string symbol)
  {
   ASC_SymbolDataPackTickSpreadStats s;
   ASC_SymbolDataPackReadTickSpreadStats(symbol, s);
   string text = "Tick Activity Statistics Factual Section\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_TICK) + "\n";
   text += "State: " + s.tick_stats_hydration_state + "\n";
   text += "Owner Trace: OpenSymbolSnapshotEngine + CopyTicks(COPY_TICKS_INFO) aggregate windows\n";
   text += "tick_refresh_target_seconds: " + IntegerToString(s.tick_refresh_target_seconds) + "\n";
   text += "tick_window_immediate_seconds: " + IntegerToString(s.tick_window_immediate_seconds) + "\n";
   text += "tick_window_primary_seconds: " + IntegerToString(s.tick_window_primary_seconds) + "\n";
   text += "ticks_last_60s: " + IntegerToString(s.ticks_last_60s) + "\n";
   text += "ticks_last_300s: " + IntegerToString(s.ticks_last_300s) + "\n";
   text += "bid_change_count_60s: " + IntegerToString(s.bid_change_count_60s) + "\n";
   text += "bid_change_count_300s: " + IntegerToString(s.bid_change_count_300s) + "\n";
   text += "ask_change_count_60s: " + IntegerToString(s.ask_change_count_60s) + "\n";
   text += "ask_change_count_300s: " + IntegerToString(s.ask_change_count_300s) + "\n";
   text += "max_tick_gap_seconds_60s: " + ASC_SymbolDataPackIntText(s.max_tick_gap_seconds_60s) + "\n";
   text += "max_tick_gap_seconds_300s: " + ASC_SymbolDataPackIntText(s.max_tick_gap_seconds_300s) + "\n";
   text += "avg_tick_gap_seconds_60s: " + ASC_SymbolDataPackDoubleText(s.avg_tick_gap_seconds_60s) + "\n";
   text += "avg_tick_gap_seconds_300s: " + ASC_SymbolDataPackDoubleText(s.avg_tick_gap_seconds_300s) + "\n";
   text += "tick_sample_count_60s: " + IntegerToString(s.tick_sample_count_60s) + "\n";
   text += "tick_sample_count_300s: " + IntegerToString(s.tick_sample_count_300s) + "\n";
   text += "tick_window_60s_valid: " + ASC_SymbolDataPackBoolText(s.tick_window_60s_valid) + "\n";
   text += "tick_window_300s_valid: " + ASC_SymbolDataPackBoolText(s.tick_window_300s_valid) + "\n";
   text += "tick_window_60s_invalid_reason: " + s.tick_window_60s_invalid_reason + "\n";
   text += "tick_window_300s_invalid_reason: " + s.tick_window_300s_invalid_reason + "\n";
   text += "tick_stats_hydration_state: " + s.tick_stats_hydration_state + "\n";
   text += "tick_stats_collecting_until_full_window: " + s.tick_stats_collecting_until_full_window + "\n";
   text += "tick_stats_retry_due: " + s.tick_stats_retry_due + "\n";
   text += "last_good_tick_stats_age_seconds: " + ASC_SymbolDataPackIntText(s.last_good_tick_stats_age_seconds) + "\n";
   text += "copy_ticks_requested_limit: " + IntegerToString(s.copy_ticks_requested_limit) + "\n";
   text += "copy_ticks_return_count: " + IntegerToString(s.copy_ticks_return_count) + "\n";
   text += "copy_ticks_cap_hit: " + ASC_SymbolDataPackBoolText(s.copy_ticks_cap_hit) + "\n";
   text += "copy_ticks_truncation_state: " + s.copy_ticks_truncation_state + "\n";
   text += "copy_ticks_error_code: " + IntegerToString(s.copy_ticks_error_code) + "\n";
   text += "Signal Safety: aggregate activity only; no raw tick spam and no direction wording.\n\n";
   return text;
  }

string ASC_SymbolDataPackSpreadStatsText(const string symbol)
  {
   ASC_SymbolDataPackTickSpreadStats s;
   ASC_SymbolDataPackReadTickSpreadStats(symbol, s);
   string text = "Spread Statistics Factual Section\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_SPREAD) + "\n";
   text += "State: " + s.spread_stats_hydration_state + "\n";
   text += "Owner Trace: OpenSymbolSnapshotEngine + CopyTicks(COPY_TICKS_INFO) aggregate windows\n";
   text += "spread_refresh_target_seconds: " + IntegerToString(s.spread_refresh_target_seconds) + "\n";
   text += "spread_window_immediate_seconds: " + IntegerToString(s.spread_window_immediate_seconds) + "\n";
   text += "spread_window_primary_seconds: " + IntegerToString(s.spread_window_primary_seconds) + "\n";
   text += "spread_current_points: " + ASC_SymbolDataPackDoubleText(s.spread_current_points) + "\n";
   text += "spread_current_price: " + ASC_SymbolDataPackDoubleText(s.spread_current_price) + "\n";
   text += "spread_current_percent: " + ASC_SymbolDataPackDoubleText(s.spread_current_percent) + "\n";
   text += "spread_min_points_60s: " + ASC_SymbolDataPackSampledDoubleText(s.spread_min_points_60s, s.spread_sample_count_60s) + "\n";
   text += "spread_max_points_60s: " + ASC_SymbolDataPackSampledDoubleText(s.spread_max_points_60s, s.spread_sample_count_60s) + "\n";
   text += "spread_avg_points_60s: " + ASC_SymbolDataPackSampledDoubleText(s.spread_avg_points_60s, s.spread_sample_count_60s) + "\n";
   text += "spread_min_points_300s: " + ASC_SymbolDataPackSampledDoubleText(s.spread_min_points_300s, s.spread_sample_count_300s) + "\n";
   text += "spread_max_points_300s: " + ASC_SymbolDataPackSampledDoubleText(s.spread_max_points_300s, s.spread_sample_count_300s) + "\n";
   text += "spread_avg_points_300s: " + ASC_SymbolDataPackSampledDoubleText(s.spread_avg_points_300s, s.spread_sample_count_300s) + "\n";
   text += "spread_sample_count_60s: " + IntegerToString(s.spread_sample_count_60s) + "\n";
   text += "spread_sample_count_300s: " + IntegerToString(s.spread_sample_count_300s) + "\n";
   text += "spread_window_60s_valid: " + ASC_SymbolDataPackBoolText(s.spread_window_60s_valid) + "\n";
   text += "spread_window_300s_valid: " + ASC_SymbolDataPackBoolText(s.spread_window_300s_valid) + "\n";
   text += "spread_window_60s_invalid_reason: " + s.spread_window_60s_invalid_reason + "\n";
   text += "spread_window_300s_invalid_reason: " + s.spread_window_300s_invalid_reason + "\n";
   text += "spread_widening_vs_300s_avg_percent: " + ASC_SymbolDataPackDoubleText(s.spread_widening_vs_300s_avg_percent) + "\n";
   text += "spread_stats_hydration_state: " + s.spread_stats_hydration_state + "\n";
   text += "spread_stats_collecting_until_full_window: " + s.spread_stats_collecting_until_full_window + "\n";
   text += "spread_stats_retry_due: " + s.spread_stats_retry_due + "\n";
   text += "last_good_spread_stats_age_seconds: " + ASC_SymbolDataPackIntText(s.last_good_spread_stats_age_seconds) + "\n";
   text += "Signal Safety: spread is cost/liquidity evidence only; not permission, not instruction.\n\n";
   return text;
  }




string ASC_SymbolDataPackOhlcSummaryText(const string symbol)
  {
   ENUM_TIMEFRAMES periods[9] = { PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1, PERIOD_MN1 };
   string text = "Multi-Timeframe OHLC Summary\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_MULTI_TF) + "\n";
   text += "Owner Trace: " + string(ASC_SDP_OHLC_OWNER) + "\n";
   text += "LTF Boundary: " + string(ASC_SDP_LTF_ROLE) + "\n";
   text += "MTF Priority: " + string(ASC_SDP_MTF_ROLE) + "\n";
   text += "Recalculation Rule: " + string(ASC_SDP_OHLC_RECALC_RULE) + "\n";
   text += "| timeframe | bars_requested | bars_received | copyrates_success | copyrates_error_code | oldest_bar_time | newest_bar_time | current_forming_bar_time | current_forming_open | current_forming_high | current_forming_low | current_forming_close | last_closed_bar_time | last_closed_open | last_closed_high | last_closed_low | last_closed_close | last_closed_tick_volume | last_closed_spread | bar_age_seconds | hydration_state | retry_attempts | retry_due | last_good_bar_time | last_good_age_seconds | role_boundary |\n";
   text += "|---|---:|---:|---:|---:|---|---|---|---:|---:|---:|---:|---|---:|---:|---:|---:|---:|---:|---:|---|---:|---|---|---:|---|\n";
   for(int i = 0; i < 9; i++)
     {
      ASC_SymbolDataPackTimeframeOhlc o;
      ASC_SymbolDataPackReadTimeframeOhlc(symbol, periods[i], o);
      text += "| " + o.timeframe
              + " | " + IntegerToString(o.bars_requested)
              + " | " + IntegerToString(o.bars_received)
              + " | " + ASC_SymbolDataPackBoolText(o.copyrates_success)
              + " | " + IntegerToString(o.copyrates_error_code)
              + " | " + ASC_SymbolDataPackUtcText(o.oldest_bar_time)
              + " | " + ASC_SymbolDataPackUtcText(o.newest_bar_time)
              + " | " + ASC_SymbolDataPackUtcText(o.current_forming_bar_time)
              + " | " + ASC_SymbolDataPackDoubleText(o.current_forming_open)
              + " | " + ASC_SymbolDataPackDoubleText(o.current_forming_high)
              + " | " + ASC_SymbolDataPackDoubleText(o.current_forming_low)
              + " | " + ASC_SymbolDataPackDoubleText(o.current_forming_close)
              + " | " + ASC_SymbolDataPackUtcText(o.last_closed_bar_time)
              + " | " + ASC_SymbolDataPackDoubleText(o.last_closed_open)
              + " | " + ASC_SymbolDataPackDoubleText(o.last_closed_high)
              + " | " + ASC_SymbolDataPackDoubleText(o.last_closed_low)
              + " | " + ASC_SymbolDataPackDoubleText(o.last_closed_close)
              + " | " + IntegerToString(o.last_closed_tick_volume)
              + " | " + IntegerToString(o.last_closed_spread)
              + " | " + ASC_SymbolDataPackIntText(o.bar_age_seconds)
              + " | " + o.hydration_state
              + " | " + IntegerToString(o.retry_attempts)
              + " | " + o.retry_due
              + " | " + ASC_SymbolDataPackUtcText(o.last_good_bar_time)
              + " | " + ASC_SymbolDataPackIntText(o.last_good_age_seconds)
              + " | " + o.role_boundary + " |\n";
     }
   text += "Signal Safety: OHLC fields are numeric facts only; no direction labels, no pattern labels, no actionability.\n\n";
   return text;
  }

string ASC_SymbolDataPackRecentClosedCandleSequenceText(const string symbol)
  {
   ENUM_TIMEFRAMES periods[9] = { PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1, PERIOD_MN1 };
   string text = "Recent Closed Candle Sequences\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_RECENT_CANDLES) + "\n";
   text += "Format: timeframe,time,open,high,low,close,tick_volume,spread\n";
   text += "Size Guard: compact recent closed sequences; LTF printed count capped while fetched depth remains available to the wrapper.\n";
   for(int p = 0; p < 9; p++)
     {
      ASC_SymbolDataPackTimeframeOhlc o;
      ASC_SymbolDataPackReadTimeframeOhlc(symbol, periods[p], o);
      MqlRates rates[];
      int copy_error = 0;
      int copied = ASC_SymbolDataPackCopyRatesSeries(symbol, periods[p], o.bars_requested, rates, copy_error);
      int available_closed = copied - 1;
      if(available_closed < 0) available_closed = 0;
      int print_count = o.sequence_print_count;
      if(print_count > available_closed) print_count = available_closed;
      text += "[" + o.timeframe + "] bars_requested=" + IntegerToString(o.bars_requested)
              + " bars_received=" + IntegerToString(copied)
              + " printed_closed_bars=" + IntegerToString(print_count)
              + " copyrates_error_code=" + IntegerToString(copy_error)
              + " hydration_state=" + o.hydration_state
              + " retry_due=" + o.retry_due
              + " role_boundary=" + o.role_boundary + "\n";
      for(int i = 1; i <= print_count; i++)
        {
         text += o.timeframe + ","
                 + ASC_SymbolDataPackUtcText(rates[i].time) + ","
                 + ASC_SymbolDataPackDoubleText(rates[i].open) + ","
                 + ASC_SymbolDataPackDoubleText(rates[i].high) + ","
                 + ASC_SymbolDataPackDoubleText(rates[i].low) + ","
                 + ASC_SymbolDataPackDoubleText(rates[i].close) + ","
                 + IntegerToString(rates[i].tick_volume) + ","
                 + IntegerToString(rates[i].spread) + "\n";
        }
     }
   text += "Signal Safety: candle sequences are numeric rows only; no pattern names and no action language.\n\n";
   return text;
  }

string ASC_SymbolDataPackDwmHighLowFactsText(const string symbol)
  {
   ASC_SymbolDataPackDwmHighLowFacts f;
   ASC_SymbolDataPackReadDwmHighLowFacts(symbol, f);
   string text = "Daily / Weekly / Monthly High-Low Facts\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_DWM) + "\n";
   text += "Owner Trace: " + f.source_proof + "\n";
   text += "Signal Safety: " + f.signal_safety + "\n";
   text += "d1_hydration_state: " + f.d1_hydration_state + "\n";
   text += "d1_retry_due: " + f.d1_retry_due + "\n";
   text += "d1_last_good_age_seconds: " + ASC_SymbolDataPackIntText(f.d1_last_good_age_seconds) + "\n";
   text += "today_open: " + ASC_SymbolDataPackDoubleText(f.today_open) + "\n";
   text += "today_high: " + ASC_SymbolDataPackDoubleText(f.today_high) + "\n";
   text += "today_low: " + ASC_SymbolDataPackDoubleText(f.today_low) + "\n";
   text += "today_current_close: " + ASC_SymbolDataPackDoubleText(f.today_current_close) + "\n";
   text += "today_range_points: " + ASC_SymbolDataPackDoubleText(f.today_range_points) + "\n";
   text += "yesterday_open: " + ASC_SymbolDataPackDoubleText(f.yesterday_open) + "\n";
   text += "yesterday_high: " + ASC_SymbolDataPackDoubleText(f.yesterday_high) + "\n";
   text += "yesterday_low: " + ASC_SymbolDataPackDoubleText(f.yesterday_low) + "\n";
   text += "yesterday_close: " + ASC_SymbolDataPackDoubleText(f.yesterday_close) + "\n";
   text += "yesterday_range_points: " + ASC_SymbolDataPackDoubleText(f.yesterday_range_points) + "\n";
   text += "two_days_ago_open: " + ASC_SymbolDataPackDoubleText(f.two_days_ago_open) + "\n";
   text += "two_days_ago_high: " + ASC_SymbolDataPackDoubleText(f.two_days_ago_high) + "\n";
   text += "two_days_ago_low: " + ASC_SymbolDataPackDoubleText(f.two_days_ago_low) + "\n";
   text += "two_days_ago_close: " + ASC_SymbolDataPackDoubleText(f.two_days_ago_close) + "\n";
   text += "two_days_ago_range_points: " + ASC_SymbolDataPackDoubleText(f.two_days_ago_range_points) + "\n";
   text += "five_day_high: " + ASC_SymbolDataPackDoubleText(f.five_day_high) + "\n";
   text += "five_day_low: " + ASC_SymbolDataPackDoubleText(f.five_day_low) + "\n";
   text += "twenty_day_high: " + ASC_SymbolDataPackDoubleText(f.twenty_day_high) + "\n";
   text += "twenty_day_low: " + ASC_SymbolDataPackDoubleText(f.twenty_day_low) + "\n";
   text += "w1_hydration_state: " + f.w1_hydration_state + "\n";
   text += "w1_retry_due: " + f.w1_retry_due + "\n";
   text += "w1_last_good_age_seconds: " + ASC_SymbolDataPackIntText(f.w1_last_good_age_seconds) + "\n";
   text += "current_week_open: " + ASC_SymbolDataPackDoubleText(f.current_week_open) + "\n";
   text += "current_week_high: " + ASC_SymbolDataPackDoubleText(f.current_week_high) + "\n";
   text += "current_week_low: " + ASC_SymbolDataPackDoubleText(f.current_week_low) + "\n";
   text += "current_week_current_close: " + ASC_SymbolDataPackDoubleText(f.current_week_current_close) + "\n";
   text += "current_week_range_points: " + ASC_SymbolDataPackDoubleText(f.current_week_range_points) + "\n";
   text += "previous_week_open: " + ASC_SymbolDataPackDoubleText(f.previous_week_open) + "\n";
   text += "previous_week_high: " + ASC_SymbolDataPackDoubleText(f.previous_week_high) + "\n";
   text += "previous_week_low: " + ASC_SymbolDataPackDoubleText(f.previous_week_low) + "\n";
   text += "previous_week_close: " + ASC_SymbolDataPackDoubleText(f.previous_week_close) + "\n";
   text += "previous_week_range_points: " + ASC_SymbolDataPackDoubleText(f.previous_week_range_points) + "\n";
   text += "two_weeks_ago_high: " + ASC_SymbolDataPackDoubleText(f.two_weeks_ago_high) + "\n";
   text += "two_weeks_ago_low: " + ASC_SymbolDataPackDoubleText(f.two_weeks_ago_low) + "\n";
   text += "four_week_high: " + ASC_SymbolDataPackDoubleText(f.four_week_high) + "\n";
   text += "four_week_low: " + ASC_SymbolDataPackDoubleText(f.four_week_low) + "\n";
   text += "twelve_week_high: " + ASC_SymbolDataPackDoubleText(f.twelve_week_high) + "\n";
   text += "twelve_week_low: " + ASC_SymbolDataPackDoubleText(f.twelve_week_low) + "\n";
   text += "mn1_hydration_state: " + f.mn1_hydration_state + "\n";
   text += "mn1_retry_due: " + f.mn1_retry_due + "\n";
   text += "mn1_last_good_age_seconds: " + ASC_SymbolDataPackIntText(f.mn1_last_good_age_seconds) + "\n";
   text += "current_month_open: " + ASC_SymbolDataPackDoubleText(f.current_month_open) + "\n";
   text += "current_month_high: " + ASC_SymbolDataPackDoubleText(f.current_month_high) + "\n";
   text += "current_month_low: " + ASC_SymbolDataPackDoubleText(f.current_month_low) + "\n";
   text += "current_month_current_close: " + ASC_SymbolDataPackDoubleText(f.current_month_current_close) + "\n";
   text += "previous_month_open: " + ASC_SymbolDataPackDoubleText(f.previous_month_open) + "\n";
   text += "previous_month_high: " + ASC_SymbolDataPackDoubleText(f.previous_month_high) + "\n";
   text += "previous_month_low: " + ASC_SymbolDataPackDoubleText(f.previous_month_low) + "\n";
   text += "previous_month_close: " + ASC_SymbolDataPackDoubleText(f.previous_month_close) + "\n";
   text += "three_month_high: " + ASC_SymbolDataPackDoubleText(f.three_month_high) + "\n";
   text += "three_month_low: " + ASC_SymbolDataPackDoubleText(f.three_month_low) + "\n";
   text += "six_month_high: " + ASC_SymbolDataPackDoubleText(f.six_month_high) + "\n";
   text += "six_month_low: " + ASC_SymbolDataPackDoubleText(f.six_month_low) + "\n";
   text += "High/Low Rule: numeric references only; support/resistance, trend, reversal, continuation, and action labels are intentionally absent.\n\n";
   return text;
  }


string ASC_SymbolDataPackAtrFactsText(const string symbol)
  {
   ENUM_TIMEFRAMES periods[9] = { PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1, PERIOD_MN1 };
   string text = "ATR / Volatility Facts\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_ATR) + "\n";
   text += "Owner Trace: CopyRates/MqlRates manual true-range factual wrapper\n";
   text += "Formula Basis: " + string(ASC_SDP_ATR_FORMULA_BASIS) + "\n";
   text += "Signal Safety: " + string(ASC_SDP_VOLATILITY_SIGNAL_SAFETY) + "\n";
   text += "| timeframe | atr_period | atr_source_method | atr_last_closed_value | atr_last_closed_bar_time | atr_current_preview_value | atr_current_preview_bar_time | atr_points | atr_price_units | atr_percent_of_price | atr_bars_used | atr_sample_count | bars_requested | bars_received | copyrates_error_code | atr_hydration_state | atr_retry_attempts | atr_retry_due | atr_last_good_value | atr_last_good_age_seconds | due_only_rule |\n";
   text += "|---|---:|---|---:|---|---:|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---:|---|---:|---:|---|\n";
   for(int i = 0; i < 9; i++)
     {
      ASC_SymbolDataPackAtrVolatilityFacts f;
      ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, periods[i], f);
      text += "| " + f.timeframe
              + " | " + IntegerToString(f.atr_period)
              + " | " + f.atr_source_method
              + " | " + ASC_SymbolDataPackDoubleText(f.atr_last_closed_value)
              + " | " + ASC_SymbolDataPackUtcText(f.atr_last_closed_bar_time)
              + " | " + ASC_SymbolDataPackDoubleText(f.atr_current_preview_value)
              + " | " + ASC_SymbolDataPackUtcText(f.atr_current_preview_bar_time)
              + " | " + ASC_SymbolDataPackDoubleText(f.atr_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.atr_price_units)
              + " | " + ASC_SymbolDataPackDoubleText(f.atr_percent_of_price)
              + " | " + IntegerToString(f.atr_bars_used)
              + " | " + IntegerToString(f.atr_sample_count)
              + " | " + IntegerToString(f.bars_requested)
              + " | " + IntegerToString(f.bars_received)
              + " | " + IntegerToString(f.copyrates_error_code)
              + " | " + f.atr_hydration_state
              + " | " + IntegerToString(f.atr_retry_attempts)
              + " | " + f.atr_retry_due
              + " | " + ASC_SymbolDataPackDoubleText(f.atr_last_good_value)
              + " | " + ASC_SymbolDataPackIntText(f.atr_last_good_age_seconds)
              + " | " + f.due_only_rule + " |\n";
     }
   text += "Closed / Preview Separation: last_closed ATR uses closed-bar index 1 onward; preview ATR uses current forming index 0 and is labelled preview.\n\n";
   return text;
  }

string ASC_SymbolDataPackVolatilityRangeFactsText(const string symbol)
  {
   ENUM_TIMEFRAMES periods[9] = { PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1, PERIOD_MN1 };
   ASC_SymbolDataPackDwmHighLowFacts d;
   ASC_SymbolDataPackReadDwmHighLowFacts(symbol, d);
   double point = 0.0;
   SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   string text = "Volatility / Range Factual Section\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_SWING_RANGE) + "\n";
   text += "Signal Safety: numeric ranges only; no pattern/action labels.\n";
   text += "DWM ranges: today_range_points=" + ASC_SymbolDataPackDoubleText(d.today_range_points)
           + " yesterday_range_points=" + ASC_SymbolDataPackDoubleText(d.yesterday_range_points)
           + " two_days_ago_range_points=" + ASC_SymbolDataPackDoubleText(d.two_days_ago_range_points)
           + " current_week_range_points=" + ASC_SymbolDataPackDoubleText(d.current_week_range_points)
           + " previous_week_range_points=" + ASC_SymbolDataPackDoubleText(d.previous_week_range_points)
           + " current_month_range_points=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackRangePoints(d.current_month_high, d.current_month_low, point))
           + " previous_month_range_points=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackRangePoints(d.previous_month_high, d.previous_month_low, point)) + "\n";
   text += "| timeframe | current_forming_range_points | last_closed_range_points | average_range_points | median_range_points | highest_range_points | lowest_range_points | range_to_atr14_ratio | range_lookback_bars | range_hydration_state |\n";
   text += "|---|---:|---:|---:|---:|---:|---:|---:|---:|---|\n";
   for(int i = 0; i < 9; i++)
     {
      ASC_SymbolDataPackAtrVolatilityFacts f;
      ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, periods[i], f);
      text += "| " + f.timeframe
              + " | " + ASC_SymbolDataPackDoubleText(f.current_forming_range_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.last_closed_range_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.average_range_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.median_range_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.highest_range_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.lowest_range_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.range_to_atr14_ratio)
              + " | " + IntegerToString(f.range_lookback_bars)
              + " | " + f.range_hydration_state + " |\n";
     }
   text += "Range Rule: average/median/highest/lowest use bounded closed-bar lookbacks; current forming ranges are labelled separately.\n\n";
   return text;
  }

string ASC_SymbolDataPackRangePositionFactsText(const string symbol)
  {
   ENUM_TIMEFRAMES periods[5] = { PERIOD_M15, PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1 };
   ASC_SymbolDataPackDwmHighLowFacts d;
   ASC_SymbolDataPackReadDwmHighLowFacts(symbol, d);
   double point = 0.0;
   SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   double current_price = d.today_current_close;
   string text = "Range-Position Factual Section\n";
   text += "Formula: position_percent=(current_price-range_low)/(range_high-range_low)*100\n";
   text += "Guard: divide-by-zero and high==low return 0.000000.\n";
   text += "Distance snapshots: today_high_points=" + ASC_SymbolDataPackDoubleText(point > 0.0 ? ASC_SymbolDataPackAbsDouble(d.today_high-current_price)/point : 0.0)
           + " today_low_points=" + ASC_SymbolDataPackDoubleText(point > 0.0 ? ASC_SymbolDataPackAbsDouble(current_price-d.today_low)/point : 0.0)
           + " previous_week_high_points=" + ASC_SymbolDataPackDoubleText(point > 0.0 ? ASC_SymbolDataPackAbsDouble(d.previous_week_high-current_price)/point : 0.0)
           + " current_month_high_points=" + ASC_SymbolDataPackDoubleText(point > 0.0 ? ASC_SymbolDataPackAbsDouble(d.current_month_high-current_price)/point : 0.0) + "\n";
   text += "| timeframe | position_last_50_range_percent | position_last_100_range_percent | position_last_20_range_percent | position_last_12_range_percent | guard |\n";
   text += "|---|---:|---:|---:|---:|---|\n";
   for(int i = 0; i < 5; i++)
     {
      ASC_SymbolDataPackAtrVolatilityFacts f;
      ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, periods[i], f);
      text += "| " + f.timeframe
              + " | " + ASC_SymbolDataPackDoubleText(f.position_last_50_range_percent)
              + " | " + ASC_SymbolDataPackDoubleText(f.position_last_100_range_percent)
              + " | " + ASC_SymbolDataPackDoubleText(f.position_last_20_range_percent)
              + " | " + ASC_SymbolDataPackDoubleText(f.position_last_12_range_percent)
              + " | numeric_percent_only_no_label |\n";
     }
   text += "Signal Safety: range position is a percent fact only; no zone, pattern, or action wording.\n\n";
   return text;
  }

string ASC_SymbolDataPackPullbackDepthFactsText(const string symbol)
  {
   ENUM_TIMEFRAMES periods[4] = { PERIOD_M15, PERIOD_H1, PERIOD_H4, PERIOD_D1 };
   ASC_SymbolDataPackDwmHighLowFacts d;
   ASC_SymbolDataPackReadDwmHighLowFacts(symbol, d);
   double current_price = d.today_current_close;
   string text = "Pullback-Depth Factual Section\n";
   text += "Definitions: pullback_from_high_percent=abs(recent_high-current_price)/recent_high*100; pullback_from_low_percent=abs(current_price-recent_low)/recent_low*100.\n";
   text += "Period pullbacks: today_high_percent=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafePercent(ASC_SymbolDataPackAbsDouble(d.today_high-current_price), d.today_high))
           + " yesterday_high_percent=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafePercent(ASC_SymbolDataPackAbsDouble(d.yesterday_high-current_price), d.yesterday_high))
           + " current_week_high_percent=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafePercent(ASC_SymbolDataPackAbsDouble(d.current_week_high-current_price), d.current_week_high))
           + " previous_week_high_percent=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafePercent(ASC_SymbolDataPackAbsDouble(d.previous_week_high-current_price), d.previous_week_high)) + "\n";
   text += "| timeframe | lookback_bars | distance_from_recent_high_points | distance_from_recent_low_points | distance_from_recent_high_percent | distance_from_recent_low_percent | distance_from_recent_high_atr_ratio | distance_from_recent_low_atr_ratio | pullback_from_recent_high_percent | pullback_from_recent_low_percent | pullback_hydration_state | signal_guard |\n";
   text += "|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|---|\n";
   for(int i = 0; i < 4; i++)
     {
      ASC_SymbolDataPackAtrVolatilityFacts f;
      ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, periods[i], f);
      text += "| " + f.timeframe
              + " | " + IntegerToString(f.pullback_lookback_bars)
              + " | " + ASC_SymbolDataPackDoubleText(f.distance_from_recent_high_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.distance_from_recent_low_points)
              + " | " + ASC_SymbolDataPackDoubleText(f.distance_from_recent_high_percent)
              + " | " + ASC_SymbolDataPackDoubleText(f.distance_from_recent_low_percent)
              + " | " + ASC_SymbolDataPackDoubleText(f.distance_from_recent_high_atr_ratio)
              + " | " + ASC_SymbolDataPackDoubleText(f.distance_from_recent_low_atr_ratio)
              + " | " + ASC_SymbolDataPackDoubleText(f.pullback_from_recent_high_percent)
              + " | " + ASC_SymbolDataPackDoubleText(f.pullback_from_recent_low_percent)
              + " | " + f.pullback_hydration_state
              + " | numeric_distance_only |\n";
     }
   text += "Signal Safety: pullback depth is numeric distance only; no timing, no permission, no pattern label.\n\n";
   return text;
  }

string ASC_SymbolDataPackSpreadToVolatilityBurdenText(const string symbol)
  {
   ASC_SymbolDataPackTickSpreadStats s;
   ASC_SymbolDataPackReadTickSpreadStats(symbol, s);
   ASC_SymbolDataPackAtrVolatilityFacts m1,m5,m15,h1;
   ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_M1, m1);
   ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_M5, m5);
   ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_M15, m15);
   ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_H1, h1);
   string text = "Spread-To-Volatility Burden Factual Section\n";
   text += "Section: spread_to_atr_and_range_cost_context\n";
   text += "Formula Guard: ratios return 0.000000 when spread, ATR, range, or point denominator is zero.\n";
   text += "| field | formula | value | guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| current_spread_to_M1_ATR | spread_current_points/M1_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_current_points, m1.atr_points)) + " | cost_context_only |\n";
   text += "| current_spread_to_M5_ATR | spread_current_points/M5_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_current_points, m5.atr_points)) + " | cost_context_only |\n";
   text += "| current_spread_to_M15_ATR | spread_current_points/M15_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_current_points, m15.atr_points)) + " | cost_context_only |\n";
   text += "| current_spread_to_H1_ATR | spread_current_points/H1_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_current_points, h1.atr_points)) + " | cost_context_only |\n";
   text += "| spread_avg_60s_to_M15_ATR | spread_avg_points_60s/M15_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_avg_points_60s, m15.atr_points)) + " | cost_context_only |\n";
   text += "| spread_avg_300s_to_M15_ATR | spread_avg_points_300s/M15_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_avg_points_300s, m15.atr_points)) + " | cost_context_only |\n";
   text += "| spread_avg_300s_to_H1_ATR | spread_avg_points_300s/H1_ATR_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_avg_points_300s, h1.atr_points)) + " | cost_context_only |\n";
   text += "| spread_avg_300s_to_M15_average_range | spread_avg_points_300s/M15_average_range_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_avg_points_300s, m15.average_range_points)) + " | cost_context_only |\n";
   text += "| spread_avg_300s_to_H1_average_range | spread_avg_points_300s/H1_average_range_points | " + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio(s.spread_avg_points_300s, h1.average_range_points)) + " | cost_context_only |\n";
   text += "| spread_widening_vs_300s_avg_percent | preserved_RUN163_field | " + ASC_SymbolDataPackDoubleText(s.spread_widening_vs_300s_avg_percent) + " | factual_only |\n";
   text += "Signal Safety: burden is cost-to-movement context only; no permission, no instruction.\n\n";
   return text;
  }


string ASC_SymbolDataPackOneVwapLine(const ASC_SymbolDataPackVwapFacts &f)
  {
   return "| " + f.anchor_name
          + " | " + ASC_SymbolDataPackUtcText(f.anchor_time)
          + " | " + f.anchor_source
          + " | " + ASC_SymbolDataPackUtcText(f.coverage_start)
          + " | " + ASC_SymbolDataPackUtcText(f.coverage_end)
          + " | " + ASC_SymbolDataPackIntText(f.sample_count)
          + " | " + f.volume_source_used
          + " | " + ASC_SymbolDataPackDoubleText(f.volume_total)
          + " | " + ASC_SymbolDataPackDoubleText(f.vwap_value)
          + " | " + ASC_SymbolDataPackDoubleText(f.current_price_distance_points)
          + " | " + ASC_SymbolDataPackDoubleText(f.current_price_distance_percent)
          + " | " + ASC_SymbolDataPackDoubleText(f.current_price_distance_atr_ratio)
          + " | " + f.hydration_state
          + " | " + f.retry_due
          + " | " + ASC_SymbolDataPackDoubleText(f.last_good_value)
          + " | " + ASC_SymbolDataPackIntText(f.last_good_age_seconds)
          + " | " + f.partial_coverage_state
          + " | " + f.signal_safety
          + " |\n";
  }

string ASC_SymbolDataPackVwapFormulaDecisionText()
  {
   string text = "VWAP Formula / Source Method Decision\n";
   text += "| VWAP Method | Data Source | Pros | Risks | Chosen? | Reason |\n";
   text += "|---|---|---|---|---:|---|\n";
   text += "| existing Aurora owner | none found in Symbol Data Pack baseline | avoids duplicate owner | no current VWAP owner observed | no | no safe existing owner found in package |\n";
   text += "| MqlRates HLC3 x volume | CopyRates M1 MqlRates tick_volume/real_volume | bounded and traceable | broker tick volume limitation | yes | official MqlRates exposes OHLC plus tick_volume/real_volume |\n";
   text += "| tick data VWAP | CopyTicks | fresher tick-level sample | heavier and short-window only | no | preserve due-only and avoid tick spam |\n";
   text += "| source-ready contract only | no calculation | lowest compile risk | report-only risk | no | RUN166R can safely fill bounded M1 MqlRates VWAP facts |\n\n";
   text += "Formula fields: formula_basis=" + string(ASC_SDP_VWAP_FORMULA_BASIS) + "; typical_price_method=" + string(ASC_SDP_VWAP_TYPICAL_PRICE_METHOD) + "; volume_source=tick_volume_or_real_volume_with_quality_label; broker_time_basis=MqlRates.time/server time.\n\n";
   return text;
  }

string ASC_SymbolDataPackVwapTableHeader()
  {
   return "| anchor | anchor_time | anchor_source | coverage_start | coverage_end | sample_count | volume_source | volume_total | vwap_value | current_price_distance_points | current_price_distance_percent | distance_atr_ratio | hydration_state | retry_due | last_good_value | last_good_age_seconds | partial_coverage_state | guard |\n|---|---|---|---|---|---:|---|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
  }

string ASC_SymbolDataPackSessionCurrentDayVwapText(const string symbol)
  {
   datetime today = ASC_SymbolDataPackDayStart(TimeCurrent());
   ASC_SymbolDataPackVwapFacts session;
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "session_current_day", "session_vwap/current_day_vwap", today, "broker_day_start_MqlRates_time", session);
   string text = "Session / Current-Day VWAP Facts\n";
   text += "Rules: numeric context only; no direction labels; no reference-level authority; no permission language.\n";
   text += ASC_SymbolDataPackVwapTableHeader();
   text += ASC_SymbolDataPackOneVwapLine(session);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackDailyPreviousVwapText(const string symbol)
  {
   datetime today = ASC_SymbolDataPackDayStart(TimeCurrent());
   datetime yesterday = today - 86400;
   datetime two_days_ago = today - 172800;
   ASC_SymbolDataPackVwapFacts current_day, previous_day;
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "daily_vwap", "current_day_vwap", today, "broker_day_start_current", current_day);
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "daily_vwap", "previous_day_vwap", yesterday, "broker_day_start_previous_open_to_current_available_window", previous_day);
   string text = "Daily / Previous-Day VWAP Facts\n";
   text += "Previous-day value is exposed only with coverage/sample metadata; completeness is not implied if M1 cap creates partial coverage.\n";
   text += "two_days_ago_anchor_source_ready: " + ASC_SymbolDataPackUtcText(two_days_ago) + "\n";
   text += ASC_SymbolDataPackVwapTableHeader();
   text += ASC_SymbolDataPackOneVwapLine(current_day);
   text += ASC_SymbolDataPackOneVwapLine(previous_day);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackAnchoredVwapText(const string symbol)
  {
   datetime now_utc = TimeCurrent();
   ASC_SymbolDataPackVwapFacts a0,a1,a2,a3,a4,a5;
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "anchored_vwap", "today_open_anchor_vwap", ASC_SymbolDataPackDayStart(now_utc), "broker_day_start_time_anchor", a0);
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "anchored_vwap", "yesterday_open_anchor_vwap", ASC_SymbolDataPackDayStart(now_utc)-86400, "broker_previous_day_start_time_anchor", a1);
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "anchored_vwap", "current_week_open_anchor_vwap", ASC_SymbolDataPackWeekStart(now_utc, 0), "broker_week_start_time_anchor", a2);
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "anchored_vwap", "previous_week_open_anchor_vwap", ASC_SymbolDataPackWeekStart(now_utc, -1), "broker_previous_week_start_time_anchor", a3);
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "anchored_vwap", "current_month_open_anchor_vwap", ASC_SymbolDataPackMonthStart(now_utc, 0), "broker_month_start_time_anchor", a4);
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "anchored_vwap", "previous_month_open_anchor_vwap", ASC_SymbolDataPackMonthStart(now_utc, -1), "broker_previous_month_start_time_anchor", a5);
   string text = "Anchored VWAP Facts\n";
   text += "Anchor rule: time-based anchors only; no discretionary event anchor and no reference-level label.\n";
   text += ASC_SymbolDataPackVwapTableHeader();
   text += ASC_SymbolDataPackOneVwapLine(a0);
   text += ASC_SymbolDataPackOneVwapLine(a1);
   text += ASC_SymbolDataPackOneVwapLine(a2);
   text += ASC_SymbolDataPackOneVwapLine(a3);
   text += ASC_SymbolDataPackOneVwapLine(a4);
   text += ASC_SymbolDataPackOneVwapLine(a5);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackVolumeSourceQualityText(const string symbol)
  {
   ASC_SymbolDataPackVwapFacts f;
   ASC_SymbolDataPackReadVwapFromAnchor(symbol, "volume_source_quality", "current_day_volume_quality", ASC_SymbolDataPackDayStart(TimeCurrent()), "broker_day_start_volume_quality_window", f);
   string text = "Volume-Source Quality Facts\n";
   text += "| field | value | source | guard |\n";
   text += "|---|---|---|---|\n";
   text += "| volume_source_used | " + f.volume_source_used + " | MqlRates.tick_volume/real_volume | label proxy vs real volume |\n";
   text += "| real_volume_available | " + ASC_SymbolDataPackBoolText(f.real_volume_available) + " | MqlRates.real_volume | do not imply centralized volume when absent |\n";
   text += "| tick_volume_available | " + ASC_SymbolDataPackBoolText(f.tick_volume_available) + " | MqlRates.tick_volume | activity proxy only |\n";
   text += "| volume_source_quality | " + f.volume_source_quality + " | computed quality label | factual limitation visible |\n";
   text += "| volume_sample_count | " + ASC_SymbolDataPackIntText(f.volume_sample_count) + " | sampled M1 bars | no fake complete value |\n";
   text += "| zero_volume_bar_count | " + ASC_SymbolDataPackIntText(f.zero_volume_bar_count) + " | sampled M1 bars | zero-volume guard |\n";
   text += "| missing_volume_bar_count | " + ASC_SymbolDataPackIntText(f.missing_volume_bar_count) + " | sampled M1 bars | hydration/retry evidence |\n";
   text += "| volume_coverage_percent | " + ASC_SymbolDataPackDoubleText(f.volume_coverage_percent) + " | volume_sample_count/sample_count | coverage not permission |\n";
   text += "| broker_volume_limitation_reason | " + f.broker_volume_limitation_reason + " | source quality decision | limitation cannot be hidden |\n\n";
   return text;
  }
string ASC_SymbolDataPackIndicatorPairLine(const ASC_SymbolDataPackIndicatorValuePair &f)
  {
   return "| " + f.timeframe_text
          + " | " + f.value_name
          + " | period=" + IntegerToString(f.period)
          + " | applied_price=" + f.applied_price
          + " | last_closed_bar_index=" + IntegerToString(f.bar_index_last_closed)
          + " | last_closed_value=" + ASC_SymbolDataPackDoubleText(f.last_closed_value)
          + " | preview_bar_index=" + IntegerToString(f.bar_index_preview)
          + " | preview_value=" + ASC_SymbolDataPackDoubleText(f.preview_value)
          + " | sample_count=" + IntegerToString(f.sample_count)
          + " | bars_calculated=" + IntegerToString(f.bars_calculated)
          + " | values_requested=" + IntegerToString(f.values_requested)
          + " | values_received=" + IntegerToString(f.values_received)
          + " | state=" + f.hydration_state
          + " | retry_due=" + f.retry_due
          + " | last_good_value=" + ASC_SymbolDataPackDoubleText(f.last_good_value)
          + " | last_good_age_seconds=" + ASC_SymbolDataPackIntText(f.last_good_age_seconds)
          + " | source=" + f.source_method
          + " | safety=" + f.signal_safety + " |\n";
  }

string ASC_SymbolDataPackMAFamilyText(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   string text = "";
   ASC_SymbolDataPackIndicatorValuePair ma;
   double price = iClose(symbol, timeframe, ASC_SDP_INDICATOR_BAR_CLOSED);
   double point = 0.0;
   SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   int periods[3] = {ASC_SDP_INDICATOR_MA_PERIOD_FAST, ASC_SDP_INDICATOR_MA_PERIOD_MEDIUM, ASC_SDP_INDICATOR_MA_PERIOD_SLOW};
   for(int i=0; i<3; i++)
     {
      ASC_SymbolDataPackReadMAValue(symbol, timeframe, periods[i], MODE_SMA, "SMA", ma);
      double distance_points = (point > 0.0 ? (price - ma.last_closed_value) / point : 0.0);
      double distance_percent = ASC_SymbolDataPackSafePercent(price - ma.last_closed_value, ma.last_closed_value);
      text += ASC_SymbolDataPackIndicatorPairLine(ma);
      text += "Distance: timeframe=" + ma.timeframe_text + " value_name=" + ma.value_name + " current_price=" + ASC_SymbolDataPackDoubleText(price) + " distance_points=" + ASC_SymbolDataPackDoubleText(distance_points) + " distance_percent=" + ASC_SymbolDataPackDoubleText(distance_percent) + " distance_atr_ratio=pending_atr_crosslink_guarded |\n";
      ASC_SymbolDataPackReadMAValue(symbol, timeframe, periods[i], MODE_EMA, "EMA", ma);
      distance_points = (point > 0.0 ? (price - ma.last_closed_value) / point : 0.0);
      distance_percent = ASC_SymbolDataPackSafePercent(price - ma.last_closed_value, ma.last_closed_value);
      text += ASC_SymbolDataPackIndicatorPairLine(ma);
      text += "Distance: timeframe=" + ma.timeframe_text + " value_name=" + ma.value_name + " current_price=" + ASC_SymbolDataPackDoubleText(price) + " distance_points=" + ASC_SymbolDataPackDoubleText(distance_points) + " distance_percent=" + ASC_SymbolDataPackDoubleText(distance_percent) + " distance_atr_ratio=pending_atr_crosslink_guarded |\n";
     }
   return text;
  }

string ASC_SymbolDataPackMovingAverageFactsText(const string symbol)
  {
   string text = "Moving Average Numeric Facts\n";
   text += "Source Method: " + string(ASC_SDP_INDICATOR_SOURCE_METHOD) + "\n";
   text += "Runtime Handle Cache Plan: " + string(ASC_SDP_INDICATOR_CACHE_PLAN) + "\n";
   text += "Rules: values/distances only; no alignment, cross, permission, or action language.\n";
   text += "| Timeframe | Value Name | Period | Applied Price | Last Closed Bar Index | Last Closed Value | Preview Bar Index | Preview Value | Sample Count | Bars Calculated | Values Requested | Values Received | State | Retry Due | Last Good Value | Last Good Age Seconds | Source | Safety |\n";
   text += "|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
   text += ASC_SymbolDataPackMAFamilyText(symbol, PERIOD_M15);
   text += ASC_SymbolDataPackMAFamilyText(symbol, PERIOD_M30);
   text += ASC_SymbolDataPackMAFamilyText(symbol, PERIOD_H1);
   text += ASC_SymbolDataPackMAFamilyText(symbol, PERIOD_H4);
   text += ASC_SymbolDataPackMAFamilyText(symbol, PERIOD_D1);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackRSIFactsText(const string symbol)
  {
   string text = "RSI Numeric Facts\n";
   text += "Rule: RSI value only; no threshold labels, reversal labels, or permission language.\n";
   text += "| Timeframe | Value Name | Period | Applied Price | Last Closed Bar Index | Last Closed Value | Preview Bar Index | Preview Value | Sample Count | Bars Calculated | Values Requested | Values Received | State | Retry Due | Last Good Value | Last Good Age Seconds | Source | Safety |\n";
   text += "|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
   ASC_SymbolDataPackIndicatorValuePair f;
   ASC_SymbolDataPackReadRSIValue(symbol, PERIOD_M15, f); text += ASC_SymbolDataPackIndicatorPairLine(f);
   ASC_SymbolDataPackReadRSIValue(symbol, PERIOD_M30, f); text += ASC_SymbolDataPackIndicatorPairLine(f);
   ASC_SymbolDataPackReadRSIValue(symbol, PERIOD_H1, f); text += ASC_SymbolDataPackIndicatorPairLine(f);
   ASC_SymbolDataPackReadRSIValue(symbol, PERIOD_H4, f); text += ASC_SymbolDataPackIndicatorPairLine(f);
   ASC_SymbolDataPackReadRSIValue(symbol, PERIOD_D1, f); text += ASC_SymbolDataPackIndicatorPairLine(f);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackMACDLineText(const ASC_SymbolDataPackMacdFacts &f)
  {
   string text = ASC_SymbolDataPackIndicatorPairLine(f.macd_line);
   text += ASC_SymbolDataPackIndicatorPairLine(f.signal_line);
   text += "Histogram: timeframe=" + f.macd_line.timeframe_text + " formula_basis=" + f.histogram_formula_basis + " last_closed_value=" + ASC_SymbolDataPackDoubleText(f.histogram_last_closed_value) + " preview_value=" + ASC_SymbolDataPackDoubleText(f.histogram_preview_value) + " safety=" + string(ASC_SDP_INDICATOR_SIGNAL_SAFETY) + " |\n";
   return text;
  }

string ASC_SymbolDataPackMACDFactsText(const string symbol)
  {
   string text = "MACD Numeric Facts\n";
   text += "Parameters: fast_ema=12 slow_ema=26 signal_ema=9 applied_price=PRICE_CLOSE. Rule: line/signal/histogram values only.\n";
   text += "| Timeframe | Value Name | Period | Applied Price | Last Closed Bar Index | Last Closed Value | Preview Bar Index | Preview Value | Sample Count | Bars Calculated | Values Requested | Values Received | State | Retry Due | Last Good Value | Last Good Age Seconds | Source | Safety |\n";
   text += "|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
   ASC_SymbolDataPackMacdFacts f;
   ASC_SymbolDataPackReadMACDFacts(symbol, PERIOD_M15, f); text += ASC_SymbolDataPackMACDLineText(f);
   ASC_SymbolDataPackReadMACDFacts(symbol, PERIOD_M30, f); text += ASC_SymbolDataPackMACDLineText(f);
   ASC_SymbolDataPackReadMACDFacts(symbol, PERIOD_H1, f); text += ASC_SymbolDataPackMACDLineText(f);
   ASC_SymbolDataPackReadMACDFacts(symbol, PERIOD_H4, f); text += ASC_SymbolDataPackMACDLineText(f);
   ASC_SymbolDataPackReadMACDFacts(symbol, PERIOD_D1, f); text += ASC_SymbolDataPackMACDLineText(f);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackBandsLineText(const ASC_SymbolDataPackBandsFacts &f)
  {
   string text = ASC_SymbolDataPackIndicatorPairLine(f.upper_band);
   text += ASC_SymbolDataPackIndicatorPairLine(f.middle_band);
   text += ASC_SymbolDataPackIndicatorPairLine(f.lower_band);
   text += "Bands Derived: timeframe=" + f.middle_band.timeframe_text + " width_points=" + ASC_SymbolDataPackDoubleText(f.width_points_last_closed) + " width_percent=" + ASC_SymbolDataPackDoubleText(f.width_percent_last_closed) + " band_position_percent=" + ASC_SymbolDataPackDoubleText(f.position_percent_last_closed) + " formula_basis=" + f.position_formula_basis + " divide_guard=" + f.divide_guard + " safety=" + string(ASC_SDP_INDICATOR_SIGNAL_SAFETY) + " |\n";
   return text;
  }

string ASC_SymbolDataPackBandsFactsText(const string symbol)
  {
   string text = "Bollinger Band Numeric Facts\n";
   text += "Parameters: period=20 deviation=2 applied_price=PRICE_CLOSE. Rule: upper/middle/lower/width/position-percent values only.\n";
   text += "| Timeframe | Value Name | Period | Applied Price | Last Closed Bar Index | Last Closed Value | Preview Bar Index | Preview Value | Sample Count | Bars Calculated | Values Requested | Values Received | State | Retry Due | Last Good Value | Last Good Age Seconds | Source | Safety |\n";
   text += "|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
   ASC_SymbolDataPackBandsFacts f;
   ASC_SymbolDataPackReadBandsFacts(symbol, PERIOD_M15, f); text += ASC_SymbolDataPackBandsLineText(f);
   ASC_SymbolDataPackReadBandsFacts(symbol, PERIOD_M30, f); text += ASC_SymbolDataPackBandsLineText(f);
   ASC_SymbolDataPackReadBandsFacts(symbol, PERIOD_H1, f); text += ASC_SymbolDataPackBandsLineText(f);
   ASC_SymbolDataPackReadBandsFacts(symbol, PERIOD_H4, f); text += ASC_SymbolDataPackBandsLineText(f);
   ASC_SymbolDataPackReadBandsFacts(symbol, PERIOD_D1, f); text += ASC_SymbolDataPackBandsLineText(f);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackADXLineText(const ASC_SymbolDataPackAdxFacts &f)
  {
   string text = ASC_SymbolDataPackIndicatorPairLine(f.adx_value);
   text += ASC_SymbolDataPackIndicatorPairLine(f.plus_di_value);
   text += ASC_SymbolDataPackIndicatorPairLine(f.minus_di_value);
   return text;
  }

string ASC_SymbolDataPackADXFactsText(const string symbol)
  {
   string text = "ADX / DI Numeric Facts\n";
   text += "Rule: ADX/+DI/-DI numbers only; no readiness, permission, or direction language.\n";
   text += "| Timeframe | Value Name | Period | Applied Price | Last Closed Bar Index | Last Closed Value | Preview Bar Index | Preview Value | Sample Count | Bars Calculated | Values Requested | Values Received | State | Retry Due | Last Good Value | Last Good Age Seconds | Source | Safety |\n";
   text += "|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
   ASC_SymbolDataPackAdxFacts f;
   ASC_SymbolDataPackReadADXFacts(symbol, PERIOD_M15, f); text += ASC_SymbolDataPackADXLineText(f);
   ASC_SymbolDataPackReadADXFacts(symbol, PERIOD_M30, f); text += ASC_SymbolDataPackADXLineText(f);
   ASC_SymbolDataPackReadADXFacts(symbol, PERIOD_H1, f); text += ASC_SymbolDataPackADXLineText(f);
   ASC_SymbolDataPackReadADXFacts(symbol, PERIOD_H4, f); text += ASC_SymbolDataPackADXLineText(f);
   ASC_SymbolDataPackReadADXFacts(symbol, PERIOD_D1, f); text += ASC_SymbolDataPackADXLineText(f);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackStdDevLineText(const ASC_SymbolDataPackStdDevZScoreFacts &f)
  {
   string text = ASC_SymbolDataPackIndicatorPairLine(f.stddev_value);
   text += ASC_SymbolDataPackIndicatorPairLine(f.mean_value);
   text += "Z-Score Derived: timeframe=" + f.stddev_value.timeframe_text + " price_minus_mean=" + ASC_SymbolDataPackDoubleText(f.price_minus_mean_last_closed) + " z_score=" + ASC_SymbolDataPackDoubleText(f.zscore_last_closed) + " formula_basis=" + f.zscore_formula_basis + " zero_guard=" + f.stddev_zero_guard + " safety=" + string(ASC_SDP_INDICATOR_SIGNAL_SAFETY) + " |\n";
   return text;
  }

string ASC_SymbolDataPackStdDevZScoreFactsText(const string symbol)
  {
   string text = "Standard Deviation / Z-Score Numeric Facts\n";
   text += "Rule: standard deviation, mean, price-minus-mean, and z-score numbers only; no interpretation labels.\n";
   text += "| Timeframe | Value Name | Period | Applied Price | Last Closed Bar Index | Last Closed Value | Preview Bar Index | Preview Value | Sample Count | Bars Calculated | Values Requested | Values Received | State | Retry Due | Last Good Value | Last Good Age Seconds | Source | Safety |\n";
   text += "|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|---|---:|---:|---|---|\n";
   ASC_SymbolDataPackStdDevZScoreFacts f;
   ASC_SymbolDataPackReadStdDevZScoreFacts(symbol, PERIOD_M15, f); text += ASC_SymbolDataPackStdDevLineText(f);
   ASC_SymbolDataPackReadStdDevZScoreFacts(symbol, PERIOD_M30, f); text += ASC_SymbolDataPackStdDevLineText(f);
   ASC_SymbolDataPackReadStdDevZScoreFacts(symbol, PERIOD_H1, f); text += ASC_SymbolDataPackStdDevLineText(f);
   ASC_SymbolDataPackReadStdDevZScoreFacts(symbol, PERIOD_H4, f); text += ASC_SymbolDataPackStdDevLineText(f);
   ASC_SymbolDataPackReadStdDevZScoreFacts(symbol, PERIOD_D1, f); text += ASC_SymbolDataPackStdDevLineText(f);
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackIndicatorHydrationTableText()
  {
   string text = "| Failure / Pending Mode | Detection | Retry / Hydration Rule | Output State |\n";
   text += "|---|---|---|---|\n";
   text += "| ready | handle valid, BarsCalculated sufficient, CopyBuffer receives closed + preview values | publish numeric values, source, sample count, freshness | indicator_state_ready |\n";
   text += "| collecting | no prior source attempt in section | retry on next due timeframe or hydration target | indicator_state_collecting |\n";
   text += "| handle invalid | iMA/iRSI/iMACD/iBands/iADX/iStdDev returns INVALID_HANDLE | expose family/timeframe/parameters and retry due | indicator_state_handle_invalid |\n";
   text += "| buffer loading | BarsCalculated <= 0 or CopyBuffer <= 0 | bounded retry; no hard absence | indicator_state_buffer_loading |\n";
   text += "| partial copy | CopyBuffer returned less than requested | show values requested/received | indicator_state_partial_copy |\n";
   text += "| insufficient bars | BarsCalculated below formula warmup | show required/available bars | indicator_state_insufficient_bars |\n";
   text += "| last-good | future persisted value exists while refresh fails | show value and age in same pack | indicator_state_last_good |\n";
   text += "| hard absence | only after future health proof confirms source cannot exist | never default to absent from first failure | indicator_state_hard_absence_proven |\n";
   return text;
  }

string ASC_SymbolDataPackIndicatorDueOnlyTableText()
  {
   string text = "| Indicator Family | Recalculate When | Preview Allowed? | Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| M1 indicator facts | new M1 closed bar only | yes, labelled preview only | precision/freshness lens, not decision brain |\n";
   text += "| M5 indicator facts | new M5 closed bar only | yes, labelled preview only | precision/freshness lens, not decision brain |\n";
   text += "| M15 indicator facts | new M15 closed bar only | yes, labelled preview only | primary intraday Lite context candidate |\n";
   text += "| M30 indicator facts | new M30 closed bar only | yes, labelled preview only | MTF context bridge |\n";
   text += "| H1/H4 indicator facts | new source timeframe closed bar only | yes, labelled preview only | do not recalc per heartbeat |\n";
   text += "| D1 indicator facts | new D1 closed bar only | yes, labelled preview only | daily context, no per-tick churn |\n";
   text += "| distance fields | quote refresh if cheap and source value already known | n/a | no full indicator handle churn for distance-only update |\n";
   text += "| full pack publish | indicator section changed or proof heartbeat due | n/a | no unchanged file churn |\n";
   return text;
  }

string ASC_SymbolDataPackIndicatorMethodDecisionText()
  {
   string text = "Indicator Source Method Decision\n";
   text += "| Indicator | Possible Source | Chosen Source | Reason | Buffer / Formula Risk |\n";
   text += "|---|---|---|---|---|\n";
   text += "| SMA/EMA | existing owner, iMA, manual formula | iMA handle + CopyBuffer | official terminal calculation, lower formula drift | handle lifecycle and BarsCalculated guarded |\n";
   text += "| RSI | existing owner, iRSI, manual formula | iRSI handle + CopyBuffer | official buffer avoids hand-coded smoothing drift | value-only guard prevents threshold labels |\n";
   text += "| MACD | existing owner, iMACD, manual EMA | iMACD handle + CopyBuffer; histogram calculated as line minus signal | official line/signal buffers, explicit histogram formula | buffer index and histogram formula guarded |\n";
   text += "| Bollinger Bands | existing owner, iBands, manual SMA/stddev | iBands handle + CopyBuffer; width/position derived | official bands, explicit divide guard | upper/middle/lower buffer index guarded |\n";
   text += "| ADX/+DI/-DI | existing owner, iADX, manual Wilder formula | iADX handle + CopyBuffer | official buffers avoid formula bloat | buffer index and non-directional wording guarded |\n";
   text += "| StdDev/Z-score | iStdDev + iMA or manual | iStdDev + iMA, z-score formula derived | traceable standard deviation and mean basis | zero standard deviation guard |\n\n";
   return text;
  }
string ASC_SymbolDataPackRun171ActivationProofText(const string symbol,const string server_root)
  {
   string text = "RUN171 Bounded Runtime Activation\n";
   text += "activation_enabled=true\n";
   text += "activation_mode=" + string(ASC_SYMBOL_DATA_PACK_BOUNDED_RUNTIME_MODE) + "\n";
   text += "activation_symbol_source=runtime_selected_or_top_symbol_route\n";
   text += "activation_symbol=" + symbol + "\n";
   text += "activation_reason=RUN170_hold_absorbed_lite_source_existed_but_runtime_callsite_and_output_proof_were_absent\n";
   text += "activation_due=due_only_by_" + IntegerToString(ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS) + "s_proof_heartbeat\n";
   text += "activation_write_mode=real_atomic_write_bounded_one_symbol\n";
   text += "runtime_callsite=ASC_ServiceSymbolDataPackLiteRuntimeActivation\n";
   text += "runtime_budget_rule=one_symbol_due_only_no_full_universe_activation\n";
   text += "output_flat_transition_final_path=" + ASC_SymbolDataPackExpectedOutputPathText(server_root, symbol, false) + "\n";
   text += "output_flat_transition_temp_path=" + ASC_SymbolDataPackExpectedOutputPathText(server_root, symbol, true) + "\n";
   text += "output_flat_transition_last_good_path=" + ASC_SymbolDataPackExpectedOutputPathText(server_root, symbol, false) + "\n";
   text += "output_globaltop10_target_final_path=" + ASC_SymbolDataPackExpectedOutputPathTextForRoute(server_root, symbol, ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10, "", false) + "\n";
   text += "output_top5perbucket_target_pattern=" + ASC_SymbolDataPackExpectedTop5PerBucketOutputPatternText(server_root, symbol, false) + "\n";
   text += "RUN172 Triple-Check Seed: verify callsite, flags, writer path, proof surfaces, package, protected areas, and compile-risk before RUN173.\n";
   text += "RUN173 Live Proof Seed: capture Scanner Status, Artifact Bundle Manifest, Symbol Data Pack Lite final/temp/last-good/no-change state, logs, and protected artifacts.\n\n";
   return text;
  }


string ASC_SymbolDataPackAssetIdentityValue(const string raw_value,const string fallback_value="unknown")
  {
   string value = raw_value;
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0)
      value = fallback_value;
   StringReplace(value, "\r", " ");
   StringReplace(value, "\n", " ");
   StringReplace(value, "\t", " ");
   return value;
  }

string ASC_SymbolDataPackIdentityClassificationSource(const bool lookup_ok,
                                                       const ASC_SymbolClassification &classification)
  {
   if(lookup_ok && classification.resolved)
      return "ClassificationBridge/resolved";
   if(lookup_ok)
      return "ClassificationBridge/unresolved";
   return "ClassificationBridge/missing";
  }

string ASC_SymbolDataPackIdentityMissingReason(const bool lookup_ok,
                                                const ASC_SymbolClassification &classification)
  {
   if(lookup_ok && classification.resolved)
      return "not_applicable";
   string reason = classification.resolution_state;
   StringTrimLeft(reason);
   StringTrimRight(reason);
   if(StringLen(reason) <= 0)
      reason = classification.review_status;
   if(StringLen(reason) <= 0)
      reason = classification.notes;
   if(StringLen(reason) <= 0)
      reason = lookup_ok ? "classification_lookup_unresolved" : "classification_lookup_failed";
   StringReplace(reason, "\r", " ");
   StringReplace(reason, "\n", " ");
   StringReplace(reason, "\t", " ");
   return reason;
  }

string ASC_SymbolDataPackIdentitySymbolFamily(const ASC_SymbolClassification &classification)
  {
   string asset = ASC_SymbolDataPackAssetIdentityValue(classification.asset_class, "Unknown");
   string family = "";

   if(StringLen(ASC_SymbolDataPackAssetIdentityValue(classification.stock_family_name, "")) > 0
      && classification.stock_family_name != "Not Applicable")
      family = classification.stock_family_name;
   else if(StringLen(ASC_SymbolDataPackAssetIdentityValue(classification.sub_bucket_name, "")) > 0
           && classification.sub_bucket_name != "Not Applicable")
      family = classification.sub_bucket_name;
   else if(StringLen(ASC_SymbolDataPackAssetIdentityValue(classification.primary_bucket, "")) > 0)
      family = classification.primary_bucket;
   else
      family = asset;

   return ASC_SymbolDataPackAssetIdentityValue(asset + " / " + family, "Unknown / Unknown");
  }

string ASC_SymbolDataPackAssetIdentityBlock(const string symbol)
  {
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   ASC_SymbolClassification classification;
   bool lookup_ok = ASC_LookupClassification(AccountInfoString(ACCOUNT_SERVER), identity, classification);

   string asset_class = ASC_SymbolDataPackAssetIdentityValue(classification.asset_class, "Unknown");
   string bucket = ASC_SymbolDataPackAssetIdentityValue(classification.main_bucket_name, "Unknown");
   string bucket_id = ASC_SymbolDataPackAssetIdentityValue(classification.main_bucket_id, "unknown");
   string symbol_family = ASC_SymbolDataPackIdentitySymbolFamily(classification);
   string classification_source = ASC_SymbolDataPackIdentityClassificationSource(lookup_ok, classification);
   string classification_confidence = ASC_SymbolDataPackAssetIdentityValue(classification.confidence, "unknown");
   string classification_missing_reason = ASC_SymbolDataPackIdentityMissingReason(lookup_ok, classification);

   string text = ASC_SymbolDataPackSymbolIdentityDiagnosticBlock(symbol, ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION);
   text += "Asset / Classification Identity\n";
   text += "asset_class=" + asset_class + "\n";
   text += "bucket=" + bucket + "\n";
   text += "bucket_id=" + bucket_id + "\n";
   text += "symbol_family=" + symbol_family + "\n";
   text += "classification_source=" + classification_source + "\n";
   text += "classification_confidence=" + classification_confidence + "\n";
   text += "classification_missing_reason=" + classification_missing_reason + "\n";
   text += "classification_boundary=route_fields_do_not_define_asset_identity\n";
   text += "classification_owner=ClassificationBridge\n";
   text += "classification_inference_policy=no_suffix_or_folder_inference\n\n";
   return text;
  }


string ASC_SymbolDataPackRouteContextRole(const ASC_SymbolDataPackFamilyRoute route)
  {
   switch(route)
     {
      case ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10:
         return "overall_board_context";
      case ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET:
         return "bucket_local_context";
      case ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION:
         return "flat_transition_context";
      default:
         return "unknown";
     }
  }

string ASC_SymbolDataPackSiamReviewScope(const ASC_SymbolDataPackFamilyRoute route)
  {
   switch(route)
     {
      case ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10:
         return "overall_board_review";
      case ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET:
         return "bucket_local_review";
      case ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION:
         return "route_context_only";
      default:
         return "limited";
     }
  }

string ASC_SymbolDataPackRoutePresentForRoute(const ASC_SymbolDataPackFamilyRoute route)
  {
   switch(route)
     {
      case ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10:
         return "GlobalTop10";
      case ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET:
         return "Top5PerBucket";
      case ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION:
         return "flat_transition";
      default:
         return "unknown";
     }
  }

string ASC_SymbolDataPackRouteExistsInGlobalTop10(const ASC_SymbolDataPackFamilyRoute route)
  {
   return (route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10) ? "true" : "false";
  }

string ASC_SymbolDataPackRouteExistsInTop5PerBucket(const ASC_SymbolDataPackFamilyRoute route)
  {
   return (route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? "true" : "false";
  }

string ASC_SymbolDataPackRouteWorkflowContext(const ASC_SymbolDataPackFamilyRoute route)
  {
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      return "globaltop10";
   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
      return "top5perbucket";
   if(route == ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION)
      return "visible_top10";
   return "unknown";
  }

string ASC_SymbolDataPackDuplicateRouteStatusForRoute(const ASC_SymbolDataPackFamilyRoute route)
  {
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10 || route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET || route == ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION)
      return "resolved";
   return "unknown";
  }

string ASC_SymbolDataPackBrokerSuffixDiagnostic(const string raw_symbol,const ASC_SymbolIdentity &identity)
  {
   string raw = raw_symbol;
   string normalized = identity.normalized_symbol;
   string canonical = identity.canonical_symbol;
   StringTrimLeft(raw);
   StringTrimRight(raw);
   StringTrimLeft(normalized);
   StringTrimRight(normalized);
   StringTrimLeft(canonical);
   StringTrimRight(canonical);

   if(StringLen(raw) <= 0)
      return "unavailable_owner=SymbolDataPackComposer_reason=raw_symbol_empty";
   if(StringLen(normalized) <= 0 && StringLen(canonical) <= 0)
      return "unavailable_owner=ClassificationBridge_reason=normalized_and_canonical_symbol_empty";
   if((StringLen(normalized) > 0 && raw == normalized) || (StringLen(canonical) > 0 && raw == canonical))
      return "none";
   if(StringLen(normalized) > 0 && StringFind(raw, normalized) == 0 && StringLen(raw) > StringLen(normalized))
      return StringSubstr(raw, StringLen(normalized));
   if(StringLen(canonical) > 0 && StringFind(raw, canonical) == 0 && StringLen(raw) > StringLen(canonical))
      return StringSubstr(raw, StringLen(canonical));
   return "unavailable_owner=ClassificationBridge_reason=suffix_not_safely_parseable_from_source_owned_raw_and_canonical_symbols_no_guessing";
  }

string ASC_SymbolDataPackBrokerSuffixSource(const string broker_suffix)
  {
   if(broker_suffix == "none")
      return "exact_broker_symbol_parse";
   if(StringLen(broker_suffix) > 0 && StringFind(broker_suffix, "unavailable_owner=") != 0)
      return "exact_broker_symbol_parse";
   return "unknown";
  }

string ASC_SymbolDataPackBrokerSuffixTransportAvailable(const string broker_suffix)
  {
   if(broker_suffix == "none")
      return "true";
   if(StringLen(broker_suffix) > 0 && StringFind(broker_suffix, "unavailable_owner=") != 0)
      return "true";
   return "false";
  }

string ASC_SymbolDataPackIdentityStatusFromSuffix(const string exact_broker_symbol,
                                                  const string canonical_symbol_id,
                                                  const string broker_suffix)
  {
   if(StringLen(exact_broker_symbol) <= 0 || exact_broker_symbol == "Unavailable" ||
      StringLen(canonical_symbol_id) <= 0 || canonical_symbol_id == "Unavailable")
      return "unknown";
   if(ASC_SymbolDataPackBrokerSuffixTransportAvailable(broker_suffix) == "true")
      return "resolved";
   return "partial";
  }

string ASC_SymbolDataPackIdentityResolutionReason(const string status,const string broker_suffix)
  {
   if(status == "resolved" && broker_suffix == "none")
      return "source_owned_exact_broker_symbol_matches_canonical_symbol_no_suffix_present";
   if(status == "resolved")
      return "source_owned_exact_broker_symbol_and_canonical_symbol_allow_safe_suffix_parse";
   if(status == "partial")
      return "visible_and_canonical_identity_source_owned_broker_suffix_not_safely_parseable_without_guessing";
   return "source_identity_unresolved_or_missing";
  }

string ASC_SymbolDataPackSymbolIdentityDiagnosticBlock(const string symbol,
                                                       const ASC_SymbolDataPackFamilyRoute route)
  {
   string visible_symbol = ASC_TextOrUnavailable(symbol);
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol);
   string exact_broker_symbol = ASC_TextOrUnavailable(identity.raw_symbol);
   string broker_suffix = ASC_SymbolDataPackBrokerSuffixDiagnostic(identity.raw_symbol, identity);
   string status = ASC_SymbolDataPackIdentityStatusFromSuffix(exact_broker_symbol, canonical_symbol_id, broker_suffix);
   string reason = ASC_SymbolDataPackIdentityResolutionReason(status, broker_suffix);

   string text = "SYMBOL_IDENTITY_DIAGNOSTIC_BEGIN\n";
   text += "symbol_identity_diagnostic_version=RUN229_v1\n";
   text += "identity_mode=diagnostic_only_not_authority\n";
   text += "visible_symbol=" + visible_symbol + "\n";
   text += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   text += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   text += "broker_suffix=" + broker_suffix + "\n";
   text += "broker_suffix_source=" + ASC_SymbolDataPackBrokerSuffixSource(broker_suffix) + "\n";
   text += "broker_suffix_transport_available=" + ASC_SymbolDataPackBrokerSuffixTransportAvailable(broker_suffix) + "\n";
   text += "symbol_identity_status=" + status + "\n";
   text += "identity_resolution_reason=" + reason + "\n";
   text += "identity_next_step=" + ((status == "resolved") ? "runtime_retest_must_confirm_identity_fields_in_published_sdp_no_trade_permission" : "bind_or_export_source_owned_exact_broker_symbol_and_canonical_symbol_before_suffix_resolution_no_filename_guessing") + "\n";
   text += "symbol_identity_reason=" + reason + "\n";
   text += "identity_source_owner=SymbolDataPackComposer_uses_ClassificationBridge_ASC_NormalizeSymbol\n";
   text += "identity_route_context=" + ASC_SymbolDataPackRoutePresentForRoute(route) + "\n";
   text += "identity_blocks_trade=" + ((status == "resolved") ? "false" : "true") + "\n";
   text += "identity_blocks_diagnostic_review=false\n";
   text += "symbol_trade_permission=false\n";
   text += "symbol_signal_permission=false\n";
   text += "symbol_execution_permission=false\n";
   text += "symbol_risk_permission=false\n";
   text += "SYMBOL_IDENTITY_DIAGNOSTIC_END\n\n";
   return text;
  }

string ASC_SymbolDataPackDuplicateRouteDiagnosticBlock(const string symbol,
                                                       const ASC_SymbolDataPackFamilyRoute route)
  {
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string visible_symbol = ASC_TextOrUnavailable(symbol);
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol);
   string exact_broker_symbol = ASC_TextOrUnavailable(identity.raw_symbol);
   string route_present = ASC_SymbolDataPackRoutePresentForRoute(route);
   string siamscope = ASC_SymbolDataPackSiamReviewScope(route);
   string overall_route = (route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10) ? "GlobalTop10" : "GlobalTop10_context_available_only_when_globaltop10_route_requested";
   string bucket_route = (route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? "Top5PerBucket" : "Top5PerBucket_context_available_only_when_top5perbucket_route_requested";
   string workflow_route = route_present;
   string workflow_context = ASC_SymbolDataPackRouteWorkflowContext(route);
   string status = ASC_SymbolDataPackDuplicateRouteStatusForRoute(route);
   string reason = (status == "resolved")
                   ? "current_sdp_route_context_is_source_owned_by_route_argument_parallel_route_membership_not_inferred_no_route_rewrite"
                   : "route_context_unknown_no_parallel_route_index_no_rewrite";

   string text = "DUPLICATE_ROUTE_DIAGNOSTIC_BEGIN\n";
   text += "duplicate_route_diagnostic_version=RUN229_v1\n";
   text += "duplicate_route_mode=diagnostic_only_not_route_rewrite\n";
   text += "symbol=" + visible_symbol + "\n";
   text += "visible_symbol=" + visible_symbol + "\n";
   text += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   text += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   text += "routes_present=" + route_present + "\n";
   text += "exists_in_globaltop10=" + ASC_SymbolDataPackRouteExistsInGlobalTop10(route) + "\n";
   text += "exists_in_top5perbucket=" + ASC_SymbolDataPackRouteExistsInTop5PerBucket(route) + "\n";
   text += "canonical_route_for_overall_review=" + overall_route + "\n";
   text += "canonical_route_for_bucket_review=" + bucket_route + "\n";
   text += "current_workflow_context=" + workflow_context + "\n";
   text += "canonical_route_for_current_workflow=" + ((status == "resolved") ? "resolved" : workflow_route) + "\n";
   text += "canonical_route_for_current_workflow_value=" + workflow_route + "\n";
   text += "canonical_scope_for_siam_review=" + siamscope + "\n";
   text += "duplicate_route_status=" + status + "\n";
   text += "duplicate_route_resolution_reason=" + reason + "\n";
   text += "duplicate_route_next_step=" + ((status == "resolved") ? "runtime_retest_must_confirm_route_context_in_published_sdp_no_trade_permission" : "bind_source_owned_parallel_route_index_if_full_duplicate_membership_resolution_is_required_no_scan_no_rewrite") + "\n";
   text += "duplicate_route_reason=" + reason + "\n";
   text += "duplicate_route_source_owner=SymbolDataPackComposer_family_route_argument_no_filesystem_scan_authority\n";
   text += "duplicate_route_blocks_trade=" + ((status == "resolved") ? "false" : "true") + "\n";
   text += "duplicate_route_blocks_diagnostic_review=false\n";
   text += "route_rewrite_performed=false\n";
   text += "path_change_performed=false\n";
   text += "fileio_change_performed=false\n";
   text += "new_gate_added=false\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "DUPLICATE_ROUTE_DIAGNOSTIC_END\n\n";
   return text;
  }

string ASC_SymbolDataPackDuplicateRouteContextBlock(const string symbol,
                                                     const ASC_SymbolDataPackFamilyRoute route)
  {
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol);
   string route_context_role = ASC_SymbolDataPackRouteContextRole(route);
   string siamscope = ASC_SymbolDataPackSiamReviewScope(route);

   string text = "Duplicate / Parallel Route Context\n";
   text += "canonical_symbol_id=" + canonical_symbol_id + "\n";
   text += "duplicate_route_instance=unknown\n";
   text += "route_context_role=" + route_context_role + "\n";
   text += "route_context_authority=route_context_only_not_trade_or_selection_authority\n";
   text += "parallel_route_family=unknown\n";
   text += "parallel_route_context_note=parallel_route_presence_requires_source_owned_index_or_live_RUN227_proof\n";
   text += "canonical_scope_for_siam_review=" + siamscope + "\n";
   text += "duplicate_resolution_owner=unresolved_source_owned_parallel_route_index_missing\n";
   text += "duplicate_inference_policy=no_filesystem_stale_scan_no_suffix_guessing\n";
   text += "duplicate_missing_reason=no_source_owned_parallel_route_index\n";
   text += "duplicate_context_boundary=data_review_metadata_only_no_signal_no_trade_no_rank_authority\n\n";
   return text;
  }




string ASC_SymbolDataPackRun247DefaultRuntimeJoinMapBlock(const string symbol,
                                                         const ASC_SymbolDataPackFamilyRoute route)
  {
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string visible_symbol = ASC_TextOrUnavailable(symbol);
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol);
   string exact_broker_symbol = ASC_TextOrUnavailable(identity.raw_symbol);
   string join_key_primary = (exact_broker_symbol != "Unavailable") ? exact_broker_symbol : visible_symbol;
   string join_key_secondary = ASC_TextOrUnavailable(canonical_symbol_id);

   string text = "SYMBOL_L3_L4_RUNTIME_JOIN_MAP_BEGIN\n";
   text += "symbol_l3_l4_runtime_join_map_version=RUN247_v1\n";
   text += "join_mode=source_owned_runtime_rows_no_formula_no_route_rewrite\n";
   text += "symbol=" + visible_symbol + "\n";
   text += "visible_symbol=" + visible_symbol + "\n";
   text += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   text += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   text += "join_key_primary=" + join_key_primary + "\n";
   text += "join_key_secondary=" + join_key_secondary + "\n";
   text += "l3_row_owner=ASC_RuntimeState.committed_l3_rows\n";
   text += "l3_row_available=unknown\n";
   text += "l3_row_match_key=none\n";
   text += "l3_row_match_status=unavailable\n";
   text += "l4_row_owner=ASC_RuntimeState.publication_shortlist_rows_or_committed_l4_rows\n";
   text += "l4_row_available=unknown\n";
   text += "l4_row_match_key=none\n";
   text += "l4_row_match_status=unavailable\n";
   text += "market_board_row_owner=ASC_RuntimeState.publication_shortlist_rows_or_committed_l4_rows\n";
   text += "market_board_row_available=unknown\n";
   text += "market_board_row_match_status=unavailable\n";
   text += "join_ambiguity_count=0\n";
   text += "join_ambiguity_symbols=none\n";
   text += "join_resolution_reason=runtime_state_not_passed_to_sdp_composer_legacy_callsite_keeps_unknown_no_fake_join\n";
   text += "join_next_step=use_ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState_from_dispatcher_or_emit_exact_owner_gap\n";
   text += "writer_calculates_l3_l4=false\n";
   text += "rank_formula_changed=false\n";
   text += "membership_formula_changed=false\n";
   text += "route_rewrite_performed=false\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "SYMBOL_L3_L4_RUNTIME_JOIN_MAP_END\n\n";
   return text;
  }

string ASC_SymbolDataPackRun247DefaultReviewReadinessBlock(const string symbol,
                                                           const ASC_SymbolDataPackFamilyRoute route)
  {
   string text = "SIAM_SYMBOL_REVIEW_READINESS_BEGIN\n";
   text += "siam_symbol_review_readiness_version=RUN247_v1\n";
   text += "review_readiness_mode=review_only_not_trade_gate\n";
   text += "ready_for_siam_review=limited\n";
   text += "ready_for_siam_trade=no\n";
   text += "review_reason=legacy_compose_callsite_without_runtime_state_keeps_l3_l4_unknown_review_only\n";
   text += "review_blocker_summary=l3_l4_runtime_join_unavailable\n";
   text += "current_missing_layers=l3_runtime_join,l4_runtime_join,l4_signature_exact_match\n";
   text += "identity_status=limited\n";
   text += "duplicate_route_status=route_context_only_not_parallel_route_authority\n";
   text += "l3_l4_status=unavailable\n";
   text += "execution_facts_status=unchanged_RUN246_execution_facts_owner_map_still_source_owned\n";
   text += "top5_sync_status=unchanged_RUN246_top5_sync_status_preserved\n";
   text += "recommended_siam_action=recheck_after_refresh\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "SIAM_SYMBOL_REVIEW_READINESS_END\n\n";
   return text;
  }

string ASC_SymbolDataPackPerSymbolL3L4RouteTransportText(const ASC_SymbolDataPackFamilyRoute route)
  {
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      return "route_context_globaltop10_mirror_source_snapshot_consumed_by_writer_but_rank_membership_signature_not_bound_to_sdp_composer";
   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
      return "route_context_top5perbucket_mirror_source_snapshot_consumed_by_writer_but_rank_membership_signature_not_bound_to_sdp_composer";
   return "flat_transition_no_l3_l4_selection_transport_bound_to_sdp_composer";
  }

string ASC_SymbolDataPackPerSymbolL3L4NextStep(const ASC_SymbolDataPackFamilyRoute route)
  {
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10 || route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
      return "add_safe_source_owned_l3_l4_transport_from_runtime_shortlist_snapshot_to_sdp_composer_without_route_or_rank_formula_change";
   return "publish_review_file_but_wait_for_route_bound_sdp_or_future_safe_transport_before_selection_authority";
  }

string ASC_SymbolDataPackPerSymbolL3L4OwnerMapBlock(const string symbol,
                                                     const ASC_SymbolDataPackFamilyRoute route)
  {
   if(g_asc_sdp_run247_runtime_join_override_active && StringLen(g_asc_sdp_run247_owner_map_override) > 0)
      return g_asc_sdp_run247_owner_map_override;
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string visible_symbol = ASC_TextOrUnavailable(symbol);
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol);
   string exact_broker_symbol = ASC_TextOrUnavailable(identity.raw_symbol);
   string route_context = ASC_SymbolDataPackPerSymbolL3L4RouteTransportText(route);
   string next_step = ASC_SymbolDataPackPerSymbolL3L4NextStep(route);

   string text = "SYMBOL_L3_L4_OWNER_MAP_BEGIN\n";
   text += "symbol_l3_l4_owner_map_version=RUN247_v1\n";
   text += "symbol_l3_l4_mode=source_owned_projection_only\n";
   text += "symbol=" + visible_symbol + "\n";
   text += "visible_symbol=" + visible_symbol + "\n";
   text += "canonical_symbol_id=" + ASC_TextOrUnavailable(canonical_symbol_id) + "\n";
   text += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   text += "l3_source_owner=ASC_RuntimeState.committed_l3_rows_ASC_SelectionFilter_ASC_Dispatcher\n";
   text += "l3_transport_available=false\n";
   text += "l3_score_owner=ASC_CommittedLayer3SymbolState.score_net_or_ASC_ShortlistSymbolSummary.shortlist_l3_score\n";
   text += "l3_score_transport_available=false\n";
   text += "l3_quality_owner=ASC_SelectionFilterEvaluation.result_state_score_posture_attention_posture\n";
   text += "l3_quality_transport_available=false\n";
   text += "l4_source_owner=ASC_RuntimeState.publication_shortlist_rows_or_committed_l4_rows\n";
   text += "l4_transport_available=false\n";
   text += "l4_membership_owner=ASC_ShortlistSymbolSummary.shortlisted_rank_bucket_shortlisted_bucket_rank\n";
   text += "l4_membership_transport_available=false\n";
   text += "l4_rank_owner=ASC_ShortlistSymbolSummary.rank_bucket_rank_raw_rank\n";
   text += "l4_rank_transport_available=false\n";
   text += "l4_signature_owner=MarketBoard_RUN239_L3_L4_signature_context_board_level_only\n";
   text += "l4_signature_transport_available=false\n";
   text += "l4_rank_order_transport_available=false\n";
   text += "l4_set_transport_available=false\n";
   text += "per_symbol_l3_l4_projection_owner=ASC_SymbolDataPackComposer_RUN246_precise_owner_gap_projection_only\n";
   text += "per_symbol_l3_l4_projection_available=true\n";
   text += "writer_calculates_l3_l4=false\n";
   text += "rank_formula_changed=false\n";
   text += "membership_formula_changed=false\n";
   text += "market_board_order_changed=false\n";
   text += "route_rewrite_performed=false\n";
   text += "l3_l4_missing_owner_summary=board_and_runtime_l3_l4_sources_exist_but_exact_per_symbol_l3_l4_fields_are_not_transport_bound_to_sdp_composer__" + route_context + "\n";
   text += "l3_l4_next_step=" + next_step + "\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "SYMBOL_L3_L4_OWNER_MAP_END\n\n";
   return text;
  }

string ASC_SymbolDataPackPerSymbolL3L4ContextBlock(const string symbol,
                                                    const ASC_SymbolDataPackFamilyRoute route)
  {
   if(g_asc_sdp_run247_runtime_join_override_active && StringLen(g_asc_sdp_run247_context_override) > 0)
      return g_asc_sdp_run247_context_override;
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(symbol);
   string visible_symbol = ASC_TextOrUnavailable(symbol);
   string route_context = ASC_SymbolDataPackPerSymbolL3L4RouteTransportText(route);
   string next_step = ASC_SymbolDataPackPerSymbolL3L4NextStep(route);

   string text = "SYMBOL_L3_L4_CONTEXT_BEGIN\n";
   text += "symbol_l3_l4_context_version=RUN247_v1\n";
   text += "symbol=" + visible_symbol + "\n";
   text += "canonical_symbol_id=" + ASC_TextOrUnavailable(ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, symbol)) + "\n";
   text += "symbol_l3_l4_status=limited\n";
   text += "symbol_l3_status=unavailable\n";
   text += "symbol_l3_score=unavailable\n";
   text += "symbol_l3_rank=unavailable\n";
   text += "symbol_l3_quality=unavailable\n";
   text += "symbol_l3_owner=ASC_RuntimeState.committed_l3_rows_not_transport_bound_to_sdp_composer\n";
   text += "symbol_l3_reason=l3_selection_quality_exists_upstream_when_committed_l3_ready_but_exact_symbol_l3_context_is_not_bound_to_sdp_payload\n";
   text += "symbol_l3_blocker_reason=per_symbol_l3_transport_missing_no_writer_calculation_allowed\n";
   text += "symbol_l4_status=limited\n";
   text += "symbol_l4_member=unknown\n";
   text += "symbol_l4_rank=unavailable\n";
   text += "symbol_l4_bucket_rank=unavailable\n";
   text += "symbol_l4_global_rank=unavailable\n";
   text += "symbol_l4_role=unknown\n";
   text += "symbol_l4_signature_match=unknown\n";
   text += "symbol_l4_rank_order_match=unknown\n";
   text += "symbol_l4_set_match=unknown\n";
   text += "symbol_l4_owner=ASC_RuntimeState.publication_shortlist_rows_or_committed_l4_rows_not_transport_bound_to_sdp_composer\n";
   text += "symbol_l4_reason=" + route_context + "\n";
   text += "symbol_l4_blocker_reason=per_symbol_l4_membership_rank_signature_transport_missing_no_writer_calculation_allowed\n";
   text += "symbol_l3_l4_blocks_trade=true\n";
   text += "symbol_l3_l4_blocks_diagnostic_review=false\n";
   text += "symbol_l3_l4_next_step=" + next_step + "\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "SYMBOL_L3_L4_CONTEXT_END\n\n";
   return text;
  }

string ASC_SymbolDataPackExecutionFactStatusFromHydration(const string hydration_state,const bool has_value)
  {
   if(has_value)
      return "source_owned";
   if(StringLen(hydration_state) > 0)
      return "unavailable";
   return "unknown";
  }

string ASC_SymbolDataPackExecutionFactsOwnerMapBlock(const string symbol)
  {
   ASC_SymbolDataPackQuoteSnapshot q;
   ASC_SymbolDataPackReadQuoteSnapshot(symbol, q);
   ASC_SymbolDataPackTickSpreadStats s;
   ASC_SymbolDataPackReadTickSpreadStats(symbol, s);
   ASC_SymbolDataPackAtrVolatilityFacts m5;
   ASC_SymbolDataPackAtrVolatilityFacts m15;
   ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_M5, m5);
   ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_M15, m15);
   ASC_SymbolDataPackTimeframeOhlc ohlc_m5;
   ASC_SymbolDataPackTimeframeOhlc ohlc_m15;
   ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_M5, ohlc_m5);
   ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_M15, ohlc_m15);

   bool quote_ready = (q.symbol_info_tick_success && q.bid > 0.0 && q.ask > 0.0);
   bool spread_ready = (s.spread_current_points > 0.0 || q.spread_points > 0.0);
   bool atr_m5_ready = (m5.atr_points > 0.0);
   bool atr_m15_ready = (m15.atr_points > 0.0);
   bool ohlc_m5_ready = (ohlc_m5.copyrates_success && ohlc_m5.bars_received > 0);
   bool ohlc_m15_ready = (ohlc_m15.copyrates_success && ohlc_m15.bars_received > 0);

   string text = "SYMBOL_EXECUTION_FACTS_OWNER_MAP_BEGIN\n";
   text += "symbol_execution_facts_owner_map_version=RUN246_v1\n";
   text += "symbol_execution_facts_mode=source_owned_facts_only_no_writer_owned_trade_decision\n";
   text += "symbol=" + ASC_TextOrUnavailable(symbol) + "\n";
   text += "symbol_quote_owner=OpenSymbolSnapshotEngine_SymbolInfoTick\n";
   text += "symbol_quote_status=" + ASC_SymbolDataPackExecutionFactStatusFromHydration(q.quote_hydration_state, quote_ready) + "\n";
   text += "symbol_quote_age_seconds=" + ASC_SymbolDataPackIntText(q.quote_age_seconds) + "\n";
   text += "symbol_bid=" + ASC_SymbolDataPackDoubleText(q.bid) + "\n";
   text += "symbol_ask=" + ASC_SymbolDataPackDoubleText(q.ask) + "\n";
   text += "symbol_spread_owner=OpenSymbolSnapshotEngine_CopyTicks_or_quote_snapshot\n";
   text += "symbol_spread_status=" + ASC_SymbolDataPackExecutionFactStatusFromHydration(s.spread_stats_hydration_state, spread_ready) + "\n";
   text += "symbol_spread_points=" + ASC_SymbolDataPackDoubleText((s.spread_current_points > 0.0) ? s.spread_current_points : q.spread_points) + "\n";
   text += "symbol_atr_owner=SymbolDataPack_ATR_factual_reader\n";
   text += "symbol_atr_status=" + ((atr_m5_ready || atr_m15_ready) ? "source_owned" : ((StringLen(m5.atr_hydration_state) > 0 || StringLen(m15.atr_hydration_state) > 0) ? "unavailable" : "unknown")) + "\n";
   text += "symbol_atr_m5=" + ASC_SymbolDataPackDoubleText(m5.atr_points) + "\n";
   text += "symbol_atr_m15=" + ASC_SymbolDataPackDoubleText(m15.atr_points) + "\n";
   text += "symbol_spread_to_atr_status=" + ((spread_ready && (atr_m5_ready || atr_m15_ready)) ? "source_owned" : "unavailable") + "\n";
   text += "symbol_spread_to_atr_ratio_m5=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio((s.spread_current_points > 0.0) ? s.spread_current_points : q.spread_points, m5.atr_points)) + "\n";
   text += "symbol_spread_to_atr_ratio_m15=" + ASC_SymbolDataPackDoubleText(ASC_SymbolDataPackSafeRatio((s.spread_current_points > 0.0) ? s.spread_current_points : q.spread_points, m15.atr_points)) + "\n";
   text += "symbol_session_owner=market_state_or_broker_session_summary_not_trade_permission\n";
   text += "symbol_session_status=unknown_owner_gap_session_summary_not_bound_to_execution_fact_block\n";
   text += "symbol_session_state=unknown\n";
   text += "symbol_ohlc_owner=SymbolDataPack_CopyRates_factual_reader\n";
   text += "symbol_ohlc_status=" + ((ohlc_m5_ready || ohlc_m15_ready) ? "source_owned" : ((StringLen(ohlc_m5.hydration_state) > 0 || StringLen(ohlc_m15.hydration_state) > 0) ? "unavailable" : "unknown")) + "\n";
   text += "symbol_recent_m5_candles_ready=" + (ohlc_m5_ready ? "true" : "false") + "\n";
   text += "symbol_recent_m15_candles_ready=" + (ohlc_m15_ready ? "true" : "false") + "\n";
   text += "symbol_execution_facts_readiness=" + ((quote_ready && spread_ready && (atr_m5_ready || atr_m15_ready) && (ohlc_m5_ready || ohlc_m15_ready)) ? "partial_source_owned_no_trade_permission" : "partial_or_unavailable_owner_gaps_explicit") + "\n";
   text += "symbol_execution_facts_reason=source_owned_quote_spread_atr_ohlc_facts_are_exposed_when_available_session_binding_remains_gap_no_trade_permission\n";
   text += "symbol_execution_facts_next_step=runtime_retest_published_sdp_execution_fact_fields_then_bind_session_summary_if_source_owner_exists_no_writer_trade_logic\n";
   text += "symbol_execution_facts_blocks_trade=true\n";
   text += "symbol_execution_facts_blocks_diagnostic_review=false\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "SYMBOL_EXECUTION_FACTS_OWNER_MAP_END\n\n";
   return text;
  }

string ASC_SymbolDataPackCryptoHealthAddMissing(const string current,const string field_name)
  {
   if(StringLen(current) <= 0 || current == "none")
      return field_name;
   return current + "," + field_name;
  }

bool ASC_SymbolDataPackCryptoHealthValueIsCrypto(string value)
  {
   StringTrimLeft(value);
   StringTrimRight(value);
   return (value == "Crypto" || value == "crypto" || value == "CRYPTO");
  }

bool ASC_SymbolDataPackCryptoHealthValueMissing(string value)
  {
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0)
      return true;
   if(value == "Unknown" || value == "unknown" || value == "route_requires_symbol" || value == "source_identity_unknown")
      return true;
   return false;
  }

string ASC_SymbolDataPackCryptoHealthApplicability(const string asset_class,const string resolved_bucket)
  {
   if(ASC_SymbolDataPackCryptoHealthValueIsCrypto(asset_class) || ASC_SymbolDataPackCryptoHealthValueIsCrypto(resolved_bucket))
      return "true";
   if(!ASC_SymbolDataPackCryptoHealthValueMissing(asset_class) || !ASC_SymbolDataPackCryptoHealthValueMissing(resolved_bucket))
      return "false";
   return "unknown";
  }

string ASC_SymbolDataPackCryptoQuoteAgeState(const string applicable,const ASC_SymbolDataPackQuoteSnapshot &q)
  {
   if(applicable == "false")
      return "not_applicable";
   if(applicable == "unknown")
      return "unknown";
   if(!q.symbol_info_tick_success)
      return "dirty";
   if(q.quote_age_seconds < 0 || q.tick_age_seconds < 0)
      return "unknown";
   if(q.quote_age_seconds <= q.quote_refresh_target_seconds)
      return "clean";
   return "limited";
  }

string ASC_SymbolDataPackCryptoTickActivityState(const string applicable,const ASC_SymbolDataPackTickSpreadStats &stats)
  {
   if(applicable == "false")
      return "not_applicable";
   if(applicable == "unknown")
      return "unknown";
   if(StringLen(stats.tick_window_60s_invalid_reason) <= 0 || StringLen(stats.tick_window_300s_invalid_reason) <= 0)
      return "dirty";
   if(stats.tick_window_60s_valid && stats.tick_window_300s_valid)
      return "clean";
   return "limited";
  }

string ASC_SymbolDataPackCryptoSpreadState(const string applicable,const ASC_SymbolDataPackTickSpreadStats &stats)
  {
   if(applicable == "false")
      return "not_applicable";
   if(applicable == "unknown")
      return "unknown";
   if(StringLen(stats.spread_window_60s_invalid_reason) <= 0 || StringLen(stats.spread_window_300s_invalid_reason) <= 0)
      return "dirty";
   if(stats.spread_window_60s_valid && stats.spread_window_300s_valid)
      return "clean";
   return "limited";
  }

string ASC_SymbolDataPackCryptoLastPriceState(const string applicable,const ASC_SymbolDataPackQuoteSnapshot &q)
  {
   if(applicable == "false")
      return "not_applicable";
   if(applicable == "unknown")
      return "unknown";
   if(StringLen(q.last_price_status) <= 0)
      return "dirty";
   if(q.last_price_available)
      return "clean";
   if(q.last_price_status == "symbol_info_tick_failed_last_price_unavailable")
      return "dirty";
   return "limited";
  }

string ASC_SymbolDataPackCryptoSectionCoherenceState(const string applicable,const string section_coherence_status)
  {
   if(applicable == "false")
      return "not_applicable";
   if(applicable == "unknown")
      return "unknown";
   if(section_coherence_status == "coherent")
      return "coherent";
   if(section_coherence_status == "minor_skew")
      return "minor_skew";
   if(section_coherence_status == "incoherent")
      return "incoherent";
   return "unknown";
  }

void ASC_SymbolDataPackBuildCryptoHealth(const string asset_class,
                                         const string resolved_bucket,
                                         const ASC_SymbolDataPackQuoteSnapshot &q,
                                         const ASC_SymbolDataPackTickSpreadStats &stats,
                                         const string section_coherence_status,
                                         string &crypto_health_applicable,
                                         string &crypto_health_state,
                                         string &crypto_health_reason,
                                         string &crypto_health_inputs,
                                         string &crypto_quote_age_state,
                                         string &crypto_tick_activity_state,
                                         string &crypto_spread_state,
                                         string &crypto_last_price_state,
                                         string &crypto_section_coherence_state,
                                         string &crypto_missing_health_inputs,
                                         string &crypto_copyticks_cap_warning)
  {
   crypto_health_applicable = ASC_SymbolDataPackCryptoHealthApplicability(asset_class, resolved_bucket);
   crypto_health_inputs = "asset_class,bucket,quote_age_seconds,tick_age_seconds,tick_window_validity,spread_window_validity,last_price_status,copy_ticks_cap_hit,copy_ticks_truncation_state,section_coherence_status";
   crypto_quote_age_state = ASC_SymbolDataPackCryptoQuoteAgeState(crypto_health_applicable, q);
   crypto_tick_activity_state = ASC_SymbolDataPackCryptoTickActivityState(crypto_health_applicable, stats);
   crypto_spread_state = ASC_SymbolDataPackCryptoSpreadState(crypto_health_applicable, stats);
   crypto_last_price_state = ASC_SymbolDataPackCryptoLastPriceState(crypto_health_applicable, q);
   crypto_section_coherence_state = ASC_SymbolDataPackCryptoSectionCoherenceState(crypto_health_applicable, section_coherence_status);
   crypto_missing_health_inputs = "none";
   crypto_copyticks_cap_warning = (stats.copy_ticks_cap_hit ? "copyticks_cap_hit_review_limited" : "none");

   if(crypto_health_applicable == "false")
     {
      crypto_health_state = "not_applicable";
      crypto_health_reason = "asset_class_not_crypto";
      return;
     }
   if(crypto_health_applicable == "unknown")
     {
      crypto_health_state = "unknown";
      crypto_health_reason = "asset_class_unknown_no_suffix_or_folder_inference";
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "source_owned_asset_class_or_bucket");
      return;
     }

   if(q.quote_age_seconds < 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "quote_age_seconds");
   if(q.tick_age_seconds < 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "tick_age_seconds");
   if(StringLen(stats.tick_window_60s_invalid_reason) <= 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "tick_window_60s_invalid_reason");
   if(StringLen(stats.tick_window_300s_invalid_reason) <= 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "tick_window_300s_invalid_reason");
   if(StringLen(stats.spread_window_60s_invalid_reason) <= 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "spread_window_60s_invalid_reason");
   if(StringLen(stats.spread_window_300s_invalid_reason) <= 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "spread_window_300s_invalid_reason");
   if(StringLen(q.last_price_status) <= 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "last_price_status");
   if(StringLen(section_coherence_status) <= 0)
      crypto_missing_health_inputs = ASC_SymbolDataPackCryptoHealthAddMissing(crypto_missing_health_inputs, "section_coherence_status");

   bool dirty = (crypto_quote_age_state == "dirty" || crypto_tick_activity_state == "dirty" || crypto_spread_state == "dirty" || crypto_last_price_state == "dirty" || crypto_section_coherence_state == "incoherent" || crypto_missing_health_inputs != "none");
   bool limited = (crypto_quote_age_state == "limited" || crypto_tick_activity_state == "limited" || crypto_spread_state == "limited" || crypto_last_price_state == "limited" || crypto_section_coherence_state == "minor_skew" || crypto_section_coherence_state == "unknown" || stats.copy_ticks_cap_hit || stats.copy_ticks_truncation_state != "none");
   bool unknown = (crypto_quote_age_state == "unknown" || crypto_tick_activity_state == "unknown" || crypto_spread_state == "unknown" || crypto_last_price_state == "unknown" || crypto_section_coherence_state == "unknown");

   if(dirty)
     {
      crypto_health_state = "dirty";
      crypto_health_reason = "critical_crypto_data_quality_input_missing_or_failed_data_review_only";
     }
   else if(limited || unknown)
     {
      crypto_health_state = "limited";
      crypto_health_reason = "crypto_data_review_limited_by_partial_or_capped_inputs_no_trade_permission";
     }
   else
     {
      crypto_health_state = "clean";
      crypto_health_reason = "source_owned_crypto_inputs_present_no_critical_data_purity_errors_data_review_only";
     }
  }

string ASC_SymbolDataPackRun254SemanticValue(string value)
  {
   StringTrimLeft(value);
   StringTrimRight(value);
   StringToLower(value);
   if(StringLen(value) <= 0)
      return "unknown";
   if(value == "clean" || value == "coherent" || value == "true" || value == "yes" || value == "complete" || value == "matched")
      return "clean";
   if(value == "limited" || value == "minor_skew" || value == "partial" || value == "degraded")
      return "limited";
   if(value == "stale")
      return "stale";
   if(value == "missing" || value == "absent" || value == "unavailable" || value == "false" || value == "no")
      return "missing";
   if(value == "blocked" || value == "dirty" || value == "incoherent" || value == "failed" || value == "failure")
      return "blocked";
   if(value == "not_applicable" || value == "not applicable")
      return "not_applicable";
   if(value == "unknown")
      return "unknown";
   return "unknown";
  }

string ASC_SymbolDataPackPurityCleanValue(string value,const string fallback)
  {
   StringTrimLeft(value);
   StringTrimRight(value);
   StringReplace(value, "\r", " ");
   StringReplace(value, "\n", " ");
   StringReplace(value, "\t", " ");
   if(StringLen(value) <= 0)
      return fallback;
   return value;
  }

bool ASC_SymbolDataPackPurityMissing(const string value)
  {
   string v = value;
   StringTrimLeft(v);
   StringTrimRight(v);
   if(StringLen(v) <= 0)
      return true;
   if(v == "Unknown" || v == "unknown" || v == "route_requires_symbol" || v == "source_identity_unknown")
      return true;
   return false;
  }

void ASC_SymbolDataPackPurityAddCritical(string &errors,int &count,const string code)
  {
   if(StringLen(errors) > 0 && errors != "none")
      errors += ",";
   if(errors == "none")
      errors = "";
   errors += code;
   count++;
  }

string ASC_SymbolDataPackPurityBoolUnknown(const bool value)
  {
   return ASC_SymbolDataPackBoolText(value);
  }

string ASC_SymbolDataPackPurityTimestampText(const datetime value)
  {
   if(value <= 0)
      return "unknown";
   return TimeToString(value, TIME_DATE | TIME_SECONDS);
  }

void ASC_SymbolDataPackCoherenceAppendKnown(datetime &known_times[],const datetime value)
  {
   if(value <= 0)
      return;
   int index = ArraySize(known_times);
   ArrayResize(known_times, index + 1);
   known_times[index] = value;
  }

void ASC_SymbolDataPackBuildSectionCoherence(const datetime quote_snapshot_utc,
                                             const datetime tick_stats_snapshot_utc,
                                             const datetime spread_stats_snapshot_utc,
                                             const datetime ohlc_snapshot_utc,
                                             const datetime recent_sequence_snapshot_utc,
                                             const datetime specs_snapshot_utc,
                                             const datetime session_snapshot_utc,
                                             string &section_time_skew_seconds,
                                             string &section_coherence_status,
                                             string &section_coherence_reason)
  {
   datetime known_times[];
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, quote_snapshot_utc);
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, tick_stats_snapshot_utc);
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, spread_stats_snapshot_utc);
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, ohlc_snapshot_utc);
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, recent_sequence_snapshot_utc);
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, specs_snapshot_utc);
   ASC_SymbolDataPackCoherenceAppendKnown(known_times, session_snapshot_utc);

   int count = ArraySize(known_times);
   if(count < 2)
     {
      section_time_skew_seconds = "unknown";
      section_coherence_status = "unknown";
      section_coherence_reason = "fewer_than_two_source_owned_section_timestamps";
      return;
     }

   datetime oldest = known_times[0];
   datetime newest = known_times[0];
   for(int i = 1; i < count; i++)
     {
      if(known_times[i] < oldest) oldest = known_times[i];
      if(known_times[i] > newest) newest = known_times[i];
     }

   int skew = (int)(newest - oldest);
   if(skew < 0) skew = 0;
   section_time_skew_seconds = IntegerToString(skew);
   if(skew <= 10)
     {
      section_coherence_status = "coherent";
      section_coherence_reason = "known_timestamps_within_10_seconds";
     }
   else if(skew <= 60)
     {
      section_coherence_status = "minor_skew";
      section_coherence_reason = "known_timestamps_between_11_and_60_seconds";
     }
   else
     {
      section_coherence_status = "incoherent";
      section_coherence_reason = "known_timestamps_exceed_60_seconds";
     }
  }

datetime ASC_SymbolDataPackSpecSnapshotUtc(const string symbol)
  {
   ASC_SymbolSpecification spec;
   if(!ASC_GetSymbolSpecification(symbol, spec, false))
      return 0;
   return spec.last_refreshed_utc;
  }

datetime ASC_SymbolDataPackSessionSnapshotUtc(const string symbol)
  {
   ASC_SymbolSessionSummary summary;
   if(!ASC_GetSymbolSessionSummary(symbol, summary, false))
      return 0;
   if(!summary.available)
      return 0;
   return summary.last_refreshed_utc;
  }

string ASC_SymbolDataPackPurityOhlcReadyText(const string symbol)
  {
   ASC_SymbolDataPackTimeframeOhlc o;
   ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_M1, o);
   if(o.copyrates_success && o.bars_received > 0)
      return "true";
   if(StringLen(o.hydration_state) > 0)
      return "false";
   return "unknown";
  }

string ASC_SymbolDataPackPurityRecentSequenceReadyText(const string symbol)
  {
   ASC_SymbolDataPackTimeframeOhlc o;
   ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_M1, o);
   if(o.copyrates_success && o.bars_received > 1)
      return "true";
   if(StringLen(o.hydration_state) > 0)
      return "false";
   return "unknown";
  }


void ASC_SymbolDataPackPurityAppendMissing(string &missing,const string field_name)
  {
   if(StringLen(field_name) <= 0)
      return;
   if(StringLen(missing) > 0 && missing != "none")
      missing += ",";
   if(missing == "none")
      missing = "";
   missing += field_name;
  }

string ASC_SymbolDataPackPurityMissingText(const string missing)
  {
   if(StringLen(missing) <= 0)
      return "none";
   return missing;
  }

string ASC_SymbolDataPackPurityHydrationState(const int total_fields,const int missing_fields,const bool owner_available)
  {
   if(!owner_available)
      return "unknown";
   if(total_fields <= 0)
      return "unknown";
   if(missing_fields <= 0)
      return "true";
   if(missing_fields < total_fields)
      return "partial";
   return "false";
  }

void ASC_SymbolDataPackBuildSpecHydrationSummary(const string symbol,
                                                 string &hydrated,
                                                 string &source,
                                                 string &missing_specs,
                                                 string &reason)
  {
   hydrated = "unknown";
   source = "unknown";
   missing_specs = "source_owner_not_available";
   reason = "no_source_owned_specs_snapshot_available";

   ASC_SymbolSpecification spec;
   if(!ASC_GetSymbolSpecification(symbol, spec, false))
      return;

   int total = 16;
   int missing_count = 0;
   string missing = "";

   if(!spec.has_digits) { ASC_SymbolDataPackPurityAppendMissing(missing, "digits"); missing_count++; }
   if(!spec.has_point || spec.point <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "point"); missing_count++; }
   if(!spec.has_tick_size || spec.tick_size <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "tick_size"); missing_count++; }
   if(!spec.has_tick_value || spec.tick_value <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "tick_value"); missing_count++; }
   if(!spec.has_contract_size || spec.contract_size <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "contract_size"); missing_count++; }
   if(!spec.has_volume_min || spec.volume_min <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "volume_min"); missing_count++; }
   if(!spec.has_volume_max || spec.volume_max <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "volume_max"); missing_count++; }
   if(!spec.has_volume_step || spec.volume_step <= 0.0) { ASC_SymbolDataPackPurityAppendMissing(missing, "volume_step"); missing_count++; }
   if(!spec.has_stop_distance_points) { ASC_SymbolDataPackPurityAppendMissing(missing, "stops_level"); missing_count++; }
   if(!spec.has_freeze_distance_points) { ASC_SymbolDataPackPurityAppendMissing(missing, "freeze_level"); missing_count++; }
   if(!spec.has_trade_mode) { ASC_SymbolDataPackPurityAppendMissing(missing, "trade_mode"); missing_count++; }
   if(!spec.has_execution_mode) { ASC_SymbolDataPackPurityAppendMissing(missing, "execution_mode"); missing_count++; }
   if(!spec.has_filling_mode) { ASC_SymbolDataPackPurityAppendMissing(missing, "filling_mode"); missing_count++; }
   if(!spec.has_margin_currency || StringLen(spec.margin_currency) <= 0) { ASC_SymbolDataPackPurityAppendMissing(missing, "margin_currency"); missing_count++; }
   if(!spec.has_profit_currency || StringLen(spec.profit_currency) <= 0) { ASC_SymbolDataPackPurityAppendMissing(missing, "profit_currency"); missing_count++; }
   if(!spec.has_calculation_mode) { ASC_SymbolDataPackPurityAppendMissing(missing, "calculation_mode"); missing_count++; }

   source = "SymbolSpecification";
   missing_specs = ASC_SymbolDataPackPurityMissingText(missing);
   hydrated = ASC_SymbolDataPackPurityHydrationState(total, missing_count, true);
   if(hydrated == "true")
      reason = "source_owned_broker_specs_all_required_fields_present";
   else if(hydrated == "partial")
      reason = "partial_source_owned_specs_missing_list_visible";
   else
      reason = "source_owned_specs_all_required_fields_missing_or_invalid";
  }

void ASC_SymbolDataPackBuildSessionHydrationSummary(const string symbol,
                                                    string &hydrated,
                                                    string &source,
                                                    string &missing_session_facts,
                                                    string &reason)
  {
   hydrated = "unknown";
   source = "unknown";
   missing_session_facts = "source_owner_not_available";
   reason = "no_source_owned_session_snapshot_available";

   ASC_SymbolSessionSummary summary;
   if(!ASC_GetSymbolSessionSummary(symbol, summary, false))
      return;

   if(!summary.available)
     {
      source = "broker_sessions";
      missing_session_facts = "quote_session_state,trade_session_state,current_session_name,next_session_open,next_session_close,minutes_to_session_change,weekend_or_holiday_state,broker_session_schedule";
      reason = "broker_session_summary_unavailable_missingness_visible";
      hydrated = "unknown";
      return;
     }

   string missing = "";
   int missing_count = 0;
   int total = 8;

   ASC_SymbolDataPackPurityAppendMissing(missing, "quote_session_state"); missing_count++;
   if(StringLen(summary.posture) <= 0 || summary.posture == "unavailable") { ASC_SymbolDataPackPurityAppendMissing(missing, "trade_session_state"); missing_count++; }
   ASC_SymbolDataPackPurityAppendMissing(missing, "current_session_name"); missing_count++;
   ASC_SymbolDataPackPurityAppendMissing(missing, "next_session_open"); missing_count++;
   ASC_SymbolDataPackPurityAppendMissing(missing, "next_session_close"); missing_count++;
   ASC_SymbolDataPackPurityAppendMissing(missing, "minutes_to_session_change"); missing_count++;
   ASC_SymbolDataPackPurityAppendMissing(missing, "weekend_or_holiday_state"); missing_count++;
   if(StringLen(summary.windows) <= 0 || summary.windows == "unavailable") { ASC_SymbolDataPackPurityAppendMissing(missing, "broker_session_schedule"); missing_count++; }

   source = "broker_sessions";
   missing_session_facts = ASC_SymbolDataPackPurityMissingText(missing);
   hydrated = ASC_SymbolDataPackPurityHydrationState(total, missing_count, true);
   if(hydrated == "true")
      reason = "source_owned_broker_session_facts_all_required_fields_present";
   else if(hydrated == "partial")
      reason = "market_state_available_but_full_session_schedule_missing";
   else
      reason = "broker_session_owner_present_but_required_session_facts_missing";
  }

string ASC_SymbolDataPackDataPuritySummaryBlock(const string symbol,
                                                 const string server_root,
                                                 const ASC_SymbolDataPackFamilyRoute route,
                                                 const string bucket,
                                                 const string bucket_display)
  {
   string safe_symbol = ASC_SymbolDataPackPurityCleanValue(symbol, "route_requires_symbol");
   ASC_SymbolIdentity identity = ASC_NormalizeSymbol(safe_symbol);
   ASC_SymbolClassification classification;
   bool lookup_ok = ASC_LookupClassification(AccountInfoString(ACCOUNT_SERVER), identity, classification);

   ASC_SymbolDataPackQuoteSnapshot q;
   ASC_SymbolDataPackReadQuoteSnapshot(safe_symbol, q);
   ASC_SymbolDataPackTickSpreadStats stats;
   ASC_SymbolDataPackReadTickSpreadStats(safe_symbol, stats);

   string family_route = ASC_SymbolDataPackFamilyRouteText(route);
   string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);
   string bucket_name = bucket_display;
   StringTrimLeft(bucket_name);
   StringTrimRight(bucket_name);
   if(StringLen(bucket_name) <= 0)
      bucket_name = bucket;

   string route_bucket = ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? safe_bucket : "not_applicable");
   string route_bucket_name = ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? ((StringLen(bucket_name) > 0) ? bucket_name : "none") : "not_applicable");
   string canonical_symbol_id = ASC_SymbolDataPackAssetIdentityValue(identity.canonical_symbol, safe_symbol);
   string asset_class = ASC_SymbolDataPackAssetIdentityValue(classification.asset_class, "Unknown");
   string resolved_bucket = ASC_SymbolDataPackAssetIdentityValue(classification.main_bucket_name, "Unknown");
   string symbol_family = ASC_SymbolDataPackIdentitySymbolFamily(classification);
   string classification_source = ASC_SymbolDataPackIdentityClassificationSource(lookup_ok, classification);
   string route_context_role = ASC_SymbolDataPackRouteContextRole(route);
   string siamscope = ASC_SymbolDataPackSiamReviewScope(route);
   string duplicate_route_instance = "unknown";
   string parallel_route_family = "unknown";
   string duplicate_boundary = "data_review_metadata_only_no_signal_no_trade_no_rank_authority";

   ASC_SymbolDataPackTimeframeOhlc m1_coherence;
   ASC_SymbolDataPackReadTimeframeOhlc(safe_symbol, PERIOD_M1, m1_coherence);
   string ohlc_ready = (m1_coherence.copyrates_success && m1_coherence.bars_received > 0 ? "true" : (StringLen(m1_coherence.hydration_state) > 0 ? "false" : "unknown"));
   string recent_ready = (m1_coherence.copyrates_success && m1_coherence.bars_received > 1 ? "true" : (StringLen(m1_coherence.hydration_state) > 0 ? "false" : "unknown"));
   string symbol_specs_hydrated = "unknown";
   string symbol_specs_source = "unknown";
   string missing_specs = "source_owner_not_available";
   string specs_hydration_reason = "no_source_owned_specs_snapshot_available";
   ASC_SymbolDataPackBuildSpecHydrationSummary(safe_symbol, symbol_specs_hydrated, symbol_specs_source, missing_specs, specs_hydration_reason);

   string session_facts_hydrated = "unknown";
   string session_facts_source = "unknown";
   string missing_session_facts = "source_owner_not_available";
   string session_hydration_reason = "no_source_owned_session_snapshot_available";
   ASC_SymbolDataPackBuildSessionHydrationSummary(safe_symbol, session_facts_hydrated, session_facts_source, missing_session_facts, session_hydration_reason);

   datetime quote_snapshot_utc = (q.symbol_info_tick_success && q.tick_time > 0 ? q.tick_time : 0);
   datetime tick_stats_snapshot_utc = stats.tick_stats_snapshot_utc;
   datetime spread_stats_snapshot_utc = stats.spread_stats_snapshot_utc;
   datetime ohlc_snapshot_utc = (m1_coherence.copyrates_success && m1_coherence.last_closed_bar_time > 0 ? m1_coherence.last_closed_bar_time : 0);
   datetime recent_sequence_snapshot_utc = (m1_coherence.copyrates_success && m1_coherence.last_closed_bar_time > 0 ? m1_coherence.last_closed_bar_time : 0);
   datetime specs_snapshot_utc = ASC_SymbolDataPackSpecSnapshotUtc(safe_symbol);
   datetime session_snapshot_utc = ASC_SymbolDataPackSessionSnapshotUtc(safe_symbol);
   string section_time_skew_seconds = "unknown";
   string section_coherence_status = "unknown";
   string section_coherence_reason = "fewer_than_two_source_owned_section_timestamps";
   ASC_SymbolDataPackBuildSectionCoherence(quote_snapshot_utc,
                                           tick_stats_snapshot_utc,
                                           spread_stats_snapshot_utc,
                                           ohlc_snapshot_utc,
                                           recent_sequence_snapshot_utc,
                                           specs_snapshot_utc,
                                           session_snapshot_utc,
                                           section_time_skew_seconds,
                                           section_coherence_status,
                                           section_coherence_reason);

   string atr_facts_hydrated = "unknown";
   string vwap_facts_hydrated = "unknown";
   string indicator_facts_hydrated = "unknown";

   string crypto_health_applicable = "unknown";
   string crypto_health_state = "unknown";
   string crypto_health_reason = "not_evaluated";
   string crypto_health_inputs = "none";
   string crypto_quote_age_state = "unknown";
   string crypto_tick_activity_state = "unknown";
   string crypto_spread_state = "unknown";
   string crypto_last_price_state = "unknown";
   string crypto_section_coherence_state = "unknown";
   string crypto_missing_health_inputs = "none";
   string crypto_copyticks_cap_warning = "none";
   ASC_SymbolDataPackBuildCryptoHealth(asset_class,
                                       resolved_bucket,
                                       q,
                                       stats,
                                       section_coherence_status,
                                       crypto_health_applicable,
                                       crypto_health_state,
                                       crypto_health_reason,
                                       crypto_health_inputs,
                                       crypto_quote_age_state,
                                       crypto_tick_activity_state,
                                       crypto_spread_state,
                                       crypto_last_price_state,
                                       crypto_section_coherence_state,
                                       crypto_missing_health_inputs,
                                       crypto_copyticks_cap_warning);

   int critical_count = 0;
   string critical_errors = "none";

   if(ASC_SymbolDataPackPurityMissing(safe_symbol))
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "unknown_source_identity");
   if(ASC_SymbolDataPackPurityMissing(canonical_symbol_id))
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_canonical_symbol_id");
   if(ASC_SymbolDataPackPurityMissing(family_route))
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_route_family");
   if(ASC_SymbolDataPackPurityMissing(asset_class))
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_asset_class");
   if(ASC_SymbolDataPackPurityMissing(resolved_bucket))
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_bucket");
   if(StringLen(duplicate_boundary) <= 0)
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_duplicate_context_boundary");
   if(StringLen(q.last_price_status) <= 0)
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_last_price_semantics");
   if(StringLen(stats.tick_window_60s_invalid_reason) <= 0 || StringLen(stats.tick_window_300s_invalid_reason) <= 0 || StringLen(stats.spread_window_60s_invalid_reason) <= 0 || StringLen(stats.spread_window_300s_invalid_reason) <= 0)
      ASC_SymbolDataPackPurityAddCritical(critical_errors, critical_count, "missing_no_sample_semantics");

   bool noncritical_unknown = (symbol_specs_hydrated != "true" || session_facts_hydrated != "true" || atr_facts_hydrated == "unknown" || vwap_facts_hydrated == "unknown" || indicator_facts_hydrated == "unknown" || duplicate_route_instance == "unknown" || parallel_route_family == "unknown" || ohlc_ready != "true" || recent_ready != "true" || section_coherence_status != "coherent");
   string ready = "no";
   string ready_reason = "critical_purity_errors_present";
   if(critical_count <= 0)
     {
      if(section_coherence_status == "incoherent")
        {
         ready = "no";
         ready_reason = "section_coherence_incoherent_data_review_blocked_not_trade_permission";
        }
      else if(section_coherence_status == "unknown" || section_coherence_status == "minor_skew")
        {
         ready = "limited";
         ready_reason = "section_coherence_not_fully_coherent_data_review_limited_only";
        }
      else if(crypto_health_state == "dirty")
        {
         ready = "limited";
         ready_reason = "crypto_health_blocked_data_review_limited_not_trade_permission";
        }
      else if(crypto_health_state == "unknown")
        {
         ready = "limited";
         ready_reason = "crypto_health_unknown_data_review_limited_not_trade_permission";
        }
      else if(noncritical_unknown)
        {
         ready = "limited";
         ready_reason = "critical_fields_present_noncritical_or_future_hydration_unknown_data_review_only";
        }
      else
        {
         ready = "yes";
         ready_reason = "critical_fields_present_permissions_false_data_review_only";
        }
     }

   string text = "DATA_PURITY_SUMMARY_BEGIN\n";
   text += "DATA PURITY SUMMARY\n";
   text += "purity_summary_version=RUN220R_v1\n";
   text += "symbol=" + safe_symbol + "\n";
   text += "canonical_symbol_id=" + canonical_symbol_id + "\n";
   text += "source_run=" + string(ASC_TRUTH_SEEKER_CURRENT_RUN) + "\n";
   text += "build=" + string(ASC_VERSION_LABEL) + "\n";
   text += "route_family=" + family_route + "\n";
   text += "route_bucket=" + route_bucket + "\n";
   text += "route_bucket_name=" + route_bucket_name + "\n";
   text += "asset_class=" + asset_class + "\n";
   text += "bucket=" + resolved_bucket + "\n";
   text += "symbol_family=" + symbol_family + "\n";
   text += "classification_source=" + classification_source + "\n";
   text += "duplicate_route_instance=" + duplicate_route_instance + "\n";
   text += "route_context_role=" + route_context_role + "\n";
   text += "canonical_scope_for_siam_review=" + siamscope + "\n";
   text += "symbol_identity_diagnostic_version=RUN229_v1\n";
   text += "visible_symbol=" + safe_symbol + "\n";
   text += "exact_broker_symbol=" + ASC_TextOrUnavailable(identity.raw_symbol) + "\n";
   text += "broker_suffix=" + ASC_SymbolDataPackBrokerSuffixDiagnostic(identity.raw_symbol, identity) + "\n";
   text += "duplicate_route_diagnostic_version=RUN229_v1\n";
   text += "routes_present=" + ASC_SymbolDataPackRoutePresentForRoute(route) + "\n";
   text += "exists_in_globaltop10=" + ASC_SymbolDataPackRouteExistsInGlobalTop10(route) + "\n";
   text += "exists_in_top5perbucket=" + ASC_SymbolDataPackRouteExistsInTop5PerBucket(route) + "\n";
   text += "canonical_route_for_overall_review=" + ((route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10) ? "GlobalTop10" : "GlobalTop10_context_available_only_when_globaltop10_route_requested") + "\n";
   text += "canonical_route_for_bucket_review=" + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? "Top5PerBucket" : "Top5PerBucket_context_available_only_when_top5perbucket_route_requested") + "\n";
   text += "duplicate_route_status=" + ((route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10 || route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? "partial" : "unknown") + "\n";
   text += "identity_blocks_diagnostic_review=false\n";
   text += "duplicate_route_blocks_diagnostic_review=false\n";
   text += "trade_permission=false\n";
   text += "signal_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "tick_window_60s_valid=" + ASC_SymbolDataPackPurityBoolUnknown(stats.tick_window_60s_valid) + "\n";
   text += "tick_window_300s_valid=" + ASC_SymbolDataPackPurityBoolUnknown(stats.tick_window_300s_valid) + "\n";
   text += "spread_window_60s_valid=" + ASC_SymbolDataPackPurityBoolUnknown(stats.spread_window_60s_valid) + "\n";
   text += "spread_window_300s_valid=" + ASC_SymbolDataPackPurityBoolUnknown(stats.spread_window_300s_valid) + "\n";
   text += "copy_ticks_cap_hit=" + ASC_SymbolDataPackBoolText(stats.copy_ticks_cap_hit) + "\n";
   text += "copy_ticks_truncation_state=" + ASC_SymbolDataPackPurityCleanValue(stats.copy_ticks_truncation_state, "unknown") + "\n";
   text += "last_price_available=" + ASC_SymbolDataPackBoolText(q.last_price_available) + "\n";
   text += "last_price_status=" + ASC_SymbolDataPackPurityCleanValue(q.last_price_status, "unknown") + "\n";
   text += "absence_state=" + ASC_SymbolDataPackPurityCleanValue(q.absence_state, "unknown") + "\n";
   text += "absence_reason=" + ASC_SymbolDataPackPurityCleanValue(q.absence_reason, "unknown") + "\n";
   text += "ohlc_summary_ready=" + ohlc_ready + "\n";
   text += "recent_candle_sequences_ready=" + recent_ready + "\n";
   text += "quote_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(quote_snapshot_utc) + "\n";
   text += "tick_stats_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(tick_stats_snapshot_utc) + "\n";
   text += "spread_stats_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(spread_stats_snapshot_utc) + "\n";
   text += "ohlc_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(ohlc_snapshot_utc) + "\n";
   text += "recent_sequence_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(recent_sequence_snapshot_utc) + "\n";
   text += "specs_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(specs_snapshot_utc) + "\n";
   text += "session_snapshot_utc=" + ASC_SymbolDataPackPurityTimestampText(session_snapshot_utc) + "\n";
   text += "section_time_skew_seconds=" + section_time_skew_seconds + "\n";
   text += "section_coherence_status=" + ASC_SymbolDataPackRun254SemanticValue(section_coherence_status) + "\n";
   text += "section_coherence_reason=" + section_coherence_reason + "\n";
   text += "section_coherence_policy=source_owned_timestamps_only_no_file_time_inference\n";
   text += "crypto_health_applicable=" + crypto_health_applicable + "\n";
   text += "crypto_health_state=" + ASC_SymbolDataPackRun254SemanticValue(crypto_health_state) + "\n";
   text += "crypto_health_reason=" + crypto_health_reason + "\n";
   text += "crypto_health_inputs=" + crypto_health_inputs + "\n";
   text += "crypto_quote_age_state=" + ASC_SymbolDataPackRun254SemanticValue(crypto_quote_age_state) + "\n";
   text += "crypto_tick_activity_state=" + ASC_SymbolDataPackRun254SemanticValue(crypto_tick_activity_state) + "\n";
   text += "crypto_spread_state=" + ASC_SymbolDataPackRun254SemanticValue(crypto_spread_state) + "\n";
   text += "crypto_last_price_state=" + ASC_SymbolDataPackRun254SemanticValue(crypto_last_price_state) + "\n";
   text += "crypto_section_coherence_state=" + ASC_SymbolDataPackRun254SemanticValue(crypto_section_coherence_state) + "\n";
   text += "crypto_missing_health_inputs=" + crypto_missing_health_inputs + "\n";
   text += "crypto_copyticks_cap_warning=" + crypto_copyticks_cap_warning + "\n";
   text += "crypto_health_boundary=data_quality_warning_only_not_signal_not_trade\n";
   text += "symbol_specs_hydrated=" + symbol_specs_hydrated + "\n";
   text += "symbol_specs_source=" + symbol_specs_source + "\n";
   text += "missing_specs=" + missing_specs + "\n";
   text += "specs_hydration_reason=" + specs_hydration_reason + "\n";
   text += "session_facts_hydrated=" + session_facts_hydrated + "\n";
   text += "session_facts_source=" + session_facts_source + "\n";
   text += "missing_session_facts=" + missing_session_facts + "\n";
   text += "session_hydration_reason=" + session_hydration_reason + "\n";
   text += "atr_facts_hydrated=" + atr_facts_hydrated + "\n";
   text += "vwap_facts_hydrated=" + vwap_facts_hydrated + "\n";
   text += "indicator_facts_hydrated=" + indicator_facts_hydrated + "\n";
   text += "critical_purity_errors_count=" + IntegerToString(critical_count) + "\n";
   text += "critical_purity_errors=" + critical_errors + "\n";
   text += "ready_for_siam_review=" + ready + "\n";
   text += "ready_for_siam_reason=" + ready_reason + "\n";
   text += "signal_permission=false\n";
   text += "trade_permission=false\n";
   text += "execution_permission=false\n";
   text += "risk_permission=false\n";
   text += "prop_firm_permission=false\n";
   string run254_section_coherence = ASC_SymbolDataPackRun254SemanticValue(section_coherence_status);
   string run254_identity_status = (critical_count <= 0 ? "clean" : "limited");
   string run254_execution_facts_status = ((symbol_specs_hydrated == "true" && session_facts_hydrated == "true") ? "clean" : "limited");
   string run254_l3_l4_status = ((ASC_SymbolDataPackRouteExistsInGlobalTop10(route) == "true" || ASC_SymbolDataPackRouteExistsInTop5PerBucket(route) == "true") ? "limited" : "unknown");
   string run254_publication_status = (critical_count <= 0 ? "complete" : "partial");
   string run254_review_usefulness = (ready == "yes" ? "high" : (ready == "limited" ? "medium" : (critical_count > 0 ? "diagnostic_only" : "low")));
   string run254_siam_action = (run254_review_usefulness == "high" ? "upload_review" : (run254_review_usefulness == "medium" ? "upload_with_caution" : (run254_review_usefulness == "diagnostic_only" ? "recheck_after_refresh" : "wait_for_file_completion")));

   text += "summary_boundary=data_review_only_not_signal_not_trade\n";
   text += "DATA_PURITY_SUMMARY_END\n\n";

   text += "SIAM_SYMBOL_REVIEW_COMPLETENESS_BEGIN\n";
   text += "siam_symbol_review_completeness_version=RUN254_v1\n";
   text += "symbol=" + safe_symbol + "\n";
   text += "canonical_symbol=" + canonical_symbol_id + "\n";
   text += "bucket=" + resolved_bucket + "\n";
   text += "rank_source=" + family_route + "\n";
   text += "market_board_rank=unknown_sdp_mirror_does_not_own_market_board_rank\n";
   text += "bucket_rank=unknown_sdp_mirror_does_not_own_bucket_rank\n";
   text += "globaltop10_member=" + ASC_SymbolDataPackRouteExistsInGlobalTop10(route) + "\n";
   text += "top5_member=" + ASC_SymbolDataPackRouteExistsInTop5PerBucket(route) + "\n";
   text += "main_dossier_file_status=unknown_no_physical_main_dossier_readback_in_sdp_mirror\n";
   text += "lite_sdp_file_status=" + run254_publication_status + "\n";
   text += "main_lite_parity_status=unproven\n";
   text += "identity_status=" + run254_identity_status + "\n";
   text += "execution_facts_status=" + run254_execution_facts_status + "\n";
   text += "l3_l4_status=" + run254_l3_l4_status + "\n";
   text += "publication_status=" + run254_publication_status + "\n";
   text += "section_coherence_status=" + run254_section_coherence + "\n";
   text += "missing_sections=" + critical_errors + "\n";
   text += "stale_sections=unknown_no_file_age_authority_in_sdp_composer\n";
   text += "blocked_sections=" + (run254_section_coherence == "blocked" ? "section_coherence" : "none") + "\n";
   text += "review_usefulness=" + run254_review_usefulness + "\n";
   text += "recommended_siam_action=" + run254_siam_action + "\n";
   text += "trade_ready=false\n";
   text += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   text += "SIAM_SYMBOL_REVIEW_COMPLETENESS_END\n\n";

   text += "SIAM_DATA_PURITY_SEMANTICS_BEGIN\n";
   text += "siam_data_purity_semantics_version=RUN254_v1\n";
   text += "allowed_section_coherence_values=clean,limited,stale,missing,not_applicable,blocked,unknown\n";
   text += "forbidden_trade_language_active=false\n";
   text += "stale_file_policy=stale_blocks_trade_not_diagnostic_review\n";
   text += "absent_file_policy=absent_blocks_trade_and_upload_completion\n";
   text += "partial_file_policy=partial_allows_diagnostic_review_only\n";
   text += "queue_transport_not_file_proof=true\n";
   text += "folder_scan_not_authority=true\n";
   text += "main_dossier_is_canonical=true\n";
   text += "lite_sdp_is_review_mirror=true\n";
   text += "review_permission_policy=review_allowed_when_truthfully_labeled\n";
   text += "trade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   text += "SIAM_DATA_PURITY_SEMANTICS_END\n\n";
   return text;
  }

string ASC_SymbolDataPackComposeSkeleton(const string symbol,
                                          const string server_root,
                                          const ASC_SymbolDataPackFamilyRoute route=ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION,
                                          const string bucket="",
                                          const string bucket_display="")
  {
   string safe_symbol = symbol;
   StringTrimLeft(safe_symbol);
   StringTrimRight(safe_symbol);
   if(StringLen(safe_symbol) <= 0)
      safe_symbol = "route_requires_symbol";

   string text = "";
   text += "# Symbol Data Pack Lite\n\n";
   text += "DEBUG_HEADER_BEGIN\n";
   text += "CLEANLINESS_BOUNDARY=truth_readability_only_no_field_deletion_no_signal_no_trade\n";
   text += "Publication / Atomic Status\n";
   text += "Family: " + string(ASC_SYMBOL_DATA_PACK_FAMILY) + "\n";
   text += "Symbol: " + safe_symbol + "\n";
   text += "Server Root: " + (StringLen(server_root) > 0 ? server_root : "route_pending_owner") + "\n";
   text += "Source Run: " + string(ASC_TRUTH_SEEKER_CURRENT_RUN) + "\n";
   text += "Build: " + string(ASC_VERSION_LABEL) + "\n";
   text += "Publication State: " + string(ASC_SDP_PUBLICATION_STATUS_READY) + "\n";
   text += "topology_contract=" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOPOLOGY) + "\n";
   text += "flat_transition_status=" + string(ASC_SYMBOL_DATA_PACK_FLAT_ROOT_TRANSITION_STATUS) + "\n";
   text += "run190_route_helper_status=" + string(ASC_SYMBOL_DATA_PACK_RUN190_SCOPE) + "\n";
   text += "Atomic Intent: existing FileIO temp/readback/promote/no-change/retained-final-continuity pattern bound in RUN162R\n";
   text += "Last Good Contract: " + string(ASC_SDP_LAST_GOOD_CONTRACT) + "\n";
   text += "No Change Contract: " + string(ASC_SDP_NO_CHANGE_CONTRACT) + "\n";
   string family_route = ASC_SymbolDataPackFamilyRouteText(route);
   string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);
   string bucket_name = bucket_display;
   StringTrimLeft(bucket_name);
   StringTrimRight(bucket_name);
   if(StringLen(bucket_name) <= 0)
      bucket_name = bucket;
   text += "Family Route: " + family_route + "\n";
   text += "family_route=" + family_route + "\n";
   text += "route_bucket=" + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? safe_bucket : "not_applicable") + "\n";
   text += "route_bucket_token=" + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? safe_bucket : "not_applicable") + "\n";
   text += "route_bucket_name=" + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? ((StringLen(bucket_name) > 0) ? bucket_name : "none") : "not_applicable") + "\n";
   text += "route_final_path=" + ASC_SymbolDataPackExpectedOutputPathTextForRoute(server_root, safe_symbol, route, bucket, false) + "\n";
   text += "route_temp_path=" + ASC_SymbolDataPackExpectedOutputPathTextForRoute(server_root, safe_symbol, route, bucket, true) + "\n";
   text += "route_last_good_path=" + ASC_SymbolDataPackExpectedOutputPathTextForRoute(server_root, safe_symbol, route, bucket, false) + "\n";
   string route_scope = "flat_transition_or_future_bucket_route";
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      route_scope = string(ASC_SYMBOL_DATA_PACK_RUN191_SCOPE);
   else if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
      route_scope = string(ASC_SYMBOL_DATA_PACK_RUN192_SCOPE);
   text += "route_publication_scope=" + route_scope + "\n";
   text += "globaltop10_mirror_publication_status=" + string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_MIRROR_STATUS) + "\n";
   text += "top5perbucket_mirror_publication_status=" + string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_MIRROR_STATUS) + "\n";
   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
     {
      text += "\nTOP5_SDP_PUBLICATION_OWNER_TRACE_BEGIN\n";
      text += "top5_sdp_publication_owner_trace_version=RUN249_v1\n";
      text += "top5_dossier_publication_owner=ASC_ServiceTop5PerBucketFamily/ASC_Top5BucketWriteChild\n";
      text += "top5_sdp_publication_owner=ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication\n";
      text += "top5_sdp_expected_source=state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs\n";
      text += "top5_sdp_expected_symbol_count=single_child_from_queue_context\n";
      text += "top5_sdp_queue_owner=ASC_RuntimeState.symbol_data_pack_top5perbucket_cursor\n";
      text += "top5_sdp_writer_owner=ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState\n";
      text += "top5_sdp_runtime_join_owner=ASC_SymbolDataPackComposer_RUN247_runtime_override_prepared_by_writer_from_ASC_RuntimeState\n";
      text += "top5_sdp_current_blocker=none_inside_child_after_write\n";
      text += "top5_sdp_blocker_reason=child_shell_status_written_before_deep_payload\n";
      text += "top5_sdp_next_step=read_family_publication_completion_ledger_for_remaining_children\n";
      text += "route_change_performed=false\npath_change_performed=false\nfileio_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
      text += "TOP5_SDP_PUBLICATION_OWNER_TRACE_END\n";
      text += "\nSHELL_FIRST_PUBLICATION_STATUS_BEGIN\n";
      text += "shell_first_publication_status_version=RUN249_v1\nfamily=Symbol Data Packs/Top5PerBucket\n";
      text += "snapshot_id=runtime_family_manifest_owner\n";
      text += "shell_before_deep_payload=true\nall_expected_shells_attempted=see_family_manifest\nall_expected_shells_written=see_family_manifest\ndeep_payload_allowed=false\ndeep_payload_defer_reason=child_status_shell_written_first_deep_payload_owner_deferred\npending_shell_symbols=see_family_manifest\nmissing_shell_symbols=see_family_manifest\nfailed_shell_symbols=see_family_manifest\nnext_shell_retry_utc=see_family_manifest\nreview_allowed_when_shell_partial=true\ntrade_allowed_when_shell_partial=false\n";
      text += "SHELL_FIRST_PUBLICATION_STATUS_END\n";
     }
   text += "DEBUG_HEADER_END\n\n";

   text += "SIAM_DATA_BODY_BEGIN\n";
   text += ASC_SymbolDataPackAssetIdentityBlock(safe_symbol);
   text += ASC_SymbolDataPackSymbolIdentityDiagnosticBlock(safe_symbol, route);
   text += ASC_SymbolDataPackDuplicateRouteDiagnosticBlock(safe_symbol, route);
   text += ASC_SymbolDataPackDuplicateRouteContextBlock(safe_symbol, route);
   if(g_asc_sdp_run247_runtime_join_override_active && StringLen(g_asc_sdp_run247_runtime_join_map_override) > 0)
      text += g_asc_sdp_run247_runtime_join_map_override;
   else
      text += ASC_SymbolDataPackRun247DefaultRuntimeJoinMapBlock(safe_symbol, route);
   text += ASC_SymbolDataPackPerSymbolL3L4OwnerMapBlock(safe_symbol, route);
   text += ASC_SymbolDataPackPerSymbolL3L4ContextBlock(safe_symbol, route);
   if(g_asc_sdp_run247_runtime_join_override_active && StringLen(g_asc_sdp_run247_review_readiness_override) > 0)
      text += g_asc_sdp_run247_review_readiness_override;
   else
      text += ASC_SymbolDataPackRun247DefaultReviewReadinessBlock(safe_symbol, route);
   text += ASC_SymbolDataPackExecutionFactsOwnerMapBlock(safe_symbol);

   text += "Safety Boundary\n";
   text += "Boundary: factual numeric data pack only; no direction, no signal, no broker action, no rank owner, no hidden selection owner.\n";
   text += "Writer Rule: " + string(ASC_SYMBOL_DATA_PACK_WRITER_COMPOSES_ONLY) + "\n";
   text += "One File Rule: " + string(ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL) + "\n";
   text += "Numeric Rule: " + string(ASC_SYMBOL_DATA_PACK_NUMERIC_FIRST) + "\n";
   text += "Absence Rule: " + string(ASC_SYMBOL_DATA_PACK_NO_LAZY_UNAVAILABLE) + "\n\n";

   text += ASC_SymbolDataPackAtomicPublicationContractText();
   text += ASC_SymbolDataPackHistoryDepthContractText();
   text += ASC_SymbolDataPackTickSpreadContractText();
   text += "OHLC Timeframe Contract\n";
   text += ASC_SymbolDataPackOhlcTimeframeContractTableText();
   text += "\n";
   text += ASC_SymbolDataPackRecalculationContractText();
   text += ASC_SymbolDataPackSectionFreshnessPlanText();

   text += "Source Owner Trace\n";
   text += ASC_SymbolDataPackRoutingMapText();
   text += "\n";

   text += "Route Readiness Map\n";
   text += "Contracts: route_ready\n";
   text += "Routing: route_ready\n";
   text += "Composer: route_ready\n";
   text += "Writer: atomic_foundation_ready_runtime_activation_enabled\n";
   text += "Runtime Activation: bounded_selected_or_top_symbol_due_only_enabled\n";
   text += "GlobalTop10 SDP Mirror Publication: " + ((route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10) ? "active_source_patch_live_unproven" : "available_when_globaltop10_route_requested") + "\n";
   text += "Top5PerBucket SDP Mirror Publication: " + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? "active_source_patch_live_unproven" : "available_when_top5perbucket_route_requested") + "\n\n";

   text += ASC_SymbolDataPackSectionPlanLine(ASC_SYMBOL_DATA_PACK_SECTION_IDENTITY, "RUN163R", "ClassificationBridge + SymbolSpecification", ASC_SDP_SECTION_CADENCE_IDENTITY_SECONDS, "slow_identity_refresh_or_manual_hydration_repair");
   text += ASC_SymbolDataPackSectionPlanLine(ASC_SYMBOL_DATA_PACK_SECTION_L4_CONTEXT, "RUN163R", "L4 committed membership snapshot", ASC_SDP_SECTION_CADENCE_L4_CONTEXT_SECONDS, "membership_epoch_only_no_rank_recalc");
   text += ASC_SymbolDataPackSectionPlanLine(ASC_SYMBOL_DATA_PACK_SECTION_MARKET_STATE, "RUN163R", "MarketStateEngine", ASC_SDP_SECTION_CADENCE_MARKET_STATE_SECONDS, "l1_due_state_only");
   text += ASC_SymbolDataPackQuoteSnapshotText(safe_symbol);
   text += ASC_SymbolDataPackTickStatsText(safe_symbol);
   text += ASC_SymbolDataPackSpreadStatsText(safe_symbol);
   text += ASC_SymbolDataPackOhlcSummaryText(safe_symbol);
   text += ASC_SymbolDataPackRecentClosedCandleSequenceText(safe_symbol);
   text += ASC_SymbolDataPackDwmHighLowFactsText(safe_symbol);
   text += ASC_SymbolDataPackAtrFactsText(safe_symbol);
   text += ASC_SymbolDataPackVolatilityRangeFactsText(safe_symbol);
   text += ASC_SymbolDataPackRangePositionFactsText(safe_symbol);
   text += ASC_SymbolDataPackPullbackDepthFactsText(safe_symbol);
   text += ASC_SymbolDataPackSpreadToVolatilityBurdenText(safe_symbol);
   text += "ATR / Range / Pullback Hydration / Retry / Last-Good Contract\n";
   text += ASC_SymbolDataPackVolatilityFailureModeTableText();
   text += "\n";
   text += "Bar Hydration / Retry / Last-Good Contract\n";
   text += ASC_SymbolDataPackBarFailureModeTableText();
   text += "\n";
   text += "Due-Only Recalculation By Timeframe\n";
   text += ASC_SymbolDataPackDueOnlyTimeframeTableText();
   text += "\n";
   text += "Due-Only Recalculation For ATR / Range / Pullback\n";
   text += ASC_SymbolDataPackAtrVolatilityDueOnlyTableText();
   text += "\n";
   text += ASC_SymbolDataPackVwapFormulaDecisionText();
   text += ASC_SymbolDataPackSessionCurrentDayVwapText(safe_symbol);
   text += ASC_SymbolDataPackDailyPreviousVwapText(safe_symbol);
   text += ASC_SymbolDataPackAnchoredVwapText(safe_symbol);
   text += ASC_SymbolDataPackVolumeSourceQualityText(safe_symbol);
   text += "VWAP Hydration / Retry / Last-Good Contract\n";
   text += ASC_SymbolDataPackVwapFailureModeTableText();
   text += "\n";
   text += "Due-Only Recalculation For VWAP\n";
   text += ASC_SymbolDataPackVwapDueOnlyTableText();
   text += "\n";
   text += ASC_SymbolDataPackIndicatorMethodDecisionText();
   text += ASC_SymbolDataPackMovingAverageFactsText(safe_symbol);
   text += ASC_SymbolDataPackRSIFactsText(safe_symbol);
   text += ASC_SymbolDataPackMACDFactsText(safe_symbol);
   text += ASC_SymbolDataPackBandsFactsText(safe_symbol);
   text += ASC_SymbolDataPackADXFactsText(safe_symbol);
   text += ASC_SymbolDataPackStdDevZScoreFactsText(safe_symbol);
   text += "Indicator Hydration / Retry / Last-Good Contract\n";
   text += ASC_SymbolDataPackIndicatorHydrationTableText();
   text += "\n";
   text += "Due-Only Recalculation For Indicators\n";
   text += ASC_SymbolDataPackIndicatorDueOnlyTableText();
   text += "\n";
   text += ASC_SymbolDataPackSectionPlanLine(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH, "RUN168R", "writer/routing health owner", ASC_SDP_SECTION_CADENCE_HEALTH_SECONDS, "health_due_only_no_fake_complete_state");
   text += ASC_SymbolDataPackConsolidatedHealthMapText();
   text += "Health Output Contract Token: " + string(ASC_SDP_HEALTH_OUTPUT_CONTRACT) + "\n";
   text += "Hard Absence Proof Rule Token: " + string(ASC_SDP_HEALTH_HARD_ABSENCE_RULE) + "\n\n";
   text += ASC_SymbolDataPackSectionPlanLine(ASC_SYMBOL_DATA_PACK_SECTION_RUN170_CONTRACT, "RUN169R", "source closeout contract owner", ASC_SDP_SECTION_CADENCE_HEALTH_SECONDS, "run170_live_contract_no_runtime_side_effect");
   text += ASC_SymbolDataPackRun170LiveContractText();
   text += ASC_SymbolDataPackRun171ActivationProofText(safe_symbol, server_root);

   text += "L2 No Bid/Ask Future Field Contract\n";
   text += ASC_SymbolDataPackL2FutureFieldTableText();
   text += "\n";

   text += ASC_SymbolDataPackDataPuritySummaryBlock(safe_symbol, server_root, route, bucket, bucket_display);
   text += "SIAM_DATA_BODY_END\n\n";

   text += "PROOF_AND_RECONCILIATION_BEGIN\n";
   text += "proof_boundary=debug_and_route_proof_retained_not_siam_data_body_no_field_deletion\n";
   text += "reconciliation_payload_policy=durable_reconciliation_fields_remain_writer_status_manifest_functionresults_owned_no_duplicate_summary\n";
   text += "Owner Trace\n";
   text += "Existing-owner routing only. RUN163R reads quote/tick/spread facts through official terminal APIs and does not duplicate main engines; RUN164R adds CopyRates/MqlRates OHLC and high-low facts; RUN165R adds ATR/range-position/pullback/spread-burden numeric facts while still excluding VWAP, full indicator matrix, permission, or execution logic.\n\n";

   text += "Safety Boundary\n";
   text += "This pack is data infrastructure only. Data available for review is not permission, instruction, or authority to act.\n";
   text += "PROOF_AND_RECONCILIATION_END\n";
   return text;
  }

#endif
