#property strict

// Aurora Sentinel Scanner
// Wrapper Version: 1.167
// Schema Family: ASC Foundation
// Active Capability: Open Symbol Snapshot
// Next Planned Capability: Layer 2 selective packet recovery / focused freshness
// Runtime Posture: Foundation / Layer 1 + Layer 2 + Layer 3 + Layer 4 active; Layer 5 cadence split active
// Update Bump Law:
// - Every meaningful edit must bump version
// - Patch bump for non-breaking fixes and polish
// - Minor bump for meaningful subsystem expansion
// - Major bump to 2.000+ for architecture revision

#include "ASC_Common.mqh"
#include "ASC_ServerPaths.mqh"
#include "ASC_Logging.mqh"
#include "ASC_FileIO.mqh"
#include "ASC_MarketState.mqh"
#include "ASC_Persistence.mqh"
#include "ASC_Dossiers.mqh"
#include "ASC_ExplorerHUD.mqh"
#include "ASC_ExplorerSnapshot.mqh"

input group "Runtime"
input int InpHeartbeatSeconds=1;                        // Dispatcher Interval Seconds
input int InpUniverseSyncSeconds=300;                  // Universe Sync Interval Seconds
input int InpSymbolBudgetPerHeartbeat=25;              // Symbol Budget Per Heartbeat

input group "Scheduler"
input int InpBacklogAttentionThreshold=10;             // Backlog Attention Threshold Symbols

input group "Market State Detection"
input int InpFreshTickSeconds=90;                      // Fresh Tick Threshold Seconds
input int InpOpenRecheckSeconds=10;                    // Open Market Recheck Seconds
input int InpUncertainBurstLimit=6;                    // Uncertain Burst Limit
input int InpUncertainFastRecheckSeconds=5;            // Uncertain Fast Recheck Seconds
input int InpUncertainSlowRecheckSeconds=30;           // Uncertain Slow Recheck Seconds
input int InpClosedNearOpenWindowSeconds=60;           // Near Open Window Seconds
input int InpClosedNearOpenRecheckSeconds=5;           // Near Open Recheck Seconds
input int InpClosedSoonWindowSeconds=900;              // Closed Soon Window Seconds
input int InpClosedSoonRecheckSeconds=60;              // Closed Soon Recheck Seconds
input int InpClosedIdleRecheckSeconds=300;             // Closed Idle Recheck Seconds
input int InpUnknownRecheckSeconds=120;                // Unknown State Recheck Seconds

input group "Recovery & Persistence"
input int InpRuntimeSaveSeconds=30;                    // Runtime Save Interval Seconds
input int InpSchedulerSaveSeconds=15;                  // Scheduler Save Interval Seconds
input int InpSummarySaveSeconds=60;                    // Summary Save Interval Seconds
input int InpWarmupMinimumUniversePercent=35;          // Warmup Minimum Universe Percent
input int InpWarmupMinimumAssessedSharePercent=35;     // Warmup Minimum Assessed Share Percent
input bool InpRepairMissingDossiersOnBoot=true;        // Repair Missing Dossiers On Boot

input group "Logging & Attention"
input int InpLogVerbosity=1;                           // Log Verbosity: 0 Errors, 1 Normal, 2 Debug
input bool InpLogSchedulerDecisions=false;             // Log Scheduler Decisions
input bool InpLogRecoveryEvents=true;                  // Log Recovery Events
input bool InpLogDossierRepairs=true;                  // Log Dossier Repairs

input group "Dossiers & Publication"
input bool InpWriteDossiersWhenDue=true;               // Write Dossiers When Due
input bool InpIncludeReservedCapabilityPlaceholders=true; // Include Reserved Capability Placeholders

input group "Explorer HUD"
input bool InpExplorerEnabled=true;                    // Explorer HUD Enabled
input int InpExplorerRefreshSeconds=1;                 // Explorer Refresh Seconds
input int InpExplorerScrollStepRows=1;                 // Explorer Scroll Step Rows
input int InpExplorerDensityMode=1;                    // Explorer Density: 0 Compact, 1 Normal, 2 Detailed
input bool InpExplorerShowBreadcrumbs=true;            // Explorer Show Path

input group "Symbol Identity and Bucketing (Reserved)"
input bool InpReserveIdentityAndBucketingControls=true; // Reserved: Symbol Identity and Bucketing Controls

input group "Open Symbol Snapshot"
input bool InpReserveOpenSymbolSnapshotControls=true;  // Open Symbol Snapshot Controls
input int InpReservedSnapshotM1Bars=500;              // Reserved: Snapshot M1 Bars
input int InpReservedSnapshotM5Bars=500;              // Reserved: Snapshot M5 Bars
input int InpReservedSnapshotM15Bars=500;             // Reserved: Snapshot M15 Bars

input group "Candidate Filtering"
input bool InpReserveCandidateFilteringControls=true;  // Candidate Filtering Controls

input group "Shortlist Selection"
input bool InpReserveShortlistSelectionControls=true;  // Shortlist Selection Controls
input int InpReservedSelectedSymbolLimit=25;           // Global Selected Symbol Limit
input int InpReservedSelectedBucketLimit=5;            // Per-Bucket Selected Symbol Limit

input group "Deep Selective Analysis (Reserved)"
input bool InpReserveDeepSelectiveAnalysisControls=true; // Reserved: Deep Selective Analysis Controls
input int InpReservedAtrRefreshSeconds=60;             // Reserved: ATR Refresh Seconds
input int InpReservedDeepH1Bars=500;                   // Reserved: Deep H1 Bars
input int InpReservedDeepH4Bars=300;                   // Reserved: Deep H4 Bars
input int InpReservedDeepD1Bars=300;                   // Reserved: Deep D1 Bars

input group "Combined Opportunity Summary (Reserved)"
input bool InpReserveCombinedSummaryControls=true;     // Reserved: Combined Opportunity Summary Controls

input group "Future Signal Surface (Reserved)"
input bool InpReserveFutureSignalSurfaceControls=true; // Reserved: Future Signal Surface Controls

ASC_ServerPaths g_paths;
ASC_RuntimeSettings g_settings;
ASC_RuntimeState g_runtime;
ASC_Logger g_logger;
ASC_SymbolState g_symbols[];
ASC_ExplorerContext g_explorer;
ASC_PreparedBucketState g_prepared_buckets;
ASC_PreparedBucketState g_prepared_working_buckets;
ASC_PreparedBucketState g_prepared_last_good_buckets;
int g_prepared_next_batch_id=ASC_PREPARED_BATCH_PRIORITY_SET;
int g_symbol_count=0;
bool g_heartbeat_running=false;
bool g_shortlist_dirty=true;
bool g_last_degraded_state=false;
int g_backlog_attention_threshold=10;
int g_last_logged_warmup_progress=-1;
string g_last_logged_bounded_work_summary="";
string g_last_logged_hydration_priority_set="";
int g_last_logged_prepared_batch_id=-1;
bool g_last_logged_warmup_minimum_met=false;
bool g_last_logged_primary_buckets_ready=false;
bool g_last_logged_background_hydration_active=false;

int g_runtime_filter_eligible_count=0;
int g_runtime_filter_ineligible_count=0;
int g_runtime_filter_pending_count=0;
int g_runtime_open_symbol_count=0;
int g_runtime_shortlist_selected_count=0;
int g_runtime_shortlist_pending_count=0;
int g_runtime_shortlist_filter_blocked_count=0;
int g_runtime_shortlist_global_cap_blocked_count=0;
int g_runtime_shortlist_bucket_cap_blocked_count=0;
int g_persistence_cursor=0;
int g_layer2_cursor=0;
datetime g_shortlist_rebuild_not_before=0;
int g_last_shortlist_rebuild_eligible_count=0;
int g_last_shortlist_rebuild_pending_count=0;

ASC_LogVerbosity ASC_InputVerbosity(const int value)
  {
   if(value<=0)
      return(ASC_LOG_ERRORS_ONLY);
   if(value>=2)
      return(ASC_LOG_DEBUG);
   return(ASC_LOG_NORMAL);
  }

void ASC_LoadSettingsFromInputs(void)
  {
   g_settings.explorer_enabled=InpExplorerEnabled;
   g_settings.explorer_refresh_seconds=(InpExplorerRefreshSeconds>0 ? InpExplorerRefreshSeconds : 1);
   g_settings.explorer_scroll_step_rows=(InpExplorerScrollStepRows>0 ? InpExplorerScrollStepRows : 1);
   g_settings.explorer_density_mode=(InpExplorerDensityMode<0 ? 0 : (InpExplorerDensityMode>2 ? 2 : InpExplorerDensityMode));
   g_settings.explorer_show_breadcrumbs=InpExplorerShowBreadcrumbs;
   g_settings.heartbeat_seconds=(InpHeartbeatSeconds>0 ? InpHeartbeatSeconds : 1);
   g_settings.universe_sync_seconds=(InpUniverseSyncSeconds>0 ? InpUniverseSyncSeconds : 300);
   g_settings.symbol_budget_per_heartbeat=(InpSymbolBudgetPerHeartbeat>0 ? InpSymbolBudgetPerHeartbeat : 1);
   g_settings.runtime_save_seconds=(InpRuntimeSaveSeconds>0 ? InpRuntimeSaveSeconds : 30);
   g_settings.scheduler_save_seconds=(InpSchedulerSaveSeconds>0 ? InpSchedulerSaveSeconds : 15);
   g_settings.summary_save_seconds=(InpSummarySaveSeconds>0 ? InpSummarySaveSeconds : 60);
   g_settings.warmup_minimum_universe_percent=ASC_PercentClamp((InpWarmupMinimumAssessedSharePercent>0 ? InpWarmupMinimumAssessedSharePercent : InpWarmupMinimumUniversePercent));
   g_settings.fresh_tick_seconds=(InpFreshTickSeconds>0 ? InpFreshTickSeconds : 90);
   g_settings.open_recheck_seconds=(InpOpenRecheckSeconds>0 ? InpOpenRecheckSeconds : 10);
   g_settings.uncertain_burst_limit=(InpUncertainBurstLimit>=0 ? InpUncertainBurstLimit : 0);
   g_settings.uncertain_fast_recheck_seconds=(InpUncertainFastRecheckSeconds>0 ? InpUncertainFastRecheckSeconds : 5);
   g_settings.uncertain_slow_recheck_seconds=(InpUncertainSlowRecheckSeconds>0 ? InpUncertainSlowRecheckSeconds : 30);
   g_settings.closed_near_open_seconds=(InpClosedNearOpenWindowSeconds>0 ? InpClosedNearOpenWindowSeconds : 60);
   g_settings.closed_near_open_recheck_seconds=(InpClosedNearOpenRecheckSeconds>0 ? InpClosedNearOpenRecheckSeconds : 5);
   g_settings.closed_soon_window_seconds=(InpClosedSoonWindowSeconds>0 ? InpClosedSoonWindowSeconds : 900);
   g_settings.closed_soon_recheck_seconds=(InpClosedSoonRecheckSeconds>0 ? InpClosedSoonRecheckSeconds : 60);
   g_settings.closed_idle_recheck_seconds=(InpClosedIdleRecheckSeconds>0 ? InpClosedIdleRecheckSeconds : 300);
   g_settings.unknown_recheck_seconds=(InpUnknownRecheckSeconds>0 ? InpUnknownRecheckSeconds : 120);
   g_settings.write_dossiers_when_due=InpWriteDossiersWhenDue;
   g_settings.repair_missing_dossiers_on_boot=InpRepairMissingDossiersOnBoot;
   g_settings.include_reserved_capability_placeholders=InpIncludeReservedCapabilityPlaceholders;
   g_settings.log_verbosity=ASC_InputVerbosity(InpLogVerbosity);
   g_settings.log_scheduler_decisions=InpLogSchedulerDecisions;
   g_settings.log_recovery_events=InpLogRecoveryEvents;
   g_settings.log_dossier_repairs=InpLogDossierRepairs;
   g_settings.open_symbol_snapshot_reserved=InpReserveOpenSymbolSnapshotControls;
   g_settings.candidate_filtering_reserved=InpReserveCandidateFilteringControls;
   g_settings.shortlist_selection_reserved=InpReserveShortlistSelectionControls;
   g_settings.deep_selective_analysis_reserved=InpReserveDeepSelectiveAnalysisControls;
   g_settings.reserved_atr_refresh_seconds=(InpReservedAtrRefreshSeconds>0 ? InpReservedAtrRefreshSeconds : 1);
   g_settings.snapshot_controls_reserved=InpReserveOpenSymbolSnapshotControls;
   g_settings.timeframe_history_reserved=true;
   g_settings.deep_analysis_controls_reserved=InpReserveDeepSelectiveAnalysisControls;
   g_settings.selection_controls_reserved=InpReserveShortlistSelectionControls;
   g_settings.reserved_m1_bars=(InpReservedSnapshotM1Bars>0 ? InpReservedSnapshotM1Bars : 1);
   g_settings.reserved_m5_bars=(InpReservedSnapshotM5Bars>0 ? InpReservedSnapshotM5Bars : 1);
   g_settings.reserved_m15_bars=(InpReservedSnapshotM15Bars>0 ? InpReservedSnapshotM15Bars : 1);
   g_settings.reserved_h1_bars=(InpReservedDeepH1Bars>0 ? InpReservedDeepH1Bars : 1);
   g_settings.reserved_h4_bars=(InpReservedDeepH4Bars>0 ? InpReservedDeepH4Bars : 1);
   g_settings.reserved_d1_bars=(InpReservedDeepD1Bars>0 ? InpReservedDeepD1Bars : 1);
   g_settings.reserved_selected_symbol_limit=(InpReservedSelectedSymbolLimit>0 ? InpReservedSelectedSymbolLimit : 1);
   g_settings.reserved_selected_bucket_limit=(InpReservedSelectedBucketLimit>0 ? InpReservedSelectedBucketLimit : 1);
   g_backlog_attention_threshold=(InpBacklogAttentionThreshold>0 ? InpBacklogAttentionThreshold : 1);
  }

void ASC_LogSettingsSummary(void)
  {
   g_logger.Info("Settings",ASC_WrapperHeaderText());
   g_logger.Info("Settings","heartbeat=" + IntegerToString(g_settings.heartbeat_seconds) + "s, budget=" + IntegerToString(g_settings.symbol_budget_per_heartbeat) + ", open recheck=" + IntegerToString(g_settings.open_recheck_seconds) + "s, runtime save=" + IntegerToString(g_settings.runtime_save_seconds) + "s, warmup min=" + IntegerToString(g_settings.warmup_minimum_universe_percent) + "%, explorer=" + ASC_BoolText(g_settings.explorer_enabled) + " (" + ASC_ExplorerDensityText(g_settings.explorer_density_mode) + ")");
   g_logger.Debug("Settings","surfaces: identity=" + ASC_BoolText(InpReserveIdentityAndBucketingControls) + ", snapshot=" + ASC_BoolText(g_settings.open_symbol_snapshot_reserved) + " with live open-only cadence, filter=" + ASC_BoolText(g_settings.candidate_filtering_reserved) + ", shortlist=" + ASC_BoolText(g_settings.shortlist_selection_reserved) + ", deep=" + ASC_BoolText(g_settings.deep_selective_analysis_reserved) + " with timeframe placeholders, combined=" + ASC_BoolText(InpReserveCombinedSummaryControls) + ", signal=" + ASC_BoolText(InpReserveFutureSignalSurfaceControls));
  }


int ASC_HydrationNextBatchId(const ASC_PreparedBucketState &prepared)
  {
   if(ArraySize(prepared.batch_ready)<ASC_PREPARED_BATCH_COUNT)
      return(ASC_PREPARED_BATCH_PRIORITY_SET);
   for(int i=0;i<ASC_PREPARED_BATCH_COUNT;i++)
     {
      if(prepared.batch_ready[i]==0)
         return(i+1);
     }
   return(0);
  }

string ASC_HydrationPrioritySetText(const int batch_id)
  {
   if(batch_id==ASC_PREPARED_BATCH_PRIORITY_SET)
      return("Priority 1: FX, Indices, Metals, Energy, Crypto");
   if(batch_id==ASC_PREPARED_BATCH_STOCK_MAIN)
      return("Priority 2: Stocks and regional stock groups");
   if(batch_id==ASC_PREPARED_BATCH_STOCK_METADATA)
      return("Priority 3: finer stock detail metadata");
   return("Hydration complete");
  }

bool ASC_HydrationShouldAdvance(const ASC_PreparedBucketState &prepared,const int next_batch)
  {
   if(g_symbol_count<=0 || next_batch<=0)
      return(false);
   if(next_batch==ASC_PREPARED_BATCH_PRIORITY_SET)
      return(true);
   if(!g_runtime.warmup_minimum_met)
      return(false);
   return(true);
  }

string ASC_DebugBacklogSeverityText(const int due_now,const int budget)
  {
   if(due_now<=0)
      return("clear");
   int safe_budget=(budget>0 ? budget : 1);
   if(due_now>=(safe_budget*ASC_DEBUG_BACKLOG_SEVERE_MULTIPLIER))
      return("severe");
   if(due_now>=(safe_budget*ASC_DEBUG_BACKLOG_ELEVATED_MULTIPLIER))
      return("elevated");
   if(due_now>safe_budget)
      return("watch");
   return("within-budget");
  }

