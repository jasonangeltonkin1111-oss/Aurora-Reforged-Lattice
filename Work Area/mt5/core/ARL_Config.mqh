#ifndef __CORE_ARL_CONFIG_MQH__
#define __CORE_ARL_CONFIG_MQH__

//+------------------------------------------------------------------+
//| ARL_Config.mqh
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: core/config
// Purpose: Holds non-input configuration defaults. User-facing input values live in ARL_Core.mq5.
// Inputs: compile-time defaults
// Outputs: central defaults for future modules
// Forbidden: runtime mutation, changelog, trading rules
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

string ARL_DefaultUniverseMode(){ return "MARKET_WATCH_ONLY"; }
string ARL_DefaultOutputScope(){ return "COMMON_FILES"; }

#endif // __CORE_ARL_CONFIG_MQH__
