#ifndef ASC_RUNTIME_SHUTDOWN_MQH
#define ASC_RUNTIME_SHUTDOWN_MQH

#include "../core/ASC_Core_RuntimeState.mqh"

void ASC_RuntimeShutdownApply(ASC_RootRuntimeState &state,
                              const int reason)
  {
   datetime now = TimeCurrent();
   if(now <= 0)
      now = TimeLocal();

   if(reason == REASON_CLOSE ||
      reason == REASON_REMOVE ||
      reason == REASON_RECOMPILE ||
      reason == REASON_CHARTCLOSE ||
      reason == REASON_PROGRAM ||
      reason == REASON_TEMPLATE ||
      reason == REASON_ACCOUNT ||
      reason == REASON_PARAMETERS)
     {
      // Shutdown reasons are acknowledged intentionally.
     }

   state.Runtime.LifecycleState.Lifecycle         = ASC_RUNTIME_LIFECYCLE_STOPPED;
   state.Runtime.LifecycleState.LastLifecycleChangeAt = now;
   state.Governor.Heartbeat.DominantWorkClass     = ASC_WORK_CLASS_NONE;
   state.Governor.Heartbeat.DominantLaneAdmission = ASC_LANE_ADMISSION_NONE;
   state.Governor.Heartbeat.DominantLaneKey       = "stopped";
   state.Governor.Heartbeat.LastHeartbeatAt       = now;
  }

#endif // ASC_RUNTIME_SHUTDOWN_MQH
