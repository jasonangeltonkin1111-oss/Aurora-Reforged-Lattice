//+------------------------------------------------------------------+
//| Aurora Reforged Lattice — ARL_Core.mq5
//| Run: ARL-RUN007
//| Status: MT5 SCAFFOLD ONLY.
//| Purpose: compile-visible skeleton for future GPT zip-audit/research/patch runs.
//| Forbidden: trading, signals, execution, HUD, direct ASC migration.
//+------------------------------------------------------------------+
#property strict
#property copyright "Jason Angel Tonkin"
#property link      "https://github.com/jasonangeltonkin1111-oss/Aurora-Reforged-Lattice"
#property version   "1.004"
#property description "Aurora Reforged Lattice"
#property description "Version 1.004 | ARL-RUN007 | pre-work unification only"
#property description "Review-only architecture. No trade, signal, execution, or HUD permission."

#include "core/ARL_ResultCodes.mqh"
#include "core/ARL_Version.mqh"
#include "core/ARL_Constants.mqh"
#include "core/ARL_Types.mqh"
#include "core/ARL_Config.mqh"
#include "runtime/ARL_Bootstrap.mqh"
#include "runtime/ARL_Clock.mqh"
#include "runtime/ARL_Heartbeat.mqh"
#include "runtime/ARL_Scheduler.mqh"
#include "runtime/ARL_WorkBudget.mqh"
#include "runtime/ARL_WarmupState.mqh"
#include "runtime/ARL_RefreshCadence.mqh"
#include "runtime/ARL_RuntimeState.mqh"
#include "io/ARL_Paths.mqh"
#include "io/ARL_FilePublisher.mqh"
#include "io/ARL_PublicationManifest.mqh"
#include "io/ARL_PayloadHash.mqh"
#include "io/ARL_OutputContracts.mqh"
#include "telemetry/ARL_StatusWriter.mqh"
#include "telemetry/ARL_ErrorLedger.mqh"
#include "telemetry/ARL_FunctionResults.mqh"
#include "telemetry/ARL_RuntimeMetrics.mqh"
#include "account/ARL_AccountSnapshot.mqh"
#include "account/ARL_PositionSnapshot.mqh"
#include "account/ARL_OrderSnapshot.mqh"
#include "account/ARL_DealHistorySnapshot.mqh"
#include "account/ARL_ExposureMap.mqh"
#include "universe/ARL_MarketWatchUniverse.mqh"
#include "universe/ARL_SymbolFolderWriter.mqh"
#include "universe/ARL_SymbolRegistry.mqh"
#include "universe/ARL_SymbolIdentity.mqh"
#include "buckets/ARL_BucketDefinitions.mqh"
#include "buckets/ARL_BucketClassifier.mqh"
#include "buckets/ARL_MajorBucketMap.mqh"
#include "buckets/ARL_MinorBucketMap.mqh"
#include "layer1_market_state/ARL_MarketStateEngine.mqh"
#include "layer1_market_state/ARL_TickFreshness.mqh"
#include "layer1_market_state/ARL_SessionSchedule.mqh"
#include "layer1_market_state/ARL_MarketStateRetry.mqh"
#include "layer2_symbol_specs/ARL_SymbolSpecEngine.mqh"
#include "layer2_symbol_specs/ARL_BrokerConstraints.mqh"
#include "layer2_symbol_specs/ARL_SpreadSnapshot.mqh"
#include "layer2_symbol_specs/ARL_SpecCache.mqh"
#include "indicators/ARL_IndicatorRegistry.mqh"
#include "indicators/ARL_IndicatorCache.mqh"
#include "indicators/ARL_ATRModule.mqh"
#include "indicators/ARL_RangeModule.mqh"
#include "indicators/ARL_VolatilityModule.mqh"
#include "indicators/ARL_IndicatorRelease.mqh"
#include "layer3_surface_rank/ARL_L3_SurfaceRankEngine.mqh"
#include "layer3_surface_rank/ARL_L3_SurfaceScore.mqh"
#include "layer3_surface_rank/ARL_L3_FrictionScore.mqh"
#include "layer3_surface_rank/ARL_L3_ScoreInputs.mqh"
#include "layer3_surface_rank/ARL_L3_RankTable.mqh"
#include "layer3_surface_rank/ARL_L3_SnapshotWriter.mqh"
#include "layer4_bucket_rank/ARL_L4_BucketRankEngine.mqh"
#include "layer4_bucket_rank/ARL_L4_GlobalTop10.mqh"
#include "layer4_bucket_rank/ARL_L4_MajorTop5.mqh"
#include "layer4_bucket_rank/ARL_L4_MinorTop5.mqh"
#include "layer4_bucket_rank/ARL_L4_ActiveSet.mqh"
#include "layer4_bucket_rank/ARL_L4_SnapshotWriter.mqh"
#include "layer5_deep_review/ARL_L5_DeepScheduler.mqh"
#include "layer5_deep_review/ARL_L5_DeepInputs.mqh"
#include "layer5_deep_review/ARL_L5_ATRRegime.mqh"
#include "layer5_deep_review/ARL_L5_LiquidityContext.mqh"
#include "layer5_deep_review/ARL_L5_SessionPhase.mqh"
#include "layer5_deep_review/ARL_L5_StructureContext.mqh"
#include "layer5_deep_review/ARL_L5_DeepSnapshotWriter.mqh"
#include "market_board/ARL_MarketBoardComposer.mqh"
#include "market_board/ARL_MarketBoardWriter.mqh"
#include "market_board/ARL_UploadSuggestionEngine.mqh"
#include "market_board/ARL_BoardExclusionReason.mqh"
#include "dossiers/ARL_DossierContracts.mqh"
#include "dossiers/ARL_DossierComposer.mqh"
#include "dossiers/ARL_DossierWriter.mqh"
#include "dossiers/sections/ARL_Dossier_Header.mqh"
#include "dossiers/sections/ARL_Dossier_AccountExposure.mqh"
#include "dossiers/sections/ARL_Dossier_MarketState.mqh"
#include "dossiers/sections/ARL_Dossier_BrokerSpecs.mqh"
#include "dossiers/sections/ARL_Dossier_SurfaceRank.mqh"
#include "dossiers/sections/ARL_Dossier_BucketRank.mqh"
#include "dossiers/sections/ARL_Dossier_DeepReview.mqh"
#include "dossiers/sections/ARL_Dossier_MissingData.mqh"
#include "dossiers/sections/ARL_Dossier_OperatorSummary.mqh"
#include "permission/ARL_NoTradePermissionBoundary.mqh"
#include "debug/ARL_ScaffoldSelfCheck.mqh"
#include "tests/ARL_StaticContractTestHarness.mqh"
#include "tests/ARL_OutputContractTestHarness.mqh"

