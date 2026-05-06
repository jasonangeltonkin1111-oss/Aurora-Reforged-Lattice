#ifndef __MARKET_BOARD_ARL_BOARDEXCLUSIONREASON_MQH__
#define __MARKET_BOARD_ARL_BOARDEXCLUSIONREASON_MQH__

//+------------------------------------------------------------------+
//| ARL_BoardExclusionReason
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: market board/exclusion reason
// Purpose: Owns numeric exclusion reasons for exposure/stale/partial blockers.
// Inputs: candidate rows and account exposure
// Outputs: exclusion code/reason
// Forbidden: hiding strong-but-blocked symbols
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_BoardExclusionReason_Compose(){ return true; }
string ARL_BoardExclusionReason_Status(){ return "SCAFFOLD"; }

#endif // __MARKET_BOARD_ARL_BOARDEXCLUSIONREASON_MQH__
