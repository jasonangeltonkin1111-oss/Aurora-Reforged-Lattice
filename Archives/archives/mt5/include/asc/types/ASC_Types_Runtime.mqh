#ifndef ASC_TYPES_RUNTIME_MQH
#define ASC_TYPES_RUNTIME_MQH

#include "ASC_Enums.mqh"

// Stage 1 runtime identity and lifecycle scaffolding only.
// No dispatcher logic, layer behavior, or persistence mechanics belong here.

struct ASC_RuntimeIdentity
  {
   string RuntimeSessionId;
   string ServerName;
   string BuildId;
   datetime StartedAt;
  };

struct ASC_RuntimeLifecycleState
  {
   ASC_RuntimeLifecyclePosture Lifecycle;
   ASC_FreshnessPosture StructuralFreshness;
   ASC_CompletenessPosture StructuralCompleteness;
   ASC_CoherencePosture StructuralCoherence;
   bool WarmupSatisfied;
   bool StructuralArtifactsAvailable;
   datetime LastLifecycleChangeAt;
  };

struct ASC_RuntimePhaseMarkers
  {
   datetime LastHeartbeatAt;
   datetime LastStructuralCommitAt;
   datetime LastStructuralConsumeAt;
  };

struct ASC_RuntimeStateSummary
  {
   ASC_RuntimeIdentity Identity;
   ASC_RuntimeLifecycleState LifecycleState;
   ASC_RuntimePhaseMarkers PhaseMarkers;
  };

#endif // ASC_TYPES_RUNTIME_MQH
