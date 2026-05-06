#ifndef __CORE_ARL_RESULTCODES_MQH__
#define __CORE_ARL_RESULTCODES_MQH__

//+------------------------------------------------------------------+
//| ARL_ResultCodes.mqh
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: core/result codes
// Purpose: Defines shared success/failure/status codes so modules do not invent private meanings.
// Inputs: none
// Outputs: stable ARL status enums and integer constants
// Forbidden: trade permission, ranking formulas, file writes
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

enum ARL_ResultCode
  {
   ARL_RESULT_OK = 0,
   ARL_RESULT_PENDING = 10,
   ARL_RESULT_PARTIAL = 20,
   ARL_RESULT_DEGRADED = 30,
   ARL_RESULT_SKIPPED_NOT_DUE = 40,
   ARL_RESULT_RETRY_DUE = 50,
   ARL_RESULT_FAILED = 90,
   ARL_RESULT_FORBIDDEN = 99
  };

enum ARL_ReadinessCode
  {
   ARL_READY_NO = 0,
   ARL_READY_PARTIAL = 50,
   ARL_READY_YES = 100
  };

#endif // __CORE_ARL_RESULTCODES_MQH__
