#ifndef ASC_TYPES_LAYERS_MQH
#define ASC_TYPES_LAYERS_MQH

#include "ASC_Enums.mqh"
#include "ASC_Types_Artifacts.mqh"
#include "ASC_Types_Runtime.mqh"
#include "ASC_Types_Control.mqh"
#include "ASC_Types_HUD.mqh"
#include "../core/ASC_Core_SymbolRegistry.mqh"

// Shared layer-state contracts.
// This pass keeps Layer 1 materially real and the later layers structurally honest.

struct ASC_MarketStateRecord
  {
   ASC_SymbolIdentity Identity;
   ASC_MarketStatePosture MarketState;
   ASC_FreshnessPosture Freshness;
   ASC_CompletenessPosture Completeness;
   string StatusReason;
   string DecisionPath;
   datetime ObservedAt;
   bool PublishedOnce;
   ASC_MarketStatePosture LastPublishedState;
   datetime LastPublishedAt;
   datetime LastDecisionLogAt;
   int TickAgeSeconds;
   bool HasTradeSessionData;
   bool TradeSessionOpen;
   bool HasQuoteSessionData;
   bool QuoteSessionOpen;
   bool HasTick;
   bool HasUsablePrice;
  };

struct ASC_OpenSymbolSnapshotRecord
  {
   ASC_SymbolIdentity Identity;
   double Bid;
   double Ask;
   double SpreadPoints;
   int Digits;
   ASC_FreshnessPosture Freshness;
   ASC_CompletenessPosture Completeness;
   datetime ObservedAt;
  };

struct ASC_CandidateFilterRecord
  {
   string SymbolKey;
   ASC_CandidateEligibilityPosture Eligibility;
   string PrimaryReasonCode;
   datetime EvaluatedAt;
  };

struct ASC_ShortlistMembershipRecord
  {
   string SymbolKey;
   ASC_ShortlistPosture ShortlistState;
   int RankSlot;
   datetime UpdatedAt;
  };

struct ASC_DeepAnalysisRecord
  {
   string SymbolKey;
   ASC_FreshnessPosture Freshness;
   ASC_CompletenessPosture Completeness;
   datetime UpdatedAt;
  };

struct ASC_Layer1ScanSummary
  {
   int TotalSymbols;
   int OpenCount;
   int ClosedCount;
   int UncertainCount;
   int UnknownCount;

   int FreshCount;
   int StaleCount;
   int PendingRefreshCount;
   int DegradedCount;

   int ResolvedClassificationCount;
   int UnknownClassificationCount;
   int FxCount;
   int IndexCount;
   int MetalsCount;
   int EnergyCount;
   int CryptoCount;
   int StockCount;

   int CompleteCount;
   int PartialCount;
   int BlockedCount;

   int LastScanDurationMilliseconds;

   datetime LastScanAt;
   datetime LastSummaryPublishAt;
   datetime LastDossierPublishAt;
   bool PublicationReady;
  };

struct ASC_LayerSlotStatus
  {
   bool Implemented;
   string StatusNote;
   datetime LastUpdateAt;
  };

struct ASC_LayerScaffoldStatus
  {
   ASC_LayerSlotStatus Layer1;
   ASC_LayerSlotStatus Layer2;
   ASC_LayerSlotStatus Layer3;
   ASC_LayerSlotStatus Layer4;
   ASC_LayerSlotStatus Layer5;
  };

#endif // ASC_TYPES_LAYERS_MQH
