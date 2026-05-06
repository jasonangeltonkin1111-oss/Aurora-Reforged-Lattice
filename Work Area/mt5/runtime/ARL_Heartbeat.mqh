#ifndef __RUNTIME_ARL_HEARTBEAT_MQH__
#define __RUNTIME_ARL_HEARTBEAT_MQH__

//+------------------------------------------------------------------+
//| ARL_Heartbeat
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: BOUNDED HEARTBEAT ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: runtime/heartbeat
// Purpose: Owns alive/breathing telemetry and must stay tiny.
// Inputs: timer event
// Outputs: heartbeat count and last heartbeat timestamps
// Forbidden: symbol scanning, file publication, ranking, dossier work, account scanning

ulong    g_arl_heartbeat_count = 0;
datetime g_arl_heartbeat_last_server_time = 0;
datetime g_arl_heartbeat_last_utc_time = 0;

bool ARL_Heartbeat_Init()
  {
   g_arl_heartbeat_count = 0;
   g_arl_heartbeat_last_server_time = TimeCurrent();
   g_arl_heartbeat_last_utc_time = TimeGMT();
   return true;
  }

bool ARL_Heartbeat_Tick()
  {
   g_arl_heartbeat_count++;
   g_arl_heartbeat_last_server_time = TimeCurrent();
   g_arl_heartbeat_last_utc_time = TimeGMT();
   return true;
  }

ulong ARL_Heartbeat_Count()
  {
   return g_arl_heartbeat_count;
  }

datetime ARL_Heartbeat_LastServerTime()
  {
   return g_arl_heartbeat_last_server_time;
  }

datetime ARL_Heartbeat_LastUtcTime()
  {
   return g_arl_heartbeat_last_utc_time;
  }

string ARL_Heartbeat_Status()
  {
   return "HEARTBEAT_ACTIVE";
  }

#endif // __RUNTIME_ARL_HEARTBEAT_MQH__
