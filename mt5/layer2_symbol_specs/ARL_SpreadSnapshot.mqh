#ifndef __LAYER2_SYMBOL_SPECS_ARL_SPREADSNAPSHOT_MQH__
#define __LAYER2_SYMBOL_SPECS_ARL_SPREADSNAPSHOT_MQH__

//+------------------------------------------------------------------+
//| ARL_SpreadSnapshot
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: layer2/spread snapshot
// Purpose: Owns current spread price/points/bps source values.
// Inputs: bid/ask/point/digits
// Outputs: spread values
// Forbidden: scoring weights
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_SpreadSnapshot_RefreshSymbol(const string symbol){ return true; }
string ARL_SpreadSnapshot_Status(){ return "SCAFFOLD"; }

#endif // __LAYER2_SYMBOL_SPECS_ARL_SPREADSNAPSHOT_MQH__
