#ifndef __TELEMETRY_ARL_RUNTIMEMETRICS_MQH__
#define __TELEMETRY_ARL_RUNTIMEMETRICS_MQH__

//+------------------------------------------------------------------+
//| ARL_RuntimeMetrics
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: RUNTIME METRICS ONLY — no edge/profit claims.
//+------------------------------------------------------------------+
// Owner: telemetry/runtime metrics
// Purpose: Owns timing/budget metrics for timer-path observability.
// Inputs: elapsed ms from bounded runtime cycle
// Outputs: last and max cycle ms
// Forbidden: profit/edge claims, symbol scoring, trading permission

int g_arl_last_cycle_ms = 0;
int g_arl_max_cycle_ms = 0;

bool ARL_RuntimeMetrics_Init()
  {
   g_arl_last_cycle_ms = 0;
   g_arl_max_cycle_ms = 0;
   return true;
  }

void ARL_RuntimeMetrics_RecordCycle(const int elapsed_ms)
  {
   g_arl_last_cycle_ms = elapsed_ms;
   if(elapsed_ms > g_arl_max_cycle_ms)
      g_arl_max_cycle_ms = elapsed_ms;
  }

int ARL_RuntimeMetrics_LastCycleMs()
  {
   return g_arl_last_cycle_ms;
  }

int ARL_RuntimeMetrics_MaxCycleMs()
  {
   return g_arl_max_cycle_ms;
  }

string ARL_RuntimeMetrics_Line()
  {
   return "ARL_RuntimeMetrics=ACTIVE;last_cycle_ms=" + IntegerToString(g_arl_last_cycle_ms) + ";max_cycle_ms=" + IntegerToString(g_arl_max_cycle_ms);
  }

#endif // __TELEMETRY_ARL_RUNTIMEMETRICS_MQH__
