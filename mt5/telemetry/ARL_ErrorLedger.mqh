#ifndef __TELEMETRY_ARL_ERRORLEDGER_MQH__
#define __TELEMETRY_ARL_ERRORLEDGER_MQH__

//+------------------------------------------------------------------+
//| ARL_ErrorLedger
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: telemetry/errors
// Purpose: Owns runtime error capture and last-error summaries.
// Inputs: module failures, GetLastError values
// Outputs: error ledger payload
// Forbidden: concealing errors
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_ErrorLedger_Init(){ return true; }
string ARL_ErrorLedger_Line(){ return "ARL_ErrorLedger=SCAFFOLD"; }

#endif // __TELEMETRY_ARL_ERRORLEDGER_MQH__
