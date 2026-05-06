#ifndef ASC_RUNTIME_BOOT_MQH
#define ASC_RUNTIME_BOOT_MQH

#include "../config/ASC_Config_Defaults.mqh"
#include "../core/ASC_Core_RuntimeState.mqh"

string ASC_RuntimeBuildSessionId()
  {
   return ASC_DEFAULT_BUILD_NAME + "-" + IntegerToString((int)GetTickCount());
  }

void ASC_RuntimePrimeLayerScaffold(ASC_RootRuntimeState &state,
                                   const datetime now)
  {
   state.LayerScaffold.Layer1.Implemented = true;
   state.LayerScaffold.Layer1.StatusNote  = "Market Status is implemented in this pass.";
   state.LayerScaffold.Layer1.LastUpdateAt = now;

   // Layer2 (open symbol snapshot) now has a minimal implementation.  It will
   // collect a bounded snapshot of open symbols with basic market fields.  More
   // detailed packet enrichment may be added later.
   state.LayerScaffold.Layer2.Implemented = true;
   state.LayerScaffold.Layer2.StatusNote  = "Open Symbol Snapshot minimally implemented; collects basic bid/ask/spread snapshots for open symbols.";
   state.LayerScaffold.Layer2.LastUpdateAt = now;

   state.LayerScaffold.Layer3.Implemented = false;
   state.LayerScaffold.Layer3.StatusNote  = "Selection Filter scaffold exists. Filtering and classification logic remain intentionally deferred.";
   state.LayerScaffold.Layer3.LastUpdateAt = now;

   state.LayerScaffold.Layer4.Implemented = false;
   state.LayerScaffold.Layer4.StatusNote  = "Shortlist scaffold exists. Selection logic remains intentionally deferred.";
   state.LayerScaffold.Layer4.LastUpdateAt = now;

   state.LayerScaffold.Layer5.Implemented = false;
   state.LayerScaffold.Layer5.StatusNote  = "Deep Analysis scaffold exists. Deep analysis remains intentionally deferred.";
   state.LayerScaffold.Layer5.LastUpdateAt = now;
  }

bool ASC_RuntimeBootInitialize(ASC_RootRuntimeState &state)
  {
   datetime now = TimeCurrent();
   if(now <= 0)
      now = TimeLocal();

   state.Ids.RuntimeSessionId                         = ASC_RuntimeBuildSessionId();
   state.Ids.BuildId                                  = ASC_DEFAULT_BUILD_NAME;
   state.Ids.GenerationId                             = "generation-1";

   state.Runtime.Identity.RuntimeSessionId            = state.Ids.RuntimeSessionId;
   state.Runtime.Identity.ServerName                  = AccountInfoString(ACCOUNT_SERVER);
   state.Runtime.Identity.BuildId                     = state.Ids.BuildId;
   state.Runtime.Identity.StartedAt                   = now;

   state.Runtime.LifecycleState.Lifecycle             = ASC_RUNTIME_LIFECYCLE_RUNNING;
   state.Runtime.LifecycleState.StructuralFreshness   = ASC_FRESHNESS_PENDING_REFRESH;
   state.Runtime.LifecycleState.StructuralCompleteness = ASC_COMPLETENESS_PARTIAL;
   state.Runtime.LifecycleState.StructuralCoherence   = ASC_COHERENCE_COHERENT;
   state.Runtime.LifecycleState.WarmupSatisfied       = false;
   state.Runtime.LifecycleState.StructuralArtifactsAvailable = false;
   state.Runtime.LifecycleState.LastLifecycleChangeAt = now;

   state.Runtime.PhaseMarkers.LastHeartbeatAt         = now;
   state.Runtime.PhaseMarkers.LastStructuralCommitAt  = 0;
   state.Runtime.PhaseMarkers.LastStructuralConsumeAt = now;

   state.Governor.Heartbeat.Mode                      = ASC_GOVERNOR_MODE_WARMUP;
   state.Governor.Heartbeat.DominantWorkClass         = ASC_WORK_CLASS_NONE;
   state.Governor.Heartbeat.DominantLaneAdmission     = ASC_LANE_ADMISSION_NONE;
   state.Governor.Heartbeat.DominantLaneKey           = "idle";
   state.Governor.Heartbeat.LastHeartbeatAt           = now;

   state.Governor.Pressure.OverallPressure            = ASC_QUEUE_PRESSURE_HEALTHY;
   state.Governor.Pressure.PersistencePressure        = ASC_QUEUE_PRESSURE_HEALTHY;
   state.Governor.Pressure.StructuralPressure         = ASC_QUEUE_PRESSURE_HEALTHY;
   state.Governor.Pressure.FocusPressure              = ASC_QUEUE_PRESSURE_HEALTHY;
   state.Governor.Pressure.LastPressureChangeAt       = now;
   state.Governor.ForcedServiceDue                    = false;
   state.Governor.AtomicLandingProtected              = false;

   state.FocusedSymbol.Identity.ServerName            = state.Runtime.Identity.ServerName;
   state.FocusedSymbol.LastKnownMarketState           = ASC_MARKET_STATE_UNKNOWN;
   state.FocusedSymbol.KnownToRuntime                 = false;
   state.FocusedSymbol.SelectedByOperator             = false;
   state.FocusedSymbol.LastIdentityTouchAt            = now;

   state.Publication.OutputRoot                       = "";
   state.Publication.SummaryPath                      = "";
   state.Publication.DossierFolderPath                = "";
   state.Publication.OutputReady                      = false;
   state.Publication.WriteWindowOpen                  = false;
   state.Publication.LastSummaryWriteAt               = 0;
   state.Publication.LastDossierWriteAt               = 0;

   state.Layer1.TotalSymbols                          = 0;
   state.Layer1.OpenCount                             = 0;
   state.Layer1.ClosedCount                           = 0;
   state.Layer1.UncertainCount                        = 0;
   state.Layer1.UnknownCount                          = 0;
   state.Layer1.FreshCount                            = 0;
   state.Layer1.StaleCount                            = 0;
   state.Layer1.PendingRefreshCount                   = 0;
   state.Layer1.DegradedCount                         = 0;
   state.Layer1.CompleteCount                         = 0;
   state.Layer1.PartialCount                          = 0;
   state.Layer1.BlockedCount                          = 0;
   state.Layer1.LastScanDurationMilliseconds          = 0;
   state.Layer1.LastScanAt                            = 0;
   state.Layer1.LastSummaryPublishAt                  = 0;
   state.Layer1.LastDossierPublishAt                  = 0;
   state.Layer1.PublicationReady                      = false;

   ASC_RuntimePrimeLayerScaffold(state, now);
   return true;
  }

#endif // ASC_RUNTIME_BOOT_MQH