void ASC_DebugLogWarmupTransition(void)
  {
   bool minimum_changed=(g_last_logged_warmup_minimum_met!=g_runtime.warmup_minimum_met);
   bool primary_changed=(g_last_logged_primary_buckets_ready!=g_runtime.compressed_primary_buckets_ready);
   bool background_changed=(g_last_logged_background_hydration_active!=g_runtime.background_hydration_active);
   if(!minimum_changed && !primary_changed && !background_changed)
      return;

   int minimum_assessed=ASC_PercentOfCountCeil(g_symbol_count,g_settings.warmup_minimum_universe_percent);
   string reason="minimum_assessed=" + IntegerToString(minimum_assessed)
      + ", assessed=" + IntegerToString(g_runtime.initial_symbols_assessed) + "/" + IntegerToString(g_runtime.total_symbols_discovered)
      + ", grouping_info=" + IntegerToString(g_runtime.primary_bucket_symbols_assessed) + "/" + IntegerToString(g_runtime.primary_bucket_symbol_count)
      + ", grouping_ready=" + ASC_BoolText(g_runtime.compressed_primary_buckets_ready)
      + ", warmup_minimum_met=" + ASC_BoolText(g_runtime.warmup_minimum_met)
      + ", readiness=" + IntegerToString(g_runtime.readiness_percent) + "%";
   g_logger.Debug("Diagnostics","warmup-state transition | mode=" + ASC_RuntimeModeText(g_runtime.mode) + " | " + reason);
   g_last_logged_warmup_minimum_met=g_runtime.warmup_minimum_met;
   g_last_logged_primary_buckets_ready=g_runtime.compressed_primary_buckets_ready;
   g_last_logged_background_hydration_active=g_runtime.background_hydration_active;
  }

void ASC_LogPreparedDiagnosticsSummary(const string reason)
  {
   bool warmup_changed=(g_last_logged_warmup_progress!=g_runtime.warmup_progress_percent);
   bool pressure_changed=ASC_LogMaterialStringChange(g_last_logged_bounded_work_summary,g_prepared_buckets.diagnostics.bounded_work_pressure_summary);
   bool priority_changed=ASC_LogMaterialStringChange(g_last_logged_hydration_priority_set,g_prepared_buckets.diagnostics.active_hydration_priority_set);
   bool batch_changed=(g_last_logged_prepared_batch_id!=g_prepared_buckets.diagnostics.last_prepared_batch_id);
   bool threshold_hit=(g_prepared_buckets.diagnostics.bucket_prep_total_ms>=ASC_DEBUG_PREP_SUMMARY_THRESHOLD_MS
                       || g_prepared_buckets.diagnostics.classification_loop_ms>=15
                       || g_prepared_buckets.diagnostics.bucket_sort_ms>=10
                       || g_prepared_buckets.diagnostics.prepared_symbol_reorder_ms>=10
                       || g_prepared_buckets.diagnostics.final_promotion_ms>=5);
   if(warmup_changed || pressure_changed || priority_changed || batch_changed || threshold_hit)
     {
      string message="reason=" + reason
         + " | prep=" + IntegerToString((int)g_prepared_buckets.diagnostics.bucket_prep_total_ms) + "ms"
         + " | classify=" + IntegerToString((int)g_prepared_buckets.diagnostics.classification_loop_ms) + "ms"
         + " | sort=" + IntegerToString((int)g_prepared_buckets.diagnostics.bucket_sort_ms) + "ms"
         + " | reorder=" + IntegerToString((int)g_prepared_buckets.diagnostics.prepared_symbol_reorder_ms) + "ms"
         + " | promote=" + IntegerToString((int)g_prepared_buckets.diagnostics.final_promotion_ms) + "ms"
         + " | warmup=" + IntegerToString(g_runtime.warmup_progress_percent) + "%"
         + " (" + ASC_LogChangedText(warmup_changed) + ")"
         + " | pressure=" + g_prepared_buckets.diagnostics.bounded_work_pressure_summary
         + " (" + ASC_LogChangedText(pressure_changed) + ")"
         + " | batch=" + IntegerToString(g_prepared_buckets.diagnostics.last_prepared_batch_id)
         + " (" + ASC_LogChangedText(batch_changed) + ")"
         + " | hydration=" + g_prepared_buckets.diagnostics.active_hydration_priority_set
         + " (" + ASC_LogChangedText(priority_changed) + ")"
         + " | dominant=" + (g_prepared_buckets.diagnostics.bucket_prep_total_ms>g_prepared_buckets.diagnostics.hud_render_ms+ASC_DEBUG_DOMINANT_DELTA_MS ? "prep" : (g_prepared_buckets.diagnostics.hud_render_ms>g_prepared_buckets.diagnostics.bucket_prep_total_ms+ASC_DEBUG_DOMINANT_DELTA_MS ? "hud" : "mixed"));
      g_logger.Debug("Diagnostics",message);
     }
   g_last_logged_warmup_progress=g_runtime.warmup_progress_percent;
   g_last_logged_bounded_work_summary=g_prepared_buckets.diagnostics.bounded_work_pressure_summary;
   g_last_logged_hydration_priority_set=g_prepared_buckets.diagnostics.active_hydration_priority_set;
   g_last_logged_prepared_batch_id=g_prepared_buckets.diagnostics.last_prepared_batch_id;
  }

void ASC_LogHeartbeatDiagnosticsSummary(const int initial_due,const int remaining_due)
  {
   bool pressure_changed=ASC_LogMaterialStringChange(g_last_logged_bounded_work_summary,g_runtime.diagnostics.bounded_work_pressure_summary);
   bool warmup_changed=(g_last_logged_warmup_progress!=g_runtime.diagnostics.warmup_progress_percent);
   bool threshold_hit=(g_runtime.diagnostics.last_heartbeat_dispatch_ms>=g_settings.heartbeat_seconds*1000
                       || remaining_due>=g_backlog_attention_threshold);
   if(pressure_changed || warmup_changed || threshold_hit)
     {
      string severity=ASC_DebugBacklogSeverityText(remaining_due,g_settings.symbol_budget_per_heartbeat);
      string message="dispatch=" + IntegerToString((int)g_runtime.diagnostics.last_heartbeat_dispatch_ms) + "ms"
         + " | due=" + IntegerToString(initial_due)
         + " -> " + IntegerToString(remaining_due)
         + " | severity=" + severity
         + " | warmup=" + IntegerToString(g_runtime.diagnostics.warmup_progress_percent) + "%"
         + " (" + ASC_LogChangedText(warmup_changed) + ")"
         + " | pressure=" + g_runtime.diagnostics.bounded_work_pressure_summary
         + " (" + ASC_LogChangedText(pressure_changed) + ")";
      g_logger.Debug("Diagnostics","bounded-work backlog severity bucket | " + message);
     }
   g_last_logged_warmup_progress=g_runtime.diagnostics.warmup_progress_percent;
   g_last_logged_bounded_work_summary=g_runtime.diagnostics.bounded_work_pressure_summary;
  }

void ASC_RunPreparedHydrationController(const string reason)
  {
   int batch_id=ASC_HydrationNextBatchId(g_prepared_buckets);
   if(!ASC_HydrationShouldAdvance(g_prepared_buckets,batch_id))
      return;

   int due_now=ASC_CountDueSymbols(TimeCurrent());
   long prep_started_ms=GetTickCount();
   ASC_PrepareBucketState(g_runtime.server_clean,
                          g_symbols,
                          g_symbol_count,
                          batch_id,
                          g_runtime.initial_symbols_assessed,
                          g_runtime.symbol_count,
                          g_runtime.warmup_progress_percent,
                          due_now,
                          g_settings.symbol_budget_per_heartbeat,
                          g_prepared_buckets,
                          g_prepared_last_good_buckets,
                          g_prepared_working_buckets);
   if(!ASC_PreparedValidateBatchCompleteness(g_prepared_working_buckets,batch_id))
     {
      g_prepared_working_buckets.diagnostics.bucket_prep_total_ms=GetTickCount()-prep_started_ms;
      g_logger.Warn("Hydration","reason=" + reason + ", batch validation failed for " + ASC_PreparedBatchName(batch_id) + "; active prepared truth kept on last-good state");
      ASC_LogPreparedDiagnosticsSummary(reason + ":validation-failed");
      return;
     }

   long promotion_started_ms=GetTickCount();
   int previous_generation=g_prepared_buckets.batch_generation;
   int previous_last_good_batch=g_prepared_buckets.last_good_batch_id;
   bool unchanged_batch=(ASC_PreparedBatchMatches(g_prepared_working_buckets,g_prepared_buckets,batch_id)
                         || ASC_PreparedBatchMatches(g_prepared_working_buckets,g_prepared_last_good_buckets,batch_id));
   ASC_PromotePreparedBucketState(g_prepared_working_buckets,batch_id,g_prepared_last_good_buckets,g_prepared_buckets);
   g_prepared_buckets.diagnostics.final_promotion_ms=GetTickCount()-promotion_started_ms;
   if(unchanged_batch)
      g_logger.Debug("Diagnostics","unchanged batch rewritten | reason=" + reason + " | batch=" + ASC_PreparedBatchName(batch_id) + " | generation=" + IntegerToString(previous_generation) + "->" + IntegerToString(g_prepared_buckets.batch_generation));
   if(previous_last_good_batch!=g_prepared_buckets.last_good_batch_id)
      g_logger.Debug("Diagnostics","batch promotion preserved last-good truth | reason=" + reason + " | promoted=" + ASC_PreparedBatchName(batch_id) + " | last_good_batch=" + IntegerToString(previous_last_good_batch) + "->" + IntegerToString(g_prepared_buckets.last_good_batch_id));
   g_prepared_buckets.diagnostics.bucket_prep_total_ms=GetTickCount()-prep_started_ms;
   ASC_SyncPreparedRuntimeMetadata();
   g_prepared_next_batch_id=ASC_HydrationNextBatchId(g_prepared_buckets);
   g_runtime.summary_dirty=true;
   g_runtime.layer1_dirty=true;
   g_runtime.layer2_dirty=true;
   g_runtime.layer3_dirty=true;
   g_runtime.prepared_live_dirty=true;
   g_runtime.last_dispatcher_lane=ASC_LANE_NONE;
   g_runtime.last_dispatcher_summary="prepared refresh pending";
   g_runtime.last_dispatcher_at=0;
   g_runtime.runtime_dirty=true;
   g_logger.Debug("Hydration","reason=" + reason + ", promoted batch=" + ASC_PreparedBatchName(batch_id) + " | planner=" + ASC_HydrationPrioritySetText(g_prepared_next_batch_id));
   ASC_LogPreparedDiagnosticsSummary(reason);
   ASC_DebugLogWarmupTransition();
  }

void ASC_SyncPreparedRuntimeMetadata(void)
  {
   g_runtime.prepared_last_batch_id=g_prepared_buckets.diagnostics.last_prepared_batch_id;
   g_runtime.prepared_promoted_batch_count=g_prepared_buckets.diagnostics.promoted_batch_count;
   g_runtime.prepared_pending_batch_count=g_prepared_buckets.diagnostics.pending_batch_count;
   g_runtime.prepared_bounded_work_summary=g_prepared_buckets.diagnostics.bounded_work_pressure_summary;
   g_runtime.diagnostics.last_bucket_prep_total_ms=g_prepared_buckets.diagnostics.bucket_prep_total_ms;
   g_runtime.diagnostics.last_classification_loop_ms=g_prepared_buckets.diagnostics.classification_loop_ms;
   g_runtime.diagnostics.last_bucket_sort_ms=g_prepared_buckets.diagnostics.bucket_sort_ms;
   g_runtime.diagnostics.last_prepared_symbol_reorder_ms=g_prepared_buckets.diagnostics.prepared_symbol_reorder_ms;
   g_runtime.diagnostics.last_final_promotion_ms=g_prepared_buckets.diagnostics.final_promotion_ms;
   g_runtime.diagnostics.last_hud_render_ms=g_prepared_buckets.diagnostics.hud_render_ms;
   g_runtime.diagnostics.last_page_switch_action_to_render_ms=g_prepared_buckets.diagnostics.page_switch_action_to_render_ms;
   g_runtime.diagnostics.warmup_progress_percent=g_runtime.warmup_progress_percent;
   g_runtime.diagnostics.bounded_work_pressure_summary=g_prepared_buckets.diagnostics.bounded_work_pressure_summary;
   g_runtime.diagnostics.last_promoted_prepared_batch_id=g_prepared_buckets.diagnostics.last_prepared_batch_id;
   g_runtime.diagnostics.active_hydration_priority_set=g_prepared_buckets.diagnostics.active_hydration_priority_set;
   if(g_runtime.diagnostics.scheduler_priority_summary=="")
      g_runtime.diagnostics.scheduler_priority_summary="due priority lanes -> 1 open-now:0, 2 recent-tick:0, 3 uncertain-near-open:0, 4 first-awareness:0, 5 closed-maintenance:0";
   g_runtime.diagnostics.last_hud_render_at=g_explorer.nav.last_render_at;
  }

void ASC_RefreshPreparedBucketState(void)
  {
   ASC_RunPreparedHydrationController("runtime");
  }

void ASC_RebuildRuntimeFilterAggregates(void)
  {
   g_runtime_filter_eligible_count=0;
   g_runtime_filter_ineligible_count=0;
   g_runtime_filter_pending_count=0;
   g_runtime_open_symbol_count=0;

   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].market_status==ASC_MARKET_OPEN)
         g_runtime_open_symbol_count++;

      if(g_symbols[i].filter_readiness==ASC_FILTER_ELIGIBLE)
         g_runtime_filter_eligible_count++;
      else if(g_symbols[i].filter_readiness==ASC_FILTER_PENDING_LAYER1_OR_2
              || g_symbols[i].filter_readiness==ASC_FILTER_PENDING_CLASSIFICATION
              || g_symbols[i].filter_readiness==ASC_FILTER_PENDING_TICK_CONTINUITY)
         g_runtime_filter_pending_count++;
      else
         g_runtime_filter_ineligible_count++;
     }
  }

void ASC_ResetRuntimeState(void)
  {
   g_runtime.schema_version="ASC Foundation v1";
   g_runtime.server_raw="";
   g_runtime.server_clean="";
   g_runtime.mode=ASC_RUNTIME_BOOT;
   g_runtime.boot_at=0;
   g_runtime.last_heartbeat_at=0;
   g_runtime.last_universe_sync_at=0;
   g_runtime.last_runtime_save_at=0;
   g_runtime.last_scheduler_save_at=0;
   g_runtime.last_summary_save_at=0;
   g_runtime.recovery_used=false;
   g_runtime.degraded=false;
   g_runtime.runtime_dirty=true;
   g_runtime.scheduler_dirty=true;
   g_runtime.summary_dirty=true;
   g_runtime.symbol_count=0;
   g_runtime.processed_this_heartbeat=0;
   g_runtime.scheduler_cursor=0;
   g_runtime.heartbeats_since_boot=0;
   g_runtime.total_symbols_discovered=0;
   g_runtime.initial_symbols_assessed=0;
   g_runtime.primary_bucket_symbols_assessed=0;
   g_runtime.primary_bucket_symbol_count=0;
   g_runtime.compressed_primary_buckets_ready=false;
   g_runtime.warmup_minimum_met=false;
   g_runtime.warmup_progress_percent=0;
   g_runtime.background_hydration_active=false;
   g_runtime.readiness_percent=0;
   g_runtime.prepared_last_batch_id=0;
   g_runtime.prepared_promoted_batch_count=0;
   g_runtime.prepared_pending_batch_count=ASC_PREPARED_BATCH_COUNT;
   g_runtime.prepared_bounded_work_summary="Not sampled.";
   g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD;
   g_runtime.open_symbol_snapshot.last_built_at=0;
   g_runtime.open_symbol_snapshot.pending_reason="Layer 2 waits for an open symbol before it can build a live snapshot.";
   g_runtime.open_symbol_snapshot.has_last_good=false;
   g_runtime.open_symbol_snapshot.last_good_preserved=false;
   g_runtime.open_symbol_snapshot.last_good_built_at=0;
   g_runtime.open_symbol_snapshot.cadence.controls_reserved=g_settings.snapshot_controls_reserved;
   g_runtime.open_symbol_snapshot.cadence.reserved_m1_bars=g_settings.reserved_m1_bars;
   g_runtime.open_symbol_snapshot.cadence.reserved_m5_bars=g_settings.reserved_m5_bars;
   g_runtime.open_symbol_snapshot.cadence.reserved_m15_bars=g_settings.reserved_m15_bars;
   g_runtime.candidate_filter.readiness=ASC_FILTER_PENDING_LAYER1_OR_2;
   g_runtime.candidate_filter.last_evaluated_at=0;
   g_runtime.candidate_filter.pending_reason="Layer 3 waits for Layer 1 market-open truth and Layer 2 snapshot truth before it can evaluate eligibility.";
   g_runtime.candidate_filter.characterization="Pending / No current candidate characterization yet";
   g_runtime.candidate_filter.eligible=false;
   g_runtime.shortlist.readiness=ASC_SHORTLIST_PENDING_LAYER3;
   g_runtime.shortlist_hold_until=0;
   g_runtime.shortlist_last_rebuild_at=0;
   g_runtime.shortlist_hold_window_seconds=600;
   g_runtime.shortlist.last_evaluated_at=0;
   g_runtime.shortlist.pending_reason="Layer 4 waits for Layer 3 eligible symbols before it can admit any shortlist members.";
   g_runtime.shortlist.basis="Pending / No shortlist admission basis yet";
   g_runtime.shortlist.selected_bucket="";
   g_runtime.shortlist.selected=false;
   g_runtime.diagnostics.last_bucket_prep_total_ms=0;
   g_runtime.diagnostics.last_final_promotion_ms=0;
   g_runtime.diagnostics.last_heartbeat_dispatch_ms=0;
   g_runtime.diagnostics.last_hud_render_ms=0;
   g_runtime.diagnostics.last_page_switch_action_to_render_ms=0;
   g_runtime.diagnostics.warmup_progress_percent=0;
   g_runtime.diagnostics.bounded_work_pressure_summary="Not sampled.";
   g_runtime.diagnostics.last_promoted_prepared_batch_id=0;
   g_runtime.diagnostics.active_hydration_priority_set="next=" + ASC_PreparedBatchName(ASC_PREPARED_BATCH_PRIORITY_SET);
   g_runtime.diagnostics.scheduler_priority_summary="due priority lanes -> 1 open-now:0, 2 recent-tick:0, 3 uncertain-near-open:0, 4 first-awareness:0, 5 closed-maintenance:0";
   g_runtime.diagnostics.last_hud_render_at=0;
   ASC_PreparedBucketStateReset(g_prepared_buckets);
   ASC_PreparedBucketStateReset(g_prepared_working_buckets);
   ASC_PreparedBucketStateReset(g_prepared_last_good_buckets);
   g_prepared_next_batch_id=ASC_PREPARED_BATCH_PRIORITY_SET;
   g_last_degraded_state=false;
  }