input group "ARL Product Identity"
input string InpARL_ProductName    = ARL_PRODUCT_NAME;
input string InpARL_ProductVersion = ARL_PRODUCT_VERSION;
input string InpARL_RunId          = ARL_PRODUCT_RUN_ID;
input string InpARL_Channel        = ARL_PRODUCT_CHANNEL;
input string InpARL_State          = ARL_PRODUCT_STATE;

input group "ARL Runtime Scaffold"
input int    InpARL_TimerSeconds   = ARL_DEFAULT_TIMER_SECONDS;
input int    InpARL_WorkBudgetMs   = ARL_DEFAULT_WORK_BUDGET_MS;
input bool   InpARL_EnableFileWrites = false;  // scaffold default: no runtime writes
input bool   InpARL_PrintStartupSummary = true;

input group "ARL Safety"
input bool   InpARL_ReviewOnlyMode = true;
input bool   InpARL_AllowTrading   = false;

int OnInit()
  {
   if(InpARL_PrintStartupSummary)
      Print(ARL_VersionLine());

   if(InpARL_AllowTrading)
     {
      Print("ARL safety violation: InpARL_AllowTrading must remain false in scaffold.");
      return(INIT_FAILED);
     }

   ARL_Bootstrap_Init();
   ARL_Heartbeat_Init();
   ARL_Scheduler_Init();

   int timer_seconds = InpARL_TimerSeconds;
   if(timer_seconds < 1)
      timer_seconds = 1;

   if(!EventSetTimer(timer_seconds))
     {
      Print("ARL scaffold: EventSetTimer failed. Error=", GetLastError());
      return(INIT_FAILED);
     }

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
   EventKillTimer();
   ARL_IndicatorRelease_Release();
   Print("ARL scaffold deinit. reason=", reason, " | ", ARL_OperatorVersionLine());
  }

void OnTick()
  {
   // Scaffold rule: OnTick remains light. Future work uses scheduler-owned due slices.
  }

void OnTimer()
  {
   ARL_Heartbeat_Tick();
   ARL_Scheduler_Tick();
  }
