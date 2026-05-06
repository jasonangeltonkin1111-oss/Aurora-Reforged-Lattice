#property strict


#include "core/ASC_Version.mqh"
#include "core/ASC_Constants.mqh"
#include "core/ASC_RuntimeState.mqh"
#include "menu/ASC_TraderControlRegistry.mqh"
#include "runtime/ASC_Bootstrap.mqh"
#include "runtime/ASC_RuntimeClock.mqh"
#include "runtime/ASC_Dispatcher.mqh"
#include "artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh"
#include "logging/ASC_Logging.mqh"
#include "hud/ASC_HUD_Manager.mqh"

input string InpGroup_HUD_Display                = "1. HUD & Display";
input bool   InpHudEnabled                       = ASC_HUD_ENABLED_DEFAULT;
input int    InpHudDensityMode                   = 1;
input int    InpHudRowsOverride                  = 0;
input bool   InpHudShowHealthStrip               = true;
input bool   InpHudShowSourceLabels              = true;
input bool   InpHudVerboseProof                  = false;
input bool   InpHudParityDiagnosticsEnabled      = false;
input string InpHudBrowseMainBucketFilter        = "all";
input string InpHudBrowseStockFamilyFilter       = "all";
input string InpHudBrowseStockSectorFilter       = "all";
input string InpHudBrowseStockIndustryFilter     = "all";

input string InpGroup_MarketBoard                = "2. Market Board";
input int    InpBoardTopN                        = 10;
input bool   InpBoardShowFreshness               = true;
input bool   InpBoardShowClassification          = true;

input string InpGroup_CurrentFocus_Dossier       = "3-4. Current Focus + Dossier";
input bool   InpCurrentFocusShowClassification   = true;
input bool   InpCurrentFocusShowFreshness        = true;
input bool   InpDossierShowIdentity              = true;
input bool   InpDossierShowMarketState           = true;
input bool   InpDossierShowFreshness             = true;
input bool   InpDossierShowClassification        = true;
input bool   InpDossierShowDeepSelectiveAnalysis          = true;

input string InpGroup_MarketState         = "5. Market State";
input int    InpMarketStateTickFreshnessSec               = ASC_L1_TICK_FRESHNESS_SEC;
input int    InpMarketStateStaleAgeSec                    = ASC_L1_STALE_AGE_SEC;
input int    InpMarketStateRecheckOpenSec                 = ASC_L1_RECHECK_OPEN_SEC;
input int    InpMarketStateRecheckClosedSec               = ASC_L1_RECHECK_CLOSED_SEC;
input int    InpMarketStateRecheckUncertainSec            = ASC_L1_RECHECK_UNCERTAIN_SEC;
input int    InpMarketStateRecheckUnknownSec              = ASC_L1_RECHECK_UNKNOWN_SEC;
input int    InpMarketStateConfirmationRetryCap           = ASC_L1_CONFIRMATION_RETRY_CAP;
input int    InpMarketStateWarmupUnknownMax               = ASC_L1_WARMUP_UNKNOWN_MAX;
input int    InpMarketStateWarmupUncertainMax             = ASC_L1_WARMUP_UNCERTAIN_MAX;
input int    InpMarketStateReadyUnknownMax                = ASC_L1_READY_UNKNOWN_MAX;
input int    InpMarketStateReadyUncertainMax              = ASC_L1_READY_UNCERTAIN_MAX;
input int    InpMarketStateStaleSymbolMax                 = ASC_L1_STALE_SYMBOL_MAX;

input string InpGroup_DeepSelectiveAnalysis                = "9. Deep Selective Analysis (Manual Only)";
input int    InpDeepTF_M1_Bars                   = 350;
input int    InpDeepTF_M5_Bars                   = 350;
input int    InpDeepTF_M15_Bars                  = 350;
input int    InpDeepTF_H1_Bars                   = 150;
input int    InpDeepTF_H4_Bars                   = 150;
input int    InpDeepTF_D1_Bars                   = 150;
input int    InpDeepRecentTickWindow             = 128;
input int    InpDeepRollingSpreadWindow          = 64;

input string InpGroup_Advanced                    = "10. Advanced Controls";
input int    InpScanBudgetSymbols                = ASC_SCAN_SYMBOL_BUDGET;
input int    InpL1PacketTarget                   = ASC_L1_BROAD_PACKET_TARGET;
input int    InpL1BurstMaxPerHeartbeat           = ASC_L1_BURST_MAX_PER_HEARTBEAT;
input int    InpWriteBudgetArtifacts             = ASC_WRITE_ARTIFACT_BUDGET;
input int    InpWriteStarvationBeats             = ASC_WRITE_STARVATION_BEATS;
input int    InpPartialWriteMinAssessed          = ASC_PARTIAL_WRITE_MIN_ASSESSED;
input int    InpL1PartialWriteBeats              = ASC_L1_PARTIAL_WRITE_BEATS;


