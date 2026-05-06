#ifndef __CORE_ARL_VERSION_MQH__
#define __CORE_ARL_VERSION_MQH__

//+------------------------------------------------------------------+
//| ARL_Version.mqh
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: core/version identity
// Purpose: Exposes current product identity. It is not a changelog; office/ and Git own change history.
// Inputs: compile-time constants updated by controlled runs
// Outputs: version strings for EA properties, status files, manifests, logs
// Forbidden: runtime changelog, strategy logic, migration history, office ledger replacement
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

#define ARL_PRODUCT_NAME        "Aurora Reforged Lattice"
#define ARL_PRODUCT_SHORT_NAME  "ARL"
#define ARL_PRODUCT_VERSION     "1.004"
#define ARL_PRODUCT_RUN_ID      "ARL-RUN004"
#define ARL_PRODUCT_CHANNEL     "SCAFFOLD"
#define ARL_PRODUCT_DATE        "2026-05-06"
#define ARL_PRODUCT_STATE       "MT5_SCAFFOLD_ONLY_NO_RUNTIME_PROOF"
#define ARL_GIT_COMMIT_HINT     "SET_BY_GIT_OR_OFFICE_LEDGER"
#define ARL_PERMISSION_TEXT     "REVIEW_ONLY_NO_TRADE_PERMISSION"

string ARL_VersionLine()
  {
   return ARL_PRODUCT_NAME + " v" + ARL_PRODUCT_VERSION + " | " + ARL_PRODUCT_RUN_ID + " | " + ARL_PRODUCT_CHANNEL + " | " + ARL_PRODUCT_STATE;
  }

string ARL_OperatorVersionLine()
  {
   return ARL_PRODUCT_NAME + " | Version " + ARL_PRODUCT_VERSION + " | " + ARL_PERMISSION_TEXT;
  }

#endif // __CORE_ARL_VERSION_MQH__
