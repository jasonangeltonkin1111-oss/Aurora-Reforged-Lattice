#ifndef __DOSSIERS_SECTIONS_ARL_DOSSIER_MISSINGDATA_MQH__
#define __DOSSIERS_SECTIONS_ARL_DOSSIER_MISSINGDATA_MQH__

//+------------------------------------------------------------------+
//| ARL_Dossier_MissingData
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: dossier section/missing data
// Purpose: Owns missing/stale/partial summary without unavailable spam.
// Inputs: all section statuses
// Outputs: missing summary
// Forbidden: hiding required missing fields
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

string ARL_Dossier_MissingData_BuildSection(){ return "ARL_Dossier_MissingData=SCAFFOLD"; }

#endif // __DOSSIERS_SECTIONS_ARL_DOSSIER_MISSINGDATA_MQH__