void ASC_ResetSymbolState(ASC_SymbolState &state,const string symbol)
  {
   state.is_due_now=true;
   state.publication_ok=false;
   state.next_check_reason="Initial assessment pending";
   state.symbol=symbol;
   state.dossier_file=ASC_DossierFileName(symbol);
   state.has_tick=false;
   state.has_trade_sessions=false;
   state.within_trade_session=false;
   state.market_status=ASC_MARKET_UNKNOWN;
   state.last_tick_seen_at=0;
   state.tick_age_seconds=-1;
   state.next_check_at=TimeCurrent();
   state.next_session_open_at=0;
   state.last_checked_at=0;
   state.last_dossier_write_at=0;
   state.uncertain_burst_count=0;
   state.snapshot_readiness=ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD;
   state.snapshot_last_built_at=0;
   state.snapshot_pending_reason="Layer 2 has not built a live snapshot for this symbol yet.";
   state.snapshot_bid=0.0;
   state.snapshot_ask=0.0;
   state.snapshot_spread=0.0;
   state.snapshot_day_high=0.0;
   state.snapshot_day_low=0.0;
   state.snapshot_point=0.0;
   state.snapshot_digits=0;
   state.snapshot_contract_size=0.0;
   state.snapshot_volume_min=0.0;
   state.snapshot_volume_step=0.0;
   state.snapshot_volume_max=0.0;
   state.snapshot_trade_mode=0;
   state.snapshot_stops_level=0;
   state.snapshot_freeze_level=0;
   state.snapshot_spread_floating=false;
   state.snapshot_tick_size=0.0;
   state.snapshot_tick_value=0.0;
   state.snapshot_margin_currency="";
   state.snapshot_profit_currency="";
   state.snapshot_chart_mode=0;
   state.snapshot_trade_execution=0;
   state.snapshot_order_mode=0;
   state.snapshot_filling_mode=0;
   state.snapshot_gtc_mode=0;
   state.snapshot_expiration_mode=0;
   state.snapshot_swap_type=0;
   state.snapshot_swap_long=0.0;
   state.snapshot_swap_short=0.0;
   state.snapshot_spread_price=0.0;
   state.snapshot_spread_percent=0.0;
   state.snapshot_atr_m1=0.0;
   state.snapshot_atr_m1_reliable=false;
   state.snapshot_atr_m1_active_tr_count=0;
   state.snapshot_spread_to_atr_percent=0.0;
   state.snapshot_has_last_good=false;
   state.snapshot_last_good_preserved=false;
   state.snapshot_last_good_built_at=0;
   state.filter_readiness=ASC_FILTER_PENDING_LAYER1_OR_2;
   state.filter_last_evaluated_at=0;
   state.filter_pending_reason="Layer 3 waits for Layer 1 market-open truth and Layer 2 snapshot truth for this symbol.";
   state.filter_characterization="Pending / No current candidate characterization yet";
   state.filter_eligible=false;
   state.shortlist_readiness=ASC_SHORTLIST_PENDING_LAYER3;
   state.shortlist_last_evaluated_at=0;
   state.shortlist_pending_reason="Layer 4 waits for Layer 3 eligibility before it can admit this symbol.";
   state.shortlist_basis="Pending / No shortlist admission basis yet";
   state.shortlist_bucket="";
   state.shortlist_selected=false;
   state.shortlist_rank=0;
   state.shortlist_display_bucket="";
   state.shortlist_spill_fill=false;
   state.layer5_last_update_at=0;
   state.status_note="Pending initial assessment";
   state.dirty=true;
  }

void ASC_ApplyRestoredRuntimeDefaults(void)
  {
   if(g_runtime.schema_version=="")
      g_runtime.schema_version="ASC Foundation v1";
   g_runtime.server_raw=g_paths.server_raw;
   g_runtime.server_clean=g_paths.server_clean;
   if(g_runtime.open_symbol_snapshot.pending_reason=="")
      g_runtime.open_symbol_snapshot.pending_reason="Layer 2 waits for an open symbol before it can build a live snapshot.";
   g_runtime.open_symbol_snapshot.cadence.controls_reserved=g_settings.snapshot_controls_reserved;
   g_runtime.open_symbol_snapshot.cadence.reserved_m1_bars=g_settings.reserved_m1_bars;
   g_runtime.open_symbol_snapshot.cadence.reserved_m5_bars=g_settings.reserved_m5_bars;
   g_runtime.open_symbol_snapshot.cadence.reserved_m15_bars=g_settings.reserved_m15_bars;
   if(g_runtime.candidate_filter.pending_reason=="")
      g_runtime.candidate_filter.pending_reason="Layer 3 waits for Layer 1 market-open truth and Layer 2 snapshot truth before it can evaluate eligibility.";
   if(g_runtime.candidate_filter.characterization=="")
      g_runtime.candidate_filter.characterization="Pending / No current candidate characterization yet";
   if(g_runtime.shortlist.pending_reason=="")
      g_runtime.shortlist.pending_reason="Layer 4 waits for Layer 3 eligible symbols before it can admit any shortlist members.";
   if(g_runtime.shortlist.basis=="")
      g_runtime.shortlist.basis="Pending / No shortlist admission basis yet";
   if(g_runtime.shortlist_hold_window_seconds<=0)
      g_runtime.shortlist_hold_window_seconds=600;
   if(g_runtime.last_dispatcher_summary=="")
      g_runtime.last_dispatcher_summary="recovered";
   g_runtime.runtime_dirty=true;
   g_runtime.scheduler_dirty=true;
   g_runtime.summary_dirty=true;
  }

bool ASC_IsDossierPresent(const ASC_SymbolState &state)
  {
   string dossier_path=ASC_JoinPath(g_paths.universe_folder,state.dossier_file);
   return(FileIsExist(dossier_path,FILE_COMMON));
  }

void ASC_SyncUniverse(void)
  {
   int total=SymbolsTotal(false);
   int missing_repairs=0;
   ArrayResize(g_symbols,total);
   g_symbol_count=total;

   for(int i=0;i<total;i++)
     {
      string symbol=SymbolName(i,false);
      if(g_symbols[i].symbol!=symbol)
         ASC_ResetSymbolState(g_symbols[i],symbol);
      else
        {
         g_symbols[i].symbol=symbol;
         g_symbols[i].dossier_file=ASC_DossierFileName(symbol);
         if(g_symbols[i].next_check_at<=0)
            g_symbols[i].next_check_at=TimeCurrent();
        }

      g_symbols[i].publication_ok=ASC_IsDossierPresent(g_symbols[i]);
      if(g_settings.repair_missing_dossiers_on_boot && !g_symbols[i].publication_ok)
        {
         g_symbols[i].dirty=true;
         missing_repairs++;
         if(g_settings.log_dossier_repairs && g_settings.log_verbosity>=ASC_LOG_DEBUG)
            g_logger.Debug("DossierRepair","queued missing dossier repair for " + symbol);
        }
     }

   if(g_runtime.scheduler_cursor>=g_symbol_count)
      g_runtime.scheduler_cursor=0;
   if(g_layer2_cursor>=g_symbol_count)
      g_layer2_cursor=0;
   g_runtime.symbol_count=total;
   g_runtime.last_universe_sync_at=TimeCurrent();
   g_runtime.runtime_dirty=true;
   g_runtime.scheduler_dirty=true;
   g_runtime.summary_dirty=true;
   g_logger.Info("Universe","synced " + IntegerToString(total) + " symbols | layout=" + g_paths.layout_label + " | universe-folder=" + g_paths.universe_folder);
   if(g_settings.repair_missing_dossiers_on_boot && missing_repairs>0)
      g_logger.Info("DossierRepair","queued " + IntegerToString(missing_repairs) + " missing dossier repairs");
   ASC_WritePersistenceAudit(TimeCurrent(),"universe-sync",0,0,0,"missing_repairs=" + IntegerToString(missing_repairs));
  }

void ASC_RestoreContinuity(void)
  {
   bool runtime_restored=ASC_LoadRuntimeState(g_paths,g_runtime,g_logger);
   ASC_ApplyRestoredRuntimeDefaults();
   g_runtime.recovery_used=runtime_restored || FileIsExist(g_paths.scheduler_state_file,FILE_COMMON) || FileIsExist(g_paths.scheduler_state_file + ".last-good",FILE_COMMON);
   ASC_SyncUniverse();
   if(ASC_LoadSchedulerState(g_paths,g_symbols,g_symbol_count,g_logger))
      g_runtime.scheduler_dirty=true;
   if(g_settings.log_recovery_events)
      g_logger.Info("Recovery",(g_runtime.recovery_used ? "continuity available" : "no prior continuity found"));
  }

bool ASC_ShouldSaveRuntime(const datetime now)
  {
   return(g_runtime.runtime_dirty || g_runtime.last_runtime_save_at<=0 || (now-g_runtime.last_runtime_save_at)>=g_settings.runtime_save_seconds);
  }

bool ASC_ShouldSaveScheduler(const datetime now)
  {
   return(g_runtime.scheduler_dirty || g_runtime.last_scheduler_save_at<=0 || (now-g_runtime.last_scheduler_save_at)>=g_settings.scheduler_save_seconds);
  }

bool ASC_ShouldSaveSummary(const datetime now)
  {
   return(g_runtime.summary_dirty || g_runtime.last_summary_save_at<=0 || (now-g_runtime.last_summary_save_at)>=g_settings.summary_save_seconds);
  }

bool ASC_HasPendingDossierWrite(const datetime now)
  {
   if(!g_settings.write_dossiers_when_due || g_symbol_count<=0)
      return(false);

   int start=(g_persistence_cursor % g_symbol_count);
   for(int offset=0; offset<g_symbol_count; offset++)
     {
      int index=(start + offset) % g_symbol_count;
      if(ASC_ShouldWriteSymbolDossier(g_symbols[index],now))
         return(true);
     }
   return(false);
  }

bool ASC_HasPersistenceWorkDue(const datetime now)
  {
   if(ASC_ShouldSaveRuntime(now) || ASC_ShouldSaveScheduler(now) || ASC_ShouldSaveSummary(now))
      return(true);
   if(ASC_HasPendingDossierWrite(now))
      return(true);
   return(false);
  }

int ASC_CountPendingDossierWrites(const datetime now)
  {
   if(!g_settings.write_dossiers_when_due || g_symbol_count<=0)
      return(0);

   int pending=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(ASC_ShouldWriteSymbolDossier(g_symbols[i],now))
         pending++;
     }
   return(pending);
  }

int ASC_CountPublishedDossiers(void)
  {
   int published=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].publication_ok)
         published++;
     }
   return(published);
  }

void ASC_WritePersistenceAudit(const datetime now,const string reason,const int attempted,const int succeeded,const int failed,const string detail)
  {
   string body="ASC Persistence Audit\r\n\r\n";
   body+="Generated At: " + ASC_DateTimeText(now) + "\r\n";
   body+="Reason: " + reason + "\r\n";
   body+="Wrapper Version: " + ASC_WRAPPER_VERSION + "\r\n";
   body+="Explorer Version: " + ASC_EXPLORER_SUBSYSTEM_VERSION + "\r\n";
   body+="Server Clean: " + g_paths.server_clean + "\r\n";
   body+="Layout Mode: " + g_paths.layout_label + "\r\n";
   body+="Server Folder: " + g_paths.server_folder + "\r\n";
   body+="Universe Folder: " + g_paths.universe_folder + "\r\n";
   body+="Dev Folder: " + g_paths.dev_folder + "\r\n\r\n";
   body+="Write Dossiers When Due: " + ASC_BoolText(g_settings.write_dossiers_when_due) + "\r\n";
   body+="Pending Dossier Writes: " + IntegerToString(ASC_CountPendingDossierWrites(now)) + "\r\n";
   body+="Published Dossiers: " + IntegerToString(ASC_CountPublishedDossiers()) + " / " + IntegerToString(g_symbol_count) + "\r\n";
   body+="Persistence Cursor: " + IntegerToString(g_persistence_cursor) + "\r\n";
   body+="Attempted This Pass: " + IntegerToString(attempted) + "\r\n";
   body+="Succeeded This Pass: " + IntegerToString(succeeded) + "\r\n";
   body+="Failed This Pass: " + IntegerToString(failed) + "\r\n\r\n";
   body+="Runtime Dirty: " + ASC_BoolText(g_runtime.runtime_dirty) + "\r\n";
   body+="Scheduler Dirty: " + ASC_BoolText(g_runtime.scheduler_dirty) + "\r\n";
   body+="Summary Dirty: " + ASC_BoolText(g_runtime.summary_dirty) + "\r\n";
   body+="Last Runtime Save: " + ASC_DateTimeText(g_runtime.last_runtime_save_at) + "\r\n";
   body+="Last Scheduler Save: " + ASC_DateTimeText(g_runtime.last_scheduler_save_at) + "\r\n";
   body+="Last Summary Save: " + ASC_DateTimeText(g_runtime.last_summary_save_at) + "\r\n";
   body+="Last Dispatcher Summary: " + g_runtime.last_dispatcher_summary + "\r\n";
   body+="Last Dispatcher At: " + ASC_DateTimeText(g_runtime.last_dispatcher_at) + "\r\n\r\n";
   body+="Detail: " + detail + "\r\n";
   ASC_AtomicWrite(g_paths.persistence_audit_file,body,g_logger);
  }

int ASC_CountDueSymbols(const datetime now)
  {
   int due_count=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      g_symbols[i].is_due_now=(g_symbols[i].next_check_at<=now || g_symbols[i].last_checked_at<=0);
      if(g_symbols[i].is_due_now)
         due_count++;
     }
   return(due_count);
  }

int ASC_SchedulerPriorityForSymbol(const ASC_SymbolState &state,const datetime now)
  {
   if(!state.is_due_now)
      return(99);
   if(state.market_status==ASC_MARKET_OPEN)
      return(1);
   bool recent_tick=(state.last_tick_seen_at>0 && state.tick_age_seconds>=0 && state.tick_age_seconds<=(g_settings.fresh_tick_seconds*2));
   if(recent_tick)
      return(2);
   bool near_open=(state.market_status==ASC_MARKET_UNCERTAIN);
   if(!near_open && state.next_session_open_at>0)
     {
      long seconds_to_open=(long)(state.next_session_open_at-now);
      if(seconds_to_open<=g_settings.closed_near_open_seconds || seconds_to_open<=g_settings.closed_soon_window_seconds)
         near_open=true;
     }
   if(near_open)
      return(3);
   if(state.last_checked_at<=0)
      return(4);
   return(5);
  }

string ASC_SchedulerPriorityLabel(const int priority)
  {
   switch(priority)
     {
      case 1: return("1 open-now");
      case 2: return("2 recent-tick");
      case 3: return("3 uncertain-near-open");
      case 4: return("4 first-awareness");
      default: return("5 closed-maintenance");
     }
  }