ASC_RuntimeState g_runtime_state;
ulong g_timer_enter_count = 0;
ulong g_timer_priority_render_served_before_heartbeat_count = 0;
ulong g_timer_runtime_heartbeat_count = 0;
ulong g_timer_hud_heartbeat_after_runtime_count = 0;
ulong g_timer_hud_heartbeat_skipped_priority_served_count = 0;
ulong g_timer_elapsed_last_ms = 0;
ulong g_timer_elapsed_max_ms = 0;
ulong g_timer_elapsed_over_budget_count = 0;
ulong g_timer_result_last_file_log_heartbeat = 0;
ulong g_timer_telemetry_last_logged_over_budget_count = 0;

#define ASC_TIMER_TELEMETRY_SAMPLE_HEARTBEATS 900
#define ASC_HEARTBEAT_RESULT_SAMPLE_HEARTBEATS 900
#define ASC_RUN147_TIMER_PRESSURE_COMPRESSION "unchanged_ok_timer_and_heartbeat_rows_sampled_every_900_heartbeats_failures_state_changes_budget_pressure_preserved"

bool ASC_ShouldEmitTimerTelemetry(const bool hud_priority_served,
                                  const bool hud_pending_render,
                                  const ulong elapsed_ms,
                                  const int heartbeat_budget_ms)
  {
   if(g_timer_enter_count <= 1)
      return true;
   if(elapsed_ms > (ulong)heartbeat_budget_ms)
      return true;
   if(g_timer_elapsed_over_budget_count != g_timer_telemetry_last_logged_over_budget_count)
      return true;
   if(hud_priority_served || hud_pending_render)
      return true;
   if(ASC_TIMER_TELEMETRY_SAMPLE_HEARTBEATS > 0
      && (g_timer_enter_count % ASC_TIMER_TELEMETRY_SAMPLE_HEARTBEATS) == 0)
      return true;
   return false;
  }

bool ASC_ShouldEmitHeartbeatResult(const ASC_FunctionResult &result,
                                   const bool hud_priority_served,
                                   const bool hud_pending_render,
                                   const ulong elapsed_ms,
                                   const int heartbeat_budget_ms)
  {
   if(result.state != ASC_RESULT_OK || result.code != ASC_RC_OK)
      return true;
   if(elapsed_ms > (ulong)heartbeat_budget_ms)
      return true;
   if(hud_priority_served || hud_pending_render)
      return true;
   if(g_timer_runtime_heartbeat_count <= 1)
      return true;
   if(ASC_HEARTBEAT_RESULT_SAMPLE_HEARTBEATS > 0
      && (g_timer_runtime_heartbeat_count % ASC_HEARTBEAT_RESULT_SAMPLE_HEARTBEATS) == 0)
      return true;
   return false;
  }

