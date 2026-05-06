#ifndef __INDICATORS_ARL_ATRMODULE_MQH__
#define __INDICATORS_ARL_ATRMODULE_MQH__

//+------------------------------------------------------------------+
//| ARL_ATRModule
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: indicators/ATR
// Purpose: Owns ATR handle and buffer read contract.
// Inputs: iATR and CopyBuffer
// Outputs: ATR numeric field
// Forbidden: ranking formula ownership
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_ATRModule_Init(){ return true; }
bool ARL_ATRModule_Release(){ return true; }

#endif // __INDICATORS_ARL_ATRMODULE_MQH__