bool ASC_ProcessDuePriorityBucket(const int priority,const datetime now,int &touched,int &promoted,int &failed)
  {
   if(g_symbol_count<=0)
      return(false);
   int start=(g_runtime.scheduler_cursor % g_symbol_count);
   bool progressed=false;
   for(int offset=0; offset<g_symbol_count && touched<g_settings.symbol_budget_per_heartbeat; offset++)
     {
      int index=(start + offset) % g_symbol_count;
      if(!g_symbols[index].is_due_now)
         continue;
      int symbol_priority=ASC_SchedulerPriorityForSymbol(g_symbols[index],now);
      if(symbol_priority!=priority)
         continue;
      touched++;
      bool success=ASC_ProcessLayer1Symbol(index);
      g_runtime.scheduler_cursor=(g_symbol_count>0 ? ((index+1)%g_symbol_count) : 0);
      g_runtime.scheduler_dirty=true;
      g_runtime.summary_dirty=true;
      progressed=true;
      if(success)
         promoted++;
      else
         failed++;
     }
   return(progressed);
  }

string ASC_BuildSchedulerPrioritySummary(const datetime now)
  {
   int counts[5];
   ArrayInitialize(counts,0);
   for(int i=0;i<g_symbol_count;i++)
     {
      if(!g_symbols[i].is_due_now)
         continue;
      int priority=ASC_SchedulerPriorityForSymbol(g_symbols[i],now);
      if(priority<1 || priority>5)
         continue;
      counts[priority-1]++;
     }
   return("due priority lanes -> "
          + ASC_SchedulerPriorityLabel(1) + ":" + IntegerToString(counts[0])
          + ", " + ASC_SchedulerPriorityLabel(2) + ":" + IntegerToString(counts[1])
          + ", " + ASC_SchedulerPriorityLabel(3) + ":" + IntegerToString(counts[2])
          + ", " + ASC_SchedulerPriorityLabel(4) + ":" + IntegerToString(counts[3])
          + ", " + ASC_SchedulerPriorityLabel(5) + ":" + IntegerToString(counts[4]));
  }

bool ASC_IsPrioritySet1Bucket(const string primary_bucket)
  {
   string bucket=ASC_ToUpper(ASC_Trim(primary_bucket));
   return(bucket=="FX_MAJOR"
          || bucket=="INDEX_US"
          || bucket=="INDEX_EUROPE"
          || bucket=="METALS_PRECIOUS"
          || bucket=="ENERGY"
          || bucket=="CRYPTO_LARGE_CAP");
  }

void ASC_UpdateLayer1Readiness(void)
  {
   int assessed=0;
   int primary_assessed=0;
   int primary_total=0;

   for(int i=0;i<g_symbol_count;i++)
     {
      bool initial_assessed=(g_symbols[i].last_checked_at>0);
      if(initial_assessed)
         assessed++;

      // Informational only: primary-bucket counts remain useful for surfaces,
      // but Layer 1 warmup/boot may not depend on any later-layer grouping model.
      ASC_SymbolClassification classification;
      if(!ASC_CL_ClassifySymbol(g_runtime.server_clean,g_symbols[i].symbol,classification))
         continue;
      if(!ASC_IsPrioritySet1Bucket(classification.primary_bucket))
         continue;

      primary_total++;
      if(initial_assessed)
         primary_assessed++;
     }

   bool primary_buckets_ready=(primary_total<=0 || primary_assessed>=primary_total);
   g_runtime.total_symbols_discovered=g_symbol_count;
   g_runtime.initial_symbols_assessed=assessed;
   g_runtime.primary_bucket_symbols_assessed=primary_assessed;
   g_runtime.primary_bucket_symbol_count=primary_total;
   g_runtime.compressed_primary_buckets_ready=primary_buckets_ready;

   int minimum_assessed=ASC_PercentOfCountCeil(g_symbol_count,g_settings.warmup_minimum_universe_percent);
   bool assessed_share_minimum_met=(g_symbol_count<=0 || assessed>=minimum_assessed);
   g_runtime.warmup_minimum_met=assessed_share_minimum_met;

   int assessed_share_progress=(g_symbol_count>0 ? (assessed*100)/g_symbol_count : 100);
   int assessed_threshold_progress=(minimum_assessed>0 ? (assessed*100)/minimum_assessed : 100);
   if(assessed_threshold_progress>100)
      assessed_threshold_progress=100;

   int progress=(g_runtime.warmup_minimum_met ? assessed_share_progress : assessed_threshold_progress);
   g_runtime.readiness_percent=ASC_PercentClamp(progress);
   g_runtime.warmup_progress_percent=g_runtime.readiness_percent;
   g_runtime.background_hydration_active=false;
   g_runtime.diagnostics.warmup_progress_percent=g_runtime.warmup_progress_percent;
  }

void ASC_UpdateRuntimeMode(void)
  {
   if(g_runtime.degraded)
     {
      g_runtime.mode=ASC_RUNTIME_DEGRADED;
      return;
     }

   bool layer1_ready=g_runtime.warmup_minimum_met;
   if(!layer1_ready)
      g_runtime.mode=ASC_RUNTIME_WARMUP;
   else
      g_runtime.mode=ASC_RUNTIME_STEADY;
   ASC_DebugLogWarmupTransition();
  }

void ASC_LogSchedulerDecision(const ASC_SymbolState &state)
  {
   if(!g_settings.log_scheduler_decisions)
      return;
   g_logger.Debug("Scheduler","symbol=" + state.symbol + ", status=" + ASC_MarketStatusText(state.market_status) + ", next due=" + ASC_DateTimeText(state.next_check_at) + ", reason=" + state.next_check_reason);
  }

bool ASC_CalculateLightAtrM1(const string symbol,const double point,const double tick_size,double &atr_value,bool &atr_reliable,int &active_tr_count)
  {
   atr_value=0.0;
   atr_reliable=false;
   active_tr_count=0;

   MqlRates rates[];
   // Use CLOSED bars only. Shift=1 skips the currently forming M1 bar.
   int copied=CopyRates(symbol,PERIOD_M1,1,16,rates);
   if(copied<15)
      return(false);

   double noise_floor=point;
   if(tick_size>noise_floor)
      noise_floor=tick_size;
   if(noise_floor<=0.0)
      noise_floor=0.00000001;

   int start=copied-15;
   double tr_sum=0.0;
   int tr_count=0;

   for(int i=start+1;i<copied;i++)
     {
      double high=rates[i].high;
      double low=rates[i].low;
      double prev_close=rates[i-1].close;
      double tr1=(high-low);
      double tr2=MathAbs(high-prev_close);
      double tr3=MathAbs(low-prev_close);
      double true_range=MathMax(tr1,MathMax(tr2,tr3));

      if(true_range>(noise_floor*2.0))
         active_tr_count++;

      tr_sum+=true_range;
      tr_count++;
     }

   if(tr_count<=0)
      return(false);

   atr_value=(tr_sum/(double)tr_count);
   if(atr_value<=0.0)
      return(false);

   // ATR is only considered reliable if it is materially above noise
   // and the recent bar set is not mostly flat.
   atr_reliable=(atr_value>(noise_floor*4.0) && active_tr_count>=6);
   return(true);
  }
  
bool ASC_BuildOpenSymbolSnapshot(ASC_SymbolState &state,string &failure_reason)
  {
   failure_reason="";

   double bid=0.0;
   double ask=0.0;
   double point=0.0;
   double day_high=0.0;
   double day_low=0.0;
   double contract_size=0.0;
   double volume_min=0.0;
   double volume_step=0.0;
   double volume_max=0.0;
   long digits=0;
   long spread_points=0;
   long trade_mode=0;
   long stops_level=0;
   long freeze_level=0;

   bool ok=(SymbolInfoDouble(state.symbol,SYMBOL_BID,bid)
            && SymbolInfoDouble(state.symbol,SYMBOL_ASK,ask)
            && SymbolInfoDouble(state.symbol,SYMBOL_POINT,point)
            && SymbolInfoDouble(state.symbol,SYMBOL_BIDHIGH,day_high)
            && SymbolInfoDouble(state.symbol,SYMBOL_BIDLOW,day_low)
            && SymbolInfoDouble(state.symbol,SYMBOL_TRADE_CONTRACT_SIZE,contract_size)
            && SymbolInfoDouble(state.symbol,SYMBOL_VOLUME_MIN,volume_min)
            && SymbolInfoDouble(state.symbol,SYMBOL_VOLUME_STEP,volume_step)
            && SymbolInfoDouble(state.symbol,SYMBOL_VOLUME_MAX,volume_max)
            && SymbolInfoInteger(state.symbol,SYMBOL_DIGITS,digits)
            && SymbolInfoInteger(state.symbol,SYMBOL_SPREAD,spread_points)
            && SymbolInfoInteger(state.symbol,SYMBOL_TRADE_MODE,trade_mode)
            && SymbolInfoInteger(state.symbol,SYMBOL_TRADE_STOPS_LEVEL,stops_level)
            && SymbolInfoInteger(state.symbol,SYMBOL_TRADE_FREEZE_LEVEL,freeze_level));

   if(!ok)
     {
      failure_reason="Layer 2 snapshot refresh failed while reading broker symbol properties.";
      return(false);
     }

   long spread_floating_flag=0;
   long chart_mode=0;
   long trade_execution=0;
   long order_mode=0;
   long filling_mode=0;
   long gtc_mode=0;
   long expiration_mode=0;
   long swap_type=0;
   double tick_size=0.0;
   double tick_value=0.0;
   double swap_long=0.0;
   double swap_short=0.0;
   string margin_currency="";
   string profit_currency="";

   SymbolInfoInteger(state.symbol,SYMBOL_SPREAD_FLOAT,spread_floating_flag);
   SymbolInfoDouble(state.symbol,SYMBOL_TRADE_TICK_SIZE,tick_size);
   SymbolInfoDouble(state.symbol,SYMBOL_TRADE_TICK_VALUE,tick_value);
   SymbolInfoString(state.symbol,SYMBOL_CURRENCY_MARGIN,margin_currency);
   SymbolInfoString(state.symbol,SYMBOL_CURRENCY_PROFIT,profit_currency);
   SymbolInfoInteger(state.symbol,SYMBOL_CHART_MODE,chart_mode);
   SymbolInfoInteger(state.symbol,SYMBOL_TRADE_EXEMODE,trade_execution);
   SymbolInfoInteger(state.symbol,SYMBOL_ORDER_MODE,order_mode);
   SymbolInfoInteger(state.symbol,SYMBOL_FILLING_MODE,filling_mode);
   SymbolInfoInteger(state.symbol,SYMBOL_ORDER_GTC_MODE,gtc_mode);
   SymbolInfoInteger(state.symbol,SYMBOL_EXPIRATION_MODE,expiration_mode);
   SymbolInfoInteger(state.symbol,SYMBOL_SWAP_MODE,swap_type);
   SymbolInfoDouble(state.symbol,SYMBOL_SWAP_LONG,swap_long);
   SymbolInfoDouble(state.symbol,SYMBOL_SWAP_SHORT,swap_short);

   double spread_price=(ask-bid);
   if(spread_price<0.0)
      spread_price=0.0;

   double mid_price=((bid+ask)/2.0);
   double spread_percent=(mid_price>0.0 ? ((spread_price/mid_price)*100.0) : 0.0);

   double atr_m1=0.0;
   bool atr_reliable=false;
   int atr_active_tr_count=0;
   bool atr_available=ASC_CalculateLightAtrM1(state.symbol,point,tick_size,atr_m1,atr_reliable,atr_active_tr_count);
   double spread_to_atr_percent=((atr_available && atr_reliable && atr_m1>0.0) ? ((spread_price/atr_m1)*100.0) : 0.0);

   datetime built_at=TimeTradeServer();
   if(built_at<=0)
      built_at=TimeCurrent();

   state.snapshot_bid=bid;
   state.snapshot_ask=ask;
   state.snapshot_spread=(double)spread_points;
   state.snapshot_day_high=day_high;
   state.snapshot_day_low=day_low;
   state.snapshot_point=point;
   state.snapshot_digits=(int)digits;
   state.snapshot_contract_size=contract_size;
   state.snapshot_volume_min=volume_min;
   state.snapshot_volume_step=volume_step;
   state.snapshot_volume_max=volume_max;
   state.snapshot_trade_mode=trade_mode;
   state.snapshot_stops_level=stops_level;
   state.snapshot_freeze_level=freeze_level;
   state.snapshot_spread_floating=(spread_floating_flag!=0);
   state.snapshot_tick_size=tick_size;
   state.snapshot_tick_value=tick_value;
   state.snapshot_margin_currency=margin_currency;
   state.snapshot_profit_currency=profit_currency;
   state.snapshot_chart_mode=chart_mode;
   state.snapshot_trade_execution=trade_execution;
   state.snapshot_order_mode=order_mode;
   state.snapshot_filling_mode=filling_mode;
   state.snapshot_gtc_mode=gtc_mode;
   state.snapshot_expiration_mode=expiration_mode;
   state.snapshot_swap_type=swap_type;
   state.snapshot_swap_long=swap_long;
   state.snapshot_swap_short=swap_short;
   state.snapshot_spread_price=spread_price;
   state.snapshot_spread_percent=spread_percent;
   state.snapshot_atr_m1=(atr_available ? atr_m1 : 0.0);
   state.snapshot_atr_m1_reliable=(atr_available ? atr_reliable : false);
   state.snapshot_atr_m1_active_tr_count=(atr_available ? atr_active_tr_count : 0);
   state.snapshot_spread_to_atr_percent=spread_to_atr_percent;
   state.snapshot_last_built_at=built_at;
   state.snapshot_last_good_built_at=built_at;
   state.snapshot_has_last_good=true;
   state.snapshot_last_good_preserved=false;
   state.snapshot_readiness=ASC_SNAPSHOT_WORKING_FRESH;
   state.snapshot_pending_reason="Layer 2 snapshot is fresh for this open symbol.";

   g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_WORKING_FRESH;
   g_runtime.open_symbol_snapshot.last_built_at=built_at;
   g_runtime.open_symbol_snapshot.pending_reason="Layer 2 built a fresh open-symbol snapshot on bounded cadence.";
   g_runtime.open_symbol_snapshot.has_last_good=true;
   g_runtime.open_symbol_snapshot.last_good_preserved=false;
   g_runtime.open_symbol_snapshot.last_good_built_at=built_at;
   return(true);
  }

bool ASC_IsUsableFiniteNumber(const double value)
  {
   return(MathIsValidNumber(value));
  }

bool ASC_HasLayer3TickContinuity(const ASC_SymbolState &state)
  {
   if(!state.has_tick || state.last_tick_seen_at<=0 || state.tick_age_seconds<0)
      return(false);
   int stale_threshold=(g_settings.fresh_tick_seconds>0 ? g_settings.fresh_tick_seconds*ASC_LAYER3_TICK_STALE_MULTIPLIER : 180);
   return(state.tick_age_seconds<=stale_threshold);
  }

bool ASC_Layer3SnapshotDataSane(const ASC_SymbolState &state,string &reason)
  {
   reason="";
   if(!ASC_IsUsableFiniteNumber(state.snapshot_bid) || state.snapshot_bid<=0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 bid is missing or invalid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_ask) || state.snapshot_ask<=0.0 || state.snapshot_ask<state.snapshot_bid)
     {
      reason="Layer 3 rejected this symbol because Layer 2 ask is missing or inverted against bid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_point) || state.snapshot_point<=0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 point size is missing or invalid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_contract_size) || state.snapshot_contract_size<=0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 contract size is missing or invalid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_spread_price) || state.snapshot_spread_price<0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 spread price is missing or invalid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_spread_percent) || state.snapshot_spread_percent<0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 normalized spread percent is missing or invalid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_atr_m1) || state.snapshot_atr_m1<0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 ATR context is invalid.";
      return(false);
     }
   if(!ASC_IsUsableFiniteNumber(state.snapshot_spread_to_atr_percent) || state.snapshot_spread_to_atr_percent<0.0)
     {
      reason="Layer 3 rejected this symbol because Layer 2 spread-to-ATR context is invalid.";
      return(false);
     }
   return(true);
  }

bool ASC_Layer3SpreadWithinBounds(const ASC_SymbolState &state,string &reason)
  {
   reason="";
   if(state.snapshot_spread_percent>ASC_LAYER3_MAX_SPREAD_PERCENT)
     {
      reason="Layer 3 rejected this symbol because normalized spread percent is too wide at "
         + DoubleToString(state.snapshot_spread_percent,3) + "%.";
      return(false);
     }

   // Only trust spread-to-ATR when the ATR context is reliable enough.
   if(state.snapshot_atr_m1_reliable && state.snapshot_atr_m1>0.0
      && state.snapshot_spread_to_atr_percent>ASC_LAYER3_MAX_SPREAD_TO_ATR_PERCENT)
     {
      reason="Layer 3 rejected this symbol because spread is too large versus reliable ATR at "
         + DoubleToString(state.snapshot_spread_to_atr_percent,1) + "%.";
      return(false);
     }

   return(true);
  }

