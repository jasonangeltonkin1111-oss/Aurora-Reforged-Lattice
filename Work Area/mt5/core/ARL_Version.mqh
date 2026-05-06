#ifndef __CORE_ARL_VERSION_MQH__
#define __CORE_ARL_VERSION_MQH__

//+------------------------------------------------------------------+
//| ARL_Version.mqh
//| Aurora Reforged Lattice — MT5 runtime identity
//| Run: ARL-RUN009
//| Status: RUNTIME IO FOUNDATION — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: core/version identity
// Purpose: Exposes current product identity. It is not a changelog; office/ and Git own change history.
// Inputs: compile-time constants updated by controlled runs
// Outputs: version strings for EA properties, status files, manifests, logs
// Forbidden: runtime changelog, strategy logic, migration history, office ledger replacement

#define ARL_PRODUCT_NAME        "Aurora Reforged Lattice"
#define ARL_PRODUCT_SHORT_NAME  "ARL"
#define ARL_PRODUCT_VERSION     "1.005"
#define ARL_PRODUCT_RUN_ID      "ARL-RUN009"
#define ARL_PRODUCT_CHANNEL     "RUNTIME_IO_FOUNDATION"
#define ARL_PRODUCT_DATE        "2026-05-06"
#define ARL_PRODUCT_STATE       "RUNTIME_IO_FOUNDATION_NO_TRADING"
#define ARL_GIT_COMMIT_HINT     "SET_BY_GIT_OR_OFFICE_LEDGER"
#define ARL_PERMISSION_TEXT     "RUNTIME_STATUS_ONLY_NO_TRADE_SIGNAL_EXECUTION_OR_HUD_PERMISSION"

string ARL_VersionLine()
  {
   return ARL_PRODUCT_NAME + " v" + ARL_PRODUCT_VERSION + " | " + ARL_PRODUCT_RUN_ID + " | " + ARL_PRODUCT_CHANNEL + " | " + ARL_PRODUCT_STATE;
  }

string ARL_OperatorVersionLine()
  {
   return ARL_PRODUCT_NAME + " | Version " + ARL_PRODUCT_VERSION + " | " + ARL_PERMISSION_TEXT;
  }

#endif // __CORE_ARL_VERSION_MQH__
