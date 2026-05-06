#ifndef __ASC_CONSUMER_VISIBILITY_PROOF_MQH__
#define __ASC_CONSUMER_VISIBILITY_PROOF_MQH__

#include "ASC_ArtifactTextHelpers.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"

string ASC_ConsumerMarketPostureReadback(const ASC_Layer1SymbolState &symbol_state)
  {
   if(symbol_state.state == ASC_L1_OPEN)
      return "open market";
   if(symbol_state.state == ASC_L1_CLOSED)
      return "closed market";
   if(symbol_state.state == ASC_L1_UNCERTAIN)
      return "uncertain market";
   return "unknown market";
  }

bool ASC_ConsumerAllowsOrdinaryL34(const ASC_Layer1SymbolState &symbol_state)
  {
   return (symbol_state.state == ASC_L1_OPEN);
  }

string ASC_ConsumerVisibleLayerCeilingReadback(const ASC_Layer1SymbolState &symbol_state)
  {
   return ASC_ConsumerAllowsOrdinaryL34(symbol_state) ? "Layer 0-4" : "Layer 0-2";
  }

string ASC_ConsumerPathIdentityReadback(const bool explicit_selected_symbol_path)
  {
   return explicit_selected_symbol_path ? "explicit selected-symbol deep path" : "ordinary passive consumer path";
  }

string ASC_ConsumerShortlistSourceIdentityReadback(const string raw_source_label)
  {
   string source = raw_source_label;
   StringTrimLeft(source);
   StringTrimRight(source);
   StringToLower(source);

   if(StringLen(source) <= 0)
      return "source label unavailable";
   if(source == "publication_shortlist_rows")
      return "ordinary passive shortlist publication cache";
   if(source == "committed_l4_rows")
      return "runtime committed Layer-4 cache";
   if(source == "selected_symbol_deep_path")
      return "explicit selected-symbol deep path";
   return ASC_ArtifactHumanizeLabel(source);
  }

string ASC_ConsumerL34SourceIdentityReadback(const ASC_Layer1SymbolState &symbol_state,
                                             const string raw_source_label,
                                             const bool l34_visible,
                                             const bool explicit_selected_symbol_path)
  {
   if(!l34_visible || !ASC_ConsumerAllowsOrdinaryL34(symbol_state))
      return "hidden by shared ordinary visibility ceiling";

   if(explicit_selected_symbol_path)
      return ASC_ConsumerShortlistSourceIdentityReadback(raw_source_label) + " | explicit deep path remains separate";

   return ASC_ConsumerShortlistSourceIdentityReadback(raw_source_label);
  }

#endif