string ASC_CandidateFilterCharacterization(const ASC_SymbolState &state,const ASC_SymbolClassification &classification)
  {
   string bucket=(classification.primary_bucket=="" ? "UNCLASSIFIED" : classification.primary_bucket);
   string asset=(classification.asset_class=="" ? "Unknown Asset" : classification.asset_class);
   string mode=ASC_SymbolTradeModeText(state.snapshot_trade_mode);
   string spread_pct=(state.snapshot_has_last_good ? DoubleToString(state.snapshot_spread_percent,3) + "%" : "pending spread%");
   string atr_share="ATR weak";
   if(state.snapshot_has_last_good && state.snapshot_atr_m1_reliable && state.snapshot_atr_m1>0.0)
      atr_share=DoubleToString(state.snapshot_spread_to_atr_percent,1) + "% ATR";
   else if(state.snapshot_has_last_good && state.snapshot_atr_m1>0.0)
      atr_share="ATR unreliable";
   string tick_age=(state.tick_age_seconds>=0 ? IntegerToString((int)state.tick_age_seconds) + "s tick" : "tick pending");
   return(bucket + " | " + asset + " | Trade Mode " + mode + " | Spread " + spread_pct + " | " + atr_share + " | " + tick_age);
  }

bool ASC_ShouldEvaluateCandidateFilter(const ASC_SymbolState &state)
  {
   if(state.filter_last_evaluated_at<=0)
      return(true);
   if(state.market_status!=ASC_MARKET_OPEN)
      return(state.filter_readiness!=ASC_FILTER_INELIGIBLE_MARKET_NOT_OPEN);
   if(state.snapshot_last_built_at>state.filter_last_evaluated_at)
      return(true);
   if(state.snapshot_last_good_preserved && state.snapshot_last_good_built_at>=state.filter_last_evaluated_at)
      return(true);
   if(state.filter_readiness==ASC_FILTER_PENDING_CLASSIFICATION || state.filter_readiness==ASC_FILTER_PENDING_LAYER1_OR_2 || state.filter_readiness==ASC_FILTER_PENDING_TICK_CONTINUITY)
      return(true);
   return(false);
  }

