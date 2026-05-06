#ifndef ASC_CORE_IDS_MQH
#define ASC_CORE_IDS_MQH

#include "../types/ASC_Enums.mqh"

// Stage 1 ID scaffolding only.
// Generation rules and builders belong to later stages.

struct ASC_RuntimeIds
  {
   string RuntimeSessionId;
   string BuildId;
   string GenerationId;
  };

struct ASC_ArtifactIds
  {
   string ArtifactId;
   string DependencySetId;
   string LastGoodSourceId;
  };

#endif // ASC_CORE_IDS_MQH
