#ifndef __PERMISSION_ARL_NOTRADEPERMISSIONBOUNDARY_MQH__
#define __PERMISSION_ARL_NOTRADEPERMISSIONBOUNDARY_MQH__

//+------------------------------------------------------------------+
//| ARL_NoTradePermissionBoundary.mqh
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: permission/no-trade boundary
// Purpose: Centralizes no-trade/no-signal/no-execution truth for all review outputs.
// Inputs: none
// Outputs: permission fields and safety text
// Forbidden: actual trading logic or exceptions
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_TradePermission(){ return false; }
bool ARL_SignalPermission(){ return false; }
bool ARL_ExecutionPermission(){ return false; }
bool ARL_RiskPermission(){ return false; }

string ARL_PermissionBoundaryLine()
  {
   return "trade_permission=false | signal_permission=false | execution_permission=false | risk_permission=false";
  }

#endif // __PERMISSION_ARL_NOTRADEPERMISSIONBOUNDARY_MQH__
