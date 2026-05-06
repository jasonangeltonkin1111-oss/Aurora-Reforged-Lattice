#ifndef __ASC_SEMI_AUTO_STATE_MQH__
#define __ASC_SEMI_AUTO_STATE_MQH__

#include "ASC_SemiAutoTypes.mqh"

struct ASC_SemiAutoState
  {
   bool scaffold_landed;
   bool runtime_activation_enabled;
   bool dispatcher_wired;
   bool dossier_publication_enabled;
   bool current_focus_publication_enabled;
   string scaffold_version;
   string last_contract_note;
   string next_build_target;
   datetime last_state_update_utc;
   ASC_L6_LineageStamp last_lineage;
  };

void ASC_ResetSemiAutoState(ASC_SemiAutoState &state)
  {
   state.scaffold_landed = true;
   state.runtime_activation_enabled = false;
   state.dispatcher_wired = false;
   state.dossier_publication_enabled = false;
   state.current_focus_publication_enabled = false;
   state.scaffold_version = "layer6_scaffold_prompt1";
   state.last_contract_note = "scaffold only; no runtime activation";
   state.next_build_target = "layer5_workbench_extraction";
   state.last_state_update_utc = 0;
   state.last_lineage.symbol = "";
   state.last_lineage.canonical_symbol = "";
   state.last_lineage.source_layer_ref = "layer5_workbench_placeholder";
   state.last_lineage.source_revision_ref = "pending";
   state.last_lineage.source_packet_ref = "pending";
   state.last_lineage.source_owner = "semi_auto_scaffold";
  }

#endif
