#ifndef ASC_CORE_RUNTIME_STATE_MQH
#define ASC_CORE_RUNTIME_STATE_MQH

#include "ASC_Core_Ids.mqh"
#include "ASC_Core_SymbolRegistry.mqh"
#include "../types/ASC_Types_Runtime.mqh"
#include "../types/ASC_Types_Control.mqh"
#include "../types/ASC_Types_Artifacts.mqh"
#include "../types/ASC_Types_Layers.mqh"

// Root runtime state for Aurora Sentinel Core.
// This pass extends the state shape just enough to support lawful scan/write separation,
// truthful Market Status publication, and passive downstream consumption.

struct ASC_ArtifactState
  {
   ASC_ArtifactMetadata StructuralOverview;
   ASC_ArtifactMetadata RuntimeControl;
   ASC_ArtifactMetadata RecoveryContinuity;
  };

struct ASC_PublicationState
  {
   string OutputRoot;
   string SummaryPath;
   string DossierFolderPath;
   bool OutputReady;
   bool WriteWindowOpen;
   datetime LastSummaryWriteAt;
   datetime LastDossierWriteAt;
  };

struct ASC_RootRuntimeState
  {
   ASC_RuntimeIds Ids;
   ASC_RuntimeStateSummary Runtime;
   ASC_GovernorState Governor;
   ASC_SymbolRegistryRecord FocusedSymbol;
   ASC_ArtifactState Artifacts;
   ASC_PublicationState Publication;
   ASC_Layer1ScanSummary Layer1;
   ASC_LayerScaffoldStatus LayerScaffold;
  };

#endif // ASC_CORE_RUNTIME_STATE_MQH