void ASC_LoadTraderControlsFromInputs(ASC_TraderControls &controls)
  {
   ASC_DefaultTraderControls(controls);

   controls.hud_enabled = InpHudEnabled;
   controls.hud_density_mode = InpHudDensityMode;
   controls.hud_rows_override = InpHudRowsOverride;
   controls.hud_show_health_strip = InpHudShowHealthStrip;
   controls.hud_show_source_labels = InpHudShowSourceLabels;
   controls.hud_verbose_proof = InpHudVerboseProof;
   controls.hud_parity_diagnostics_enabled = InpHudParityDiagnosticsEnabled;
   controls.browse_main_bucket_filter = InpHudBrowseMainBucketFilter;
   controls.browse_stock_family_filter = InpHudBrowseStockFamilyFilter;
   controls.browse_stock_sector_filter = InpHudBrowseStockSectorFilter;
   controls.browse_stock_industry_filter = InpHudBrowseStockIndustryFilter;

   controls.board_top_n = InpBoardTopN;
   controls.board_show_freshness = InpBoardShowFreshness;
   controls.board_show_classification = InpBoardShowClassification;

   controls.current_focus_show_classification = InpCurrentFocusShowClassification;
   controls.current_focus_show_freshness = InpCurrentFocusShowFreshness;
   controls.dossier_show_identity = InpDossierShowIdentity;
   controls.dossier_show_market_state = InpDossierShowMarketState;
   controls.dossier_show_freshness = InpDossierShowFreshness;
   controls.dossier_show_classification = InpDossierShowClassification;
   controls.dossier_show_deep_selective_analysis = InpDossierShowDeepSelectiveAnalysis;

   controls.l1_tick_freshness_sec = InpMarketStateTickFreshnessSec;
   controls.l1_stale_age_sec = InpMarketStateStaleAgeSec;
   controls.l1_recheck_open_sec = InpMarketStateRecheckOpenSec;
   controls.l1_recheck_closed_sec = InpMarketStateRecheckClosedSec;
   controls.l1_recheck_uncertain_sec = InpMarketStateRecheckUncertainSec;
   controls.l1_recheck_unknown_sec = InpMarketStateRecheckUnknownSec;
   controls.l1_confirmation_retry_cap = InpMarketStateConfirmationRetryCap;
   controls.l1_warmup_unknown_max = InpMarketStateWarmupUnknownMax;
   controls.l1_warmup_uncertain_max = InpMarketStateWarmupUncertainMax;
   controls.l1_ready_unknown_max = InpMarketStateReadyUnknownMax;
   controls.l1_ready_uncertain_max = InpMarketStateReadyUncertainMax;
   controls.l1_stale_symbol_max = InpMarketStateStaleSymbolMax;

   controls.deep_tf_m1_bars = InpDeepTF_M1_Bars;
   controls.deep_tf_m5_bars = InpDeepTF_M5_Bars;
   controls.deep_tf_m15_bars = InpDeepTF_M15_Bars;
   controls.deep_tf_h1_bars = InpDeepTF_H1_Bars;
   controls.deep_tf_h4_bars = InpDeepTF_H4_Bars;
   controls.deep_tf_d1_bars = InpDeepTF_D1_Bars;
   controls.deep_recent_tick_window = InpDeepRecentTickWindow;
   controls.deep_rolling_spread_window = InpDeepRollingSpreadWindow;

   controls.scan_budget_symbols = InpScanBudgetSymbols;
   controls.l1_packet_target = InpL1PacketTarget;
   controls.l1_burst_max_per_heartbeat = InpL1BurstMaxPerHeartbeat;
   controls.write_budget_artifacts = InpWriteBudgetArtifacts;
   controls.write_starvation_beats = InpWriteStarvationBeats;
   controls.partial_write_min_assessed = InpPartialWriteMinAssessed;
   controls.l1_partial_write_beats = InpL1PartialWriteBeats;

   ASC_NormalizeTraderControls(controls);
  }

int OnInit(void)
  {
   ASC_ResetRuntimeState(g_runtime_state);

   ASC_TraderControls controls;
   ASC_LoadTraderControlsFromInputs(controls);
   ASC_ApplyTraderControls(controls);

   ASC_LogInfo("AuroraSentinelCore", "OnInit", "global", "Runtime boot starting.");

   ASC_FunctionResult init_result = ASC_BootstrapRuntime(g_runtime_state);
   ASC_LogFunctionResult(init_result);

   if(init_result.state != ASC_RESULT_OK)
      return INIT_FAILED;

   if(!EventSetTimer(ASC_HEARTBEAT_SECONDS))
     {
      g_runtime_state.posture = ASC_RUNTIME_DEGRADED;
      ASC_LogInfo("AuroraSentinelCore", "OnInit", "global", "Failed to start heartbeat timer.");
      return INIT_FAILED;
     }

   ASC_HudInit();
   if(!g_asc_trader_controls.hud_enabled)
      ASC_LogInfo("AuroraSentinelCore", "OnInit", "global", "hud_runtime_enabled=false operator_primary_surface=dossier_folder hud_repair_deferred=true");
   ASC_LogInfo("AuroraSentinelCore", "OnInit", "global", "Runtime boot complete and heartbeat timer active.");
   return INIT_SUCCEEDED;
  }

void OnDeinit(const int reason)
  {
   EventKillTimer();
   ASC_HudShutdown();
   g_runtime_state.posture = ASC_RUNTIME_STOPPED;
   string message = StringFormat("Runtime deinit. reason=%d", reason);
   ASC_LogInfo("AuroraSentinelCore", "OnDeinit", "global", message);
  }

void OnTick()
  {
   g_runtime_state.last_tick_utc = ASC_RuntimeUtcNow();
   // Tick path remains quote-card micro refresh only when HUD runtime is explicitly enabled.
   // RUN141R dossier-first mode prevents HUD micro-refresh/redraw work by default.
   if(g_asc_trader_controls.hud_enabled)
     {
      ASC_HudRefreshSelectedSymbolMicroLive();
      ASC_HudFlushPendingRedraw();
     }
  }

