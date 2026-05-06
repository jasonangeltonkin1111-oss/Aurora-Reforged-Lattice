#ifndef __CORE_ARL_TYPES_MQH__
#define __CORE_ARL_TYPES_MQH__

//+------------------------------------------------------------------+
//| ARL_Types.mqh
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: core/shared types
// Purpose: Defines small shared value objects that let modules exchange status without hidden ownership.
// Inputs: module status, timestamps, identifiers
// Outputs: typed status records used by later implementation
// Forbidden: module-specific calculations or file publication
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

struct ARL_ModuleStatus
  {
   string module_name;
   int    status_code;
   string status_label;
   string owner;
   string reason;
   datetime last_attempt;
   datetime last_success;
   datetime next_due;
  };

struct ARL_SnapshotIdentity
  {
   string snapshot_id;
   string source_run_id;
   string source_version;
   datetime generated_utc;
   bool complete;
   string completeness_reason;
  };

struct ARL_NumericField
  {
   double value;
   bool   available;
   string source;
   string formula;
   string timeframe;
   int    sample_count;
   datetime refreshed_at;
   string status;
  };

#endif // __CORE_ARL_TYPES_MQH__
