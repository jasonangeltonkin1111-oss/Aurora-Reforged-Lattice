#ifndef ASC_TYPES_CONTROL_MQH
#define ASC_TYPES_CONTROL_MQH

#include "ASC_Enums.mqh"

// Stage 1 control and governor state scaffolding only.
// No admission logic, queue handling, or scheduler behavior belongs here.

struct ASC_HeartbeatOwnershipState
  {
   ASC_GovernorModePosture Mode;
   ASC_WorkClassPosture DominantWorkClass;
   ASC_LaneAdmissionPosture DominantLaneAdmission;
   string DominantLaneKey;
   datetime LastHeartbeatAt;
  };

struct ASC_WorkCreditState
  {
   int SymbolCreditsGranted;
   int SymbolCreditsConsumed;
   int PacketCreditsGranted;
   int PacketCreditsConsumed;
   int ArtifactCreditsGranted;
   int ArtifactCreditsConsumed;
   int RenderCreditsGranted;
   int RenderCreditsConsumed;
  };

struct ASC_QueuePressureState
  {
   ASC_QueuePressurePosture OverallPressure;
   ASC_QueuePressurePosture PersistencePressure;
   ASC_QueuePressurePosture StructuralPressure;
   ASC_QueuePressurePosture FocusPressure;
   datetime LastPressureChangeAt;
  };

struct ASC_GovernorState
  {
   ASC_HeartbeatOwnershipState Heartbeat;
   ASC_WorkCreditState Credits;
   ASC_QueuePressureState Pressure;
   bool ForcedServiceDue;
   bool AtomicLandingProtected;
  };

#endif // ASC_TYPES_CONTROL_MQH
