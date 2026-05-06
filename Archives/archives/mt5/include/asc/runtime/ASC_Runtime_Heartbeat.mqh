#ifndef ASC_RUNTIME_HEARTBEAT_MQH
#define ASC_RUNTIME_HEARTBEAT_MQH

#include "../core/ASC_Core_RuntimeState.mqh"

void ASC_RuntimeHeartbeatApply(ASC_RootRuntimeState &state)
  {
   datetime now = TimeCurrent();
   if(now <= 0)
      now = TimeLocal();

   state.Runtime.PhaseMarkers.LastHeartbeatAt     = now;
   state.Governor.Heartbeat.Mode                  = ASC_GOVERNOR_MODE_NORMAL;
   state.Governor.Heartbeat.DominantWorkClass     = ASC_WORK_CLASS_SCAN;
   state.Governor.Heartbeat.DominantLaneAdmission = ASC_LANE_ADMISSION_ACTIVE_OWNER;
   state.Governor.Heartbeat.DominantLaneKey       = "scan_cycle";
   state.Governor.Heartbeat.LastHeartbeatAt       = now;
  }

#endif // ASC_RUNTIME_HEARTBEAT_MQH
