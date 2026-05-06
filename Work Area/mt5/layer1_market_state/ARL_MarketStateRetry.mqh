#ifndef __LAYER1_MARKET_STATE_ARL_MARKETSTATERETRY_MQH__
#define __LAYER1_MARKET_STATE_ARL_MARKETSTATERETRY_MQH__

//+------------------------------------------------------------------+
//| ARL_MarketStateRetry
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: layer1/retry
// Purpose: Owns bounded retry/backoff for unknown market state only.
// Inputs: market unknown reasons
// Outputs: retry due/attempts
// Forbidden: retrying confirmed open/closed symbols
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_MarketStateRetry_RefreshSymbol(const string symbol){ return true; }
int ARL_MarketStateRetry_StateCode(){ return 0; }

#endif // __LAYER1_MARKET_STATE_ARL_MARKETSTATERETRY_MQH__