void ASC_UpdateCandidateFilterState(ASC_SymbolState &state)
  {
   datetime evaluated_at=TimeTradeServer();
   if(evaluated_at<=0)
      evaluated_at=TimeCurrent();

   state.filter_last_evaluated_at=evaluated_at;
   state.filter_eligible=false;
   state.filter_characterization="Pending / No current candidate characterization yet";
   g_runtime.candidate_filter.last_evaluated_at=evaluated_at;
   g_runtime.candidate_filter.eligible=false;
   g_runtime.candidate_filter.characterization=state.filter_characterization;

   if(state.market_status!=ASC_MARKET_OPEN)
     {
      state.filter_readiness=ASC_FILTER_INELIGIBLE_MARKET_NOT_OPEN;
      state.filter_pending_reason="Layer 3 is ineligible until Layer 1 returns Market State Open.";
      state.filter_characterization="Ineligible / Layer 1 market state is not Open";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason="Layer 3 is waiting for open-market truth from Layer 1 before it can evaluate candidates.";
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   if(!(state.snapshot_readiness==ASC_SNAPSHOT_WORKING_FRESH || state.snapshot_readiness==ASC_SNAPSHOT_WORKING_LAST_GOOD) || !state.snapshot_has_last_good)
     {
      state.filter_readiness=ASC_FILTER_INELIGIBLE_SNAPSHOT_UNAVAILABLE;
      state.filter_pending_reason="Layer 3 requires a current or preserved Layer 2 snapshot before it can mark this symbol eligible.";
      state.filter_characterization="Ineligible / Layer 2 snapshot unavailable";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason="Layer 3 requires Layer 2 snapshot continuity before it can evaluate open-symbol eligibility.";
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   if(!ASC_HasLayer3TickContinuity(state))
     {
      state.filter_readiness=ASC_FILTER_PENDING_TICK_CONTINUITY;
      state.filter_pending_reason="Layer 3 is holding this symbol until Layer 1 tick continuity becomes recent enough for open-market evaluation.";
      state.filter_characterization="Pending / Tick continuity not recent enough";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason="Layer 3 is waiting for fresh tick continuity from Layer 1 before it trusts the open-symbol packet.";
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   string data_reason="";
   if(!ASC_Layer3SnapshotDataSane(state,data_reason))
     {
      state.filter_readiness=ASC_FILTER_INELIGIBLE_DATA_INVALID;
      state.filter_pending_reason=data_reason;
      state.filter_characterization="Ineligible / Snapshot data invalid";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason=data_reason;
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   if(state.snapshot_trade_mode==SYMBOL_TRADE_MODE_DISABLED || state.snapshot_trade_mode==SYMBOL_TRADE_MODE_CLOSEONLY)
     {
      state.filter_readiness=ASC_FILTER_INELIGIBLE_TRADE_MODE_BLOCKED;
      state.filter_pending_reason="Layer 3 rejects symbols whose Layer 2 snapshot shows trade mode disabled or close-only.";
      state.filter_characterization="Ineligible / Trade Mode " + ASC_SymbolTradeModeText(state.snapshot_trade_mode);
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason="Layer 3 excludes symbols whose current Layer 2 trade mode blocks new participation.";
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   if(state.snapshot_volume_min<=0.0 || state.snapshot_volume_step<=0.0 || state.snapshot_volume_max<state.snapshot_volume_min)
     {
      state.filter_readiness=ASC_FILTER_INELIGIBLE_VOLUME_INVALID;
      state.filter_pending_reason="Layer 3 rejects symbols whose Layer 2 volume bounds are missing or invalid.";
      state.filter_characterization="Ineligible / Invalid volume bounds";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason="Layer 3 excludes symbols when Layer 2 volume bounds are not usable yet.";
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   string spread_reason="";
   if(!ASC_Layer3SpreadWithinBounds(state,spread_reason))
     {
      state.filter_readiness=ASC_FILTER_INELIGIBLE_SPREAD_EXCESSIVE;
      state.filter_pending_reason=spread_reason;
      state.filter_characterization="Ineligible / Spread normalization failed";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason=spread_reason;
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   ASC_SymbolClassification classification;
   if(!ASC_CL_ClassifySymbol(g_runtime.server_clean,state.symbol,classification) || !classification.resolved || classification.primary_bucket=="")
     {
      state.filter_readiness=ASC_FILTER_PENDING_CLASSIFICATION;
      state.filter_pending_reason="Layer 3 keeps this symbol pending until identity/bucketing resolves enough to characterize the candidate honestly.";
      state.filter_characterization="Pending / Classification unresolved";
      g_runtime.candidate_filter.readiness=state.filter_readiness;
      g_runtime.candidate_filter.pending_reason="Layer 3 is waiting for provisional identity/bucketing truth before it can characterize the candidate.";
      g_runtime.candidate_filter.characterization=state.filter_characterization;
      return;
     }

   state.filter_readiness=ASC_FILTER_ELIGIBLE;
   state.filter_pending_reason="Layer 3 marks this symbol eligible because tick continuity is current, Layer 2 data is sane, and normalized spread remains bounded.";
   state.filter_characterization=ASC_CandidateFilterCharacterization(state,classification);
   state.filter_eligible=true;
   g_runtime.candidate_filter.readiness=state.filter_readiness;
   g_runtime.candidate_filter.pending_reason="Layer 3 produced bounded eligibility from Layer 1 openness, tick continuity, and Layer 2 data-aware gates only.";
   g_runtime.candidate_filter.characterization=state.filter_characterization;
   g_runtime.candidate_filter.eligible=true;
  }

int ASC_ShortlistGlobalCap(void)
  {
   int cap=g_settings.reserved_selected_symbol_limit;
   if(cap<=0)
      cap=1;
   return(cap);
  }

int ASC_ShortlistBucketCap(void)
  {
   int bucket_cap=g_settings.reserved_selected_bucket_limit;
   if(bucket_cap<=0)
      bucket_cap=1;
   int global_cap=ASC_ShortlistGlobalCap();
   if(bucket_cap>global_cap)
      bucket_cap=global_cap;
   return(bucket_cap);
  }


int ASC_ShortlistBucketOrder(const string bucket)
  {
   string value=ASC_ToUpper(ASC_Trim(bucket));
   if(value=="FX_MAJOR")
      return(0);
   if(value=="INDEX_US")
      return(1);
   if(value=="INDEX_EUROPE")
      return(2);
   if(value=="METALS_PRECIOUS")
      return(3);
   if(value=="ENERGY")
      return(4);
   if(value=="CRYPTO_LARGE_CAP")
      return(5);
   if(StringFind(value,"STOCK")==0 || value=="US_LARGE_CAP" || value=="EU_LARGE_CAP" || value=="HK_LARGE_CAP")
      return(6);
   return(7);
  }

bool ASC_ShortlistPreferred(const int left_index,const int right_index)
  {
   ASC_SymbolState left=g_symbols[left_index];
   ASC_SymbolState right=g_symbols[right_index];

   ASC_SymbolClassification left_classification;
   ASC_SymbolClassification right_classification;
   bool left_classified=(ASC_CL_ClassifySymbol(g_runtime.server_clean,left.symbol,left_classification) && left_classification.resolved && left_classification.primary_bucket!="");
   bool right_classified=(ASC_CL_ClassifySymbol(g_runtime.server_clean,right.symbol,right_classification) && right_classification.resolved && right_classification.primary_bucket!="");

   int left_bucket_order=(left_classified ? ASC_ShortlistBucketOrder(left_classification.primary_bucket) : 99);
   int right_bucket_order=(right_classified ? ASC_ShortlistBucketOrder(right_classification.primary_bucket) : 99);
   if(left_bucket_order!=right_bucket_order)
      return(left_bucket_order<right_bucket_order);

   if(left.tick_age_seconds!=right.tick_age_seconds)
     {
      long left_tick=(left.tick_age_seconds>=0 ? left.tick_age_seconds : 2147483647);
      long right_tick=(right.tick_age_seconds>=0 ? right.tick_age_seconds : 2147483647);
      if(left_tick!=right_tick)
         return(left_tick<right_tick);
     }

   if(left.snapshot_atr_m1_reliable!=right.snapshot_atr_m1_reliable)
      return(left.snapshot_atr_m1_reliable && !right.snapshot_atr_m1_reliable);

   if(left.snapshot_spread_percent!=right.snapshot_spread_percent)
      return(left.snapshot_spread_percent<right.snapshot_spread_percent);

   double left_spread_to_atr=(left.snapshot_atr_m1_reliable && left.snapshot_atr_m1>0.0 ? left.snapshot_spread_to_atr_percent : 1000000.0);
   double right_spread_to_atr=(right.snapshot_atr_m1_reliable && right.snapshot_atr_m1>0.0 ? right.snapshot_spread_to_atr_percent : 1000000.0);
   if(left_spread_to_atr!=right_spread_to_atr)
      return(left_spread_to_atr<right_spread_to_atr);

   return(StringCompare(left.symbol,right.symbol,true)<0);
  }

void ASC_ShortlistSortIndices(int &indices[])
  {
   int total=ArraySize(indices);
   for(int i=1;i<total;i++)
     {
      int key=indices[i];
      int j=i-1;
      while(j>=0 && ASC_ShortlistPreferred(key,indices[j]))
        {
         indices[j+1]=indices[j];
         j--;
        }
      indices[j+1]=key;
     }
  }

int ASC_CountAssignedShortlistSelectionsForBucket(const string bucket,const string &assigned_buckets[])
  {
   int count=0;
   string target=ASC_Trim(bucket);
   for(int i=0;i<ArraySize(assigned_buckets);i++)
     {
      if(ASC_Trim(assigned_buckets[i])==target)
         count++;
     }
   return(count);
  }


bool ASC_ValidateShortlistState(string &reason)
  {
   reason="";
   for(int i=0;i<g_symbol_count;i++)
     {
      if(!g_symbols[i].shortlist_selected)
         continue;
      if(g_symbols[i].shortlist_readiness!=ASC_SHORTLIST_SELECTED)
        {
         reason="selected symbol has non-selected readiness: " + g_symbols[i].symbol;
         return(false);
        }
      if(!g_symbols[i].filter_eligible || g_symbols[i].filter_readiness!=ASC_FILTER_ELIGIBLE)
        {
         reason="selected symbol is not Layer 3 eligible: " + g_symbols[i].symbol;
         return(false);
        }
      if(g_symbols[i].shortlist_rank<1 || g_symbols[i].shortlist_rank>5)
        {
         reason="selected symbol has invalid shortlist rank: " + g_symbols[i].symbol;
         return(false);
        }
      if(g_symbols[i].shortlist_display_bucket=="")
        {
         reason="selected symbol missing shortlist display bucket: " + g_symbols[i].symbol;
         return(false);
        }
     }
   return(true);
  }

bool ASC_CurrentShortlistStillValid(void)
  {
   int selected=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(!g_symbols[i].shortlist_selected)
         continue;
      selected++;
      if(g_symbols[i].market_status!=ASC_MARKET_OPEN)
         return(false);
      if(!g_symbols[i].filter_eligible || g_symbols[i].filter_readiness!=ASC_FILTER_ELIGIBLE)
         return(false);
     }
   return(selected>0);
  }

int ASC_FindBucketSlot(const string bucket,string &bucket_names[])
  {
   string target=ASC_Trim(bucket);
   for(int i=0;i<ArraySize(bucket_names);i++)
     {
      if(ASC_Trim(bucket_names[i])==target)
         return(i);
     }
   return(-1);
  }

void ASC_AppendIndex(int &indices[],const int index)
  {
   int slot=ArraySize(indices);
   ArrayResize(indices,slot+1);
   indices[slot]=index;
  }

void ASC_AppendBucketName(string &bucket_names[],const string bucket)
  {
   if(ASC_FindBucketSlot(bucket,bucket_names)>=0)
      return;
   int slot=ArraySize(bucket_names);
   ArrayResize(bucket_names,slot+1);
   bucket_names[slot]=bucket;
  }

bool ASC_ShortlistBorrowCandidateUsed(const int index,const int &used_indices[])
  {
   for(int i=0;i<ArraySize(used_indices);i++)
     {
      if(used_indices[i]==index)
         return(true);
     }
   return(false);
  }

int ASC_ShortlistNeighborDistance(const string from_bucket,const string candidate_bucket)
  {
   int from_order=ASC_ShortlistBucketOrder(from_bucket);
   int candidate_order=ASC_ShortlistBucketOrder(candidate_bucket);
   int distance=from_order-candidate_order;
   if(distance<0)
      distance=-distance;
   return(distance);
  }

int ASC_ShortlistFindBorrowCandidate(const string target_bucket,string &bucket_names[],int &bucket_counts[],int &bucket_offsets[],int &ordered_candidates[],int &used_indices[])
  {
   int best_index=-1;
   int best_distance=1000;
   int best_offset=1000000;
   for(int b=0;b<ArraySize(bucket_names);b++)
     {
      if(bucket_counts[b]<=5)
         continue;
      for(int pos=5;pos<bucket_counts[b];pos++)
        {
         int ordered_index=ordered_candidates[bucket_offsets[b]+pos];
         if(ASC_ShortlistBorrowCandidateUsed(ordered_index,used_indices))
            continue;
         int distance=ASC_ShortlistNeighborDistance(target_bucket,bucket_names[b]);
         if(best_index<0 || distance<best_distance || (distance==best_distance && pos<best_offset))
           {
            best_index=ordered_index;
            best_distance=distance;
            best_offset=pos;
           }
         break;
        }
     }
   return(best_index);
  }

void ASC_RebuildShortlistState(void)
  {
   datetime evaluated_at=TimeTradeServer();
   if(evaluated_at<=0)
      evaluated_at=TimeCurrent();

   if(g_runtime.shortlist_hold_until>evaluated_at && ASC_CurrentShortlistStillValid() && !g_shortlist_dirty)
     {
      g_runtime.shortlist.last_evaluated_at=evaluated_at;
      g_runtime.shortlist.readiness=ASC_SHORTLIST_SELECTED;
      g_runtime.shortlist.pending_reason="Layer 4 is holding the current promoted set inside the active calm window.";
      g_runtime.shortlist.basis="Selected / Hold window preserved the current top set";
      return;
     }

   g_runtime_shortlist_selected_count=0;
   g_runtime_shortlist_pending_count=0;
   g_runtime_shortlist_filter_blocked_count=0;
   g_runtime_shortlist_global_cap_blocked_count=0;
   g_runtime_shortlist_bucket_cap_blocked_count=0;

   string bucket_names[];
   int bucket_counts[];
   int ordered_candidates[];
   ArrayResize(bucket_names,0);
   ArrayResize(bucket_counts,0);
   ArrayResize(ordered_candidates,0);

   for(int i=0;i<g_symbol_count;i++)
     {
      g_symbols[i].shortlist_last_evaluated_at=evaluated_at;
      g_symbols[i].shortlist_selected=false;
      g_symbols[i].shortlist_rank=0;
      g_symbols[i].shortlist_bucket="";
      g_symbols[i].shortlist_display_bucket="";
      g_symbols[i].shortlist_spill_fill=false;
      g_symbols[i].shortlist_basis="Pending / No shortlist admission basis yet";

      if(g_symbols[i].market_status!=ASC_MARKET_OPEN)
        {
         g_symbols[i].shortlist_readiness=ASC_SHORTLIST_INELIGIBLE_MARKET_NOT_OPEN;
         g_symbols[i].shortlist_pending_reason="Layer 4 cannot shortlist symbols unless Layer 1 still confirms Market State Open.";
         g_symbols[i].shortlist_basis="Ineligible / Layer 1 market state is not Open";
         continue;
        }

      if(!g_symbols[i].filter_eligible || g_symbols[i].filter_readiness!=ASC_FILTER_ELIGIBLE)
        {
         g_symbols[i].shortlist_readiness=ASC_SHORTLIST_INELIGIBLE_FILTER_NOT_ELIGIBLE;
         g_symbols[i].shortlist_pending_reason="Layer 4 only admits symbols that Layer 3 already marked eligible.";
         g_symbols[i].shortlist_basis="Ineligible / Layer 3 did not admit this symbol";
         g_runtime_shortlist_filter_blocked_count++;
         continue;
        }

      ASC_SymbolClassification classification;
      if(!ASC_CL_ClassifySymbol(g_runtime.server_clean,g_symbols[i].symbol,classification) || !classification.resolved || classification.primary_bucket=="")
        {
         g_symbols[i].shortlist_readiness=ASC_SHORTLIST_PENDING_LAYER3;
         g_symbols[i].shortlist_pending_reason="Layer 4 keeps this symbol pending until bucket identity is usable for shortlist admission.";
         g_symbols[i].shortlist_basis="Pending / No shortlist bucket identity yet";
         g_runtime_shortlist_pending_count++;
         continue;
        }

      string bucket=classification.primary_bucket;
      int slot=ASC_FindBucketSlot(bucket,bucket_names);
      if(slot<0)
        {
         slot=ArraySize(bucket_names);
         ArrayResize(bucket_names,slot+1);
         ArrayResize(bucket_counts,slot+1);
         bucket_names[slot]=bucket;
         bucket_counts[slot]=0;
        }

      ASC_AppendIndex(ordered_candidates,i);
      bucket_counts[slot]++;
      g_symbols[i].shortlist_bucket=bucket;
      g_symbols[i].shortlist_display_bucket=bucket;
     }

   ASC_ShortlistSortIndices(ordered_candidates);

   // rebuild ordered candidates per bucket in stable bucket order
   string sorted_bucket_names[];
   int sorted_bucket_counts[];
   int bucket_offsets[];
   int per_bucket_candidates[];
   ArrayResize(sorted_bucket_names,0);
   ArrayResize(sorted_bucket_counts,0);
   ArrayResize(bucket_offsets,0);
   ArrayResize(per_bucket_candidates,0);

   for(int pass=0;pass<ArraySize(bucket_names);pass++)
     {
      int best=-1;
      for(int b=0;b<ArraySize(bucket_names);b++)
        {
         if(bucket_names[b]=="")
            continue;
         if(best<0 || ASC_ShortlistBucketOrder(bucket_names[b])<ASC_ShortlistBucketOrder(bucket_names[best]))
            best=b;
        }
      if(best<0)
         break;
      int slot=ArraySize(sorted_bucket_names);
      ArrayResize(sorted_bucket_names,slot+1);
      ArrayResize(sorted_bucket_counts,slot+1);
      ArrayResize(bucket_offsets,slot+1);
      sorted_bucket_names[slot]=bucket_names[best];
      sorted_bucket_counts[slot]=0;
      bucket_offsets[slot]=ArraySize(per_bucket_candidates);
      for(int i=0;i<ArraySize(ordered_candidates);i++)
        {
         int idx=ordered_candidates[i];
         if(ASC_Trim(g_symbols[idx].shortlist_bucket)!=ASC_Trim(bucket_names[best]))
            continue;
         ASC_AppendIndex(per_bucket_candidates,idx);
         sorted_bucket_counts[slot]++;
        }
      bucket_names[best]="";
     }

   int used_indices[];
   ArrayResize(used_indices,0);

   for(int b=0;b<ArraySize(sorted_bucket_names);b++)
     {
      int actual_count=sorted_bucket_counts[b];
      int slot_rank=1;
      for(int pos=0;pos<actual_count && pos<5;pos++)
        {
         int idx=per_bucket_candidates[bucket_offsets[b]+pos];
         g_symbols[idx].shortlist_selected=true;
         g_symbols[idx].shortlist_rank=slot_rank++;
         g_symbols[idx].shortlist_display_bucket=sorted_bucket_names[b];
         g_symbols[idx].shortlist_spill_fill=false;
         g_symbols[idx].shortlist_readiness=ASC_SHORTLIST_SELECTED;
         g_symbols[idx].shortlist_pending_reason="Layer 4 admitted this symbol into the bucket top set.";
         g_symbols[idx].shortlist_basis="Selected / Top 5 in own main bucket";
         ASC_AppendIndex(used_indices,idx);
         g_runtime_shortlist_selected_count++;
        }

      while(slot_rank<=5)
        {
         int borrow_idx=ASC_ShortlistFindBorrowCandidate(sorted_bucket_names[b],sorted_bucket_names,sorted_bucket_counts,bucket_offsets,per_bucket_candidates,used_indices);
         if(borrow_idx<0)
            break;
         g_symbols[borrow_idx].shortlist_selected=true;
         g_symbols[borrow_idx].shortlist_rank=slot_rank++;
         g_symbols[borrow_idx].shortlist_display_bucket=sorted_bucket_names[b];
         g_symbols[borrow_idx].shortlist_spill_fill=true;
         g_symbols[borrow_idx].shortlist_readiness=ASC_SHORTLIST_SELECTED;
         g_symbols[borrow_idx].shortlist_pending_reason="Layer 4 borrowed this candidate to keep a sparse bucket’s visible top set full.";
         g_symbols[borrow_idx].shortlist_basis="Selected / Neighbor spill fill into sparse bucket while preserving true origin " + g_symbols[borrow_idx].shortlist_bucket;
         ASC_AppendIndex(used_indices,borrow_idx);
         g_runtime_shortlist_selected_count++;
        }
     }

   g_runtime.shortlist.last_evaluated_at=evaluated_at;
   g_runtime.shortlist_last_rebuild_at=evaluated_at;
   g_runtime.shortlist_hold_until=evaluated_at + g_runtime.shortlist_hold_window_seconds;
   g_runtime.shortlist.selected=(g_runtime_shortlist_selected_count>0);
   g_runtime.shortlist.selected_bucket="";
   g_runtime.shortlist.basis="Pending / No shortlist admission basis yet";
   g_runtime.shortlist.pending_reason="Layer 4 is waiting for Layer 3 eligible symbols before it can admit any shortlist members.";
   g_runtime.shortlist.readiness=ASC_SHORTLIST_PENDING_LAYER3;

   if(g_runtime_shortlist_selected_count>0)
     {
      g_runtime.shortlist.readiness=ASC_SHORTLIST_SELECTED;
      g_runtime.shortlist.pending_reason="Layer 4 rebuilt the top 5 per main bucket and started a calm hold window.";
      g_runtime.shortlist.basis="Selected / Top 5 per main bucket with honest sparse-bucket spill fill";
      for(int i=0;i<g_symbol_count;i++)
        {
         if(g_symbols[i].shortlist_selected)
           {
            g_runtime.shortlist.selected_bucket=g_symbols[i].shortlist_display_bucket;
            break;
           }
        }
     }
   else if(g_runtime_shortlist_pending_count>0)
     {
      g_runtime.shortlist.readiness=ASC_SHORTLIST_PENDING_LAYER3;
      g_runtime.shortlist.pending_reason="Layer 4 is still waiting for usable bucket identity on at least one Layer 3-eligible symbol.";
      g_runtime.shortlist.basis="Pending / Eligible symbols still awaiting shortlist identity";
     }
   else if(g_runtime_shortlist_filter_blocked_count>0)
     {
      g_runtime.shortlist.readiness=ASC_SHORTLIST_INELIGIBLE_FILTER_NOT_ELIGIBLE;
      g_runtime.shortlist.pending_reason="Layer 4 only consumes symbols that already passed Layer 3 eligibility.";
      g_runtime.shortlist.basis="Ineligible / No current Layer 3-eligible shortlist candidates";
     }

   g_runtime.layer3_dirty=false;
   g_shortlist_dirty=false;
   g_runtime.runtime_dirty=true;
   g_last_shortlist_rebuild_eligible_count=g_runtime_filter_eligible_count;
   g_last_shortlist_rebuild_pending_count=g_runtime_filter_pending_count;
   int cooldown_seconds=5;
   if(g_runtime_filter_pending_count>=128)
      cooldown_seconds=15;
   else if(g_runtime_filter_pending_count>=32)
      cooldown_seconds=10;
   g_shortlist_rebuild_not_before=evaluated_at+cooldown_seconds;
  }


int ASC_Layer2FocusedRefreshSeconds(void)
  {
   int focused_seconds=ASC_LAYER2_FOCUSED_REFRESH_SECONDS;
   if(focused_seconds<=0)
      focused_seconds=1;
   if(g_settings.open_recheck_seconds>0 && focused_seconds>g_settings.open_recheck_seconds)
      focused_seconds=g_settings.open_recheck_seconds;
   if(focused_seconds<=0)
      focused_seconds=1;
   return(focused_seconds);
  }

int ASC_Layer2SnapshotAgeSeconds(const ASC_SymbolState &state,const datetime now)
  {
   if(state.snapshot_last_built_at<=0 || now<=0)
      return(-1);
   long age=(long)(now-state.snapshot_last_built_at);
   if(age<0)
      age=0;
   return((int)age);
  }

bool ASC_ShouldRefreshOpenSymbolSnapshotByCadence(const ASC_SymbolState &state,const int cadence_seconds)
  {
   if(state.market_status!=ASC_MARKET_OPEN)
      return(false);
   if(state.snapshot_last_built_at<=0)
      return(true);
   if(state.snapshot_readiness==ASC_SNAPSHOT_DEGRADED_RETRY_PENDING)
      return(true);
   datetime now=TimeTradeServer();
   if(now<=0)
      now=TimeCurrent();
   int effective_cadence=(cadence_seconds>0 ? cadence_seconds : g_settings.open_recheck_seconds);
   if(effective_cadence<=0)
      effective_cadence=1;
   return(ASC_Layer2SnapshotAgeSeconds(state,now)>=effective_cadence);
  }

bool ASC_ShouldRefreshOpenSymbolSnapshot(const ASC_SymbolState &state)
  {
   return(ASC_ShouldRefreshOpenSymbolSnapshotByCadence(state,g_settings.open_recheck_seconds));
  }

void ASC_UpdateOpenSymbolSnapshotState(ASC_SymbolState &state,const int cadence_seconds=0,const bool force_refresh=false)
  {
   state.snapshot_last_good_preserved=false;

   if(state.market_status==ASC_MARKET_CLOSED)
     {
      state.snapshot_readiness=ASC_SNAPSHOT_INELIGIBLE_SYMBOL_CLOSED;
      state.snapshot_pending_reason="Layer 2 is not eligible until the symbol returns to Open.";
      g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_INELIGIBLE_SYMBOL_CLOSED;
      g_runtime.open_symbol_snapshot.pending_reason="Layer 2 is ineligible for closed symbols and preserves any prior last-good snapshot.";
      g_runtime.open_symbol_snapshot.last_good_preserved=state.snapshot_has_last_good;
      g_runtime.open_symbol_snapshot.has_last_good=state.snapshot_has_last_good;
      g_runtime.open_symbol_snapshot.last_good_built_at=state.snapshot_last_good_built_at;
      return;
     }

   if(state.market_status!=ASC_MARKET_OPEN)
     {
      state.snapshot_readiness=ASC_SNAPSHOT_INELIGIBLE_MARKET_NOT_OPEN;
      state.snapshot_pending_reason="Layer 2 is not eligible until Market State Detection returns Open.";
      g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_INELIGIBLE_MARKET_NOT_OPEN;
      g_runtime.open_symbol_snapshot.pending_reason="Layer 2 waits for Layer 1 to confirm Market State Open before building a snapshot.";
      g_runtime.open_symbol_snapshot.last_good_preserved=state.snapshot_has_last_good;
      g_runtime.open_symbol_snapshot.has_last_good=state.snapshot_has_last_good;
      g_runtime.open_symbol_snapshot.last_good_built_at=state.snapshot_last_good_built_at;
      return;
     }

   int effective_cadence=(cadence_seconds>0 ? cadence_seconds : g_settings.open_recheck_seconds);
   bool cadence_due=(force_refresh || ASC_ShouldRefreshOpenSymbolSnapshotByCadence(state,effective_cadence));

   if(!cadence_due)
     {
      state.snapshot_pending_reason="Layer 2 reuses current open-symbol snapshot until its owned cadence says the symbol is stale.";
      g_runtime.open_symbol_snapshot.readiness=state.snapshot_readiness;
      g_runtime.open_symbol_snapshot.pending_reason="Layer 2 kept the current open-symbol snapshot because its owned cadence is still fresh enough.";
      g_runtime.open_symbol_snapshot.has_last_good=state.snapshot_has_last_good;
      g_runtime.open_symbol_snapshot.last_good_preserved=state.snapshot_last_good_preserved;
      g_runtime.open_symbol_snapshot.last_good_built_at=state.snapshot_last_good_built_at;
      g_runtime.open_symbol_snapshot.last_built_at=state.snapshot_last_built_at;
      return;
     }

   state.snapshot_readiness=ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD;
   state.snapshot_pending_reason="Layer 2 is eligible and pending this open-symbol refresh attempt.";
   g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD;
   g_runtime.open_symbol_snapshot.pending_reason="Layer 2 is eligible and pending the next bounded open-symbol build.";

   string failure_reason="";
   if(ASC_BuildOpenSymbolSnapshot(state,failure_reason))
      return;

   if(state.snapshot_has_last_good)
     {
      state.snapshot_readiness=ASC_SNAPSHOT_WORKING_LAST_GOOD;
      state.snapshot_pending_reason=failure_reason + " Last-good snapshot values remain published.";
      state.snapshot_last_good_preserved=true;
      g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_WORKING_LAST_GOOD;
      g_runtime.open_symbol_snapshot.pending_reason="Layer 2 refresh failed for an open symbol; last-good snapshot truth remains active.";
      g_runtime.open_symbol_snapshot.has_last_good=true;
      g_runtime.open_symbol_snapshot.last_good_preserved=true;
      g_runtime.open_symbol_snapshot.last_good_built_at=state.snapshot_last_good_built_at;
     }
   else
     {
      state.snapshot_readiness=ASC_SNAPSHOT_DEGRADED_RETRY_PENDING;
      state.snapshot_pending_reason=failure_reason + " No last-good snapshot exists yet.";
      g_runtime.open_symbol_snapshot.readiness=ASC_SNAPSHOT_DEGRADED_RETRY_PENDING;
      g_runtime.open_symbol_snapshot.pending_reason="Layer 2 refresh failed for an open symbol and no last-good snapshot exists yet.";
      g_runtime.open_symbol_snapshot.has_last_good=false;
      g_runtime.open_symbol_snapshot.last_good_preserved=false;
      g_runtime.open_symbol_snapshot.last_good_built_at=0;
     }
  }

bool ASC_ProcessLayer1Symbol(const int index)
  {
   if(index<0 || index>=g_symbol_count)
      return(false);
   ASC_AssessSymbol(g_symbols[index].symbol,g_symbols[index],g_settings);
   g_runtime.layer1_dirty=true;
   g_runtime.layer2_dirty=true;
   g_runtime.prepared_live_dirty=true;
   ASC_LogSchedulerDecision(g_symbols[index]);
   return(true);
  }

bool ASC_ProcessLayer2Symbol(const int index,const bool force_refresh)
  {
   if(index<0 || index>=g_symbol_count)
      return(false);

   datetime prior_built=g_symbols[index].snapshot_last_built_at;
   datetime prior_last_good=g_symbols[index].snapshot_last_good_built_at;
   ASC_SnapshotReadinessStatus prior_readiness=g_symbols[index].snapshot_readiness;
   bool prior_has_last_good=g_symbols[index].snapshot_has_last_good;
   bool prior_last_good_preserved=g_symbols[index].snapshot_last_good_preserved;
   string prior_pending=g_symbols[index].snapshot_pending_reason;

   if(g_symbols[index].market_status!=ASC_MARKET_OPEN)
     {
      ASC_UpdateOpenSymbolSnapshotState(g_symbols[index]);
      bool changed=(g_symbols[index].snapshot_readiness!=prior_readiness
                    || g_symbols[index].snapshot_has_last_good!=prior_has_last_good
                    || g_symbols[index].snapshot_last_good_preserved!=prior_last_good_preserved
                    || g_symbols[index].snapshot_last_good_built_at!=prior_last_good
                    || g_symbols[index].snapshot_pending_reason!=prior_pending);
      if(changed)
        {
         g_runtime.layer2_dirty=true;
         g_runtime.layer3_dirty=true;
         g_symbols[index].dirty=true;
        }
      return(changed);
     }

   int cadence_seconds=(force_refresh ? 1 : g_settings.open_recheck_seconds);

   ASC_UpdateOpenSymbolSnapshotState(g_symbols[index],cadence_seconds,force_refresh);

   bool changed=(g_symbols[index].snapshot_last_built_at!=prior_built
                 || g_symbols[index].snapshot_last_good_built_at!=prior_last_good
                 || g_symbols[index].snapshot_readiness!=prior_readiness
                 || g_symbols[index].snapshot_has_last_good!=prior_has_last_good
                 || g_symbols[index].snapshot_last_good_preserved!=prior_last_good_preserved
                 || g_symbols[index].snapshot_pending_reason!=prior_pending
                 || force_refresh);
   if(changed)
     {
      g_runtime.layer2_dirty=true;
      g_runtime.layer3_dirty=true;
      g_symbols[index].dirty=true;
     }
   return(changed);
  }

bool ASC_ProcessLayer3Symbol(const int index)
  {
   if(index<0 || index>=g_symbol_count)
      return(false);
   if(!ASC_ShouldEvaluateCandidateFilter(g_symbols[index]))
      return(false);
   datetime prior_eval=g_symbols[index].filter_last_evaluated_at;
   bool prior_eligible=g_symbols[index].filter_eligible;
   ASC_FilterReadinessStatus prior_readiness=g_symbols[index].filter_readiness;
   ASC_UpdateCandidateFilterState(g_symbols[index]);
   bool changed=(g_symbols[index].filter_last_evaluated_at!=prior_eval
                 || g_symbols[index].filter_eligible!=prior_eligible
                 || g_symbols[index].filter_readiness!=prior_readiness);
   if(changed)
     {
      g_runtime.layer3_dirty=true;
      bool shortlist_truth_changed=(prior_eligible!=g_symbols[index].filter_eligible
                                   || prior_readiness==ASC_FILTER_ELIGIBLE
                                   || g_symbols[index].filter_readiness==ASC_FILTER_ELIGIBLE);
      if(shortlist_truth_changed)
         g_shortlist_dirty=true;
      g_symbols[index].dirty=true;
     }
   return(changed);
  }

int ASC_Layer5RankCadenceSeconds(const ASC_SymbolState &state)
  {
   int rank=(state.shortlist_rank>0 ? state.shortlist_rank : 5);
   if(rank<1)
      rank=1;
   if(rank>5)
      rank=5;
   return(rank*5);
  }

bool ASC_ShouldWriteSymbolDossier(const ASC_SymbolState &state,const datetime now)
  {
   if(!g_settings.write_dossiers_when_due)
      return(false);

   if(!state.publication_ok || state.last_dossier_write_at<=0)
      return(true);
   if(state.dirty)
      return(true);

   if(state.shortlist_selected && state.shortlist_rank>0)
     {
      if(state.layer5_last_update_at>0 && state.layer5_last_update_at>state.last_dossier_write_at)
         return(true);
     }

   return((now-state.last_dossier_write_at)>=g_settings.summary_save_seconds);
  }

bool ASC_ShouldRunLayer5Wave(const datetime now)
  {
   if(!g_runtime.layer1_boot_complete)
      return(false);
   if(!g_runtime.shortlist.selected)
      return(false);

   for(int i=0;i<g_symbol_count;i++)
     {
      if(!g_symbols[i].shortlist_selected || g_symbols[i].shortlist_rank<=0)
         continue;
      if(g_symbols[i].layer5_last_update_at<=0)
         return(true);
      if((now-g_symbols[i].layer5_last_update_at)>=ASC_Layer5RankCadenceSeconds(g_symbols[i]))
         return(true);
     }
   return(false);
  }

int ASC_RunLayer5Wave(const datetime now,const int budget)
  {
   int touched=0;
   for(int rank=1; rank<=5 && touched<budget; rank++)
     {
      for(int i=0;i<g_symbol_count && touched<budget;i++)
        {
         if(!g_symbols[i].shortlist_selected || g_symbols[i].shortlist_rank!=rank)
            continue;
         if(g_symbols[i].layer5_last_update_at>0 && (now-g_symbols[i].layer5_last_update_at)<ASC_Layer5RankCadenceSeconds(g_symbols[i]))
            continue;

         g_symbols[i].layer5_last_update_at=now;
         g_symbols[i].dirty=true;
         touched++;
        }
     }

   if(touched>0)
     {
      g_runtime.runtime_dirty=true;
      g_runtime.scheduler_dirty=true;
      g_runtime.summary_dirty=true;
     }
   return(touched);
  }

void ASC_OpenSymbolSnapshotPlaceholder(void) { }
void ASC_CandidateFilteringPlaceholder(void) { /* bounded Layer 3 now active in ASC_UpdateCandidateFilterState */ }
void ASC_ShortlistSelectionPlaceholder(void) { }
void ASC_DeepSelectiveAnalysisPlaceholder(void) { }


bool ASC_RunLayer1BootAcquisition(const datetime now)
  {
   if(g_symbol_count<=0)
      ASC_SyncUniverse();

   int unresolved_indices[];
   ArrayResize(unresolved_indices,0);

   for(int i=0;i<g_symbol_count;i++)
     {
      ASC_ProcessLayer1Symbol(i);
      if(g_symbols[i].market_status==ASC_MARKET_UNCERTAIN || g_symbols[i].market_status==ASC_MARKET_UNKNOWN)
         ASC_AppendIndex(unresolved_indices,i);
     }

   int confirmation_limit=3;
   for(int pass=0; pass<confirmation_limit && ArraySize(unresolved_indices)>0; pass++)
     {
      int next_pass[];
      ArrayResize(next_pass,0);
      for(int i=0;i<ArraySize(unresolved_indices);i++)
        {
         int index=unresolved_indices[i];
         ASC_ProcessLayer1Symbol(index);
         if(g_symbols[index].market_status==ASC_MARKET_UNCERTAIN || g_symbols[index].market_status==ASC_MARKET_UNKNOWN)
            ASC_AppendIndex(next_pass,index);
        }
      ArrayResize(unresolved_indices,ArraySize(next_pass));
      for(int i=0;i<ArraySize(next_pass);i++)
         unresolved_indices[i]=next_pass[i];
     }

   ASC_UpdateLayer1Readiness();
   ASC_UpdateRuntimeMode();
   g_runtime.layer1_boot_complete=g_runtime.warmup_minimum_met;
   g_runtime.layer1_truth_published=true;
   g_runtime.last_dispatcher_lane=ASC_LANE_LAYER1_BOOT;
   g_runtime.last_dispatcher_summary="heavy lane: Layer 1 boot acquisition";
   g_runtime.last_dispatcher_at=now;
   g_runtime.runtime_dirty=true;
   g_runtime.scheduler_dirty=true;
   ASC_SaveRuntimeState(g_paths,g_runtime,g_logger);
   if(ASC_SaveSchedulerState(g_paths,g_symbols,g_symbol_count,g_logger))
     {
      g_runtime.last_scheduler_save_at=now;
      g_runtime.scheduler_dirty=false;
     }
   return(true);
  }

int ASC_RunLayer1MaintenanceLane(const datetime now,const int budget)
  {
   int touched=0;
   ASC_CountDueSymbols(now);
   g_runtime.diagnostics.scheduler_priority_summary=ASC_BuildSchedulerPrioritySummary(now);
   for(int priority=1; priority<=5 && touched<budget; priority++)
     {
      if(g_symbol_count<=0)
         break;
      int start=(g_runtime.scheduler_cursor % g_symbol_count);
      for(int offset=0; offset<g_symbol_count && touched<budget; offset++)
        {
         int index=(start + offset) % g_symbol_count;
         if(!g_symbols[index].is_due_now)
            continue;
         if(ASC_SchedulerPriorityForSymbol(g_symbols[index],now)!=priority)
            continue;
         ASC_ProcessLayer1Symbol(index);
         touched++;
         g_runtime.scheduler_cursor=(g_symbol_count>0 ? ((index+1)%g_symbol_count) : 0);
        }
     }
   if(touched>0)
     {
      g_runtime.layer1_dirty=true;
      g_runtime.layer2_dirty=true;
      g_runtime.prepared_live_dirty=true;
      g_runtime.scheduler_dirty=true;
      g_runtime.summary_dirty=true;
     }
   return(touched);
  }

int ASC_RunLayer2BackgroundLane(const datetime now,const int budget)
  {
   int touched=0;
   if(g_symbol_count<=0 || budget<=0)
      return(0);

   string focused=ASC_ExplorerActiveFocusedSymbolName(g_explorer,g_symbols,g_symbol_count);
   bool used[];
   ArrayResize(used,g_symbol_count);
   ArrayInitialize(used,false);

   for(int pass=0; pass<budget; pass++)
     {
      int best_index=-1;
      int best_score=-1;
      for(int offset=0; offset<g_symbol_count; offset++)
        {
         int index=((g_layer2_cursor + offset) % g_symbol_count);
         if(used[index])
            continue;
         if(!ASC_ShouldRefreshOpenSymbolSnapshot(g_symbols[index]))
            continue;
         int score=ASC_Layer2CandidateScore(g_symbols[index],now,focused);
         if(score>best_score)
           {
            best_score=score;
            best_index=index;
           }
        }

      if(best_index<0)
         break;

      used[best_index]=true;
      if(ASC_ProcessLayer2Symbol(best_index,false))
        {
         touched++;
         g_layer2_cursor=(g_symbol_count>0 ? ((best_index+1)%g_symbol_count) : 0);
        }
     }
   return(touched);
  }

int ASC_Layer2PendingTruthCount(void)
  {
   int pending=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].market_status!=ASC_MARKET_OPEN)
         continue;
      if(g_symbols[i].snapshot_last_built_at<=0
         || g_symbols[i].snapshot_readiness==ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD
         || g_symbols[i].snapshot_readiness==ASC_SNAPSHOT_DEGRADED_RETRY_PENDING)
         pending++;
     }
   return(pending);
  }

int ASC_Layer1MaintenanceBudget(const datetime now)
  {
   int base=(g_settings.symbol_budget_per_heartbeat>0 ? g_settings.symbol_budget_per_heartbeat : 1);
   int due_now=ASC_CountDueSymbols(now);
   int budget=base;

   if(g_runtime.mode==ASC_RUNTIME_WARMUP || !g_runtime.warmup_minimum_met)
      budget=MathMax(budget,MathMin(36,base+12));
   else if(due_now>=(base*8))
      budget=MathMin(32,base+8);
   else if(due_now<=(base/2))
      budget=MathMax(10,base-5);

   if(ASC_HasPersistenceWorkDue(now) && budget>base)
      budget=MathMax(base,budget-4);
   return(budget);
  }

int ASC_Layer2BackgroundBudget(const datetime now)
  {
   int open_symbols=0;
   int due_refresh=0;
   int pending_truth=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].market_status!=ASC_MARKET_OPEN)
         continue;
      open_symbols++;
      if(ASC_ShouldRefreshOpenSymbolSnapshot(g_symbols[i]))
         due_refresh++;
      if(g_symbols[i].snapshot_last_built_at<=0
         || g_symbols[i].snapshot_readiness==ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD
         || g_symbols[i].snapshot_readiness==ASC_SNAPSHOT_DEGRADED_RETRY_PENDING)
         pending_truth++;
     }

   int budget=4;
   if(pending_truth>=256 || due_refresh>=256)
      budget=16;
   else if(pending_truth>=128 || due_refresh>=128)
      budget=14;
   else if(pending_truth>=64 || due_refresh>=64)
      budget=12;
   else if(pending_truth>=24 || due_refresh>=24)
      budget=10;
   else if(pending_truth>=8 || due_refresh>=8)
      budget=8;
   else if(due_refresh>0 || pending_truth>0)
      budget=6;

   if(open_symbols<=8 && (due_refresh>0 || pending_truth>0) && budget<8)
      budget=8;
   if(ASC_HasPersistenceWorkDue(now) && budget>10)
      budget=10;
   return(budget);
  }

