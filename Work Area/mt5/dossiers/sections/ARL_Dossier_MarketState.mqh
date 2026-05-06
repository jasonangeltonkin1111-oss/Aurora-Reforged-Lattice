#ifndef __DOSSIERS_SECTIONS_ARL_DOSSIER_MARKETSTATE_MQH__
#define __DOSSIERS_SECTIONS_ARL_DOSSIER_MARKETSTATE_MQH__

//+------------------------------------------------------------------+
//| ARL_Dossier_MarketState
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: dossier section/market state
// Purpose: Owns market state section.
// Inputs: L1 market state
// Outputs: market state fields
// Forbidden: broker specs
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

string ARL_Dossier_MarketState_BuildSection(){ return "ARL_Dossier_MarketState=SCAFFOLD"; }

#endif // __DOSSIERS_SECTIONS_ARL_DOSSIER_MARKETSTATE_MQH__
