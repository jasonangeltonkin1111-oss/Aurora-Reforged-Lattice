#ifndef __LAYER2_SYMBOL_SPECS_ARL_BROKERCONSTRAINTS_MQH__
#define __LAYER2_SYMBOL_SPECS_ARL_BROKERCONSTRAINTS_MQH__

//+------------------------------------------------------------------+
//| ARL_BrokerConstraints
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: layer2/broker constraints
// Purpose: Owns stops/freeze/volume/tick/contract constraint records.
// Inputs: symbol spec APIs
// Outputs: constraint fields
// Forbidden: trade execution
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_BrokerConstraints_RefreshSymbol(const string symbol){ return true; }
string ARL_BrokerConstraints_Status(){ return "SCAFFOLD"; }

#endif // __LAYER2_SYMBOL_SPECS_ARL_BROKERCONSTRAINTS_MQH__
