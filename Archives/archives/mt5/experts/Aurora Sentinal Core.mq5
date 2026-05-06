#property strict
#property description "Aurora Sentinel Core - Navigation & pagination enhancement EA"
#property version   "1.027"

#include "../include/asc/config/ASC_Config_Defaults.mqh"
#include "../include/asc/runtime/ASC_Runtime_Manager.mqh"

input int  InpHeartbeatSeconds = ASC_DEFAULT_HEARTBEAT_SECONDS;
input bool InpShowChartStatus  = ASC_DEFAULT_SHOW_CHART_STATUS;

int OnInit()
  {
   int safe_seconds = ASC_RuntimeClampHeartbeatSeconds(InpHeartbeatSeconds);

   if(!ASC_RuntimeInitialize(safe_seconds, InpShowChartStatus))
      return INIT_FAILED;

   EventSetTimer(safe_seconds);
   return INIT_SUCCEEDED;
  }

void OnDeinit(const int reason)
  {
   EventKillTimer();
   ASC_RuntimeShutdown(reason);
  }

void OnTimer()
  {
   ASC_RuntimeHeartbeat();
  }

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   ASC_RuntimeHandleChartEvent(id, lparam, dparam, sparam);
  }
