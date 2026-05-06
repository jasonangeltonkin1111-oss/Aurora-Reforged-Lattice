#ifndef __CORE_ARL_CONSTANTS_MQH__
#define __CORE_ARL_CONSTANTS_MQH__

//+------------------------------------------------------------------+
//| ARL_Constants.mqh
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: core/constants
// Purpose: Defines shared cadence defaults and output names. Runtime may override through inputs.
// Inputs: versioned design defaults from blueprint/roadmap
// Outputs: consistent constants consumed by runtime and writers
// Forbidden: formulas, trading thresholds, strategy weights
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

#define ARL_DEFAULT_TIMER_SECONDS        1
#define ARL_DEFAULT_WORK_BUDGET_MS       50
#define ARL_L2_ACTIVE_REFRESH_SECONDS    60
#define ARL_L3_REFRESH_SECONDS           1200
#define ARL_L4_OFFSET_SECONDS            300
#define ARL_L4_REFRESH_SECONDS           1200
#define ARL_L5_ACTIVE_REFRESH_SECONDS    300

#define ARL_OUTPUT_ROOT_FOLDER           "Aurora Reforged Lattice"
#define ARL_STATUS_CURRENT_FILE          "Status_Current.json"
#define ARL_MANIFEST_CURRENT_FILE        "Manifest_Current.json"
#define ARL_MARKET_BOARD_CURRENT_TXT     "MarketBoard_Current.txt"
#define ARL_MARKET_BOARD_CURRENT_JSON    "MarketBoard_Current.json"

#endif // __CORE_ARL_CONSTANTS_MQH__
