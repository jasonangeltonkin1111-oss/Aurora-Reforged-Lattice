#ifndef __RUNTIME_ARL_WARMUPSTATE_MQH__
#define __RUNTIME_ARL_WARMUPSTATE_MQH__

//+------------------------------------------------------------------+
//| ARL_WarmupState
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: runtime/warmup state
// Purpose: Owns warmup state machine and READY transition criteria.
// Inputs: module completion records
// Outputs: warmup code/state/reason
// Forbidden: pretending partial output is ready
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_WarmupState_Init(){ return true; }
bool ARL_WarmupState_Tick(){ return true; }
string ARL_WarmupState_Status(){ return "SCAFFOLD"; }

#endif // __RUNTIME_ARL_WARMUPSTATE_MQH__
