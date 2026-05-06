#ifndef ASC_RUNTIME_MANAGER_MQH
#define ASC_RUNTIME_MANAGER_MQH

#include "../config/ASC_Config_Defaults.mqh"
#include "../hud/ASC_HUD_BrowseState.mqh"
#include "../hud/ASC_HUD_Manager.mqh"
#include "../layers/ASC_Layer1_MarketState.mqh"
#include "../persistence/ASC_Persistence_Publication.mqh"
#include "ASC_Runtime_Boot.mqh"
#include "ASC_Runtime_Heartbeat.mqh"
#include "ASC_Runtime_Shutdown.mqh"

// Runtime manager for the current bounded pass.
// Ownership in this file:
// - boot/shutdown orchestration
// - heartbeat phase ordering
// - isolated publication window
// It intentionally does not widen into later-layer orchestration or menu authority.

ASC_RootRuntimeState g_asc_runtime_state;
int  g_asc_heartbeat_count = 0;
bool g_asc_comment_enabled = ASC_DEFAULT_SHOW_CHART_STATUS;
bool g_asc_runtime_initialized = false;
bool g_asc_runtime_heartbeat_active = false;

int ASC_RuntimeClampHeartbeatSeconds(const int requested_seconds)
  {
   if(requested_seconds < ASC_MIN_HEARTBEAT_SECONDS)
      return ASC_MIN_HEARTBEAT_SECONDS;
   if(requested_seconds > ASC_MAX_HEARTBEAT_SECONDS)
      return ASC_MAX_HEARTBEAT_SECONDS;
   return requested_seconds;
  }

bool ASC_RuntimeRunScanPhase(ASC_RootRuntimeState &state)
  {
   state.Governor.Heartbeat.DominantWorkClass     = ASC_WORK_CLASS_SCAN;
   state.Governor.Heartbeat.DominantLaneAdmission = ASC_LANE_ADMISSION_ACTIVE_OWNER;
   state.Governor.Heartbeat.DominantLaneKey       = "market_status_scan";
   return ASC_Layer1Scan(state);
  }

bool ASC_RuntimeRunWritePhase(ASC_RootRuntimeState &state)
  {
   state.Governor.Heartbeat.DominantWorkClass     = ASC_WORK_CLASS_PERSISTENCE_WRITE;
   state.Governor.Heartbeat.DominantLaneAdmission = ASC_LANE_ADMISSION_ACTIVE_OWNER;
   state.Governor.Heartbeat.DominantLaneKey       = "publication_write";
   return ASC_PublicationWriteLayer1Outputs(state);
  }

void ASC_RuntimeRunReadPhase(ASC_RootRuntimeState &state)
  {
   state.Governor.Heartbeat.DominantWorkClass        = ASC_WORK_CLASS_HUD_RENDER;
   state.Governor.Heartbeat.DominantLaneAdmission    = ASC_LANE_ADMISSION_ACTIVE_OWNER;
   state.Governor.Heartbeat.DominantLaneKey          = "hud_read";
   state.Runtime.PhaseMarkers.LastStructuralConsumeAt = state.Runtime.PhaseMarkers.LastHeartbeatAt;
   ASC_HUD_PrepareBrowseData(state);
   ASC_HUD_ShowStatus(state, g_asc_heartbeat_count, g_asc_comment_enabled);
  }

bool ASC_RuntimeInitialize(const int heartbeat_seconds,
                           const bool comment_enabled)
  {
   if(ASC_RuntimeClampHeartbeatSeconds(heartbeat_seconds) <= 0)
      return false;

   g_asc_comment_enabled   = comment_enabled;
   g_asc_heartbeat_count   = 0;

   if(!ASC_RuntimeBootInitialize(g_asc_runtime_state))
      return false;

   if(!ASC_PublicationInitialize(g_asc_runtime_state))
      return false;

   ASC_RuntimeHeartbeatApply(g_asc_runtime_state);

   if(!ASC_RuntimeRunScanPhase(g_asc_runtime_state))
      return false;

   if(!ASC_RuntimeRunWritePhase(g_asc_runtime_state))
      return false;

   g_asc_runtime_initialized      = true;
   g_asc_runtime_heartbeat_active = false;

   ASC_RuntimeRunReadPhase(g_asc_runtime_state);
   return true;
  }

void ASC_RuntimeHeartbeat()
  {
   if(!g_asc_runtime_initialized)
      return;

   if(g_asc_runtime_heartbeat_active)
      return;

   g_asc_runtime_heartbeat_active = true;
   g_asc_heartbeat_count++;

   ASC_RuntimeHeartbeatApply(g_asc_runtime_state);

   if(ASC_RuntimeRunScanPhase(g_asc_runtime_state))
     {
      if(ASC_RuntimeRunWritePhase(g_asc_runtime_state))
         ASC_RuntimeRunReadPhase(g_asc_runtime_state);
     }

   // After completing the heartbeat, perform a catch-up render if the HUD remains
   // dirty. This ensures operator clicks or state changes during scan/write
   // cycles are reflected immediately instead of waiting for the next timer
   // heartbeat. The HUD stays consumer-only and simply re-renders existing
   // prepared browse data.
   if(g_asc_hud_state.Dirty)
      ASC_HUD_ShowStatus(g_asc_runtime_state, g_asc_heartbeat_count, g_asc_comment_enabled);

   g_asc_runtime_heartbeat_active = false;
  }

void ASC_RuntimeShutdown(const int reason)
  {
   if(!g_asc_runtime_initialized)
     {
      ASC_HUD_ClearStatus();
      return;
     }

   ASC_RuntimeShutdownApply(g_asc_runtime_state, reason);

   if(ASC_PublicationBeginWriteWindow(g_asc_runtime_state))
     {
      ASC_PublicationWriteSummary(g_asc_runtime_state);
      ASC_PublicationEndWriteWindow(g_asc_runtime_state);
     }

   ASC_HUD_ClearStatus();

   g_asc_runtime_initialized      = false;
   g_asc_runtime_heartbeat_active = false;
   g_asc_heartbeat_count          = 0;
  }

void ASC_RuntimeHandleChartEvent(const int id,
                                 const long &lparam,
                                 const double &dparam,
                                 const string &sparam)
  {
   if(!g_asc_runtime_initialized)
      return;

   ASC_HUD_HandleChartEvent(id, lparam, dparam, sparam);

   if(!g_asc_comment_enabled)
      return;

   if(g_asc_runtime_heartbeat_active)
      return;

   if(!g_asc_hud_state.Dirty)
      return;

   ASC_HUD_ShowStatus(g_asc_runtime_state, g_asc_heartbeat_count, g_asc_comment_enabled);
  }

#endif // ASC_RUNTIME_MANAGER_MQH
