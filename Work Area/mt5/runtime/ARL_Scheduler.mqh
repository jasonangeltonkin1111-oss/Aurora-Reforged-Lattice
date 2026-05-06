#ifndef __RUNTIME_ARL_SCHEDULER_MQH__
#define __RUNTIME_ARL_SCHEDULER_MQH__

//+------------------------------------------------------------------+
//| ARL_Scheduler
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: BOUNDED SCHEDULER TICK ONLY — no layer work.
//+------------------------------------------------------------------+
// Owner: runtime/scheduler
// Purpose: Owns bounded scheduler ticks. RUN009 permits status publication coordination only.
// Inputs: timer event
// Outputs: scheduler tick count and status
// Forbidden: symbol loops, account scans, ranking, Market Board, dossiers, signals, execution

ulong    g_arl_scheduler_tick_count = 0;
datetime g_arl_scheduler_last_tick_server_time = 0;

bool ARL_Scheduler_Init()
  {
   g_arl_scheduler_tick_count = 0;
   g_arl_scheduler_last_tick_server_time = TimeCurrent();
   return true;
  }

bool ARL_Scheduler_Tick()
  {
   g_arl_scheduler_tick_count++;
   g_arl_scheduler_last_tick_server_time = TimeCurrent();
   return true;
  }

ulong ARL_Scheduler_TickCount()
  {
   return g_arl_scheduler_tick_count;
  }

datetime ARL_Scheduler_LastTickServerTime()
  {
   return g_arl_scheduler_last_tick_server_time;
  }

string ARL_Scheduler_Status()
  {
   return "SCHEDULER_BOUNDED_STATUS_ONLY";
  }

#endif // __RUNTIME_ARL_SCHEDULER_MQH__