int ASC_Layer2CandidateScore(const ASC_SymbolState &state,const datetime now,const string focused_symbol)
  {
   if(state.market_status!=ASC_MARKET_OPEN)
      return(-1);

   int score=0;
   if(state.symbol==focused_symbol || ASC_SymbolsMatchCanonical(state.symbol,focused_symbol))
      score+=1000;
   if(state.shortlist_selected)
      score+=300;
   if(state.snapshot_last_built_at<=0)
      score+=220;
   if(state.snapshot_readiness==ASC_SNAPSHOT_DEGRADED_RETRY_PENDING)
      score+=180;
   if(state.snapshot_readiness==ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD)
      score+=120;

   int age=ASC_Layer2SnapshotAgeSeconds(state,now);
   if(age<0)
      age=120;
   score+=age;

   if(state.tick_age_seconds>=0 && state.tick_age_seconds<=ASC_Layer2FocusedRefreshSeconds())
      score+=20;

   return(score);
  }

bool ASC_RunLayer2FocusedLane(void)
  {
   string focused=ASC_ExplorerActiveFocusedSymbolName(g_explorer,g_symbols,g_symbol_count);
   if(focused=="")
      return(false);

   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].symbol!=focused && !ASC_SymbolsMatchCanonical(g_symbols[i].symbol,focused))
         continue;

      // The HUD may declare operator focus, but it must not force broad live compute.
      // Layer 2 still owns cadence and freshness for the active symbol only.
      if(!ASC_ShouldRefreshOpenSymbolSnapshotByCadence(g_symbols[i],ASC_Layer2FocusedRefreshSeconds()))
         return(false);
      return(ASC_ProcessLayer2Symbol(i,true));
     }
   return(false);
  }

int ASC_Layer3Budget(const datetime now)
  {
   int budget=6;
   if(g_runtime_filter_pending_count>=256)
      budget=20;
   else if(g_runtime_filter_pending_count>=128)
      budget=16;
   else if(g_runtime_filter_pending_count>=64)
      budget=12;
   else if(g_runtime_filter_pending_count>=24)
      budget=10;
   else if(g_runtime_filter_pending_count>0)
      budget=8;

   if(ASC_Layer2PendingTruthCount()>=64 && budget<12)
      budget=12;
   if(ASC_HasPersistenceWorkDue(now) && budget>14)
      budget=14;
   return(budget);
  }

int ASC_RunLayer3Lane(const int budget)
  {
   int touched=0;
   for(int i=0;i<g_symbol_count && touched<budget;i++)
     {
      if(ASC_ProcessLayer3Symbol(i))
         touched++;
     }
   return(touched);
  }

bool ASC_ShortlistNeedsRebuild(const datetime now)
  {
   if(!g_runtime.layer1_boot_complete)
      return(false);
   if(g_runtime.shortlist_last_rebuild_at<=0)
      return(true);

   bool current_valid=ASC_CurrentShortlistStillValid();
   if(!current_valid)
     {
      if(g_runtime_filter_eligible_count<=0 && g_runtime_filter_pending_count>0)
         return(false);
      if(g_shortlist_rebuild_not_before>0 && now<g_shortlist_rebuild_not_before)
         return(false);
      return(true);
     }

   if(g_shortlist_dirty && (g_runtime.shortlist_hold_until<=0 || now>=g_runtime.shortlist_hold_until))
     {
      if(g_shortlist_rebuild_not_before>0 && now<g_shortlist_rebuild_not_before)
         return(false);
      int eligible_delta=g_runtime_filter_eligible_count-g_last_shortlist_rebuild_eligible_count;
      if(eligible_delta<0)
         eligible_delta=-eligible_delta;
      int pending_delta=g_runtime_filter_pending_count-g_last_shortlist_rebuild_pending_count;
      if(pending_delta<0)
         pending_delta=-pending_delta;
      int material_delta=MathMax(4,MathMin(24,g_settings.symbol_budget_per_heartbeat));
      if(eligible_delta<material_delta && pending_delta<material_delta)
         return(false);
      return(true);
     }
   return(false);
  }

bool ASC_RunPreparedLiveRefreshLane(void)
  {
   if(!g_prepared_buckets.ready)
      return(false);
   ASC_PreparedRefreshLiveState(g_prepared_buckets,g_symbols,g_symbol_count);
   g_runtime.prepared_live_dirty=false;
   return(true);
  }

int ASC_PersistenceRecoveryBudget(const datetime now)
  {
   int pending=ASC_CountPendingDossierWrites(now);
   int budget=4;
   if(pending>=600)
      budget=16;
   else if(pending>=300)
      budget=12;
   else if(pending>=150)
      budget=10;
   else if(pending>=60)
      budget=8;
   else if(pending>=20)
      budget=6;

   if(g_runtime.mode==ASC_RUNTIME_WARMUP && budget<10)
      budget=10;
   return(budget);
  }

