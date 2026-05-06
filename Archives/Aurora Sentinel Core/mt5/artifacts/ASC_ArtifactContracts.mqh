#ifndef __ASC_ARTIFACT_CONTRACTS_MQH__
#define __ASC_ARTIFACT_CONTRACTS_MQH__

#include "../core/ASC_Types.mqh"

struct ASC_ArtifactContract
  {
   ASC_ArtifactFamily family;
   string artifact_name;
   string target_path;
   ASC_PublicationState publication_state;
  };

#endif
