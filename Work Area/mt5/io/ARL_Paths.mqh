#ifndef __IO_ARL_PATHS_MQH__
#define __IO_ARL_PATHS_MQH__

//+------------------------------------------------------------------+
//| ARL_Paths
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: io/paths
// Purpose: Owns output path construction and forbids random public paths.
// Inputs: server/profile/root settings
// Outputs: canonical output paths
// Forbidden: writing payloads directly
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_Paths_Init(){ return true; }
string ARL_Paths_Contract(){ return "SCAFFOLD_CONTRACT"; }

#endif // __IO_ARL_PATHS_MQH__