void OnTimer()
  {
   g_timer_enter_count++;
   ulong timer_started_us = GetMicrosecondCount();

   bool hud_priority_served = false;
   datetime now_utc = ASC_RuntimeUtcNow();
   bool hud_runtime_enabled = g_asc_trader_controls.hud_enabled;
   bool hud_pending_render = false;
   if(hud_runtime_enabled)
     {
      hud_pending_render = ASC_HudPriorityServicePending();
      if(g_runtime_state.ui_priority_until_utc >= now_utc && hud_pending_render)
        {
         hud_priority_served = ASC_HudServicePriorityNavigation(g_runtime_state);
         if(hud_priority_served)
            g_timer_priority_render_served_before_heartbeat_count++;
        }
      hud_pending_render = ASC_HudPriorityServicePending();
     }

   g_timer_runtime_heartbeat_count++;
   ASC_FunctionResult beat_result = ASC_RunHeartbeat(g_runtime_state, hud_priority_served, hud_pending_render);
   if(hud_runtime_enabled)
     {
      if(!hud_priority_served)
        {
         g_timer_hud_heartbeat_after_runtime_count++;
         ASC_HudServiceDeferredCurrentFocusWork(g_runtime_state, true, "heartbeat_background");
         ASC_HudOnHeartbeat(g_runtime_state);
        }
      else
        {
         g_timer_hud_heartbeat_skipped_priority_served_count++;
         ASC_HudFlushPendingRedraw();
        }
     }
   ulong elapsed_ms = (GetMicrosecondCount() - timer_started_us) / 1000;
   g_timer_elapsed_last_ms = elapsed_ms;
   if(elapsed_ms > g_timer_elapsed_max_ms)
      g_timer_elapsed_max_ms = elapsed_ms;
   int heartbeat_budget_ms = ASC_HEARTBEAT_SECONDS * 1000;
   if(elapsed_ms > (ulong)heartbeat_budget_ms)
      g_timer_elapsed_over_budget_count++;

   bool heartbeat_result_due = ASC_ShouldEmitHeartbeatResult(beat_result, hud_priority_served, hud_pending_render, elapsed_ms, heartbeat_budget_ms);
   if(heartbeat_result_due)
     {
      ASC_LogFunctionResult(beat_result);
      if(StringLen(g_runtime_state.function_results_log_path) > 0)
        {
         ASC_LogFunctionResultToFile(beat_result, g_runtime_state.function_results_log_path);
         g_timer_result_last_file_log_heartbeat = g_timer_runtime_heartbeat_count;
        }
     }

   if(ASC_ShouldEmitTimerTelemetry(hud_priority_served, hud_pending_render, elapsed_ms, heartbeat_budget_ms))
     {
      string telemetry_message = "timer_telemetry";
      telemetry_message += " enter=" + IntegerToString((long)g_timer_enter_count);
      telemetry_message += " sample_hb=" + IntegerToString(ASC_TIMER_TELEMETRY_SAMPLE_HEARTBEATS);
      telemetry_message += " result_sample_hb=" + IntegerToString(ASC_HEARTBEAT_RESULT_SAMPLE_HEARTBEATS);
      telemetry_message += " compression=RUN147_ok_unchanged_sample_900_failures_budget_pressure_preserved";
      telemetry_message += " result_last_file_hb=" + IntegerToString((long)g_timer_result_last_file_log_heartbeat);
      telemetry_message += " priority_before_heartbeat=" + IntegerToString((long)g_timer_priority_render_served_before_heartbeat_count);
      telemetry_message += " runtime_heartbeat=" + IntegerToString((long)g_timer_runtime_heartbeat_count);
      telemetry_message += " hud_heartbeat=" + IntegerToString((long)g_timer_hud_heartbeat_after_runtime_count);
      telemetry_message += " hud_skipped_priority=" + IntegerToString((long)g_timer_hud_heartbeat_skipped_priority_served_count);
      telemetry_message += " elapsed_last_ms=" + IntegerToString((long)g_timer_elapsed_last_ms);
      telemetry_message += " elapsed_max_ms=" + IntegerToString((long)g_timer_elapsed_max_ms);
      telemetry_message += " over_budget=" + IntegerToString((long)g_timer_elapsed_over_budget_count);
      telemetry_message += " budget_ms=" + IntegerToString(heartbeat_budget_ms);
      ASC_LogInfo("AuroraSentinelCore", "OnTimer", "global", telemetry_message);
      g_timer_telemetry_last_logged_over_budget_count = g_timer_elapsed_over_budget_count;
     }
  }

void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if(!g_asc_trader_controls.hud_enabled)
      return;

   datetime now_utc = ASC_RuntimeUtcNow();
   bool hud_click_event = (id == CHARTEVENT_OBJECT_CLICK && StringFind(sparam, ASC_HUD_PREFIX) == 0);
   bool chart_resize_event = (id == CHARTEVENT_CHART_CHANGE);
   g_runtime_state.last_chart_event_utc = now_utc;
   if(hud_click_event || chart_resize_event)
      g_runtime_state.ui_priority_until_utc = now_utc + ASC_UI_PRIORITY_INTERACTION_WINDOW_SEC;
   ASC_HudOnChartEvent(id, lparam, dparam, sparam, g_runtime_state);
  }