int ASC_RunPersistenceLane(const datetime now,const int budget)
  {
   int writes=0;
   int dossier_attempts=0;
   int dossier_success=0;
   int dossier_failures=0;
   int dossier_budget=(budget>0 ? budget : 0);
   string first_failed_symbol="";
   bool runtime_due=ASC_ShouldSaveRuntime(now);
   bool scheduler_due=ASC_ShouldSaveScheduler(now);
   bool summary_due=ASC_ShouldSaveSummary(now);
   bool runtime_saved=false;
   bool scheduler_saved=false;
   bool summary_saved=false;
   bool snapshot_saved=false;

   if(g_symbol_count>0 && dossier_budget>0)
     {
      int start=(g_persistence_cursor % g_symbol_count);
      int scanned=0;
      int dossier_writes=0;
      while(scanned<g_symbol_count && dossier_writes<dossier_budget)
        {
         int index=(start + scanned) % g_symbol_count;
         scanned++;
         if(!ASC_ShouldWriteSymbolDossier(g_symbols[index],now))
            continue;

         dossier_attempts++;
         if(ASC_WriteDossier(g_paths,g_runtime,g_symbols[index],g_logger))
           {
            writes++;
            dossier_writes++;
            dossier_success++;
           }
         else
           {
            dossier_failures++;
            if(first_failed_symbol=="")
               first_failed_symbol=g_symbols[index].symbol;
           }

         g_persistence_cursor=(g_symbol_count>0 ? ((index+1)%g_symbol_count) : 0);
        }
     }

   if(runtime_due)
     {
      runtime_saved=ASC_SaveRuntimeState(g_paths,g_runtime,g_logger);
      if(runtime_saved)
        {
         g_runtime.last_runtime_save_at=now;
         g_runtime.runtime_dirty=false;
         writes++;
        }
     }
   if(scheduler_due)
     {
      scheduler_saved=ASC_SaveSchedulerState(g_paths,g_symbols,g_symbol_count,g_logger);
      if(scheduler_saved)
        {
         g_runtime.last_scheduler_save_at=now;
         g_runtime.scheduler_dirty=false;
         writes++;
        }
     }
   if(summary_due)
     {
      summary_saved=ASC_SaveSummary(g_paths,g_runtime,g_symbols,g_symbol_count,g_logger);
      if(summary_saved)
         writes++;
     }
   snapshot_saved=ASC_WriteExplorerSnapshot();
   if(snapshot_saved)
      writes++;

   string detail="attempted=" + IntegerToString(dossier_attempts)
      + ", success=" + IntegerToString(dossier_success)
      + ", failed=" + IntegerToString(dossier_failures)
      + (first_failed_symbol!="" ? ", first_failed=" + first_failed_symbol : "")
      + ", runtime_due=" + ASC_BoolText(runtime_due)
      + ", runtime_saved=" + ASC_BoolText(runtime_saved)
      + ", scheduler_due=" + ASC_BoolText(scheduler_due)
      + ", scheduler_saved=" + ASC_BoolText(scheduler_saved)
      + ", summary_due=" + ASC_BoolText(summary_due)
      + ", summary_saved=" + ASC_BoolText(summary_saved)
      + ", snapshot_saved=" + ASC_BoolText(snapshot_saved)
      + ", pending_after=" + IntegerToString(ASC_CountPendingDossierWrites(now));

   if(dossier_attempts>0 || runtime_due || scheduler_due || summary_due || snapshot_saved)
     {
      if(dossier_success>0 || dossier_failures>0 || runtime_saved || scheduler_saved || summary_saved || snapshot_saved)
         g_logger.Info("Persistence",detail);
      ASC_WritePersistenceAudit(now,"persistence-lane",dossier_attempts,dossier_success,dossier_failures,detail);
     }

   if(dossier_attempts>0 && dossier_success==0)
      g_logger.Warn("Persistence","dossier publication still pending after this pass; failures=" + IntegerToString(dossier_failures) + (first_failed_symbol!="" ? ", first_failed=" + first_failed_symbol : ""));
   return(writes);
  }

bool ASC_RunGuaranteedPersistencePass(const datetime now,const string reason)
  {
   if(!ASC_HasPersistenceWorkDue(now))
      return(false);

   int budget=ASC_PersistenceRecoveryBudget(now);
   int writes=ASC_RunPersistenceLane(now,budget);
   int pending_after=ASC_CountPendingDossierWrites(now);
   string detail="reason=" + reason + ", budget=" + IntegerToString(budget) + ", writes=" + IntegerToString(writes) + ", pending_after=" + IntegerToString(pending_after);

   if(writes>0)
     {
      g_logger.Info("Persistence","guaranteed pass | " + detail);
      return(true);
     }

   g_logger.Warn("Persistence","guaranteed pass made no forward progress | " + detail);
   ASC_WritePersistenceAudit(now,"guaranteed-persistence-no-progress",0,0,0,detail);
   return(false);
  }

void ASC_RunDispatcherPulse(void)
  {
   long started_ms=GetTickCount();
   if(g_heartbeat_running)
     {
      g_logger.Warn("Dispatcher","skipped re-entry while prior pulse was still running");
      return;
     }
   g_heartbeat_running=true;

   datetime now=TimeTradeServer();
   if(now<=0)
      now=TimeCurrent();

   g_runtime.last_heartbeat_at=now;
   g_runtime.heartbeats_since_boot++;
   g_runtime.processed_this_heartbeat=0;

   if(ASC_ExplorerTransitionLockActive(g_explorer))
     {
      bool persistence_due=ASC_HasPersistenceWorkDue(now);
      int persistence_writes=0;
      if(persistence_due)
        {
         int persistence_budget=ASC_PersistenceRecoveryBudget(now);
         if(persistence_budget>3)
            persistence_budget=3;
         if(persistence_budget<1)
            persistence_budget=1;
         persistence_writes=ASC_RunPersistenceLane(now,persistence_budget);
        }
      long lock_render_before=g_explorer.nav.last_render_tick_ms;
      ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,true,g_logger);
      if(g_explorer.nav.last_render_tick_ms!=lock_render_before)
         ASC_ExplorerMaybeReleaseTransitionLockAfterRender(g_explorer);
      ASC_SyncPreparedRuntimeMetadata();
      g_runtime.last_dispatcher_lane=ASC_LANE_HUD_RENDER;
      g_runtime.last_dispatcher_summary="HUD transition lock: frozen-state render"
         + (g_explorer.nav.transition_lock_action!="" ? " | action=" + g_explorer.nav.transition_lock_action : "")
         + (persistence_due ? " | persistence=" + IntegerToString(persistence_writes) : "");
      g_runtime.last_dispatcher_at=now;
      g_runtime.diagnostics.last_heartbeat_dispatch_ms=GetTickCount()-started_ms;
      g_prepared_buckets.diagnostics.heartbeat_dispatch_ms=g_runtime.diagnostics.last_heartbeat_dispatch_ms;
      g_heartbeat_running=false;
      return;
     }

   if(g_symbol_count==0 || (now-g_runtime.last_universe_sync_at)>=g_settings.universe_sync_seconds)
     {
      ASC_SyncUniverse();
      bool universe_persisted=ASC_RunGuaranteedPersistencePass(now,"post-universe-sync");
      g_runtime.last_dispatcher_lane=ASC_LANE_UNIVERSE_SYNC;
      g_runtime.last_dispatcher_summary=(universe_persisted ? "heavy lane: universe sync + persistence recovery" : "heavy lane: universe sync");
      g_runtime.last_dispatcher_at=now;
      g_runtime.diagnostics.last_heartbeat_dispatch_ms=GetTickCount()-started_ms;
      g_heartbeat_running=false;
      return;
     }

   if(!g_runtime.layer1_boot_complete)
     {
      ASC_RunLayer1BootAcquisition(now);
      bool boot_persisted=ASC_RunGuaranteedPersistencePass(now,"post-layer1-boot");
      long lock_render_before=g_explorer.nav.last_render_tick_ms;
      ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,true,g_logger);
      if(g_explorer.nav.last_render_tick_ms!=lock_render_before)
         ASC_ExplorerMaybeReleaseTransitionLockAfterRender(g_explorer);
      ASC_SyncPreparedRuntimeMetadata();
      if(boot_persisted)
         g_runtime.last_dispatcher_summary="heavy lane: Layer 1 boot acquisition + persistence recovery";
      g_runtime.diagnostics.last_heartbeat_dispatch_ms=GetTickCount()-started_ms;
      g_heartbeat_running=false;
      return;
     }

   ASC_UpdateLayer1Readiness();
   ASC_UpdateRuntimeMode();
   ASC_RebuildRuntimeFilterAggregates();

   if(ASC_ShortlistNeedsRebuild(now))
     {
      ASC_RebuildShortlistState();
      ASC_RefreshPreparedBucketState();
      ASC_RunPreparedLiveRefreshLane();
      g_runtime.last_dispatcher_lane=ASC_LANE_LAYER4_SHORTLIST;
      g_runtime.last_dispatcher_summary="heavy lane: Layer 4 shortlist rebuild";
      g_runtime.last_dispatcher_at=now;
      g_runtime.runtime_dirty=true;
      g_runtime.summary_dirty=true;
      bool shortlist_persisted=ASC_RunGuaranteedPersistencePass(now,"post-layer4-shortlist");
      long lock_render_before=g_explorer.nav.last_render_tick_ms;
      ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,true,g_logger);
      if(g_explorer.nav.last_render_tick_ms!=lock_render_before)
         ASC_ExplorerMaybeReleaseTransitionLockAfterRender(g_explorer);
      ASC_SyncPreparedRuntimeMetadata();
      if(shortlist_persisted)
         g_runtime.last_dispatcher_summary="heavy lane: Layer 4 shortlist rebuild + persistence recovery";
      g_runtime.diagnostics.last_heartbeat_dispatch_ms=GetTickCount()-started_ms;
      g_heartbeat_running=false;
      return;
     }

   if(ASC_ShouldRunLayer5Wave(now))
     {
      int wave_touched=ASC_RunLayer5Wave(now,25);
      g_runtime.last_dispatcher_lane=ASC_LANE_LAYER5_WAVE;
      g_runtime.last_dispatcher_summary="heavy lane: Layer 5 cadence wave=" + IntegerToString(wave_touched);
      g_runtime.last_dispatcher_at=now;
      bool wave_persisted=ASC_RunGuaranteedPersistencePass(now,"post-layer5-wave");
      ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,false,g_logger);
      ASC_SyncPreparedRuntimeMetadata();
      if(wave_persisted)
         g_runtime.last_dispatcher_summary="heavy lane: Layer 5 cadence wave=" + IntegerToString(wave_touched) + " + persistence recovery";
      g_runtime.diagnostics.last_heartbeat_dispatch_ms=GetTickCount()-started_ms;
      g_heartbeat_running=false;
      return;
     }

   int light_lanes=0;
   string lane_summary="";
   bool persistence_due=ASC_HasPersistenceWorkDue(now);
   int non_persistence_lane_cap=(persistence_due ? 2 : 3);

   int l1_touched=ASC_RunLayer1MaintenanceLane(now,ASC_Layer1MaintenanceBudget(now));
   if(l1_touched>0)
     {
      light_lanes++;
      g_runtime.processed_this_heartbeat+=l1_touched;
      lane_summary+=(lane_summary=="" ? "" : " | ") + "L1=" + IntegerToString(l1_touched);
     }

   if(light_lanes<non_persistence_lane_cap)
     {
      int l2_touched=ASC_RunLayer2BackgroundLane(now,ASC_Layer2BackgroundBudget(now));
      if(l2_touched>0)
        {
         light_lanes++;
         lane_summary+=(lane_summary=="" ? "" : " | ") + "L2bg=" + IntegerToString(l2_touched);
        }
     }

   if(light_lanes<non_persistence_lane_cap)
     {
      int l3_touched=ASC_RunLayer3Lane(ASC_Layer3Budget(now));
      if(l3_touched>0)
        {
         light_lanes++;
         lane_summary+=(lane_summary=="" ? "" : " | ") + "L3=" + IntegerToString(l3_touched);
        }
     }

   ASC_UpdateLayer1Readiness();
   ASC_UpdateRuntimeMode();
   ASC_RebuildRuntimeFilterAggregates();

   if(light_lanes<3 && persistence_due)
     {
      int writes=ASC_RunPersistenceLane(now,ASC_PersistenceRecoveryBudget(now));
      if(writes>0)
        {
         light_lanes++;
         lane_summary+=(lane_summary=="" ? "" : " | ") + "persist=" + IntegerToString(writes);
        }
     }

   if(light_lanes<non_persistence_lane_cap && ASC_RunLayer2FocusedLane())
     {
      light_lanes++;
      lane_summary+=(lane_summary=="" ? "" : " | ") + "L2focus=1@" + IntegerToString(ASC_Layer2FocusedRefreshSeconds()) + "s";
     }

   if(light_lanes<non_persistence_lane_cap && g_runtime.prepared_live_dirty && ASC_RunPreparedLiveRefreshLane())
     {
      light_lanes++;
      lane_summary+=(lane_summary=="" ? "" : " | ") + "prepared=1";
     }

   if(light_lanes<3 && !persistence_due)
     {
      int writes=ASC_RunPersistenceLane(now,ASC_PersistenceRecoveryBudget(now));
      if(writes>0)
        {
         light_lanes++;
         lane_summary+=(lane_summary=="" ? "" : " | ") + "persist=" + IntegerToString(writes);
        }
     }

   ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,false,g_logger);
   ASC_SyncPreparedRuntimeMetadata();

   g_runtime.last_dispatcher_lane=(light_lanes>0 ? ASC_LANE_LAYER1_MAINTENANCE : ASC_LANE_HUD_RENDER);
   g_runtime.last_dispatcher_summary=(lane_summary=="" ? "light lanes: idle/render-only" : "light lanes: " + lane_summary);
   g_runtime.last_dispatcher_at=now;
   g_runtime.diagnostics.last_heartbeat_dispatch_ms=GetTickCount()-started_ms;
   g_prepared_buckets.diagnostics.heartbeat_dispatch_ms=g_runtime.diagnostics.last_heartbeat_dispatch_ms;
   g_heartbeat_running=false;
  }

int OnInit()

  {
   ASC_ResetRuntimeState();
   ASC_LoadSettingsFromInputs();
   if(!ASC_ResolveServerPaths(g_paths))
      return(INIT_FAILED);

   g_logger.Configure(g_paths.log_file,g_settings.log_verbosity);
   g_runtime.boot_at=TimeCurrent();
   g_runtime.mode=ASC_RUNTIME_RECOVERING;
   g_logger.Info("Init","foundation starting on server " + g_paths.server_clean + " | layout=" + g_paths.layout_label + " | server-folder=" + g_paths.server_folder);
   ASC_LogSettingsSummary();

   ASC_RestoreContinuity();
   g_runtime.mode=ASC_RUNTIME_WARMUP;
   g_runtime.runtime_dirty=true;
   ASC_ExplorerInit(g_explorer,ChartID());
   g_logger.Info("Explorer","init chart=" + IntegerToString((int)ChartID()) + ", server=" + g_runtime.server_clean);
   ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,true,g_logger);
   ASC_SyncPreparedRuntimeMetadata();
   EventSetTimer(g_settings.heartbeat_seconds);
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
   EventKillTimer();
   g_runtime.last_heartbeat_at=TimeCurrent();
   g_runtime.runtime_dirty=true;
   g_runtime.scheduler_dirty=true;
   g_runtime.summary_dirty=true;
   ASC_SaveRuntimeState(g_paths,g_runtime,g_logger);
   if(ASC_SaveSchedulerState(g_paths,g_symbols,g_symbol_count,g_logger))
     {
      g_runtime.last_scheduler_save_at=TimeCurrent();
      g_runtime.scheduler_dirty=false;
     }
   ASC_SaveSummary(g_paths,g_runtime,g_symbols,g_symbol_count,g_logger);
   ASC_WritePersistenceAudit(TimeCurrent(),"deinit",0,0,0,"final flush during shutdown");
   g_logger.Info("Explorer","shutdown server=" + g_runtime.server_clean);
   ASC_ExplorerShutdown(g_explorer);
   g_logger.Info("Deinit","foundation stopping with reason " + IntegerToString(reason));
  }

void OnTick() { }

void OnTimer()
  {
   ASC_RunDispatcherPulse();
  }

void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      int chart_w=(int)ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
      int chart_h=(int)ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0);
      bool size_changed=(chart_w!=g_explorer.cached_chart_width || chart_h!=g_explorer.cached_chart_height);
      if(size_changed || g_explorer.layout_dirty)
        {
         ASC_ExplorerInvalidateLayout(g_explorer);
         ASC_ExplorerInvalidateObjectRegistry(g_explorer);
         g_explorer.nav.dirty=true;
        }
      return;
     }

   if(id!=CHARTEVENT_OBJECT_CLICK)
      return;
   if(StringFind(sparam,ASC_HUD_PREFIX)!=0)
      return;

   ASC_ExplorerHandleAction(g_explorer,g_settings,g_runtime,g_prepared_buckets,sparam,g_symbols,g_symbol_count,g_logger);
   ASC_ExplorerMaybeRender(g_explorer,g_settings,g_runtime,g_prepared_buckets,g_symbols,g_symbol_count,true,g_logger);
   ASC_SyncPreparedRuntimeMetadata();
  }
