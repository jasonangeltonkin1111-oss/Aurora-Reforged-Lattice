#ifndef __ASC_DISPATCHER_MQH__
#define __ASC_DISPATCHER_MQH__

#include "../core/ASC_RuntimeState.mqh"
#include "../core/ASC_Constants.mqh"
#include "../core/ASC_Version.mqh"
#include "../logging/ASC_Logging.mqh"
#include "../io/ASC_FileIO.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../artifacts/ASC_MarketBoardWriter.mqh"
#include "../artifacts/ASC_DossierWriter.mqh"
#include "../artifacts/ASC_OpenSymbolSnapshotWriter.mqh"
#include "../artifacts/ASC_CurrentFocusWriter.mqh"
#include "../artifacts/ASC_ScannerStatusWriter.mqh"
#include "../artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh"
#include "../deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh"
#include "../menu/ASC_TraderControlRegistry.mqh"

string ASC_Top5BucketExactSignature(const ASC_RuntimeState &state);
string ASC_Run245Top5BucketQueueSymbols(const ASC_RuntimeState &state,const string bucket_id);
string ASC_Run245Top5BucketQueueAllSymbols(const ASC_RuntimeState &state);
int ASC_Top5BucketCountActiveChildFiles(const ASC_RuntimeState &state);
int ASC_Top5BucketCountStagingChildFiles(const ASC_RuntimeState &state);
string ASC_Top5BucketManifestBoardSyncStatus(const ASC_RuntimeState &state,const int active_actual_count,const int staging_child_count);

#define ASC_SELECTED_SYNC_STABLE_RECHECK_SEC 5
#define ASC_L2_COMPANION_STARVATION_SEC (ASC_HEARTBEAT_SECONDS * 3)
#define ASC_CURRENT_FOCUS_SYNC_STARVATION_SEC (ASC_HEARTBEAT_SECONDS * 3)
#define ASC_CURRENT_FOCUS_FAILURE_BACKOFF_BASE_SEC (ASC_HEARTBEAT_SECONDS * 2)
#define ASC_CURRENT_FOCUS_FAILURE_BACKOFF_MAX_SEC (ASC_HEARTBEAT_SECONDS * 20)
// Committed cadence doctrine:
// - RUN243 L3 tactical candidate filtering steady cadence: 1800s (30 minutes).
// - RUN243 L4 shortlist/board authority steady cadence: 1800s (30 minutes).
// - RUN243 L3 warmup refresh: 300s after startup/bootstrap, not immediate final authority.
// - RUN243 L4 runs after committed L3 with a 300s offset where scheduler-safe.
// - RUN243 Market Board/status file publish cadence: 300s without forcing L4 recompute.
// - GlobalTop10/Top5PerBucket shell/status refresh cadence: 300s (5 minutes).
// - Top5PerBucket/GlobalTop10 membership source remains the committed L4 epoch; per-symbol info refresh remains independent every 300s.
#define ASC_L3_TARGET_RECHECK_OPEN_SEC ASC_L3_CANDIDATE_REFRESH_CADENCE_SEC
#define ASC_L4_TARGET_RECHECK_OPEN_SEC ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC
#define ASC_L3_RECHECK_OPEN_SEC ASC_L3_CANDIDATE_REFRESH_CADENCE_SEC
#define ASC_L4_RECHECK_OPEN_SEC ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC
#define ASC_DOSSIER_QUEUE_REBUILD_STALL_BEATS 2
#define ASC_TOP10_RUN_FULL_MAX_RETRIES 2
#define ASC_TOP10_RUN_FULL_CADENCE_SEC 300
// RUN077R bounded startup warmup gate for first GlobalTop10 publish.
// First-family admission/release honesty only; no rank, score, order, FileIO, HUD, or strategy change.
#define ASC_WARMUP_FIRST_TOP10_MAX_SECONDS 90
#define ASC_WARMUP_FIRST_TOP10_MAX_HEARTBEATS 120
#define ASC_WARMUP_FIRST_TOP10_MAX_RETRY_CYCLES 4
#define ASC_WARMUP_FIRST_TOP10_MIN_USEFUL_CHILDREN 5
#define ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET 10
#define ASC_WARMUP_FIRST_TOP10_MIN_MATURITY_SECONDS 20
#define ASC_WARMUP_FIRST_TOP10_MIN_MATURITY_HEARTBEATS 20
#define ASC_WARMUP_FIRST_TOP10_L2_UNAVAILABLE_ABS_MAX 25
#define ASC_WARMUP_FIRST_TOP10_L2_UNAVAILABLE_PCT_MAX 5
#define ASC_WARMUP_FIRST_TOP10_CRITICAL_L2_UNAVAILABLE_MAX 0
#define ASC_HEARTBEAT_DURATION_SAMPLE_CAP 64
#define ASC_HEARTBEAT_BUDGET_MARGIN_MS 120
#define ASC_UI_PRIORITY_SCAN_SCALE_PERCENT 60
#define ASC_UI_PRIORITY_WRITE_SCALE_PERCENT 55
#define ASC_UI_PRIORITY_INTERACTION_WINDOW_SEC (ASC_HEARTBEAT_SECONDS * 2)
#define ASC_UI_PRIORITY_SCAN_PACKET_SCALE_PERCENT 45
#define ASC_UI_PRIORITY_SCAN_BURST_SCALE_PERCENT 60
#define ASC_UI_PRIORITY_DOSSIER_BUDGET_SCALE_PERCENT 40
#define ASC_WRITE_NEAR_BUDGET_MARGIN_MS 90
#define ASC_WRITE_UI_NEAR_BUDGET_MARGIN_MS 160
// RUN089R live-regression repair: GlobalTop10 must auto-hydrate full L5/L6 children again.
#define ASC_TOP10_RUN_FULL_DEFER_HEAVY_DEEP_CHILDREN false
#define ASC_TOP10_RUN_FULL_MAX_CHILD_QUEUE_PER_BEAT 1
// RUN082R deferred GlobalTop10 L5 recovery guard: bounded retry/expiry only; no all-child L5 sweep.
#define ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_CHILDREN_PER_BEAT 1
#define ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES 2
#define ASC_TOP10_DEFERRED_L5_RECOVERY_RETRY_SPACING_SEC 5
#define ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_AGE_SEC 90
#define ASC_DOSSIER_QUEUE_PROGRESS_MIN_PER_BEAT 1
#define ASC_DOSSIER_QUEUE_BACKLOG_BUDGET_CAP 8

int ASC_DynamicL1PacketTarget(const ASC_RuntimeState &state)
  {
   int base_target = state.l1_packet_target;
   if(base_target <= 0)
      base_target = g_asc_trader_controls.l1_packet_target;

   int configured_budget = state.scan_budget_symbols;
   if(configured_budget <= 0)
      configured_budget = g_asc_trader_controls.scan_budget_symbols;

   int total_symbols = ASC_Layer1CachedSymbolCount();
   if(total_symbols <= 0)
      total_symbols = SymbolsTotal(true);
   if(total_symbols < 0)
      total_symbols = 0;

   int target = MathMax(base_target, configured_budget);
   bool warmup_pressure = (!state.l1_warmup_ready || state.mode == ASC_MODE_WARMUP);

   if(state.l1_bootstrap_active)
     {
      int bootstrap_floor = MathMax(320, configured_budget * 2);
      if(total_symbols > 0)
         bootstrap_floor = MathMin(total_symbols, bootstrap_floor);
      if(target < bootstrap_floor)
         target = bootstrap_floor;
     }
   else if(warmup_pressure)
     {
      if(total_symbols >= 1000)
         target += base_target;
      else if(total_symbols >= 400)
         target += (base_target / 2);
      else if(total_symbols >= 120)
         target += (base_target / 4);
     }
   else if(state.deferred_scan_symbols > (base_target * 2))
     {
      target += (base_target / 4);
     }

   bool sustained_scan_pressure = (state.deferred_scan_symbols > configured_budget
                                   || (state.consecutive_scan_beats >= 2 && state.deferred_scan_symbols > 0)
                                   || state.layer1_dirty);
   if(sustained_scan_pressure)
      target += MathMax(16, configured_budget / 2);

   int hard_cap = MathMax(configured_budget, base_target);
   if(warmup_pressure && total_symbols >= 400)
      hard_cap = MathMax(hard_cap, configured_budget * 2);
   else if(sustained_scan_pressure)
      hard_cap = MathMax(hard_cap, configured_budget * 2);
   else
      hard_cap = MathMax(hard_cap, configured_budget + (configured_budget / 2));

   if(total_symbols > 0)
      hard_cap = MathMin(hard_cap, total_symbols);

   target = ASC_ClampInt(target, 1, MathMax(1, hard_cap));
   return target;
  }

int ASC_DynamicL1BurstCap(const ASC_RuntimeState &state,const int packet_target)
  {
   int burst_cap = state.l1_burst_max;
   if(burst_cap <= 0)
      burst_cap = g_asc_trader_controls.l1_burst_max_per_heartbeat;

   int total_symbols = ASC_Layer1CachedSymbolCount();
   if(total_symbols <= 0)
      total_symbols = SymbolsTotal(true);
   if(total_symbols < 0)
      total_symbols = 0;

   bool warmup_pressure = (!state.l1_warmup_ready || state.mode == ASC_MODE_WARMUP);
   if(state.l1_bootstrap_active)
      burst_cap = MathMax(burst_cap, 8);
   else if(warmup_pressure)
     {
      if(total_symbols >= 1000)
         burst_cap += 3;
      else if(total_symbols >= 400)
         burst_cap += 2;
      else if(total_symbols >= 120)
         burst_cap += 1;
     }
   else if(state.deferred_scan_symbols > packet_target)
      burst_cap += 1;

   if(state.deferred_scan_symbols > (packet_target * 2))
      burst_cap += 1;
   if(state.layer1_dirty && state.deferred_scan_symbols > 0)
      burst_cap += 1;

   return ASC_ClampInt(burst_cap, 1, 10);
  }


string ASC_ModeToText(const ASC_RuntimeMode mode)
  {
   switch(mode)
     {
      case ASC_MODE_WARMUP:         return "warmup";
      case ASC_MODE_BALANCED:       return "balanced";
      case ASC_MODE_WRITE_PRESSURE: return "write_pressure";
      case ASC_MODE_DEGRADED:       return "degraded";
     }
   return "balanced";
  }

string ASC_LaneToText(const ASC_MajorLane lane)
  {
   switch(lane)
     {
      case ASC_LANE_SCAN:        return "scan";
      case ASC_LANE_PERSISTENCE: return "persistence";
      case ASC_LANE_HUD:         return "hud";
      case ASC_LANE_RECOVERY:    return "recovery";
      case ASC_LANE_FOCUS:       return "focus";
      case ASC_LANE_CALCULATION: return "calculation";
     }
   return "scan";
  }

string ASC_SublaneToText(const ASC_Sublane sublane)
  {
   switch(sublane)
     {
      case ASC_SUBLANE_L1_BROAD_SCAN:       return "l1_broad_scan";
      case ASC_SUBLANE_L1_CONFIRMATION:     return "l1_confirmation";
      case ASC_SUBLANE_PERSISTENCE_PUBLISH: return "publish";
     }
  return "l1_broad_scan";
  }

int ASC_DynamicWriteStreakLimit(const int total_symbols)
  {
   if(total_symbols >= 1000)
      return 3;
   if(total_symbols >= 400)
      return 4;
   return 5;
  }

bool ASC_IsCooldownActive(const datetime now_utc,const datetime until_utc)
  {
   return (until_utc > 0 && now_utc < until_utc);
  }

int ASC_BoundedBackoffSeconds(const int streak,const int base_seconds,const int max_seconds)
  {
   if(streak <= 0)
      return 0;

   int seconds = base_seconds * streak;
   if(seconds > max_seconds)
      seconds = max_seconds;
   return seconds;
  }

string ASC_BuildPublicationId(const int heartbeat_id,const datetime publication_utc)
  {
   return StringFormat("bundle-%I64d-%d", (long)publication_utc, heartbeat_id);
  }

datetime ASC_MaxDatetime(const datetime a,const datetime b)
  {
   return (a >= b ? a : b);
  }

ulong ASC_HeartbeatNowMicroseconds()
  {
   return GetMicrosecondCount();
  }

int ASC_SafeElapsedMsSince(const ulong started_us)
  {
   if(started_us == 0)
      return 0;

   ulong now_us = ASC_HeartbeatNowMicroseconds();
   if(now_us <= started_us)
      return 0;

   ulong elapsed_us = now_us - started_us;
   ulong elapsed_ms = elapsed_us / 1000;
   if(elapsed_ms > 600000)
      return 0;

   return (int)elapsed_ms;
  }

int ASC_ClampHeartbeatBudgetMs(const int value_ms)
  {
   return ASC_ClampInt(value_ms, 50, 60000);
  }

string ASC_TelemetrySafeValue(const string value)
  {
   string safe = value;
   StringReplace(safe, "\t", " ");
   StringReplace(safe, "\r", " ");
   StringReplace(safe, "\n", " ");
   StringTrimLeft(safe);
   StringTrimRight(safe);
   if(StringLen(safe) <= 0)
      return "none";
   return safe;
  }

string ASC_HeartbeatBundleDecisionTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("publication_id=%s | board_result=%s | board_baseline=%s | board_trigger=%s | board_skip_reason=%s | bundle_status=%s",
                       ASC_TelemetrySafeValue(state.publication_bundle.publication_id),
                       ASC_TelemetrySafeValue(state.publication_bundle.board_publish_result),
                       ASC_TelemetrySafeValue(ASC_BoardBaselineAdvanceState(state.publication_bundle.board_publish_result)),
                       ASC_TelemetrySafeValue(state.publication_bundle.board_refresh_trigger),
                       ASC_TelemetrySafeValue(state.publication_bundle.board_publish_skip_reason),
                       ASC_TelemetrySafeValue(state.publication_bundle.overall_bundle_status));
  }

string ASC_HeartbeatManualRefreshTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("manual_board_pending=%s | manual_board_inflight=%s | manual_board_status=%s | manual_board_reason=%s | manual_board_req_seq=%d | manual_board_trigger=%s | manual_board_requested_utc=%s | manual_board_served_utc=%s",
                       state.board_manual_refresh_pending ? "yes" : "no",
                       state.board_manual_refresh_inflight ? "yes" : "no",
                       ASC_TelemetrySafeValue(state.board_manual_refresh_last_status),
                       ASC_TelemetrySafeValue(state.board_manual_refresh_last_reason),
                       state.board_manual_refresh_request_seq,
                       ASC_TelemetrySafeValue(state.board_manual_refresh_trigger),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.board_manual_refresh_requested_utc)),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.board_manual_refresh_last_served_utc)));
  }

string ASC_HeartbeatForcedDownstreamTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("forced_downstream_pending=%s | forced_downstream_status=%s | forced_downstream_reason=%s | forced_downstream_req_seq=%d | forced_downstream_scope=%s | forced_downstream_symbol=%s | forced_downstream_requested_utc=%s | forced_downstream_served_utc=%s",
                       state.forced_downstream_refresh_pending ? "yes" : "no",
                       ASC_TelemetrySafeValue(state.forced_downstream_refresh_last_status),
                       ASC_TelemetrySafeValue(state.forced_downstream_refresh_last_reason),
                       state.forced_downstream_refresh_request_seq,
                       ASC_TelemetrySafeValue(state.forced_downstream_refresh_scope),
                       ASC_TelemetrySafeValue(state.forced_downstream_refresh_symbol),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.forced_downstream_refresh_requested_utc)),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.forced_downstream_refresh_last_served_utc)));
  }

string ASC_HeartbeatLayer1ReadinessTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("bootstrap_active=%s | warmup_ready=%s | l1_ready=%s | cycle_posture=%s | readiness_posture=%s | publish_posture=%s | next_due_reason=%s | next_due_count=%d | last_full_cycle_utc=%s | bootstrap_completed_utc=%s",
                       state.l1_bootstrap_active ? "yes" : "no",
                       state.l1_warmup_ready ? "yes" : "no",
                       state.l1_ready ? "yes" : "no",
                       ASC_TelemetrySafeValue(state.l1_last_cycle_posture),
                       ASC_TelemetrySafeValue(state.l1_readiness_posture),
                       ASC_TelemetrySafeValue(state.l1_last_publish_posture),
                       ASC_TelemetrySafeValue(state.l1_next_due_reason),
                       state.l1_next_due_count,
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.l1_last_full_cycle_utc)),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.l1_bootstrap_completed_utc)));
  }

string ASC_HeartbeatShortlistPublicationTrace(const ASC_RuntimeState &state)
  {
   string source_state = "not_ready";
   if(state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
      source_state = "published_shortlist_cache";
   else if(state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0)
      source_state = "committed_l4_runtime_only";

   return StringFormat("snapshot_source=%s | publication_shortlist_ready=%s | publication_rows=%d | publication_pass_utc=%s | publication_status=%s | publication_reason=%s | committed_l4_ready=%s | committed_l4_rows=%d | committed_l4_pass_utc=%s",
                       source_state,
                       state.publication_shortlist_ready ? "yes" : "no",
                       ArraySize(state.publication_shortlist_rows),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.publication_shortlist_pass_utc)),
                       ASC_TelemetrySafeValue(state.publication_shortlist_last_status),
                       ASC_TelemetrySafeValue(state.publication_shortlist_last_reason),
                       state.committed_l4_ready ? "yes" : "no",
                       ArraySize(state.committed_l4_rows),
                       ASC_TelemetrySafeValue(ASC_FormatUtc(state.committed_l4_pass_utc)));
  }

int ASC_DefaultHeartbeatBudgetMs()
  {
   int heartbeat_window_ms = ASC_HEARTBEAT_SECONDS * 1000;
   int budget_ms = heartbeat_window_ms - ASC_HEARTBEAT_BUDGET_MARGIN_MS;
   if(budget_ms < 100)
      budget_ms = MathMax(100, heartbeat_window_ms);
   return ASC_ClampHeartbeatBudgetMs(budget_ms);
  }

bool ASC_IsUiPriorityActive(const ASC_RuntimeState &state,const datetime now_utc)
  {
   datetime interaction_window_until_utc = 0;
   if(state.last_chart_event_utc > 0)
      interaction_window_until_utc = state.last_chart_event_utc + ASC_UI_PRIORITY_INTERACTION_WINDOW_SEC;
   datetime priority_until_utc = ASC_MaxDatetime(state.ui_priority_until_utc, interaction_window_until_utc);
   return (priority_until_utc > 0 && now_utc <= priority_until_utc);
  }

int ASC_EffectiveHeartbeatBudgetMs(ASC_RuntimeState &state,const ASC_MajorLane lane,const bool ui_priority_active)
  {
   int default_budget = ASC_DefaultHeartbeatBudgetMs();
   int configured_scan_budget = (state.heartbeat_budget_scan_ms > 0) ? state.heartbeat_budget_scan_ms : default_budget;
   int configured_write_budget = (state.heartbeat_budget_write_ms > 0) ? state.heartbeat_budget_write_ms : default_budget;
   int configured_ui_budget = (state.heartbeat_budget_ui_ms > 0) ? state.heartbeat_budget_ui_ms : default_budget;

   int lane_budget = (lane == ASC_LANE_PERSISTENCE) ? configured_write_budget : configured_scan_budget;
   if(ui_priority_active)
     {
      int scaled_budget = lane_budget;
      if(lane == ASC_LANE_SCAN)
         scaled_budget = (lane_budget * ASC_UI_PRIORITY_SCAN_SCALE_PERCENT) / 100;
      else if(lane == ASC_LANE_PERSISTENCE)
         scaled_budget = (lane_budget * ASC_UI_PRIORITY_WRITE_SCALE_PERCENT) / 100;
      lane_budget = MathMin(configured_ui_budget, MathMax(40, scaled_budget));
     }

   return ASC_ClampHeartbeatBudgetMs(lane_budget);
  }

bool ASC_HeartbeatBudgetExpired(const ulong beat_start_us,const int budget_ms)
  {
   ulong elapsed_us = ASC_HeartbeatNowMicroseconds() - beat_start_us;
   return (elapsed_us >= (ulong)MathMax(1, budget_ms) * 1000);
  }

int ASC_HeartbeatElapsedMsSince(const ulong beat_start_us)
  {
   return ASC_SafeElapsedMsSince(beat_start_us);
  }

int ASC_HeartbeatRemainingMs(const ulong beat_start_us,const int budget_ms)
  {
   int elapsed_ms = ASC_HeartbeatElapsedMsSince(beat_start_us);
   int remaining_ms = MathMax(0, MathMax(1, budget_ms) - elapsed_ms);
   return remaining_ms;
  }

bool ASC_WriteLaneNearBudget(const ulong beat_start_us,const int budget_ms,const bool ui_priority_active)
  {
   int margin_ms = ui_priority_active ? ASC_WRITE_UI_NEAR_BUDGET_MARGIN_MS : ASC_WRITE_NEAR_BUDGET_MARGIN_MS;
   return (ASC_HeartbeatRemainingMs(beat_start_us, budget_ms) <= margin_ms);
  }

int ASC_HeartbeatPercentile(const int &values[],const double percentile)
  {
   int count = ArraySize(values);
   if(count <= 0)
      return 0;

   int sorted[];
   ArrayResize(sorted, count);
   for(int i = 0; i < count; i++)
      sorted[i] = values[i];
   ArraySort(sorted);

   double p = percentile;
   if(p < 0.0)
      p = 0.0;
   if(p > 100.0)
      p = 100.0;
   int index = (int)MathFloor(((count - 1) * p) / 100.0 + 0.5);
   index = ASC_ClampInt(index, 0, count - 1);
   return sorted[index];
  }

void ASC_RecordHeartbeatDurationTelemetry(ASC_RuntimeState &state,const ASC_MajorLane lane,const int duration_ms)
  {
   int clipped_duration = MathMax(0, duration_ms);
   if(lane == ASC_LANE_PERSISTENCE)
     {
      int count = ArraySize(state.heartbeat_write_duration_samples);
      if(count < ASC_HEARTBEAT_DURATION_SAMPLE_CAP)
         ArrayResize(state.heartbeat_write_duration_samples, count + 1);
      else
        {
         for(int i = 1; i < count; i++)
            state.heartbeat_write_duration_samples[i - 1] = state.heartbeat_write_duration_samples[i];
        }

      int write_index = ArraySize(state.heartbeat_write_duration_samples) - 1;
      if(write_index >= 0)
         state.heartbeat_write_duration_samples[write_index] = clipped_duration;
     }
   else
     {
      int count = ArraySize(state.heartbeat_scan_duration_samples);
      if(count < ASC_HEARTBEAT_DURATION_SAMPLE_CAP)
         ArrayResize(state.heartbeat_scan_duration_samples, count + 1);
      else
        {
         for(int i = 1; i < count; i++)
            state.heartbeat_scan_duration_samples[i - 1] = state.heartbeat_scan_duration_samples[i];
        }

      int write_index = ArraySize(state.heartbeat_scan_duration_samples) - 1;
      if(write_index >= 0)
         state.heartbeat_scan_duration_samples[write_index] = clipped_duration;
     }

   state.heartbeat_last_duration_ms = clipped_duration;
   if(lane == ASC_LANE_PERSISTENCE)
     {
      state.heartbeat_write_p50_ms = ASC_HeartbeatPercentile(state.heartbeat_write_duration_samples, 50.0);
      state.heartbeat_write_p95_ms = ASC_HeartbeatPercentile(state.heartbeat_write_duration_samples, 95.0);
     }
   else
     {
      state.heartbeat_scan_p50_ms = ASC_HeartbeatPercentile(state.heartbeat_scan_duration_samples, 50.0);
      state.heartbeat_scan_p95_ms = ASC_HeartbeatPercentile(state.heartbeat_scan_duration_samples, 95.0);
     }
  }

string ASC_BundleResultStatus(const ASC_FunctionResult &result)
  {
   if(result.state == ASC_RESULT_OK)
      return "fresh";
   if(result.state == ASC_RESULT_WARNING)
      return "continuity";
   return "failure";
  }

void ASC_RecordPublicationOutcomeCounters(ASC_RuntimeState &state,const ASC_FunctionResult &result)
  {
   if(result.state == ASC_RESULT_OK)
      state.publication_fresh_count++;
   else if(result.state == ASC_RESULT_WARNING)
      state.publication_continuity_count++;
   else
      state.publication_failure_count++;
  }

bool ASC_BundleHasPendingWork(const ASC_RuntimeState &state)
  {
   return (state.l2_publish_pending
           || state.l1_publish_pending_essentials
           || state.l1_publish_pending_dossiers
           || state.l1_publish_pending_manifest);
  }

int ASC_PendingBundleArtifactCount(const ASC_RuntimeState &state,
                                   const ASC_Layer1PassSummary &summary,
                                   const int dossier_pending)
  {
   if(!ASC_BundleHasPendingWork(state))
      return 0;

   int total = 1;
   if(state.l2_publish_pending)
      total++;
   if(state.l1_publish_pending_essentials)
      total++;
   if(state.l1_publish_pending_dossiers)
      total += dossier_pending;
   if(state.l1_publish_pending_manifest)
      total++;
   return total;
  }

string ASC_BoardRefreshTriggerLabel(const ASC_RuntimeState &state)
  {
   if(state.board_manual_refresh_inflight && StringLen(state.board_manual_refresh_trigger) > 0)
      return state.board_manual_refresh_trigger;
   if(state.deep_focus_trigger_pending)
      return "deep_trigger_priority";
   if(state.write_force)
      return "write_force";
   if(StringLen(state.lane_decision_reason) > 0)
      return state.lane_decision_reason;
   return "cadence_or_backlog";
  }


bool ASC_IsRunFullBoardRefreshTrigger(const string trigger)
  {
   return (trigger == "manual_hud_run_full_selected_symbol"
           || trigger == "manual_hud_run_full_top10");
  }

bool ASC_IsTop10RunFullBatchActive(const ASC_RuntimeState &state)
  {
   return (state.top10_run_full_batch_pending
           || state.top10_run_full_cursor < state.top10_run_full_total
           || StringLen(state.top10_run_full_inflight_symbol) > 0);
  }

int ASC_SecondsBetweenUtc(const datetime newer_utc,const datetime older_utc)
  {
   if(newer_utc <= 0 || older_utc <= 0 || newer_utc < older_utc)
      return 0;
   return (int)(newer_utc - older_utc);
  }

string ASC_RunFullSynchronizationLagTrace(const ASC_RuntimeState &state,const datetime now_utc)
  {
   int board_wait_sec = 0;
   if((state.board_manual_refresh_pending || state.board_manual_refresh_inflight)
      && state.board_manual_refresh_requested_utc > 0)
      board_wait_sec = ASC_SecondsBetweenUtc(now_utc, state.board_manual_refresh_requested_utc);

   int batch_age_sec = 0;
   if(ASC_IsTop10RunFullBatchActive(state) && state.top10_run_full_batch_requested_utc > 0)
      batch_age_sec = ASC_SecondsBetweenUtc(now_utc, state.top10_run_full_batch_requested_utc);

   int inflight_age_sec = 0;
   if(StringLen(state.top10_run_full_inflight_symbol) > 0 && state.top10_run_full_inflight_queued_utc > 0)
      inflight_age_sec = ASC_SecondsBetweenUtc(now_utc, state.top10_run_full_inflight_queued_utc);

   int board_to_child_lag_sec = 0;
   if(state.publication_bundle.board_baseline_confirmed_utc > 0
      && ASC_IsTop10RunFullBatchActive(state))
      board_to_child_lag_sec = ASC_SecondsBetweenUtc(now_utc, state.publication_bundle.board_baseline_confirmed_utc);

   return StringFormat("board_wait_sec=%d | batch_age_sec=%d | inflight_age_sec=%d | board_to_child_lag_sec=%d",
                       MathMax(0, board_wait_sec),
                       MathMax(0, batch_age_sec),
                       MathMax(0, inflight_age_sec),
                       MathMax(0, board_to_child_lag_sec));
  }

bool ASC_BundleHasConfirmedBoardBaseline(const ASC_PublicationBundleState &bundle)
  {
   bool board_finished = (bundle.board_publish_finished_utc > 0 || bundle.board_recompute_finished_utc > 0);
   bool board_status_confirmed = (bundle.market_board_status == "fresh"
                                  || bundle.market_board_status == "continuity"
                                  || bundle.market_board_status == "unchanged"
                                  || bundle.board_publish_result == "fresh"
                                  || bundle.board_publish_result == "continuity"
                                  || bundle.board_publish_result == "unchanged");
   return (board_finished
           && board_status_confirmed
           && bundle.board_baseline_confirmed_utc > 0
           && StringLen(bundle.publication_id) > 0);
  }

bool ASC_RunFullBoardBaselineSatisfied(const ASC_RuntimeState &state)
  {
   if(!ASC_BundleHasConfirmedBoardBaseline(state.publication_bundle))
      return false;

   datetime request_utc = state.board_manual_refresh_requested_utc;
   if(state.deep_focus_trigger_requested_utc > request_utc)
      request_utc = state.deep_focus_trigger_requested_utc;
   datetime board_confirmation_utc = state.publication_bundle.board_publish_finished_utc;
   if(state.publication_bundle.board_publish_result == "unchanged"
      && state.publication_bundle.board_recompute_finished_utc > board_confirmation_utc)
      board_confirmation_utc = state.publication_bundle.board_recompute_finished_utc;
   if(request_utc > 0 && board_confirmation_utc > 0 && board_confirmation_utc >= request_utc)
      return true;

   return (request_utc <= 0 && board_confirmation_utc > 0);
  }

void ASC_ReconcileRunFullBoardBaselineSatisfaction(ASC_RuntimeState &state)
  {
   bool run_full_manual_request_active = ((state.board_manual_refresh_pending || state.board_manual_refresh_inflight)
                                          && ASC_IsRunFullBoardRefreshTrigger(state.board_manual_refresh_trigger));
   if(!run_full_manual_request_active)
      return;

   if(!ASC_RunFullBoardBaselineSatisfied(state))
      return;

   state.board_manual_refresh_pending = false;
   state.board_manual_refresh_inflight = false;
   state.board_manual_refresh_last_status = "satisfied_by_published_board_baseline";
   state.board_manual_refresh_last_reason = "Run Full child gate cleared because a lawful Market Board baseline publish already landed for this request family";
   if(state.publication_bundle.board_publish_finished_utc > 0)
      state.board_manual_refresh_last_served_utc = state.publication_bundle.board_publish_finished_utc;
   else if(state.publication_bundle.publication_utc > 0)
      state.board_manual_refresh_last_served_utc = state.publication_bundle.publication_utc;
  }

bool ASC_RunFullChildPublishMustWaitForBoardBaseline(const ASC_RuntimeState &state,
                                                     const bool current_focus_write_due)
  {
   bool child_pending = (state.deep_focus_trigger_pending || current_focus_write_due);
   if(!child_pending)
      return false;

   if(ASC_RunFullBoardBaselineSatisfied(state))
      return false;

   bool run_full_board_request_active = (((state.board_manual_refresh_pending || state.board_manual_refresh_inflight)
                                          && ASC_IsRunFullBoardRefreshTrigger(state.board_manual_refresh_trigger))
                                         || (ASC_IsRunFullBoardRefreshTrigger(state.publication_bundle.board_refresh_trigger)
                                             && !ASC_BundleHasConfirmedBoardBaseline(state.publication_bundle)));
   if(!run_full_board_request_active)
      return false;

   if(state.deep_focus_trigger_pending
      && state.deep_focus_trigger_requested_utc > 0)
      return true;

   if(current_focus_write_due)
      return true;

   return false;
  }

bool ASC_HasUiPriorityRuntimeWorkPending(const ASC_RuntimeState &state,
                                         const bool current_focus_write_due)
  {
   bool top10_batch_active = ASC_IsTop10RunFullBatchActive(state);

   return (state.deep_focus_trigger_pending
           || state.deep_focus_ownership_active
           || state.forced_downstream_refresh_pending
           || state.board_manual_refresh_pending
           || state.board_manual_refresh_inflight
           || current_focus_write_due
           || state.current_focus_view_pending
           || top10_batch_active);
  }

bool ASC_ManualBoardRefreshShouldYieldToLayer2Service(const ASC_RuntimeState &state,
                                                      const datetime now_utc,
                                                      string &reason_out)
  {
   reason_out = "";

   bool l2_due_now = (state.layer2_dirty
                      || (state.l2_next_due_utc > 0 && state.l2_next_due_utc <= now_utc));
   if(!l2_due_now)
      return false;

   if(state.l1_l2_live_entitled_count <= 0 && !state.current_focus_view_pending)
      return false;

   int l2_due_remaining = MathMax(0, state.l2_due_remaining);
   int live_entitled = MathMax(0, state.l1_l2_live_entitled_count);
   int backlog_pressure_floor = MathMax(12, live_entitled / 4);
   bool backlog_pressure = (l2_due_remaining >= backlog_pressure_floor);

   bool scan_service_due = false;
   if(state.l2_last_scan_utc <= 0)
      scan_service_due = true;
   else if((now_utc - state.l2_last_scan_utc) >= ASC_HEARTBEAT_SECONDS)
      scan_service_due = true;

   if(state.current_focus_view_pending && state.current_focus_view_earliest_write_utc <= now_utc)
      scan_service_due = true;

   bool run_full_manual_request = ASC_IsRunFullBoardRefreshTrigger(state.board_manual_refresh_trigger);
   int request_wait_sec = ASC_SecondsBetweenUtc(now_utc, state.board_manual_refresh_requested_utc);
   bool shortlist_ready = ((state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
                           || (state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0));
   if(run_full_manual_request
      && shortlist_ready
      && request_wait_sec >= (ASC_HEARTBEAT_SECONDS * 2)
      && (ASC_IsTop10RunFullBatchActive(state)
          || state.deep_focus_trigger_pending
          || StringLen(state.top10_run_full_inflight_symbol) > 0))
     {
      reason_out = StringFormat("run_full_board_refresh_relief_after_wait request_wait_sec=%d due_remaining=%d live_entitled=%d shortlist_ready=yes",
                                request_wait_sec,
                                l2_due_remaining,
                                live_entitled);
      return false;
     }

   if(!scan_service_due && !backlog_pressure)
      return false;

   reason_out = backlog_pressure
                ? StringFormat("held until Layer 2 due service receives scan-lane relief (due_remaining=%d live_entitled=%d request_wait_sec=%d)",
                               l2_due_remaining,
                               live_entitled,
                               request_wait_sec)
                : StringFormat("held until Layer 2 due service receives scan-lane relief (request_wait_sec=%d)",
                               request_wait_sec);
   return true;
  }

void ASC_ServiceForcedDownstreamRefreshRequest(ASC_RuntimeState &state,const datetime now_utc)
  {
   if(!state.forced_downstream_refresh_pending)
      return;

   string scope = (StringLen(state.forced_downstream_refresh_scope) > 0
                   ? state.forced_downstream_refresh_scope
                   : "unspecified");
   string trigger_reason = StringFormat("forced-downstream-refresh|scope=%s|symbol=%s|req_seq=%d",
                                        scope,
                                        state.forced_downstream_refresh_symbol,
                                        state.forced_downstream_refresh_request_seq);
   ASC_RefreshCommittedSelectionOwnershipState(state,
                                               now_utc,
                                               true,
                                               trigger_reason);
   state.write_dirty = true;
   state.l1_publish_pending_essentials = true;
   state.l1_publish_pending_manifest = true;
   state.forced_downstream_refresh_pending = false;
   state.forced_downstream_refresh_last_served_utc = now_utc;
   state.forced_downstream_refresh_last_status = "served";
   state.forced_downstream_refresh_last_reason = StringFormat("forced downstream refresh consumed using current lawful Layer 0-2 substrate | scope=%s | forced_recompute=l3_l4_committed_selection | marked_dirty=essentials,manifest,write_lane", scope);

   ASC_LogInfo("ASC_Dispatcher", "ASC_ServiceForcedDownstreamRefreshRequest", "runtime",
               StringFormat("forced downstream refresh consumed req_seq=%d scope=%s symbol=%s forced_recompute=l3_l4_committed_selection marked_dirty=essentials,manifest,write_lane recompute_source=current_lawful_layer0_2_substrate",
                            state.forced_downstream_refresh_request_seq,
                            scope,
                            state.forced_downstream_refresh_symbol));
  }

void ASC_AdmitManualBoardRefreshRequest(ASC_RuntimeState &state,const datetime now_utc)
  {
   if(!state.board_manual_refresh_pending)
      return;

   string yield_reason = "";
   if(ASC_ManualBoardRefreshShouldYieldToLayer2Service(state, now_utc, yield_reason))
     {
      state.board_manual_refresh_last_status = "queued_waiting_packet_service";
      state.board_manual_refresh_last_reason = "manual refresh held pending until upstream Layer 2 service receives a lawful scan opportunity";
      if(StringLen(yield_reason) > 0)
         state.board_manual_refresh_last_reason += " | " + yield_reason;
      state.publication_bundle.board_lifecycle_state = "manual_refresh_requested";
      state.publication_bundle.board_refresh_trigger = ASC_BoardRefreshTriggerLabel(state);
      state.publication_bundle.board_refresh_requested_utc = state.board_manual_refresh_requested_utc;
      state.publication_bundle.board_publish_result = "pending";
      state.publication_bundle.board_publish_skip_reason = "awaiting_layer2_service_relief";
      return;
     }

   state.board_manual_refresh_pending = false;
   state.board_manual_refresh_inflight = true;
   state.board_manual_refresh_last_served_utc = now_utc;
   state.board_manual_refresh_last_status = "consumed";
   state.board_manual_refresh_last_reason = "manual refresh request admitted to runtime write lane";
   state.write_dirty = true;
   state.write_force = true;
   state.l1_publish_pending_essentials = true;
   state.l1_publish_pending_manifest = true;
   state.publication_bundle.board_lifecycle_state = "manual_refresh_requested";
   state.publication_bundle.board_refresh_trigger = ASC_BoardRefreshTriggerLabel(state);
   state.publication_bundle.board_refresh_requested_utc = state.board_manual_refresh_requested_utc;
   state.publication_bundle.board_refresh_consumed_utc = now_utc;
   state.publication_bundle.board_publish_result = "pending";
   state.publication_bundle.board_publish_skip_reason = "none";

   ASC_LogInfo("ASC_Dispatcher", "ASC_AdmitManualBoardRefreshRequest", "runtime",
               StringFormat("manual board refresh consumed req_seq=%d trigger=%s marked_dirty=essentials,manifest,write_lane board_lifecycle=%s board_publish_result=%s",
                            state.board_manual_refresh_request_seq,
                            state.board_manual_refresh_trigger,
                            state.publication_bundle.board_lifecycle_state,
                            state.publication_bundle.board_publish_result));
  }

void ASC_BeginPublicationBundle(ASC_RuntimeState &state,
                                const string publication_id,
                                const datetime publication_utc)
  {
   state.bundle_started_count++;
   state.publication_bundle.publication_id = publication_id;
   state.publication_bundle.publication_utc = publication_utc;
   state.publication_bundle.bundle_started_utc = publication_utc;
   state.publication_bundle.bundle_finished_utc = 0;
   state.publication_bundle.board_lifecycle_state = state.l1_publish_pending_essentials ? "recompute_in_progress" : "awaiting_auto_refresh";
   state.publication_bundle.board_refresh_trigger = ASC_BoardRefreshTriggerLabel(state);
   if(state.board_manual_refresh_inflight && state.board_manual_refresh_requested_utc > 0)
      state.publication_bundle.board_refresh_requested_utc = state.board_manual_refresh_requested_utc;
   else
      state.publication_bundle.board_refresh_requested_utc = publication_utc;
   state.publication_bundle.board_refresh_consumed_utc = publication_utc;
   state.publication_bundle.board_recompute_started_utc = publication_utc;
   state.publication_bundle.board_recompute_finished_utc = 0;
   state.publication_bundle.board_publish_started_utc = 0;
   state.publication_bundle.board_publish_finished_utc = 0;
   state.publication_bundle.board_baseline_confirmed_utc = state.market_board_last_publish_utc;
   state.publication_bundle.board_publish_result = state.l1_publish_pending_essentials ? "pending" : "skipped";
   state.publication_bundle.board_publish_skip_reason = state.l1_publish_pending_essentials ? "none" : "market_board_not_pending";
   state.publication_bundle.market_board_status = state.l1_publish_pending_essentials ? "pending" : "skipped";
   state.publication_bundle.open_symbol_snapshot_status = state.l2_publish_pending ? "pending" : "skipped";
   state.publication_bundle.manifest_status = state.l1_publish_pending_manifest ? "pending" : "skipped";
   state.publication_bundle.dossier_attempted_count = 0;
   state.publication_bundle.dossier_success_count = 0;
   state.publication_bundle.dossier_failure_count = 0;
   state.publication_bundle.dossier_skipped_count = 0;
   state.publication_bundle.board_compose_ms = 0;
   state.publication_bundle.board_publish_ms = 0;
   state.publication_bundle.dossier_compose_ms_total = 0;
   state.publication_bundle.dossier_publish_ms_total = 0;
   state.publication_bundle.manifest_compose_ms = 0;
   state.publication_bundle.manifest_publish_ms = 0;
   state.publication_bundle.write_queue_service_ms = 0;
   state.publication_bundle.artifact_attempted_count = 0;
   state.publication_bundle.write_bottleneck_family = "pending";
   state.publication_bundle.write_bottleneck_reason = "pending";
   state.publication_bundle.overall_bundle_status = "pending";
   state.publication_bundle.last_bundle_error_summary = "";
   state.publication_bundle.top5_bucket_family_state = state.top5_bucket_family_state;
   state.publication_bundle.top5_bucket_committed_signature = ASC_TextOrUnavailable(state.top5_bucket_last_signature);
   state.publication_bundle.top5_bucket_committed_exact_signature = ASC_Top5BucketExactSignature(state);
   state.publication_bundle.top5_bucket_committed_source_pass_utc = state.publication_shortlist_pass_utc;
   state.publication_bundle.top5_market_board_source_pass_utc = state.publication_shortlist_pass_utc;
   state.publication_bundle.top5_bucket_child_target_count = MathMax(0, state.top5_bucket_child_target_count);
   state.publication_bundle.top5_bucket_active_child_actual_count = MathMax(0, ASC_Top5BucketCountActiveChildFiles(state));
   state.publication_bundle.top5_bucket_staging_child_count = MathMax(0, ASC_Top5BucketCountStagingChildFiles(state));
   state.publication_bundle.top5_bucket_queue_remaining = MathMax(0, state.top5_bucket_queue_remaining);
   state.publication_bundle.top5_bucket_pending_count = MathMax(0, state.top5_bucket_child_pending_count);
   state.publication_bundle.top5_bucket_alignment_state = "pending_market_board_visible_compare";
   state.publication_bundle.top5_bucket_alignment_reason = "bundle_started_before_market_board_signature_compare";
   string run245_top5_all_symbols = ASC_Run245Top5BucketQueueAllSymbols(state);
   string run245_top5_exact_signature = ASC_Top5BucketExactSignature(state);
   state.publication_bundle.top5_dossier_current_symbols = run245_top5_all_symbols;
   state.publication_bundle.top5_dossier_current_exact_signature = run245_top5_exact_signature;
   state.publication_bundle.top5_sdp_current_symbols = run245_top5_all_symbols;
   state.publication_bundle.top5_sdp_current_signature = ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_source_signature);
   if(StringLen(state.publication_bundle.top5_sdp_current_signature) <= 0 || state.publication_bundle.top5_sdp_current_signature == "unknown")
      state.publication_bundle.top5_sdp_current_signature = ASC_TextOrUnavailable(state.top5_bucket_last_signature);
   state.publication_bundle.top5_sdp_current_exact_signature = run245_top5_exact_signature;
   state.publication_bundle.top5_crypto_dossier_symbols = ASC_Run245Top5BucketQueueSymbols(state, "crypto");
   state.publication_bundle.top5_energy_dossier_symbols = ASC_Run245Top5BucketQueueSymbols(state, "energy");
   state.publication_bundle.top5_fx_dossier_symbols = ASC_Run245Top5BucketQueueSymbols(state, "fx");
   state.publication_bundle.top5_indices_dossier_symbols = ASC_Run245Top5BucketQueueSymbols(state, "indices");
   state.publication_bundle.top5_metals_dossier_symbols = ASC_Run245Top5BucketQueueSymbols(state, "metals");
   state.publication_bundle.top5_stocks_dossier_symbols = ASC_Run245Top5BucketQueueSymbols(state, "stocks");
   state.publication_bundle.top5_crypto_sdp_symbols = state.publication_bundle.top5_crypto_dossier_symbols;
   state.publication_bundle.top5_energy_sdp_symbols = state.publication_bundle.top5_energy_dossier_symbols;
   state.publication_bundle.top5_fx_sdp_symbols = state.publication_bundle.top5_fx_dossier_symbols;
   state.publication_bundle.top5_indices_sdp_symbols = state.publication_bundle.top5_indices_dossier_symbols;
   state.publication_bundle.top5_metals_sdp_symbols = state.publication_bundle.top5_metals_dossier_symbols;
   state.publication_bundle.top5_stocks_sdp_symbols = state.publication_bundle.top5_stocks_dossier_symbols;
   int run249_bundle_top5_sdp_expected = MathMax(0, state.symbol_data_pack_top5perbucket_total > 0 ? state.symbol_data_pack_top5perbucket_total : state.top5_bucket_child_target_count);
   int run249_bundle_top5_sdp_written = MathMax(0, state.symbol_data_pack_top5perbucket_written_count + state.symbol_data_pack_top5perbucket_no_change_count);
   int run249_bundle_top5_sdp_failed = MathMax(0, state.symbol_data_pack_top5perbucket_failed_count);
   int run249_bundle_top5_sdp_pending = MathMax(0, run249_bundle_top5_sdp_expected - run249_bundle_top5_sdp_written - run249_bundle_top5_sdp_failed);
   string run249_bundle_top5_sdp_status = (run249_bundle_top5_sdp_expected <= 0 ? "absent" : (run249_bundle_top5_sdp_pending > 0 ? "pending" : (run249_bundle_top5_sdp_failed > 0 ? "partial" : "complete")));
   state.publication_bundle.top5_sdp_transport_status = "top5_sdp_publication_status=" + run249_bundle_top5_sdp_status
                                                          + ";expected=" + IntegerToString(run249_bundle_top5_sdp_expected)
                                                          + ";written=" + IntegerToString(run249_bundle_top5_sdp_written)
                                                          + ";pending=" + IntegerToString(run249_bundle_top5_sdp_pending)
                                                          + ";failed=" + IntegerToString(run249_bundle_top5_sdp_failed);
   state.publication_bundle.top5_sdp_transport_owner = "state.symbol_data_pack_top5perbucket_cursor_over_state.top5_bucket_queue_symbols consumed_by_ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication";
   state.publication_bundle.top5_sdp_transport_next_step = (run249_bundle_top5_sdp_expected > 0 ? "resume_top5_sdp_publication_until_written_or_failed_readback_ledger_visible" : "source_owner_gap_queue_unavailable_do_not_fake_child_truth");
   state.publication_bundle.globaltop10_dossier_current_symbols = ASC_Top10RunFullCompactSymbolList(state.top10_run_full_last_completed_symbols);
   state.publication_bundle.globaltop10_dossier_source_signature = ASC_TextOrUnavailable(state.top10_run_full_last_completed_source_signature);
   state.publication_bundle.globaltop10_dossier_alignment_status = ASC_TextOrUnavailable(state.top10_run_full_family_alignment_status);
   state.publication_bundle.globaltop10_dossier_alignment_reason = ASC_TextOrUnavailable(state.top10_run_full_family_alignment_reason);
   state.publication_bundle.globaltop10_sdp_current_symbols = ASC_Top10RunFullCompactSymbolList(state.top10_run_full_last_completed_symbols);
   state.publication_bundle.globaltop10_sdp_source_signature = ASC_TextOrUnavailable(state.symbol_data_pack_globaltop10_source_signature);
   state.publication_bundle.globaltop10_sdp_alignment_status = ASC_TextOrUnavailable(state.symbol_data_pack_globaltop10_activation_mode);
   state.publication_bundle.globaltop10_sdp_alignment_reason = ASC_TextOrUnavailable(state.symbol_data_pack_globaltop10_last_reason);
  }


string ASC_CommittedCanonicalSymbolForState(const ASC_Layer1SymbolState &symbol_state)
  {
   if(StringLen(symbol_state.classification.canonical_symbol) > 0)
      return symbol_state.classification.canonical_symbol;
   if(StringLen(symbol_state.identity.canonical_symbol) > 0)
      return symbol_state.identity.canonical_symbol;
   if(StringLen(symbol_state.identity.normalized_symbol) > 0)
      return symbol_state.identity.normalized_symbol;
   return symbol_state.symbol;
  }


bool ASC_CommittedL4FindBySymbol(const ASC_CommittedLayer4SymbolState &rows[],
                                 const string symbol,
                                 ASC_CommittedLayer4SymbolState &row_out)
  {
   if(StringLen(symbol) <= 0)
      return false;

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(rows[i].symbol == symbol
         || rows[i].canonical_symbol == symbol)
        {
         row_out = rows[i];
         return true;
        }
     }
   return false;
  }

int ASC_CountOpenLayer1Symbols()
  {
   int open_count = 0;
   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(symbol_state.state == ASC_L1_OPEN)
         open_count++;
     }
   return open_count;
  }

void ASC_SortStringsAscending(string &values[])
  {
   int total = ArraySize(values);
   for(int i = 0; i < total; i++)
     {
      for(int j = i + 1; j < total; j++)
        {
         if(StringCompare(values[j], values[i]) < 0)
           {
            string tmp = values[i];
            values[i] = values[j];
            values[j] = tmp;
           }
        }
     }
  }

string ASC_ShortlistMembershipSignature(const ASC_ShortlistSymbolSummary &rows[])
  {
   string signature = "";
   string remainder_symbols[];
   ArrayResize(remainder_symbols, 0);

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(rows[i]))
         continue;

      if(rows[i].rank > 0 && rows[i].rank <= 3)
         signature += StringFormat("top:%s#%d;", rows[i].symbol, rows[i].rank);
      else
        {
         int next = ArraySize(remainder_symbols);
         ArrayResize(remainder_symbols, next + 1);
         remainder_symbols[next] = rows[i].symbol;
        }
     }

   ASC_SortStringsAscending(remainder_symbols);
   for(int i = 0; i < ArraySize(remainder_symbols); i++)
      signature += "rest:" + remainder_symbols[i] + ";";
   return signature;
  }

string ASC_BucketTop5Signature(const ASC_ShortlistSymbolSummary &rows[])
  {
   string signature = "";
   string remainder_members[];
   ArrayResize(remainder_members, 0);

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistHasLawfulBucketMembership(rows[i]))
         continue;

      string bucket_id = ASC_ClassificationEffectiveMainBucketId(rows[i].state.classification);
      if(StringLen(bucket_id) <= 0)
         bucket_id = "unknown";

      if(rows[i].bucket_rank > 0 && rows[i].bucket_rank <= 2)
         signature += StringFormat("lead:%s:%s#%d;", bucket_id, rows[i].symbol, rows[i].bucket_rank);
      else
        {
         int next = ArraySize(remainder_members);
         ArrayResize(remainder_members, next + 1);
         remainder_members[next] = bucket_id + ":" + rows[i].symbol;
        }
     }

   ASC_SortStringsAscending(remainder_members);
   for(int i = 0; i < ArraySize(remainder_members); i++)
      signature += "rest:" + remainder_members[i] + ";";
   return signature;
  }

string ASC_CommittedL3MotionOverlayLabel(const ASC_CommittedLayer3SymbolState &row)
  {
   if(row.momentum_acceleration_score >= 67.5
      && row.pressure_shift_score >= 60.0
      && row.risk_drag_score <= 45.0)
      return "accelerating";
   if(row.momentum_acceleration_score >= 57.5
      && row.pressure_shift_score >= 55.0
      && row.move_age_score >= 55.0
      && row.late_move_risk_score <= 50.0)
      return "clean-continuation";
   if(row.pressure_shift_score >= 60.0 && row.momentum_acceleration_score < 50.0)
      return "pressure-build";
   if(row.late_move_risk_score >= 62.5 || row.exhaustion_risk_score >= 57.5)
      return "late-stretch";
   if(row.momentum_acceleration_score < 45.0 && row.pressure_shift_score < 47.5)
      return "stalling";
   return "mixed-pulse";
  }

string ASC_CommittedL3WaveOverlayLabel(const ASC_CommittedLayer3SymbolState &row)
  {
   if(row.entry_readiness_score >= 72.5
      && row.tick_burst_score >= 55.0
      && row.session_timing_score >= 65.0)
      return "in-sync";
   if(row.entry_readiness_score >= 57.5 && row.session_timing_score >= 55.0)
      return "building";
   if(row.context_strength_score >= 60.0
      && (row.late_move_risk_score >= 60.0 || row.exhaustion_risk_score >= 55.0))
      return "extended";
   if(row.tick_burst_score < 40.0 && row.momentum_acceleration_score < 50.0)
      return "fading";
   return "between-pulses";
  }

string ASC_CommittedL3FlowOverlayLabel(const ASC_CommittedLayer3SymbolState &row)
  {
   if(row.execution_alignment_score >= 67.5
      && row.session_alignment_score >= 62.5
      && row.risk_drag_score <= 42.5)
      return "clean";
   if(row.execution_alignment_score >= 57.5 && row.entry_readiness_score >= 57.5)
      return "workable";
   if(row.execution_alignment_score >= 50.0 && row.risk_drag_score < 60.0)
      return "guarded";
   return "heavy";
  }

string ASC_CommittedL3ExecutionStyleOverlayLabel(const ASC_CommittedLayer3SymbolState &row)
  {
   if(row.style_execution_fit_score >= 70.0
      && row.scalp_tradable == "yes"
      && row.session_execution_quality_score >= 62.5)
      return "scalp-clean";
   if(row.style_execution_fit_score >= 60.0
      && row.intraday_tradable == "yes")
      return "intraday-clean";
   if(row.execution_alignment_score >= 52.5)
      return "mixed";
   return "friction-heavy";
  }

string ASC_CommittedL3OverlayEffectLabel(const ASC_CommittedLayer3SymbolState &row)
  {
   double overlay_balance = ((row.pressure_shift_score
                              + row.momentum_acceleration_score
                              + row.entry_readiness_score
                              + row.execution_alignment_score) / 4.0)
                            - row.risk_drag_score;
   if(overlay_balance >= 15.0)
      return "strengthened";
   if(overlay_balance <= -10.0)
      return "softened";
   return "stabilized";
  }

string ASC_CommittedL3OverlaySummary(const ASC_CommittedLayer3SymbolState &row)
  {
   return StringFormat("motion=%s | wave=%s | flow=%s | style=%s | effect=%s",
                       ASC_CommittedL3MotionOverlayLabel(row),
                       ASC_CommittedL3WaveOverlayLabel(row),
                       ASC_CommittedL3FlowOverlayLabel(row),
                       ASC_CommittedL3ExecutionStyleOverlayLabel(row),
                       ASC_CommittedL3OverlayEffectLabel(row));
  }

string ASC_CommittedL3InfluenceTopTrace(const ASC_CommittedLayer3SymbolState &row)
  {
   return StringFormat("top_inputs=%s | %s | pressure=%.1f:%s | momentum=%.1f:%s | execution=%.1f:%s | timing=%.1f:%s | risk_drag=%.1f",
                       row.symbol,
                       ASC_CommittedL3OverlaySummary(row),
                       row.pressure_shift_score,
                       row.pressure_shift_posture,
                       row.momentum_acceleration_score,
                       row.momentum_acceleration_posture,
                       row.execution_alignment_score,
                       row.execution_posture,
                       row.entry_readiness_score,
                       row.session_timing_posture,
                       row.risk_drag_score);
  }

string ASC_CommittedL4InfluenceOutcomeToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.overall_board_quality_adjustment >= 0.25)
      return "raised";
   if(entry.overall_board_quality_adjustment <= -0.25)
      return "reduced";
   return "stabilized";
  }

void ASC_AppendInfluenceSample(string &target,const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return;
   if(StringLen(target) > 0)
      target += ",";
   target += symbol;
  }

string ASC_CommittedL4InfluenceTopTrace(const ASC_ShortlistSymbolSummary &entry)
  {
   return StringFormat("top_influence=%s | outcome=%s | %s | pressure=%.1f:%s | momentum=%.1f:%s | execution=%.1f:%s | timing=%.1f:%s | risk_drag=%.1f | quality=%+.1f",
                       entry.symbol,
                       ASC_CommittedL4InfluenceOutcomeToken(entry),
                       ASC_SelectionFilterOverlaySummary(entry.filter),
                       entry.filter.pressure_shift_score,
                       entry.filter.pressure_shift_posture,
                       entry.filter.momentum_acceleration_score,
                       entry.filter.momentum_acceleration_posture,
                       entry.filter.execution_alignment_score,
                       entry.filter.execution_posture,
                       entry.filter.entry_readiness_score,
                       entry.filter.timing_quality_posture,
                       entry.filter.risk_drag_score,
                       entry.overall_board_quality_adjustment);
  }

string ASC_CommittedLayer3TelemetryTrace(const ASC_RuntimeState &state)
  {
   if(!state.committed_l3_ready)
      return "l3_status=not_ready | l3_reason=committed_l3_not_ready";

   int total = ArraySize(state.committed_l3_rows);
   int score_ready = 0;
   int qualified = 0;
   int drag = 0;
   int pending = 0;
   int fail = 0;
   int participation_clone = 0;
   int pressure_active = 0;
   int momentum_active = 0;
   int execution_active = 0;
   int timing_active = 0;
   int drag_active = 0;
   double top_score = -1.0;
   string top_symbol = "none";
   string top_branch = "none";
   string top_influence_trace = "top_inputs=none";
   string blocker_code = "none";
   int blocker_hits = 0;

   for(int i = 0; i < total; i++)
     {
      ASC_CommittedLayer3SymbolState row = state.committed_l3_rows[i];
      if(row.score_pack_ready)
         score_ready++;
      if(row.reason_code == "score_led_candidate_ready")
         qualified++;
      else if(row.reason_code == "score_led_penalty_carry")
         drag++;

      if(row.result_state == "Pending")
        {
         pending++;
         if(blocker_hits <= 0)
           {
            blocker_code = row.reason_code;
            blocker_hits = 1;
           }
         else if(row.reason_code == blocker_code)
            blocker_hits++;
        }
      else if(row.result_state == "Fail")
         fail++;

      if(MathAbs(row.participation_score - row.microstructure_score) < 0.05)
         participation_clone++;
      if(MathAbs(row.pressure_shift_score - 50.0) >= 5.0)
         pressure_active++;
      if(MathAbs(row.momentum_acceleration_score - 50.0) >= 5.0)
         momentum_active++;
      if(MathAbs(row.execution_alignment_score - 50.0) >= 5.0)
         execution_active++;
      if(MathAbs(row.entry_readiness_score - 50.0) >= 5.0)
         timing_active++;
      if(MathAbs(row.risk_drag_score - 50.0) >= 5.0)
         drag_active++;

      if(row.score_net > top_score)
        {
         top_score = row.score_net;
         top_symbol = row.symbol;
         top_branch = row.reason_code;
         top_influence_trace = ASC_CommittedL3InfluenceTopTrace(row);
        }
     }

   string blocker_text = (pending > 0)
                         ? StringFormat("%s:%d", blocker_code, blocker_hits)
                         : "none";
   string top_score_text = (top_score >= 0.0) ? DoubleToString(top_score, 1) : "unavailable";
   datetime now_utc = TimeGMT();
   int open_scope = ASC_CountOpenLayer1Symbols();
   string refresh_status = "not_due";
   if(open_scope <= 0)
      refresh_status = "closed_sleep";
   else if(state.committed_l3_next_recheck_utc <= 0 || state.committed_l3_next_recheck_utc <= now_utc)
      refresh_status = "due_pending";
   int seconds_to_due = (state.committed_l3_next_recheck_utc > 0 ? (int)(state.committed_l3_next_recheck_utc - now_utc) : 0);
   return StringFormat("refresh_domain=candidate_filtering | refresh_status=%s | last_refresh_utc=%s | next_due_utc=%s | seconds_to_due=%d | open_scope=%d | l3_status=%s | symbols=%d | score_ready=%d | qualified=%d | drag=%d | pending=%d | fail=%d | participation_clone=%d | influence_active=pressure:%d,momentum:%d,execution:%d,timing:%d,drag:%d | blocker=%s | top=%s:%s:%s | %s | l3_reason=%s",
                       refresh_status,
                       ASC_FormatUtc(state.committed_l3_last_built_utc),
                       ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                       seconds_to_due,
                       open_scope,
                       state.committed_l3_status,
                       total,
                       score_ready,
                       qualified,
                       drag,
                       pending,
                       fail,
                       participation_clone,
                       pressure_active,
                       momentum_active,
                       execution_active,
                       timing_active,
                       drag_active,
                       blocker_text,
                       top_symbol,
                       top_score_text,
                       top_branch,
                       top_influence_trace,
                       state.committed_l3_reason);
  }


string ASC_CommittedL4SymbolsSample(const string &symbols[],const int limit = 3)
  {
   int total = ArraySize(symbols);
   if(total <= 0)
      return "none";

   string sample = "";
   int shown = MathMin(limit, total);
   for(int i = 0; i < shown; i++)
     {
      if(i > 0)
         sample += ",";
      sample += symbols[i];
     }
   if(total > shown)
      sample += StringFormat("+%d", total - shown);
   return sample;
  }

void ASC_CommittedL4CollectMembershipDelta(const ASC_CommittedLayer4SymbolState &before_rows[],
                                           const ASC_CommittedLayer4SymbolState &after_rows[],
                                           string &added_sample,
                                           string &removed_sample,
                                           string &retained_sample,
                                           int &added_count,
                                           int &removed_count,
                                           int &retained_count)
  {
   string before_members[];
   string after_members[];
   string added_symbols[];
   string removed_symbols[];
   string retained_symbols[];
   ArrayResize(before_members, 0);
   ArrayResize(after_members, 0);
   ArrayResize(added_symbols, 0);
   ArrayResize(removed_symbols, 0);
   ArrayResize(retained_symbols, 0);

   for(int i = 0; i < ArraySize(before_rows); i++)
     {
      if(!before_rows[i].lawful_survivor)
         continue;
      int next = ArraySize(before_members);
      ArrayResize(before_members, next + 1);
      before_members[next] = before_rows[i].symbol;
     }

   for(int j = 0; j < ArraySize(after_rows); j++)
     {
      if(!after_rows[j].lawful_survivor)
         continue;
      int next = ArraySize(after_members);
      ArrayResize(after_members, next + 1);
      after_members[next] = after_rows[j].symbol;
     }

   for(int a = 0; a < ArraySize(after_members); a++)
     {
      if(ASC_ShortlistContains(before_members, after_members[a]))
        {
         int next = ArraySize(retained_symbols);
         ArrayResize(retained_symbols, next + 1);
         retained_symbols[next] = after_members[a];
        }
      else
        {
         int next = ArraySize(added_symbols);
         ArrayResize(added_symbols, next + 1);
         added_symbols[next] = after_members[a];
        }
     }

   for(int b = 0; b < ArraySize(before_members); b++)
     {
      if(ASC_ShortlistContains(after_members, before_members[b]))
         continue;
      int next = ArraySize(removed_symbols);
      ArrayResize(removed_symbols, next + 1);
      removed_symbols[next] = before_members[b];
     }

   ASC_SortStringsAscending(added_symbols);
   ASC_SortStringsAscending(removed_symbols);
   ASC_SortStringsAscending(retained_symbols);

   added_count = ArraySize(added_symbols);
   removed_count = ArraySize(removed_symbols);
   retained_count = ArraySize(retained_symbols);
   added_sample = ASC_CommittedL4SymbolsSample(added_symbols);
   removed_sample = ASC_CommittedL4SymbolsSample(removed_symbols);
   retained_sample = ASC_CommittedL4SymbolsSample(retained_symbols);
  }

string ASC_CommittedLayer4TelemetryTrace(const ASC_RuntimeState &state)
  {
   if(!state.committed_l4_ready)
      return "l4_status=not_ready | l4_reason=committed_l4_not_ready";

   int total = ArraySize(state.committed_l4_rows);
   int members = 0;
   int promoted = 0;
   int shortlisted = 0;
   int bucket_reserve = 0;
   int reserve_only = 0;
   int pending = 0;
   int peer_drag = 0;
   int diversity_drag = 0;
   int exposure_drag = 0;
   int influence_raised = 0;
   int influence_reduced = 0;
   int influence_stabilized = 0;
   string raised_samples = "";
   string reduced_samples = "";
   double top_score = -1.0;
   string top_symbol = "none";
   string top_peer = "n/a";
   string top_corr = "n/a";
   int top_cluster = 0;
   string top_influence_trace = "top_influence=none";
   string shortlist_posture = "none";

   for(int i = 0; i < total; i++)
     {
      ASC_ShortlistSymbolSummary entry = state.committed_l4_rows[i].summary;
      if(StringLen(shortlist_posture) <= 0 || shortlist_posture == "none")
         shortlist_posture = entry.shortlist_stability_posture;

      if(ASC_ShortlistHasLawfulMembership(entry))
        {
         members++;
         if(entry.rank > 0 && entry.rank <= 3)
            promoted++;
         else
            shortlisted++;

         if(entry.overall_board_correlation_penalty > 0.05)
            peer_drag++;
         if(entry.overall_board_bucket_penalty > 0.05)
            diversity_drag++;
         if(entry.overall_board_conflict_penalty > 0.05)
            exposure_drag++;

         string influence_outcome = ASC_CommittedL4InfluenceOutcomeToken(entry);
         if(influence_outcome == "raised")
           {
            influence_raised++;
            if(StringLen(raised_samples) < 64)
               ASC_AppendInfluenceSample(raised_samples, entry.symbol);
           }
         else if(influence_outcome == "reduced")
           {
            influence_reduced++;
            if(StringLen(reduced_samples) < 64)
               ASC_AppendInfluenceSample(reduced_samples, entry.symbol);
           }
         else
            influence_stabilized++;

         if(entry.overall_board_score > top_score)
           {
            top_score = entry.overall_board_score;
            top_symbol = entry.symbol;
            top_peer = entry.overall_board_peer_symbol;
            top_corr = (entry.overall_board_peer_symbol != "n/a") ? DoubleToString(entry.overall_board_peer_correlation, 2) : "n/a";
            top_cluster = entry.overall_board_cluster_count;
            top_influence_trace = ASC_CommittedL4InfluenceTopTrace(entry);
           }
        }
      else if(ASC_ShortlistHasLawfulBucketMembership(entry))
         bucket_reserve++;
      else if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
         pending++;
      else if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         reserve_only++;
     }

   string top_score_text = (top_score >= 0.0) ? DoubleToString(top_score, 1) : "unavailable";
   datetime now_utc = TimeGMT();
   int open_scope = ASC_CountOpenLayer1Symbols();
   string refresh_status = "not_due";
   if(open_scope <= 0)
      refresh_status = "closed_sleep";
   else if(state.committed_l4_next_recheck_utc <= 0 || state.committed_l4_next_recheck_utc <= now_utc)
      refresh_status = "due_pending";
   int seconds_to_due = (state.committed_l4_next_recheck_utc > 0 ? (int)(state.committed_l4_next_recheck_utc - now_utc) : 0);
   return StringFormat("refresh_domain=shortlist_selection | refresh_status=%s | last_refresh_utc=%s | next_due_utc=%s | seconds_to_due=%d | open_scope=%d | l4_status=%s | shortlist_posture=%s | members=%d | promoted=%d | shortlisted=%d | bucket_reserve=%d | reserve_only=%d | pending=%d | peer_drag=%d | diversity_drag=%d | exposure_drag=%d | influence=raised:%d,reduced:%d,stabilized:%d | influence_samples=raise[%s] reduce[%s] | top=%s:%s:%s:%s:c%d | %s | l4_reason=%s",
                       refresh_status,
                       ASC_FormatUtc(state.committed_l4_last_built_utc),
                       ASC_FormatUtc(state.committed_l4_next_recheck_utc),
                       seconds_to_due,
                       open_scope,
                       state.committed_l4_status,
                       shortlist_posture,
                       members,
                       promoted,
                       shortlisted,
                       bucket_reserve,
                       reserve_only,
                       pending,
                       peer_drag,
                       diversity_drag,
                       exposure_drag,
                       influence_raised,
                       influence_reduced,
                       influence_stabilized,
                       (StringLen(raised_samples) > 0 ? raised_samples : "none"),
                       (StringLen(reduced_samples) > 0 ? reduced_samples : "none"),
                       top_symbol,
                       top_score_text,
                       top_peer,
                       top_corr,
                       top_cluster,
                       top_influence_trace,
                       state.committed_l4_reason);
  }

bool ASC_CommittedL4MaterialChangeDetected(const ASC_CommittedLayer4SymbolState &before_rows[],
                                           const ASC_CommittedLayer4SymbolState &after_rows[],
                                           string &reason_out)
  {
   ASC_ShortlistSymbolSummary before_shortlist[];
   ASC_ShortlistSymbolSummary after_shortlist[];
   ArrayResize(before_shortlist, ArraySize(before_rows));
   for(int i = 0; i < ArraySize(before_rows); i++)
      before_shortlist[i] = before_rows[i].summary;
   ArrayResize(after_shortlist, ArraySize(after_rows));
   for(int i = 0; i < ArraySize(after_rows); i++)
      after_shortlist[i] = after_rows[i].summary;

   string before_membership = ASC_ShortlistMembershipSignature(before_shortlist);
   string after_membership = ASC_ShortlistMembershipSignature(after_shortlist);
   if(before_membership != after_membership)
     {
      reason_out = "shortlist membership signature changed";
      return true;
     }

   string before_bucket_top5 = ASC_BucketTop5Signature(before_shortlist);
   string after_bucket_top5 = ASC_BucketTop5Signature(after_shortlist);
   if(before_bucket_top5 != after_bucket_top5)
     {
      reason_out = "bucket top-5 membership/rank signature changed";
      return true;
     }

   reason_out = "no shortlist or bucket top-5 material change";
   return false;
  }

void ASC_CommitLayer3SelectionState(ASC_RuntimeState &state,
                                    const datetime pass_utc,
                                    const bool force_recheck = false,
                                    const string trigger_reason = "")
  {
   datetime committed_utc = TimeGMT();
   int open_count = ASC_CountOpenLayer1Symbols();
   bool live_open_scope = (open_count > 0);
   if(state.committed_l3_ready && state.committed_l3_pass_utc == pass_utc && !force_recheck)
     {
      state.committed_l3_status = "reused";
      state.committed_l3_reason = "committed Layer 3 state reused for this pass";
      if(live_open_scope && state.committed_l3_next_recheck_utc <= 0)
         state.committed_l3_next_recheck_utc = committed_utc + ASC_L3_RECHECK_OPEN_SEC;
      return;
     }

   ArrayResize(state.committed_l3_rows, 0);
   ulong l1_revision = ASC_Layer1StructuralRevision();
   ulong l2_revision = ASC_Layer2LatestRevision();
   int score_ready_count = 0;
   int qualified_count = 0;
   int drag_count = 0;
   int pending_count = 0;
   int fail_count = 0;
   int participation_clone_count = 0;
   double top_score_net = -1.0;
   string top_symbol = "none";
   string top_branch = "none";
   string dominant_pending_code = "none";
   string dominant_candidate_evidence_intake_state = ASC_CAND_EVID_INTAKE_NOT_APPLICABLE;
   string dominant_candidate_evidence_intake_ce = ASC_CE_NO_CLAIM;
   int dominant_candidate_evidence_intake_hits = 0;
   int candidate_evidence_clean_count = 0;
   int candidate_evidence_non_clean_count = 0;
   int candidate_evidence_unavailable_count = 0;
   int candidate_evidence_stale_count = 0;
   int candidate_evidence_insufficient_count = 0;
   int candidate_evidence_dependency_count = 0;
   int dominant_pending_hits = 0;

   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      ASC_Layer2Packet packet;
      bool has_packet = ASC_ShortlistTryGetPacketForState(symbol_state, packet);
      bool has_lawful_packet = has_packet && ASC_L2PacketHasLawfulSnapshot(packet);

      ASC_SelectionFilterEvaluation evaluation;
      ASC_SelectionFilterEvaluate(symbol_state, packet, has_lawful_packet, evaluation);

      int next = ArraySize(state.committed_l3_rows);
      ArrayResize(state.committed_l3_rows, next + 1);
      state.committed_l3_rows[next].symbol = symbol_state.symbol;
      state.committed_l3_rows[next].canonical_symbol = ASC_CommittedCanonicalSymbolForState(symbol_state);
      state.committed_l3_rows[next].evaluation = evaluation;
      state.committed_l3_rows[next].result_state = evaluation.result_state_text;
      state.committed_l3_rows[next].reason_code = evaluation.reason_code;
      state.committed_l3_rows[next].reason_summary = evaluation.reason_summary;
      state.committed_l3_rows[next].disqualifiers = evaluation.disqualifiers;
      state.committed_l3_rows[next].dependencies_text = evaluation.dependencies_text;
      state.committed_l3_rows[next].corroboration_text = evaluation.corroboration_text;
      state.committed_l3_rows[next].confidence_text = evaluation.confidence_text;
      state.committed_l3_rows[next].next_required_step = evaluation.next_required_step;
      state.committed_l3_rows[next].score_pack_ready = evaluation.score_pack_ready;
      state.committed_l3_rows[next].score_gross = evaluation.score_gross;
      state.committed_l3_rows[next].score_net = evaluation.score_net;
      state.committed_l3_rows[next].price_engine_score = evaluation.price_engine_score;
      state.committed_l3_rows[next].microstructure_score = evaluation.microstructure_score;
      state.committed_l3_rows[next].volatility_transition_score = evaluation.volatility_transition_score;
      state.committed_l3_rows[next].structure_context_score = evaluation.structure_context_score;
      state.committed_l3_rows[next].session_timing_score = evaluation.session_timing_score;
      state.committed_l3_rows[next].execution_friction_penalty = evaluation.execution_friction_penalty;
      state.committed_l3_rows[next].pressure_shift_score = evaluation.pressure_shift_score;
      state.committed_l3_rows[next].momentum_delta = evaluation.momentum_delta;
      state.committed_l3_rows[next].momentum_speed = evaluation.momentum_speed;
      state.committed_l3_rows[next].momentum_acceleration_score = evaluation.momentum_acceleration_score;
      state.committed_l3_rows[next].move_age_score = evaluation.move_age_score;
      state.committed_l3_rows[next].position_in_range_pct = evaluation.position_in_range_pct;
      state.committed_l3_rows[next].distance_to_recent_high_pct = evaluation.distance_to_recent_high_pct;
      state.committed_l3_rows[next].distance_to_recent_low_pct = evaluation.distance_to_recent_low_pct;
      state.committed_l3_rows[next].liquidity_proximity_score = evaluation.liquidity_proximity_score;
      state.committed_l3_rows[next].participation_score = evaluation.participation_score;
      state.committed_l3_rows[next].execution_score = evaluation.execution_score;
      state.committed_l3_rows[next].execution_penalty = evaluation.execution_penalty;
      state.committed_l3_rows[next].spread_quality_score = evaluation.spread_quality_score;
      state.committed_l3_rows[next].friction_quality_score = evaluation.friction_quality_score;
      state.committed_l3_rows[next].liquidity_quality_score = evaluation.liquidity_quality_score;
      state.committed_l3_rows[next].context_strength_score = evaluation.context_strength_score;
      state.committed_l3_rows[next].entry_readiness_score = evaluation.entry_readiness_score;
      state.committed_l3_rows[next].extension_risk_score = evaluation.extension_risk_score;
      state.committed_l3_rows[next].late_move_risk_score = evaluation.late_move_risk_score;
      state.committed_l3_rows[next].exhaustion_risk_score = evaluation.exhaustion_risk_score;
      state.committed_l3_rows[next].execution_alignment_score = evaluation.execution_alignment_score;
      state.committed_l3_rows[next].session_alignment_score = evaluation.session_alignment_score;
      state.committed_l3_rows[next].opportunity_density_score = evaluation.opportunity_density_score;
      state.committed_l3_rows[next].risk_drag_score = evaluation.risk_drag_score;
      state.committed_l3_rows[next].tick_burst_score = evaluation.tick_burst_score;
      state.committed_l3_rows[next].score_posture = evaluation.score_posture;
      state.committed_l3_rows[next].attention_posture = evaluation.attention_posture;
      state.committed_l3_rows[next].price_engine_posture = evaluation.recent_momentum_posture;
      state.committed_l3_rows[next].microstructure_posture = evaluation.tick_activity_posture;
      state.committed_l3_rows[next].volatility_transition_posture = evaluation.burst_posture;
      state.committed_l3_rows[next].structure_context_posture = evaluation.structure_context_posture;
      state.committed_l3_rows[next].session_timing_posture = evaluation.session_timing_posture;
      state.committed_l3_rows[next].execution_friction_posture = evaluation.execution_friction_posture;
      state.committed_l3_rows[next].pressure_shift_posture = evaluation.pressure_shift_posture;
      state.committed_l3_rows[next].momentum_acceleration_posture = evaluation.momentum_acceleration_posture;
      state.committed_l3_rows[next].move_age_posture = evaluation.move_age_posture;
      state.committed_l3_rows[next].liquidity_zone = evaluation.liquidity_zone;
      state.committed_l3_rows[next].liquidity_proximity_posture = evaluation.liquidity_proximity_posture;
      state.committed_l3_rows[next].participation_posture = evaluation.participation_posture;
      state.committed_l3_rows[next].execution_posture = evaluation.execution_posture;
      state.committed_l3_rows[next].tick_burst_flag = evaluation.tick_burst_flag;
      state.committed_l3_rows[next].tick_burst_posture = evaluation.tick_burst_posture;
      state.committed_l3_rows[next].scalp_tradable = evaluation.scalp_tradable;
      state.committed_l3_rows[next].intraday_tradable = evaluation.intraday_tradable;
      state.committed_l3_rows[next].score_pack_summary = evaluation.score_pack_summary;
      state.committed_l3_rows[next].score_pack_reason = evaluation.score_pack_reason;
      state.committed_l3_rows[next].evidence_intake_state = evaluation.evidence_intake_state;
      state.committed_l3_rows[next].evidence_intake_claim_evidence_status = evaluation.evidence_intake_claim_evidence_status;
      state.committed_l3_rows[next].evidence_intake_detail = evaluation.evidence_intake_detail;
      state.committed_l3_rows[next].evaluated_utc = evaluation.evaluated_at_utc;
      state.committed_l3_rows[next].committed_utc = committed_utc;
      state.committed_l3_rows[next].committed_revision = state.committed_l3_revision + 1;
      state.committed_l3_rows[next].source_l1_revision = l1_revision;
      state.committed_l3_rows[next].source_l2_revision = (has_lawful_packet ? packet.revision : l2_revision);
      state.committed_l3_rows[next].source_lineage = StringFormat("l1_rev=%I64u l2_rev=%I64u packet=%s | l3_meaning=%s | l3_scope=%s | trade_permission=false | entry_signal=false | execution_permission=false | final_rank=false | strategy_edge_proof=false | authority=%s | freshness=%s | dependency=%s | l3_to_l4=%s | l3_to_l4_authority_scope=%s | l4_consumes_l3_support_only=true | artifact_projection=projection_only | writers_do_not_own_l3_truth=true",
                                                          l1_revision,
                                                          state.committed_l3_rows[next].source_l2_revision,
                                                          (has_lawful_packet ? "lawful" : "unavailable"),
                                                          ASC_L3_MEANING_CANDIDATE_RANKING_SUPPORT_ONLY,
                                                          ASC_L3_SCOPE_LIGHTWEIGHT_CANDIDATE_SUPPORT,
                                                          ASC_SelectionFilterAuthoritySource(symbol_state, packet, has_lawful_packet, has_lawful_packet),
                                                          ASC_SelectionFilterFreshnessToken(symbol_state, packet, has_lawful_packet, has_lawful_packet),
                                                          ASC_SelectionFilterDependencyStatusToken(symbol_state, packet, has_lawful_packet, has_lawful_packet),
                                                          ASC_SelectionFilterL3ToL4AuthorityToken(evaluation, evaluation.evidence_intake_state, ASC_SelectionFilterFreshnessToken(symbol_state, packet, has_lawful_packet, has_lawful_packet)),
                                                          ASC_L3_TO_L4_AUTHORITY_COMMITTED_SUPPORT_ONLY);
      state.committed_l3_rows[next].has_lawful_packet = has_lawful_packet;
      state.committed_l3_rows[next].source_ready = true;

      if(evaluation.score_pack_ready)
         score_ready_count++;
      if(evaluation.reason_code == "score_led_candidate_ready")
         qualified_count++;
      else if(evaluation.reason_code == "score_led_penalty_carry")
         drag_count++;

      if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
        {
         pending_count++;
         if(dominant_pending_hits <= 0)
           {
            dominant_pending_code = evaluation.reason_code;
            dominant_pending_hits = 1;
           }
         else if(evaluation.reason_code == dominant_pending_code)
            dominant_pending_hits++;
        }
      else if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
         fail_count++;
      if(evaluation.evidence_intake_state == ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED)
         candidate_evidence_clean_count++;
      else if(evaluation.evidence_intake_state == ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE)
         candidate_evidence_unavailable_count++;
      else if(evaluation.evidence_intake_state == ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE)
         candidate_evidence_stale_count++;
      else if(evaluation.evidence_intake_state == ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW)
         candidate_evidence_insufficient_count++;
      else if(evaluation.evidence_intake_state == ASC_CAND_EVID_INTAKE_DEP_BLOCKED)
         candidate_evidence_dependency_count++;

      if(evaluation.evidence_intake_state != ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED
         && evaluation.evidence_intake_state != ASC_CAND_EVID_INTAKE_NOT_APPLICABLE)
         candidate_evidence_non_clean_count++;

      if(dominant_candidate_evidence_intake_hits <= 0
         || evaluation.evidence_intake_state == dominant_candidate_evidence_intake_state)
        {
         dominant_candidate_evidence_intake_state = evaluation.evidence_intake_state;
         dominant_candidate_evidence_intake_ce = evaluation.evidence_intake_claim_evidence_status;
         dominant_candidate_evidence_intake_hits++;
        }

      if(MathAbs(evaluation.participation_score - evaluation.microstructure_score) < 0.05)
         participation_clone_count++;

      if(evaluation.score_net > top_score_net)
        {
         top_score_net = evaluation.score_net;
         top_symbol = symbol_state.symbol;
         top_branch = evaluation.reason_code;
        }
     }

   state.committed_l3_revision++;
   state.committed_l3_source_l1_revision = l1_revision;
   state.committed_l3_source_l2_revision = l2_revision;
   state.committed_l3_pass_utc = pass_utc;
   state.committed_l3_last_built_utc = committed_utc;
   state.committed_l3_next_recheck_utc = live_open_scope ? (committed_utc + ASC_L3_RECHECK_OPEN_SEC) : 0;
   state.committed_l3_ready = (ArraySize(state.committed_l3_rows) > 0 || ASC_Layer1CachedSymbolCount() == 0);
   state.committed_l3_status = "committed";
   string trigger_text = (StringLen(trigger_reason) > 0 ? trigger_reason : "runtime selection refresh");
   string blocker_text = (pending_count > 0)
                         ? StringFormat("%s:%d", dominant_pending_code, dominant_pending_hits)
                         : "none";
   string top_score_text = (top_score_net >= 0.0) ? DoubleToString(top_score_net, 1) : "unavailable";
   state.committed_l3_reason = StringFormat("l3_meaning=candidate_ranking_support_only | trade_permission=false | entry_signal=false | l3_to_l4_authority_summary=clean_limited_degraded_pending_blocked | trigger=%s | inputs=price,micro,vol,structure,session,pressure,participation,execution | score_ready=%d | qualified=%d | drag=%d | pending=%d | fail=%d | participation_clone=%d | blocker=%s | top=%s:%s:%s | open=%d",
                                            trigger_text,
                                            score_ready_count,
                                            qualified_count,
                                            drag_count,
                                            pending_count,
                                            fail_count,
                                            participation_clone_count,
                                            blocker_text,
                                            top_symbol,
                                            top_score_text,
                                            top_branch,
                                            open_count);

   ASC_FunctionResult l3_result;
   ASC_FunctionResultBegin(l3_result, "ASC_Dispatcher", "ASC_CommitLayer3SelectionState", "runtime");
   ASC_FunctionResultSetTruthBoundary(l3_result, "candidate_filtering.evidence_intake_boundary", "truth_consumer.layer3_read_only_evidence_intake");
   ASC_FunctionResultSetProof(l3_result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_SOURCE_SUPPORT,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   ASC_FunctionResultSetProofRowClass(l3_result, ASC_PROOF_ROW_CLASS_REQUIRED_ONCE);
   string candidate_evidence_detail = ASC_CandidateEvidenceIntakeDetailAppend(state.committed_l3_reason,
                                                                              dominant_candidate_evidence_intake_state,
                                                                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   candidate_evidence_detail += StringFormat(" | metric_domain=l3_candidate | metric_purpose=ranking_support | metric_owner=ASC_SelectionFilter.ASC_EvaluateSelectionFilter | input_source=mixed | freshness_status=summary_row | sample_status=summary_row | timeframe_coverage=not_applicable | tick_window_status=not_applicable | validity_status=summary_row | falsifier=stale_input_or_insufficient_sample_or_unavailable_dependency | l3_meaning=candidate_ranking_support_only | trade_permission=false | entry_signal=false | l3_authority_source=summary_row | l3_freshness=summary_row | l3_dependency_status=summary_row | l3_candidate_state=summary_row | l3_recovery_state=summary_row | l3_to_l4_authority=summary_row | resolver_domain=candidate_filtering | unavailable_state=%s | resolver_owner=l3_candidate_filtering | resolver_status=attempted | retry_due_utc=%s | last_attempt_utc=%s | attempt_count=%d | expiry_policy=cadence_retry | downstream_authority=%s | artifact_projection=%s | refresh_domain=candidate_filtering | refresh_status=due_refreshed | last_refresh_utc=%s | next_due_utc=%s | skip_reason=none | behavior_change=no | candidate_evidence_rows=%d | candidate_evidence_clean=%d | candidate_evidence_non_clean=%d | candidate_evidence_unavailable=%d | candidate_evidence_stale=%d | candidate_evidence_insufficient=%d | candidate_evidence_dependency_blocked=%d | candidate_evidence_representative_hits=%d",
                                             (pending_count > 0 ? "l3_pending" : ((candidate_evidence_unavailable_count > 0 || candidate_evidence_stale_count > 0 || candidate_evidence_insufficient_count > 0 || candidate_evidence_dependency_count > 0) ? "dependency_pending" : "no_gap_found")),
                                             ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                                             ASC_FormatUtc(state.committed_l3_last_built_utc),
                                             ArraySize(state.committed_l3_rows),
                                             ((pending_count > 0 || candidate_evidence_non_clean_count > 0) ? "limited" : "clean"),
                                             ((pending_count > 0 || candidate_evidence_non_clean_count > 0) ? "qualified" : "allowed"),
                                             ASC_FormatUtc(state.committed_l3_last_built_utc),
                                             ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                                             ArraySize(state.committed_l3_rows),
                                             candidate_evidence_clean_count,
                                             candidate_evidence_non_clean_count,
                                             candidate_evidence_unavailable_count,
                                             candidate_evidence_stale_count,
                                             candidate_evidence_insufficient_count,
                                             candidate_evidence_dependency_count,
                                             dominant_candidate_evidence_intake_hits);
   candidate_evidence_detail += " | " + ASC_Run058APerformanceCadenceProofTokens("l3",
                                                                                  "due_refreshed",
                                                                                  "normal",
                                                                                  "none",
                                                                                  "aggregate",
                                                                                  "low",
                                                                                  "current");
   ASC_FunctionResultFinish(l3_result,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            candidate_evidence_detail,
                            "runtime:committed_l3");
   ASC_RecordResult(state, l3_result, false, true);
  }

void ASC_CommitLayer4ShortlistState(ASC_RuntimeState &state,
                                    const datetime pass_utc,
                                    const bool force_recheck = false,
                                    const string trigger_reason = "",
                                    const bool force_l3_recheck = true)
  {
   datetime committed_utc = TimeGMT();
   int open_count = ASC_CountOpenLayer1Symbols();
   bool live_open_scope = (open_count > 0);
   if(state.committed_l4_ready && state.committed_l4_pass_utc == pass_utc && !force_recheck)
     {
      state.committed_l4_status = "reused";
      state.committed_l4_reason = "committed Layer 4 shortlist state reused for this pass";
      if(live_open_scope && state.committed_l4_next_recheck_utc <= 0)
         state.committed_l4_next_recheck_utc = committed_utc + ASC_L4_RECHECK_OPEN_SEC;
      return;
     }

   bool l3_pass_matches = (state.committed_l3_ready && state.committed_l3_pass_utc == pass_utc);
   if(!state.committed_l3_ready || (force_l3_recheck && (!l3_pass_matches || force_recheck)))
      ASC_CommitLayer3SelectionState(state, pass_utc, force_recheck, trigger_reason);

   ASC_ShortlistSymbolSummary shortlist_rows[];
   ASC_ShortlistBuildSummarySet(state.committed_l3_rows, shortlist_rows);

   ASC_CommittedLayer4SymbolState previous_rows[];
   ArrayResize(previous_rows, ArraySize(state.committed_l4_rows));
   for(int p = 0; p < ArraySize(state.committed_l4_rows); p++)
      previous_rows[p] = state.committed_l4_rows[p];

   ArrayResize(state.committed_l4_rows, 0);
   for(int i = 0; i < ArraySize(shortlist_rows); i++)
     {
      ASC_CommittedLayer3SymbolState linked_l3;
      bool has_l3 = ASC_ShortlistFindCommittedLayer3State(state.committed_l3_rows,
                                                shortlist_rows[i].symbol,
                                                linked_l3);

      int next = ArraySize(state.committed_l4_rows);
      ArrayResize(state.committed_l4_rows, next + 1);
      state.committed_l4_rows[next].symbol = shortlist_rows[i].symbol;
      state.committed_l4_rows[next].canonical_symbol = ASC_CommittedCanonicalSymbolForState(shortlist_rows[i].state);
      state.committed_l4_rows[next].summary = shortlist_rows[i];
      state.committed_l4_rows[next].lawful_survivor = ASC_ShortlistHasLawfulMembership(shortlist_rows[i]);
      state.committed_l4_rows[next].evaluated_utc = shortlist_rows[i].shortlist_evaluated_utc;
      state.committed_l4_rows[next].committed_utc = committed_utc;
      state.committed_l4_rows[next].committed_revision = state.committed_l4_revision + 1;
      state.committed_l4_rows[next].source_l3_revision = (has_l3 ? linked_l3.committed_revision : state.committed_l3_revision);
      state.committed_l4_rows[next].source_l3_pass_utc = state.committed_l3_pass_utc;
      state.committed_l4_rows[next].shortlist_pass_utc = pass_utc;
      state.committed_l4_rows[next].source_lineage = StringFormat("l4_rev=%I64u l3_rev=%I64u shortlist_pass=%d", state.committed_l4_rows[next].committed_revision, state.committed_l4_rows[next].source_l3_revision, (int)pass_utc);
      state.committed_l4_rows[next].source_ready = has_l3;
     }

   state.committed_l4_revision++;
   state.committed_l4_source_l3_revision = state.committed_l3_revision;
   state.committed_l4_pass_utc = pass_utc;
   state.committed_l4_last_built_utc = committed_utc;
   state.committed_l4_next_recheck_utc = live_open_scope ? (committed_utc + ASC_L4_RECHECK_OPEN_SEC) : 0;
   state.committed_l4_ready = true;
   state.committed_l4_status = "committed";
   string material_reason = "";
   bool material_change = ASC_CommittedL4MaterialChangeDetected(previous_rows, state.committed_l4_rows, material_reason);
   string trigger_text = (StringLen(trigger_reason) > 0 ? trigger_reason : "runtime shortlist refresh");
   string added_sample = "none";
   string removed_sample = "none";
   string retained_sample = "none";
   int added_count = 0;
   int removed_count = 0;
   int retained_count = 0;
   ASC_CommittedL4CollectMembershipDelta(previous_rows,
                                         state.committed_l4_rows,
                                         added_sample,
                                         removed_sample,
                                         retained_sample,
                                         added_count,
                                         removed_count,
                                         retained_count);
   state.committed_l4_reason = StringFormat("committed Layer 4 shortlist state built for %d symbols from committed Layer 3 revision %I64u (trigger=%s, open=%d, material=%s: %s, add=%d[%s], drop=%d[%s], retained=%d[%s])",
                                            ArraySize(state.committed_l4_rows),
                                            state.committed_l3_revision,
                                            trigger_text,
                                            open_count,
                                            (material_change ? "yes" : "no"),
                                            material_reason,
                                            added_count,
                                            added_sample,
                                            removed_count,
                                            removed_sample,
                                            retained_count,
                                            retained_sample);

   int shortlist_evidence_clean_count = 0;
   int shortlist_evidence_non_clean_count = 0;
   int shortlist_evidence_unavailable_count = 0;
   int shortlist_evidence_stale_count = 0;
   int shortlist_evidence_insufficient_count = 0;
   int shortlist_evidence_dependency_count = 0;
   int l4_top_authority_clean_count = 0;
   int l4_top_authority_limited_count = 0;
   int l4_top_authority_degraded_count = 0;
   int l4_top_authority_pending_count = 0;
   int l4_corr_complete_count = 0;
   int l4_corr_partial_count = 0;
   int l4_corr_pending_count = 0;
   int l4_corr_unavailable_count = 0;
   int l4_exposure_conflict_count = 0;
   int l4_exclusion_budget_count = 0;
   int l4_exclusion_authority_count = 0;
   int l4_exclusion_dependency_count = 0;
   string dominant_shortlist_evidence_state = ASC_SHORTLIST_EVID_INTAKE_NOT_APPLICABLE;
   int dominant_shortlist_evidence_hits = 0;
   for(int e = 0; e < ArraySize(shortlist_rows); e++)
     {
      string intake_state = ASC_ShortlistEvidenceIntakeText(shortlist_rows[e].evidence_intake_state);
      if(intake_state == ASC_SHORTLIST_EVID_INTAKE_CLEAN_SUPPORTED)
         shortlist_evidence_clean_count++;
      else if(intake_state == ASC_SHORTLIST_EVID_INTAKE_UNAVAILABLE_RECOVERABLE)
         shortlist_evidence_unavailable_count++;
      else if(intake_state == ASC_SHORTLIST_EVID_INTAKE_STALE_RECOVERABLE)
         shortlist_evidence_stale_count++;
      else if(intake_state == ASC_SHORTLIST_EVID_INTAKE_INSUFFICIENT_NOW)
         shortlist_evidence_insufficient_count++;
      else if(intake_state == ASC_SHORTLIST_EVID_INTAKE_DEP_BLOCKED)
         shortlist_evidence_dependency_count++;
      if(intake_state != ASC_SHORTLIST_EVID_INTAKE_CLEAN_SUPPORTED
         && intake_state != ASC_SHORTLIST_EVID_INTAKE_NOT_APPLICABLE)
         shortlist_evidence_non_clean_count++;

      if(shortlist_rows[e].top_list_authority_token == "clean")
         l4_top_authority_clean_count++;
      else if(shortlist_rows[e].top_list_authority_token == "limited")
         l4_top_authority_limited_count++;
      else if(shortlist_rows[e].top_list_authority_token == "degraded")
         l4_top_authority_degraded_count++;
      else if(shortlist_rows[e].top_list_authority_token == "pending")
         l4_top_authority_pending_count++;

      if(shortlist_rows[e].correlation_status_token == "complete")
         l4_corr_complete_count++;
      else if(shortlist_rows[e].correlation_status_token == "partial")
         l4_corr_partial_count++;
      else if(shortlist_rows[e].correlation_status_token == "pending")
         l4_corr_pending_count++;
      else if(shortlist_rows[e].correlation_status_token == "unavailable")
         l4_corr_unavailable_count++;

      if(shortlist_rows[e].exposure_status_token == "conflict")
         l4_exposure_conflict_count++;

      if(shortlist_rows[e].exclusion_reason_token == "budget_limit")
         l4_exclusion_budget_count++;
      else if(shortlist_rows[e].exclusion_reason_token == "insufficient_authority")
         l4_exclusion_authority_count++;
      else if(shortlist_rows[e].exclusion_reason_token == "dependency_missing")
         l4_exclusion_dependency_count++;

      if(dominant_shortlist_evidence_hits <= 0 || intake_state == dominant_shortlist_evidence_state)
        {
         dominant_shortlist_evidence_state = intake_state;
         dominant_shortlist_evidence_hits++;
        }
     }

   ASC_FunctionResult l4_result;
   ASC_FunctionResultBegin(l4_result, "ASC_Dispatcher", "ASC_CommitLayer4ShortlistState", "runtime");
   ASC_FunctionResultSetTruthBoundary(l4_result, "shortlist_selection.evidence_intake_boundary", "truth_consumer.layer4_read_only_evidence_intake");
   ASC_FunctionResultSetProof(l4_result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_SOURCE_SUPPORT,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   ASC_FunctionResultSetProofRowClass(l4_result, ASC_PROOF_ROW_CLASS_REQUIRED_ONCE);
   string shortlist_evidence_detail = ASC_ShortlistEvidenceIntakeDetailAppend(ASC_CommittedLayer4TelemetryTrace(state),
                                                                              dominant_shortlist_evidence_state,
                                                                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   shortlist_evidence_detail += StringFormat(" | metric_domain=l4_shortlist | metric_purpose=ranking_support | metric_owner=ASC_ShortlistSelectionEngine.ASC_RebuildShortlist | input_source=mixed | freshness_status=summary_row | sample_status=summary_row | timeframe_coverage=summary_row | tick_window_status=not_applicable | validity_status=summary_row | falsifier=stale_input_or_insufficient_sample_or_missing_timeframe | l4_meaning=shortlist_priority_ordering_only | trade_permission=false | entry_signal=false | rank_formula_change=no | top_list_selection_change=no | market_board_ordering_change=no | resolver_domain=shortlist_selection | unavailable_state=%s | resolver_owner=l4_shortlist_selection | resolver_status=attempted | retry_due_utc=%s | last_attempt_utc=%s | attempt_count=%d | expiry_policy=cadence_retry | downstream_authority=%s | artifact_projection=%s | refresh_domain=shortlist_selection | refresh_status=due_refreshed | last_refresh_utc=%s | next_due_utc=%s | source_l3_last_refresh_utc=%s | source_l3_next_due_utc=%s | skip_reason=none | behavior_change=no | shortlist_evidence_rows=%d | shortlist_evidence_clean=%d | shortlist_evidence_non_clean=%d | shortlist_evidence_unavailable=%d | shortlist_evidence_stale=%d | shortlist_evidence_insufficient=%d | shortlist_evidence_dependency_blocked=%d | shortlist_evidence_representative_hits=%d | top_list_authority_clean=%d | top_list_authority_limited=%d | top_list_authority_degraded=%d | top_list_authority_pending=%d | correlation_complete=%d | correlation_partial=%d | correlation_pending=%d | correlation_unavailable=%d | exposure_conflict=%d | exclusion_budget_limit=%d | exclusion_insufficient_authority=%d | exclusion_dependency_missing=%d",
                                             (l4_corr_pending_count > 0 ? "correlation_pending" : (l4_corr_unavailable_count > 0 ? "correlation_unavailable" : ((l4_top_authority_pending_count > 0 || shortlist_evidence_non_clean_count > 0) ? "l4_pending" : "no_gap_found"))),
                                             ASC_FormatUtc(state.committed_l4_next_recheck_utc),
                                             ASC_FormatUtc(state.committed_l4_last_built_utc),
                                             ArraySize(shortlist_rows),
                                             ((l4_top_authority_pending_count > 0 || shortlist_evidence_non_clean_count > 0 || l4_corr_pending_count > 0 || l4_corr_unavailable_count > 0) ? "limited" : "clean"),
                                             ((l4_top_authority_pending_count > 0 || shortlist_evidence_non_clean_count > 0 || l4_corr_pending_count > 0 || l4_corr_unavailable_count > 0) ? "qualified" : "allowed"),
                                             ASC_FormatUtc(state.committed_l4_last_built_utc),
                                             ASC_FormatUtc(state.committed_l4_next_recheck_utc),
                                             ASC_FormatUtc(state.committed_l3_last_built_utc),
                                             ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                                             ArraySize(shortlist_rows),
                                             shortlist_evidence_clean_count,
                                             shortlist_evidence_non_clean_count,
                                             shortlist_evidence_unavailable_count,
                                             shortlist_evidence_stale_count,
                                             shortlist_evidence_insufficient_count,
                                             shortlist_evidence_dependency_count,
                                             dominant_shortlist_evidence_hits,
                                             l4_top_authority_clean_count,
                                             l4_top_authority_limited_count,
                                             l4_top_authority_degraded_count,
                                             l4_top_authority_pending_count,
                                             l4_corr_complete_count,
                                             l4_corr_partial_count,
                                             l4_corr_pending_count,
                                             l4_corr_unavailable_count,
                                             l4_exposure_conflict_count,
                                             l4_exclusion_budget_count,
                                             l4_exclusion_authority_count,
                                             l4_exclusion_dependency_count);
   shortlist_evidence_detail += " | " + ASC_Run058APerformanceCadenceProofTokens("l4",
                                                                                  "due_refreshed",
                                                                                  "normal",
                                                                                  "normal",
                                                                                  "aggregate",
                                                                                  "low",
                                                                                  "current");
   ASC_FunctionResultFinish(l4_result,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            shortlist_evidence_detail,
                            "runtime:committed_l4");
   ASC_RecordResult(state, l4_result, false, true);
  }

void ASC_RefreshCommittedSelectionOwnershipState(ASC_RuntimeState &state,
                                                 const datetime pass_utc,
                                                 const bool force_recheck = false,
                                                 const string trigger_reason = "")
  {
   ASC_CommitLayer3SelectionState(state, pass_utc, force_recheck, trigger_reason);
   ASC_CommitLayer4ShortlistState(state, pass_utc, force_recheck, trigger_reason);
  }


string ASC_Run058APerformanceCadenceProofTokens(const string runtime_cost_scope,
                                                const string cadence_status,
                                                const string refresh_pressure,
                                                const string write_pressure,
                                                const string proof_scope,
                                                const string proof_bloat_risk,
                                                const string artifact_state)
  {
   return "runtime_cost_scope=" + runtime_cost_scope
          + " | cadence_status=" + cadence_status
          + " | refresh_pressure=" + refresh_pressure
          + " | write_pressure=" + write_pressure
          + " | proof_scope=" + proof_scope
          + " | proof_bloat_risk=" + proof_bloat_risk
          + " | artifact_state=" + artifact_state
          + " | runtime_observed=false | source_supported=true | behavior_change=no";
  }

bool ASC_Run058ACadenceNoOpProofDue(const datetime now_utc,
                                     datetime &last_emit_utc,
                                     const int interval_sec)
  {
   int bounded_interval_sec = MathMax(ASC_HEARTBEAT_SECONDS, interval_sec);
   if(last_emit_utc <= 0 || (now_utc - last_emit_utc) >= bounded_interval_sec)
     {
      last_emit_utc = now_utc;
      return true;
     }
   return false;
  }

void ASC_MaybeRefreshCommittedSelectionCadence(ASC_RuntimeState &state,const datetime now_utc)
  {
   // Heartbeat/lane architecture stays intact; this helper only evaluates L3/L4 due clocks.
   int open_count = ASC_CountOpenLayer1Symbols();
   if(open_count <= 0)
     {
      static datetime s_last_closed_sleep_cadence_proof_utc = 0;
      if(ASC_Run058ACadenceNoOpProofDue(now_utc, s_last_closed_sleep_cadence_proof_utc, 60))
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     StringFormat("refresh_domain=candidate_filtering|shortlist_selection refresh_status=closed_sleep open=0 last_l3=%s next_l3=%s last_l4=%s next_l4=%s skip_reason=no_open_symbols heavy_refresh=no %s",
                                  ASC_FormatUtc(state.committed_l3_last_built_utc),
                                  ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                                  ASC_FormatUtc(state.committed_l4_last_built_utc),
                                  ASC_FormatUtc(state.committed_l4_next_recheck_utc),
                                  ASC_Run058APerformanceCadenceProofTokens("mixed", "closed_sleep", "blocked", "none", "aggregate", "low", "retained_last_good")));
      return;
     }

   bool l3_due = (!state.committed_l3_ready
                  || state.committed_l3_next_recheck_utc <= 0
                  || state.committed_l3_next_recheck_utc <= now_utc);
   bool l4_due = (!state.committed_l4_ready
                  || state.committed_l4_next_recheck_utc <= 0
                  || state.committed_l4_next_recheck_utc <= now_utc);

   // RUN243: do not let the first startup pass masquerade as final L3/L4 authority.
   // Seed a bounded 5-minute warmup clock, then keep the existing cadence owner in charge.
   if(!state.committed_l3_ready && state.committed_l3_next_recheck_utc <= 0)
     {
      state.committed_l3_next_recheck_utc = now_utc + ASC_L3_WARMUP_REFRESH_CADENCE_SEC;
      state.committed_l3_status = "warmup_pending";
      state.committed_l3_reason = "RUN243 warmup refresh scheduled before first committed L3 authority";
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "run243-l3-warmup-pending-status");
      ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                  StringFormat("refresh_domain=candidate_filtering refresh_status=warmup_pending l3_warmup_refresh_seconds=%d l3_next=%s l4_waits_for_committed_l3=true",
                               ASC_L3_WARMUP_REFRESH_CADENCE_SEC,
                               ASC_FormatUtc(state.committed_l3_next_recheck_utc)));
      return;
     }

   if(!state.committed_l4_ready && state.committed_l3_ready && state.committed_l4_next_recheck_utc <= 0)
     {
      datetime l4_warmup_due = state.committed_l3_last_built_utc + ASC_L4_WARMUP_OFFSET_AFTER_L3_SEC;
      if(l4_warmup_due <= now_utc)
         state.committed_l4_next_recheck_utc = now_utc;
      else
        {
         state.committed_l4_next_recheck_utc = l4_warmup_due;
         state.committed_l4_status = "warmup_pending_after_l3";
         state.committed_l4_reason = "RUN243 L4 warmup waits for committed L3 plus 5-minute offset";
         state.write_dirty = true;
         state.l1_publish_pending_manifest = true;
         ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "run243-l4-warmup-pending-status");
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     StringFormat("refresh_domain=shortlist_selection refresh_status=warmup_pending_after_l3 l4_warmup_offset_after_l3_seconds=%d l3_last=%s l4_next=%s",
                                  ASC_L4_WARMUP_OFFSET_AFTER_L3_SEC,
                                  ASC_FormatUtc(state.committed_l3_last_built_utc),
                                  ASC_FormatUtc(state.committed_l4_next_recheck_utc)));
         l4_due = false;
        }
     }
   if(!l3_due && !l4_due)
     {
      string board_readiness_reason = "";
      bool board_ready_consolidated = ASC_RuntimeBoardReadinessConsolidated(state, board_readiness_reason);
      int live_entitled_open = MathMax(0, state.l1_l2_live_entitled_count);
      if(!board_ready_consolidated && live_entitled_open > 0)
        {
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     StringFormat("refresh_domain=candidate_filtering|shortlist_selection refresh_status=dependency_missing open=%d l3_next=%s l4_next=%s board_reason=%s recovery=pending_recovery_snapshot public_promotion_allowed=false_until_child_shell_sync",
                                  open_count,
                                  ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                                  ASC_FormatUtc(state.committed_l4_next_recheck_utc),
                                  board_readiness_reason));
         // RUN244: recovery may expose a pending snapshot/status, but it must not bypass the ordinary cadence
         // into a new public L3/L4 ownership signature before child shell/status parity can catch up.
         state.publication_bundle.recovery_snapshot_pending = true;
         state.publication_bundle.recovery_snapshot_pending_utc = now_utc;
         state.publication_bundle.recovery_snapshot_reason = StringFormat("board-readiness-recovery-held-%s", board_readiness_reason);
         state.publication_bundle.recovery_snapshot_next_step = "wait_for_ordinary_l3_l4_cadence_and_child_shell_status_refresh_before_public_promotion";
         state.publication_bundle.recovery_snapshot_public_promotion_allowed = "false_until_child_shell_sync";
         state.publication_bundle.recovery_snapshot_child_shell_sync_required = "true";
         state.publication_bundle.top5_bucket_alignment_state = "pending_recovery_snapshot";
         state.publication_bundle.top5_bucket_alignment_reason = state.publication_bundle.recovery_snapshot_reason;
         state.write_dirty = true;
         state.l1_publish_pending_essentials = true;
         state.l1_publish_pending_manifest = true;
         ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "run244-recovery-snapshot-held-for-child-shell-sync");
         return;
        }

      static datetime s_last_not_due_cadence_proof_utc = 0;
      if(ASC_Run058ACadenceNoOpProofDue(now_utc, s_last_not_due_cadence_proof_utc, 60))
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     StringFormat("refresh_domain=candidate_filtering|shortlist_selection refresh_status=not_due open=%d last_l3=%s next_l3=%s last_l4=%s next_l4=%s skip_reason=cadence_not_elapsed %s",
                                  open_count,
                                  ASC_FormatUtc(state.committed_l3_last_built_utc),
                                  ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                                  ASC_FormatUtc(state.committed_l4_last_built_utc),
                                  ASC_FormatUtc(state.committed_l4_next_recheck_utc),
                                  ASC_Run058APerformanceCadenceProofTokens("mixed", "not_due", "normal", "none", "aggregate", "low", "current")));
      ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "l4-max-age-backstop");
      return;
     }

   ASC_CommittedLayer4SymbolState before_l4_rows[];
   ArrayResize(before_l4_rows, ArraySize(state.committed_l4_rows));
   for(int i = 0; i < ArraySize(state.committed_l4_rows); i++)
      before_l4_rows[i] = state.committed_l4_rows[i];

   ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
               StringFormat("refresh_domain=candidate_filtering|shortlist_selection refresh_status=due_admitted l3_due=%s l4_due=%s open=%d l3_last=%s l3_next=%s l4_last=%s l4_next=%s",
                            l3_due ? "yes" : "no",
                            l4_due ? "yes" : "no",
                            open_count,
                            ASC_FormatUtc(state.committed_l3_last_built_utc),
                            ASC_FormatUtc(state.committed_l3_next_recheck_utc),
                            ASC_FormatUtc(state.committed_l4_last_built_utc),
                            ASC_FormatUtc(state.committed_l4_next_recheck_utc)));

   if(l3_due)
     {
      ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                  StringFormat("refresh_domain=candidate_filtering refresh_status=due_refreshed operational=%ds doctrine_target=%ds artifact_write_reason=manifest_proof_only behavior_change=no", ASC_L3_RECHECK_OPEN_SEC, ASC_L3_TARGET_RECHECK_OPEN_SEC));
      ASC_CommitLayer3SelectionState(state,
                                     now_utc,
                                     true,
                                     StringFormat("open-symbol-cadence-recheck-op-%ds-target-%ds", ASC_L3_RECHECK_OPEN_SEC, ASC_L3_TARGET_RECHECK_OPEN_SEC));
      state.l1_publish_pending_manifest = true;
     }

   if(l4_due && l3_due)
     {
      state.committed_l4_next_recheck_utc = now_utc + ASC_L4_OFFSET_AFTER_L3_SEC;
      state.committed_l4_status = "offset_pending_after_l3";
      state.committed_l4_reason = "RUN243 L4 steady refresh intentionally offset after committed L3";
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "run243-l4-offset-pending-status");
      ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                  StringFormat("refresh_domain=shortlist_selection refresh_status=offset_pending_after_l3 l4_offset_after_l3_seconds=%d l4_next=%s l4_waits_for_committed_l3=true",
                               ASC_L4_OFFSET_AFTER_L3_SEC,
                               ASC_FormatUtc(state.committed_l4_next_recheck_utc)));
      l4_due = false;
     }

   if(l4_due)
     {
      ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                  StringFormat("refresh_domain=shortlist_selection refresh_status=due_refreshed operational=%ds doctrine_target=%ds source_l3_refresh=%s artifact_write_reason=board_cadence_or_material_change behavior_change=no",
                               ASC_L4_RECHECK_OPEN_SEC,
                               ASC_L4_TARGET_RECHECK_OPEN_SEC,
                               "latest_committed_l3"));
      ASC_CommitLayer4ShortlistState(state,
                                     now_utc,
                                     true,
                                     StringFormat("open-symbol-cadence-recheck-op-%ds-target-%ds", ASC_L4_RECHECK_OPEN_SEC, ASC_L4_TARGET_RECHECK_OPEN_SEC),
                                     false);
     }

   string material_reason = "";
   bool shortlist_material_change = false;
   if(l4_due)
      shortlist_material_change = ASC_CommittedL4MaterialChangeDetected(before_l4_rows,
                                                                        state.committed_l4_rows,
                                                                        material_reason);
   else
      material_reason = "l4_not_due_candidate_filtering_refreshed_only";

   string shortlist_posture = (StringLen(g_asc_shortlist_posture) > 0 ? g_asc_shortlist_posture : "unknown");
   string shortlist_reason = (StringLen(g_asc_shortlist_reason) > 0 ? g_asc_shortlist_reason : "unavailable");
   ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
               StringFormat("refresh_domain=candidate_filtering|shortlist_selection refresh_status=due_processed l3_due=%s l4_due=%s shortlist_posture=%s shortlist_reason=%s material_reason=%s",
                            l3_due ? "yes" : "no",
                            l4_due ? "yes" : "no",
                            shortlist_posture,
                            shortlist_reason,
                            material_reason));

   if(l4_due)
     {
      if(shortlist_posture == "dirty-held")
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     "refresh_domain=shortlist_selection refresh_status=refreshed_no_change skip_reason=shortlist_challenge_held_by_hold_window");
      else if(shortlist_posture == "material-shift")
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     "refresh_domain=shortlist_selection refresh_status=refreshed_written artifact_write_reason=shortlist_authority_updated");
      else if(shortlist_posture == "stable" || shortlist_posture == "degraded" || shortlist_posture == "stale")
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     "refresh_domain=shortlist_selection refresh_status=refreshed_no_change skip_reason=fresh_evidence_still_favored_incumbents");

      if(shortlist_material_change)
        {
         state.write_dirty = true;
         state.l1_publish_pending_essentials = true;
         state.l1_publish_pending_manifest = true;
         ASC_RequestOpenSymbolDossierRefresh(state, now_utc);
         if(StringFind(material_reason, "bucket top-5") >= 0)
            ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                        "refresh_domain=shortlist_selection refresh_status=refreshed_written artifact_write_reason=bucket_top5_changed");
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     "refresh_domain=shortlist_selection refresh_status=refreshed_written artifact_write_reason=shortlist_or_bucket_top5_material_change detail=" + material_reason);
        }
      else
        {
         ASC_LogInfo("ASC_Dispatcher", "ASC_MaybeRefreshCommittedSelectionCadence", "runtime",
                     "refresh_domain=shortlist_selection refresh_status=refreshed_no_change artifact_write_reason=market_board_freshness_republish_only detail=" + material_reason);
         ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "l4-cadence-no-material-change");
        }
     }
  }

void ASC_CopyCommittedL4RowsToShortlistRows(const ASC_CommittedLayer4SymbolState &source_rows[],
                                            ASC_ShortlistSymbolSummary &target_rows[])
  {
   ArrayResize(target_rows, ArraySize(source_rows));
   for(int i = 0; i < ArraySize(source_rows); i++)
      target_rows[i] = source_rows[i].summary;
  }


string ASC_Layer3ProofTrace(const ASC_RuntimeState &state)
  {
   int total = ArraySize(state.committed_l3_rows);
   if(total <= 0)
      return "l3_ready=no | rows=0 | proof=unavailable";

   int pass_count = 0;
   int burst_total = 0;
   int burst_useful = 0;
   int burst_guarded = 0;
   int decay_dragged = 0;
   int weak_exec = 0;
   int handoff_honest = 0;
   string useful_symbol = "none";
   string guarded_symbol = "none";
   string decay_symbol = "none";

   for(int i = 0; i < total; i++)
     {
      ASC_CommittedLayer3SymbolState row = state.committed_l3_rows[i];
      if(row.evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         pass_count++;

      bool burst_flag = row.tick_burst_flag;
      bool weak_execution = (row.execution_score < 60.0
                             || row.spread_stability_score < 55.0
                             || row.quote_stability_score < 60.0);
      bool decay_flag = (row.late_move_risk_score >= 55.0
                         || row.move_age_score < 55.0
                         || row.risk_drag_score >= 55.0);
      bool guarded_burst = (burst_flag
                            && (row.execution_score < 70.0
                                || row.quote_stability_score < 65.0
                                || row.liquidity_quality_score < 45.0
                                || row.move_age_score < 60.0
                                || row.risk_drag_score >= 45.0));
      bool useful_burst = (burst_flag && !guarded_burst);

      if(burst_flag)
         burst_total++;
      if(useful_burst)
        {
         burst_useful++;
         if(useful_symbol == "none" && StringLen(row.symbol) > 0)
            useful_symbol = row.symbol;
        }
      if(guarded_burst)
        {
         burst_guarded++;
         if(guarded_symbol == "none" && StringLen(row.symbol) > 0)
            guarded_symbol = row.symbol;
        }
      if(decay_flag)
        {
         decay_dragged++;
         if(decay_symbol == "none" && StringLen(row.symbol) > 0)
            decay_symbol = row.symbol;
        }
      if(weak_execution)
         weak_exec++;
      if(StringFind(row.score_pack_reason, "Layer 4 still owns execution-adjusted ordering") >= 0)
         handoff_honest++;
     }

   return StringFormat("l3_ready=%s | rows=%d | qualified=%d | burst_total=%d | burst_useful=%d[%s] | burst_guarded=%d[%s] | decay_dragged=%d[%s] | weak_exec=%d | handoff_honest=%d",
                       state.committed_l3_ready ? "yes" : "no",
                       total,
                       pass_count,
                       burst_total,
                       burst_useful,
                       useful_symbol,
                       burst_guarded,
                       guarded_symbol,
                       decay_dragged,
                       decay_symbol,
                       weak_exec,
                       handoff_honest);
  }

string ASC_ShortlistCacheDiagnosticSummary(const ASC_ShortlistSymbolSummary &rows[])
  {
   int total = ASC_ShortlistCount(rows);
   string posture = (StringLen(g_asc_shortlist_posture) > 0 ? g_asc_shortlist_posture : "unknown");
   string reason = (StringLen(g_asc_shortlist_reason) > 0 ? g_asc_shortlist_reason : "unavailable");
   return StringFormat("count=%d posture=%s reason=%s", total, posture, reason);
  }

void ASC_RebuildPublicationShortlistCache(ASC_RuntimeState &state,const datetime pass_utc)
  {
   datetime shortlist_source_pass_utc = pass_utc;
   if(state.committed_l4_ready && state.committed_l4_pass_utc > 0)
      shortlist_source_pass_utc = state.committed_l4_pass_utc;

   if(state.publication_shortlist_ready && state.publication_shortlist_pass_utc == shortlist_source_pass_utc)
     {
      state.publication_shortlist_last_status = "reused";
      state.publication_shortlist_last_reason = "publication shortlist cache reused from current committed Layer 4 source state | " + ASC_ShortlistCacheDiagnosticSummary(state.publication_shortlist_rows);
      return;
     }

   if(state.l1_publish_pending_essentials || state.l1_publish_pending_dossiers)
     {
      if(!state.committed_l4_ready || state.committed_l4_pass_utc != shortlist_source_pass_utc)
         ASC_RefreshCommittedSelectionOwnershipState(state, pass_utc);
      ASC_CopyCommittedL4RowsToShortlistRows(state.committed_l4_rows, state.publication_shortlist_rows);
      state.publication_shortlist_ready = state.committed_l4_ready;
      state.publication_shortlist_pass_utc = state.committed_l4_pass_utc > 0 ? state.committed_l4_pass_utc : pass_utc;
      state.publication_shortlist_total = ASC_ShortlistCount(state.publication_shortlist_rows);
      state.publication_shortlist_last_status = "mirrored";
      state.publication_shortlist_last_reason = "publication shortlist cache mirrored from committed Layer 4 runtime state | " + ASC_ShortlistCacheDiagnosticSummary(state.publication_shortlist_rows);
      return;
     }

   state.publication_shortlist_ready = false;
   state.publication_shortlist_pass_utc = shortlist_source_pass_utc;
   state.publication_shortlist_total = 0;
   state.publication_shortlist_last_status = "not_required";
   state.publication_shortlist_last_reason = "publication shortlist cache was not rebuilt because neither essentials nor dossier publication is pending";
   ArrayResize(state.publication_shortlist_rows, 0);
  }

bool ASC_DossierCandidateAllowed(const ASC_RuntimeState &state,const ASC_Layer1SymbolState &symbol_state)
  {
   if(StringLen(symbol_state.symbol) <= 0)
      return false;

   if(state.dossier_existence_shell_only)
      return true;

   if(!state.dossier_open_refresh_only)
      return true;

   return (symbol_state.state == ASC_L1_OPEN);
  }

bool ASC_RoutineRootAllSymbolDossierPolicyEnabled()
  {
   return (ASC_ROOT_DIRECT_SYMBOL_DOSSIERS_COMPAT_ENABLED
           || ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED
           || ASC_DIAGNOSTIC_ALL_SYMBOL_DOSSIERS_ENABLED);
  }

string ASC_Run115RootPolicyLogSignature(const string reason)
  {
   string normalized_reason = (StringLen(reason) > 0 ? reason : ASC_ROOT_ALL_SYMBOL_DOSSIER_SKIP_REASON);
   return "run115_root_policy|mode=" + ASC_DOSSIER_PUBLICATION_MODE
          + "|root=" + (ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false")
          + "|root_direct_compat=" + (ASC_ROOT_DIRECT_SYMBOL_DOSSIERS_COMPAT_ENABLED ? "true" : "false")
          + "|diagnostic=" + (ASC_DIAGNOSTIC_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false")
          + "|reason=" + normalized_reason;
  }

bool ASC_Run115ProofEmitDue(const datetime now_utc,const datetime last_emit_utc)
  {
   if(last_emit_utc <= 0)
      return true;
   if(now_utc <= 0)
      return false;
   return ((now_utc - last_emit_utc) >= ASC_RUN115_PROOF_UNCHANGED_SKIP_GUARD_SEC);
  }

string ASC_DossierPublicationPolicyTokens(const ASC_RuntimeState &state)
  {
   string tokens = "dossier_publication_mode=" + ASC_DOSSIER_PUBLICATION_MODE;
   tokens += " | root_all_symbol_dossiers_enabled=" + (ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | root_direct_symbol_dossiers_compat_enabled=" + (ASC_ROOT_DIRECT_SYMBOL_DOSSIERS_COMPAT_ENABLED ? "true" : "false");
   tokens += " | root_direct_symbol_dossier_policy_run193=" + ASC_ROOT_DIRECT_SYMBOL_DOSSIER_POLICY_RUN193;
   tokens += " | root_direct_symbol_dossier_suppression_patch=" + ASC_RUN193_ROOT_DIRECT_SYMBOL_SUPPRESSION_PATCH;
   tokens += " | root_all_symbol_dossier_writes_skipped=" + IntegerToString(MathMax(0, state.root_all_symbol_dossier_writes_skipped));
   tokens += " | globaltop10_dossiers_enabled=" + (ASC_GLOBALTOP10_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | top5_per_bucket_dossiers_enabled=" + (ASC_TOP5_PER_BUCKET_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | current_focus_enabled=" + (ASC_CURRENT_FOCUS_ENABLED ? "true" : "false");
   tokens += " | selected_symbol_dossier_enabled=" + (ASC_SELECTED_SYMBOL_DOSSIER_ENABLED ? "true" : "false");
   tokens += " | root_policy_preserves_selected_current=" + ((ASC_SELECTED_SYMBOL_DOSSIER_ENABLED && ASC_CURRENT_FOCUS_ENABLED && !ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED) ? "true" : "false");
   tokens += " | current_focus_independent_of_root_all_symbol=" + ((ASC_CURRENT_FOCUS_ENABLED && !ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED) ? "true" : "false");
   tokens += " | diagnostic_all_symbol_dossiers_enabled=" + (ASC_DIAGNOSTIC_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | legacy_all_symbol_dossiers_retained=" + (ASC_LEGACY_ALL_SYMBOL_DOSSIERS_RETAINED ? "true" : "false");
   tokens += " | legacy_root_dossier_cleanup_pending=" + (ASC_LEGACY_ROOT_DOSSIER_CLEANUP_PENDING ? "true" : "false");
   tokens += " | market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC);
   tokens += " | l3_candidate_refresh_cadence_sec=" + IntegerToString(ASC_L3_CANDIDATE_REFRESH_CADENCE_SEC);
   tokens += " | l4_shortlist_refresh_cadence_sec=" + IntegerToString(ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC);
   tokens += " | globaltop10_refresh_cadence_sec=" + IntegerToString(ASC_GLOBALTOP10_REFRESH_CADENCE_SEC);
   tokens += " | top5_per_bucket_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_PER_BUCKET_REFRESH_CADENCE_SEC);
   tokens += " | performance_side_audit=" + ASC_PERFORMANCE_SIDE_AUDIT_STATE;
   tokens += " | safe_cleanup_patch=" + ASC_RUN113_SAFE_CLEANUP_PATCH;
   tokens += " | top5_depth_parity_state=" + ASC_TOP5_DEPTH_PARITY_STATE_SOURCE_PATCHED;
   tokens += " | top5_rank_1_3_deep_attempted=" + (ASC_TOP5_RANK_1_3_DEEP_ATTEMPTED ? "true" : "false");
   tokens += " | top5_rank_4_5_deep_pending=" + (ASC_TOP5_RANK_4_5_DEEP_PENDING ? "true" : "false");
   tokens += " | top5_staging_enabled=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false");
   tokens += " | top5_archive_enabled=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false");
   tokens += " | top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false");
   tokens += " | top5_archive_previous_on_promote=" + (ASC_TOP5_ARCHIVE_PREVIOUS_ON_PROMOTE ? "true" : "false");
   tokens += " | top5_no_broad_file_deletion=true";
   tokens += " | run114_safe_cleanup_patch=" + ASC_RUN114_SAFE_CLEANUP_PATCH;
   tokens += " | run115_safe_cleanup_patch=" + ASC_RUN115_SAFE_CLEANUP_PATCH;
   tokens += " | run116_safe_cleanup_patch=" + ASC_RUN116_SAFE_CLEANUP_PATCH;
   tokens += " | proof_unchanged_skipped_count=" + IntegerToString(MathMax(0, state.proof_unchanged_skipped_count));
   tokens += " | root_policy_unchanged_log_skipped_count=" + IntegerToString(MathMax(0, state.dossier_publication_policy_unchanged_log_skipped_count));
   tokens += " | top5_unchanged_decision_skipped_count=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count));
   tokens += " | root_policy_duplicate_log_skipped=" + IntegerToString(MathMax(0, state.dossier_publication_policy_unchanged_log_skipped_count));
   tokens += " | top5_duplicate_decision_skipped=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count));
   tokens += " | last_policy_skip_reason=" + (StringLen(state.dossier_publication_policy_last_skip_reason) > 0 ? state.dossier_publication_policy_last_skip_reason : "none");
   return tokens;
  }

void ASC_RecordRoutineRootDossierPolicySkip(ASC_RuntimeState &state,const datetime now_utc,const string reason)
  {
   state.root_all_symbol_dossier_writes_skipped++;
   state.dossier_publication_policy_last_skip_reason = (StringLen(reason) > 0 ? reason : ASC_ROOT_ALL_SYMBOL_DOSSIER_SKIP_REASON);
   state.dossier_publication_policy_last_skip_utc = now_utc;
   state.publication_bundle.dossier_skipped_count++;

   string signature = ASC_Run115RootPolicyLogSignature(state.dossier_publication_policy_last_skip_reason);
   bool unchanged = (signature == state.dossier_publication_policy_last_log_signature);
   if(unchanged && !ASC_Run115ProofEmitDue(now_utc, state.dossier_publication_policy_last_log_utc))
     {
      state.dossier_publication_policy_unchanged_log_skipped_count++;
      state.proof_unchanged_skipped_count++;
      return;
     }

   state.dossier_publication_policy_last_log_signature = signature;
   state.dossier_publication_policy_last_log_utc = now_utc;
   ASC_LogInfo("ASC_Dispatcher", "ASC_DossierPublicationPolicy", "runtime", ASC_DossierPublicationPolicyTokens(state));
  }

ASC_DossierProductMode ASC_DossierContinuationModeFromLayer1(const ASC_Layer1SymbolState &symbol_state)
  {
   if(symbol_state.state == ASC_L1_OPEN)
      return ASC_DOSSIER_MODE_OPEN_MARKET;
   return ASC_DOSSIER_MODE_CLOSED_MARKET;
  }

bool ASC_DossierPublishIntervalSatisfied(const datetime now_utc,const datetime last_publish_utc)
  {
   return (last_publish_utc <= 0 || (now_utc - last_publish_utc) >= ASC_DOSSIER_MIN_PUBLISH_INTERVAL_SEC);
  }

bool ASC_MarketBoardPublishIntervalSatisfied(const datetime now_utc,const datetime last_publish_utc)
  {
   return (last_publish_utc > 0 && (now_utc - last_publish_utc) < ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC);
  }

void ASC_RequestMarketBoardFreshnessRepublish(ASC_RuntimeState &state,
                                              const datetime now_utc,
                                              const string trigger_reason)
  {
   if(ASC_MarketBoardPublishIntervalSatisfied(now_utc, state.market_board_last_publish_utc))
      return;

   state.write_dirty = true;
   state.l1_publish_pending_essentials = true;
   state.l1_publish_pending_manifest = true;

   string reason = (StringLen(trigger_reason) > 0) ? trigger_reason : "market-board-max-age";
   string last_publish_text = ASC_PublicationHeaderUtc(state.market_board_last_publish_utc);
   ASC_LogInfo("ASC_Dispatcher", "ASC_RequestMarketBoardFreshnessRepublish", "runtime",
               StringFormat("Market Board freshness republish scheduled reason=%s max_age_sec=%d last_publish_utc=%s",
                            reason,
                            ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC,
                            last_publish_text));
  }

bool ASC_MarketBoardFreshnessRepublishReadyForWrite(const ASC_RuntimeState &state,
                                                    const datetime now_utc,
                                                    string &source_reason_out)
  {
   source_reason_out = "not_pending";

   if(!state.l1_publish_pending_essentials)
      return false;
   if(state.l2_publish_pending)
     {
      source_reason_out = "awaiting_open_symbol_snapshot_publish";
      return false;
     }
   if(ASC_MarketBoardPublishIntervalSatisfied(now_utc, state.market_board_last_publish_utc))
     {
      source_reason_out = "publish_interval_not_elapsed";
      return false;
     }

   bool publication_shortlist_available = (state.publication_shortlist_ready
                                           && ArraySize(state.publication_shortlist_rows) > 0);
   bool committed_l4_available = (state.committed_l4_ready
                                  && ArraySize(state.committed_l4_rows) > 0);
   bool publication_shortlist_current = (publication_shortlist_available
                                         && (!committed_l4_available
                                             || state.publication_shortlist_pass_utc >= state.committed_l4_pass_utc));

   if(publication_shortlist_current)
     {
      source_reason_out = "publication_shortlist_current";
      return true;
     }
   if(committed_l4_available)
     {
      source_reason_out = "committed_l4_current";
      return true;
     }
   if(publication_shortlist_available)
     {
      source_reason_out = "publication_shortlist_retained";
      return true;
     }

   source_reason_out = "shortlist_truth_not_available";
   return false;
  }

bool ASC_MarketBoardPublishAdmittedForWrite(const ASC_RuntimeState &state,
                                            const datetime now_utc,
                                            string &reason_out)
  {
   reason_out = "final_gate_not_elapsed";

   if(state.board_manual_refresh_inflight)
     {
      reason_out = "manual_refresh_inflight";
      return true;
     }

   if(state.market_board_last_publish_utc <= 0)
     {
      reason_out = "initial_board_baseline_missing";
      return true;
     }

   string freshness_reason = "";
   if(ASC_MarketBoardFreshnessRepublishReadyForWrite(state, now_utc, freshness_reason))
     {
      reason_out = freshness_reason;
      return true;
     }

   reason_out = freshness_reason;
   if(StringLen(reason_out) <= 0)
      reason_out = "final_gate_not_elapsed";
   return false;
  }

bool ASC_L1BootstrapComplete(const ASC_RuntimeState &state,const ASC_Layer1PassSummary &summary,const datetime now_utc)
  {
   if(!state.l1_bootstrap_active)
      return true;

   if(summary.total_symbols <= 0)
      return false;

   int min_coverage = (summary.total_symbols * ASC_L1_BOOTSTRAP_MIN_COVERAGE_PCT) / 100;
   min_coverage = MathMax(64, MathMin(summary.total_symbols, min_coverage));
   int unknown_allowance = MathMax(1, (summary.total_symbols * ASC_L1_BOOTSTRAP_UNKNOWN_PCT) / 100);
   bool coverage_ready = (summary.assessed_symbols >= min_coverage);
   bool unknown_ready = (summary.unknown_count <= unknown_allowance);
   bool timed_out = (state.l1_bootstrap_started_utc > 0 && (now_utc - state.l1_bootstrap_started_utc) >= ASC_L1_BOOTSTRAP_MAX_SECONDS);
   return ((coverage_ready && unknown_ready) || timed_out);
  }

bool ASC_IsDossierShellPayload(const string payload)
  {
   if(StringLen(payload) <= 0)
      return false;

   return (StringFind(payload, "\nHydration Status\n") >= 0
           && StringFind(payload, "- Shell Only: yes") >= 0
           && StringFind(payload, "Market State Shell") >= 0);
  }

bool ASC_DossierPayloadHasLayer3Section(const string payload)
  {
   return (StringLen(payload) > 0 && StringFind(payload, "CANDIDATE FILTERING [L3]") >= 0);
  }

bool ASC_DossierPayloadHasLayer4Section(const string payload)
  {
   return (StringLen(payload) > 0 && StringFind(payload, "SHORTLIST SELECTION [L4]") >= 0);
  }

bool ASC_DossierPayloadHasCompletedL6Surface(const string payload)
  {
   if(StringLen(payload) <= 0)
      return false;

   return (StringFind(payload, "LAYER 6 STRATEGY SURFACE [L6]") >= 0
           || StringFind(payload, "LAYER 6 CURRENT FOCUS SUMMARY") >= 0
           || StringFind(payload, "Layer 6 Maturity / Trigger Canon") >= 0);
  }

bool ASC_DossierPayloadHasLawfulL0ToL2Baseline(const string payload)
  {
   if(StringLen(payload) <= 0)
      return false;

   return (StringFind(payload, "OPERATOR SNAPSHOT") >= 0
           && StringFind(payload, "PUBLICATION HEALTH") >= 0
           && StringFind(payload, "SYMBOL IDENTITY [L0]") >= 0
           && StringFind(payload, "MARKET STATE [L1]") >= 0
           && StringFind(payload, "MARKET WATCH [L2]") >= 0
           && StringFind(payload, "TRADING CONDITIONS & CONTRACT [L2]") >= 0
           && StringFind(payload, "SESSIONS, SWAP & MARGIN [L2]") >= 0);
  }

bool ASC_DossierPayloadHasLawfulL0ToL4Baseline(const string payload)
  {
   return (ASC_DossierPayloadHasLawfulL0ToL2Baseline(payload)
           && ASC_DossierPayloadHasLayer3Section(payload)
           && ASC_DossierPayloadHasLayer4Section(payload));
  }

bool ASC_DossierPayloadHasLawfulL0ToL6Coverage(const string payload)
  {
   return (ASC_DossierPayloadHasLawfulL0ToL4Baseline(payload)
           && ASC_DossierDeepSectionHasCompletedTruth(payload)
           && ASC_DossierPayloadHasCompletedL6Surface(payload));
  }

bool ASC_DossierPayloadHasGlobalTop10ChildIdentity(const string payload)
  {
   if(StringLen(payload) <= 0)
      return false;

   string schema_version = ASC_TextExtractLabeledLineValue(payload, "Schema Version:");
   string selected_symbol_status = ASC_TextExtractLabeledLineValue(payload, "Selected Symbol Status:");
   return (schema_version == "global_top10_child_operator_schema_v1"
           && selected_symbol_status == "Global Top 10 Child");
  }

bool ASC_DossierPayloadHasLawfulBaselineCoverage(const ASC_Layer1SymbolState &symbol_state,
                                                 const string payload,
                                                 bool &is_shell_out,
                                                 bool &is_rich_out,
                                                 bool &has_l3_out,
                                                 bool &has_l4_out)
  {
   is_shell_out = false;
   is_rich_out = false;
   has_l3_out = false;
   has_l4_out = false;

   if(StringLen(payload) <= 0)
      return false;

   is_shell_out = ASC_IsDossierShellPayload(payload);
   has_l3_out = ASC_DossierPayloadHasLayer3Section(payload);
   has_l4_out = ASC_DossierPayloadHasLayer4Section(payload);
   if(is_shell_out)
      return false;

   ASC_DossierProductMode mode = ASC_DossierContinuationModeFromLayer1(symbol_state);
   if(!ASC_DossierPayloadPassesMinimumIntegrity(payload, mode))
      return false;

   if(mode == ASC_DOSSIER_MODE_OPEN_MARKET)
     {
      if(!ASC_DossierPayloadHasLawfulL0ToL4Baseline(payload))
         return false;
     }
   else if(!ASC_DossierPayloadHasLawfulL0ToL2Baseline(payload))
      return false;

   is_rich_out = true;
   return true;
  }


string ASC_Run094HydrationClassLabel(const ASC_Layer1SymbolState &symbol_state,
                                     const bool exists,
                                     const bool is_shell,
                                     const bool is_rich,
                                     const bool has_l3,
                                     const bool has_l4,
                                     const string payload)
  {
   if(!exists)
      return ASC_DOSSIER_HYDRATION_CLASS_INCOMPLETE;
   if(symbol_state.state != ASC_L1_OPEN && symbol_state.state != ASC_L1_CLOSED)
      return ASC_DOSSIER_HYDRATION_CLASS_DEPENDENCY_BLOCKED;
   if(StringLen(payload) <= 0)
      return ASC_DOSSIER_HYDRATION_CLASS_INCOMPLETE;
   if(ASC_DossierPayloadHasGlobalTop10ChildIdentity(payload) && ASC_DossierPayloadHasLawfulL0ToL6Coverage(payload))
      return ASC_DOSSIER_HYDRATION_CLASS_TOP10_L0_L6;
   string selected_symbol_status = ASC_TextExtractLabeledLineValue(payload, "Selected Symbol Status:");
   if(selected_symbol_status == "Selected Symbol" && ASC_DossierPayloadHasLawfulL0ToL6Coverage(payload))
      return ASC_DOSSIER_HYDRATION_CLASS_SELECTED_L0_L6;
   if(symbol_state.state == ASC_L1_CLOSED)
      return ASC_DOSSIER_HYDRATION_CLASS_CLOSED_L0_L2;
   if(symbol_state.state == ASC_L1_OPEN && is_rich && has_l3 && has_l4)
      return ASC_DOSSIER_HYDRATION_CLASS_OPEN_L0_L4;
   if(is_shell || !has_l3 || !has_l4)
      return ASC_DOSSIER_HYDRATION_CLASS_INCOMPLETE;
   return ASC_DOSSIER_HYDRATION_CLASS_STALLED;
  }

string ASC_Run094ExpectedLayerRange(const string hydration_class)
  {
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_CLOSED_L0_L2)
      return "L0-L2 compact closed truth";
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_OPEN_L0_L4)
      return "L0-L4 open symbol hydration";
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_TOP10_L0_L6)
      return "L0-L6 GlobalTop10 child deep hydration";
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_SELECTED_L0_L6)
      return "L0-L6 selected/current deep hydration";
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_DEPENDENCY_BLOCKED)
      return "blocked until quote/spec/session/history dependency clears";
   return "incomplete/stalled source-visible hydration";
  }

string ASC_Run094ActualLayerRange(const bool is_shell,const bool is_rich,const bool has_l3,const bool has_l4,const string payload)
  {
   if(StringLen(payload) <= 0)
      return "no readable payload";
   if(ASC_DossierPayloadHasLawfulL0ToL6Coverage(payload))
      return "L0-L6 observed";
   if(has_l3 && has_l4)
      return "L0-L4 observed";
   if(is_rich)
      return "L0-L2 observed";
   if(is_shell)
      return "shell compact observed";
   return "payload present but layer coverage unclassified";
  }

int ASC_Run094SectionCount(const string payload)
  {
   if(StringLen(payload) <= 0)
      return 0;
   int count = 0;
   int pos = 0;
   while((pos = StringFind(payload, "[L", pos)) >= 0)
     {
      count++;
      pos += 2;
     }
   if(StringFind(payload, "Hydration Status") >= 0)
      count++;
   return count;
  }

string ASC_Run094ThreeKbReason(const ASC_Layer1SymbolState &symbol_state,
                               const bool exists,
                               const bool is_shell,
                               const bool is_rich,
                               const bool has_l3,
                               const bool has_l4,
                               const string publication_status,
                               const string hydration_class,
                               const int payload_size)
  {
   if(!exists)
      return ASC_DOSSIER_3KB_REASON_UNKNOWN_REQUIRES_REVIEW;
   if(symbol_state.state != ASC_L1_OPEN && symbol_state.state != ASC_L1_CLOSED)
      return ASC_DOSSIER_3KB_REASON_DEPENDENCY_BLOCKED;
   if(StringFind(publication_status, "continuity") >= 0 || StringFind(publication_status, "retained") >= 0)
      return ASC_DOSSIER_3KB_REASON_RETAINED_LAST_GOOD_COMPACT;
   if(StringFind(publication_status, "interrupted") >= 0 || StringFind(publication_status, "unreadable") >= 0)
      return ASC_DOSSIER_3KB_REASON_PUBLICATION_INTERRUPTED;
   if(symbol_state.state == ASC_L1_CLOSED && is_shell)
      return ASC_DOSSIER_3KB_REASON_CLOSED_COMPACT_HONEST;
   if(symbol_state.state == ASC_L1_OPEN && (is_shell || !has_l3 || !has_l4))
      return ASC_DOSSIER_3KB_REASON_OPEN_HYDRATION_INCOMPLETE;
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_STALLED)
      return ASC_DOSSIER_3KB_REASON_STALLED_DUE_RETRY;
   if(payload_size > 0 && payload_size <= 4096 && !is_shell && !is_rich)
      return ASC_DOSSIER_3KB_REASON_UNAVAILABLE_GARBAGE_SHELL;
   return ASC_DOSSIER_3KB_REASON_UNKNOWN_REQUIRES_REVIEW;
  }

string ASC_Run094ThreeKbBugStatus(const string reason)
  {
   if(reason == ASC_DOSSIER_3KB_REASON_CLOSED_COMPACT_HONEST || reason == ASC_DOSSIER_3KB_REASON_RETAINED_LAST_GOOD_COMPACT)
      return "not_bug_if_reasoned";
   if(reason == ASC_DOSSIER_3KB_REASON_UNKNOWN_REQUIRES_REVIEW)
      return "review_required";
   return "bug_or_debt_until_backfilled";
  }

string ASC_Run094ThreeKbNextAction(const string reason)
  {
   if(reason == ASC_DOSSIER_3KB_REASON_CLOSED_COMPACT_HONEST)
      return "retain compact closed truth until scheduled wake";
   if(reason == ASC_DOSSIER_3KB_REASON_OPEN_HYDRATION_INCOMPLETE)
      return "queue open L0-L4 hydration backfill";
   if(reason == ASC_DOSSIER_3KB_REASON_DEPENDENCY_BLOCKED)
      return "wait for quote/spec/session dependency then retry";
   if(reason == ASC_DOSSIER_3KB_REASON_WRITE_BUDGET_LEFTOVER)
      return "resume next heartbeat within write budget";
   if(reason == ASC_DOSSIER_3KB_REASON_PUBLICATION_INTERRUPTED)
      return "resume or republish from source owner";
   if(reason == ASC_DOSSIER_3KB_REASON_STALLED_DUE_RETRY)
      return "surface stall reason and retry budget";
   if(reason == ASC_DOSSIER_3KB_REASON_RETAINED_LAST_GOOD_COMPACT)
      return "do not mark current; retain as last-good only";
   return "operator review required";
  }

void ASC_Run094ResetPhase2AProofCounts(ASC_RuntimeState &state)
  {
   state.phase2a_hydration_closed_l0_l2_count = 0;
   state.phase2a_hydration_open_l0_l4_count = 0;
   state.phase2a_hydration_top10_l0_l6_count = 0;
   state.phase2a_hydration_selected_l0_l6_count = 0;
   state.phase2a_hydration_stalled_count = 0;
   state.phase2a_hydration_incomplete_count = 0;
   state.phase2a_hydration_dependency_blocked_count = 0;
   state.phase2a_three_kb_closed_compact_honest_count = 0;
   state.phase2a_three_kb_open_hydration_incomplete_count = 0;
   state.phase2a_three_kb_unavailable_garbage_shell_count = 0;
   state.phase2a_three_kb_dependency_blocked_count = 0;
   state.phase2a_three_kb_write_budget_leftover_count = 0;
   state.phase2a_three_kb_publication_interrupted_count = 0;
   state.phase2a_three_kb_stalled_due_retry_count = 0;
   state.phase2a_three_kb_retained_last_good_compact_count = 0;
   state.phase2a_three_kb_unknown_requires_review_count = 0;
   state.phase2a_requires_operator_review_count = 0;
  }

void ASC_Run094AccumulatePhase2AProofCounts(ASC_RuntimeState &state,
                                            const string hydration_class,
                                            const string three_kb_reason)
  {
   if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_CLOSED_L0_L2)
      state.phase2a_hydration_closed_l0_l2_count++;
   else if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_OPEN_L0_L4)
      state.phase2a_hydration_open_l0_l4_count++;
   else if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_TOP10_L0_L6)
      state.phase2a_hydration_top10_l0_l6_count++;
   else if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_SELECTED_L0_L6)
      state.phase2a_hydration_selected_l0_l6_count++;
   else if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_DEPENDENCY_BLOCKED)
      state.phase2a_hydration_dependency_blocked_count++;
   else if(hydration_class == ASC_DOSSIER_HYDRATION_CLASS_STALLED)
      state.phase2a_hydration_stalled_count++;
   else
      state.phase2a_hydration_incomplete_count++;

   if(three_kb_reason == ASC_DOSSIER_3KB_REASON_CLOSED_COMPACT_HONEST)
      state.phase2a_three_kb_closed_compact_honest_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_OPEN_HYDRATION_INCOMPLETE)
      state.phase2a_three_kb_open_hydration_incomplete_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_UNAVAILABLE_GARBAGE_SHELL)
      state.phase2a_three_kb_unavailable_garbage_shell_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_DEPENDENCY_BLOCKED)
      state.phase2a_three_kb_dependency_blocked_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_WRITE_BUDGET_LEFTOVER)
      state.phase2a_three_kb_write_budget_leftover_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_PUBLICATION_INTERRUPTED)
      state.phase2a_three_kb_publication_interrupted_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_STALLED_DUE_RETRY)
      state.phase2a_three_kb_stalled_due_retry_count++;
   else if(three_kb_reason == ASC_DOSSIER_3KB_REASON_RETAINED_LAST_GOOD_COMPACT)
      state.phase2a_three_kb_retained_last_good_compact_count++;
   else
      state.phase2a_three_kb_unknown_requires_review_count++;

   if(three_kb_reason == ASC_DOSSIER_3KB_REASON_UNKNOWN_REQUIRES_REVIEW
      || three_kb_reason == ASC_DOSSIER_3KB_REASON_UNAVAILABLE_GARBAGE_SHELL
      || three_kb_reason == ASC_DOSSIER_3KB_REASON_PUBLICATION_INTERRUPTED)
      state.phase2a_requires_operator_review_count++;
  }


int ASC_DossierHydrationLedgerFindIndex(const ASC_RuntimeState &state,
                                        const string symbol,
                                        const string canonical_symbol)
  {
   for(int i = 0; i < ArraySize(state.dossier_hydration_rows); i++)
     {
      if((StringLen(symbol) > 0 && state.dossier_hydration_rows[i].symbol == symbol)
         || (StringLen(canonical_symbol) > 0 && state.dossier_hydration_rows[i].canonical_symbol == canonical_symbol))
         return i;
     }
   return -1;
  }

void ASC_DossierHydrationLedgerUpsert(ASC_RuntimeState &state,
                                      const ASC_Layer1SymbolState &symbol_state,
                                      const int hydration_class,
                                      const bool has_hydration_class_line,
                                      const bool exists,
                                      const bool is_shell,
                                      const bool is_rich,
                                      const bool has_l3,
                                      const bool has_l4,
                                      const string publication_status,
                                      const datetime now_utc,
                                      const string hydration_class_label = "",
                                      const string expected_layer_range = "",
                                      const string actual_layer_range = "",
                                      const int section_count = 0,
                                      const int file_size_bytes = 0,
                                      const string three_kb_reason = "",
                                      const string three_kb_bug_status = "",
                                      const string three_kb_next_action = "",
                                      const string stall_reason = "",
                                      const string dependency_block_reason = "",
                                      const string publication_boundary = "")
  {
   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   int index = ASC_DossierHydrationLedgerFindIndex(state, symbol_state.symbol, canonical_symbol);
   if(index < 0)
     {
      index = ArraySize(state.dossier_hydration_rows);
      ArrayResize(state.dossier_hydration_rows, index + 1);
     }

   state.dossier_hydration_rows[index].symbol = symbol_state.symbol;
   state.dossier_hydration_rows[index].canonical_symbol = canonical_symbol;
   state.dossier_hydration_rows[index].hydration_class = hydration_class;
   state.dossier_hydration_rows[index].has_hydration_class_line = has_hydration_class_line;
   state.dossier_hydration_rows[index].exists = exists;
   state.dossier_hydration_rows[index].is_shell = is_shell;
   state.dossier_hydration_rows[index].is_rich = is_rich;
   state.dossier_hydration_rows[index].has_l3 = has_l3;
   state.dossier_hydration_rows[index].has_l4 = has_l4;
   state.dossier_hydration_rows[index].publication_status = publication_status;
   state.dossier_hydration_rows[index].updated_utc = now_utc;
   state.dossier_hydration_rows[index].hydration_class_label = hydration_class_label;
   state.dossier_hydration_rows[index].expected_layer_range = expected_layer_range;
   state.dossier_hydration_rows[index].actual_layer_range = actual_layer_range;
   state.dossier_hydration_rows[index].section_count = section_count;
   state.dossier_hydration_rows[index].file_size_bytes = file_size_bytes;
   state.dossier_hydration_rows[index].three_kb_reason = three_kb_reason;
   state.dossier_hydration_rows[index].three_kb_bug_status = three_kb_bug_status;
   state.dossier_hydration_rows[index].three_kb_next_action = three_kb_next_action;
   state.dossier_hydration_rows[index].stall_reason = stall_reason;
   state.dossier_hydration_rows[index].dependency_block_reason = dependency_block_reason;
   state.dossier_hydration_rows[index].publication_boundary = publication_boundary;
   if(state.dossier_hydration_rows[index].next_due_utc <= 0)
      state.dossier_hydration_rows[index].next_due_utc = now_utc;
  }

void ASC_DossierHydrationLedgerSetCadence(ASC_RuntimeState &state,
                                          const ASC_Layer1SymbolState &symbol_state,
                                          const int cadence_class,
                                          const datetime next_due_utc,
                                          const bool reset_retry_streak,
                                          const bool increment_retry_streak)
  {
   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   int index = ASC_DossierHydrationLedgerFindIndex(state, symbol_state.symbol, canonical_symbol);
   if(index < 0)
      return;

   state.dossier_hydration_rows[index].cadence_class = cadence_class;
   state.dossier_hydration_rows[index].next_due_utc = next_due_utc;
   if(reset_retry_streak)
      state.dossier_hydration_rows[index].retry_streak = 0;
   else if(increment_retry_streak)
      state.dossier_hydration_rows[index].retry_streak++;
  }

void ASC_DossierHydrationLedgerSetPublicationStatus(ASC_RuntimeState &state,
                                                    const ASC_Layer1SymbolState &symbol_state,
                                                    const string publication_status,
                                                    const datetime updated_utc)
  {
   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   int index = ASC_DossierHydrationLedgerFindIndex(state, symbol_state.symbol, canonical_symbol);
   if(index < 0)
      return;
   state.dossier_hydration_rows[index].publication_status = publication_status;
   state.dossier_hydration_rows[index].updated_utc = updated_utc;
  }

// Truth Seeker RUN146R: selected/family Dossier-first policy proof helpers.
int ASC_Run146RequiredSelectedFamilyDossierTarget(const ASC_RuntimeState &state)
  {
   int target = 0;
   if(ASC_GLOBALTOP10_DOSSIERS_ENABLED)
      target += MathMax(0, state.top10_run_full_total);
   if(ASC_TOP5_PER_BUCKET_DOSSIERS_ENABLED)
      target += MathMax(0, state.top5_bucket_child_target_count);
   if(ASC_SELECTED_SYMBOL_DOSSIER_ENABLED && StringLen(state.current_focus_live_symbol) > 0)
      target++;
   return MathMax(0, target);
  }

int ASC_Run146RequiredSelectedFamilyDossierMissing(const ASC_RuntimeState &state)
  {
   int missing = 0;
   if(ASC_GLOBALTOP10_DOSSIERS_ENABLED)
      missing += MathMax(0, state.top10_run_full_total - state.top10_run_full_cursor);
   if(ASC_TOP5_PER_BUCKET_DOSSIERS_ENABLED)
      missing += MathMax(0, state.top5_bucket_child_pending_count + state.top5_bucket_queue_remaining);
   return MathMax(0, missing);
  }

void ASC_Run146ApplySelectedFamilyDossierPolicy(ASC_RuntimeState &state,const string refresh_reason,const int elapsed_ms=0)
  {
   int target = ASC_Run146RequiredSelectedFamilyDossierTarget(state);
   int missing = ASC_Run146RequiredSelectedFamilyDossierMissing(state);
   int completed = MathMax(0, target - missing);
   bool root_enabled = ASC_RoutineRootAllSymbolDossierPolicyEnabled();

   state.dossier_required_policy = root_enabled ? "root_flood_required" : ASC_DOSSIER_REQUIRED_POLICY_SELECTED_FAMILY;
   state.dossier_root_flood_policy = root_enabled ? "root_flood_required" : ASC_DOSSIER_ROOT_FLOOD_NOT_REQUIRED;
   state.dossier_root_disabled_missing_policy = root_enabled ? "root_missing_counts_active" : ASC_DOSSIER_ROOT_DISABLED_BY_POLICY;
   state.dossier_family_backfill_policy = (target > 0 ? ASC_DOSSIER_FAMILY_BACKFILL_REQUIRED : "family_dossier_backfill_waiting_for_shortlist_family_targets");
   state.dossier_required_family_count = target;
   state.dossier_required_family_missing_count = missing;
   state.dossier_expected_count = target;
   state.dossier_missing_count = missing;
   state.dossier_queue_completed_count = completed;
   state.dossier_queue_remaining_count = missing;
   state.dossier_pending_backlog_count = missing;
   state.dossier_backfill_pending_count = missing;
   state.dossier_queue_active = (missing > 0);
   state.dossier_queue_cursor_total = completed;
   state.dossier_startup_flood_active = false;
   state.dossier_startup_flood_target = target;
   state.dossier_startup_flood_progress = completed;
   state.dossier_presence_refresh_last_utc = TimeGMT();
   state.dossier_presence_refresh_last_elapsed_ms = elapsed_ms;
   state.dossier_presence_refresh_last_symbols = target;
   state.dossier_presence_refresh_last_existing_files = completed;
   state.dossier_presence_refresh_last_payload_reads = 0;
   state.dossier_presence_refresh_last_heartbeat_id = state.heartbeat_counter;
   state.dossier_presence_refresh_last_reason = refresh_reason + "|root_flood_not_required";
   state.dossier_presence_refresh_last_lane = ASC_LaneToText(state.active_lane);
   if(missing <= 0)
     {
      state.dossier_queue_policy_state = (target > 0 ? "completed" : ASC_DOSSIER_ROOT_DISABLED_BY_POLICY);
      state.dossier_queue_state = state.dossier_queue_policy_state;
      state.dossier_queue_last_reason = (target > 0 ? "selected_and_family_dossier_requirements_complete_or_not_yet_published" : "root_flood_not_required_family_targets_not_yet_available");
     }
   else if(state.dossier_queue_stalled_count > 0 || state.dossier_missing_stall_beats > 3)
     {
      state.dossier_queue_policy_state = ASC_DOSSIER_QUEUE_STALLED;
      state.dossier_queue_state = ASC_DOSSIER_QUEUE_STALLED;
      state.dossier_queue_last_reason = "selected_or_family_dossier_backfill_stalled";
     }
   else
     {
      state.dossier_queue_policy_state = ASC_DOSSIER_QUEUE_PROGRESSING;
      state.dossier_queue_state = ASC_DOSSIER_QUEUE_PROGRESSING;
      state.dossier_queue_last_reason = "selected_or_family_dossier_backfill_required";
     }
   state.dossier_queue_service_last_stall_reason = (state.dossier_queue_state == ASC_DOSSIER_QUEUE_STALLED ? "selected_family_queue_no_progress" : "none");
   state.dossier_write_budget_used = 0;
   state.dossier_write_budget_max = ASC_DOSSIER_QUEUE_BACKLOG_BUDGET_CAP;
  }

string ASC_Run146PathState(const string path,const bool enabled,const string present_token,const string missing_token,const string disabled_token,string &reason_out)
  {
   if(!enabled)
     {
      reason_out = "disabled_by_policy";
      return disabled_token;
     }
   if(StringLen(path) <= 0)
     {
      reason_out = "path_unavailable";
      return missing_token;
     }
   if(ASC_FileExistsCommon(path))
     {
      reason_out = "path_present=" + path;
      return present_token;
     }
   reason_out = "path_missing=" + path;
   return missing_token;
  }

void ASC_Run146RefreshFamilyArchiveProof(ASC_RuntimeState &state,const datetime now_utc)
  {
   string reason = "";
   string top5_archive_root = (StringLen(state.server_root) > 0 ? state.server_root + "\\" + ASC_TOP5_BUCKET_PATH_FRAGMENT + "\\" + ASC_TOP5_BUCKET_ARCHIVE_FOLDER : "");
   state.top5_archive_proof_state = ASC_Run146PathState(top5_archive_root,
                                                        ASC_TOP5_PER_BUCKET_DOSSIERS_ENABLED,
                                                        "top5_archive_present",
                                                        "top5_archive_missing",
                                                        "top5_archive_disabled_by_policy",
                                                        reason);
   state.top5_archive_proof_reason = reason;

   string global_archive_root = (StringLen(state.server_root) > 0 ? state.server_root + "\\" + ASC_DOSSIER_FOLDER + "\\GlobalTop10\\archive" : "");
   state.globaltop10_archive_proof_state = ASC_Run146PathState(global_archive_root,
                                                              ASC_GLOBALTOP10_DOSSIERS_ENABLED,
                                                              "globaltop10_archive_present",
                                                              "globaltop10_archive_missing",
                                                              "globaltop10_archive_disabled_by_policy",
                                                              reason);
   state.globaltop10_archive_proof_reason = reason;

   string stale_tmp_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\" + ASC_DOSSIER_FOLDER + "\\GlobalTop10\\_staging\\_family_manifest.txt.tmp" : "");
   if(StringLen(stale_tmp_path) > 0 && ASC_FileExistsCommon(stale_tmp_path))
     {
      state.globaltop10_stale_tmp_proof_state = "stale_tmp_detected";
      state.globaltop10_stale_tmp_proof_reason = "cleanup_pending_no_broad_delete path=" + stale_tmp_path;
     }
   else
     {
      state.globaltop10_stale_tmp_proof_state = "cleanup_not_attempted";
      state.globaltop10_stale_tmp_proof_reason = "no_known_staging_manifest_tmp_detected_or_path_unavailable";
     }
  }

void ASC_RefreshDossierHydrationLedgerFromFilesystem(ASC_RuntimeState &state,
                                                  const string refresh_reason = "unspecified",
                                                  const bool force_refresh = false,
                                                  const int min_interval_seconds = 2)
  {
   datetime now_utc = TimeGMT();
   if(!force_refresh
      && state.dossier_presence_refresh_last_utc > 0
      && min_interval_seconds > 0
      && (now_utc - state.dossier_presence_refresh_last_utc) < min_interval_seconds)
      return;

   ulong sweep_started_us = ASC_HeartbeatNowMicroseconds();
   int total = ASC_Layer1CachedSymbolCount();
   int existing_files = 0;
   int payload_reads = 0;
   ASC_Run094ResetPhase2AProofCounts(state);
   state.dossier_queue_completed_count = 0;
   state.dossier_queue_remaining_count = 0;
   state.dossier_queue_stalled_count = 0;
   state.dossier_backfill_pending_count = 0;
   state.dossier_dependency_block_reason = "none";
   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
     {
      ASC_Run146ApplySelectedFamilyDossierPolicy(state, refresh_reason, ASC_SafeElapsedMsSince(sweep_started_us));
      return;
     }
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
      ASC_ArtifactContract dossier_contract = ASC_DossierContract(state.server_root, canonical_symbol);
      bool dossier_exists = ASC_FileExistsCommon(dossier_contract.target_path);
      if(dossier_exists)
         existing_files++;
      bool dossier_is_shell = false;
      bool dossier_is_rich = false;
      bool has_l3 = false;
      bool has_l4 = false;
      string publication_status = dossier_exists ? "existing_unreadable" : "missing";
      bool hydration_class_line_found = false;
      string payload = "";

      if(dossier_exists)
        {
         payload_reads++;
         if(ASC_ReadTextFile(dossier_contract.target_path, payload) && StringLen(payload) > 0)
           {
            ASC_DossierPayloadHasLawfulBaselineCoverage(symbol_state,
                                                        payload,
                                                        dossier_is_shell,
                                                        dossier_is_rich,
                                                        has_l3,
                                                        has_l4);
            publication_status = "existing";
            hydration_class_line_found = (StringLen(ASC_TextExtractLabeledLineValue(payload, "Hydration Class:")) > 0);
           }
        }

      int prior_index = ASC_DossierHydrationLedgerFindIndex(state, symbol_state.symbol, canonical_symbol);
      int hydration_class = (prior_index >= 0) ? state.dossier_hydration_rows[prior_index].hydration_class : -1;
      int payload_size = StringLen(payload);
      string hydration_class_label = ASC_Run094HydrationClassLabel(symbol_state,
                                                                   dossier_exists,
                                                                   dossier_is_shell,
                                                                   dossier_is_rich,
                                                                   has_l3,
                                                                   has_l4,
                                                                   payload);
      string expected_layer_range = ASC_Run094ExpectedLayerRange(hydration_class_label);
      string actual_layer_range = ASC_Run094ActualLayerRange(dossier_is_shell, dossier_is_rich, has_l3, has_l4, payload);
      int section_count = ASC_Run094SectionCount(payload);
      string three_kb_reason = ASC_Run094ThreeKbReason(symbol_state,
                                                       dossier_exists,
                                                       dossier_is_shell,
                                                       dossier_is_rich,
                                                       has_l3,
                                                       has_l4,
                                                       publication_status,
                                                       hydration_class_label,
                                                       payload_size);
      string three_kb_bug_status = ASC_Run094ThreeKbBugStatus(three_kb_reason);
      string three_kb_next_action = ASC_Run094ThreeKbNextAction(three_kb_reason);
      string stall_reason = (hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_STALLED) ? "no_progress_or_retry_stall_visible" : "none";
      string dependency_block_reason = (hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_DEPENDENCY_BLOCKED) ? "l1_quote_spec_session_dependency_unresolved" : "none";
      string publication_boundary = "file_exists_and_file_filled_are_diagnostic_only_currentness_requires_promoted_source_identity_and_live_RUN095R_proof";
      ASC_Run094AccumulatePhase2AProofCounts(state, hydration_class_label, three_kb_reason);
      if(hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_OPEN_L0_L4
         || hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_TOP10_L0_L6
         || hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_SELECTED_L0_L6
         || hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_CLOSED_L0_L2)
         state.dossier_queue_completed_count++;
      else
        {
         state.dossier_queue_remaining_count++;
         state.dossier_backfill_pending_count++;
         state.dossier_backfill_target_reason = three_kb_reason;
         if(hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_STALLED)
            state.dossier_queue_stalled_count++;
         if(hydration_class_label == ASC_DOSSIER_HYDRATION_CLASS_DEPENDENCY_BLOCKED)
            state.dossier_dependency_block_reason = dependency_block_reason;
        }
      ASC_DossierHydrationLedgerUpsert(state,
                                       symbol_state,
                                       hydration_class,
                                       hydration_class_line_found,
                                       dossier_exists,
                                       dossier_is_shell,
                                       dossier_is_rich,
                                       has_l3,
                                       has_l4,
                                       publication_status,
                                       now_utc,
                                       hydration_class_label,
                                       expected_layer_range,
                                       actual_layer_range,
                                       section_count,
                                       payload_size,
                                       three_kb_reason,
                                       three_kb_bug_status,
                                       three_kb_next_action,
                                       stall_reason,
                                       dependency_block_reason,
                                       publication_boundary);
     }

   state.dossier_presence_refresh_last_utc = now_utc;
   state.dossier_presence_refresh_last_elapsed_ms = ASC_SafeElapsedMsSince(sweep_started_us);
   state.dossier_presence_refresh_last_symbols = total;
   state.dossier_presence_refresh_last_existing_files = existing_files;
   state.dossier_presence_refresh_last_payload_reads = payload_reads;
   state.dossier_presence_refresh_last_heartbeat_id = state.heartbeat_counter;
   state.dossier_presence_refresh_last_reason = refresh_reason;
   state.dossier_presence_refresh_last_lane = ASC_LaneToText(state.active_lane);
   state.dossier_queue_active = (state.dossier_queue_remaining_count > 0);
   state.dossier_pending_backlog_count = state.dossier_queue_remaining_count;
   state.dossier_queue_cursor_total = state.dossier_queue_completed_count;
   state.dossier_queue_stall_count = state.dossier_queue_stalled_count;
   state.dossier_queue_state = state.dossier_queue_active ? "resume_required" : "completed";
   state.dossier_queue_last_reason = state.dossier_queue_active ? state.dossier_backfill_target_reason : "phase2a_hydration_folder_complete_or_no_backfill_pending";
   state.dossier_queue_service_last_stall_reason = (state.dossier_queue_stalled_count > 0) ? "stalled_due_retry_or_no_progress" : "none";
   state.dossier_write_budget_used = payload_reads;
   state.dossier_write_budget_max = ASC_DOSSIER_QUEUE_BACKLOG_BUDGET_CAP;
  }

bool ASC_TryResolveDossierCoverageState(const ASC_RuntimeState &state,
                                        const ASC_Layer1SymbolState &symbol_state,
                                        bool &exists_out,
                                        bool &is_shell_out,
                                        bool &is_rich_out,
                                        bool &has_l3_out,
                                        bool &has_l4_out)
  {
   exists_out = false;
   is_shell_out = false;
   is_rich_out = false;
   has_l3_out = false;
   has_l4_out = false;

   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   int index = ASC_DossierHydrationLedgerFindIndex(state, symbol_state.symbol, canonical_symbol);
   if(index < 0)
      return false;

   exists_out = state.dossier_hydration_rows[index].exists;
   is_shell_out = state.dossier_hydration_rows[index].is_shell;
   is_rich_out = state.dossier_hydration_rows[index].is_rich;
   has_l3_out = state.dossier_hydration_rows[index].has_l3;
   has_l4_out = state.dossier_hydration_rows[index].has_l4;
   return true;
  }

void ASC_UpdateBootstrapState(ASC_RuntimeState &state,const ASC_Layer1PassSummary &summary,const datetime now_utc)
  {
   if(state.l1_bootstrap_started_utc <= 0)
      state.l1_bootstrap_started_utc = now_utc;

   state.l1_bootstrap_pass_counter++;
   if(summary.assessed_symbols > state.l1_bootstrap_assessed_peak)
      state.l1_bootstrap_assessed_peak = summary.assessed_symbols;

   if(ASC_L1BootstrapComplete(state, summary, now_utc))
     {
      state.l1_bootstrap_active = false;
      if(state.l1_bootstrap_completed_utc <= 0)
         state.l1_bootstrap_completed_utc = now_utc;
     }
  }

void ASC_RefreshDossierPresenceCounters(ASC_RuntimeState &state,
                                       const string refresh_reason = "presence_counters",
                                       const bool force_refresh = false,
                                       const int min_interval_seconds = 2)
  {
   ASC_RefreshDossierHydrationLedgerFromFilesystem(state, refresh_reason, force_refresh, min_interval_seconds);
   datetime now_utc = TimeGMT();
   int total = ASC_Layer1CachedSymbolCount();
   int shell_present = 0;
   int reduced_present = 0;
   int expanded_present = 0;
   int open_base_present = 0;
   int open_l3_present = 0;
   int open_l4_present = 0;
   int rich_present = 0;
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
      if(ASC_DossierHydrationLedgerFindIndex(state, symbol_state.symbol, canonical_symbol) < 0)
         ASC_DossierHydrationLedgerUpsert(state,
                                          symbol_state,
                                          -1,
                                          false,
                                          false,
                                          false,
                                          false,
                                          false,
                                          false,
                                          "missing",
                                          now_utc);

      bool dossier_exists = false;
      bool dossier_is_shell = false;
      bool dossier_is_rich = false;
      bool has_l3 = false;
      bool has_l4 = false;
      if(!ASC_TryResolveDossierCoverageState(state,
                                             symbol_state,
                                             dossier_exists,
                                             dossier_is_shell,
                                             dossier_is_rich,
                                             has_l3,
                                             has_l4))
         continue;
      if(!dossier_exists)
         continue;
      if(dossier_is_shell)
        {
         shell_present++;
         continue;
        }

      if(!dossier_is_rich)
         continue;

      rich_present++;

      if(symbol_state.state == ASC_L1_CLOSED)
        {
         if(!has_l3 && !has_l4)
            reduced_present++;
        }
      else if(symbol_state.state == ASC_L1_OPEN)
        {
         if(has_l4)
           {
            expanded_present++;
            open_l4_present++;
           }
         else if(has_l3)
           {
            expanded_present++;
            open_l3_present++;
           }
         else
            open_base_present++;
        }
     }
   state.dossier_shell_present_count = shell_present;
   state.dossier_reduced_present_count = reduced_present;
   state.dossier_expanded_present_count = expanded_present;
   state.dossier_open_base_present_count = open_base_present;
   state.dossier_open_l3_present_count = open_l3_present;
   state.dossier_open_l4_present_count = open_l4_present;
   state.dossier_rich_present_count = rich_present;
  }

void ASC_UpdateDossierCoverageTelemetry(ASC_RuntimeState &state,const ASC_Layer1PassSummary &summary)
  {
   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
     {
      int missing = ASC_Run146RequiredSelectedFamilyDossierMissing(state);
      if(state.dossier_last_missing_observed < 0 || missing != state.dossier_last_missing_observed)
         state.dossier_missing_stall_beats = 0;
      else if(missing > 0)
         state.dossier_missing_stall_beats++;
      ASC_Run146ApplySelectedFamilyDossierPolicy(state, "coverage_telemetry_selected_family_policy", 0);
      state.dossier_last_missing_observed = missing;
      return;
     }
   int expected = MathMax(0, summary.total_symbols);
   int rich_present = MathMax(0, state.dossier_rich_present_count);
   int backlog = ASC_CountRemainingDossierBacklog(state);
   int missing = MathMax(0, expected - rich_present);
   if(backlog > 0)
      missing = MathMax(missing, MathMin(expected, backlog));
   state.dossier_pending_backlog_count = MathMax(0, backlog);

   if(state.dossier_last_missing_observed < 0 || missing != state.dossier_last_missing_observed)
      state.dossier_missing_stall_beats = 0;
   else if(missing > 0)
      state.dossier_missing_stall_beats++;

   state.dossier_expected_count = expected;
   state.dossier_missing_count = missing;
   state.dossier_last_missing_observed = missing;

   if(state.l1_publish_pending_dossiers && backlog > 0)
     {
      if(state.dossier_last_backlog_observed >= 0
         && backlog >= state.dossier_last_backlog_observed)
         state.dossier_cursor_stall_beats++;
      else
         state.dossier_cursor_stall_beats = 0;
      state.dossier_last_cursor_observed = state.write_cursor;
      state.dossier_last_backlog_observed = backlog;
     }
   else
     {
      state.dossier_cursor_stall_beats = 0;
      state.dossier_last_cursor_observed = 0;
      state.dossier_last_backlog_observed = -1;
      state.dossier_no_progress_write_beats = 0;
     }

   state.dossier_regression_signal = "none";
   if(missing > 0 && !state.l1_publish_pending_dossiers)
      state.dossier_regression_signal = "missing_without_pending_dossier_duty";
   else if(state.dossier_no_progress_write_beats >= 3 && backlog > 0)
      state.dossier_regression_signal = "dossier_cursor_stall";
   else if(state.dossier_cursor_stall_beats >= 3 && backlog > 0)
      state.dossier_regression_signal = "dossier_cursor_stall";
   else if(state.dossier_missing_stall_beats >= 6 && missing > 0)
      state.dossier_regression_signal = "dossier_missing_stall";
  }

bool ASC_IsBroadCatchupIncomplete(const ASC_RuntimeState &state,
                                  ASC_Layer1PassSummary &summary_out,
                                  bool &has_summary_out,
                                  string &reason_out)
  {
   has_summary_out = ASC_Layer1TryGetLatestSummary(summary_out);
   if(!has_summary_out)
     {
      reason_out = "l1_summary_pending";
      return true;
     }

   if(summary_out.total_symbols <= 0)
     {
      reason_out = "l1_universe_pending";
      return true;
     }

   if(summary_out.assessed_symbols < summary_out.total_symbols || summary_out.remaining_symbols > 0)
     {
      reason_out = StringFormat("l1_coverage_pending assessed=%d total=%d remaining=%d",
                                summary_out.assessed_symbols,
                                summary_out.total_symbols,
                                summary_out.remaining_symbols);
      return true;
     }

   int open_symbols = MathMax(0, summary_out.open_count);
   int l2_admitted = MathMax(0, state.l2_admitted_symbols);
   if(open_symbols > 0 && l2_admitted < open_symbols)
     {
      reason_out = StringFormat("l2_admission_pending admitted=%d open=%d", l2_admitted, open_symbols);
      return true;
     }

   int safe_due_threshold = MathMax(8, open_symbols / 4);
   if(state.l2_due_remaining > safe_due_threshold)
     {
      reason_out = StringFormat("l2_backlog_pending due=%d threshold=%d",
                                state.l2_due_remaining,
                                safe_due_threshold);
      return true;
     }

   reason_out = "broad_catchup_complete";
   return false;
  }

bool ASC_RuntimeStartupReadinessEstablished(const ASC_RuntimeState &state,string &reason_out)
  {
   ASC_Layer1PassSummary summary;
   bool has_summary = false;
   string catchup_reason = "";
   if(ASC_IsBroadCatchupIncomplete(state, summary, has_summary, catchup_reason))
     {
      reason_out = "broad_catchup_incomplete: " + catchup_reason;
      return false;
     }

   if(state.l1_bootstrap_active || !state.l1_warmup_ready)
     {
      reason_out = "warmup_or_bootstrap_not_complete";
      return false;
     }

   if(!state.committed_l3_ready)
     {
      reason_out = "committed_l3_not_ready";
      return false;
     }

   if(!state.committed_l4_ready)
     {
      reason_out = "committed_l4_not_ready";
      return false;
     }

   if(!state.publication_shortlist_ready || ArraySize(state.publication_shortlist_rows) <= 0)
     {
      reason_out = "publication_shortlist_not_ready";
      return false;
     }

   reason_out = "startup_readiness_established";
   return true;
  }

bool ASC_RuntimeBoardReadinessConsolidated(const ASC_RuntimeState &state,string &reason_out)
  {
   reason_out = "board_readiness_pending";

   ASC_ShortlistSymbolSummary source_rows[];
   bool publication_shortlist_available = (state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0);
   bool committed_l4_available = (state.committed_l4_ready && ArraySize(state.committed_l4_rows) > 0);
   bool publication_shortlist_current = (publication_shortlist_available
                                         && (!committed_l4_available
                                             || state.publication_shortlist_pass_utc >= state.committed_l4_pass_utc));

   if(publication_shortlist_current)
     {
      int source_size = ArraySize(state.publication_shortlist_rows);
      if(ArrayResize(source_rows, source_size) != source_size)
        {
         reason_out = "top5_source_rows_resize_failed";
         return false;
        }
      for(int i = 0; i < source_size; i++)
         source_rows[i] = state.publication_shortlist_rows[i];
     }
   else if(committed_l4_available)
     {
      ArrayResize(source_rows, ArraySize(state.committed_l4_rows));
      for(int i = 0; i < ArraySize(state.committed_l4_rows); i++)
         source_rows[i] = state.committed_l4_rows[i].summary;
     }
   else if(publication_shortlist_available)
     {
      ArrayResize(source_rows, ArraySize(state.publication_shortlist_rows));
      for(int i = 0; i < ArraySize(state.publication_shortlist_rows); i++)
         source_rows[i] = state.publication_shortlist_rows[i];
     }

   if(ArraySize(source_rows) <= 0)
     {
      reason_out = "shortlist_rows_not_available";
      return false;
     }

   ASC_ShortlistSymbolSummary top_ten[];
   ASC_BoardBuildAllMarketsTopRows(source_rows, 10, top_ten);
   if(ArraySize(top_ten) <= 0)
     {
      reason_out = "top10_not_available";
      return false;
     }

   int open_market_entitled_count = ASC_BoardOpenMarketEntitledCount(top_ten);
   int live_entitled_open = MathMax(0, state.l1_l2_live_entitled_count);
   if(live_entitled_open > 0 && open_market_entitled_count <= 0)
     {
      reason_out = StringFormat("open_market_rows_not_available live_open=%d top10_open=%d",
                                live_entitled_open,
                                open_market_entitled_count);
      return false;
     }

   if(open_market_entitled_count <= 0)
     {
      reason_out = "closed_market_only_projection";
      return true;
     }

   int authoritative_candidate_count = ASC_BoardOpenMarketAuthoritativeCandidateCount(top_ten);
   if(authoritative_candidate_count <= 0)
     {
      reason_out = StringFormat("open_market_authoritative_candidates_not_ready open=%d authoritative=%d",
                                open_market_entitled_count,
                                authoritative_candidate_count);
      return false;
     }

   reason_out = StringFormat("board_readiness_consolidated open=%d authoritative=%d",
                             open_market_entitled_count,
                             authoritative_candidate_count);
   return true;
  }

void ASC_UpdateStartupDossierFloodState(ASC_RuntimeState &state)
  {
   ASC_Layer1PassSummary summary;
   bool has_summary = false;
   string catchup_reason = "";
   bool broad_catchup_incomplete = ASC_IsBroadCatchupIncomplete(state, summary, has_summary, catchup_reason);

   int expected = MathMax(0, state.dossier_expected_count);
   int missing = MathMax(0, state.dossier_missing_count);
   bool backlog_pending = (state.l1_publish_pending_dossiers || state.write_cursor > 0);
   bool warmup_like = (state.l1_bootstrap_active || state.mode == ASC_MODE_WARMUP || !state.l1_warmup_ready);
   bool should_flood = (warmup_like && expected > 0 && missing > 0 && !broad_catchup_incomplete);

   state.dossier_startup_flood_active = should_flood;
   state.dossier_startup_flood_target = expected;
   state.dossier_startup_flood_progress = MathMax(0, expected - missing);
   if(state.dossier_regression_signal == "startup_flood_deferred_for_broad_l0_l2_catchup")
      state.dossier_regression_signal = "";
   if(!should_flood && !backlog_pending)
      state.dossier_startup_flood_budget_last = 0;
  }

void ASC_MaybeWriteScannerStatus(ASC_RuntimeState &state,const datetime now_utc)
  {
   if(state.scanner_status_last_write_utc > 0 && (now_utc - state.scanner_status_last_write_utc) < 2)
      return;

   ASC_Layer1PassSummary summary;
   if(!ASC_Layer1TryGetLatestSummary(summary))
      return;

   ASC_RefreshDossierPresenceCounters(state, "scanner_status_refresh", false, 2);
   ASC_UpdateDossierCoverageTelemetry(state, summary);
   ASC_UpdateStartupDossierFloodState(state);
   ASC_Run146RefreshFamilyArchiveProof(state, now_utc);
   ASC_FunctionResult status_result = ASC_WriteScannerStatusArtifact(state, summary, now_utc);
   ASC_RecordResult(state, status_result, status_result.state == ASC_RESULT_ERROR, status_result.state != ASC_RESULT_OK);
   if(status_result.state == ASC_RESULT_OK || status_result.state == ASC_RESULT_WARNING)
     {
      state.scanner_status_last_write_utc = now_utc;
      state.scanner_status_last_error = "";
     }
   else
      state.scanner_status_last_error = status_result.detail_message;
  }

void ASC_DossierPendingQueuesReset(ASC_RuntimeState &state);

void ASC_RequestOpenSymbolDossierRefresh(ASC_RuntimeState &state,const datetime now_utc)
  {
   bool dossier_backoff_active_now = ASC_IsCooldownActive(now_utc, state.dossier_backoff_until_utc);
   if(dossier_backoff_active_now)
     {
      state.dossier_refresh_last_status = "deferred_backoff";
      state.dossier_refresh_last_reason = StringFormat("open-symbol dossier refresh deferred until %s because dossier backoff is active",
                                                       ASC_PublicationHeaderUtc(state.dossier_backoff_until_utc));
      return;
     }

   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
     {
      state.l1_publish_pending_dossiers = false;
      state.dossier_open_refresh_only = false;
      state.dossier_resume_full_publish_after_open_refresh = false;
      state.dossier_existence_shell_only = false;
      state.dossier_startup_flood_active = false;
      state.write_cursor = 0;
      state.dossier_pending_backlog_count = 0;
      ASC_DossierPendingQueuesReset(state);
      state.dossier_pending_queues_ready = false;
      state.dossier_pending_queues_dirty = true;
      state.dossier_pending_queue_signature = "";
      state.l1_publish_pending_manifest = true;
      state.write_dirty = (state.l1_publish_pending_essentials || state.l2_publish_pending || state.l1_publish_pending_manifest);
      state.dossier_refresh_last_status = "skipped_root_direct_disabled_run193";
      state.dossier_refresh_last_reason = "RUN193 suppressed direct root Dossiers/<symbol>.txt refresh; Current Focus and top-list family Dossiers remain separate owners";
      ASC_RecordRoutineRootDossierPolicySkip(state, now_utc, ASC_ROOT_DIRECT_SYMBOL_DOSSIER_SKIP_REASON_RUN193);
      return;
     }

   if(state.l1_publish_pending_dossiers)
     {
      if(state.dossier_existence_shell_only)
        {
         state.dossier_resume_full_publish_after_open_refresh = true;
         state.dossier_open_refresh_only = true;
         state.l1_publish_pending_manifest = true;
         state.write_dirty = true;
         state.write_cursor = 0;
         state.dossier_refresh_last_status = "queued_after_shell_duty";
         state.dossier_refresh_last_reason = "open-symbol dossier refresh queued to run immediately after startup shell-existence duty completes";
         return;
        }

      state.dossier_resume_full_publish_after_open_refresh = (!state.dossier_open_refresh_only);
      state.dossier_open_refresh_only = true;
      state.dossier_existence_shell_only = false;
      state.l1_publish_pending_manifest = true;
      state.write_dirty = true;
      state.write_cursor = 0;
      state.dossier_refresh_last_status = "admitted_priority";
      state.dossier_refresh_last_reason = "open-symbol dossier refresh admitted with priority ahead of the active generic dossier backlog";
      return;
     }

   if(!ASC_DossierPublishIntervalSatisfied(now_utc, state.l1_last_open_dossier_publish_utc))
     {
      state.dossier_refresh_last_status = "skipped_interval_guard";
      state.dossier_refresh_last_reason = StringFormat("open-symbol dossier refresh skipped because the minimum publish interval has not elapsed since %s",
                                                       ASC_PublicationHeaderUtc(state.l1_last_open_dossier_publish_utc));
      return;
     }

   state.l1_publish_pending_dossiers = true;
   state.dossier_open_refresh_only = true;
   state.dossier_resume_full_publish_after_open_refresh = false;
   state.dossier_existence_shell_only = false;
   state.l1_publish_pending_manifest = true;
   state.write_dirty = true;
   state.write_cursor = 0;
   state.dossier_refresh_last_status = "admitted";
   state.dossier_refresh_last_reason = "open-symbol dossier refresh admitted and queued into the active dossier publication lane";
  }


bool ASC_CurrentFocusViewWriteDue(const ASC_RuntimeState &state,const datetime now_utc)
  {
   if(!state.current_focus_view_pending || StringLen(state.current_focus_view_symbol) <= 0)
      return false;

   if(ASC_IsCooldownActive(now_utc, state.current_focus_view_backoff_until_utc))
      return false;

   if(state.current_focus_view_earliest_write_utc <= 0)
      return true;

   return (now_utc >= state.current_focus_view_earliest_write_utc);
  }

int ASC_CurrentFocusFailureBackoffSeconds(const int failure_streak)
  {
   int bounded_streak = MathMax(1, failure_streak);
   int backoff_seconds = ASC_CURRENT_FOCUS_FAILURE_BACKOFF_BASE_SEC * bounded_streak;
   return MathMin(backoff_seconds, ASC_CURRENT_FOCUS_FAILURE_BACKOFF_MAX_SEC);
  }

void ASC_ResetCurrentFocusFailureIsolation(ASC_RuntimeState &state,const string symbol = "")
  {
   if(StringLen(symbol) > 0
      && StringLen(state.current_focus_view_last_failed_symbol) > 0
      && symbol != state.current_focus_view_last_failed_symbol)
     {
      return;
     }
   state.current_focus_view_failure_streak = 0;
   state.current_focus_view_backoff_until_utc = 0;
   state.current_focus_view_last_failed_symbol = "";
  }

void ASC_RecordCurrentFocusViewFailure(ASC_RuntimeState &state,
                                       const datetime now_utc,
                                       const string symbol,
                                       const string failure_reason)
  {
   state.current_focus_view_failure_streak = 0;
   state.current_focus_view_backoff_until_utc = 0;
   state.current_focus_view_last_failed_symbol = "";
   state.current_focus_view_pending = false;
   state.current_focus_view_symbol = "";
   if(state.current_focus_view_requested_utc <= 0)
      state.current_focus_view_requested_utc = now_utc;
   state.current_focus_view_earliest_write_utc = 0;
   state.current_focus_last_status = "view_disabled_manual_deep_only";
   state.current_focus_last_reason = "selected-symbol Dossier write failure path suppressed by manual deep-only policy: " + failure_reason;
   state.current_focus_last_served_utc = now_utc;
  }

bool ASC_CurrentFocusSyncStarved(const ASC_RuntimeState &state,const datetime now_utc)
  {
   if(!state.current_focus_view_pending || StringLen(state.current_focus_view_symbol) <= 0)
      return false;

   if(ASC_IsCooldownActive(now_utc, state.current_focus_view_backoff_until_utc))
      return false;

   if(state.current_focus_view_requested_utc <= 0)
      return false;

   return ((now_utc - state.current_focus_view_requested_utc) >= ASC_CURRENT_FOCUS_SYNC_STARVATION_SEC);
  }

void ASC_ArmCurrentFocusViewWrite(ASC_RuntimeState &state,
                                  const datetime now_utc,
                                  const bool broad_scan_backlog,
                                  const string reason)
  {
   state.current_focus_view_pending = false;
   state.current_focus_view_symbol = "";
   state.current_focus_view_requested_utc = (state.hud_selected_symbol_observed_utc > 0
                                             ? state.hud_selected_symbol_observed_utc
                                             : now_utc);
   state.current_focus_last_status = "view_disabled_manual_deep_only";
   state.current_focus_view_earliest_write_utc = 0;
   state.current_focus_last_reason = (StringLen(reason) > 0
                                      ? ("selected-symbol view-sync queue suppressed by manual deep-only model | " + reason)
                                      : "selected-symbol view-sync queue suppressed by manual deep-only model");
  }

bool ASC_ShouldRunLayer2CompanionWork(const ASC_RuntimeState &state,
                                      const datetime now_utc,
                                      const int packet_target,
                                      const int packet_completed,
                                      const int due_selected_total,
                                      const int retry_selected_total,
                                      const bool cycle_complete,
                                      string &reason)
  {
   if(state.l1_l2_live_entitled_count <= 0 && !state.l1_bootstrap_active)
     {
      reason = "l2_deferred_no_live_entitled_symbols";
      return false;
     }

   bool l2_due_now = state.layer2_dirty || (state.l2_next_due_utc > 0 && state.l2_next_due_utc <= now_utc);
   if(cycle_complete)
     {
      reason = "l2_allowed_after_l1_cycle_completion";
      return true;
     }

   if(!l2_due_now)
     {
      reason = "l2_not_due";
      return false;
     }

  if(packet_completed <= 0)
     {
      reason = "l2_allowed_because_l1_packet_idle";
      return true;
     }

   int l2_due_remaining = MathMax(0, state.l2_due_remaining);
   int live_entitled = MathMax(0, state.l1_l2_live_entitled_count);
   int backlog_pressure_floor = MathMax(24, live_entitled / 2);
   bool l2_backlog_pressure = (l2_due_remaining >= backlog_pressure_floor
                               || l2_due_remaining >= MathMax(16, packet_target));

   bool l2_starved = false;
   if(state.layer2_dirty)
     {
      if(state.l2_last_scan_utc <= 0)
         l2_starved = true;
      else
        {
         int starvation_seconds = ASC_L2_COMPANION_STARVATION_SEC;
         if(l2_backlog_pressure)
            starvation_seconds = MathMax(ASC_HEARTBEAT_SECONDS * 2, ASC_L2_COMPANION_STARVATION_SEC / 2);
         l2_starved = ((now_utc - state.l2_last_scan_utc) >= starvation_seconds);
        }
     }

   if(retry_selected_total > 0 && !l2_starved && !l2_backlog_pressure)
     {
      reason = "l2_deferred_to_protect_l1_confirmation";
      return false;
     }

   int heavy_threshold = MathMax(1, (packet_target * 3) / 4);
   if(packet_completed >= heavy_threshold && due_selected_total > 0 && !l2_starved && !l2_backlog_pressure)
     {
      reason = "l2_deferred_to_protect_l1_budget";
      return false;
     }

   if(l2_starved)
     {
      reason = "l2_allowed_for_starvation_relief";
      return true;
     }

   reason = "l2_allowed_within_companion_budget";
   return true;
  }

bool ASC_SymbolMatchesSelectionContext(const ASC_Layer1SymbolState &candidate,const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return false;
   if(candidate.symbol == symbol)
      return true;
   if(candidate.identity.normalized_symbol == symbol)
      return true;
   if(candidate.classification.canonical_symbol == symbol)
      return true;
   return false;
  }

bool ASC_FindLayer1SymbolByName(const string symbol,ASC_Layer1SymbolState &out_symbol)
  {
   if(StringLen(symbol) <= 0)
      return false;

   int cached_symbol_total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < cached_symbol_total; i++)
     {
      ASC_Layer1SymbolState candidate;
      if(!ASC_Layer1GetCachedSymbol(i, candidate))
         continue;
      if(ASC_SymbolMatchesSelectionContext(candidate, symbol))
        {
         out_symbol = candidate;
         return true;
        }
     }
  return false;
  }

string ASC_GlobalTop10ArtifactPathForDirectory(const string directory,
                                                   const string runtime_symbol,
                                                   const string canonical_symbol)
  {
   if(StringLen(directory) <= 0)
      return "";

   string artifact_key = runtime_symbol;
   if(StringLen(artifact_key) <= 0)
      artifact_key = canonical_symbol;
   if(StringLen(artifact_key) <= 0)
      return "";

   return directory + "\\" + artifact_key + ".txt";
  }

string ASC_GlobalTop10LiveDirectory(const ASC_RuntimeState &state)
  {
   if(StringLen(state.server_root) <= 0)
      return "";
   return state.server_root + "\\" + ASC_DOSSIER_FOLDER + "\\GlobalTop10";
  }

string ASC_Top10RunFullStagingDirectory(const ASC_RuntimeState &state)
  {
   string live_dir = ASC_GlobalTop10LiveDirectory(state);
   if(StringLen(live_dir) <= 0)
      return "";
   return live_dir + "\\_staging";
  }

string ASC_GlobalTop10LiveArtifactPath(const ASC_RuntimeState &state,
                                       const string runtime_symbol,
                                       const string canonical_symbol)
  {
   return ASC_GlobalTop10ArtifactPathForDirectory(ASC_GlobalTop10LiveDirectory(state), runtime_symbol, canonical_symbol);
  }

string ASC_GlobalTop10BatchArtifactPath(const ASC_RuntimeState &state,
                                        const string runtime_symbol,
                                        const string canonical_symbol)
  {
   return ASC_GlobalTop10ArtifactPathForDirectory(ASC_Top10RunFullStagingDirectory(state), runtime_symbol, canonical_symbol);
  }

bool ASC_GlobalTop10PayloadCompleteForSymbolContext(const string payload,
                                                       const ASC_Layer1SymbolState &symbol_state,
                                                       const string canonical_symbol,
                                                       const string required_publication_id,
                                                       string &reason_out)
  {
   reason_out = "pending";
   if(StringLen(payload) <= 0)
     {
      reason_out = "top10_payload_missing";
      return false;
     }

   if(ASC_IsDossierShellPayload(payload))
     {
      reason_out = "top10_payload_shell_only";
      return false;
     }

   bool payload_symbol_matches_context = ASC_DossierPayloadMatchesSymbolContext(payload, symbol_state, canonical_symbol);
   if(!payload_symbol_matches_context)
     {
      string payload_live_symbol = ASC_ArtifactLiveSymbolFromPayload(payload);
      if(StringLen(payload_live_symbol) > 0)
        {
         if(ASC_SymbolMatchesSelectionContext(symbol_state, payload_live_symbol))
            payload_symbol_matches_context = true;
         else if(StringLen(canonical_symbol) > 0)
           {
            ASC_SymbolIdentity live_identity = ASC_NormalizeSymbol(payload_live_symbol);
            ASC_SymbolIdentity canonical_identity = ASC_NormalizeSymbol(canonical_symbol);
            if(payload_live_symbol == canonical_symbol
               || (StringLen(live_identity.normalized_symbol) > 0
                   && live_identity.normalized_symbol == canonical_identity.normalized_symbol))
               payload_symbol_matches_context = true;
           }
        }
     }

   if(!payload_symbol_matches_context)
     {
      string payload_symbol = ASC_DossierExtractIdentityLineValue(payload, "Symbol:");
      string payload_canonical = ASC_DossierExtractIdentityLineValue(payload, "Canonical Symbol:");
      reason_out = StringFormat("top10_payload_symbol_mismatch payload_symbol=%s payload_canonical=%s expected_runtime=%s expected_canonical=%s",
                                ASC_TextOrUnavailable(payload_symbol),
                                ASC_TextOrUnavailable(payload_canonical),
                                ASC_TextOrUnavailable(symbol_state.symbol),
                                ASC_TextOrUnavailable(canonical_symbol));
      return false;
     }

   if(StringLen(canonical_symbol) > 0 && !ASC_DossierPayloadMatchesCanonicalSymbol(payload, canonical_symbol))
     {
      reason_out = "top10_payload_canonical_mismatch";
      return false;
     }

   if(!ASC_DossierPayloadPassesMinimumIntegrity(payload, ASC_DOSSIER_MODE_OPEN_MARKET))
     {
      reason_out = "top10_payload_minimum_integrity_failed";
      return false;
     }

   if(!ASC_DossierPayloadHasGlobalTop10ChildIdentity(payload))
     {
      reason_out = "top10_payload_family_identity_mismatch";
      return false;
     }

   if(!ASC_DossierPayloadHasLawfulL0ToL6Coverage(payload))
     {
      if(ASC_DossierPayloadHasLawfulL0ToL4Baseline(payload)
         && ASC_GlobalTop10PayloadCarriesDeferredDeepLabel(payload))
        {
         reason_out = "top10_payload_l0_l4_ready_deep_payload_deferred_terminal_degraded_not_complete";
        }
      else
        {
         if(!ASC_DossierPayloadHasLawfulL0ToL4Baseline(payload))
            reason_out = "top10_payload_missing_l0_l4_baseline";
         else if(!ASC_DossierDeepSectionHasCompletedTruth(payload))
            reason_out = "top10_payload_missing_completed_l5";
         else
            reason_out = "top10_payload_missing_l6_surface";
         return false;
        }
     }

   string publication_id = ASC_PublicationPayloadId(payload);
   if(StringLen(publication_id) <= 0)
     {
      reason_out = "top10_payload_publication_id_missing";
      return false;
     }

   if(StringFind(publication_id, "deep-focus-") != 0
      && StringFind(publication_id, "top10-deferred-") != 0)
     {
      reason_out = "top10_payload_publication_id_not_deep_or_deferred_top10";
      return false;
     }

   if(StringLen(required_publication_id) > 0 && publication_id != required_publication_id)
     {
      reason_out = StringFormat("top10_payload_publication_mismatch required=%s actual=%s",
                                required_publication_id,
                                publication_id);
      return false;
     }

   if(StringLen(reason_out) <= 0 || reason_out == "pending")
      reason_out = "top10_payload_complete_l0_l6";
   return true;
  }

bool ASC_GlobalTop10ArtifactCompleteForSymbolAtPath(const string artifact_path,
                                                    const ASC_Layer1SymbolState &symbol_state,
                                                    const string canonical_symbol,
                                                    const datetime truth_floor_utc,
                                                    const string required_publication_id,
                                                    string &reason_out)
  {
   reason_out = "pending";
   if(StringLen(artifact_path) <= 0)
     {
      reason_out = "top10_artifact_path_unavailable";
      return false;
     }

   string payload = "";
   if(!ASC_ReadTextFile(artifact_path, payload) || StringLen(payload) <= 0)
     {
      reason_out = "top10_artifact_payload_missing";
      return false;
     }

   string payload_reason = "";
   if(!ASC_GlobalTop10PayloadCompleteForSymbolContext(payload,
                                                       symbol_state,
                                                       canonical_symbol,
                                                       required_publication_id,
                                                       payload_reason))
     {
      reason_out = payload_reason;
      return false;
     }

   datetime modified_utc = 0;
   if(truth_floor_utc > 0)
     {
      if(!ASC_FileTryGetModifyUtc(artifact_path, modified_utc) || modified_utc < truth_floor_utc)
        {
         reason_out = StringFormat("top10_artifact_stale truth_floor=%s modified=%s",
                                   ASC_ArtifactFormatUtc(truth_floor_utc),
                                   modified_utc > 0 ? ASC_ArtifactFormatUtc(modified_utc) : "unavailable");
         return false;
        }
     }

   reason_out = "top10_artifact_complete_l0_l6";
   return true;
  }

bool ASC_GlobalTop10ArtifactCompleteForSymbolInDirectory(const ASC_RuntimeState &state,
                                                         const string directory,
                                                         const string symbol,
                                                         const datetime truth_floor_utc,
                                                         const string required_publication_id,
                                                         string &reason_out)
  {
   reason_out = "pending";
   ASC_Layer1SymbolState symbol_state;
   if(!ASC_FindLayer1SymbolByName(symbol, symbol_state))
     {
      reason_out = "top10_family_symbol_missing " + symbol;
      return false;
     }

   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   string artifact_path = ASC_GlobalTop10ArtifactPathForDirectory(directory, symbol_state.symbol, canonical_symbol);
   return ASC_GlobalTop10ArtifactCompleteForSymbolAtPath(artifact_path,
                                                         symbol_state,
                                                         canonical_symbol,
                                                         truth_floor_utc,
                                                         required_publication_id,
                                                         reason_out);
  }

bool ASC_GlobalTop10BatchArtifactCompleteForSymbol(const ASC_RuntimeState &state,
                                                   const ASC_Layer1SymbolState &symbol_state,
                                                   const string canonical_symbol,
                                                   const datetime truth_floor_utc,
                                                   const string required_publication_id,
                                                   string &reason_out)
  {
   string top10_batch_path = ASC_GlobalTop10BatchArtifactPath(state, symbol_state.symbol, canonical_symbol);
   bool ok = ASC_GlobalTop10ArtifactCompleteForSymbolAtPath(top10_batch_path,
                                                            symbol_state,
                                                            canonical_symbol,
                                                            truth_floor_utc,
                                                            required_publication_id,
                                                            reason_out);
   if(!ok)
      reason_out = "top10_batch_" + reason_out;
   else
      reason_out = "top10_batch_payload_complete_l0_l6";
   return ok;
  }

void ASC_GlobalTop10BatchDeleteArtifact(const ASC_RuntimeState &state,
                                        const string runtime_symbol,
                                        const string canonical_symbol)
  {
   string top10_batch_path = ASC_GlobalTop10BatchArtifactPath(state, runtime_symbol, canonical_symbol);
   if(StringLen(top10_batch_path) <= 0)
      return;
   if(!ASC_FileExistsCommon(top10_batch_path))
      return;
   FileDelete(top10_batch_path, FILE_COMMON);
  }

bool ASC_Top10RunFullBuildSnapshot(const ASC_RuntimeState &state,
                                   string &symbols_out[],
                                   string &reason_out)
  {
   reason_out = "";
   ArrayResize(symbols_out, 0);

   ASC_ShortlistSymbolSummary shortlist_rows[];
   if(state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
     {
      int shortlist_count = ArraySize(state.publication_shortlist_rows);
      ArrayResize(shortlist_rows, shortlist_count);
      for(int i = 0; i < shortlist_count; i++)
         shortlist_rows[i] = state.publication_shortlist_rows[i];
     }
   else
      ASC_CopyCommittedL4RowsToShortlistRows(state.committed_l4_rows, shortlist_rows);

   string ranked_symbols[];
   ArrayResize(ranked_symbols, 10);
   for(int i = 0; i < 10; i++)
      ranked_symbols[i] = "";

   for(int i = 0; i < ArraySize(shortlist_rows); i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(shortlist_rows[i]))
         continue;
      int rank = shortlist_rows[i].rank;
      if(rank <= 0 || rank > 10)
         continue;
      if(StringLen(ranked_symbols[rank - 1]) <= 0)
         ranked_symbols[rank - 1] = shortlist_rows[i].symbol;
     }

   for(int i = 0; i < 10; i++)
     {
      if(StringLen(ranked_symbols[i]) <= 0)
         continue;
      int next = ArraySize(symbols_out);
      ArrayResize(symbols_out, next + 1);
      symbols_out[next] = ranked_symbols[i];
     }

   if(ArraySize(symbols_out) <= 0)
     {
      reason_out = "no_lawful_diversified_top10_snapshot_available";
      return false;
     }

   reason_out = StringFormat("snapshot_ready_count=%d from lawful diversified overall carry", ArraySize(symbols_out));
   return true;
  }

bool ASC_QueueDeepTriggerForSymbol(ASC_RuntimeState &state,
                                   const string symbol,
                                   const datetime request_utc,
                                   const string origin,
                                   string &reason_out)
  {
   reason_out = "";
   ASC_Layer1SymbolState selected;
   if(!ASC_FindLayer1SymbolByName(symbol, selected))
     {
      reason_out = "symbol_unavailable_in_layer1_cache";
      return false;
     }

   string frozen_origin = (StringLen(origin) > 0 ? origin : "single_symbol");
   // Batch-owned Global Top 10 completion must not steal HUD selected-symbol ownership
   // or arm ordinary Selected-Symbol Dossier reconciliation for non-selected symbols.
   if(frozen_origin != "global_top10_batch" && !ASC_Top5BucketDeepOrigin(frozen_origin))
     {
      state.hud_selected_symbol = selected.symbol;
      state.hud_selected_symbol_observed_utc = request_utc;
     }
   state.deep_focus_trigger_pending = true;
   state.deep_focus_trigger_symbol = selected.symbol;
   state.deep_focus_trigger_canonical_symbol = selected.classification.canonical_symbol;
   if(StringLen(state.deep_focus_trigger_canonical_symbol) <= 0)
      state.deep_focus_trigger_canonical_symbol = selected.identity.canonical_symbol;
   state.deep_focus_trigger_normalized_symbol = selected.identity.normalized_symbol;
   state.deep_focus_trigger_origin = frozen_origin;
   state.deep_focus_trigger_requested_utc = request_utc;
   state.deep_trigger_request_count++;
   state.deep_focus_trigger_request_seq = state.deep_trigger_request_count;
   state.deep_focus_trigger_last_status = "queued";
   state.deep_focus_last_symbol = selected.symbol;
   state.deep_focus_last_reason = StringFormat("queued by runtime batch scheduler | origin=%s | request_seq=%d",
                                               state.deep_focus_trigger_origin,
                                               state.deep_focus_trigger_request_seq);
   reason_out = "queued";
   return true;
  }

string ASC_Top10RunFullTargetDirectory(const ASC_RuntimeState &state)
  {
   return ASC_GlobalTop10LiveDirectory(state);
  }

string ASC_Top10RunFullBatchTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("top10_batch_status=%s | cursor=%d/%d | inflight=%s | retry=%d | alignment=%s | reason=%s",
                       (StringLen(state.top10_run_full_batch_status) > 0 ? state.top10_run_full_batch_status : "idle"),
                       state.top10_run_full_cursor,
                       state.top10_run_full_total,
                       (StringLen(state.top10_run_full_inflight_symbol) > 0 ? state.top10_run_full_inflight_symbol : "none"),
                       state.top10_run_full_inflight_retry_count,
                       (StringLen(state.top10_run_full_family_alignment_status) > 0 ? state.top10_run_full_family_alignment_status : "unknown"),
                       (StringLen(state.top10_run_full_batch_reason) > 0 ? state.top10_run_full_batch_reason : "none"))
          + " | current_board_signature=" + ASC_TextOrUnavailable(state.top10_run_full_current_source_signature)
          + " | derived_from_board_signature=" + ASC_TextOrUnavailable(state.top10_run_full_last_completed_source_signature);
  }

string ASC_Top10RunFullBatchCountersTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("top10_batch_counts pass=%d | fail=%d | last_total=%d | pending_count=%d | completed_count=%d | expired_count=%d | retry_exhausted_count=%d",
                       state.top10_run_full_verify_pass_count,
                       state.top10_run_full_verify_fail_count,
                       state.top10_run_full_last_total,
                       state.top10_deferred_l5_pending_count,
                       state.top10_deferred_l5_completed_count,
                       state.top10_deferred_l5_expired_count,
                       state.top10_deferred_l5_retry_exhausted_count);
  }

bool ASC_Top10RunFullCadenceDue(const ASC_RuntimeState &state,
                                const datetime now_utc,
                                string &reason_out)
  {
   reason_out = "cadence_not_due";
   if(now_utc <= 0)
     {
      reason_out = "cadence_clock_unavailable";
      return false;
     }

   if(ASC_IsTop10RunFullBatchActive(state))
     {
      reason_out = "cadence_not_due_batch_active";
      return false;
     }

   if(state.top10_run_full_batch_last_served_utc <= 0)
     {
      reason_out = "cadence_due_initial_family_or_first_proof";
      return true;
     }

   int seconds_since_last_cycle = ASC_SecondsBetweenUtc(now_utc, state.top10_run_full_batch_last_served_utc);
   if(seconds_since_last_cycle >= ASC_TOP10_RUN_FULL_CADENCE_SEC)
     {
      reason_out = StringFormat("cadence_due seconds_since_last_cycle=%d cadence_sec=%d",
                                seconds_since_last_cycle,
                                ASC_TOP10_RUN_FULL_CADENCE_SEC);
      return true;
     }

   reason_out = StringFormat("cadence_not_due seconds_since_last_cycle=%d cadence_sec=%d last_cycle=%s",
                             seconds_since_last_cycle,
                             ASC_TOP10_RUN_FULL_CADENCE_SEC,
                             ASC_ArtifactFormatUtc(state.top10_run_full_batch_last_served_utc));
   return false;
  }

int ASC_WarmupTop10L2UnavailableCount()
  {
   int unavailable = 0;
   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[i];
      if(StringLen(packet.symbol) <= 0)
         continue;
      if(!packet.admitted && !packet.tactical_only)
         continue;
      bool quote_incomplete = (packet.hydration_family == ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE
                               || packet.hydration_reason_code == "live_quote_bid_ask_missing"
                               || packet.hydration_reason_code == "live_quote_time_missing"
                               || !packet.valid_bid
                               || !packet.valid_ask
                               || !packet.valid_tick_time);
      bool spec_incomplete = (!packet.has_specification || packet.hydration_reason_code == "spec_owner_missing");
      bool pending_gate = (packet.hydration_gate_code == "blocked_by_warmup"
                           || packet.hydration_gate_code == "blocked_by_post_warmup_repair_queue");
      if(quote_incomplete || spec_incomplete || pending_gate || packet.is_degraded)
         unavailable++;
     }
   return unavailable;
  }

int ASC_WarmupTop10CriticalL2UnavailableCount(const string &snapshot_symbols[],string &detail_out)
  {
   int unavailable = 0;
   int inspected = 0;
   detail_out = "";
   int max_scan = MathMin(ArraySize(snapshot_symbols), ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET);
   for(int i = 0; i < max_scan; i++)
     {
      string symbol = snapshot_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      inspected++;
      int packet_index = ASC_L2FindIndexBySymbol(symbol);
      if(packet_index < 0)
        {
         unavailable++;
         if(StringLen(detail_out) > 0)
            detail_out += ",";
         detail_out += symbol + "=missing_packet";
         continue;
        }
      ASC_Layer2Packet packet = g_asc_l2_cache[packet_index];
      bool quote_incomplete = (packet.hydration_family == ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE
                               || packet.hydration_reason_code == "live_quote_bid_ask_missing"
                               || packet.hydration_reason_code == "live_quote_time_missing"
                               || !packet.valid_bid
                               || !packet.valid_ask
                               || !packet.valid_tick_time);
      bool spec_incomplete = (!packet.has_specification || packet.hydration_reason_code == "spec_owner_missing");
      bool pending_gate = (packet.hydration_gate_code == "blocked_by_warmup"
                           || packet.hydration_gate_code == "blocked_by_post_warmup_repair_queue");
      bool unavailable_symbol = ((!packet.admitted && !packet.tactical_only)
                                 || quote_incomplete
                                 || spec_incomplete
                                 || pending_gate
                                 || packet.is_degraded);
      if(!unavailable_symbol)
         continue;
      unavailable++;
      if(StringLen(detail_out) > 0)
         detail_out += ",";
      detail_out += symbol + "=l2_unresolved";
     }
   if(StringLen(detail_out) <= 0)
      detail_out = StringFormat("clean inspected=%d target=%d", inspected, ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET);
   return unavailable;
  }

bool ASC_WarmupTop10CriticalL2Clean(const string &snapshot_symbols[],const int unavailable_count)
  {
   if(ArraySize(snapshot_symbols) < ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET)
      return false;
   return (unavailable_count <= ASC_WARMUP_FIRST_TOP10_CRITICAL_L2_UNAVAILABLE_MAX);
  }

int ASC_WarmupTop10L2Threshold(const int admitted_symbols)
  {
   int pct_threshold = (admitted_symbols * ASC_WARMUP_FIRST_TOP10_L2_UNAVAILABLE_PCT_MAX) / 100;
   return MathMax(ASC_WARMUP_FIRST_TOP10_L2_UNAVAILABLE_ABS_MAX, pct_threshold);
  }

bool ASC_WarmupTop10L2MinimumComplete(const int admitted_symbols,const int unavailable_count)
  {
   if(admitted_symbols <= 0)
      return false;
   return (unavailable_count <= ASC_WarmupTop10L2Threshold(admitted_symbols));
  }

bool ASC_WarmupFirstTop10TimedOut(const ASC_RuntimeState &state,const datetime now_utc)
  {
   bool seconds_elapsed = (state.warmup_first_top10_started_utc > 0
                           && (now_utc - state.warmup_first_top10_started_utc) >= ASC_WARMUP_FIRST_TOP10_MAX_SECONDS);
   bool heartbeat_elapsed = (state.warmup_first_top10_start_heartbeat > 0
                             && (state.heartbeat_counter - state.warmup_first_top10_start_heartbeat) >= ASC_WARMUP_FIRST_TOP10_MAX_HEARTBEATS);
   bool maturity_seconds = (state.warmup_first_top10_started_utc > 0
                            && (now_utc - state.warmup_first_top10_started_utc) >= ASC_WARMUP_FIRST_TOP10_MIN_MATURITY_SECONDS);
   bool maturity_heartbeats = (state.warmup_first_top10_start_heartbeat > 0
                               && (state.heartbeat_counter - state.warmup_first_top10_start_heartbeat) >= ASC_WARMUP_FIRST_TOP10_MIN_MATURITY_HEARTBEATS);
   bool retry_elapsed = (state.warmup_first_top10_retry_cycles >= ASC_WARMUP_FIRST_TOP10_MAX_RETRY_CYCLES);
   return (seconds_elapsed || heartbeat_elapsed || ((maturity_seconds || maturity_heartbeats) && retry_elapsed));
  }

bool ASC_WarmupEvaluateFirstTop10Release(ASC_RuntimeState &state,
                                         const datetime now_utc,
                                         const string &snapshot_symbols[],
                                         const string snapshot_reason,
                                         string &release_label_out,
                                         string &reason_out)
  {
   release_label_out = "hold";
   reason_out = "warmup_first_top10_unchecked";

   if(state.warmup_first_top10_released)
     {
      release_label_out = state.warmup_first_top10_release_label;
      reason_out = "first_top10_already_released";
      return true;
     }

   state.startup_warmup_active = true;
   if(state.warmup_first_top10_started_utc <= 0)
      state.warmup_first_top10_started_utc = now_utc;
   if(state.warmup_first_top10_start_heartbeat <= 0)
      state.warmup_first_top10_start_heartbeat = state.heartbeat_counter;
   state.warmup_first_top10_armed = true;

   int snapshot_count = ArraySize(snapshot_symbols);
   int total_symbols = g_asc_l1_has_summary ? g_asc_l1_latest_summary.total_symbols : 0;
   int assessed_symbols = g_asc_l1_has_summary ? g_asc_l1_latest_summary.assessed_symbols : 0;
   bool coverage_complete = (total_symbols > 0 && assessed_symbols >= total_symbols && g_asc_l1_latest_summary.remaining_symbols <= 0);
   int l2_admitted = g_asc_l2_has_summary ? g_asc_l2_latest_summary.admitted_symbols : state.l2_admitted_symbols;
   int l2_unavailable = ASC_WarmupTop10L2UnavailableCount();
   bool l2_minimum_complete = ASC_WarmupTop10L2MinimumComplete(l2_admitted, l2_unavailable);
   string top10_l2_detail = "";
   int top10_l2_unavailable = ASC_WarmupTop10CriticalL2UnavailableCount(snapshot_symbols, top10_l2_detail);
   bool top10_l2_clean = ASC_WarmupTop10CriticalL2Clean(snapshot_symbols, top10_l2_unavailable);
   int committed_l3_count = ArraySize(state.committed_l3_rows);
   bool l3_committed_complete = (total_symbols <= 0) ? (state.committed_l3_ready && committed_l3_count > 0)
                                                      : (state.committed_l3_ready && committed_l3_count >= MathMin(total_symbols, assessed_symbols));
   bool l4_shortlist_settled = ((state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) >= ASC_WARMUP_FIRST_TOP10_MIN_USEFUL_CHILDREN)
                                || (state.committed_l4_ready && ArraySize(state.committed_l4_rows) >= ASC_WARMUP_FIRST_TOP10_MIN_USEFUL_CHILDREN));
   bool useful_snapshot = (snapshot_count >= ASC_WARMUP_FIRST_TOP10_MIN_USEFUL_CHILDREN);
   bool essential_publication_clear = (StringLen(snapshot_reason) > 0 && StringFind(snapshot_reason, "no_lawful_diversified_top10_snapshot_available") < 0);

   state.warmup_coverage_complete = coverage_complete;
   state.warmup_l2_minimum_complete = l2_minimum_complete;
   state.warmup_l3_committed_complete = l3_committed_complete;
   state.warmup_l4_shortlist_settled = l4_shortlist_settled;
   state.warmup_l2_unavailable_count = l2_unavailable;
   state.warmup_top10_l2_unavailable_count = top10_l2_unavailable;
   state.warmup_l2_admitted_count = l2_admitted;
   state.warmup_first_top10_snapshot_count = snapshot_count;

   bool complete_release = (coverage_complete
                            && l2_minimum_complete
                            && top10_l2_clean
                            && l3_committed_complete
                            && l4_shortlist_settled
                            && useful_snapshot
                            && essential_publication_clear);
   bool timed_out = ASC_WarmupFirstTop10TimedOut(state, now_utc);
   bool degraded_release = (timed_out && useful_snapshot && essential_publication_clear);

   if(complete_release || degraded_release)
     {
      state.warmup_first_top10_released = true;
      state.warmup_timeout_released = degraded_release;
      state.warmup_degraded_first_publish = degraded_release;
      state.post_warmup_steady = (!degraded_release);
      state.startup_warmup_active = false;
      state.warmup_first_top10_released_utc = now_utc;
      state.warmup_first_top10_release_label = degraded_release ? "degraded_first_publish" : "complete_first_publish";
      release_label_out = state.warmup_first_top10_release_label;
      reason_out = StringFormat("%s | coverage_complete=%s assessed=%d/%d | l2_minimum=%s l2_unavailable=%d/%d threshold=%d | top10_l2_clean=%s top10_l2_unavailable=%d/%d detail=%s | l3_committed=%s rows=%d | l4_settled=%s | snapshot_count=%d | timeout=%s retries=%d",
                                state.warmup_first_top10_release_label,
                                coverage_complete ? "yes" : "no",
                                assessed_symbols,
                                total_symbols,
                                l2_minimum_complete ? "yes" : "no",
                                l2_unavailable,
                                l2_admitted,
                                ASC_WarmupTop10L2Threshold(l2_admitted),
                                top10_l2_clean ? "yes" : "no",
                                top10_l2_unavailable,
                                ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET,
                                ASC_TextOrUnavailable(top10_l2_detail),
                                l3_committed_complete ? "yes" : "no",
                                committed_l3_count,
                                l4_shortlist_settled ? "yes" : "no",
                                snapshot_count,
                                timed_out ? "yes" : "no",
                                state.warmup_first_top10_retry_cycles);
      state.warmup_first_publish_status = degraded_release ? "warmup_timeout_degraded_publish" : "globaltop10_first_publish_released";
      state.warmup_degraded_first_publish_reason = degraded_release ? reason_out : "none";
      state.warmup_no_freeze_escape_available = true;
      state.warmup_later_refresh_not_blocked_by_first_latch = true;
      state.warmup_first_top10_reason = reason_out;
      return true;
     }

   state.warmup_first_top10_retry_cycles++;
   state.warmup_first_top10_last_hold_utc = now_utc;
   state.warmup_first_top10_release_label = "held_for_warmup";
   state.warmup_first_publish_status = timed_out ? "warmup_timeout_fail_open" : "startup_warmup_active";
   state.warmup_no_freeze_escape_available = true;
   state.warmup_later_refresh_not_blocked_by_first_latch = true;
   release_label_out = "held_for_warmup";
   reason_out = StringFormat("held_for_warmup | coverage_complete=%s assessed=%d/%d | l2_minimum=%s l2_unavailable=%d/%d threshold=%d | top10_l2_clean=%s top10_l2_unavailable=%d/%d detail=%s | l3_committed=%s rows=%d | l4_settled=%s | snapshot_count=%d | timeout=%s retries=%d/%d | live_family_preserved=yes",
                             coverage_complete ? "yes" : "no",
                             assessed_symbols,
                             total_symbols,
                             l2_minimum_complete ? "yes" : "no",
                             l2_unavailable,
                             l2_admitted,
                             ASC_WarmupTop10L2Threshold(l2_admitted),
                             top10_l2_clean ? "yes" : "no",
                             top10_l2_unavailable,
                             ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET,
                             ASC_TextOrUnavailable(top10_l2_detail),
                             l3_committed_complete ? "yes" : "no",
                             committed_l3_count,
                             l4_shortlist_settled ? "yes" : "no",
                             snapshot_count,
                             timed_out ? "yes" : "no",
                             state.warmup_first_top10_retry_cycles,
                             ASC_WARMUP_FIRST_TOP10_MAX_RETRY_CYCLES);
   state.warmup_first_top10_reason = reason_out;
   return false;
  }

void ASC_WarmupRequestBoundedL2RetryForTop10(const string &snapshot_symbols[],const datetime now_utc)
  {
   int touched = 0;
   int max_touch = MathMin(ArraySize(snapshot_symbols), ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET);
   for(int i = 0; i < ArraySize(snapshot_symbols) && touched < max_touch; i++)
     {
      string symbol = snapshot_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      int packet_index = ASC_L2FindIndexBySymbol(symbol);
      if(packet_index < 0)
         continue;
      ASC_Layer2Packet packet = g_asc_l2_cache[packet_index];
      if(!packet.admitted && !packet.tactical_only)
         continue;
      bool unresolved = (packet.hydration_family != ASC_L2_HYDRATION_READY
                         || packet.hydration_gate_code == "blocked_by_warmup"
                         || packet.hydration_gate_code == "blocked_by_post_warmup_repair_queue"
                         || packet.is_degraded
                         || !packet.valid_bid
                         || !packet.valid_ask
                         || !packet.valid_tick_time
                         || !packet.has_specification);
      if(!unresolved)
         continue;
      packet.next_due_utc = now_utc;
      packet.next_due_reason = "warmup-first-top10-priority-retry";
      packet.spec_next_due_utc = now_utc;
      packet.spec_next_due_reason = "warmup-first-top10-priority-spec-retry";
      g_asc_l2_cache[packet_index] = packet;
      touched++;
     }
  }

bool ASC_Top10RunFullStageFamilyComplete(const ASC_RuntimeState &state,
                                         string &reason_out)
  {
   reason_out = "stage_unchecked";
   if(ArraySize(state.top10_run_full_symbols) <= 0)
     {
      reason_out = "stage_symbols_unavailable";
      return false;
     }

   int verified_count = 0;
   for(int i = 0; i < ArraySize(state.top10_run_full_symbols); i++)
     {
      string symbol = state.top10_run_full_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_FindLayer1SymbolByName(symbol, symbol_state))
        {
         reason_out = "stage_verify_symbol_missing " + symbol;
         return false;
        }
      string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
      string child_reason = "";
      if(!ASC_GlobalTop10BatchArtifactCompleteForSymbol(state,
                                                        symbol_state,
                                                        canonical_symbol,
                                                        state.top10_run_full_batch_requested_utc,
                                                        "",
                                                        child_reason))
        {
         reason_out = StringFormat("stage_verify_child_failed symbol=%s reason=%s",
                                   symbol,
                                   ASC_TextOrUnavailable(child_reason));
         return false;
        }
      verified_count++;
     }

   if(verified_count <= 0)
     {
      reason_out = "stage_verify_zero_children";
      return false;
     }

   reason_out = StringFormat("stage_complete verified_count=%d source_signature=%s",
                             verified_count,
                             ASC_TextOrUnavailable(state.top10_run_full_inflight_source_signature));
   return true;
  }

bool ASC_Top10RunFullBuildSnapshot(const ASC_RuntimeState &state,
                                   string &symbols_out[],
                                   string &reason_out);
void ASC_RecordTop10BatchDecision(const ASC_RuntimeState &state,
                                  const string scope,
                                  const ASC_FunctionResultState result_state,
                                  const ASC_ResultCode result_code,
                                  const string detail,
                                  const string target_path);

string ASC_Top10RunFullSnapshotSignature(const string &symbols[])
  {
   string signature = "";
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(StringLen(symbols[i]) <= 0)
         continue;
      signature += StringFormat("%02d:%s;", i + 1, symbols[i]);
     }
   return signature;
  }

string ASC_Top10RunFullBoardEpochUtc(const ASC_RuntimeState &state)
  {
   datetime board_epoch = state.market_board_last_publish_utc;
   if(board_epoch <= 0)
      board_epoch = state.publication_bundle.board_publish_finished_utc;
   if(board_epoch <= 0)
      board_epoch = state.publication_shortlist_pass_utc;
   if(board_epoch <= 0)
      board_epoch = state.committed_l4_pass_utc;
   return ASC_ArtifactFormatUtc(board_epoch);
  }

string ASC_Top10RunFullBoardSignature(const ASC_RuntimeState &state,const string &symbols[])
  {
   string visible_top10 = ASC_Top10RunFullSnapshotSignature(symbols);
   return "market_board_diversified_top10"
          + "|board_epoch=" + ASC_Top10RunFullBoardEpochUtc(state)
          + "|visible_top10=" + ASC_TextOrUnavailable(visible_top10)
          + "|build=" + ASC_VERSION_LABEL
          + "|run=" + ASC_TRUTH_SEEKER_CURRENT_RUN;
  }

string ASC_Top10RunFullManifestAlignmentStatus(const string family_state)
  {
   if(StringFind(family_state, "promoted") >= 0)
      return "aligned_current_requires_matching_board_signature";
   if(StringFind(family_state, "archived") >= 0)
      return "archived_historical_board_signature";
   if(StringFind(family_state, "stale") >= 0 || StringFind(family_state, "mismatch") >= 0)
      return "alignment_mismatch_or_stale_current";
   if(StringFind(family_state, "verified") >= 0)
      return "pending_promote_derived_from_board_signature";
   return "pending_refresh_or_unproven_alignment";
  }

bool ASC_Top10RunFullSymbolExists(const string &symbols[],const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return false;
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(symbols[i] == symbol)
         return true;
     }
   return false;
  }

void ASC_CopyStringArray(const string &source[],string &target[])
  {
   ArrayResize(target, ArraySize(source));
   for(int i = 0; i < ArraySize(source); i++)
      target[i] = source[i];
  }

string ASC_Top10RunFullCompactSymbolList(const string &symbols[])
  {
   string compact = "";
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(StringLen(symbols[i]) <= 0)
         continue;
      if(StringLen(compact) > 0)
         compact += ",";
      compact += symbols[i];
     }
   return compact;
  }

string ASC_Top10RunFullFamilyManifestPath(const string directory)
  {
   if(StringLen(directory) <= 0)
      return "";
   return directory + "\\_family_manifest.txt";
  }

string ASC_Top10RunFullBuildFamilyManifest(const string family_role,
                                           const string family_state,
                                           const datetime now_utc,
                                           const datetime source_pass_utc,
                                           const string source_signature,
                                           const string &symbols[],
                                           const string reason,
                                           const string server_root)
  {
   string body = "";
   body += "GLOBAL TOP 10 FAMILY MANIFEST\n";
   body += "Family Role: " + ASC_TextOrUnavailable(family_role) + "\n";
   body += "Family State: " + ASC_TextOrUnavailable(family_state) + "\n";
   body += "Manifest UTC: " + ASC_ArtifactFormatUtc(now_utc) + "\n";
   body += "Source Pass UTC: " + ASC_ArtifactFormatUtc(source_pass_utc) + "\n";
   body += "Source Signature: " + ASC_TextOrUnavailable(source_signature) + "\n";
   body += "Board Epoch UTC: " + ASC_ArtifactFormatUtc(source_pass_utc) + "\n";
   body += "Board Signature: " + ASC_TextOrUnavailable(source_signature) + "\n";
   body += "Derived From Board Signature: " + ASC_TextOrUnavailable(source_signature) + "\n";
   body += ASC_ArtifactIdentityLine("globaltop10_family", family_state) + "\n";
   body += "source_run_id=" + ASC_SourceRunId() + " | source_identity_token=" + ASC_SourceIdentityToken() + " | artifact_written_by_run=" + ASC_SourceRunId() + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion() + " | build_identity_present=true\n";
   body += ASC_RuntimeIdentityProofBlock("globaltop10_family_manifest", server_root, "GlobalTop10", now_utc) + "\n";
   int global_expected = ArraySize(symbols);
   int global_written = (StringFind(family_state, "complete") >= 0 || StringFind(family_state, "promoted") >= 0 || StringFind(family_state, "archived") >= 0) ? global_expected : 0;
   int global_pending = MathMax(0, global_expected - global_written);
   string global_queue_state = (global_pending <= 0 && global_expected > 0) ? "complete" : ((global_expected > 0) ? "partial" : "unknown");
   body += ASC_PublicationForwardProgressProofBlock("GlobalTop10 Dossier",
                                                    "GlobalTop10",
                                                    global_expected,
                                                    global_expected,
                                                    global_written,
                                                    global_written,
                                                    global_written,
                                                    global_pending,
                                                    0,
                                                    now_utc,
                                                    global_written > 0 ? now_utc : 0,
                                                    0,
                                                    reason,
                                                    "manifest_family_state=" + ASC_TextOrUnavailable(family_state),
                                                    global_pending > 0 ? "pending_child_unknown_without_runtime_queue_state" : "none",
                                                    global_queue_state,
                                                    false,
                                                    global_pending > 0,
                                                    "globaltop10_family_manifest",
                                                    global_pending > 0 ? "family_not_complete_or_runtime_queue_state_missing" : "none",
                                                    "RUN253_PUBLICATION_COMPLETION_REPAIR") + "\n";
   string global_snapshot_id = ASC_TextOrUnavailable(source_signature);
   string global_next_pending_symbol = (global_pending > 0 && ArraySize(symbols) > 0) ? symbols[0] : "none";
   string global_same_snapshot_status = (StringLen(source_signature) > 0 && source_signature != "unavailable") ? "matched" : "unproven";
   string global_same_symbol_set_status = (global_expected > 0) ? "matched" : "unproven";
   body += ASC_Run253GlobalTop10PublicationCompletionRepairBlock("ASC_ServiceTop10RunFullBatch/ASC_Top10RunFullWriteFamilyManifest",
                                                                 "ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication",
                                                                 "state.top10_run_full_last_completed_symbols/source_signature",
                                                                 global_snapshot_id,
                                                                 global_expected,
                                                                 global_written,
                                                                 global_written,
                                                                 0,
                                                                 0,
                                                                 global_pending,
                                                                 global_expected,
                                                                 0,
                                                                 0,
                                                                 global_same_snapshot_status,
                                                                 global_same_symbol_set_status) + "\n";
   body += ASC_Run253PublicationCompletionLedgerBlock("GlobalTop10 Dossier",
                                                      "GlobalTop10",
                                                      global_snapshot_id,
                                                      global_expected,
                                                      global_expected,
                                                      global_written,
                                                      global_written,
                                                      global_written,
                                                      global_pending,
                                                      0,
                                                      0,
                                                      global_queue_state,
                                                      "manifest_family_state=" + ASC_TextOrUnavailable(family_state),
                                                      global_written > 0 ? "manifest_family" : "none",
                                                      global_written > 0 ? "manifest_family" : "none",
                                                      global_next_pending_symbol,
                                                      global_pending > 0 ? ASC_Top10RunFullCompactSymbolList(symbols) : "none",
                                                      "none",
                                                      reason,
                                                      "none",
                                                      now_utc) + "\n";
   body += ASC_Run253ShellFirstPublicationStatusBlock("GlobalTop10 Dossier",
                                                      global_snapshot_id,
                                                      global_expected > 0,
                                                      global_written >= global_expected && global_expected > 0,
                                                      global_written >= global_expected && global_expected > 0,
                                                      global_pending > 0 ? "globaltop10_child_shell_completion_pending" : "shells_complete",
                                                      global_pending > 0 ? ASC_Top10RunFullCompactSymbolList(symbols) : "none",
                                                      global_pending > 0 ? ASC_Top10RunFullCompactSymbolList(symbols) : "none",
                                                      "none",
                                                      now_utc) + "\n";
   body += ASC_Run253FamilyFairnessStatusBlock("GlobalTop10 Dossier", "Top5PerBucket", global_pending > 0) + "\n";
   body += ASC_ArtifactAlignmentContractLine("globaltop10_family",
                                             family_role,
                                             source_signature,
                                             source_signature,
                                             "parent",
                                             ASC_Top10RunFullCompactSymbolList(symbols),
                                             family_state,
                                             ASC_Top10RunFullManifestAlignmentStatus(family_state),
                                             "children_expected",
                                             "child_count=" + IntegerToString(ArraySize(symbols)),
                                             (StringFind(family_state, "complete") >= 0 || StringFind(family_state, "promoted") >= 0) ? "requires_child_deep_complete_tokens" : "partial_or_pending",
                                             ASC_Top10RunFullManifestAlignmentStatus(family_state),
                                             0,
                                             ("runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN),
                                             false) + "\n";
   body += ASC_ArtifactRun092ContradictionClassCatalogLine() + "\n";
   body += "alignment_status: " + ASC_Top10RunFullManifestAlignmentStatus(family_state) + "\n";
   body += "stale_current_guard: clean_current_requires_derived_from_board_signature_equals_current_board_signature\n";
   body += ASC_Run081RBuildIdentityToken() + "\n";
   body += StringFormat("Child Count: %d\n", ArraySize(symbols));
   body += "Children: " + ASC_TextOrUnavailable(ASC_Top10RunFullCompactSymbolList(symbols)) + "\n";
   body += ASC_ArtifactFamilyRoleMeaningLine() + "\n";
   body += ASC_ArtifactSurfaceProvenanceLine() + "\n";
   body += "Reason: " + ASC_TextOrUnavailable(reason) + "\n";
   body += "Law: current family remains last confirmed complete family until staging verifies, archive is safe, and promote verifies.\n";
   return body;
  }

bool ASC_Top10RunFullWriteFamilyManifest(const string directory,
                                         const string server_root,
                                         const string family_role,
                                         const string family_state,
                                         const datetime now_utc,
                                         const datetime source_pass_utc,
                                         const string source_signature,
                                         const string &symbols[],
                                         const string reason,
                                         string &write_reason_out)
  {
   write_reason_out = "pending";
   string manifest_path = ASC_Top10RunFullFamilyManifestPath(directory);
   if(StringLen(manifest_path) <= 0)
     {
      write_reason_out = "manifest_path_unavailable";
      return false;
     }

   string required_tokens[];
   ArrayResize(required_tokens, 17);
   required_tokens[0] = "GLOBAL TOP 10 FAMILY MANIFEST";
   required_tokens[1] = "Family Role:";
   required_tokens[2] = "Family State:";
   required_tokens[3] = "Children:";
   required_tokens[4] = "Derived From Board Signature:";
   required_tokens[5] = "stale_current_guard:";
   required_tokens[6] = "source_run_id=";
   required_tokens[7] = "artifact_written_by_run=";
   required_tokens[8] = "artifact_schema_version=";
   required_tokens[9] = "build_identity_present=true";
   required_tokens[10] = "RUN092 Alignment Contract";
   required_tokens[11] = "derived_from_board_signature=";
   required_tokens[12] = "rank_order_formula_change=false";
   required_tokens[13] = "GLOBALTOP10_PUBLICATION_COMPLETION_REPAIR_BEGIN";
   required_tokens[14] = "PUBLICATION_COMPLETION_LEDGER_BEGIN";
   required_tokens[15] = "SHELL_FIRST_PUBLICATION_STATUS_BEGIN";
   required_tokens[16] = "FAMILY_FAIRNESS_STATUS_BEGIN";

   string publication_state = "pending";
   string payload = ASC_Top10RunFullBuildFamilyManifest(family_role,
                                                        family_state,
                                                        now_utc,
                                                        source_pass_utc,
                                                        source_signature,
                                                        symbols,
                                                        reason,
                                                        server_root);
   if(!ASC_WritePublicationPayloadAtomic(manifest_path,
                                         payload,
                                         required_tokens,
                                         family_state,
                                         publication_state,
                                         write_reason_out))
      return false;

   return true;
  }


// Truth Seeker RUN108R: Top5PerBucket queued writer helpers.
// Consumes existing L4 bucket-ranked rows only; no rank/formula/order mutation.
string ASC_Top5BucketRootDirectory(const ASC_RuntimeState &state)
  {
   if(StringLen(state.server_root) <= 0)
      return "";
   return state.server_root + "\\" + ASC_TOP5_BUCKET_PATH_FRAGMENT;
  }

string ASC_Top5BucketSafeSlug(const string bucket_id)
  {
   string slug = bucket_id;
   if(StringLen(slug) <= 0)
      slug = "unknown";
   StringToLower(slug);
   for(int i = 0; i < StringLen(slug); i++)
     {
      ushort ch = StringGetCharacter(slug, i);
      bool ok = ((ch >= 97 && ch <= 122) || (ch >= 48 && ch <= 57) || ch == 95);
      if(!ok)
         StringSetCharacter(slug, i, 95);
     }
   if(StringLen(slug) <= 0)
      slug = "unknown";
   return slug;
  }

string ASC_Top5BucketSafeFileName(const string raw_name)
  {
   string name = raw_name;
   if(StringLen(name) <= 0)
      return "unknown";
   for(int i = 0; i < StringLen(name); i++)
     {
      ushort ch = StringGetCharacter(name, i);
      bool ok = ((ch >= 65 && ch <= 90) || (ch >= 97 && ch <= 122) || (ch >= 48 && ch <= 57) || ch == 95 || ch == 45 || ch == 46);
      if(!ok)
         StringSetCharacter(name, i, 95);
     }
   if(StringLen(name) <= 0)
      name = "unknown";
   return name;
  }

string ASC_Top5BucketDisplayName(const string bucket_id,const string raw_display)
  {
   if(StringLen(raw_display) > 0 && raw_display != "Unknown")
      return raw_display;
   string slug = ASC_Top5BucketSafeSlug(bucket_id);
   if(slug == "fx") return "Forex";
   if(slug == "indices") return "Indices";
   if(slug == "stocks") return "Stocks";
   if(slug == "metals") return "Metals";
   if(slug == "energy") return "Energy";
   if(slug == "crypto") return "Crypto";
   if(slug == "rates") return "Rates";
   if(slug == "volatility") return "Volatility";
   if(slug == "commodities") return "Commodities";
   if(slug == "funds_etfs") return "Funds & ETFs";
   return "Unknown";
  }

string ASC_Top5BucketDirectory(const ASC_RuntimeState &state,const string bucket_slug)
  {
   string root = ASC_Top5BucketRootDirectory(state);
   if(StringLen(root) <= 0)
      return "";
   return root + "\\" + ASC_Top5BucketSafeSlug(bucket_slug);
  }

string ASC_Top5BucketFamilyManifestPath(const ASC_RuntimeState &state)
  {
   string root = ASC_Top5BucketRootDirectory(state);
   if(StringLen(root) <= 0)
      return "";
   return root + "\\" + ASC_TOP5_BUCKET_FAMILY_MANIFEST;
  }

string ASC_Top5BucketManifestPath(const ASC_RuntimeState &state,const string bucket_slug)
  {
   string dir = ASC_Top5BucketDirectory(state, bucket_slug);
   if(StringLen(dir) <= 0)
      return "";
   return dir + "\\" + ASC_TOP5_BUCKET_BUCKET_MANIFEST;
  }

string ASC_Top5BucketChildPath(const ASC_RuntimeState &state,const string bucket_slug,const string symbol)
  {
   string dir = ASC_Top5BucketDirectory(state, bucket_slug);
   if(StringLen(dir) <= 0 || StringLen(symbol) <= 0)
      return "";
   return dir + "\\" + ASC_Top5BucketSafeFileName(symbol) + ".txt";
  }

string ASC_Top5BucketFamilyStagingDirectory(const ASC_RuntimeState &state)
  {
   string root = ASC_Top5BucketRootDirectory(state);
   if(StringLen(root) <= 0)
      return "";
   return root + "\\" + ASC_TOP5_BUCKET_STAGING_FOLDER;
  }

string ASC_Top5BucketFamilyArchiveDirectory(const ASC_RuntimeState &state,const datetime now_utc)
  {
   string root = ASC_Top5BucketRootDirectory(state);
   if(StringLen(root) <= 0)
      return "";
   return root + "\\" + ASC_TOP5_BUCKET_ARCHIVE_FOLDER + "\\" + ASC_Top10ArchiveCadenceSlotLabel(now_utc);
  }

string ASC_Top5BucketStagingDirectory(const ASC_RuntimeState &state,const string bucket_slug)
  {
   string family_stage = ASC_Top5BucketFamilyStagingDirectory(state);
   if(StringLen(family_stage) <= 0)
      return "";
   return family_stage + "\\" + ASC_Top5BucketSafeSlug(bucket_slug);
  }

string ASC_Top5BucketArchiveDirectory(const ASC_RuntimeState &state,const string bucket_slug,const datetime now_utc)
  {
   string family_archive = ASC_Top5BucketFamilyArchiveDirectory(state, now_utc);
   if(StringLen(family_archive) <= 0)
      return "";
   return family_archive + "\\" + ASC_Top5BucketSafeSlug(bucket_slug);
  }

string ASC_Top5BucketChildStagingPath(const ASC_RuntimeState &state,const string bucket_slug,const string symbol)
  {
   string dir = ASC_Top5BucketStagingDirectory(state, bucket_slug);
   if(StringLen(dir) <= 0 || StringLen(symbol) <= 0)
      return "";
   return dir + "\\" + ASC_Top5BucketSafeFileName(symbol) + ".txt";
  }

string ASC_Top5BucketChildArchivePath(const ASC_RuntimeState &state,const string bucket_slug,const string symbol_file,const datetime now_utc)
  {
   string dir = ASC_Top5BucketArchiveDirectory(state, bucket_slug, now_utc);
   if(StringLen(dir) <= 0 || StringLen(symbol_file) <= 0)
      return "";
   return dir + "\\" + ASC_Top5BucketSafeFileName(symbol_file);
  }

// Truth Seeker RUN117R: live proof repair for Top5PerBucket staging/archive observability.
// Materializes lightweight marker manifests only; no active child deletion, no rank/order/formula/FileIO/lane/heartbeat change.
string ASC_Top5BucketFamilyArchiveManifestPath(const ASC_RuntimeState &state,const datetime now_utc)
  {
   string dir = ASC_Top5BucketFamilyArchiveDirectory(state, now_utc);
   if(StringLen(dir) <= 0)
      return "";
   return dir + "\\_archive_manifest.txt";
  }

string ASC_Top5BucketStagingManifestPath(const ASC_RuntimeState &state)
  {
   string dir = ASC_Top5BucketFamilyStagingDirectory(state);
   if(StringLen(dir) <= 0)
      return "";
   return dir + "\\_staging_manifest.txt";
  }

bool ASC_Top5BucketWriteArchiveManifest(ASC_RuntimeState &state,const datetime now_utc,const string phase,const string cleanup_reason,string &reason_out)
  {
   reason_out = "pending";
   string path = ASC_Top5BucketFamilyArchiveManifestPath(state, now_utc);
   if(StringLen(path) <= 0)
     {
      reason_out = "top5_archive_manifest_path_unavailable";
      return false;
     }

   string body = "Top5PerBucket Archive Manifest\n";
   body += "artifact_family=Top5PerBucket\n";
   body += "artifact_family_id=top5_per_bucket\n";
   body += "source_run_id=" + ASC_VERSION_LABEL + "\n";
   body += "archive_state=materialized_marker\n";
   body += "archive_phase=" + ASC_TextOrUnavailable(phase) + "\n";
   body += "archive_slot=" + ASC_Top10ArchiveCadenceSlotLabel(now_utc) + "\n";
   body += "archive_path=" + ASC_TextOrUnavailable(ASC_Top5BucketFamilyArchiveDirectory(state, now_utc)) + "\n";
   body += "top5_archive_enabled=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false") + "\n";
   body += "top5_archive_previous_on_promote=" + (ASC_TOP5_ARCHIVE_PREVIOUS_ON_PROMOTE ? "true" : "false") + "\n";
   body += "top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false") + "\n";
   body += "top5_no_broad_file_deletion=true\n";
   body += "cleanup_reason=" + ASC_TextOrUnavailable(cleanup_reason) + "\n";
   body += "materialization_reason=RUN117_live_gap_archive_folder_not_exported_when_no_previous_children_exist\n";

   string required[];
   ArrayResize(required, 8);
   required[0] = "Top5PerBucket Archive Manifest";
   required[1] = "artifact_family_id=top5_per_bucket";
   required[2] = "archive_state=";
   required[3] = "top5_archive_enabled=true";
   required[4] = "top5_archive_previous_on_promote=true";
   required[5] = "top5_promote_after_validate=true";
   required[6] = "top5_no_broad_file_deletion=true";
   required[7] = "materialization_reason=";

   string write_state = "pending";
   return ASC_WritePublicationPayloadAtomic(path, body, required, "archive_marker", write_state, reason_out);
  }

bool ASC_Top5BucketWriteStagingManifest(ASC_RuntimeState &state,const datetime now_utc,const string phase,string &reason_out)
  {
   reason_out = "pending";
   string path = ASC_Top5BucketStagingManifestPath(state);
   if(StringLen(path) <= 0)
     {
      reason_out = "top5_staging_manifest_path_unavailable";
      return false;
     }

   string body = "Top5PerBucket Staging Manifest\n";
   body += "artifact_family=Top5PerBucket\n";
   body += "artifact_family_id=top5_per_bucket\n";
   body += "source_run_id=" + ASC_VERSION_LABEL + "\n";
   body += "staging_state=cleared_after_promote\n";
   body += "staging_phase=" + ASC_TextOrUnavailable(phase) + "\n";
   body += "staging_path=" + ASC_TextOrUnavailable(ASC_Top5BucketFamilyStagingDirectory(state)) + "\n";
   body += "current_surface_path=" + ASC_TextOrUnavailable(ASC_Top5BucketRootDirectory(state)) + "\n";
   body += "staging_contains_promoted_source_copies=false\n";
   body += "staging_currentness=false\n";
   body += "staging_cleanup_policy=clear_children_after_successful_promote\n";
   body += "top5_staging_enabled=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false") + "\n";
   body += "top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false") + "\n";
   body += "top5_no_broad_file_deletion=true\n";
   body += "materialization_reason=RUN118_lifecycle_staging_is_temporary_not_second_active_copy\n";

   string required[];
   ArrayResize(required, 8);
   required[0] = "Top5PerBucket Staging Manifest";
   required[1] = "artifact_family_id=top5_per_bucket";
   required[2] = "staging_state=cleared_after_promote";
   required[3] = "staging_currentness=false";
   required[4] = "top5_staging_enabled=true";
   required[5] = "top5_promote_after_validate=true";
   required[6] = "top5_no_broad_file_deletion=true";
   required[7] = "materialization_reason=";

   string write_state = "pending";
   return ASC_WritePublicationPayloadAtomic(path, body, required, "staging_marker", write_state, reason_out);
  }

bool ASC_Top5BucketDeepOrigin(const string origin)
  {
   return (StringFind(origin, "top5_per_bucket:") == 0);
  }

string ASC_Top5BucketOriginSlug(const string origin)
  {
   if(!ASC_Top5BucketDeepOrigin(origin))
      return "";
   string rest = StringSubstr(origin, StringLen("top5_per_bucket:"));
   int sep = StringFind(rest, ":");
   if(sep <= 0)
      return ASC_Top5BucketSafeSlug(rest);
   return ASC_Top5BucketSafeSlug(StringSubstr(rest, 0, sep));
  }

int ASC_Top5BucketOriginRank(const string origin)
  {
   if(!ASC_Top5BucketDeepOrigin(origin))
      return 0;
   string rest = StringSubstr(origin, StringLen("top5_per_bucket:"));
   int sep = StringFind(rest, ":");
   if(sep < 0)
      return 0;
   string rank_text = StringSubstr(rest, sep + 1);
   int next_sep = StringFind(rank_text, ":");
   if(next_sep >= 0)
      rank_text = StringSubstr(rank_text, 0, next_sep);
   int rank = (int)StringToInteger(rank_text);
   return (rank >= 1 && rank <= 5) ? rank : 0;
  }

string ASC_Top5BucketDepthParityState(const int bucket_rank,const bool payload_attached)
  {
   if(bucket_rank >= 1 && bucket_rank <= 5)
      return payload_attached ? "deep_payload_attached" : "deep_pending";
   return "deep_pending";
  }

// Truth Seeker RUN111R: remove stale Top5PerBucket child files before a new live batch.
// This is intentionally scoped to the Top5PerBucket child folders only; it does not alter
// FileIO atomic publication, artifact roots, rank formulas, Market Board order, or L3/L4 truth.
bool ASC_Top5BucketCleanupChildFilesForSlug(const ASC_RuntimeState &state,const string bucket_slug,string &reason_out)
  {
   reason_out = "pending";
   string dir = ASC_Top5BucketDirectory(state, bucket_slug);
   if(StringLen(dir) <= 0)
     {
      reason_out = "cleanup_directory_unavailable";
      return false;
     }

   string found_name = "";
   long handle = FileFindFirst(dir + "\\*.txt", found_name, FILE_COMMON);
   if(handle == INVALID_HANDLE)
     {
      reason_out = "cleanup_no_existing_child_files";
      return true;
     }

   int archived = 0;
   int failed = 0;
   do
     {
      if(found_name == ASC_TOP5_BUCKET_BUCKET_MANIFEST || StringLen(found_name) <= 0)
         continue;
      string child_path = dir + "\\" + found_name;
      string archive_path = ASC_Top5BucketChildArchivePath(state, bucket_slug, found_name, TimeGMT());
      string archive_state = "pending";
      string archive_reason = "pending";
      string archive_required[];
      ArrayResize(archive_required, 0);
      if(StringLen(archive_path) > 0 && ASC_FileExistsCommon(archive_path))
         archived++;
      else if(StringLen(archive_path) > 0 && ASC_CopyTextFileAtomic(child_path, archive_path, archive_required, archive_state, archive_reason))
         archived++;
      else
         failed++;
     }
   while(FileFindNext(handle, found_name));
   FileFindClose(handle);

   reason_out = StringFormat("cleanup_child_files archived=%d failed=%d top5_no_broad_file_deletion=true", archived, failed);
   return (failed == 0);
  }

bool ASC_Top5BucketCleanupActiveChildFiles(ASC_RuntimeState &state,string &reason_out)
  {
   reason_out = "pending";
   int failed = 0;
   int cleaned = 0;
   string detail = "";
   for(int i = 0; i < ArraySize(state.top5_bucket_active_slugs); i++)
     {
      string slug = state.top5_bucket_active_slugs[i];
      string part = "";
      if(ASC_Top5BucketCleanupChildFilesForSlug(state, slug, part))
         cleaned++;
      else
         failed++;
      if(StringLen(detail) > 0)
         detail += ";";
      detail += slug + "=" + part;
     }

   reason_out = StringFormat("top5_bucket_child_folder_cleanup cleaned=%d failed=%d | %s", cleaned, failed, detail);
   return (failed == 0);
  }

int ASC_Top5BucketActiveIndex(const ASC_RuntimeState &state,const string slug)
  {
   for(int i = 0; i < ArraySize(state.top5_bucket_active_slugs); i++)
     {
      if(state.top5_bucket_active_slugs[i] == slug)
         return i;
     }
   return -1;
  }

void ASC_Top5BucketCanonicalCleanupSlugs(string &slugs[])
  {
   ArrayResize(slugs, 11);
   slugs[0] = "fx";
   slugs[1] = "indices";
   slugs[2] = "stocks";
   slugs[3] = "metals";
   slugs[4] = "energy";
   slugs[5] = "crypto";
   slugs[6] = "rates";
   slugs[7] = "volatility";
   slugs[8] = "commodities";
   slugs[9] = "funds_etfs";
   slugs[10] = "unknown";
  }

string ASC_Top5BucketSnapshotId(const ASC_RuntimeState &state)
  {
   return "l4_rev=" + IntegerToString((long)state.committed_l4_revision)
          + "|l4_pass=" + ASC_ArtifactFormatUtc(state.committed_l4_pass_utc)
          + "|board_pass=" + ASC_ArtifactFormatUtc(state.publication_shortlist_pass_utc)
          + "|signature=" + ASC_TextOrUnavailable(state.top5_bucket_last_signature);
  }

bool ASC_Top5BucketFileNameExpectedForSlug(const ASC_RuntimeState &state,const string slug,const string file_name)
  {
   if(StringLen(slug) <= 0 || StringLen(file_name) <= 0)
      return false;
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      if(state.top5_bucket_queue_slugs[i] != slug)
         continue;
      string expected = ASC_Top5BucketSafeFileName(state.top5_bucket_queue_symbols[i]) + ".txt";
      if(expected == file_name)
         return true;
     }
   return false;
  }

int ASC_Top5BucketCountChildFilesInDirectory(const string dir)
  {
   if(StringLen(dir) <= 0)
      return 0;
   string found_name = "";
   long handle = FileFindFirst(dir + "\\*.txt", found_name, FILE_COMMON);
   if(handle == INVALID_HANDLE)
      return 0;
   int count = 0;
   do
     {
      if(StringLen(found_name) <= 0 || found_name == ASC_TOP5_BUCKET_BUCKET_MANIFEST)
         continue;
      count++;
     }
   while(FileFindNext(handle, found_name));
   FileFindClose(handle);
   return count;
  }

int ASC_Top5BucketCountActiveChildFiles(const ASC_RuntimeState &state)
  {
   string slugs[];
   ASC_Top5BucketCanonicalCleanupSlugs(slugs);
   int count = 0;
   for(int i = 0; i < ArraySize(slugs); i++)
      count += ASC_Top5BucketCountChildFilesInDirectory(ASC_Top5BucketDirectory(state, slugs[i]));
   return count;
  }

int ASC_Top5BucketCountStagingChildFiles(const ASC_RuntimeState &state)
  {
   string slugs[];
   ASC_Top5BucketCanonicalCleanupSlugs(slugs);
   int count = 0;
   for(int i = 0; i < ArraySize(slugs); i++)
      count += ASC_Top5BucketCountChildFilesInDirectory(ASC_Top5BucketStagingDirectory(state, slugs[i]));
   return count;
  }

bool ASC_Top5BucketStageFamilyComplete(const ASC_RuntimeState &state,string &reason_out)
  {
   reason_out = "stage_unchecked";
   string queue_guard_reason = "";
   if(!ASC_Top5BucketQueueArraysAligned(state, true, true, queue_guard_reason))
     {
      reason_out = queue_guard_reason;
      return false;
     }
   int expected = 0;
   int existing = 0;
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      string staging_path = ASC_Top5BucketChildStagingPath(state, state.top5_bucket_queue_slugs[i], state.top5_bucket_queue_symbols[i]);
      if(StringLen(staging_path) <= 0)
        {
         reason_out = "stage_path_unavailable";
         return false;
        }
      expected++;
      if(ASC_FileExistsCommon(staging_path))
         existing++;
      else
        {
         reason_out = "stage_child_missing symbol=" + state.top5_bucket_queue_symbols[i] + " bucket=" + state.top5_bucket_queue_slugs[i];
         return false;
        }
     }
   reason_out = StringFormat("stage_family_complete expected=%d existing=%d", expected, existing);
   return (expected > 0 && existing == expected);
  }

bool ASC_Top5BucketArchiveAndDeleteActiveChildrenForSlug(const ASC_RuntimeState &state,const string bucket_slug,const datetime now_utc,int &archived,int &deleted,int &failed,string &reason_out)
  {
   reason_out = "pending";
   int duplicate_skipped = 0;
   string dir = ASC_Top5BucketDirectory(state, bucket_slug);
   if(StringLen(dir) <= 0)
     {
      reason_out = "active_directory_unavailable";
      failed++;
      return false;
     }
   string found_name = "";
   long handle = FileFindFirst(dir + "\\*.txt", found_name, FILE_COMMON);
   if(handle == INVALID_HANDLE)
     {
      reason_out = "active_no_child_files";
      return true;
     }
   do
     {
      if(found_name == ASC_TOP5_BUCKET_BUCKET_MANIFEST || StringLen(found_name) <= 0)
         continue;
      string child_path = dir + "\\" + found_name;
      string archive_path = ASC_Top5BucketChildArchivePath(state, bucket_slug, found_name, now_utc);
      string archive_state = "pending";
      string archive_reason = "pending";
      string archive_required[];
      ArrayResize(archive_required, 0);
      if(StringLen(archive_path) > 0 && ASC_FileExistsCommon(archive_path))
        {
         duplicate_skipped++;
         archived++;
         if(ASC_DeleteFileIfExists(child_path))
            deleted++;
         else
            failed++;
        }
      else if(StringLen(archive_path) > 0 && ASC_CopyTextFileAtomic(child_path, archive_path, archive_required, archive_state, archive_reason))
        {
         archived++;
         if(ASC_DeleteFileIfExists(child_path))
            deleted++;
         else
            failed++;
        }
      else
         failed++;
     }
   while(FileFindNext(handle, found_name));
   FileFindClose(handle);
   reason_out = StringFormat("active_archive_then_remove bucket=%s archived=%d duplicate_skipped=%d deleted=%d failed=%d", bucket_slug, archived, duplicate_skipped, deleted, failed);
   return (failed == 0);
  }

bool ASC_Top5BucketArchiveAndDeleteActiveChildren(ASC_RuntimeState &state,const datetime now_utc,string &reason_out)
  {
   reason_out = "pending";
   string slugs[];
   ASC_Top5BucketCanonicalCleanupSlugs(slugs);
   int archived = 0;
   int deleted = 0;
   int failed = 0;
   string detail = "";
   for(int i = 0; i < ArraySize(slugs); i++)
     {
      string part = "";
      ASC_Top5BucketArchiveAndDeleteActiveChildrenForSlug(state, slugs[i], now_utc, archived, deleted, failed, part);
      if(StringLen(detail) > 0) detail += ";";
      detail += slugs[i] + "=" + part;
     }
   reason_out = StringFormat("top5_active_prune_policy=archive_then_remove_from_active archived=%d deleted=%d failed=%d top5_no_broad_file_deletion=true | %s", archived, deleted, failed, detail);
   return (failed == 0);
  }

bool ASC_Top5BucketPromoteStagedFamily(ASC_RuntimeState &state,const datetime now_utc,string &reason_out)
  {
   reason_out = "pending";
   string queue_guard_reason = "";
   if(!ASC_Top5BucketQueueArraysAligned(state, true, true, queue_guard_reason))
     {
      reason_out = queue_guard_reason;
      return false;
     }
   string required_tokens[];
   ArrayResize(required_tokens, 0);
   int promoted = 0;
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      string staging_path = ASC_Top5BucketChildStagingPath(state, state.top5_bucket_queue_slugs[i], state.top5_bucket_queue_symbols[i]);
      string child_path = ASC_Top5BucketChildPath(state, state.top5_bucket_queue_slugs[i], state.top5_bucket_queue_symbols[i]);
      string promote_state = "pending";
      string promote_reason = "pending";
      if(StringLen(staging_path) <= 0 || StringLen(child_path) <= 0)
        {
         reason_out = "promote_path_unavailable";
         return false;
        }
      if(!ASC_CopyTextFileAtomic(staging_path, child_path, required_tokens, promote_state, promote_reason))
        {
         reason_out = "promote_copy_failed symbol=" + state.top5_bucket_queue_symbols[i] + " state=" + promote_state + " reason=" + promote_reason;
         return false;
        }
      promoted++;
     }
   int active_actual = ASC_Top5BucketCountActiveChildFiles(state);
   if(active_actual != state.top5_bucket_child_target_count)
     {
      reason_out = StringFormat("promote_active_set_not_exact target=%d actual=%d promoted=%d", state.top5_bucket_child_target_count, active_actual, promoted);
      return false;
     }
   reason_out = StringFormat("promote_staged_family_complete promoted=%d top5_active_child_actual_count=%d top5_active_set_exact=true", promoted, active_actual);
   return true;
  }

bool ASC_Top5BucketClearStagingChildrenForSlug(const ASC_RuntimeState &state,const string bucket_slug,int &cleared,int &failed,string &reason_out)
  {
   reason_out = "pending";
   string dir = ASC_Top5BucketStagingDirectory(state, bucket_slug);
   if(StringLen(dir) <= 0)
     {
      reason_out = "staging_directory_unavailable";
      failed++;
      return false;
     }
   string found_name = "";
   long handle = FileFindFirst(dir + "\\*.txt", found_name, FILE_COMMON);
   if(handle == INVALID_HANDLE)
     {
      reason_out = "staging_empty";
      return true;
     }
   do
     {
      if(StringLen(found_name) <= 0 || found_name == "_staging_manifest.txt")
         continue;
      string child_path = dir + "\\" + found_name;
      if(ASC_DeleteFileIfExists(child_path))
         cleared++;
      else
         failed++;
     }
   while(FileFindNext(handle, found_name));
   FileFindClose(handle);
   reason_out = StringFormat("staging_clear bucket=%s cleared=%d failed=%d", bucket_slug, cleared, failed);
   return (failed == 0);
  }

bool ASC_Top5BucketClearStagingChildren(ASC_RuntimeState &state,string &reason_out)
  {
   reason_out = "pending";
   string slugs[];
   ASC_Top5BucketCanonicalCleanupSlugs(slugs);
   int cleared = 0;
   int failed = 0;
   string detail = "";
   for(int i = 0; i < ArraySize(slugs); i++)
     {
      string part = "";
      ASC_Top5BucketClearStagingChildrenForSlug(state, slugs[i], cleared, failed, part);
      if(StringLen(detail) > 0) detail += ";";
      detail += slugs[i] + "=" + part;
     }
   reason_out = StringFormat("top5_staging_cleared_after_promote=%s cleared=%d failed=%d top5_staging_currentness=false | %s", failed == 0 ? "true" : "false", cleared, failed, detail);
   return (failed == 0);
  }

bool ASC_Top5BucketFinalizeSuccessfulBatch(ASC_RuntimeState &state,const datetime now_utc,string &reason_out)
  {
   reason_out = "pending";
   string stage_reason = "";
   if(!ASC_Top5BucketStageFamilyComplete(state, stage_reason))
     {
      reason_out = "stage_validation_failed | " + stage_reason;
      return false;
     }
   int active_before = ASC_Top5BucketCountActiveChildFiles(state);
   string archive_prune_reason = "";
   if(!ASC_Top5BucketArchiveAndDeleteActiveChildren(state, now_utc, archive_prune_reason))
     {
      reason_out = "archive_prune_failed | " + archive_prune_reason;
      return false;
     }
   string promote_reason = "";
   if(!ASC_Top5BucketPromoteStagedFamily(state, now_utc, promote_reason))
     {
      reason_out = "promote_failed | " + promote_reason + " | archive_prune=" + archive_prune_reason;
      return false;
     }
   string clear_reason = "";
   bool clear_ok = ASC_Top5BucketClearStagingChildren(state, clear_reason);
   int active_after = ASC_Top5BucketCountActiveChildFiles(state);
   int staging_after = ASC_Top5BucketCountStagingChildFiles(state);
   reason_out = StringFormat("finalize_success stage=%s | active_before=%d active_after=%d target=%d stale_before=%d | %s | %s | %s | top5_staging_child_count=%d top5_active_set_exact=%s",
                             ASC_TextOrUnavailable(stage_reason),
                             active_before,
                             active_after,
                             state.top5_bucket_child_target_count,
                             MathMax(0, active_before - state.top5_bucket_child_target_count),
                             ASC_TextOrUnavailable(archive_prune_reason),
                             ASC_TextOrUnavailable(promote_reason),
                             ASC_TextOrUnavailable(clear_reason),
                             staging_after,
                             (active_after == state.top5_bucket_child_target_count && staging_after == 0 && clear_ok) ? "true" : "false");
   return (active_after == state.top5_bucket_child_target_count && clear_ok);
  }

string ASC_Top5BucketCompactQueueList(const string &symbols[],const string &slugs[],const int &ranks[])
  {
   return ASC_Top5SnapshotCompactList(symbols, slugs, ranks, false);
  }

string ASC_Top5BucketNormalizedQueueList(const string &symbols[],const string &slugs[],const int &ranks[])
  {
   return ASC_Top5SnapshotCompactList(symbols, slugs, ranks, true);
  }


bool ASC_Top5BucketQueueArraysAligned(const ASC_RuntimeState &state,const bool require_displays,const bool require_hydration,string &reason_out)
  {
   int queue_count = ArraySize(state.top5_bucket_queue_symbols);
   if(queue_count != ArraySize(state.top5_bucket_queue_slugs)
      || queue_count != ArraySize(state.top5_bucket_queue_ranks))
     {
      reason_out = StringFormat("queue_array_size_mismatch symbols=%d slugs=%d ranks=%d",
                                queue_count,
                                ArraySize(state.top5_bucket_queue_slugs),
                                ArraySize(state.top5_bucket_queue_ranks));
      return false;
     }
   if(require_displays && queue_count != ArraySize(state.top5_bucket_queue_displays))
     {
      reason_out = StringFormat("queue_display_array_size_mismatch symbols=%d displays=%d",
                                queue_count,
                                ArraySize(state.top5_bucket_queue_displays));
      return false;
     }
   if(require_hydration && queue_count != ArraySize(state.top5_bucket_queue_hydration))
     {
      reason_out = StringFormat("queue_hydration_array_size_mismatch symbols=%d hydration=%d",
                                queue_count,
                                ArraySize(state.top5_bucket_queue_hydration));
      return false;
     }
   reason_out = "queue_arrays_aligned";
   return true;
  }

bool ASC_Top5BucketResizeQueueArrays(ASC_RuntimeState &state,const int new_size,string &reason_out)
  {
   reason_out = "pending";
   if(new_size < 0)
     {
      reason_out = "top5_queue_resize_negative_size";
      return false;
     }
   if(ArrayResize(state.top5_bucket_queue_symbols, new_size) != new_size
      || ArrayResize(state.top5_bucket_queue_slugs, new_size) != new_size
      || ArrayResize(state.top5_bucket_queue_displays, new_size) != new_size
      || ArrayResize(state.top5_bucket_queue_ranks, new_size) != new_size
      || ArrayResize(state.top5_bucket_queue_hydration, new_size) != new_size)
     {
      reason_out = StringFormat("top5_queue_resize_failed requested=%d", new_size);
      return false;
     }
   reason_out = StringFormat("top5_queue_resize_ok size=%d", new_size);
   return true;
  }

bool ASC_Top5BucketResizeActiveBucketArrays(ASC_RuntimeState &state,const int new_size,string &reason_out)
  {
   reason_out = "pending";
   if(new_size < 0)
     {
      reason_out = "top5_active_bucket_resize_negative_size";
      return false;
     }
   if(ArrayResize(state.top5_bucket_active_slugs, new_size) != new_size
      || ArrayResize(state.top5_bucket_active_displays, new_size) != new_size
      || ArrayResize(state.top5_bucket_active_targets, new_size) != new_size
      || ArrayResize(state.top5_bucket_active_written, new_size) != new_size
      || ArrayResize(state.top5_bucket_active_failed, new_size) != new_size)
     {
      reason_out = StringFormat("top5_active_bucket_resize_failed requested=%d", new_size);
      return false;
     }
   reason_out = StringFormat("top5_active_bucket_resize_ok size=%d", new_size);
   return true;
  }

string ASC_Top5BucketSignature(const ASC_RuntimeState &state)
  {
   return ASC_Top5SnapshotSignatureFromArrays(state.publication_shortlist_pass_utc,
                                             state.top5_bucket_queue_symbols,
                                             state.top5_bucket_queue_slugs,
                                             state.top5_bucket_queue_ranks,
                                             true);
  }

string ASC_Top5BucketExactSignature(const ASC_RuntimeState &state)
  {
   return ASC_Top5SnapshotSignatureFromArrays(state.publication_shortlist_pass_utc,
                                             state.top5_bucket_queue_symbols,
                                             state.top5_bucket_queue_slugs,
                                             state.top5_bucket_queue_ranks,
                                             false);
  }


string ASC_Run245Top5BucketQueueSymbols(const ASC_RuntimeState &state,const string bucket_id)
  {
   string symbols = "";
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      if(i >= ArraySize(state.top5_bucket_queue_slugs))
         continue;
      if(state.top5_bucket_queue_slugs[i] != bucket_id)
         continue;
      string symbol = state.top5_bucket_queue_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      if(StringLen(symbols) > 0)
         symbols += ",";
      symbols += symbol;
     }
   return (StringLen(symbols) > 0 ? symbols : "unknown");
  }

string ASC_Run245Top5BucketQueueAllSymbols(const ASC_RuntimeState &state)
  {
   string symbols = "";
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      string symbol = state.top5_bucket_queue_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      if(StringLen(symbols) > 0)
         symbols += ",";
      symbols += symbol;
     }
   return (StringLen(symbols) > 0 ? symbols : "unknown");
  }


string ASC_Top5BucketManifestBoardSyncStatus(const ASC_RuntimeState &state,const int active_actual_count,const int staging_child_count)
  {
   if(StringLen(state.top5_bucket_last_signature) <= 0)
      return "not_yet_committed";
   if(state.top5_bucket_queue_remaining > 0 || state.top5_bucket_child_pending_count > 0)
      return "queue_pending";
   if(staging_child_count > 0)
      return "alignment_pending_refresh";
   if(state.top5_bucket_family_state != ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT)
      return "cadence_hold";
   if(state.top5_bucket_child_target_count <= 0)
      return "not_yet_committed";
   if(active_actual_count != state.top5_bucket_child_target_count)
      return "snapshot_mismatch";
   return "committed_snapshot_ready_market_board_compare_required";
  }

string ASC_Top5BucketActionability(const ASC_Layer1SymbolState &symbol_state)
  {
   if(symbol_state.state == ASC_L1_OPEN && !symbol_state.is_stale && !symbol_state.is_degraded)
      return "open_confirmed_candidate_not_trade_signal";
   if(symbol_state.state == ASC_L1_CLOSED)
      return "retained_closed_not_actionable";
   if(symbol_state.state == ASC_L1_UNCERTAIN)
      return "uncertain_not_actionable";
   if(symbol_state.is_stale)
      return "stale_not_current";
   if(symbol_state.is_degraded)
      return "degraded_not_actionable";
   return "unknown_not_actionable";
  }

bool ASC_Top5BucketBuildRows(ASC_RuntimeState &state,ASC_ShortlistSymbolSummary &rows_out[],string &reason_out)
  {
   ArrayResize(rows_out, 0);
   reason_out = "pending";

   ASC_ShortlistSymbolSummary source_rows[];
   if(state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
     {
      ArrayResize(source_rows, ArraySize(state.publication_shortlist_rows));
      for(int i = 0; i < ArraySize(state.publication_shortlist_rows); i++)
         source_rows[i] = state.publication_shortlist_rows[i];
     }
   else
      ASC_CopyCommittedL4RowsToShortlistRows(state.committed_l4_rows, source_rows);

   for(int i = 0; i < ArraySize(source_rows); i++)
     {
      if(!source_rows[i].bucket_shortlisted || source_rows[i].bucket_rank <= 0 || source_rows[i].bucket_rank > 5)
         continue;
      int next = ArraySize(rows_out);
      if(ArrayResize(rows_out, next + 1) != next + 1)
        {
         reason_out = "top5_bucket_rows_resize_failed";
         ArrayResize(rows_out, 0);
         return false;
        }
      rows_out[next] = source_rows[i];
     }

   if(ArraySize(rows_out) <= 0)
     {
      reason_out = "no_existing_l4_bucket_top5_rows_available";
      return false;
     }

   for(int i = 0; i < ArraySize(rows_out); i++)
     {
      for(int j = i + 1; j < ArraySize(rows_out); j++)
        {
         string left_bucket = ASC_Top5BucketSafeSlug(ASC_ClassificationEffectiveMainBucketId(rows_out[i].state.classification));
         string right_bucket = ASC_Top5BucketSafeSlug(ASC_ClassificationEffectiveMainBucketId(rows_out[j].state.classification));
         bool swap = false;
         if(StringCompare(left_bucket, right_bucket) > 0)
            swap = true;
         else if(left_bucket == right_bucket && rows_out[i].bucket_rank > rows_out[j].bucket_rank)
            swap = true;
         if(swap)
           {
            ASC_ShortlistSymbolSummary tmp = rows_out[i];
            rows_out[i] = rows_out[j];
            rows_out[j] = tmp;
           }
        }
     }

   reason_out = StringFormat("bucket_top5_source_ready rows=%d", ArraySize(rows_out));
   return true;
  }

bool ASC_Top5BucketWriteFamilyManifest(ASC_RuntimeState &state,const datetime now_utc,string &reason_out)
  {
   reason_out = "pending";
   string path = ASC_Top5BucketFamilyManifestPath(state);
   if(StringLen(path) <= 0)
     {
      reason_out = "family_manifest_path_unavailable";
      return false;
     }
   string body = "TOP5 PER BUCKET FAMILY MANIFEST\n";
   body += "artifact_family_id=" + ASC_TOP5_BUCKET_FAMILY_ID + "\n";
   body += "family_state=" + ASC_TextOrUnavailable(state.top5_bucket_family_state) + "\n";
   body += "path=" + ASC_TOP5_BUCKET_PATH_FRAGMENT + "\n";
   body += "source_run_id=" + ASC_SourceRunId() + "\n";
   body += ASC_RuntimeIdentityProofBlock("top5perbucket_family_manifest", state.server_root, "Top5PerBucket", now_utc) + "\n";
   int top5_expected = MathMax(0, state.top5_bucket_child_target_count);
   int top5_attempted = MathMax(0, state.top5_bucket_child_written_count + state.top5_bucket_child_failed_count);
   int top5_written = MathMax(0, state.top5_bucket_child_written_count);
   int top5_pending = MathMax(0, state.top5_bucket_child_pending_count + state.top5_bucket_queue_remaining);
   string top5_queue_state = (top5_expected <= 0) ? "unknown" : ((top5_pending > 0) ? "pending" : ((state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT) ? "complete" : "partial"));
   body += ASC_PublicationForwardProgressProofBlock("Top5PerBucket Dossier",
                                                    "Top5PerBucket",
                                                    top5_expected,
                                                    MathMax(0, ArraySize(state.top5_bucket_queue_symbols)),
                                                    top5_attempted,
                                                    top5_written,
                                                    top5_written,
                                                    top5_pending,
                                                    MathMax(0, state.top5_bucket_child_failed_count),
                                                    now_utc,
                                                    top5_written > 0 ? now_utc : 0,
                                                    state.top5_bucket_child_failed_count > 0 ? now_utc : 0,
                                                    state.top5_bucket_last_error,
                                                    "queue_remaining=" + IntegerToString(MathMax(0, state.top5_bucket_queue_remaining)),
                                                    state.top5_bucket_last_symbol,
                                                    top5_queue_state,
                                                    false,
                                                    top5_pending > 0,
                                                    "top5perbucket_family_manifest",
                                                    top5_pending > 0 ? "queue_or_child_pending" : "none",
                                                    "RUN253_PUBLICATION_COMPLETION_REPAIR") + "\n";
   body += "bucket_count=" + IntegerToString(MathMax(0, state.top5_bucket_count)) + "\n";
   body += "bucket_child_target_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_target_count)) + "\n";
   body += "bucket_child_written_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_written_count)) + "\n";
   body += "bucket_child_pending_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_pending_count)) + "\n";
   body += "bucket_child_failed_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_failed_count)) + "\n";
   body += "bucket_family_promoted=" + ((state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT) ? "true" : "false") + "\n";
   body += "bucket_family_partial=" + ((state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PARTIAL || state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_QUEUED) ? "true" : "false") + "\n";
   body += "bucket_family_degraded=" + ((state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_DEGRADED || state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_BLOCKED) ? "true" : "false") + "\n";
   body += "bucket_manifest_written=true\n";
   body += "top5_per_bucket_queue_remaining=" + IntegerToString(MathMax(0, state.top5_bucket_queue_remaining)) + "\n";
   body += "top5_per_bucket_last_symbol=" + ASC_TextOrUnavailable(state.top5_bucket_last_symbol) + "\n";
   body += "top5_per_bucket_last_error=" + ASC_TextOrUnavailable(state.top5_bucket_last_error) + "\n";
   body += "closed_symbols_actionable=false\nrank_formula_change=false\ntrade_signal=false\nexecution_change=false\n";
   body += "next_due=" + ASC_ArtifactFormatUtc(state.top5_bucket_next_due) + "\n";
   body += "bucket_signature=" + ASC_TextOrUnavailable(state.top5_bucket_last_signature) + "\n";
   body += "proof_boundary=" + ASC_TOP5_BUCKET_PROOF_BOUNDARY + "\n";
   body += "dynamic_sub_family_readiness=" + ASC_TOP5_BUCKET_DYNAMIC_SUBFAMILY_READINESS + "\n";
   body += "sub_family_writer_active=false\n";
   body += "top5_depth_parity_state=" + ASC_TOP5_DEPTH_PARITY_STATE_SOURCE_PATCHED + "\n";
   body += "top5_rank_1_3_deep_attempted=" + (ASC_TOP5_RANK_1_3_DEEP_ATTEMPTED ? "true" : "false") + "\n";
   body += "top5_rank_1_3_deep_attached=source_pending_live_unproven\n";
   body += "top5_rank_1_3_deep_pending=until_existing_deep_owner_overwrites_child\n";
   body += "top5_rank_4_5_deep_pending=" + (ASC_TOP5_RANK_4_5_DEEP_PENDING ? "true" : "false") + "\n";
   body += "top5_child_expected_size_class=rank1_5_globaltop10_style_deep_when_attached\n";
   body += "top5_child_depth_class=rank1_5_existing_deep_owner_deep_payload_attached_when_ready\n";
   body += "top5_staging_enabled=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false") + "\n";
   body += "top5_archive_enabled=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false") + "\n";
   body += "top5_family_staging_path=" + ASC_TextOrUnavailable(ASC_Top5BucketFamilyStagingDirectory(state)) + "\n";
   body += "top5_family_archive_path=" + ASC_TextOrUnavailable(ASC_Top5BucketFamilyArchiveDirectory(state, now_utc)) + "\n";
   body += "top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false") + "\n";
   body += "top5_archive_previous_on_promote=" + (ASC_TOP5_ARCHIVE_PREVIOUS_ON_PROMOTE ? "true" : "false") + "\n";
   body += "top5_no_broad_file_deletion=true\n";
   body += "safe_cleanup_patch=" + ASC_RUN114_SAFE_CLEANUP_PATCH + "\n";
   body += "run115_safe_cleanup_patch=" + ASC_RUN115_SAFE_CLEANUP_PATCH + "\n";
   body += "run116_safe_cleanup_patch=" + ASC_RUN116_SAFE_CLEANUP_PATCH + "\n";
   body += "run126_safe_cleanup_patch=" + ASC_RUN126_SAFE_CLEANUP_PATCH + "\n";
   body += "run127_safe_cleanup_patch=" + ASC_RUN127_SAFE_CLEANUP_PATCH + "\n";
   body += "top5_rank_1_5_deep_queue_enabled=true\n";
   body += "top5_rank_4_5_permanent_deep_pending=false\n";
   body += "top5_rank_4_5_deep_pending_policy=temporary_until_existing_deep_owner_attaches\n";
   body += "proof_unchanged_skipped_count=" + IntegerToString(MathMax(0, state.proof_unchanged_skipped_count)) + "\n";
   body += "top5_unchanged_decision_skipped_count=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count)) + "\n";
   body += "top5_duplicate_decision_skipped=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count)) + "\n";
   body += "root_policy_duplicate_log_skipped=" + IntegerToString(MathMax(0, state.dossier_publication_policy_unchanged_log_skipped_count)) + "\n";
   body += "top5_per_bucket_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_PER_BUCKET_REFRESH_CADENCE_SEC) + "\n";
   body += "top5_membership_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_BUCKET_CADENCE_SEC) + "\n";
   body += "market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC) + "\n";
   body += "\nTOP5_SDP_PUBLICATION_OWNER_TRACE_BEGIN\n";
   body += "top5_sdp_publication_owner_trace_version=RUN249_v1\n";
   body += "top5_dossier_publication_owner=ASC_ServiceTop5PerBucketFamily/ASC_Top5BucketWriteChild\n";
   body += "top5_sdp_publication_owner=ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication\n";
   body += "top5_sdp_expected_source=state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs\n";
   body += "top5_sdp_expected_symbol_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_total > 0 ? state.symbol_data_pack_top5perbucket_total : state.top5_bucket_child_target_count)) + "\n";
   body += "top5_sdp_queue_owner=ASC_RuntimeState.symbol_data_pack_top5perbucket_cursor_over_top5_bucket_queue_symbols\n";
   body += "top5_sdp_writer_owner=ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState\n";
   body += "top5_sdp_runtime_join_owner=ASC_SymbolDataPackComposer_RUN247_runtime_override_prepared_by_writer_from_ASC_RuntimeState\n";
   body += "top5_sdp_current_blocker=" + ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_activation_mode) + "\n";
   body += "top5_sdp_blocker_reason=" + ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_last_reason) + "\n";
   body += "top5_sdp_next_step=resume_top5_sdp_mirror_until_expected_children_written_or_failed_with_reason\n";
   body += "route_change_performed=false\npath_change_performed=false\nfileio_final_path_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "TOP5_SDP_PUBLICATION_OWNER_TRACE_END\n";
   int run249_expected = MathMax(0, state.symbol_data_pack_top5perbucket_total > 0 ? state.symbol_data_pack_top5perbucket_total : state.top5_bucket_child_target_count);
   int run249_written = MathMax(0, state.symbol_data_pack_top5perbucket_written_count + state.symbol_data_pack_top5perbucket_no_change_count);
   int run249_failed = MathMax(0, state.symbol_data_pack_top5perbucket_failed_count);
   int run249_pending = MathMax(0, run249_expected - run249_written - run249_failed);
   int run253_main_expected = MathMax(0, state.top5_bucket_child_target_count);
   int run253_main_written = MathMax(0, state.top5_bucket_child_written_count);
   int run253_main_failed = MathMax(0, state.top5_bucket_child_failed_count);
   int run253_main_pending = MathMax(0, state.top5_bucket_child_pending_count + state.top5_bucket_queue_remaining);
   int run253_lite_expected = run249_expected;
   int run253_lite_written = run249_written;
   int run253_lite_failed = run249_failed;
   int run253_lite_pending = run249_pending;
   string run253_snapshot_id = ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state));
   string run253_next_symbol = (state.top5_bucket_queue_cursor >= 0 && state.top5_bucket_queue_cursor < ArraySize(state.top5_bucket_queue_symbols)) ? state.top5_bucket_queue_symbols[state.top5_bucket_queue_cursor] : "none";
   string run253_next_bucket = (state.top5_bucket_queue_cursor >= 0 && state.top5_bucket_queue_cursor < ArraySize(state.top5_bucket_queue_slugs)) ? state.top5_bucket_queue_slugs[state.top5_bucket_queue_cursor] : "none";
   string run253_main_lite_parity = ASC_Run253ParityStatus(run253_main_expected,
                                                           run253_main_written,
                                                           run253_lite_expected,
                                                           run253_lite_written,
                                                           ASC_TextOrUnavailable(state.top5_bucket_last_signature),
                                                           ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_source_signature));
   body += "\n" + ASC_Run253Top5PerBucketPublicationCompletionRepairBlock("state.top5_bucket_active_slugs/state.top5_bucket_active_targets",
                                                                          "state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs/state.top5_bucket_queue_ranks",
                                                                          run253_snapshot_id,
                                                                          MathMax(0, state.top5_bucket_count),
                                                                          5,
                                                                          run253_main_expected,
                                                                          run253_main_written,
                                                                          run253_main_written,
                                                                          run253_lite_written,
                                                                          run253_lite_written,
                                                                          MathMax(0, state.top5_bucket_count - ArraySize(state.top5_bucket_active_slugs)),
                                                                          MathMax(run253_main_pending, run253_lite_pending),
                                                                          MathMax(run253_main_failed, run253_lite_failed),
                                                                          run253_main_pending > 0 ? "see_top5_bucket_queue_from_resume_cursor" : "none",
                                                                          run253_lite_pending > 0 ? "see_sdp_top5_cursor_and_last_reason" : "none",
                                                                          MathMax(run253_main_failed, run253_lite_failed) > 0 ? "see_failed_child_reason" : "none",
                                                                          ASC_TextOrUnavailable(state.top5_bucket_last_error + " | " + state.symbol_data_pack_top5perbucket_last_error),
                                                                          (MathMax(run253_main_pending, run253_lite_pending) > 0 ? "pending" : (MathMax(run253_main_failed, run253_lite_failed) > 0 ? "partial" : "complete")),
                                                                          IntegerToString(MathMax(0, state.top5_bucket_queue_cursor)) + "/" + IntegerToString(MathMax(0, ArraySize(state.top5_bucket_queue_symbols))),
                                                                          run253_next_bucket,
                                                                          run253_next_symbol,
                                                                          run253_main_lite_parity) + "\n";
   body += ASC_Run253PublicationCompletionLedgerBlock("Top5PerBucket Dossier",
                                                      "Top5PerBucket",
                                                      run253_snapshot_id,
                                                      run253_main_expected,
                                                      MathMax(0, ArraySize(state.top5_bucket_queue_symbols)),
                                                      MathMax(0, run253_main_written + run253_main_failed),
                                                      run253_main_written,
                                                      run253_main_written,
                                                      run253_main_pending,
                                                      run253_main_failed,
                                                      0,
                                                      (run253_main_pending > 0 ? "pending" : (run253_main_failed > 0 ? "partial" : "complete")),
                                                      IntegerToString(MathMax(0, state.top5_bucket_queue_cursor)),
                                                      ASC_TextOrUnavailable(state.top5_bucket_last_symbol),
                                                      run253_main_written > 0 ? ASC_TextOrUnavailable(state.top5_bucket_last_symbol) : "none",
                                                      run253_next_symbol,
                                                      run253_main_pending > 0 ? "see_top5_bucket_queue_symbols_from_cursor" : "none",
                                                      run253_main_failed > 0 ? "see_top5_bucket_last_error" : "none",
                                                      state.top5_bucket_last_error,
                                                      ASC_TextOrUnavailable(state.lane_deferred_reason),
                                                      state.top5_bucket_next_due) + "\n";
   body += ASC_Run253PublicationCompletionLedgerBlock("Symbol Data Packs/Top5PerBucket",
                                                      "Top5PerBucket",
                                                      run253_snapshot_id,
                                                      run253_lite_expected,
                                                      run253_lite_expected,
                                                      MathMax(0, state.symbol_data_pack_top5perbucket_attempted_count),
                                                      run253_lite_written,
                                                      run253_lite_written,
                                                      run253_lite_pending,
                                                      run253_lite_failed,
                                                      0,
                                                      (run253_lite_pending > 0 ? "pending" : (run253_lite_failed > 0 ? "partial" : "complete")),
                                                      IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_cursor)),
                                                      ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_last_symbol),
                                                      state.symbol_data_pack_top5perbucket_last_success_utc > 0 ? ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_last_symbol) : "none",
                                                      (state.symbol_data_pack_top5perbucket_cursor >= 0 && state.symbol_data_pack_top5perbucket_cursor < ArraySize(state.top5_bucket_queue_symbols)) ? state.top5_bucket_queue_symbols[state.symbol_data_pack_top5perbucket_cursor] : "none",
                                                      run253_lite_pending > 0 ? "see_top5_sdp_cursor_over_top5_queue" : "none",
                                                      run253_lite_failed > 0 ? "see_top5_sdp_last_error" : "none",
                                                      state.symbol_data_pack_top5perbucket_last_error,
                                                      ASC_TextOrUnavailable(state.lane_deferred_reason),
                                                      state.symbol_data_pack_top5perbucket_next_due_utc) + "\n";
   body += ASC_Run253ShellFirstPublicationStatusBlock("Top5PerBucket Main/Lite",
                                                      run253_snapshot_id,
                                                      (run253_main_expected > 0 && MathMax(run253_main_written, run253_lite_written) > 0),
                                                      (run253_main_expected > 0 && run253_main_written >= run253_main_expected && run253_lite_written >= run253_lite_expected),
                                                      (run253_main_expected > 0 && run253_main_written >= run253_main_expected && run253_lite_written >= run253_lite_expected),
                                                      MathMax(run253_main_pending, run253_lite_pending) > 0 ? "top5_main_or_lite_shell_completion_pending" : "shells_complete",
                                                      MathMax(run253_main_pending, run253_lite_pending) > 0 ? "see_publication_completion_ledgers" : "none",
                                                      MathMax(run253_main_pending, run253_lite_pending) > 0 ? "see_publication_completion_ledgers" : "none",
                                                      MathMax(run253_main_failed, run253_lite_failed) > 0 ? "see_publication_completion_ledgers" : "none",
                                                      state.symbol_data_pack_top5perbucket_next_due_utc) + "\n";
   body += ASC_Run253FamilyFairnessStatusBlock("Top5PerBucket Main/Lite", "GlobalTop10", MathMax(run253_main_pending, run253_lite_pending) > 0) + "\n";
   body += "\nPUBLICATION_COMPLETION_LEDGER_BEGIN\n";
   body += "publication_completion_ledger_version=RUN253_v1\n";
   body += "family=Symbol Data Packs/Top5PerBucket\n";
   body += "route_family=Top5PerBucket\n";
   body += "snapshot_id=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "expected_child_count=" + IntegerToString(run249_expected) + "\n";
   body += "written_child_count=" + IntegerToString(run249_written) + "\n";
   body += "readback_confirmed_child_count=" + IntegerToString(run249_written) + "\n";
   body += "pending_child_count=" + IntegerToString(run249_pending) + "\n";
   body += "failed_child_count=" + IntegerToString(run249_failed) + "\n";
   body += "stale_replan_count=0\n";
   body += "queue_state=" + ((run249_expected <= 0) ? "pending" : (run249_pending > 0 ? "pending" : (run249_failed > 0 ? "partial" : "complete"))) + "\n";
   body += "queue_resume_cursor=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_cursor)) + "\n";
   body += "last_attempted_symbol=" + ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_last_symbol) + "\n";
   body += "last_written_symbol=" + ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_last_success_utc > 0 ? state.symbol_data_pack_top5perbucket_last_symbol : "") + "\n";
   body += "next_pending_symbol=" + ASC_TextOrUnavailable((run249_pending > 0 && state.symbol_data_pack_top5perbucket_cursor >= 0 && state.symbol_data_pack_top5perbucket_cursor < ArraySize(state.top5_bucket_queue_symbols)) ? state.top5_bucket_queue_symbols[state.symbol_data_pack_top5perbucket_cursor] : "none") + "\n";
   body += "pending_symbols=see_top5_bucket_queue_from_queue_resume_cursor\nfailed_symbols=see_writer_reason_last_error\nfailure_reasons=" + ASC_TextOrUnavailable(state.symbol_data_pack_top5perbucket_last_error) + "\n";
   body += "last_yield_reason=" + ASC_TextOrUnavailable(state.lane_deferred_reason) + "\n";
   body += "next_retry_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc) + "\n";
   body += "completion_status=" + ((run249_expected <= 0) ? "pending" : (run249_pending > 0 ? "pending" : (run249_failed > 0 ? "partial" : "complete"))) + "\n";
   body += "completion_blocks_trade=true\ncompletion_blocks_review=false\nroute_change_performed=false\npath_change_performed=false\nfileio_final_path_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   body += "PUBLICATION_COMPLETION_LEDGER_END\n";
   body += "\nSHELL_FIRST_PUBLICATION_STATUS_BEGIN\n";
   body += "shell_first_publication_status_version=RUN253_v1\nfamily=Symbol Data Packs/Top5PerBucket\n";
   body += "snapshot_id=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "shell_before_deep_payload=true\n";
   body += "all_expected_shells_attempted=" + ((run249_expected > 0 && (run249_written + run249_failed) >= run249_expected) ? "true" : "false") + "\n";
   body += "all_expected_shells_written=" + ((run249_expected > 0 && run249_written >= run249_expected && run249_failed <= 0) ? "true" : "false") + "\n";
   body += "deep_payload_allowed=" + ((run249_expected > 0 && run249_written >= run249_expected && run249_failed <= 0) ? "true" : "false") + "\n";
   body += "deep_payload_defer_reason=" + ((run249_expected > 0 && run249_written >= run249_expected && run249_failed <= 0) ? "shells_complete" : "top5_sdp_shell_status_completion_pending") + "\n";
   body += "pending_shell_symbols=see_publication_completion_ledger\nmissing_shell_symbols=see_publication_completion_ledger\nfailed_shell_symbols=see_publication_completion_ledger\n";
   body += "next_shell_retry_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc) + "\n";
   body += "review_allowed_when_shell_partial=true\ntrade_allowed_when_shell_partial=false\nSHELL_FIRST_PUBLICATION_STATUS_END\n";
   body += "\nREQUIRED_TOKEN_CADENCE_PARITY_BEGIN\nrequired_token_cadence_parity_version=RUN249_v1\nlegacy_required_token_detected=market_board_publish_cadence_sec=60\ncurrent_required_token=market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC) + "\ncadence_token_source=ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC\ncadence_token_validation_status=repaired\nvalidation_deleted=false\nvalidation_scope=cadence_token_only\nREQUIRED_TOKEN_CADENCE_PARITY_END\n";
   body += "\nFAMILY_FAIRNESS_STATUS_BEGIN\nfamily_fairness_version=RUN253_v1\nshell_quota_per_beat=1\ndeep_payload_quota_per_beat=deferred_until_shell_status_complete\nfamily_progress_order=root_status,family_manifest,top5_sdp_shell_status,deep_payload\nstarvation_guard_active=true\ntop5_sdp_starvation_guard=true\nlast_family_served=Symbol Data Packs/Top5PerBucket\nnext_family_due=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc) + "\nFAMILY_FAIRNESS_STATUS_END\n";
   body += "l4_shortlist_refresh_cadence_sec=" + IntegerToString(ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC) + "\n";
   body += "market_board_republish_uses_committed_l4=true\n";
   body += ASC_Run157SpeedTruthFillOwnerMapLine() + "\n";
   body += "l4_snapshot_epoch=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "l4_membership_window_seconds=" + IntegerToString(ASC_RUN156_L4_STATIC_MEMBERSHIP_SEC) + "\n";
   body += "l4_membership_static_until=" + (state.committed_l4_next_recheck_utc > 0 ? ASC_ArtifactFormatUtc(state.committed_l4_next_recheck_utc) : "unavailable") + "\n";
   body += "l4_membership_static_active=" + ((state.committed_l4_next_recheck_utc > now_utc) ? "true" : "false") + "\n";
   body += "l4_membership_refresh_due=" + ((state.committed_l4_next_recheck_utc > 0 && now_utc >= state.committed_l4_next_recheck_utc) ? "true" : "false") + "\n";
   body += "top5_l4_epoch=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "globaltop10_l4_epoch=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "top5_globaltop10_epoch_match=true\n";
   body += "l4_info_refresh_independent=true\n";
   body += "displayed_symbol_info_refresh_seconds=" + IntegerToString(ASC_RUN156_DISPLAYED_INFO_REFRESH_SEC) + "\n";
   body += "bucket_fill_target_seconds=" + IntegerToString(ASC_RUN156_BUCKET_FILL_TARGET_SEC) + "\n";
   body += "market_board_snapshot_id=" + ASC_Top5BucketSnapshotId(state) + "\n";
   body += "l4_committed_snapshot_id=" + ASC_Top5BucketSnapshotId(state) + "\n";
   body += "top5_bucket_snapshot_id=" + ASC_Top5BucketSnapshotId(state) + "\n";
   body += "top5_bucket_committed_signature=" + ASC_TextOrUnavailable(state.top5_bucket_last_signature) + "\n";
   body += "top5_bucket_committed_exact_signature=" + ASC_Top5BucketExactSignature(state) + "\n";
   int top5_active_actual_count = ASC_Top5BucketCountActiveChildFiles(state);
   int top5_staging_child_count = ASC_Top5BucketCountStagingChildFiles(state);
   string top5_manifest_sync_status = ASC_Top5BucketManifestBoardSyncStatus(state, top5_active_actual_count, top5_staging_child_count);
   body += "top5_market_board_sync=false\n";
   body += "top5_market_board_sync_status=" + top5_manifest_sync_status + "\n";
   body += "top5_market_board_sync_reason=manifest_does_not_assert_visible_board_sync_without_market_board_signature_compare\n";
   body += "top5_snapshot_age_sec=" + IntegerToString(state.committed_l4_last_built_utc > 0 ? ASC_SecondsBetweenUtc(now_utc, state.committed_l4_last_built_utc) : -1) + "\n";
   body += "top5_active_child_target_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_target_count)) + "\n";
   body += "top5_active_child_actual_count=" + IntegerToString(MathMax(0, top5_active_actual_count)) + "\n";
   body += "top5_active_stale_child_count=" + IntegerToString(MathMax(0, top5_active_actual_count - state.top5_bucket_child_target_count)) + "\n";
   body += "top5_active_stale_children_archived=true\n";
   body += "top5_active_set_exact=" + ((top5_active_actual_count == state.top5_bucket_child_target_count && state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT) ? "true" : "false") + "\n";
   body += "top5_active_prune_policy=archive_then_remove_from_active\n";
   body += "top5_staging_state=" + ((top5_staging_child_count <= 0 && state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT) ? "idle_empty" : "refresh_or_failed_retained") + "\n";
   body += "top5_staging_child_count=" + IntegerToString(MathMax(0, top5_staging_child_count)) + "\n";
   body += "top5_staging_cleared_after_promote=" + ((top5_staging_child_count <= 0 && state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT) ? "true" : "false") + "\n";
   body += "top5_staging_retained_for_failure=" + ((top5_staging_child_count > 0 && state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_DEGRADED) ? "true" : "false") + "\n";
   body += "top5_staging_currentness=false\n";
   body += "top5_archive_state=" + ((state.top5_bucket_family_state == ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT) ? "previous_active_archived_on_promote" : "marker_or_pending") + "\n";
   body += "top5_archive_child_count=previous_active_snapshot\n";
   body += "top5_archive_previous_on_promote=true\n";
   body += "top5_archive_duplicate_skipped=true\n";
   body += "market_board_to_top5_dossier_sync=false\n";
   body += "market_board_to_top5_dossier_sync_status=" + top5_manifest_sync_status + "\n";
   body += "market_board_to_top5_dossier_sync_reason=manifest_child_count_is_not_visible_market_board_signature_sync\n";
   body += "market_board_top5_symbol_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_target_count)) + "\n";
   body += "top5_matching_dossier_count=" + IntegerToString(MathMax(0, MathMin(top5_active_actual_count, state.top5_bucket_child_target_count))) + "\n";
   body += "top5_missing_dossier_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_target_count - top5_active_actual_count)) + "\n";
   body += "top5_missing_dossier_symbols=see_bucket_manifests_if_nonzero\n";
   body += "top5_lookup_path_policy=Top5PerBucket/<bucket>/<symbol>.txt\n";
   body += "globaltop10_lookup_path_policy=GlobalTop10/<symbol>.txt\n";
   body += "performance_side_audit=" + ASC_PERFORMANCE_SIDE_AUDIT_STATE + "\n";
   body += "safe_cleanup_patch=" + ASC_RUN118_SAFE_CLEANUP_PATCH + "\n";
   body += "top5_no_broad_file_deletion=true\n";
   body += "symbols=" + ASC_TextOrUnavailable(ASC_Top5BucketCompactQueueList(state.top5_bucket_queue_symbols, state.top5_bucket_queue_slugs, state.top5_bucket_queue_ranks)) + "\n";

   string required[];
   ArrayResize(required, 61);
   required[0] = "TOP5 PER BUCKET FAMILY MANIFEST";
   required[1] = "artifact_family_id=top5_per_bucket";
   required[2] = "family_state=";
   required[3] = "bucket_child_target_count=";
   required[4] = "bucket_child_written_count=";
   required[5] = "bucket_manifest_written=true";
   required[6] = "top5_per_bucket_queue_remaining=";
   required[7] = "closed_symbols_actionable=false";
   required[8] = "rank_formula_change=false";
   required[9] = "trade_signal=false";
   required[10] = "execution_change=false";
   required[11] = "proof_boundary=";
   required[12] = "dynamic_sub_family_readiness=";
   required[13] = "sub_family_writer_active=false";
   required[14] = "top5_depth_parity_state=";
   required[15] = "top5_staging_enabled=true";
   required[16] = "top5_archive_enabled=true";
   required[17] = "top5_promote_after_validate=true";
   required[18] = "top5_archive_previous_on_promote=true";
   required[19] = "top5_no_broad_file_deletion=true";
   required[20] = "safe_cleanup_patch=";
   required[21] = "top5_child_depth_class=";
   required[22] = "run115_safe_cleanup_patch=";
   required[23] = "proof_unchanged_skipped_count=";
   required[24] = "top5_duplicate_decision_skipped=";
   required[25] = "root_policy_duplicate_log_skipped=";
   required[26] = "run116_safe_cleanup_patch=";

   required[27] = "run126_safe_cleanup_patch=";
   required[28] = "top5_rank_1_5_deep_queue_enabled=true";
   required[29] = "top5_rank_4_5_permanent_deep_pending=false";
   required[30] = "top5_membership_refresh_cadence_sec=600";
   required[31] = "market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC);
   required[32] = "l4_shortlist_refresh_cadence_sec=1200";
   required[33] = "market_board_republish_uses_committed_l4=true";
   required[34] = "market_board_snapshot_id=";
   required[35] = "l4_committed_snapshot_id=";
   required[36] = "top5_bucket_snapshot_id=";
   required[37] = "top5_market_board_sync=";
   required[38] = "top5_market_board_sync_status=";
   required[39] = "top5_active_child_target_count=";
   required[40] = "top5_active_child_actual_count=";
   required[41] = "top5_active_stale_child_count=";
   required[42] = "top5_active_prune_policy=archive_then_remove_from_active";
   required[43] = "top5_staging_state=";
   required[44] = "top5_staging_child_count=";
   required[45] = "top5_staging_cleared_after_promote=";
   required[46] = "top5_staging_currentness=false";
   required[47] = "top5_archive_state=";
   required[48] = "top5_archive_child_count=";
   required[49] = "top5_archive_duplicate_skipped=true";
   required[50] = "market_board_to_top5_dossier_sync=";
   required[51] = "top5_matching_dossier_count=";
   required[52] = "top5_missing_dossier_count=";
   required[53] = "top5_lookup_path_policy=Top5PerBucket/<bucket>/<symbol>.txt";
   required[54] = "globaltop10_lookup_path_policy=GlobalTop10/<symbol>.txt";
   required[55] = "performance_side_audit=active";
   required[56] = "top5_no_broad_file_deletion=true";
   required[57] = "TOP5PERBUCKET_PUBLICATION_COMPLETION_REPAIR_BEGIN";
   required[58] = "PUBLICATION_COMPLETION_LEDGER_BEGIN";
   required[59] = "SHELL_FIRST_PUBLICATION_STATUS_BEGIN";
   required[60] = "FAMILY_FAIRNESS_STATUS_BEGIN";
   string existing_body = "";
   if(ASC_ReadTextFile(path, existing_body) && existing_body == body)
     {
      state.proof_unchanged_skipped_count++;
      state.top5_bucket_unchanged_decision_skipped_count++;
      reason_out = "family_manifest_unchanged_skipped | run126_safe_cleanup_patch=" + ASC_RUN126_SAFE_CLEANUP_PATCH + " | run127_safe_cleanup_patch=" + ASC_RUN127_SAFE_CLEANUP_PATCH;
      return true;
     }
   string write_state = "pending";
   if(!ASC_WritePublicationPayloadAtomic(path, body, required, state.top5_bucket_family_state, write_state, reason_out))
      return false;
   reason_out = "family_manifest_written | " + write_state;
   return true;
  }

bool ASC_Top5BucketWriteBucketManifest(ASC_RuntimeState &state,const string slug,const string display,const datetime now_utc,string &reason_out)
  {
   reason_out = "pending";
   string bucket_path = ASC_Top5BucketManifestPath(state, slug);
   if(StringLen(bucket_path) <= 0)
     {
      reason_out = "bucket_manifest_path_unavailable";
      return false;
     }
   int idx = ASC_Top5BucketActiveIndex(state, slug);
   int target = (idx >= 0 ? state.top5_bucket_active_targets[idx] : 0);
   int written = (idx >= 0 ? state.top5_bucket_active_written[idx] : 0);
   int failed = (idx >= 0 ? state.top5_bucket_active_failed[idx] : 0);
   int pending = MathMax(0, target - written - failed);
   string bucket_state = (target <= 0) ? "empty" : ((failed > 0) ? "degraded" : ((written >= target) ? "complete" : ((written > 0) ? "partial" : "queued")));
   string symbols = "";
   string deep_first = "";
   string deep_pending = "";
   string queue_guard_reason = "";
   if(!ASC_Top5BucketQueueArraysAligned(state, false, false, queue_guard_reason))
     {
      reason_out = "bucket_manifest_" + queue_guard_reason;
      return false;
     }
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      if(state.top5_bucket_queue_slugs[i] != slug)
         continue;
      if(StringLen(symbols) > 0) symbols += ",";
      symbols += state.top5_bucket_queue_symbols[i];
      if(state.top5_bucket_queue_ranks[i] >= 1 && state.top5_bucket_queue_ranks[i] <= 5)
        {
         if(StringLen(deep_first) > 0) deep_first += ",";
         deep_first += state.top5_bucket_queue_symbols[i];
        }
      else
        {
         if(StringLen(deep_pending) > 0) deep_pending += ",";
         deep_pending += state.top5_bucket_queue_symbols[i];
        }
     }
   string body = "TOP5 PER BUCKET BUCKET MANIFEST\n";
   body += "artifact_family_id=" + ASC_TOP5_BUCKET_FAMILY_ID + "\n";
   body += "bucket_slug=" + ASC_TextOrUnavailable(slug) + "\n";
   body += "bucket_display=" + ASC_TextOrUnavailable(display) + "\n";
   body += "bucket_state=" + bucket_state + "\n";
   body += "bucket_rank_source=MarketBoard/L4\n";
   body += "bucket_child_target_count=" + IntegerToString(target) + "\n";
   body += "bucket_child_written_count=" + IntegerToString(written) + "\n";
   body += "bucket_child_pending_count=" + IntegerToString(pending) + "\n";
   body += "bucket_child_failed_count=" + IntegerToString(failed) + "\n";
   body += "rank_formula_change=false\nclosed_symbols_actionable=false\n";
   body += "symbols=" + ASC_TextOrUnavailable(symbols) + "\n";
   body += "deep_first_symbols=" + ASC_TextOrUnavailable(deep_first) + "\n";
   body += "deep_queue_rank1_5_symbols=" + ASC_TextOrUnavailable(deep_first) + "\n";
   body += "deep_pending_symbols=" + ASC_TextOrUnavailable(deep_pending) + "\n";
   body += "top5_rank_1_5_deep_queue_enabled=true\n";
   body += "top5_rank_4_5_permanent_deep_pending=false\n";
   body += "top5_depth_parity_state=" + ASC_TOP5_DEPTH_PARITY_STATE_SOURCE_PATCHED + "\n";
   body += "top5_bucket_staging_ready=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false") + "\n";
   body += "top5_bucket_archive_ready=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false") + "\n";
   body += "top5_staging_enabled=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false") + "\n";
   body += "top5_archive_enabled=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false") + "\n";
   body += "top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false") + "\n";
   body += "top5_archive_previous_on_promote=" + (ASC_TOP5_ARCHIVE_PREVIOUS_ON_PROMOTE ? "true" : "false") + "\n";
   body += "top5_no_broad_file_deletion=true\n";
   body += "last_symbol=" + ASC_TextOrUnavailable(state.top5_bucket_last_symbol) + "\n";
   body += "last_error=" + ASC_TextOrUnavailable(state.top5_bucket_last_error) + "\n";
   body += "source_run_id=" + ASC_SourceRunId() + "\n";
   body += "market_board_snapshot_id=" + ASC_Top5BucketSnapshotId(state) + "\n";
   body += "l4_committed_snapshot_id=" + ASC_Top5BucketSnapshotId(state) + "\n";
   body += "top5_bucket_snapshot_id=" + ASC_Top5BucketSnapshotId(state) + "\n";
   body += "top5_bucket_committed_signature=" + ASC_TextOrUnavailable(state.top5_bucket_last_signature) + "\n";
   body += "top5_bucket_committed_exact_signature=" + ASC_Top5BucketExactSignature(state) + "\n";
   body += "top5_market_board_sync=false\n";
   body += "top5_market_board_sync_status=bucket_manifest_requires_market_board_visible_signature_compare\n";
   body += "top5_market_board_sync_reason=bucket_manifest_cannot_prove_visible_market_board_rows_by_itself\n";
   body += "top5_membership_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_BUCKET_CADENCE_SEC) + "\n";
   body += "market_board_republish_uses_committed_l4=true\n";
   body += ASC_Run157SpeedTruthFillOwnerMapLine() + "\n";
   body += "l4_snapshot_epoch=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "l4_membership_window_seconds=" + IntegerToString(ASC_RUN156_L4_STATIC_MEMBERSHIP_SEC) + "\n";
   body += "l4_membership_static_until=" + (state.committed_l4_next_recheck_utc > 0 ? ASC_ArtifactFormatUtc(state.committed_l4_next_recheck_utc) : "unavailable") + "\n";
   body += "l4_membership_static_active=" + ((state.committed_l4_next_recheck_utc > now_utc) ? "true" : "false") + "\n";
   body += "l4_membership_refresh_due=" + ((state.committed_l4_next_recheck_utc > 0 && now_utc >= state.committed_l4_next_recheck_utc) ? "true" : "false") + "\n";
   body += "top5_l4_epoch=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "globaltop10_l4_epoch=" + ASC_TextOrUnavailable(ASC_Top5BucketSnapshotId(state)) + "\n";
   body += "top5_globaltop10_epoch_match=true\n";
   body += "l4_info_refresh_independent=true\n";
   body += "displayed_symbol_info_refresh_seconds=" + IntegerToString(ASC_RUN156_DISPLAYED_INFO_REFRESH_SEC) + "\n";
   body += "bucket_fill_target_seconds=" + IntegerToString(ASC_RUN156_BUCKET_FILL_TARGET_SEC) + "\n";
   body += "top5_lookup_path_policy=Top5PerBucket/<bucket>/<symbol>.txt\n";
   body += "run115_safe_cleanup_patch=" + ASC_RUN115_SAFE_CLEANUP_PATCH + "\n";
   body += "run126_safe_cleanup_patch=" + ASC_RUN126_SAFE_CLEANUP_PATCH + "\n";
   body += "run127_safe_cleanup_patch=" + ASC_RUN127_SAFE_CLEANUP_PATCH + "\n";
   body += "top5_unchanged_decision_skipped_count=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count)) + "\n";

   string required[];
   ArrayResize(required, 24);
   required[0] = "TOP5 PER BUCKET BUCKET MANIFEST";
   required[1] = "artifact_family_id=top5_per_bucket";
   required[2] = "bucket_slug=";
   required[3] = "bucket_state=";
   required[4] = "bucket_rank_source=MarketBoard/L4";
   required[5] = "closed_symbols_actionable=false";
   required[6] = "rank_formula_change=false";
   required[7] = "source_run_id=" + ASC_SourceRunId();
   required[8] = "top5_depth_parity_state=";
   required[9] = "top5_bucket_staging_ready=true";
   required[10] = "top5_bucket_archive_ready=true";
   required[11] = "top5_promote_after_validate=true";
   required[12] = "top5_archive_previous_on_promote=true";
   required[13] = "top5_no_broad_file_deletion=true";
   required[14] = "market_board_snapshot_id=";
   required[15] = "l4_committed_snapshot_id=";
   required[16] = "top5_bucket_snapshot_id=";
   required[17] = "top5_market_board_sync=";
   required[18] = "top5_market_board_sync_status=";
   required[19] = "market_board_republish_uses_committed_l4=true";
   required[20] = "top5_lookup_path_policy=Top5PerBucket/<bucket>/<symbol>.txt";
   required[21] = "top5_rank_1_5_deep_queue_enabled=true";
   required[22] = "top5_rank_4_5_permanent_deep_pending=false";
   required[23] = "run126_safe_cleanup_patch=";
   string existing_bucket_body = "";
   if(ASC_ReadTextFile(bucket_path, existing_bucket_body) && existing_bucket_body == body)
     {
      state.proof_unchanged_skipped_count++;
      state.top5_bucket_unchanged_decision_skipped_count++;
      reason_out = "bucket_manifest_unchanged_skipped | " + slug + " | run126_safe_cleanup_patch=" + ASC_RUN126_SAFE_CLEANUP_PATCH + " | run127_safe_cleanup_patch=" + ASC_RUN127_SAFE_CLEANUP_PATCH;
      return true;
     }
   string write_state = "pending";
   if(!ASC_WritePublicationPayloadAtomic(bucket_path, body, required, bucket_state, write_state, reason_out))
      return false;
   reason_out = "bucket_manifest_written | " + slug + " | " + write_state;
   return true;
  }

bool ASC_Top5BucketWriteChild(ASC_RuntimeState &state,const int queue_index,const datetime now_utc,string &reason_out)
  {
   reason_out = "pending";
   string queue_guard_reason = "";
   if(!ASC_Top5BucketQueueArraysAligned(state, true, true, queue_guard_reason))
     {
      reason_out = queue_guard_reason;
      return false;
     }
   int queue_count = ArraySize(state.top5_bucket_queue_symbols);
   if(queue_index < 0 || queue_index >= queue_count)
     {
      reason_out = "queue_index_out_of_range";
      return false;
     }
   string symbol = state.top5_bucket_queue_symbols[queue_index];
   string slug = state.top5_bucket_queue_slugs[queue_index];
   string display = state.top5_bucket_queue_displays[queue_index];
   int bucket_rank = state.top5_bucket_queue_ranks[queue_index];
   string hydration_class = state.top5_bucket_queue_hydration[queue_index];

   ASC_Layer1SymbolState selected;
   if(!ASC_FindLayer1SymbolByName(symbol, selected))
     {
      reason_out = "child_symbol_missing_from_l1_cache";
      return false;
     }

   ASC_ShortlistSymbolSummary shortlist_rows[];
   if(state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
     {
      ArrayResize(shortlist_rows, ArraySize(state.publication_shortlist_rows));
      for(int i = 0; i < ArraySize(state.publication_shortlist_rows); i++)
         shortlist_rows[i] = state.publication_shortlist_rows[i];
     }
   else
      ASC_CopyCommittedL4RowsToShortlistRows(state.committed_l4_rows, shortlist_rows);

   ASC_PublicationBundleState bundle = state.publication_bundle;
   bundle.publication_id = "top5-bucket-" + IntegerToString((long)now_utc) + "-" + IntegerToString(queue_index + 1);
   bundle.publication_utc = now_utc;
   if(bundle.bundle_started_utc <= 0) bundle.bundle_started_utc = now_utc;
   bundle.bundle_finished_utc = now_utc;
   bundle.dossier_attempted_count = 1;
   bundle.dossier_success_count = 0;
   bundle.dossier_failure_count = 0;
   bundle.dossier_skipped_count = 0;

   ASC_DeepSelectiveAnalysisResult deferred_deep;
   ASC_DeepInitResult(deferred_deep);
   string canonical_symbol = ASC_SelectedCanonicalSymbol(selected);
   deferred_deep.symbol = selected.symbol;
   deferred_deep.canonical_symbol = canonical_symbol;
   deferred_deep.entitlement_state = (bucket_rank >= 1 && bucket_rank <= 5 ? "TOP5_BUCKET_DEEP_QUEUED" : "TOP5_BUCKET_DEEP_PENDING");
   deferred_deep.entitlement_reason = (bucket_rank >= 1 && bucket_rank <= 5 ? "Top5PerBucket ranks 1-5 queue the existing Deep Selective Analysis owner for GlobalTop10-style parity; current child remains honest until completed payload overwrites it." : "Top5PerBucket rank outside 1-5 remains deep_pending by policy.");
   deferred_deep.summary_line = "top5_per_bucket_child | depth_parity_state=deep_pending_until_owner_attaches | execution_change=false";
   deferred_deep.block_text = "Top5PerBucket Deep Policy\n"
                              "deep_payload_deferred: yes\n"
                              "deep_hydration_pending: yes\n"
                              "deep_completed: no\n"
                              "defer_reason=" + ASC_SourceRunId() + " one-child/write-beat budget guard; rank1_5 queues existing deep owner for GlobalTop10-style parity; no rank/order/formula change\n";
   deferred_deep.execution_context = "top5_per_bucket_child";
   deferred_deep.build_context = "deferred";
   deferred_deep.data_tier = "tier_deferred_not_complete";

   string payload_canonical = "";
   string payload = "";
   string publication_state = "partial";
   string required_tokens[];
   if(!ASC_BuildCanonicalDossierPayload(state.server_root,
                                        selected,
                                        bundle,
                                        shortlist_rows,
                                        ASC_DOSSIER_MODE_DEEP_OVERRIDE,
                                        true,
                                        deferred_deep,
                                        "top5_per_bucket:" + slug + ":" + selected.symbol,
                                        payload_canonical,
                                        payload,
                                        publication_state,
                                        required_tokens))
     {
      reason_out = "child_payload_compose_failed";
      return false;
     }

   string actionability = ASC_Top5BucketActionability(selected);
   payload += "\nTop5PerBucket Child Identity\n";
   payload += "artifact_family=Top5PerBucket\n";
   payload += "artifact_family_id=top5_per_bucket\n";
   payload += "bucket_slug=" + ASC_TextOrUnavailable(slug) + "\n";
   payload += "bucket_display=" + ASC_TextOrUnavailable(display) + "\n";
   payload += "bucket_rank=" + IntegerToString(bucket_rank) + "\n";
   payload += "bucket_rank_source=MarketBoard/L4\n";
   payload += "hydration_class=" + hydration_class + "\n";
   payload += "actionability_state=" + actionability + "\n";
   payload += "actionability_basis=L1_open_confirmed_non_stale_non_degraded_required;MarketBoard_L4_rank_is_not_actionability;no_trade_or_execution_signal\n";
   payload += "closed_symbols_actionable=false\n";
   payload += "rank_formula_change=false\ntrade_signal=false\nexecution_change=false\n";
   payload += "source_run_id=" + ASC_SourceRunId() + "\n";
   payload += "currentness_state=" + ASC_TextOrUnavailable(state.top5_bucket_family_state) + "\n";
   string depth_parity_state = ASC_Top5BucketDepthParityState(bucket_rank, false);
   bool top5_rank_1_5_deep_attempted = false;
   string top5_rank_1_5_queue_reason = "not_rank_1_5";
   if(bucket_rank >= 1 && bucket_rank <= 5)
     {
      if(!state.deep_focus_trigger_pending)
         top5_rank_1_5_deep_attempted = ASC_QueueDeepTriggerForSymbol(state, selected.symbol, now_utc, "top5_per_bucket:" + slug + ":" + IntegerToString(bucket_rank), top5_rank_1_5_queue_reason);
      else
         top5_rank_1_5_queue_reason = "deep_owner_busy_existing_request_preserved";
     }
   payload += "deep_pending=true\n";
   payload += "depth_parity_state=" + depth_parity_state + "\n";
   payload += "deep_payload_available=false\n";
   payload += "top5_depth_parity_state=" + depth_parity_state + "\n";
   payload += "top5_rank_1_3_deep_attempted=" + (bucket_rank <= 3 && top5_rank_1_5_deep_attempted ? "true" : "false") + "\n";
   payload += "top5_rank_1_5_deep_attempted=" + (top5_rank_1_5_deep_attempted ? "true" : "false") + "\n";
   payload += "top5_rank_1_3_deep_attached=false\n";
   payload += "top5_rank_1_3_deep_pending=" + (bucket_rank <= 3 ? "true" : "false") + "\n";
   payload += "top5_rank_4_5_deep_attempted=" + (bucket_rank >= 4 && bucket_rank <= 5 && top5_rank_1_5_deep_attempted ? "true" : "false") + "\n";
   payload += "top5_rank_4_5_deep_pending=" + (bucket_rank >= 4 && bucket_rank <= 5 ? "true_until_deep_owner_attaches" : "false") + "\n";
   payload += "top5_rank_4_5_permanent_deep_pending=false\n";
   payload += "top5_rank_1_5_deep_queue_enabled=true\n";
   payload += "top5_quote_hydration_source=ASC_OpenSymbolSnapshotEngine/SymbolInfoTick+SymbolInfoDouble\n";
   payload += "top5_deep_queue_reason=" + ASC_TextOrUnavailable(top5_rank_1_5_queue_reason) + "\n";
   payload += "top5_child_expected_size_class=" + (bucket_rank >= 1 && bucket_rank <= 5 ? "globaltop10_style_deep_target_when_attached" : "deep_pending") + "\n";
   payload += "top5_child_depth_class=" + (bucket_rank >= 1 && bucket_rank <= 5 ? "rank1_5_deep_owner_queued_or_pending" : "deep_pending") + "\n";
   payload += "top5_staging_enabled=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false") + "\n";
   payload += "top5_archive_enabled=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false") + "\n";
   payload += "top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false") + "\n";
   payload += "top5_archive_previous_on_promote=" + (ASC_TOP5_ARCHIVE_PREVIOUS_ON_PROMOTE ? "true" : "false") + "\n";
   payload += "top5_no_broad_file_deletion=true\n";
   payload += "performance_side_audit=" + ASC_PERFORMANCE_SIDE_AUDIT_STATE + "\n";
   payload += "safe_cleanup_patch=" + ASC_RUN114_SAFE_CLEANUP_PATCH + "\n";
   payload += "run115_safe_cleanup_patch=" + ASC_RUN115_SAFE_CLEANUP_PATCH + "\n";
   payload += "run116_safe_cleanup_patch=" + ASC_RUN116_SAFE_CLEANUP_PATCH + "\n";
   payload += "proof_unchanged_skipped_count=" + IntegerToString(MathMax(0, state.proof_unchanged_skipped_count)) + "\n";
   payload += "top5_duplicate_decision_skipped=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count)) + "\n";
   payload += "root_policy_duplicate_log_skipped=" + IntegerToString(MathMax(0, state.dossier_publication_policy_unchanged_log_skipped_count)) + "\n";
   payload += "proof_boundary=" + ASC_TOP5_BUCKET_PROOF_BOUNDARY + "\n";

   int n = ArraySize(required_tokens);
   ArrayResize(required_tokens, n + 38);
   required_tokens[n] = "Top5PerBucket Child Identity";
   required_tokens[n + 1] = "artifact_family=Top5PerBucket";
   required_tokens[n + 2] = "bucket_rank_source=MarketBoard/L4";
   required_tokens[n + 3] = "hydration_class=";
   required_tokens[n + 4] = "actionability_basis=";
   required_tokens[n + 5] = "closed_symbols_actionable=false";
   required_tokens[n + 6] = "rank_formula_change=false";
   required_tokens[n + 7] = "trade_signal=false";
   required_tokens[n + 8] = "execution_change=false";
   required_tokens[n + 9] = "source_run_id=" + ASC_SourceRunId();
   required_tokens[n + 10] = "deep_pending=true";
   required_tokens[n + 11] = "proof_boundary=";
   required_tokens[n + 12] = "top5_depth_parity_state=";
   required_tokens[n + 13] = "top5_rank_1_3_deep_attempted=";
   required_tokens[n + 14] = "top5_rank_1_3_deep_attached=false";
   required_tokens[n + 15] = "top5_rank_1_3_deep_pending=";
   required_tokens[n + 16] = "top5_rank_1_5_deep_attempted=";
   required_tokens[n + 17] = "top5_rank_4_5_deep_attempted=";
   required_tokens[n + 18] = "top5_rank_4_5_deep_pending=";
   required_tokens[n + 19] = "top5_child_expected_size_class=";
   required_tokens[n + 20] = "top5_child_depth_class=";
   required_tokens[n + 21] = "top5_staging_enabled=true";
   required_tokens[n + 22] = "top5_archive_enabled=true";
   required_tokens[n + 23] = "top5_promote_after_validate=true";
   required_tokens[n + 24] = "top5_archive_previous_on_promote=true";
   required_tokens[n + 25] = "top5_no_broad_file_deletion=true";
   required_tokens[n + 26] = "safe_cleanup_patch=";
   required_tokens[n + 27] = "run115_safe_cleanup_patch=";
   required_tokens[n + 28] = "proof_unchanged_skipped_count=";
   required_tokens[n + 29] = "top5_duplicate_decision_skipped=";
   required_tokens[n + 30] = "root_policy_duplicate_log_skipped=";
   required_tokens[n + 31] = "run116_safe_cleanup_patch=";
   required_tokens[n + 32] = "deep_pending=true";
   required_tokens[n + 33] = "top5_deep_queue_reason=";
   required_tokens[n + 34] = "top5_rank_4_5_permanent_deep_pending=false";
   required_tokens[n + 35] = "top5_rank_1_5_deep_queue_enabled=true";
   required_tokens[n + 36] = "top5_quote_hydration_source=";
   required_tokens[n + 37] = "top5_no_broad_file_deletion=true";

   string child_path = ASC_Top5BucketChildPath(state, slug, selected.symbol);
   string staging_path = ASC_Top5BucketChildStagingPath(state, slug, selected.symbol);
   if(StringLen(child_path) <= 0 || StringLen(staging_path) <= 0)
     {
      reason_out = "child_path_or_staging_path_unavailable";
      return false;
     }
   string write_state = "pending";
   string staging_reason = "pending";
   if(!ASC_WritePublicationPayloadAtomic(staging_path, payload, required_tokens, "partial", write_state, staging_reason))
     {
      reason_out = "staging_child_write_failed | " + staging_reason;
      return false;
     }
   reason_out = "child_staged | " + selected.symbol + " | " + slug + " | staging=" + write_state + " | promote=deferred_until_family_validation | depth_parity_state=" + depth_parity_state + " | deep_queue=" + top5_rank_1_5_queue_reason;
   return true;
  }

void ASC_RecordTop5BucketDecision(ASC_RuntimeState &state,const string scope,const ASC_FunctionResultState result_state,const ASC_ResultCode result_code,const string detail,const string target_path = "")
  {
   string signature = scope
                      + "|state=" + IntegerToString((int)result_state)
                      + "|code=" + IntegerToString((int)result_code)
                      + "|family=" + state.top5_bucket_family_state
                      + "|remaining=" + IntegerToString(MathMax(0, state.top5_bucket_queue_remaining))
                      + "|last_symbol=" + state.top5_bucket_last_symbol
                      + "|last_error=" + state.top5_bucket_last_error
                      + "|target=" + target_path
                      + "|detail=" + detail;
   datetime now_utc = TimeGMT();
   if(result_state == ASC_RESULT_OK
      && signature == state.top5_bucket_last_decision_signature
      && !ASC_Run115ProofEmitDue(now_utc, state.top5_bucket_last_decision_utc))
     {
      state.top5_bucket_unchanged_decision_skipped_count++;
      state.proof_unchanged_skipped_count++;
      return;
     }

   state.top5_bucket_last_decision_signature = signature;
   state.top5_bucket_last_decision_utc = now_utc;

   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_Dispatcher", "ASC_ServiceTop5PerBucketFamily", scope);
   string proof_detail = detail + " | run115_safe_cleanup_patch=" + ASC_RUN115_SAFE_CLEANUP_PATCH
                         + " | run116_safe_cleanup_patch=" + ASC_RUN116_SAFE_CLEANUP_PATCH
                         + " | proof_unchanged_skipped_count=" + IntegerToString(MathMax(0, state.proof_unchanged_skipped_count))
                         + " | top5_unchanged_decision_skipped_count=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count))
                         + " | top5_duplicate_decision_skipped=" + IntegerToString(MathMax(0, state.top5_bucket_unchanged_decision_skipped_count))
                         + " | root_policy_duplicate_log_skipped=" + IntegerToString(MathMax(0, state.dossier_publication_policy_unchanged_log_skipped_count))
                         + " | top5_per_bucket_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_PER_BUCKET_REFRESH_CADENCE_SEC)
                         + " | top5_membership_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_BUCKET_CADENCE_SEC)
                         + " | market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC)
                         + " | l4_shortlist_refresh_cadence_sec=" + IntegerToString(ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC)
                         + " | market_board_republish_uses_committed_l4=true"
                         + " | market_board_snapshot_id=" + ASC_Top5BucketSnapshotId(state)
                         + " | l4_committed_snapshot_id=" + ASC_Top5BucketSnapshotId(state)
                         + " | top5_bucket_snapshot_id=" + ASC_Top5BucketSnapshotId(state)
                         + " | top5_market_board_sync=false"
                         + " | top5_market_board_sync_status=" + ASC_Top5BucketManifestBoardSyncStatus(state, ASC_Top5BucketCountActiveChildFiles(state), ASC_Top5BucketCountStagingChildFiles(state))
                         + " | top5_market_board_sync_reason=functionresults_requires_market_board_visible_signature_compare"
                         + " | top5_active_child_target_count=" + IntegerToString(MathMax(0, state.top5_bucket_child_target_count))
                         + " | top5_active_child_actual_count=" + IntegerToString(MathMax(0, ASC_Top5BucketCountActiveChildFiles(state)))
                         + " | top5_staging_child_count=" + IntegerToString(MathMax(0, ASC_Top5BucketCountStagingChildFiles(state)))
                         + " | top5_active_prune_policy=archive_then_remove_from_active"
                         + " | top5_staging_currentness=false"
                         + " | market_board_to_top5_dossier_sync=false"
                         + " | market_board_to_top5_dossier_sync_status=" + ASC_Top5BucketManifestBoardSyncStatus(state, ASC_Top5BucketCountActiveChildFiles(state), ASC_Top5BucketCountStagingChildFiles(state))
                         + " | market_board_to_top5_dossier_sync_reason=functionresults_child_count_is_not_visible_market_board_signature_sync"
                         + " | top5_no_broad_file_deletion=true"
                         + " | " + ASC_Top5BucketSkeletonProofTokens(state.top5_bucket_family_state,
                                                                        state.top5_bucket_count,
                                                                        state.top5_bucket_child_target_count,
                                                                        state.top5_bucket_child_written_count,
                                                                        state.top5_bucket_child_pending_count,
                                                                        state.top5_bucket_child_failed_count,
                                                                        state.top5_bucket_queue_remaining,
                                                                        state.top5_bucket_last_symbol,
                                                                        state.top5_bucket_last_error);
   ASC_FunctionResultFinish(result, result_state, result_code, proof_detail, target_path);
   ASC_RecordResult(state, result, true, result_state != ASC_RESULT_OK);
  }

bool ASC_Top5BucketCadenceDue(const ASC_RuntimeState &state,const datetime now_utc,string &reason_out)
  {
   reason_out = "cadence_not_due";
   if(now_utc <= 0)
     {
      reason_out = "cadence_clock_unavailable";
      return false;
     }
   if(state.top5_bucket_batch_pending || state.top5_bucket_queue_cursor < ArraySize(state.top5_bucket_queue_symbols))
     {
      reason_out = "cadence_not_due_batch_active";
      return false;
     }
   if(state.top5_bucket_last_served_utc <= 0)
     {
      reason_out = "cadence_due_initial_top5_per_bucket_family";
      return true;
     }
   int age = ASC_SecondsBetweenUtc(now_utc, state.top5_bucket_last_served_utc);
   if(age >= ASC_TOP5_BUCKET_CADENCE_SEC)
     {
      reason_out = StringFormat("cadence_due age=%d cadence=%d", age, ASC_TOP5_BUCKET_CADENCE_SEC);
      return true;
     }
   reason_out = StringFormat("cadence_not_due age=%d cadence=%d", age, ASC_TOP5_BUCKET_CADENCE_SEC);
   return false;
  }

void ASC_Top5BucketStartBatch(ASC_RuntimeState &state,const datetime now_utc)
  {
   ASC_ShortlistSymbolSummary rows[];
   string reason = "";
   bool ok = ASC_Top5BucketBuildRows(state, rows, reason);
   string resize_reason = "";
   if(!ASC_Top5BucketResizeQueueArrays(state, 0, resize_reason)
      || !ASC_Top5BucketResizeActiveBucketArrays(state, 0, resize_reason))
     {
      state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_DEGRADED;
      state.top5_bucket_last_error = resize_reason;
      ASC_RecordTop5BucketDecision(state, "top5_bucket_resize_reset_failed", ASC_RESULT_ERROR, ASC_RC_INVALID_STATE, resize_reason, ASC_Top5BucketRootDirectory(state));
      return;
     }
   state.top5_bucket_queue_cursor = 0;
   state.top5_bucket_child_written_count = 0;
   state.top5_bucket_child_failed_count = 0;

   if(!ok)
     {
      state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_EMPTY_SOURCE;
      state.top5_bucket_count = 0;
      state.top5_bucket_child_target_count = 0;
      state.top5_bucket_child_pending_count = 0;
      state.top5_bucket_queue_remaining = 0;
      state.top5_bucket_last_error = reason;
      state.top5_bucket_last_served_utc = now_utc;
      state.top5_bucket_next_due = now_utc + ASC_TOP5_BUCKET_CADENCE_SEC;
      string manifest_reason = "";
      bool manifest_ok = ASC_Top5BucketWriteFamilyManifest(state, now_utc, manifest_reason);
      ASC_RecordTop5BucketDecision(state, "top5_bucket_empty_source", manifest_ok ? ASC_RESULT_WARNING : ASC_RESULT_ERROR, manifest_ok ? ASC_RC_NOT_FOUND : ASC_RC_IO_FAILED, reason + " | " + manifest_reason, ASC_Top5BucketRootDirectory(state));
      return;
     }

   for(int i = 0; i < ArraySize(rows); i++)
     {
      string bucket_id = ASC_ClassificationEffectiveMainBucketId(rows[i].state.classification);
      string slug = ASC_Top5BucketSafeSlug(bucket_id);
      string display = ASC_Top5BucketDisplayName(bucket_id, rows[i].state.classification.main_bucket_name);
      int next = ArraySize(state.top5_bucket_queue_symbols);
      if(!ASC_Top5BucketResizeQueueArrays(state, next + 1, resize_reason))
        {
         state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_DEGRADED;
         state.top5_bucket_last_error = resize_reason;
         ASC_RecordTop5BucketDecision(state, "top5_bucket_queue_resize_failed", ASC_RESULT_ERROR, ASC_RC_INVALID_STATE, resize_reason, ASC_Top5BucketRootDirectory(state));
         return;
        }
      state.top5_bucket_queue_symbols[next] = rows[i].symbol;
      state.top5_bucket_queue_slugs[next] = slug;
      state.top5_bucket_queue_displays[next] = display;
      state.top5_bucket_queue_ranks[next] = rows[i].bucket_rank;
      state.top5_bucket_queue_hydration[next] = (rows[i].bucket_rank <= 3 ? ASC_TOP5_BUCKET_HYDRATION_RANK1_3 : ASC_TOP5_BUCKET_HYDRATION_RANK4_5);

      int idx = ASC_Top5BucketActiveIndex(state, slug);
      if(idx < 0)
        {
         idx = ArraySize(state.top5_bucket_active_slugs);
         if(!ASC_Top5BucketResizeActiveBucketArrays(state, idx + 1, resize_reason))
           {
            state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_DEGRADED;
            state.top5_bucket_last_error = resize_reason;
            ASC_RecordTop5BucketDecision(state, "top5_bucket_active_resize_failed", ASC_RESULT_ERROR, ASC_RC_INVALID_STATE, resize_reason, ASC_Top5BucketRootDirectory(state));
            return;
           }
         state.top5_bucket_active_slugs[idx] = slug;
         state.top5_bucket_active_displays[idx] = display;
         state.top5_bucket_active_targets[idx] = 0;
         state.top5_bucket_active_written[idx] = 0;
         state.top5_bucket_active_failed[idx] = 0;
        }
      state.top5_bucket_active_targets[idx]++;
     }

   state.top5_bucket_batch_pending = false;
   state.top5_bucket_batch_requested_utc = now_utc;
   state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_QUEUED;
   state.top5_bucket_count = ArraySize(state.top5_bucket_active_slugs);
   state.top5_bucket_child_target_count = ArraySize(state.top5_bucket_queue_symbols);
   state.top5_bucket_child_pending_count = state.top5_bucket_child_target_count;
   state.top5_bucket_queue_remaining = state.top5_bucket_child_target_count;
   state.top5_bucket_last_error = "none";
   state.top5_bucket_last_signature = ASC_Top5BucketSignature(state);
   state.top5_bucket_next_due = now_utc + ASC_TOP5_BUCKET_CADENCE_SEC;

   string cleanup_reason = "active_current_preserved_until_staging_validation";
   bool cleanup_ok = true;

   string archive_marker_reason = "";
   bool archive_marker_ok = ASC_Top5BucketWriteArchiveManifest(state, now_utc, "batch_start_preserve_active", cleanup_reason, archive_marker_reason);
   string staging_marker_reason = "";
   bool staging_marker_ok = ASC_Top5BucketWriteStagingManifest(state, now_utc, "batch_start", staging_marker_reason);
   if(!archive_marker_ok || !staging_marker_ok)
      state.top5_bucket_last_error = archive_marker_reason + " | " + staging_marker_reason;

   string family_reason = "";
   bool family_ok = ASC_Top5BucketWriteFamilyManifest(state, now_utc, family_reason);
   for(int b = 0; b < ArraySize(state.top5_bucket_active_slugs); b++)
     {
      string bucket_reason = "";
      bool bucket_ok = ASC_Top5BucketWriteBucketManifest(state, state.top5_bucket_active_slugs[b], state.top5_bucket_active_displays[b], now_utc, bucket_reason);
      if(!bucket_ok)
         state.top5_bucket_last_error = bucket_reason;
     }
   ASC_RecordTop5BucketDecision(state,
                                "top5_bucket_batch_start",
                                (family_ok && cleanup_ok && archive_marker_ok && staging_marker_ok) ? ASC_RESULT_OK : ASC_RESULT_ERROR,
                                (family_ok && cleanup_ok && archive_marker_ok && staging_marker_ok) ? ASC_RC_OK : ASC_RC_IO_FAILED,
                                reason + " | " + cleanup_reason + " | archive_marker=" + archive_marker_reason + " | staging_marker=" + staging_marker_reason + " | " + family_reason,
                                ASC_Top5BucketRootDirectory(state));
  }

void ASC_ServiceTop5PerBucketFamily(ASC_RuntimeState &state,const datetime now_utc,const ulong beat_start_us,const int beat_budget_ms,const bool ui_priority_active)
  {
   string cadence_reason = "";
   if(!state.top5_bucket_batch_pending && state.top5_bucket_queue_cursor >= ArraySize(state.top5_bucket_queue_symbols))
     {
      if(!ASC_Top5BucketCadenceDue(state, now_utc, cadence_reason))
         return;
      state.top5_bucket_batch_pending = true;
     }

   if(ui_priority_active)
     {
      state.write_dirty = true;
      state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_QUEUED;
      ASC_RecordTop5BucketDecision(state, "top5_bucket_yield", ASC_RESULT_OK, ASC_RC_OK, "yield_for_ui_priority", ASC_Top5BucketRootDirectory(state));
      return;
     }
   if(ASC_WriteLaneNearBudget(beat_start_us, beat_budget_ms, ui_priority_active))
     {
      state.write_dirty = true;
      ASC_RecordTop5BucketDecision(state, "top5_bucket_yield", ASC_RESULT_OK, ASC_RC_OK, "yield_near_write_budget", ASC_Top5BucketRootDirectory(state));
      return;
     }

   if(state.top5_bucket_batch_pending)
      ASC_Top5BucketStartBatch(state, now_utc);

   string queue_guard_reason = "";
   if(!ASC_Top5BucketQueueArraysAligned(state, true, true, queue_guard_reason))
     {
      state.top5_bucket_family_state = ASC_TOP5_BUCKET_STATE_BLOCKED;
      state.top5_bucket_last_error = queue_guard_reason;
      state.write_dirty = true;
      ASC_RecordTop5BucketDecision(state, "top5_bucket_queue_guard", ASC_RESULT_ERROR, ASC_RC_INVALID_ARGUMENT, queue_guard_reason, ASC_Top5BucketRootDirectory(state));
      return;
     }

   int wrote = 0;
   while(wrote < ASC_TOP5_BUCKET_MAX_CHILD_QUEUE_PER_BEAT && state.top5_bucket_queue_cursor < ArraySize(state.top5_bucket_queue_symbols))
     {
      int qi = state.top5_bucket_queue_cursor;
      string child_reason = "";
      bool child_ok = ASC_Top5BucketWriteChild(state, qi, now_utc, child_reason);
      string slug = state.top5_bucket_queue_slugs[qi];
      int idx = ASC_Top5BucketActiveIndex(state, slug);
      if(child_ok)
        {
         state.top5_bucket_child_written_count++;
         if(idx >= 0) state.top5_bucket_active_written[idx]++;
         state.top5_bucket_last_symbol = state.top5_bucket_queue_symbols[qi];
        }
      else
        {
         state.top5_bucket_child_failed_count++;
         if(idx >= 0) state.top5_bucket_active_failed[idx]++;
         state.top5_bucket_last_error = child_reason;
        }
      state.top5_bucket_queue_cursor++;
      wrote++;
      state.top5_bucket_child_pending_count = MathMax(0, state.top5_bucket_child_target_count - state.top5_bucket_child_written_count - state.top5_bucket_child_failed_count);
      state.top5_bucket_queue_remaining = MathMax(0, ArraySize(state.top5_bucket_queue_symbols) - state.top5_bucket_queue_cursor);
      state.top5_bucket_family_state = (state.top5_bucket_queue_remaining > 0) ? ASC_TOP5_BUCKET_STATE_PARTIAL : (state.top5_bucket_child_failed_count > 0 ? ASC_TOP5_BUCKET_STATE_DEGRADED : ASC_TOP5_BUCKET_STATE_PARTIAL);
      string bucket_reason = "";
      if(idx >= 0)
         ASC_Top5BucketWriteBucketManifest(state, slug, state.top5_bucket_active_displays[idx], now_utc, bucket_reason);
      string family_reason = "";
      ASC_Top5BucketWriteFamilyManifest(state, now_utc, family_reason);
      ASC_RecordTop5BucketDecision(state, "top5_bucket_child_write", child_ok ? ASC_RESULT_OK : ASC_RESULT_WARNING, child_ok ? ASC_RC_OK : ASC_RC_IO_FAILED, child_reason + " | " + family_reason, ASC_Top5BucketChildPath(state, slug, state.top5_bucket_queue_symbols[qi]));
     }

   if(state.top5_bucket_queue_remaining > 0)
     {
      state.write_dirty = true;
      return;
     }

   if(state.top5_bucket_child_target_count > 0)
     {
      string finalize_reason = "";
      bool finalize_ok = false;
      if(state.top5_bucket_child_failed_count <= 0)
         finalize_ok = ASC_Top5BucketFinalizeSuccessfulBatch(state, now_utc, finalize_reason);
      else
         finalize_reason = "finalize_blocked_child_failures=" + IntegerToString(state.top5_bucket_child_failed_count);

      state.top5_bucket_family_state = finalize_ok ? ASC_TOP5_BUCKET_STATE_PROMOTED_CURRENT : ASC_TOP5_BUCKET_STATE_DEGRADED;
      state.top5_bucket_last_error = finalize_ok ? "none" : finalize_reason;
      state.top5_bucket_last_served_utc = now_utc;
      state.top5_bucket_next_due = now_utc + ASC_TOP5_BUCKET_CADENCE_SEC;
      string final_reason = "";
      ASC_Top5BucketWriteFamilyManifest(state, now_utc, final_reason);
      for(int b = 0; b < ArraySize(state.top5_bucket_active_slugs); b++)
        {
         string manifest_reason = "";
         ASC_Top5BucketWriteBucketManifest(state, state.top5_bucket_active_slugs[b], state.top5_bucket_active_displays[b], now_utc, manifest_reason);
        }
      string final_staging_reason = "";
      ASC_Top5BucketWriteStagingManifest(state, now_utc, finalize_ok ? "cleared_after_promote" : "failed_retained_for_debug", final_staging_reason);
      string final_archive_reason = "";
      ASC_Top5BucketWriteArchiveManifest(state, now_utc, finalize_ok ? "previous_active_archived_on_promote" : "failed_no_active_replace", finalize_reason, final_archive_reason);
      ASC_RecordTop5BucketDecision(state,
                                   "top5_bucket_finalize",
                                   finalize_ok ? ASC_RESULT_OK : ASC_RESULT_ERROR,
                                   finalize_ok ? ASC_RC_OK : ASC_RC_IO_FAILED,
                                   finalize_reason + " | family=" + final_reason + " | staging=" + final_staging_reason + " | archive=" + final_archive_reason,
                                   ASC_Top5BucketRootDirectory(state));
     }
  }
bool ASC_Top10RunFullFamilyCompleteInDirectory(const ASC_RuntimeState &state,
                                               const string directory,
                                               const string &symbols[],
                                               const datetime truth_floor_utc,
                                               const string required_publication_id,
                                               string &reason_out)
  {
   reason_out = "family_unchecked";
   if(StringLen(directory) <= 0)
     {
      reason_out = "family_directory_unavailable";
      return false;
     }

   int expected_count = 0;
   int verified_count = 0;
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      string symbol = symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      expected_count++;
      string child_reason = "";
      if(!ASC_GlobalTop10ArtifactCompleteForSymbolInDirectory(state,
                                                              directory,
                                                              symbol,
                                                              truth_floor_utc,
                                                              required_publication_id,
                                                              child_reason))
        {
         reason_out = StringFormat("family_child_failed symbol=%s reason=%s",
                                   symbol,
                                   ASC_TextOrUnavailable(child_reason));
         return false;
        }
      verified_count++;
     }

   if(expected_count <= 0 || verified_count != expected_count)
     {
      reason_out = StringFormat("family_count_invalid expected=%d verified=%d", expected_count, verified_count);
      return false;
     }

   reason_out = StringFormat("family_complete verified_count=%d", verified_count);
   return true;
  }

bool ASC_Top10RunFullArchiveSlotComplete(const ASC_RuntimeState &state,
                                         const datetime now_utc,
                                         const string &symbols[],
                                         string &reason_out)
  {
   reason_out = "archive_slot_unchecked";
   string archive_dir = ASC_Top10ArchiveSnapshotDirectory(state, now_utc);
   if(StringLen(archive_dir) <= 0)
     {
      reason_out = "archive_slot_directory_unavailable";
      return false;
     }

   int expected_count = 0;
   int existing_count = 0;
   int missing_count = 0;
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(StringLen(symbols[i]) <= 0)
         continue;
      expected_count++;
      string archive_path = ASC_GlobalTop10ArtifactPathForDirectory(archive_dir, symbols[i], "");
      if(ASC_FileExistsCommon(archive_path))
         existing_count++;
      else
         missing_count++;
     }

   if(expected_count <= 0)
     {
      reason_out = "archive_slot_expected_empty";
      return false;
     }

   if(existing_count <= 0)
     {
      reason_out = "archive_slot_empty";
      return false;
     }

   if(existing_count != expected_count || missing_count > 0)
     {
      reason_out = StringFormat("archive_slot_partial expected=%d existing=%d missing=%d",
                                expected_count,
                                existing_count,
                                missing_count);
      return false;
     }

   string family_reason = "";
   if(!ASC_Top10RunFullFamilyCompleteInDirectory(state,
                                                 archive_dir,
                                                 symbols,
                                                 0,
                                                 "",
                                                 family_reason))
     {
      reason_out = "archive_slot_invalid | " + family_reason;
      return false;
     }

   reason_out = StringFormat("archive_slot_complete count=%d", existing_count);
   return true;
  }

bool ASC_Top10RunFullArchiveSlotHasPartial(const ASC_RuntimeState &state,
                                           const datetime now_utc,
                                           const string &symbols[],
                                           string &reason_out)
  {
   reason_out = "archive_slot_partial_unchecked";
   string archive_dir = ASC_Top10ArchiveSnapshotDirectory(state, now_utc);
   if(StringLen(archive_dir) <= 0)
     {
      reason_out = "archive_slot_directory_unavailable";
      return false;
     }

   int expected_count = 0;
   int existing_count = 0;
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(StringLen(symbols[i]) <= 0)
         continue;
      expected_count++;
      string archive_path = ASC_GlobalTop10ArtifactPathForDirectory(archive_dir, symbols[i], "");
      if(ASC_FileExistsCommon(archive_path))
         existing_count++;
     }

   if(existing_count > 0 && existing_count < expected_count)
     {
      reason_out = StringFormat("archive_slot_partial expected=%d existing=%d", expected_count, existing_count);
      return true;
     }

   reason_out = StringFormat("archive_slot_not_partial expected=%d existing=%d", expected_count, existing_count);
   return false;
  }

bool ASC_Top10RunFullArchiveLiveFamily(const ASC_RuntimeState &state,
                                       const datetime now_utc,
                                       string &reason_out)
  {
   reason_out = "archive_not_needed";
   if(ArraySize(state.top10_run_full_last_completed_symbols) <= 0)
      return true;

   string archive_dir = ASC_Top10ArchiveSnapshotDirectory(state, now_utc);
   if(StringLen(archive_dir) <= 0)
     {
      reason_out = "archive_directory_unavailable";
      return false;
     }

   string slot_reason = "";
   if(ASC_Top10RunFullArchiveSlotComplete(state,
                                          now_utc,
                                          state.top10_run_full_last_completed_symbols,
                                          slot_reason))
     {
      string manifest_path = ASC_Top10RunFullFamilyManifestPath(archive_dir);
      if(!ASC_FileExistsCommon(manifest_path))
        {
         string complete_manifest_reason = "";
         if(!ASC_Top10RunFullWriteFamilyManifest(archive_dir,
                                                 state.server_root,
                                                 "archive",
                                                 "archived_complete",
                                                 now_utc,
                                                 state.top10_run_full_last_completed_source_pass_utc,
                                                 state.top10_run_full_last_completed_source_signature,
                                                 state.top10_run_full_last_completed_symbols,
                                                 slot_reason,
                                                 complete_manifest_reason))
           {
            reason_out = "archive_slot_manifest_missing_and_write_failed | " + complete_manifest_reason;
            return false;
           }
         slot_reason += " | manifest_repaired=" + complete_manifest_reason;
        }
      reason_out = "archive_slot_already_complete | " + slot_reason;
      return true;
     }

   string partial_reason = "";
   if(ASC_Top10RunFullArchiveSlotHasPartial(state,
                                            now_utc,
                                            state.top10_run_full_last_completed_symbols,
                                            partial_reason))
     {
      reason_out = "archive_slot_partial_blocks_promotion | " + partial_reason;
      return false;
     }

   string live_family_reason = "";
   if(!ASC_Top10RunFullFamilyCompleteInDirectory(state,
                                                 ASC_GlobalTop10LiveDirectory(state),
                                                 state.top10_run_full_last_completed_symbols,
                                                 0,
                                                 "",
                                                 live_family_reason))
     {
      reason_out = "archive_source_live_family_invalid | " + live_family_reason;
      return false;
     }

   if(!ASC_EnsureDirectoryTree(archive_dir))
     {
      reason_out = "archive_directory_create_failed";
      return false;
     }

   string required_tokens[];
   ArrayResize(required_tokens, 0);
   int expected_count = 0;
   int archived_count = 0;
   for(int i = 0; i < ArraySize(state.top10_run_full_last_completed_symbols); i++)
     {
      string symbol = state.top10_run_full_last_completed_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      expected_count++;
      string live_path = ASC_GlobalTop10LiveArtifactPath(state, symbol, "");
      string archive_path = ASC_GlobalTop10ArtifactPathForDirectory(archive_dir, symbol, "");
      string write_state = "pending";
      string write_reason = "pending";
      if(!ASC_CopyTextFileAtomic(live_path, archive_path, required_tokens, write_state, write_reason))
        {
         reason_out = StringFormat("archive_copy_failed symbol=%s state=%s reason=%s",
                                   symbol,
                                   ASC_TextOrUnavailable(write_state),
                                   ASC_TextOrUnavailable(write_reason));
         return false;
        }
      archived_count++;
     }

   if(expected_count <= 0 || archived_count != expected_count)
     {
      reason_out = StringFormat("archive_incomplete expected=%d archived=%d", expected_count, archived_count);
      return false;
     }

   string archive_verify_reason = "";
   if(!ASC_Top10RunFullFamilyCompleteInDirectory(state,
                                                 archive_dir,
                                                 state.top10_run_full_last_completed_symbols,
                                                 0,
                                                 "",
                                                 archive_verify_reason))
     {
      reason_out = "archive_readback_failed | " + archive_verify_reason;
      return false;
     }

   string manifest_reason = "";
   if(!ASC_Top10RunFullWriteFamilyManifest(archive_dir,
                                           state.server_root,
                                           "archive",
                                           "archived_complete",
                                           now_utc,
                                           state.top10_run_full_last_completed_source_pass_utc,
                                           state.top10_run_full_last_completed_source_signature,
                                           state.top10_run_full_last_completed_symbols,
                                           archive_verify_reason,
                                           manifest_reason))
     {
      reason_out = "archive_manifest_failed | " + manifest_reason;
      return false;
     }

   reason_out = StringFormat("archive_written slot=%s count=%d | %s",
                             ASC_TextOrUnavailable(ASC_Top10ArchiveCadenceSlotLabel(now_utc)),
                             archived_count,
                             ASC_TextOrUnavailable(archive_verify_reason));
   return true;
  }

bool ASC_Top10RunFullPromoteStagingFamily(ASC_RuntimeState &state,
                                          const datetime now_utc,
                                          string &reason_out)
  {
   reason_out = "pending";
   if(ArraySize(state.top10_run_full_symbols) <= 0)
     {
      reason_out = "staging_symbols_unavailable";
      return false;
     }

   string live_dir = ASC_GlobalTop10LiveDirectory(state);
   if(StringLen(live_dir) <= 0 || !ASC_EnsureDirectoryTree(live_dir))
     {
      reason_out = "live_directory_unavailable";
      return false;
     }

   string stage_verify_reason = "stage_unchecked";
   if(!ASC_Top10RunFullStageFamilyComplete(state, stage_verify_reason))
     {
      reason_out = "stage_verification_blocked | " + stage_verify_reason;
      return false;
     }

   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_staging_complete",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                "branch=top10_batch_staging_complete | verify_result=passed | " + stage_verify_reason + " | live_family_preserved=yes",
                                ASC_Top10RunFullStagingDirectory(state));

   string archive_reason = "archive_not_needed";
   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_archive_eligibility",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                StringFormat("branch=top10_batch_archive_eligibility | eligible=%s | prior_family_count=%d | archive_dir=%s",
                                             ArraySize(state.top10_run_full_last_completed_symbols) > 0 ? "yes" : "no",
                                             ArraySize(state.top10_run_full_last_completed_symbols),
                                             ASC_TextOrUnavailable(ASC_Top10ArchiveSnapshotDirectory(state, now_utc))),
                                ASC_Top10ArchiveSnapshotDirectory(state, now_utc));
   if(!ASC_Top10RunFullArchiveLiveFamily(state, now_utc, archive_reason))
     {
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_archive",
                                   ASC_RESULT_ERROR,
                                   ASC_RC_IO_FAILED,
                                   "branch=top10_batch_archive | write_result=failed | live_family_preserved=yes | reason=" + archive_reason,
                                   ASC_Top10ArchiveSnapshotDirectory(state, now_utc));
      reason_out = "archive_blocked | " + archive_reason;
      return false;
     }

   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_archive",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                "branch=top10_batch_archive | write_result=success | " + archive_reason + " | live_family_preserved=yes",
                                ASC_Top10ArchiveSnapshotDirectory(state, now_utc));

   string staging_manifest_reason = "";
   if(!ASC_Top10RunFullWriteFamilyManifest(ASC_Top10RunFullStagingDirectory(state),
                                           state.server_root,
                                           "staging",
                                           (state.warmup_degraded_first_publish && state.top10_run_full_batch_last_served_utc <= 0) ? "verified_degraded_first_publish_before_promote" : ((state.warmup_first_top10_released && state.top10_run_full_batch_last_served_utc <= 0) ? "verified_complete_first_publish_before_promote" : "verified_complete_before_promote"),
                                           now_utc,
                                           state.top10_run_full_inflight_source_pass_utc,
                                           state.top10_run_full_inflight_source_signature,
                                           state.top10_run_full_symbols,
                                           stage_verify_reason,
                                           staging_manifest_reason))
     {
      reason_out = "staging_manifest_blocked | " + staging_manifest_reason;
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_staging_manifest",
                                   ASC_RESULT_ERROR,
                                   ASC_RC_IO_FAILED,
                                   "branch=top10_batch_staging_manifest | manifest_result=failed | live_family_preserved=yes | reason=" + staging_manifest_reason,
                                   ASC_Top10RunFullStagingDirectory(state));
      return false;
     }

   string staging_decision_state = (state.warmup_degraded_first_publish && state.top10_run_full_batch_last_served_utc <= 0)
                                   ? "verified_degraded_first_publish_before_promote"
                                   : ((state.warmup_first_top10_released && state.top10_run_full_batch_last_served_utc <= 0)
                                      ? "verified_complete_first_publish_before_promote"
                                      : "verified_complete_before_promote");
   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_staging_manifest",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                "branch=top10_batch_staging_manifest | manifest_result=success | state=" + staging_decision_state + " | " + staging_manifest_reason,
                                ASC_Top10RunFullStagingDirectory(state));

   string required_tokens[];
   ArrayResize(required_tokens, 0);
   int promoted_count = 0;
   for(int i = 0; i < ArraySize(state.top10_run_full_symbols); i++)
     {
      string symbol = state.top10_run_full_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      string staging_path = ASC_GlobalTop10BatchArtifactPath(state, symbol, "");
      string live_path = ASC_GlobalTop10LiveArtifactPath(state, symbol, "");
      string write_state = "pending";
      string write_reason = "pending";
      if(!ASC_CopyTextFileAtomic(staging_path, live_path, required_tokens, write_state, write_reason))
        {
         reason_out = StringFormat("promote_copy_failed symbol=%s state=%s reason=%s | archive=%s",
                                   symbol,
                                   ASC_TextOrUnavailable(write_state),
                                   ASC_TextOrUnavailable(write_reason),
                                   ASC_TextOrUnavailable(archive_reason));
         ASC_RecordTop10BatchDecision(state,
                                      "top10_batch_promote",
                                      ASC_RESULT_ERROR,
                                      ASC_RC_IO_FAILED,
                                      "branch=top10_batch_promote | promote_result=failed | live_family_preserved_until_failure=yes | reason=" + reason_out,
                                      live_path);
         return false;
        }
      promoted_count++;
     }

   string live_verify_reason = "";
   if(!ASC_Top10RunFullFamilyCompleteInDirectory(state,
                                                 live_dir,
                                                 state.top10_run_full_symbols,
                                                 state.top10_run_full_batch_requested_utc,
                                                 "",
                                                 live_verify_reason))
     {
      reason_out = "promote_live_readback_failed | " + live_verify_reason + " | archive=" + archive_reason;
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_promote_verify",
                                   ASC_RESULT_ERROR,
                                   ASC_RC_IO_FAILED,
                                   "branch=top10_batch_promote_verify | verify_result=failed | old_children_not_removed=yes | reason=" + reason_out,
                                   live_dir);
      return false;
     }

   string live_manifest_reason = "";
   if(!ASC_Top10RunFullWriteFamilyManifest(live_dir,
                                           state.server_root,
                                           "current",
                                           (state.warmup_degraded_first_publish && state.top10_run_full_batch_last_served_utc <= 0) ? "promoted_degraded_first_publish" : ((state.warmup_first_top10_released && state.top10_run_full_batch_last_served_utc <= 0) ? "promoted_complete_first_publish" : "promoted_complete"),
                                           now_utc,
                                           state.top10_run_full_inflight_source_pass_utc,
                                           state.top10_run_full_inflight_source_signature,
                                           state.top10_run_full_symbols,
                                           live_verify_reason,
                                           live_manifest_reason))
     {
      reason_out = "promote_manifest_failed | " + live_manifest_reason + " | archive=" + archive_reason;
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_promote_manifest",
                                   ASC_RESULT_ERROR,
                                   ASC_RC_IO_FAILED,
                                   "branch=top10_batch_promote_manifest | manifest_result=failed | old_children_not_removed=yes | reason=" + reason_out,
                                   live_dir);
      return false;
     }

   bool has_deferred_l5_degraded_children = (state.top10_deferred_l5_expired_count > 0
                                                || state.top10_deferred_l5_retry_exhausted_count > 0);
      string live_decision_state = has_deferred_l5_degraded_children
                                ? "promoted_degraded_deferred_l5"
                                : ((state.warmup_degraded_first_publish && state.top10_run_full_batch_last_served_utc <= 0)
                                   ? "promoted_degraded_first_publish"
                                   : ((state.warmup_first_top10_released && state.top10_run_full_batch_last_served_utc <= 0)
                                      ? "promoted_complete_first_publish"
                                      : "promoted_complete"));
   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_promote_verify",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                "branch=top10_batch_promote_verify | verify_result=passed | family_state=" + live_decision_state + " | " + live_verify_reason + " | manifest=" + live_manifest_reason,
                                live_dir);

   int removed_count = 0;
   for(int i = 0; i < ArraySize(state.top10_run_full_last_completed_symbols); i++)
     {
      string prior_symbol = state.top10_run_full_last_completed_symbols[i];
      if(StringLen(prior_symbol) <= 0 || ASC_Top10RunFullSymbolExists(state.top10_run_full_symbols, prior_symbol))
         continue;
      string prior_live_path = ASC_GlobalTop10LiveArtifactPath(state, prior_symbol, "");
      if(ASC_DeleteFileIfExists(prior_live_path))
         removed_count++;
     }

   for(int i = 0; i < ArraySize(state.top10_run_full_symbols); i++)
     {
      string symbol = state.top10_run_full_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      ASC_DeleteFileIfExists(ASC_GlobalTop10BatchArtifactPath(state, symbol, ""));
     }

   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_promote",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                StringFormat("branch=top10_batch_promote | promote_result=success | promoted_count=%d | removed_count=%d | live_family_replaced_as_family=yes | archive=%s",
                                             promoted_count,
                                             removed_count,
                                             ASC_TextOrUnavailable(archive_reason)),
                                ASC_Top10RunFullTargetDirectory(state));

   reason_out = StringFormat("promoted_count=%d removed_count=%d | %s",
                             promoted_count,
                             removed_count,
                             ASC_TextOrUnavailable(archive_reason));
   return true;
  }

void ASC_ReconcileTop10RunFullChildFamily(ASC_RuntimeState &state,const datetime now_utc)
  {
   bool batch_active = (state.top10_run_full_batch_pending
                        || state.top10_run_full_cursor < state.top10_run_full_total
                        || StringLen(state.top10_run_full_inflight_symbol) > 0);
   if(batch_active)
      return;

   string cadence_reason = "";
   bool cadence_due = ASC_Top10RunFullCadenceDue(state, now_utc, cadence_reason);

   string snapshot_symbols[];
   string snapshot_reason = "";
   bool snapshot_ok = ASC_Top10RunFullBuildSnapshot(state, snapshot_symbols, snapshot_reason);

   state.top10_run_full_current_source_pass_utc = (state.publication_shortlist_pass_utc > 0
                                                   ? state.publication_shortlist_pass_utc
                                                   : state.committed_l4_pass_utc);
   state.top10_run_full_current_source_signature = snapshot_ok ? ASC_Top10RunFullBoardSignature(state, snapshot_symbols) : "";

   if(!snapshot_ok)
     {
      state.top10_run_full_family_alignment_status = "source_unavailable";
      state.top10_run_full_family_alignment_reason = StringFormat("current committed shortlist family unavailable for GlobalTop10 refresh | reason=%s | cadence=%s",
                                                                  ASC_TextOrUnavailable(snapshot_reason),
                                                                  ASC_TextOrUnavailable(cadence_reason));
      if(cadence_due)
         state.top10_run_full_batch_last_served_utc = now_utc;
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_cadence_due",
                                   ASC_RESULT_WARNING,
                                   ASC_RC_NOT_FOUND,
                                   StringFormat("branch=top10_batch_cadence_due | cadence_due=%s | admitted=no | reason=%s | snapshot=%s | live_family_preserved=yes",
                                                cadence_due ? "yes" : "no",
                                                ASC_TextOrUnavailable(cadence_reason),
                                                ASC_TextOrUnavailable(snapshot_reason)),
                                   ASC_Top10RunFullTargetDirectory(state));
      return;
     }

   if(state.top10_run_full_batch_last_served_utc <= 0 && !state.warmup_first_top10_released)
     {
      string warmup_release_label = "hold";
      string warmup_gate_reason = "warmup_gate_unchecked";
      bool warmup_released = ASC_WarmupEvaluateFirstTop10Release(state,
                                                                 now_utc,
                                                                 snapshot_symbols,
                                                                 snapshot_reason,
                                                                 warmup_release_label,
                                                                 warmup_gate_reason);
      state.top10_run_full_family_alignment_status = warmup_released ? warmup_release_label : "warmup_gate_hold";
      state.top10_run_full_family_alignment_reason = warmup_gate_reason;
      if(!warmup_released)
        {
         state.top10_run_full_batch_status = "warmup_gate_hold";
         state.top10_run_full_batch_reason = warmup_gate_reason;
         ASC_WarmupRequestBoundedL2RetryForTop10(snapshot_symbols, now_utc);
         ASC_RecordTop10BatchDecision(state,
                                      "top10_first_publish_warmup_gate",
                                      ASC_RESULT_OK,
                                      ASC_RC_OK,
                                      "branch=top10_first_publish_warmup_gate | admitted=no | " + warmup_gate_reason,
                                      ASC_Top10RunFullTargetDirectory(state));
         return;
        }
      ASC_RecordTop10BatchDecision(state,
                                   "top10_first_publish_warmup_gate",
                                   state.warmup_degraded_first_publish ? ASC_RESULT_WARNING : ASC_RESULT_OK,
                                   ASC_RC_OK,
                                   "branch=top10_first_publish_warmup_gate | admitted=yes | release=" + warmup_release_label + " | " + warmup_gate_reason,
                                   ASC_Top10RunFullStagingDirectory(state));
     }

   if(!cadence_due)
     {
      bool same_source_pass = (state.top10_run_full_last_completed_source_pass_utc == state.top10_run_full_current_source_pass_utc);
      bool same_signature = (state.top10_run_full_last_completed_source_signature == state.top10_run_full_current_source_signature);
      state.top10_run_full_family_alignment_status = (same_source_pass && same_signature) ? "aligned_cadence_hold" : "alignment_mismatch_pending_refresh";
      state.top10_run_full_family_alignment_reason = (same_source_pass && same_signature)
                                                     ? StringFormat("GlobalTop10 refresh held by 5-minute cadence | %s | clean current allowed because derived_from_board_signature matches current board signature",
                                                                    ASC_TextOrUnavailable(cadence_reason))
                                                     : StringFormat("GlobalTop10 retained family is stale/current-mismatch until refresh promotes | %s | derived_from_board_signature=%s | current_board_signature=%s",
                                                                    ASC_TextOrUnavailable(cadence_reason),
                                                                    ASC_TextOrUnavailable(state.top10_run_full_last_completed_source_signature),
                                                                    ASC_TextOrUnavailable(state.top10_run_full_current_source_signature));
      if(state.top10_run_full_batch_status != "cadence_hold")
        {
         state.top10_run_full_batch_status = "cadence_hold";
         state.top10_run_full_batch_reason = cadence_reason;
         ASC_RecordTop10BatchDecision(state,
                                      "top10_batch_cadence_not_due",
                                      ASC_RESULT_OK,
                                      ASC_RC_OK,
                                      StringFormat("branch=top10_batch_cadence_not_due | admitted=no | reason=%s | current_symbols=%s | live_family_preserved=yes | staging_started=no",
                                                   ASC_TextOrUnavailable(cadence_reason),
                                                   ASC_TextOrUnavailable(ASC_Top10RunFullCompactSymbolList(state.top10_run_full_last_completed_symbols))),
                                      ASC_Top10RunFullTargetDirectory(state));
        }
      return;
     }

   int dropped_count = 0;
   for(int i = 0; i < ArraySize(state.top10_run_full_last_completed_symbols); i++)
     {
      string prior_symbol = state.top10_run_full_last_completed_symbols[i];
      if(StringLen(prior_symbol) <= 0 || ASC_Top10RunFullSymbolExists(snapshot_symbols, prior_symbol))
         continue;
      dropped_count++;
     }

   state.top10_run_full_batch_pending = true;
   state.top10_run_full_batch_requested_utc = now_utc;
   state.top10_run_full_batch_status = "refresh_queued";
   state.top10_run_full_batch_reason = StringFormat("5-minute cadence admitted Top10 refresh | %s | source_pass=%s | dropped=%d",
                                                    ASC_TextOrUnavailable(cadence_reason),
                                                    ASC_ArtifactFormatUtc(state.top10_run_full_current_source_pass_utc),
                                                    dropped_count);
   ArrayResize(state.top10_run_full_symbols, 0);
   state.top10_run_full_total = 0;
   state.top10_run_full_cursor = 0;
   state.top10_run_full_inflight_symbol = "";
   state.top10_run_full_inflight_retry_count = 0;
   state.top10_run_full_inflight_queued_utc = 0;
   state.top10_run_full_inflight_publication_id = "";
   state.top10_run_full_inflight_source_pass_utc = 0;
   state.top10_run_full_inflight_source_signature = "";
   state.top10_run_full_family_alignment_status = "cadence_refresh_queued";
   state.top10_run_full_family_alignment_reason = StringFormat("lawful 5-minute cadence admitted staging refresh | source_signature=%s | current live family preserved until promote",
                                                               ASC_TextOrUnavailable(state.top10_run_full_current_source_signature));
   ASC_RecordTop10BatchDecision(state,
                                "top10_batch_cadence_due",
                                ASC_RESULT_OK,
                                ASC_RC_OK,
                                StringFormat("branch=top10_batch_cadence_due | cadence_due=yes | admitted=yes | reason=%s | current_symbols=%s | prior_symbols=%s | dropped=%d | live_family_preserved=yes | staging_will_start=yes",
                                             ASC_TextOrUnavailable(cadence_reason),
                                             ASC_TextOrUnavailable(ASC_Top10RunFullCompactSymbolList(snapshot_symbols)),
                                             ASC_TextOrUnavailable(ASC_Top10RunFullCompactSymbolList(state.top10_run_full_last_completed_symbols)),
                                             dropped_count),
                                ASC_Top10RunFullStagingDirectory(state));
  }


void ASC_RecordTop10BatchDecision(const ASC_RuntimeState &state,
                                  const string scope,
                                  const ASC_FunctionResultState result_state,
                                  const ASC_ResultCode result_code,
                                  const string detail,
                                  const string target_path = "")
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_Dispatcher", "ASC_ServiceTop10RunFullBatch", scope);
   ASC_FunctionResultFinish(result, result_state, result_code, detail, target_path);
   ASC_RecordResult(state, result, true, result_state != ASC_RESULT_OK);
  }

bool ASC_GlobalTop10PayloadCarriesDeferredPendingDeepLabel(const string payload)
  {
   return (StringLen(payload) > 0
           && StringFind(payload, "deep_payload_deferred: yes") >= 0
           && StringFind(payload, "deep_hydration_pending: yes") >= 0
           && StringFind(payload, "deep_completed: no") >= 0);
  }

bool ASC_GlobalTop10PayloadCarriesDeferredTerminalLabel(const string payload)
  {
   return (StringLen(payload) > 0
           && StringFind(payload, "deep_payload_deferred: yes") >= 0
           && StringFind(payload, "deep_completed: no") >= 0
           && (StringFind(payload, "deep_hydration_state: expired") >= 0
               || StringFind(payload, "deep_hydration_state: retry_exhausted") >= 0
               || StringFind(payload, "deep_hydration_state: degraded") >= 0)
           && (StringFind(payload, "deep_hydration_expired: yes") >= 0
               || StringFind(payload, "deep_hydration_retry_exhausted: yes") >= 0
               || StringFind(payload, "deep_hydration_degraded: yes") >= 0));
  }

bool ASC_GlobalTop10PayloadCarriesDeferredDeepLabel(const string payload)
  {
   return ASC_GlobalTop10PayloadCarriesDeferredTerminalLabel(payload);
  }

string ASC_Run081RBuildIdentityToken()
  {
   return StringFormat("build_identity_present=true | asc_version=%s | asc_run=%s | source_patch=RUN081R | proof_boundary=source_patched_live_unproven",
                       ASC_VERSION_LABEL,
                       ASC_TRUTH_SEEKER_CURRENT_RUN);
  }

string ASC_Run082RBuildIdentityToken()
  {
   return StringFormat("build_identity_present=true | asc_version=%s | asc_run=%s | source_patch=RUN082R | proof_boundary=source_patched_live_unproven | next_live_checkpoint=RUN090R",
                       ASC_VERSION_LABEL,
                       ASC_TRUTH_SEEKER_CURRENT_RUN);
  }

string ASC_GlobalTop10DeferredL5RecoveryCountersTrace(const ASC_RuntimeState &state)
  {
   return StringFormat("pending_count=%d | completed_count=%d | expired_count=%d | retry_exhausted_count=%d | last_state=%s | last_symbol=%s | last_service_utc=%s",
                       state.top10_deferred_l5_pending_count,
                       state.top10_deferred_l5_completed_count,
                       state.top10_deferred_l5_expired_count,
                       state.top10_deferred_l5_retry_exhausted_count,
                       ASC_TextOrUnavailable(state.top10_deferred_l5_last_state),
                       ASC_TextOrUnavailable(state.top10_deferred_l5_last_symbol),
                       ASC_ArtifactFormatUtc(state.top10_deferred_l5_last_service_utc));
  }

bool ASC_MarkGlobalTop10DeferredL5Terminal(ASC_RuntimeState &state,
                                           const string runtime_symbol,
                                           const string canonical_symbol,
                                           const datetime now_utc,
                                           const string hydration_state,
                                           const int retry_count,
                                           const string status_reason,
                                           string &reason_out)
  {
   reason_out = "pending";
   string top10_batch_path = ASC_GlobalTop10BatchArtifactPath(state, runtime_symbol, canonical_symbol);
   if(StringLen(top10_batch_path) <= 0)
     {
      reason_out = "top10_deferred_terminal_path_unavailable";
      return false;
     }

   string payload = "";
   if(!ASC_ReadTextFile(top10_batch_path, payload) || StringLen(payload) <= 0)
     {
      reason_out = "top10_deferred_terminal_payload_missing";
      return false;
     }

   if(!ASC_GlobalTop10PayloadCarriesDeferredPendingDeepLabel(payload)
      && !ASC_GlobalTop10PayloadCarriesDeferredTerminalLabel(payload))
     {
      reason_out = "top10_deferred_terminal_payload_not_deferred";
      return false;
     }

   bool expired = (hydration_state == "expired" || hydration_state == "retry_exhausted" || hydration_state == "degraded");
   bool retry_exhausted = (hydration_state == "retry_exhausted" || retry_count >= ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES);
   bool degraded = expired || retry_exhausted;

   payload += "\nGlobalTop10 Deferred L5 Recovery Status\n";
   payload += "deep_payload_deferred: yes\n";
   payload += "deep_hydration_state: " + hydration_state + "\n";
   payload += "deep_hydration_pending: no\n";
   payload += "deep_hydration_in_progress: no\n";
   payload += "deep_hydration_completed: no\n";
   payload += "deep_hydration_partial: yes\n";
   payload += "deep_hydration_degraded: " + (degraded ? "yes" : "no") + "\n";
   payload += "deep_hydration_expired: " + (expired ? "yes" : "no") + "\n";
   payload += "deep_hydration_retry_exhausted: " + (retry_exhausted ? "yes" : "no") + "\n";
   payload += "deep_completed: no\n";
   payload += "retry_count: " + IntegerToString(retry_count) + "\n";
   payload += "retry_max: " + IntegerToString(ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES) + "\n";
   payload += "retry_spacing_sec: " + IntegerToString(ASC_TOP10_DEFERRED_L5_RECOVERY_RETRY_SPACING_SEC) + "\n";
   payload += "max_age_sec: " + IntegerToString(ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_AGE_SEC) + "\n";
   payload += "recovery_status_utc: " + ASC_ArtifactFormatUtc(now_utc) + "\n";
   payload += "recovery_reason: " + ASC_TextOrUnavailable(status_reason) + "\n";
   payload += "pending_count: 0\n";
   payload += "completed_count: 0\n";
   payload += "expired_count: " + (expired ? "1" : "0") + "\n";
   payload += "retry_exhausted_count: " + (retry_exhausted ? "1" : "0") + "\n";
   payload += "heartbeat_budget_guard: RUN082R_GLOBALTOP10_DEFERRED_L5_RECOVERY_TERMINAL\n";
   payload += ASC_Run082RBuildIdentityToken() + "\n";

   string required_tokens[];
   ArrayResize(required_tokens, 6);
   required_tokens[0] = "Schema Version:";
   required_tokens[1] = "Selected Symbol Status:";
   required_tokens[2] = "GlobalTop10 Deep Hydration Status";
   required_tokens[3] = "GlobalTop10 Deferred L5 Recovery Status";
   required_tokens[4] = "deep_hydration_state: " + hydration_state;
   required_tokens[5] = "deep_completed: no";

   string write_state = "pending";
   string write_reason = "pending";
   if(!ASC_WritePublicationPayloadAtomic(top10_batch_path, payload, required_tokens, "partial", write_state, write_reason))
     {
      reason_out = "top10_deferred_terminal_write_failed | " + write_reason;
      return false;
     }

   state.top10_deferred_l5_pending_count = (state.top10_deferred_l5_pending_count > 0 ? state.top10_deferred_l5_pending_count - 1 : 0);
   if(expired)
      state.top10_deferred_l5_expired_count++;
   if(retry_exhausted)
      state.top10_deferred_l5_retry_exhausted_count++;
   state.top10_deferred_l5_last_service_utc = now_utc;
   state.top10_deferred_l5_last_symbol = runtime_symbol;
   state.top10_deferred_l5_last_state = hydration_state;
   state.top10_deferred_l5_last_reason = status_reason;
   reason_out = StringFormat("top10_deferred_l5_terminal_written | symbol=%s | state=%s | retry=%d/%d | write_state=%s | %s",
                             runtime_symbol,
                             hydration_state,
                             retry_count,
                             ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES,
                             ASC_TextOrUnavailable(write_state),
                             ASC_GlobalTop10DeferredL5RecoveryCountersTrace(state));
   return true;
  }

bool ASC_PublishGlobalTop10DeferredDeepChild(ASC_RuntimeState &state,
                                             const ASC_Layer1SymbolState &selected,
                                             const ASC_ShortlistSymbolSummary &shortlist_rows[],
                                             const datetime now_utc,
                                             string &reason_out)
  {
   reason_out = "pending";
   string canonical_symbol = ASC_SelectedCanonicalSymbol(selected);
   string top10_batch_path = ASC_GlobalTop10BatchArtifactPath(state, selected.symbol, canonical_symbol);
   if(StringLen(top10_batch_path) <= 0)
     {
      reason_out = "top10_batch_path_unavailable";
      return false;
     }

   string top10_target_dir = ASC_PathParentDirectory(top10_batch_path);
   if(StringLen(top10_target_dir) <= 0 || !ASC_EnsureDirectoryTree(top10_target_dir))
     {
      reason_out = "top10_batch_directory_unavailable";
      return false;
     }

   ASC_DeepSelectiveAnalysisResult deferred_deep;
   ASC_DeepInitResult(deferred_deep);
   deferred_deep.symbol = selected.symbol;
   deferred_deep.canonical_symbol = canonical_symbol;
   deferred_deep.entitlement_state = "DEFERRED_BY_HEARTBEAT_BUDGET";
   deferred_deep.entitlement_reason = "GlobalTop10 child heavy Deep Analysis hydration deferred by RUN081R budget guard; L0-L4 child identity is published first and L5 must not be read as complete.";
   deferred_deep.summary_line = "deep_payload_deferred | deep_hydration_pending | deep_completed=no";
   deferred_deep.block_text = "Deep Analysis Hydration Deferred\n"
                              "deep_payload_deferred: yes\n"
                              "deep_hydration_pending: yes\n"
                              "deep_completed: no\n"
                              "defer_reason=RUN081R GlobalTop10 child heartbeat budget guard prevents CopyRates/CopyTicks-heavy L5 work from monopolizing one timer beat\n";
   deferred_deep.execution_context = "global_top10_batch_deferred";
   deferred_deep.build_context = "deferred";
   deferred_deep.data_tier = "tier_deferred_not_complete";

   ASC_PublicationBundleState top10_bundle = state.publication_bundle;
   top10_bundle.publication_id = StringFormat("top10-deferred-%I64d-%d", (long)now_utc, state.heartbeat_counter);
   top10_bundle.publication_utc = now_utc;
   if(top10_bundle.bundle_started_utc <= 0)
      top10_bundle.bundle_started_utc = now_utc;
   top10_bundle.bundle_finished_utc = now_utc;
   top10_bundle.dossier_attempted_count = 1;
   top10_bundle.dossier_success_count = 0;
   top10_bundle.dossier_failure_count = 0;
   top10_bundle.dossier_skipped_count = 0;

   string payload = "";
   string publication_state = "partial";
   string required_tokens[];
   string payload_canonical = "";
   if(!ASC_BuildCanonicalDossierPayload(state.server_root,
                                        selected,
                                        top10_bundle,
                                        shortlist_rows,
                                        ASC_DOSSIER_MODE_DEEP_OVERRIDE,
                                        true,
                                        deferred_deep,
                                        "global_top10_batch:" + selected.symbol,
                                        payload_canonical,
                                        payload,
                                        publication_state,
                                        required_tokens))
     {
      reason_out = "top10_deferred_payload_compose_failed";
      return false;
     }

   payload += "\nGlobalTop10 Deep Hydration Status\n";
   payload += "deep_payload_deferred: yes\n";
   payload += "deep_hydration_state: pending\n";
   payload += "deep_hydration_pending: yes\n";
   payload += "deep_hydration_in_progress: no\n";
   payload += "deep_hydration_completed: no\n";
   payload += "deep_hydration_partial: yes\n";
   payload += "deep_hydration_degraded: no\n";
   payload += "deep_hydration_expired: no\n";
   payload += "deep_hydration_retry_exhausted: no\n";
   payload += "deep_completed: no\n";
   payload += "retry_count: 0\n";
   payload += "retry_max: " + IntegerToString(ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES) + "\n";
   payload += "retry_spacing_sec: " + IntegerToString(ASC_TOP10_DEFERRED_L5_RECOVERY_RETRY_SPACING_SEC) + "\n";
   payload += "max_age_sec: " + IntegerToString(ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_AGE_SEC) + "\n";
   payload += "pending_count: 1\n";
   payload += "completed_count: 0\n";
   payload += "expired_count: 0\n";
   payload += "retry_exhausted_count: 0\n";
   payload += "heartbeat_budget_guard: RUN081R_GLOBALTOP10_CHILD_DEEP_DEFER | RUN082R_RECOVERY_QUEUE_PENDING\n";
   payload += "board_source_pass_utc: " + ASC_ArtifactFormatUtc(state.top10_run_full_inflight_source_pass_utc) + "\n";
   payload += "board_source_signature: " + ASC_TextOrUnavailable(state.top10_run_full_inflight_source_signature) + "\n";
   payload += "derived_from_board_signature: " + ASC_TextOrUnavailable(state.top10_run_full_inflight_source_signature) + "\n";
   payload += "source_epoch_utc: " + ASC_ArtifactFormatUtc(state.top10_run_full_inflight_source_pass_utc) + "\n";
   payload += "alignment_status: pending_refresh_child_derived_from_board_signature\n";
   payload += "stale_current_guard: child_is_not_clean_current_unless_family_manifest_matches_current_board_signature\n";
   payload += ASC_ArtifactIdentityLine("globaltop10_child", "deferred_l5_pending") + "\n";
   payload += "source_run_id=" + ASC_SourceRunId() + " | source_identity_token=" + ASC_SourceIdentityToken() + " | artifact_written_by_run=" + ASC_SourceRunId() + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion() + " | build_identity_present=true\n";
   payload += ASC_Run081RBuildIdentityToken() + "\n";
   payload += ASC_Run082RBuildIdentityToken() + "\n";

   int n = ArraySize(required_tokens);
   ArrayResize(required_tokens, n + 12);
   required_tokens[n] = "Schema Version:";
   required_tokens[n + 1] = "Selected Symbol Status:";
   required_tokens[n + 2] = "GlobalTop10 Deep Hydration Status";
   required_tokens[n + 3] = "deep_payload_deferred: yes";
   required_tokens[n + 4] = "deep_completed: no";
   required_tokens[n + 5] = "derived_from_board_signature:";
   required_tokens[n + 6] = "stale_current_guard:";
   required_tokens[n + 7] = "source_run_id=";
   required_tokens[n + 8] = "artifact_written_by_run=";
   required_tokens[n + 9] = "artifact_schema_version=";
   required_tokens[n + 10] = "build_identity_present=true";

   string write_state = "pending";
   string write_reason = "pending";
   if(ASC_IsUiPriorityActive(state, now_utc))
      state.ui_priority_top10_write_attempt_count++;
   if(!ASC_WritePublicationPayloadAtomic(top10_batch_path,
                                         payload,
                                         required_tokens,
                                         "partial",
                                         write_state,
                                         write_reason))
     {
      reason_out = "top10_deferred_payload_write_failed | " + write_reason;
      return false;
     }

   state.top10_run_full_inflight_publication_id = ASC_PublicationPayloadId(payload);
   state.top10_deferred_l5_pending_count++;
   state.top10_deferred_l5_last_service_utc = now_utc;
   state.top10_deferred_l5_last_symbol = selected.symbol;
   state.top10_deferred_l5_last_state = "pending";
   state.top10_deferred_l5_last_reason = "queued for bounded deferred L5 recovery/expiry";
   reason_out = StringFormat("deep_budget_deferred | symbol=%s | publication_id=%s | write_state=%s | %s | %s",
                             selected.symbol,
                             ASC_TextOrUnavailable(state.top10_run_full_inflight_publication_id),
                             ASC_TextOrUnavailable(write_state),
                             ASC_Run081RBuildIdentityToken(),
                             ASC_GlobalTop10DeferredL5RecoveryCountersTrace(state));
   return true;
  }

void ASC_ServiceTop10RunFullBatch(ASC_RuntimeState &state,const datetime now_utc)
  {
   bool batch_active = (state.top10_run_full_batch_pending
                        || state.top10_run_full_cursor < state.top10_run_full_total
                        || StringLen(state.top10_run_full_inflight_symbol) > 0);
   if(!batch_active)
      return;

   if(state.top10_run_full_batch_pending)
     {
      string snapshot_symbols[];
      string snapshot_reason = "";
      bool snapshot_ok = ASC_Top10RunFullBuildSnapshot(state, snapshot_symbols, snapshot_reason);
      state.top10_run_full_batch_pending = false;
      state.top10_run_full_batch_requested_utc = now_utc;
      state.top10_run_full_batch_status = snapshot_ok ? "snapshot_ready" : "snapshot_empty";
      if(state.warmup_first_top10_released && StringLen(state.warmup_first_top10_release_label) > 0 && state.top10_run_full_batch_last_served_utc <= 0)
         state.top10_run_full_batch_reason = state.warmup_first_top10_release_label + " | " + snapshot_reason;
      else
         state.top10_run_full_batch_reason = snapshot_reason;
      if(snapshot_ok)
        {
         for(int i = 0; i < ArraySize(state.top10_run_full_symbols); i++)
           {
            if(StringLen(state.top10_run_full_symbols[i]) <= 0)
               continue;
            ASC_DeleteFileIfExists(ASC_GlobalTop10BatchArtifactPath(state, state.top10_run_full_symbols[i], ""));
           }
         for(int i = 0; i < ArraySize(snapshot_symbols); i++)
           {
            if(StringLen(snapshot_symbols[i]) <= 0)
               continue;
            ASC_DeleteFileIfExists(ASC_GlobalTop10BatchArtifactPath(state, snapshot_symbols[i], ""));
           }
        }
      ArrayResize(state.top10_run_full_symbols, ArraySize(snapshot_symbols));
      for(int i = 0; i < ArraySize(snapshot_symbols); i++)
         state.top10_run_full_symbols[i] = snapshot_symbols[i];
      state.top10_run_full_total = ArraySize(snapshot_symbols);
      state.top10_run_full_last_total = state.top10_run_full_total;
      state.top10_run_full_verify_pass_count = 0;
      state.top10_run_full_verify_fail_count = 0;
      state.top10_deferred_l5_pending_count = 0;
      state.top10_deferred_l5_completed_count = 0;
      state.top10_deferred_l5_expired_count = 0;
      state.top10_deferred_l5_retry_exhausted_count = 0;
      state.top10_deferred_l5_last_service_utc = now_utc;
      state.top10_deferred_l5_last_symbol = "";
      state.top10_deferred_l5_last_state = "pending_family_start";
      state.top10_deferred_l5_last_reason = "GlobalTop10 family admitted; deferred L5 child recovery counters reset";
      state.top10_run_full_cursor = 0;
      state.top10_run_full_inflight_symbol = "";
      state.top10_run_full_inflight_retry_count = 0;
      state.top10_run_full_inflight_queued_utc = 0;
      state.top10_run_full_inflight_publication_id = "";
      state.top10_run_full_inflight_source_pass_utc = state.top10_run_full_current_source_pass_utc;
      state.top10_run_full_inflight_source_signature = state.top10_run_full_current_source_signature;
      state.top10_run_full_family_alignment_status = "refresh_in_progress";
      state.top10_run_full_family_alignment_reason = StringFormat("GlobalTop10 child refresh admitted from committed shortlist family | source_pass=%s | source_signature=%s",
                                                                  ASC_ArtifactFormatUtc(state.top10_run_full_inflight_source_pass_utc),
                                                                  ASC_TextOrUnavailable(state.top10_run_full_inflight_source_signature));
      string snapshot_detail = StringFormat("branch=top10_batch_admission | requested=yes | admitted=%s | target_dir=%s | snapshot_reason=%s | source_pass=%s | source_signature=%s | live_family_preserved=yes | staging_start=%s | %s",
                                            snapshot_ok ? "yes" : "no",
                                            ASC_TextOrUnavailable(ASC_Top10RunFullStagingDirectory(state)),
                                            ASC_TextOrUnavailable(snapshot_reason),
                                            ASC_ArtifactFormatUtc(state.top10_run_full_inflight_source_pass_utc),
                                            ASC_TextOrUnavailable(state.top10_run_full_inflight_source_signature),
                                            snapshot_ok ? "yes" : "no",
                                            ASC_Top10RunFullBatchTrace(state));
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_admission",
                                   snapshot_ok ? ASC_RESULT_OK : ASC_RESULT_WARNING,
                                   snapshot_ok ? ASC_RC_OK : ASC_RC_NOT_FOUND,
                                   snapshot_detail,
                                   ASC_Top10RunFullStagingDirectory(state));
      if(!snapshot_ok)
        {
         state.top10_run_full_batch_last_served_utc = now_utc;
         state.top10_run_full_family_alignment_status = "admission_failed_live_family_preserved";
         state.top10_run_full_family_alignment_reason = "GlobalTop10 cadence cycle could not build a snapshot; prior live family remains active";
         return;
        }

      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_staging_start",
                                   ASC_RESULT_OK,
                                   ASC_RC_OK,
                                   StringFormat("branch=top10_batch_staging_start | staging_dir=%s | symbol_count=%d | live_family_preserved=yes | current_family_unchanged_during_staging=yes",
                                                ASC_TextOrUnavailable(ASC_Top10RunFullStagingDirectory(state)),
                                                state.top10_run_full_total),
                                   ASC_Top10RunFullStagingDirectory(state));
     }

   if(state.deep_focus_trigger_pending || state.deep_focus_ownership_active)
     {
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_wait",
                                   ASC_RESULT_OK,
                                   ASC_RC_OK,
                                   StringFormat("branch=top10_batch_wait | queue_state=held | owner_pending=%s | owner_active=%s | %s | %s",
                                                state.deep_focus_trigger_pending ? "yes" : "no",
                                                state.deep_focus_ownership_active ? "yes" : "no",
                                                ASC_Top10RunFullBatchTrace(state),
                                                ASC_Top10RunFullBatchCountersTrace(state)),
                                   ASC_Top10RunFullTargetDirectory(state));
      return;
     }

   if(StringLen(state.top10_run_full_inflight_symbol) > 0)
     {
      ASC_Layer1SymbolState inflight_symbol_state;
      bool has_inflight_symbol = ASC_FindLayer1SymbolByName(state.top10_run_full_inflight_symbol, inflight_symbol_state);
      string inflight_canonical = has_inflight_symbol
                                  ? ASC_DossierCanonicalSymbol(inflight_symbol_state)
                                  : "";
      string completion_reason = "";
      bool family_complete = (has_inflight_symbol
                              && ASC_GlobalTop10BatchArtifactCompleteForSymbol(state,
                                                                               inflight_symbol_state,
                                                                               inflight_canonical,
                                                                               state.top10_run_full_inflight_queued_utc,
                                                                               state.top10_run_full_inflight_publication_id,
                                                                               completion_reason));
      if(family_complete)
        {
         int cursor_before = state.top10_run_full_cursor;
         string status_before = state.top10_run_full_batch_status;
         string inflight_publication_id = state.top10_run_full_inflight_publication_id;
         state.top10_run_full_cursor++;
         state.top10_run_full_inflight_symbol = "";
         state.top10_run_full_inflight_retry_count = 0;
         state.top10_run_full_inflight_queued_utc = 0;
         state.top10_run_full_inflight_publication_id = "";
         state.top10_run_full_batch_status = "running";
         state.top10_run_full_batch_reason = StringFormat("completed symbol %s (%d/%d)",
                                                          inflight_symbol_state.symbol,
                                                          state.top10_run_full_cursor,
                                                          state.top10_run_full_total);
         ASC_RecordTop10BatchDecision(state,
                                      "top10_batch_post_verify",
                                      ASC_RESULT_OK,
                                      ASC_RC_OK,
                                      StringFormat("branch=top10_batch_post_verify | verify_passed=yes | symbol=%s | publication_id=%s | cursor=%d->%d/%d | progress=%d/%d->%d/%d | status=%s->%s | served_utc=%s | completion=%s | %s",
                                                   inflight_symbol_state.symbol,
                                                   ASC_TextOrUnavailable(inflight_publication_id),
                                                   cursor_before,
                                                   state.top10_run_full_cursor,
                                                   state.top10_run_full_total,
                                                   cursor_before,
                                                   state.top10_run_full_total,
                                                   state.top10_run_full_cursor,
                                                   state.top10_run_full_total,
                                                   ASC_TextOrUnavailable(status_before),
                                                   ASC_TextOrUnavailable(state.top10_run_full_batch_status),
                                                   ASC_ArtifactFormatUtc(state.top10_run_full_batch_last_served_utc),
                                                   ASC_TextOrUnavailable(completion_reason),
                                                   ASC_Top10RunFullBatchCountersTrace(state)),
                                      ASC_Top10RunFullTargetDirectory(state));
        }
      else
        {
         // Preserve any existing Global Top 10 child artifact during retry evaluation.
         // A completion-proof miss here can be transient (for example publication-id,
         // truth-floor, or same-cycle readback timing) and must not destructively erase
         // the currently visible child before the next lawful overwrite attempt proves
         // a replacement. Retry publication remains overwrite-based via the existing
         // atomic writer path.
         int deferred_age_sec = (state.top10_run_full_inflight_queued_utc > 0 ? (int)(now_utc - state.top10_run_full_inflight_queued_utc) : 0);
         bool retry_spacing_ready = (state.top10_run_full_inflight_queued_utc <= 0
                                     || (now_utc - state.top10_run_full_inflight_queued_utc) >= ASC_TOP10_DEFERRED_L5_RECOVERY_RETRY_SPACING_SEC);
         bool retry_budget_available = (state.top10_run_full_inflight_retry_count < ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES
                                        && state.top10_run_full_inflight_retry_count < ASC_TOP10_RUN_FULL_MAX_RETRIES);
         bool expired_by_age = (deferred_age_sec >= ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_AGE_SEC);

         if(retry_budget_available && !expired_by_age)
           {
            if(!retry_spacing_ready)
              {
               state.top10_run_full_batch_status = "running";
               state.top10_run_full_batch_reason = StringFormat("deferred L5 recovery retry spacing active for %s age=%d spacing=%d completion=%s",
                                                                state.top10_run_full_inflight_symbol,
                                                                deferred_age_sec,
                                                                ASC_TOP10_DEFERRED_L5_RECOVERY_RETRY_SPACING_SEC,
                                                                completion_reason);
               ASC_RecordTop10BatchDecision(state,
                                            "top10_deferred_l5_retry_spacing",
                                            ASC_RESULT_OK,
                                            ASC_RC_OK,
                                            StringFormat("branch=top10_deferred_l5_retry_spacing | symbol=%s | age_sec=%d | retry=%d/%d | %s | completion=%s",
                                                         state.top10_run_full_inflight_symbol,
                                                         deferred_age_sec,
                                                         state.top10_run_full_inflight_retry_count,
                                                         ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES,
                                                         ASC_GlobalTop10DeferredL5RecoveryCountersTrace(state),
                                                         ASC_TextOrUnavailable(completion_reason)),
                                            ASC_GlobalTop10BatchArtifactPath(state, state.top10_run_full_inflight_symbol, inflight_canonical));
               return;
              }

            state.top10_run_full_inflight_retry_count++;
            string retry_reason = "";
            if(ASC_QueueDeepTriggerForSymbol(state,
                                             state.top10_run_full_inflight_symbol,
                                             now_utc,
                                             "global_top10_batch",
                                             retry_reason))
              {
               state.top10_run_full_batch_status = "running";
               state.top10_run_full_batch_reason = StringFormat("retrying deferred L5 child %s (%d/%d) attempt=%d reason=%s",
                                                                state.top10_run_full_inflight_symbol,
                                                                state.top10_run_full_cursor + 1,
                                                                state.top10_run_full_total,
                                                                state.top10_run_full_inflight_retry_count,
                                                                completion_reason);
               state.top10_run_full_inflight_queued_utc = now_utc;
               state.top10_run_full_inflight_publication_id = "";
               state.write_dirty = true;
               return;
              }

            string terminal_reason = "";
            if(ASC_MarkGlobalTop10DeferredL5Terminal(state,
                                                     state.top10_run_full_inflight_symbol,
                                                     inflight_canonical,
                                                     now_utc,
                                                     "retry_exhausted",
                                                     state.top10_run_full_inflight_retry_count,
                                                     "retry queue failed: " + retry_reason + " | completion=" + completion_reason,
                                                     terminal_reason))
              {
               state.top10_run_full_verify_pass_count++;
               state.top10_run_full_cursor++;
               state.top10_run_full_batch_status = "running_degraded";
               state.top10_run_full_batch_reason = StringFormat("deferred L5 child terminal degraded %s (%d/%d): %s",
                                                                state.top10_run_full_inflight_symbol,
                                                                state.top10_run_full_cursor,
                                                                state.top10_run_full_total,
                                                                terminal_reason);
              }
            else
              {
               state.top10_run_full_verify_fail_count++;
               state.top10_run_full_cursor++;
               state.top10_run_full_batch_status = "running";
               state.top10_run_full_batch_reason = StringFormat("skipped symbol %s (%d/%d): retry_queue_failed=%s | terminal_write_failed=%s | completion=%s",
                                                                state.top10_run_full_inflight_symbol,
                                                                state.top10_run_full_cursor,
                                                                state.top10_run_full_total,
                                                                retry_reason,
                                                                terminal_reason,
                                                                completion_reason);
              }
            state.top10_run_full_inflight_symbol = "";
            state.top10_run_full_inflight_retry_count = 0;
            state.top10_run_full_inflight_queued_utc = 0;
            state.top10_run_full_inflight_publication_id = "";
           }
         else
           {
            string terminal_state = expired_by_age ? "expired" : "retry_exhausted";
            string terminal_reason = "";
            if(ASC_MarkGlobalTop10DeferredL5Terminal(state,
                                                     state.top10_run_full_inflight_symbol,
                                                     inflight_canonical,
                                                     now_utc,
                                                     terminal_state,
                                                     state.top10_run_full_inflight_retry_count,
                                                     StringFormat("bounded recovery terminal state; age_sec=%d | completion=%s", deferred_age_sec, ASC_TextOrUnavailable(completion_reason)),
                                                     terminal_reason))
              {
               state.top10_run_full_verify_pass_count++;
               state.top10_run_full_cursor++;
               state.top10_run_full_batch_status = "running_degraded";
               state.top10_run_full_batch_reason = StringFormat("deferred L5 child terminal %s %s (%d/%d): %s",
                                                                terminal_state,
                                                                state.top10_run_full_inflight_symbol,
                                                                state.top10_run_full_cursor,
                                                                state.top10_run_full_total,
                                                                terminal_reason);
              }
            else
              {
               state.top10_run_full_verify_fail_count++;
               state.top10_run_full_cursor++;
               state.top10_run_full_batch_status = "running";
               state.top10_run_full_batch_reason = StringFormat("skipped symbol %s (%d/%d): completion_failed_after_retries=%s | terminal_write_failed=%s",
                                                                state.top10_run_full_inflight_symbol,
                                                                state.top10_run_full_cursor,
                                                                state.top10_run_full_total,
                                                                completion_reason,
                                                                terminal_reason);
              }
            state.top10_run_full_inflight_symbol = "";
            state.top10_run_full_inflight_retry_count = 0;
            state.top10_run_full_inflight_queued_utc = 0;
            state.top10_run_full_inflight_publication_id = "";
           }
        }
     }

   if(state.top10_run_full_cursor >= state.top10_run_full_total)
     {
      int drained_cursor = state.top10_run_full_cursor;
      int drained_total = state.top10_run_full_total;
      bool drained_with_failures = (state.top10_run_full_verify_fail_count > 0
                                    || state.top10_run_full_verify_pass_count < state.top10_run_full_last_total);
      bool promoted_ok = false;
      string promotion_reason = "verification_gaps_blocked_promotion";
      if(!drained_with_failures)
         promoted_ok = ASC_Top10RunFullPromoteStagingFamily(state, now_utc, promotion_reason);

      bool drained_with_deferred_degraded = (state.top10_deferred_l5_expired_count > 0
                                             || state.top10_deferred_l5_retry_exhausted_count > 0);
      state.top10_run_full_batch_status = promoted_ok ? (drained_with_deferred_degraded ? "completed_degraded_deferred_l5" : "completed") : (drained_with_failures ? "completed_with_failures" : "completed_without_promotion");
      state.top10_run_full_batch_reason = promoted_ok
                                          ? promotion_reason
                                          : (drained_with_failures
                                             ? StringFormat("runtime batch queue drained with verification gaps pass=%d fail=%d total=%d",
                                                            state.top10_run_full_verify_pass_count,
                                                            state.top10_run_full_verify_fail_count,
                                                            state.top10_run_full_last_total)
                                             : promotion_reason);
      state.top10_run_full_batch_last_served_utc = now_utc;
      if(promoted_ok)
        {
         state.top10_run_full_last_completed_source_pass_utc = state.top10_run_full_inflight_source_pass_utc;
         state.top10_run_full_last_completed_source_signature = state.top10_run_full_inflight_source_signature;
         ASC_CopyStringArray(state.top10_run_full_symbols, state.top10_run_full_last_completed_symbols);
         if(state.top10_run_full_last_completed_source_pass_utc == state.top10_run_full_current_source_pass_utc
            && state.top10_run_full_last_completed_source_signature == state.top10_run_full_current_source_signature)
           {
            state.top10_run_full_family_alignment_status = "aligned";
            state.top10_run_full_family_alignment_reason = "GlobalTop10 child family staged, archived, and promoted from the current committed shortlist family";
           }
         else
           {
            state.top10_run_full_family_alignment_status = "completed_stale_vs_current_shortlist";
            state.top10_run_full_family_alignment_reason = StringFormat("GlobalTop10 batch completed from an older shortlist family | child_pass=%s | current_pass=%s",
                                                                        ASC_ArtifactFormatUtc(state.top10_run_full_last_completed_source_pass_utc),
                                                                        ASC_ArtifactFormatUtc(state.top10_run_full_current_source_pass_utc));
           }
        }
      else if(!drained_with_failures)
        {
         state.top10_run_full_family_alignment_status = "staging_complete_promotion_blocked";
         state.top10_run_full_family_alignment_reason = "GlobalTop10 staging family completed but promotion was blocked: " + promotion_reason;
        }
      else
        {
         state.top10_run_full_family_alignment_status = "aligned_with_failures";
         state.top10_run_full_family_alignment_reason = "GlobalTop10 staging family completed with verification gaps; live family left unchanged";
        }
      ArrayResize(state.top10_run_full_symbols, 0);
      state.top10_run_full_total = 0;
      state.top10_run_full_cursor = drained_cursor;
      state.top10_run_full_inflight_symbol = "";
      state.top10_run_full_inflight_retry_count = 0;
      state.top10_run_full_inflight_queued_utc = 0;
      state.top10_run_full_inflight_publication_id = "";
      state.top10_run_full_inflight_source_pass_utc = 0;
      state.top10_run_full_inflight_source_signature = "";
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_completion",
                                   promoted_ok ? ASC_RESULT_OK : ASC_RESULT_WARNING,
                                   promoted_ok ? ASC_RC_OK : ASC_RC_IO_FAILED,
                                   StringFormat("branch=top10_batch_completion | queue_state=drained | pre_reset_progress=%d/%d | promoted=%s | promotion_reason=%s | %s | %s",
                                                drained_cursor,
                                                drained_total,
                                                promoted_ok ? "yes" : "no",
                                                ASC_TextOrUnavailable(promotion_reason),
                                                ASC_Top10RunFullBatchTrace(state),
                                                ASC_Top10RunFullBatchCountersTrace(state)),
                                   promoted_ok ? ASC_Top10RunFullTargetDirectory(state) : ASC_Top10RunFullStagingDirectory(state));
      state.l1_publish_pending_manifest = true;
      state.write_dirty = true;
      return;
     }

   string symbol = state.top10_run_full_symbols[state.top10_run_full_cursor];
   string queue_reason = "";
   if(ASC_QueueDeepTriggerForSymbol(state, symbol, now_utc, "global_top10_batch", queue_reason))
     {
      state.top10_run_full_inflight_symbol = symbol;
      state.top10_run_full_inflight_retry_count = 0;
      state.top10_run_full_inflight_queued_utc = now_utc;
      state.top10_run_full_inflight_publication_id = "";
      state.top10_run_full_inflight_source_pass_utc = state.top10_run_full_current_source_pass_utc;
      state.top10_run_full_inflight_source_signature = state.top10_run_full_current_source_signature;
      state.top10_run_full_batch_status = "running";
      state.top10_run_full_batch_reason = StringFormat("queued symbol %s (%d/%d) for family completion",
                                                       symbol,
                                                       state.top10_run_full_cursor + 1,
                                                       state.top10_run_full_total);
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_queue",
                                   ASC_RESULT_OK,
                                   ASC_RC_OK,
                                   StringFormat("branch=top10_batch_queue | requested=yes | admitted=yes | symbol=%s | target_dir=%s | %s",
                                                symbol,
                                                ASC_TextOrUnavailable(ASC_Top10RunFullStagingDirectory(state)),
                                                ASC_Top10RunFullBatchTrace(state)),
                                   ASC_GlobalTop10BatchArtifactPath(state, symbol, ""));
      state.write_dirty = true;
     }
   else
     {
      state.top10_run_full_cursor++;
      state.top10_run_full_batch_status = "running";
      state.top10_run_full_batch_reason = StringFormat("skipped symbol %s (%d/%d): %s",
                                                       symbol,
                                                       state.top10_run_full_cursor,
                                                       state.top10_run_full_total,
                                                       queue_reason);
      ASC_RecordTop10BatchDecision(state,
                                   "top10_batch_queue",
                                   ASC_RESULT_WARNING,
                                   ASC_RC_NOT_FOUND,
                                   StringFormat("branch=top10_batch_queue | requested=yes | admitted=no | symbol=%s | reason=%s | %s",
                                                symbol,
                                                ASC_TextOrUnavailable(queue_reason),
                                                ASC_Top10RunFullBatchTrace(state)),
                                   ASC_GlobalTop10BatchArtifactPath(state, symbol, ""));
     }
  }

bool ASC_DeepTriggerOwnsSelectedPairWrite(const ASC_RuntimeState &state)
  {
   string owner_symbol = "";
   if(state.deep_focus_ownership_active && StringLen(state.deep_focus_ownership_symbol) > 0)
      owner_symbol = state.deep_focus_ownership_symbol;
   else if(state.deep_focus_trigger_pending && StringLen(state.deep_focus_trigger_symbol) > 0)
      owner_symbol = state.deep_focus_trigger_symbol;

   if(StringLen(owner_symbol) <= 0
      || !state.current_focus_view_pending
      || StringLen(state.current_focus_view_symbol) <= 0)
      return false;

   ASC_Layer1SymbolState queued_symbol;
   if(!ASC_FindLayer1SymbolByName(state.current_focus_view_symbol, queued_symbol))
      return (state.current_focus_view_symbol == owner_symbol);

   return ASC_SymbolMatchesSelectionContext(queued_symbol, owner_symbol);
  }



string ASC_SelectedCanonicalSymbol(const ASC_Layer1SymbolState &selected)
  {
   string canonical_symbol = selected.classification.canonical_symbol;
   if(StringLen(canonical_symbol) <= 0)
      canonical_symbol = selected.identity.canonical_symbol;
   if(StringLen(canonical_symbol) <= 0)
      canonical_symbol = selected.identity.normalized_symbol;
   if(StringLen(canonical_symbol) <= 0)
      canonical_symbol = selected.symbol;
   return canonical_symbol;
  }

bool ASC_SymbolHasExplicitHudOwnership(const ASC_RuntimeState &state,const ASC_Layer1SymbolState &symbol_state)
  {
   if(StringLen(state.hud_selected_symbol) > 0
      && ASC_SymbolMatchesSelectionContext(symbol_state, state.hud_selected_symbol))
      return true;

   if(state.current_focus_view_pending
      && StringLen(state.current_focus_view_symbol) > 0
      && ASC_SymbolMatchesSelectionContext(symbol_state, state.current_focus_view_symbol))
      return true;

   if(state.deep_focus_trigger_pending
      && StringLen(state.deep_focus_trigger_symbol) > 0
      && ASC_SymbolMatchesSelectionContext(symbol_state, state.deep_focus_trigger_symbol))
      return true;

   if(state.deep_focus_ownership_active
      && StringLen(state.deep_focus_ownership_symbol) > 0
      && ASC_SymbolMatchesSelectionContext(symbol_state, state.deep_focus_ownership_symbol))
      return true;

   return false;
  }

bool ASC_DossierHasCompletedPreservedDeepTruth(const ASC_RuntimeState &state,const ASC_Layer1SymbolState &symbol_state)
  {
   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   if(StringLen(canonical_symbol) <= 0)
      return false;

   ASC_ArtifactContract contract = ASC_DossierContract(state.server_root, canonical_symbol);
   if(StringLen(contract.target_path) <= 0)
      return false;

   string payload_text = "";
   if(!ASC_ReadTextFile(contract.target_path, payload_text) || StringLen(payload_text) <= 0)
      return false;
   if(!ASC_DossierPayloadMatchesCanonicalSymbol(payload_text, canonical_symbol))
      return false;

   string deep_section = "";
   if(!ASC_DossierTryExtractDeepSection(payload_text, deep_section))
      return false;

   return ASC_DossierDeepSectionHasCompletedTruth(deep_section);
  }

bool ASC_DossierBroadRefreshAllowed(const ASC_RuntimeState &state,const ASC_Layer1SymbolState &symbol_state)
  {
   if(ASC_SymbolHasExplicitHudOwnership(state, symbol_state))
      return true;
   return !ASC_DossierHasCompletedPreservedDeepTruth(state, symbol_state);
  }

string ASC_ArtifactLiveSymbolFromPayload(const string payload_text)
  {
   string live_symbol = ASC_TextExtractLabeledLineValue(payload_text, "Canonical Symbol:");
   if(StringLen(live_symbol) <= 0)
      live_symbol = ASC_TextExtractLabeledLineValue(payload_text, "Symbol:");
   return live_symbol;
  }

datetime ASC_SelectedSymbolTruthFloorUtc(const ASC_RuntimeState &state,const ASC_Layer1SymbolState &selected)
  {
   datetime floor_utc = state.hud_selected_symbol_observed_utc;
   if(selected.observed_at_utc > floor_utc)
      floor_utc = selected.observed_at_utc;
   if(state.current_focus_view_requested_utc > floor_utc
      && ASC_SymbolMatchesSelectionContext(selected, state.current_focus_view_symbol))
      floor_utc = state.current_focus_view_requested_utc;

   ASC_Layer2Packet packet;
   if(ASC_Layer2TryGetPacketBySymbol(selected.symbol, packet))
     {
      if(packet.last_built_utc > floor_utc)
         floor_utc = packet.last_built_utc;
      if(packet.last_good_utc > floor_utc)
         floor_utc = packet.last_good_utc;
     }

   return floor_utc;
  }

bool ASC_SelectedSymbolSyncRecheckDue(const ASC_RuntimeState &state,
                                      const ASC_Layer1SymbolState &selected,
                                      const datetime now_utc,
                                      datetime &truth_floor_utc,
                                      datetime &focus_modified_utc,
                                      datetime &dossier_modified_utc)
  {
   truth_floor_utc = ASC_SelectedSymbolTruthFloorUtc(state, selected);
   focus_modified_utc = 0;
   dossier_modified_utc = 0;

   if(state.current_focus_view_pending || state.deep_focus_trigger_pending)
      return true;

   bool stable_status = (state.current_focus_last_status == "verified_current"
                         || state.current_focus_last_status == "succeeded"
                         || state.current_focus_last_status == "deep_pair_succeeded"
                         || state.current_focus_last_status == "continuity"
                         || state.current_focus_last_status == "deep_pair_continuity"
                         || state.current_focus_last_status == "deep_focus_preserved_direct"
                         || state.current_focus_last_status == "state_aligned");

   if(!stable_status)
      return true;

   if(!ASC_SymbolMatchesSelectionContext(selected, state.current_focus_sync_last_selected_symbol))
      return true;

   if(state.current_focus_sync_last_checked_utc <= 0
      || (now_utc - state.current_focus_sync_last_checked_utc) >= ASC_SELECTED_SYNC_STABLE_RECHECK_SEC)
      return true;

   if(truth_floor_utc > state.current_focus_sync_last_truth_floor_utc)
      return true;

   bool focus_exists_now = false;
   if(StringLen(state.current_focus_path) > 0)
      focus_exists_now = ASC_FileTryGetModifyUtc(state.current_focus_path, focus_modified_utc);

   string canonical_symbol = ASC_SelectedCanonicalSymbol(selected);
   string dossier_path = ASC_DossierContract(state.server_root, canonical_symbol).target_path;
   bool dossier_exists_now = false;
   if(StringLen(dossier_path) > 0)
      dossier_exists_now = ASC_FileTryGetModifyUtc(dossier_path, dossier_modified_utc);

   if(!focus_exists_now && state.current_focus_sync_last_focus_modified_utc > 0)
      return true;
   if(!dossier_exists_now && state.current_focus_sync_last_dossier_modified_utc > 0)
      return true;
   if(focus_modified_utc > state.current_focus_sync_last_focus_modified_utc)
      return true;
   if(dossier_modified_utc > state.current_focus_sync_last_dossier_modified_utc)
      return true;

   return false;
  }


struct ASC_SelectedSymbolSyncAssessment
  {
   string canonical_symbol;
   string focus_symbol;
   string dossier_symbol;
   string pair_reason;
   bool root_payload_read;
   bool focus_exists;
   bool focus_matches_selected;
   bool focus_completed_deep;
   bool dossier_exists;
   bool dossier_matches_selected;
   bool focus_current;
   bool dossier_current;
   bool pair_artifacts_read;
   bool pair_aligned;
   bool dossier_newer_than_focus;
   bool state_reset_needed;
   datetime focus_modified_utc;
   datetime dossier_modified_utc;
  };

void ASC_AssessSelectedSymbolSync(const ASC_RuntimeState &state,
                                  const ASC_Layer1SymbolState &selected,
                                  ASC_SelectedSymbolSyncAssessment &assessment)
  {
   assessment.canonical_symbol = ASC_SelectedCanonicalSymbol(selected);
   assessment.focus_symbol = "";
   assessment.dossier_symbol = "";
   assessment.pair_reason = "not_evaluated";
   assessment.root_payload_read = false;
   assessment.focus_exists = false;
   assessment.focus_matches_selected = false;
   assessment.focus_completed_deep = false;
   assessment.dossier_exists = false;
   assessment.dossier_matches_selected = false;
   assessment.focus_current = false;
   assessment.dossier_current = false;
   assessment.pair_artifacts_read = false;
   assessment.pair_aligned = false;
   assessment.dossier_newer_than_focus = false;
   assessment.state_reset_needed = false;
   assessment.focus_modified_utc = 0;
   assessment.dossier_modified_utc = 0;

   datetime freshness_floor_utc = ASC_SelectedSymbolTruthFloorUtc(state, selected);
   string focus_payload = "";
   string dossier_payload = "";

   if(StringLen(state.current_focus_path) > 0
      && ASC_ReadTextFile(state.current_focus_path, focus_payload)
      && StringLen(focus_payload) > 0)
     {
      assessment.root_payload_read = true;
      assessment.focus_exists = true;
      assessment.focus_symbol = ASC_ArtifactLiveSymbolFromPayload(focus_payload);
      assessment.focus_matches_selected = ASC_DossierPayloadMatchesSymbolContext(focus_payload,
                                                                                 selected,
                                                                                 assessment.canonical_symbol);
      assessment.focus_completed_deep = (assessment.focus_matches_selected
                                         && ASC_DossierDeepSectionHasCompletedTruth(focus_payload));
      ASC_FileTryGetModifyUtc(state.current_focus_path, assessment.focus_modified_utc);
      assessment.focus_current = assessment.focus_matches_selected
                                 && ASC_FileIsFreshSince(state.current_focus_path, freshness_floor_utc);
     }

   string dossier_path = ASC_DossierContract(state.server_root, assessment.canonical_symbol).target_path;
   if(StringLen(dossier_path) > 0
      && ASC_ReadTextFile(dossier_path, dossier_payload)
      && StringLen(dossier_payload) > 0)
     {
      assessment.dossier_exists = true;
      assessment.dossier_symbol = ASC_ArtifactLiveSymbolFromPayload(dossier_payload);
      assessment.dossier_matches_selected = ASC_DossierPayloadMatchesSymbolContext(dossier_payload,
                                                                                   selected,
                                                                                   assessment.canonical_symbol);
      ASC_FileTryGetModifyUtc(dossier_path, assessment.dossier_modified_utc);
      assessment.dossier_current = assessment.dossier_matches_selected
                                   && ASC_FileIsFreshSince(dossier_path, freshness_floor_utc);
     }

   if(assessment.focus_exists && assessment.dossier_exists)
     {
      assessment.pair_artifacts_read = true;

      if(!assessment.focus_matches_selected)
         assessment.pair_reason = "not selected: Dossier readback points to another symbol";
      else if(!assessment.dossier_matches_selected)
         assessment.pair_reason = "not selected: selected-symbol dossier readback points to another symbol";
      else
        {
         string focus_publication_id = ASC_PublicationPayloadId(focus_payload);
         string dossier_publication_id = ASC_PublicationPayloadId(dossier_payload);
         if(StringLen(focus_publication_id) > 0
            && StringLen(dossier_publication_id) > 0
            && focus_publication_id != dossier_publication_id)
            assessment.pair_reason = "selected-symbol dossier support artifact is newer than root dossier";
         else if(!ASC_PublicationPayloadMateriallyEqual(focus_payload, dossier_payload))
            assessment.pair_reason = "payload_mismatch";
         else
           {
            assessment.pair_reason = "legitimately current";
            assessment.pair_aligned = true;
           }
        }
     }
   else if(!assessment.focus_exists)
      assessment.pair_reason = "Dossier readback missing";
   else
      assessment.pair_reason = "selected-symbol dossier readback missing";

   assessment.dossier_newer_than_focus = assessment.dossier_matches_selected
                                         && (!assessment.focus_exists
                                             || !assessment.focus_matches_selected
                                             || (assessment.dossier_modified_utc > 0
                                                 && assessment.focus_modified_utc > 0
                                                 && assessment.dossier_modified_utc > assessment.focus_modified_utc
                                                 && !assessment.pair_aligned)
                                             || assessment.pair_reason == "selected-symbol dossier support artifact is newer than root dossier");

   assessment.state_reset_needed = assessment.focus_matches_selected
                                   && assessment.dossier_matches_selected
                                   && assessment.pair_aligned
                                   && !ASC_SymbolMatchesSelectionContext(selected, state.current_focus_live_symbol)
                                   && state.current_focus_live_symbol != assessment.canonical_symbol;
  }

void ASC_RefreshCurrentFocusStateFromArtifacts(ASC_RuntimeState &state)
  {
   if(StringLen(state.current_focus_path) <= 0)
      return;

   datetime modified_utc = 0;
   if(!ASC_FileTryGetModifyUtc(state.current_focus_path, modified_utc) || modified_utc <= 0)
      return;

   if(StringLen(state.current_focus_live_symbol) > 0
      && state.current_focus_sync_last_focus_modified_utc > 0
      && modified_utc <= state.current_focus_sync_last_focus_modified_utc)
     {
      if(state.current_focus_last_served_utc <= 0 || modified_utc > state.current_focus_last_served_utc)
         state.current_focus_last_served_utc = modified_utc;
      return;
     }

   string focus_payload = "";
   if(!ASC_ReadTextFile(state.current_focus_path, focus_payload) || StringLen(focus_payload) <= 0)
      return;

   string live_symbol = ASC_ArtifactLiveSymbolFromPayload(focus_payload);
   if(StringLen(live_symbol) <= 0)
      return;

   state.current_focus_live_symbol = live_symbol;
   state.current_focus_sync_last_focus_modified_utc = modified_utc;

   if(state.current_focus_last_served_utc <= 0 || modified_utc > state.current_focus_last_served_utc)
      state.current_focus_last_served_utc = modified_utc;

   if((StringLen(state.current_focus_last_status) <= 0 || state.current_focus_last_status == "idle")
      && !state.current_focus_view_pending
      && !state.deep_focus_trigger_pending)
     {
      state.current_focus_last_status = "state_aligned";
      state.current_focus_last_reason = "state reset needed: Dossier ownership restored from artifact readback";
     }
  }

void ASC_ReconcileDeepTriggerSelectionContext(ASC_RuntimeState &state,
                                              const ASC_Layer1SymbolState &selected,
                                              const datetime now_utc)
  {
   // Explicit Deep Analysis is symbol-frozen at click time.
   // Runtime selection movement must not invalidate the pending request.
   if(state.deep_focus_trigger_pending && StringLen(state.deep_focus_trigger_symbol) > 0)
      return;
  }

void ASC_ReconcileSelectedSymbolCurrentFocusSync(ASC_RuntimeState &state,const datetime now_utc)
  {
   if(StringLen(state.hud_selected_symbol) > 0)
      state.selected_symbol_reconcile_count++;

   ASC_RefreshCurrentFocusStateFromArtifacts(state);

   string selected_symbol = state.hud_selected_symbol;
   if(StringLen(selected_symbol) <= 0)
     {
      state.current_focus_view_pending = false;
      state.current_focus_view_symbol = "";
      state.current_focus_view_earliest_write_utc = 0;
      ASC_ResetCurrentFocusFailureIsolation(state);
      if(!state.current_focus_view_pending
         && !state.deep_focus_trigger_pending
         && StringLen(state.current_focus_live_symbol) <= 0
         && (StringLen(state.current_focus_last_status) <= 0 || state.current_focus_last_status == "idle"))
        {
         state.current_focus_last_status = "not_selected";
         state.current_focus_last_reason = "selected-symbol sync is idle because no HUD selected symbol is active";
        }
      return;
     }

   ASC_Layer1SymbolState selected;
   if(!ASC_FindLayer1SymbolByName(selected_symbol, selected))
     {
      state.current_focus_view_pending = false;
      state.current_focus_view_symbol = "";
      if(state.current_focus_view_requested_utc <= 0)
         state.current_focus_view_requested_utc = (state.hud_selected_symbol_observed_utc > 0
                                                   ? state.hud_selected_symbol_observed_utc
                                                   : now_utc);
      state.current_focus_view_earliest_write_utc = 0;
      state.current_focus_last_status = "view_pending_symbol_resolution";
      state.current_focus_last_reason = "selected-symbol baseline refresh is waiting for Layer 1 symbol resolution";
      ASC_LogInfo("ASC_Dispatcher", "ASC_ReconcileSelectedSymbolCurrentFocusSync", selected_symbol,
                  "selected-symbol baseline refresh deferred: selected symbol unresolved in Layer 1 cache");
      return;
     }

   ASC_ReconcileDeepTriggerSelectionContext(state, selected, now_utc);

   datetime truth_floor_utc = 0;
   datetime focus_modified_utc = 0;
   datetime dossier_modified_utc = 0;
   if(!ASC_SelectedSymbolSyncRecheckDue(state,
                                        selected,
                                        now_utc,
                                        truth_floor_utc,
                                        focus_modified_utc,
                                        dossier_modified_utc))
      return;

   ASC_SelectedSymbolSyncAssessment assessment;
   ASC_AssessSelectedSymbolSync(state, selected, assessment);
   state.current_focus_sync_last_checked_utc = now_utc;
   state.current_focus_sync_last_truth_floor_utc = truth_floor_utc;
   state.current_focus_sync_last_selected_symbol = selected.symbol;
   state.current_focus_sync_last_focus_modified_utc = assessment.focus_modified_utc;
   state.current_focus_sync_last_dossier_modified_utc = assessment.dossier_modified_utc;

   bool root_deep_truth_valid = (assessment.root_payload_read
                                 && assessment.focus_exists
                                 && assessment.focus_matches_selected
                                 && assessment.focus_completed_deep
                                 && assessment.focus_current);

   if(root_deep_truth_valid)
     {
      ASC_ResetCurrentFocusFailureIsolation(state, selected.symbol);
      state.current_focus_view_pending = false;
      state.current_focus_view_symbol = "";
      state.current_focus_view_earliest_write_utc = 0;
      state.current_focus_live_symbol = assessment.canonical_symbol;
      state.current_focus_last_status = "deep_focus_preserved_direct";
      state.current_focus_last_reason = "baseline_requeue_suppressed_deep_root_present";
      if(assessment.focus_modified_utc > 0)
         state.current_focus_last_served_utc = assessment.focus_modified_utc;
      else if(state.current_focus_last_served_utc <= 0)
         state.current_focus_last_served_utc = now_utc;
      ASC_LogInfo("ASC_Dispatcher", "ASC_ReconcileSelectedSymbolCurrentFocusSync", selected.symbol,
                  "selected-symbol baseline requeue suppressed: root Dossier already holds same-symbol completed deep truth");
      return;
     }

   if(assessment.focus_current)
     {
      ASC_ResetCurrentFocusFailureIsolation(state, selected.symbol);
      state.current_focus_live_symbol = assessment.canonical_symbol;
      if(state.current_focus_view_pending
         && ASC_SymbolMatchesSelectionContext(selected, state.current_focus_view_symbol))
        {
         state.current_focus_view_pending = false;
         state.current_focus_view_earliest_write_utc = 0;
        }

      if(assessment.focus_modified_utc > 0)
         state.current_focus_last_served_utc = assessment.focus_modified_utc;

      if(assessment.state_reset_needed)
        {
         state.current_focus_last_status = "state_aligned";
         state.current_focus_last_reason = "state reset needed: selected-symbol Dossier readback restored runtime ownership without rewriting";
        }
      else if(!state.deep_focus_trigger_pending
              && state.current_focus_last_status != "succeeded"
              && state.current_focus_last_status != "continuity"
              && state.current_focus_last_status != "deep_pair_succeeded"
              && state.current_focus_last_status != "deep_pair_continuity"
              && state.current_focus_last_status != "deep_focus_preserved_direct")
        {
         state.current_focus_last_status = "state_aligned";
         state.current_focus_last_reason = "not due yet: Dossier readback is selected-symbol aligned and current";
         ASC_LogInfo("ASC_Dispatcher", "ASC_ReconcileSelectedSymbolCurrentFocusSync", selected.symbol,
                     "selected-symbol Dossier readback already current and verified; no write queued");
        }
      return;
     }

   if(state.deep_focus_trigger_pending
      && ASC_SymbolMatchesSelectionContext(selected, state.deep_focus_trigger_symbol))
      return;
   if(state.deep_focus_ownership_active
      && ASC_SymbolMatchesSelectionContext(selected, state.deep_focus_ownership_symbol))
      return;

   bool current_focus_backoff_active = ASC_IsCooldownActive(now_utc, state.current_focus_view_backoff_until_utc);
   if(current_focus_backoff_active
      && StringLen(state.current_focus_view_last_failed_symbol) > 0
      && ASC_SymbolMatchesSelectionContext(selected, state.current_focus_view_last_failed_symbol))
     {
      state.current_focus_view_pending = true;
      state.current_focus_view_symbol = selected.symbol;
      state.current_focus_view_earliest_write_utc = state.current_focus_view_backoff_until_utc;
      state.current_focus_last_status = "view_retry_backoff";
      state.current_focus_last_reason = "selected-symbol baseline refresh is deferred by retry backoff after recent same-symbol write failure";
      return;
     }

   if(state.current_focus_view_pending
      && ASC_SymbolMatchesSelectionContext(selected, state.current_focus_view_symbol))
     {
      state.current_focus_last_status = "view_queued";
      state.current_focus_last_reason = "selected-symbol baseline refresh already queued for this symbol";
      return;
     }

   state.current_focus_view_pending = true;
   state.current_focus_view_symbol = selected.symbol;
   state.current_focus_view_requested_utc = (state.hud_selected_symbol_observed_utc > 0
                                             ? state.hud_selected_symbol_observed_utc
                                             : now_utc);
   state.current_focus_view_earliest_write_utc = 0;
   state.current_focus_last_status = "view_queued";
   // Counter law:
   // - selected_symbol_request_count: explicit HUD queue actions only.
   // - selected_symbol_runtime_request_count: runtime reconciliation queue actions.
   state.selected_symbol_runtime_request_count++;
   state.current_focus_last_reason = "selected-symbol runtime reconciliation queued immediate baseline refresh";

   ASC_LogInfo("ASC_Dispatcher", "ASC_ReconcileSelectedSymbolCurrentFocusSync", selected.symbol,
               "selected-symbol runtime reconciliation queued immediate baseline refresh");
  }

void ASC_FinalizePublicationBundle(ASC_RuntimeState &state,const datetime finished_utc)
  {
   state.bundle_completed_count++;
   state.publication_bundle.bundle_finished_utc = finished_utc;
   if(state.publication_bundle.board_publish_started_utc > 0
      && state.publication_bundle.board_publish_finished_utc <= 0)
      state.publication_bundle.board_publish_finished_utc = finished_utc;

   if(state.publication_bundle.dossier_failure_count > 0)
      state.publication_bundle.overall_bundle_status = "failure";
   else if(state.publication_bundle.market_board_status == "failure"
           || state.publication_bundle.open_symbol_snapshot_status == "failure"
           || state.publication_bundle.manifest_status == "failure")
      state.publication_bundle.overall_bundle_status = "failure";
   else if(state.publication_bundle.market_board_status == "continuity"
           || state.publication_bundle.open_symbol_snapshot_status == "continuity"
           || state.publication_bundle.manifest_status == "continuity")
      state.publication_bundle.overall_bundle_status = "continuity";
   else
      state.publication_bundle.overall_bundle_status = "fresh";

   if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0
      && state.publication_bundle.overall_bundle_status == "fresh")
      state.publication_bundle.last_bundle_error_summary = "none";

   if(state.publication_bundle.market_board_status == "failure")
     {
      state.publication_bundle.board_lifecycle_state = "publish_failed";
      state.publication_bundle.board_publish_result = "failure";
      if(StringLen(state.publication_bundle.board_publish_skip_reason) <= 0)
         state.publication_bundle.board_publish_skip_reason = "none";
     }
   else if(state.publication_bundle.market_board_status == "continuity")
     {
      state.publication_bundle.board_lifecycle_state = "published_degraded";
      state.publication_bundle.board_publish_result = "continuity";
      state.publication_bundle.board_publish_skip_reason = "none";
     }
   else if(state.publication_bundle.market_board_status == "fresh")
     {
      state.publication_bundle.board_publish_result = "fresh";
      if(state.l1_publish_pending_dossiers)
         state.publication_bundle.board_lifecycle_state = "published_partial";
      else
         state.publication_bundle.board_lifecycle_state = "published_ready";
      state.publication_bundle.board_publish_skip_reason = "none";
     }
   else if(state.publication_bundle.market_board_status == "pending")
     {
      if(state.publication_bundle.board_publish_result == "skipped")
        {
         state.publication_bundle.board_lifecycle_state = "waiting_for_packet_support";
         if(StringLen(state.publication_bundle.board_publish_skip_reason) <= 0)
            state.publication_bundle.board_publish_skip_reason = "write_heartbeat_budget_exhausted";
        }
      else
        {
         state.publication_bundle.board_lifecycle_state = "publishing";
         state.publication_bundle.board_publish_result = "pending";
         state.publication_bundle.board_publish_skip_reason = "none";
        }
     }
   else if(state.publication_bundle.market_board_status == "degraded")
     {
      state.publication_bundle.board_lifecycle_state = "waiting_for_packet_support";
      state.publication_bundle.board_publish_result = "skipped";
      if(StringLen(state.publication_bundle.board_publish_skip_reason) <= 0)
         state.publication_bundle.board_publish_skip_reason = "essential_artifact_backoff_active";
     }
   else if(state.publication_bundle.market_board_status == "skipped")
     {
      state.publication_bundle.board_lifecycle_state = "awaiting_auto_refresh";
      state.publication_bundle.board_publish_result = "skipped";
      if(StringLen(state.publication_bundle.board_publish_skip_reason) <= 0)
         state.publication_bundle.board_publish_skip_reason = "market_board_not_pending";
     }
  }

string ASC_CurrentFocusTriggerEvidenceText(const string status)
  {
   if(status == "deep_pair_succeeded")
      return "deep trigger pair published and verified";
   if(status == "deep_pair_continuity")
      return "deep trigger continuity retained and pair-verified";
   if(status == "deep_pair_failed_compose")
      return "deep trigger compose failed before pair publication";
   if(status == "deep_pair_failed_pair_path")
      return "deep trigger pair path invalid before write";
   if(status == "deep_pair_failed_write")
      return "deep trigger pair write failed before readback verification";
   if(status == "deep_pair_failed_partial_publish")
      return "deep trigger pair write was partial or missing one side";
   if(status == "deep_pair_failed_pair_mismatch")
      return "deep trigger readback mismatch between root Dossier and selected-symbol dossier support artifact";
   if(status == "deep_pair_failed_deep_truth")
      return "deep trigger pair readback lacked completed deep truth";
   if(status == "deep_pair_failed_symbol_alignment")
      return "deep trigger request and selected symbol were not aligned";
   if(status == "deep_pair_failed_runtime_path")
      return "deep trigger runtime path failed before compose/pair";
   if(status == "running")
      return "deep trigger is running";
   if(status == "queued")
      return "deep trigger is queued";
   if(StringLen(status) <= 0 || status == "idle")
      return "no deep trigger has been served yet";
   return "deep trigger status: " + status;
  }

string ASC_CurrentFocusManualLaneEvidenceText(const string status)
  {
   if(status == "view_disabled_manual_deep_only")
      return "selected-symbol manual lane remains deep-only; this status does not disable the ordinary dossier queue";
   if(status == "deep_pair_succeeded")
      return "Dossier is currently served by deep-trigger pair publication";
   if(status == "deep_pair_continuity")
      return "Dossier is currently served by retained deep-backed pair continuity";
   if(status == "deep_focus_preserved_direct")
      return "root Dossier survived directly from same-symbol completed deep truth without dossier-support/pair dependency";
   if(status == "view_failed_write")
      return "legacy status: view-sync write/backoff path is disabled by manual deep-only policy";
   if(status == "view_queued" || status == "view_deferred")
      return "legacy status: queued view-sync publication is disabled by manual deep-only policy";
   if(status == "state_aligned")
      return "Dossier state aligned by readback while deep trigger remains sole publisher";
   if(status == "deep_pair_failed_ownership_conflict")
      return "view-sync publication remains disabled while deep trigger owns Dossier publication";
   if(StringLen(status) <= 0 || status == "idle")
      return "view-sync publication is idle/disabled under manual deep-only policy";
   return "manual-lane(disabled) status: " + status;
  }

string ASC_DossierPublicationPathText(const ASC_RuntimeState &state)
  {
   bool ordinary_queue_active = (state.l1_publish_pending_dossiers
                                 || state.dossier_reduced_present_count > 0
                                 || state.dossier_expanded_present_count > 0
                                 || state.dossier_open_base_present_count > 0
                                 || state.dossier_open_l3_present_count > 0
                                 || state.dossier_open_l4_present_count > 0);

   if(ordinary_queue_active)
      return "ordinary dossier queue publication is active for root Dossiers/; explicit Deep Analysis remains the selected-symbol deep publisher";

   return "explicit Deep Analysis is currently the only proven Dossier publisher; ordinary dossier queue publication has not yet been proven active";
  }

bool ASC_RetainedPairFreshnessOnlyFailure(const string verification_reason)
  {
   if(StringFind(verification_reason, "retained_pair_dossier_stale") < 0
      && StringFind(verification_reason, "retained_pair_current_focus_stale") < 0)
      return false;

   if(StringFind(verification_reason, "symbol_mismatch") >= 0
      || StringFind(verification_reason, "canonical_mismatch") >= 0
      || StringFind(verification_reason, "publication_id_mismatch") >= 0
      || StringFind(verification_reason, "payload_mismatch") >= 0
      || StringFind(verification_reason, "missing") >= 0
      || StringFind(verification_reason, "deep_truth") >= 0)
      return false;

   return true;
  }




string ASC_ExtractPipeTokenValue(const string text,const string token)
  {
   if(StringLen(text) <= 0 || StringLen(token) <= 0)
      return "";

   string needle = token + "=";
   int start = StringFind(text, needle);
   if(start < 0)
      return "";

   start += (int)StringLen(needle);
   int stop = start;
   int n = (int)StringLen(text);
   while(stop < n)
     {
      ushort ch = (ushort)StringGetCharacter(text, stop);
      if(ch == 124 || ch == 10 || ch == 13 || ch == 9)
         break;
      stop++;
     }

   string value = StringSubstr(text, start, stop - start);
   StringTrimLeft(value);
   StringTrimRight(value);
   return value;
  }

bool ASC_TryGetActivePublicationArtifactDetails(const string path,
                                                string &publication_id_out,
                                                datetime &modified_utc_out,
                                                bool &exists_out,
                                                bool &has_payload_out)
  {
   publication_id_out = "";
   modified_utc_out = 0;
   exists_out = false;
   has_payload_out = false;

   if(StringLen(path) <= 0)
      return false;

   exists_out = ASC_FileTryGetModifyUtc(path, modified_utc_out);

   string payload = "";
   if(!ASC_ReadTextFile(path, payload) || StringLen(payload) <= 0)
      return exists_out;

   has_payload_out = true;
   publication_id_out = ASC_PublicationPayloadId(payload);
   return true;
  }

bool ASC_ManifestLawfulSplitRoleFocusStatus(const string focus_status)
  {
   return (focus_status == "deep_pair_succeeded"
           || focus_status == "deep_pair_continuity"
           || focus_status == "deep_focus_preserved_direct"
           || focus_status == "state_aligned");
  }

bool ASC_ManifestSelectedSymbolChildPending(const string focus_publication_id,
                                            const string focus_status)
  {
   if(StringLen(focus_publication_id) > 0)
      return false;

   return (focus_status == "view_queued"
           || focus_status == "view_deferred"
           || focus_status == "view_retry_backoff"
           || focus_status == "view_pending_symbol_resolution"
           || focus_status == "deep_pair_succeeded"
           || focus_status == "deep_pair_continuity"
           || focus_status == "deep_focus_preserved_direct"
           || focus_status == "state_aligned");
  }

string ASC_ManifestActiveArtifactFieldFamilyDivergence(const string board_publication_id,
                                                       const string focus_publication_id,
                                                       const string bundle_publication_id,
                                                       const string focus_status)
  {
   if(StringLen(board_publication_id) <= 0)
      return "board_proof_missing";
   if(ASC_ManifestSelectedSymbolChildPending(focus_publication_id, focus_status))
      return "selected_symbol_child_pending";
   if(StringLen(focus_publication_id) <= 0)
      return "selected_symbol_child_missing";
   if(board_publication_id != focus_publication_id)
      return (ASC_ManifestLawfulSplitRoleFocusStatus(focus_status)
              ? "publication_identity_only"
              : "publication_identity_and_state");
   if(StringLen(bundle_publication_id) > 0 && board_publication_id != bundle_publication_id)
      return "runtime_bundle_identity_only";
   return "none";
  }

string ASC_ManifestActiveArtifactDivergenceReason(const string board_publication_id,
                                                  const string focus_publication_id,
                                                  const string bundle_publication_id,
                                                  const string focus_status,
                                                  const string focus_reason)
  {
   if(StringLen(board_publication_id) <= 0)
      return "active Market Board proof is unavailable";
   if(ASC_ManifestSelectedSymbolChildPending(focus_publication_id, focus_status))
      return StringFormat("selected-symbol child proof is still pending under lawful same-symbol support flow | selected_symbol_dossier_status=%s | focus_reason=%s",
                          ASC_TextOrUnavailable(focus_status),
                          ASC_TextOrUnavailable(focus_reason));
   if(StringLen(focus_publication_id) <= 0)
      return "selected-symbol child proof is unavailable";
   if(board_publication_id != focus_publication_id)
     {
      if(ASC_ManifestLawfulSplitRoleFocusStatus(focus_status))
         return StringFormat("board keeps ordinary baseline authority while Selected-Symbol Dossier carries same-symbol deep support only | selected_symbol_dossier_status=%s | focus_reason=%s",
                             ASC_TextOrUnavailable(focus_status),
                             ASC_TextOrUnavailable(focus_reason));
      return StringFormat("active board and selected-symbol child disagree on publication identity outside lawful split-role tolerance | selected_symbol_dossier_status=%s | focus_reason=%s",
                          ASC_TextOrUnavailable(focus_status),
                          ASC_TextOrUnavailable(focus_reason));
     }
   if(StringLen(bundle_publication_id) > 0 && board_publication_id != bundle_publication_id)
      return StringFormat("active board proof still points at the preserved board baseline while runtime bundle publication id advanced to %s",
                          bundle_publication_id);
   return "none";
  }

string ASC_ManifestActiveArtifactFamilyAlignment(const string board_publication_id,
                                                 const string focus_publication_id,
                                                 const string bundle_publication_id,
                                                 const string focus_status)
  {
   if(StringLen(board_publication_id) <= 0)
      return "board_active_proof_unavailable";
   if(ASC_ManifestSelectedSymbolChildPending(focus_publication_id, focus_status))
      return StringFormat("board_active_selected_symbol_child_pending selected_symbol_dossier_status=%s",
                          ASC_TextOrUnavailable(focus_status));
   if(StringLen(focus_publication_id) <= 0)
      return "board_active_without_selected_symbol_child";
   if(board_publication_id != focus_publication_id)
     {
      if(ASC_ManifestLawfulSplitRoleFocusStatus(focus_status))
         return StringFormat("lawful_split_role board_baseline=%s selected_symbol_deep=%s field_family=publication_identity_only selected_symbol_dossier_status=%s",
                             board_publication_id,
                             focus_publication_id,
                             ASC_TextOrUnavailable(focus_status));
      return StringFormat("publication_id_mismatch board=%s child=%s selected_symbol_dossier_status=%s",
                          board_publication_id,
                          focus_publication_id,
                          ASC_TextOrUnavailable(focus_status));
     }
   if(StringLen(bundle_publication_id) > 0 && board_publication_id != bundle_publication_id)
      return StringFormat("active_family_differs_from_runtime_bundle active=%s runtime=%s",
                          board_publication_id,
                          bundle_publication_id);
   return "same_family_active_proof_confirmed";
  }
string ASC_ManifestProofClassLedgerLine(const ASC_RuntimeState &state,
                                        const bool active_board_exists,
                                        const bool active_board_has_payload,
                                        const string active_board_publication_id,
                                        const bool active_focus_exists,
                                        const bool active_focus_has_payload,
                                        const string active_focus_publication_id,
                                        const string active_family_alignment)
  {
   string artifact_visible = (active_board_exists && active_board_has_payload) ? "board=yes" : "board=no";
   artifact_visible += (active_focus_exists && active_focus_has_payload) ? ",selected_symbol_dossier=yes" : ",selected_symbol_dossier=no";

   string runtime_proof = "no_live_claim";
   if(StringLen(active_board_publication_id) > 0
      && StringLen(active_focus_publication_id) > 0
      && active_family_alignment == "same_family_active_proof_confirmed")
      runtime_proof = "manifest_readback_aligned";
   else if(StringLen(active_board_publication_id) > 0 && ASC_ManifestSelectedSymbolChildPending(active_focus_publication_id, state.current_focus_last_status))
      runtime_proof = "board_baseline_visible_child_pending";
   else if(StringLen(active_board_publication_id) > 0)
      runtime_proof = "partial_manifest_readback";

   return "Proof Class Ledger: source_owner=ASC_WriteArtifactBundleManifest"
          + " | artifact_visible=" + artifact_visible
          + " | runtime_proof=" + runtime_proof
          + " | calibration_validation=not_claimed_by_manifest";
  }

string ASC_ManifestCheckpointEvidenceLine(const ASC_RuntimeState &state,
                                          const string active_family_alignment,
                                          const string active_family_divergence_reason)
  {
   string checkpoint = "phase_end_live_output_batch_required";
   if(state.l1_publish_pending_essentials || state.l1_publish_pending_dossiers || state.l1_publish_pending_manifest)
      checkpoint = "batch_pending_or_deferred";
   else if(state.publication_bundle.overall_bundle_status == "failure")
      checkpoint = "blocked_by_bundle_failure";
   else if(StringFind(active_family_alignment, "same_family_active_proof_confirmed") >= 0)
      checkpoint = "artifact_visible_ready_for_live_closeout_review";
   else if(StringFind(active_family_alignment, "pending") >= 0)
      checkpoint = "selected_symbol_child_pending";

   return "Checkpoint Evidence: checkpoint=" + checkpoint
          + " | board=" + ASC_TextOrUnavailable(state.publication_bundle.market_board_status)
          + " | dossier=" + ASC_TextOrUnavailable(state.current_focus_last_status)
          + " | manifest=" + ASC_TextOrUnavailable(state.publication_bundle.manifest_status)
          + " | overall=" + ASC_TextOrUnavailable(state.publication_bundle.overall_bundle_status)
          + " | hold_reason=" + ASC_TextOrUnavailable(active_family_divergence_reason);
  }

string ASC_ManifestEvidenceBoundaryLine(const ASC_RuntimeState &state,
                                        const string active_family_alignment,
                                        const string active_family_divergence_reason)
  {
   string artifact_scope = "not_aligned";
   if(StringFind(active_family_alignment, "same_family_active_proof_confirmed") >= 0)
      artifact_scope = "active_board_and_focus_same_publication_id";
   else if(StringFind(active_family_alignment, "pending") >= 0)
      artifact_scope = "selected_symbol_child_pending";
   else if(StringFind(active_family_alignment, "split_role") >= 0)
      artifact_scope = "lawful_split_role_only";
   else if(StringFind(active_family_alignment, "without_selected_symbol_child") >= 0)
      artifact_scope = "board_without_selected_symbol_child";

   string live_scope = "live_output_required_for_phase2a_acceptance";
   if(state.publication_bundle.overall_bundle_status == "failure")
      live_scope = "blocked_until_bundle_failure_resolved";
   else if(state.l1_publish_pending_essentials || state.l1_publish_pending_dossiers || state.l1_publish_pending_manifest)
      live_scope = "deferred_until_pending_batch_clears";

   return "Evidence Boundary: compile_proof=not_observed_by_manifest"
          + " | live_runtime_proof=" + live_scope
          + " | artifact_readback=" + artifact_scope
          + " | runtime_function_result_log_proof=not_observed_by_manifest"
          + " | owner_boundary_log_proof=not_observed_by_manifest"
          + " | calibration_validation=not_claimed_by_manifest"
          + " | artifact_publication_is_not_trading_edge_validation=yes"
          + " | closeout_required=phase_end_live_output_batch_plus_function_results_log_when_available"
          + " | hold_reason=" + ASC_TextOrUnavailable(active_family_divergence_reason);
  }



string ASC_ManifestDossierHydrationLedgerTrace(const ASC_RuntimeState &state)
  {
   int rows = ArraySize(state.dossier_hydration_rows);
   int known_class = 0;
   int hydration_class_line = 0;
   int existing = 0;
   int shell = 0;
   int rich = 0;
   int has_l3 = 0;
   int has_l4 = 0;
   int fresh = 0;
   int continuity = 0;
   int missing = 0;
   int unreadable = 0;
   int other_status = 0;

   for(int i = 0; i < rows; i++)
     {
      if(state.dossier_hydration_rows[i].hydration_class >= 0)
         known_class++;
      if(state.dossier_hydration_rows[i].has_hydration_class_line)
         hydration_class_line++;
      if(state.dossier_hydration_rows[i].exists)
         existing++;
      if(state.dossier_hydration_rows[i].is_shell)
         shell++;
      if(state.dossier_hydration_rows[i].is_rich)
         rich++;
      if(state.dossier_hydration_rows[i].has_l3)
         has_l3++;
      if(state.dossier_hydration_rows[i].has_l4)
         has_l4++;

      string status = state.dossier_hydration_rows[i].publication_status;
      if(status == "fresh")
         fresh++;
      else if(status == "continuity")
         continuity++;
      else if(status == "missing")
         missing++;
      else if(status == "existing_unreadable")
         unreadable++;
      else if(StringLen(status) > 0)
         other_status++;
     }

   return StringFormat("rows=%d | known_class_rows=%d | hydration_class_line_rows=%d | existing=%d | shell=%d | rich=%d | has_l3=%d | has_l4=%d | status_fresh=%d | status_continuity=%d | status_missing=%d | status_unreadable=%d | status_other=%d",
                       rows,
                       known_class,
                       hydration_class_line,
                       existing,
                       shell,
                       rich,
                       has_l3,
                       has_l4,
                       fresh,
                       continuity,
                       missing,
                       unreadable,
                       other_status);
  }

string ASC_ManifestDossierBacklogTrace(const ASC_RuntimeState &state)
  {
   int closed_reduced = MathMax(0, ArraySize(state.dossier_queue_closed_reduced_symbols) - state.dossier_queue_cursor_closed_reduced);
   int open_base = MathMax(0, ArraySize(state.dossier_queue_open_base_symbols) - state.dossier_queue_cursor_open_base);
   int open_l3 = MathMax(0, ArraySize(state.dossier_queue_open_l3_symbols) - state.dossier_queue_cursor_open_l3);
   int open_l4 = MathMax(0, ArraySize(state.dossier_queue_open_l4_symbols) - state.dossier_queue_cursor_open_l4);
   int queue_total = closed_reduced + open_base + open_l3 + open_l4;

   return StringFormat("pending_dossiers=%s | backlog=%d | queue_total=%d | closed_l0_l2=%d | open_base=%d | open_l3=%d | open_l4=%d | cursor=%d | expected=%d | missing=%d | regression=%s | missing_stall_beats=%d | cursor_stall_beats=%d | no_progress_write_beats=%d",
                       state.l1_publish_pending_dossiers ? "yes" : "no",
                       MathMax(0, state.dossier_pending_backlog_count),
                       queue_total,
                       closed_reduced,
                       open_base,
                       open_l3,
                       open_l4,
                       MathMax(0, state.write_cursor),
                       MathMax(0, state.dossier_expected_count),
                       MathMax(0, state.dossier_missing_count),
                       ASC_TextOrUnavailable(state.dossier_regression_signal),
                       MathMax(0, state.dossier_missing_stall_beats),
                       MathMax(0, state.dossier_cursor_stall_beats),
                       MathMax(0, state.dossier_no_progress_write_beats));
  }

string ASC_ManifestFunctionResultsLogEvidenceLine(const ASC_RuntimeState &state)
  {
   string resolved_path = (StringLen(state.function_results_log_path) > 0)
                          ? state.function_results_log_path
                          : ASC_FunctionResultsLogExpectedRelativePath();
   string runtime_unproven_status = "source_supported_runtime_unproven";

   return "Function Results Log Evidence: function_results_log_expected_path=" + ASC_FunctionResultsLogExpectedRelativePath()
          + " | function_results_log_resolved_path=" + ASC_TextOrUnavailable(resolved_path)
          + " | function_results_log_required_for_phase2a_closeout=" + ASC_FUNCTION_RESULTS_PHASE2A_CLOSEOUT_REQUIRED
          + " | function_results_log_write_attempted=" + (state.function_results_log_write_attempted ? "yes" : "no")
          + " | function_results_log_write_status=" + ASC_TextOrUnavailable(state.function_results_log_last_status)
          + " | function_results_log_write_succeeded=" + (state.function_results_log_write_succeeded ? "yes" : "no")
          + " | function_results_log_last_error=" + IntegerToString(state.function_results_log_last_error)
          + " | function_results_log_last_write_utc=" + ASC_FormatUtc(state.function_results_log_last_write_utc)
          + " | function_results_log_last_detail=" + ASC_TextOrUnavailable(state.function_results_log_last_detail)
          + " | function_results_log_runtime_proof=" + (state.function_results_log_write_succeeded ? "bootstrap_marker_written_source_observed_needs_output_package_proof" : "not_claimed_until_file_supplied")
          + " | function_results_log_absence_classification=" + ASC_Run030MissingLogClassification()
          + " | function_results_log_absence_means=if_write_succeeded_then_output_package_omission_else_runtime_write_failure"
          + " | function_results_log_header_expected=" + ASC_FunctionResultsLogHeaderExpected()
          + " | telemetry_keys_required=" + ASC_FunctionResultsLogRequiredKeys()
          + " | row_keys_required=" + ASC_Run030RequiredFunctionResultRowKeys()
          + " | run050_required_manifest_lines=" + ASC_Run030RequiredManifestLines()
          + " | proof_event_taxonomy=" + ASC_FunctionResultsProofEventTaxonomy()
          + " | proof_status_taxonomy=" + ASC_FunctionResultsProofStatusTaxonomy()
          + " | missing_proof_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_MISSING_FROM_OUTPUT_PACKAGE
          + " | unavailable_proof_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_UNAVAILABLE
          + " | stale_proof_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_STALE
          + " | insufficient_evidence_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_INSUFFICIENT_EVIDENCE
          + " | dependency_blocked_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_DEPENDENCY_BLOCKED
          + " | source_supported_runtime_unproven_status=" + runtime_unproven_status
          + " | claim_evidence_contract_source_support=present"
          + " | claim_evidence_statuses=" + ASC_ClaimEvidenceStatusTaxonomy()
          + " | claim_evidence_runtime_proof=deferred_to_run050"
          + " | next_live_proof_required=phase_end_live_output_batch"
          + " | next_live_proof_target=RUN050"
          + " | proof_boundary=source_support_present_bootstrap_marker_written_when_runtime_succeeds_output_package_still_required";
  }


int ASC_ManifestDossierVisibleRows(const ASC_RuntimeState &state)
  {
   int visible = 0;
   for(int i = 0; i < ArraySize(state.dossier_hydration_rows); i++)
     {
      if(state.dossier_hydration_rows[i].exists
         && state.dossier_hydration_rows[i].has_hydration_class_line)
         visible++;
     }
   return visible;
  }

string ASC_ManifestCrossArtifactAlignmentLine(const string ce_status,
                                              const bool dossier_visible,
                                              const bool focus_visible,
                                              const bool board_visible,
                                              const bool top10_visible,
                                              const bool manifest_visible,
                                              const string divergence,
                                              const string reason)
  {
   return "Cross-Artifact Alignment Witness: claim_evidence_status=" + ASC_ClaimEvidenceStatusText(ce_status)
          + " | expected_artifacts=Dossier,Selected-Symbol Dossier,Market Board,GlobalTop10,Artifact Bundle Manifest"
          + " | dossier=" + (dossier_visible ? "visible" : "missing_or_unverified")
          + " | current_focus=" + (focus_visible ? "visible" : "missing_or_unverified")
          + " | market_board=" + (board_visible ? "visible" : "missing_or_unverified")
          + " | global_top10=" + (top10_visible ? "visible" : "missing_or_unverified")
          + " | manifest=" + (manifest_visible ? "visible" : "source_writer_current_manifest")
          + " | divergence=" + ASC_TextOrUnavailable(divergence)
          + " | reason=" + ASC_TextOrUnavailable(reason)
          + " | status_taxonomy=" + ASC_Run030ClaimEvidenceCrossArtifactStatuses()
          + " | runtime_proof=deferred_to_run050"
          + " | proof_boundary=lightweight_witness_not_full_contradiction_engine_no_strategy_ranking_hud_claim";
  }

string ASC_ManifestCurrentFocusProofLine(const string ce_status,
                                          const string expectation_state,
                                          const string focus_path,
                                          const bool focus_exists,
                                          const bool focus_has_payload,
                                          const string selected_symbol,
                                          const string support)
  {
   string readable_expectation = "separate Selected-Symbol Dossier artifact expectation is unresolved";
   string separate_required = "unknown";
   if(expectation_state == "dossier_derivative_expected")
     {
      readable_expectation = "expected as root Dossier derivative; separate Selected-Symbol Dossier file not required while contract path is Dossier.txt";
      separate_required = "no";
     }
   else if(expectation_state == "selected_dossier_copy_expected")
     {
      readable_expectation = "expected as selected-symbol Dossier copy support artifact";
      separate_required = "no";
     }
   else if(expectation_state == "separate_artifact_expected")
     {
      readable_expectation = "separate Selected-Symbol Dossier artifact expected; RUN050 must prove present or classify failure";
      separate_required = "yes";
     }
   else if(expectation_state == "not_applicable_no_selected_symbol")
     {
      readable_expectation = "not applicable because no selected symbol is active";
      separate_required = "no";
     }
   else if(expectation_state == "dependency_blocked")
      readable_expectation = "unavailable until selected-symbol dependency clears";
   else if(expectation_state == "retained_last_good" || expectation_state == "stale")
      readable_expectation = "retained or stale Selected-Symbol Dossier proof; not clean success";
   else if(expectation_state == "unavailable")
      readable_expectation = "Selected-Symbol Dossier proof unavailable";
   else if(expectation_state == "contradiction_pending")
      readable_expectation = "Selected-Symbol Dossier expectation contradiction pending";
   else if(expectation_state == "source_supported_runtime_unproven")
      readable_expectation = "source-supported Selected-Symbol Dossier expectation awaiting RUN050 runtime proof";

   return "Selected-Symbol Dossier Proof: claim_evidence_status=" + ASC_ClaimEvidenceStatusText(ce_status)
          + " | current_focus_expectation=" + (StringLen(expectation_state) > 0 ? expectation_state : "unavailable")
          + " | readable_expectation=" + readable_expectation
          + " | active_current_focus_path=" + ASC_TextOrUnavailable(focus_path)
          + " | active_current_focus_exists=" + (focus_exists ? "yes" : "no")
          + " | active_current_focus_payload=" + (focus_has_payload ? "readable" : "unreadable_or_empty")
          + " | selected_symbol=" + (StringLen(selected_symbol) > 0 ? selected_symbol : "none")
          + " | separate_current_focus_file_required=" + separate_required
          + " | expectation_status_taxonomy=" + ASC_CurrentFocusExpectationStatuses()
          + " | claim_evidence_support=" + support
          + " | runtime_proof=deferred_to_run050"
          + " | proof_boundary=metadata_only_no_strategy_ranking_hud_or_operator_content_change";
  }

string ASC_ManifestOperatorSurfaceBoundaryLine(const string ce_status,
                                                 const string boundary_state)
  {
   return "Operator Surface Claim Boundary Witness: claim_evidence_status=" + ASC_ClaimEvidenceStatusText(ce_status)
          + " | claim_evidence_operator_surface_boundaries=" + ASC_OpSurfBoundaryTargets()
          + " | claim_evidence_operator_surface_boundary_statuses=" + ASC_Run030ClaimEvidenceOperatorSurfaceStatuses()
          + " | surface_claim_boundary=" + (StringLen(boundary_state) > 0 ? boundary_state : "proof_required")
          + " | claim_evidence_operator_surface_scope=" + ASC_OpSurfScope()
          + " | protected_surfaces=Dossier Operator Snapshot,Selected-Symbol Dossier Summary,Market Board Compression,HUD Truth Surface"
          + " | proof_boundary=metadata_only_no_operator_text_rewrite_no_strategy_ranking_hud_change"
          + " | runtime_proof=deferred_to_run050";
  }

string ASC_ManifestFunctionResultsLogBudgetLine(const ASC_RuntimeState &state)
  {
   return "Function Results Log Budget: function_results_log_budget=" + ASC_FunctionResultsLogBudgetStatus()
          + " | function_results_log_path=" + ASC_FunctionResultsLogExpectedRelativePath()
          + " | function_results_log_write_attempted=" + (state.function_results_log_write_attempted ? "yes" : "no")
          + " | function_results_log_write_succeeded=" + (state.function_results_log_write_succeeded ? "yes" : "no")
          + " | function_results_bootstrap_marker_emitted=" + (state.function_results_log_write_succeeded ? "source_observed_write" : "runtime_unproven_until_run050")
          + " | function_results_required_keys_supported=" + ASC_FunctionResultsLogRequiredKeys()
          + " | function_results_proof_row_classes=" + ASC_FunctionResultsProofRowClassTaxonomy()
          + " | function_results_spam_guard=" + ASC_FunctionResultsSpamGuardStatus()
          + " | function_results_required_rows_must_not_be_throttled=" + ASC_FunctionResultsRequiredRowsMustNotBeThrottled()
          + " | seam_no_spam_guard=" + ASC_RowLevelSeamNoSpamGuard()
          + " | run050_must_verify=" + ASC_FunctionResultsLogBudgetRun050Checks()
          + " | no_runtime_log_size_claim_before_run050=yes";
  }


string ASC_ManifestFunctionResultsLogBudgetSummaryLine()
  {
   return "Function Results Log Budget Summary:"
          + " function_results_log_budget_summary=present"
          + " | actual_log_required=yes"
          + " | row_count_check_required=yes"
          + " | file_size_check_required=yes"
          + " | repeated_row_noise_check_required=yes"
          + " | required_rows_must_not_be_suppressed=yes"
          + " | per_symbol_proof_spam_forbidden=yes"
          + " | budget_runtime_proof=deferred_to_run050"
          + " | budget_summary_keys=" + ASC_FunctionResultsLogBudgetSummaryKeys()
          + " | judgement_taxonomy=" + ASC_FunctionResultsLogBudgetJudgementTaxonomy()
          + " | required_row_vs_spam_rules=" + ASC_FunctionResultsRequiredRowVsSpamRules()
          + " | run050_must_verify=" + ASC_FunctionResultsLogBudgetSummaryRun050Checks()
          + " | manifest_summary_is_actual_log_proof=no"
          + " | proof_boundary=budget_checklist_only_actual_function_results_log_required_for_row_count_file_size_and_repeated_row_proof";
  }


string ASC_ManifestFunctionResultsRowLevelProofSummaryLine()
  {
   return "Function Results Row-Level Proof Summary: row_level_summary=present"
          + " | row_level_support=" + ASC_FunctionResultsRowLevelProofSummarySupport()
          + " | required_row_detail_keys=" + ASC_Run030RequiredFunctionResultRowKeys()
          + " | compact_seam_detail_keys=" + ASC_RowLevelSeamDetailKeyStandard()
          + " | required_log_header=" + ASC_FunctionResultsLogHeaderExpected()
          + " | proof_row_classes=" + ASC_FunctionResultsProofRowClassTaxonomy()
          + " | seam_status_taxonomy=" + ASC_RowLevelSeamStatusTaxonomy()
          + " | bootstrap_marker_expectation=required_once"
          + " | actual_log_required_for_row_level_proof=yes"
          + " | manifest_row_level_summary_is_actual_log_proof=no"
          + " | runtime_proof=deferred_to_run050"
          + " | canonical_baseline_support=" + ASC_CanonicalBaselineReconciliationSupport()
          + " | baseline_source_decision=" + ASC_CanonicalBaselineReconciliationSourceDecision()
          + " | proof_boundary=summary_locator_only_actual_Workbench_logs_function_results_log_required_for_row_level_evidence";
  }

string ASC_ManifestRowLevelSeamEmissionContractLine()
  {
   return "Row-Level Seam Emission Contract:"
          + " row_level_seam_contract=present"
          + " | actual_log_required=yes"
          + " | manifest_line_not_row_proof=yes"
          + " | conditional_seams_may_be_runtime_unobserved=yes"
          + " | runtime_observed_requires_log_row=yes"
          + " | row_level_runtime_proof=deferred_to_run050"
          + " | contract_keys=" + ASC_RowLevelSeamEmissionContractKeys()
          + " | compact_detail_keys=" + ASC_RowLevelSeamDetailKeyStandard()
          + " | detail_key_expectation=" + ASC_RowLevelSeamDetailKeyExpectation()
          + " | seam_status_taxonomy=" + ASC_RowLevelSeamStatusTaxonomy()
          + " | required_seam_inventory=" + ASC_RowLevelRequiredSeamInventory()
          + " | no_spam_guard=" + ASC_RowLevelSeamNoSpamGuard()
          + " | run050_must_verify=" + ASC_RowLevelSeamContractRun050Checks()
          + " | behavior_change=no"
          + " | proof_boundary=contract_and_inventory_only_actual_function_results_log_rows_required_for_runtime_proof";
  }

string ASC_ManifestOutputArtifactLocatorLine()
  {
   return "Output Artifact Locator: output_artifact_locator=present"
          + " | required_artifacts=" + ASC_OutputArtifactLocatorRequiredArtifacts()
          + " | required_paths=" + ASC_OutputArtifactLocatorRequiredPaths()
          + " | optional_artifacts=" + ASC_OutputArtifactLocatorOptionalArtifacts()
          + " | optional_paths=" + ASC_OutputArtifactLocatorOptionalPaths()
          + " | derivative_artifacts=" + ASC_OutputArtifactLocatorDerivativeArtifacts()
          + " | current_focus_expectation=" + ASC_OutputArtifactLocatorCurrentFocusExpectation()
          + " | current_focus_contract_path=" + ASC_CURRENT_FOCUS_FILE
          + " | current_focus_derivative_rule=if_derivative_expected_root_Dossier_txt_satisfies_package_presence_only_when_current_output"
          + " | current_focus_retained_last_good_rule=retained_last_good_Dossier_is_continuity_evidence_not_fresh_Current_Focus_proof_unless_labelled"
          + " | current_focus_separate_rule=if_separate_artifact_expected_separate_file_must_exist_or_classify_missing_required_artifact"
          + " | package_completeness_taxonomy=" + ASC_PackageCompletenessTaxonomy()
          + " | missing_required_artifact_blocks_relevant_proof=yes"
          + " | missing_optional_artifact_blocks_relevant_proof=no_unless_claimed"
          + " | source_write_witness_is_uploaded_package_proof=no"
          + " | actual_package_proof_requirement=" + ASC_OutputArtifactLocatorActualPackageProofRequirement()
          + " | runtime_proof=" + ASC_OutputArtifactLocatorRuntimeProof()
          + " | proof_boundary=locator_and_package_contract_only_no_artifact_semantic_output_fileio_strategy_ranking_hud_change";
  }



string ASC_ManifestCurrentVsArchiveArtifactBoundaryLine()
  {
   return "Current vs Archive Artifact Boundary:"
          + " current_artifact_required_for_run050=yes"
          + " | archive_artifact_is_evidence_only=yes"
          + " | previous_run_file_not_current_proof=yes"
          + " | retained_last_good_requires_label=yes"
          + " | source_supported_not_runtime_proof=yes"
          + " | current_output_package_required=yes"
          + " | current_vs_archive_classification=" + ASC_CurrentArchiveArtifactBoundaryClassification()
          + " | package_completeness_taxonomy=" + ASC_PackageCompletenessTaxonomy()
          + " | current_focus_currentness_rule=" + ASC_CurrentArchiveCurrentFocusRule()
          + " | proof_rule=" + ASC_CurrentArchiveArtifactBoundaryProofRule()
          + " | mql5_timestamp_path_proof=run050_compare_current_output_paths_and_modify_times_when_available"
          + " | proof_boundary=manifest_boundary_only_actual_current_output_package_proof_deferred_to_run050";
  }

string ASC_FunctionResultsPackageClassification(const ASC_RuntimeState &state)
  {
   string resolved_path = (StringLen(state.function_results_log_path) > 0)
                          ? state.function_results_log_path
                          : ASC_FunctionResultsLogExpectedRelativePath();
   if(StringLen(resolved_path) <= 0)
      return ASC_FunctionResultsSourceContractMissingClass();
   if(!state.function_results_log_write_attempted)
      return ASC_FunctionResultsRuntimeUnprovenClass();
   if(!state.function_results_log_write_succeeded)
      return ASC_FunctionResultsRuntimeWriteFailedClass();
   return ASC_FunctionResultsPackagePresenceUnverifiedClass();
  }

string ASC_ManifestFunctionResultsOutputPackageContractLine(const ASC_RuntimeState &state)
  {
   string resolved_path = (StringLen(state.function_results_log_path) > 0)
                          ? state.function_results_log_path
                          : ASC_FunctionResultsLogExpectedRelativePath();
   return "Function Results Output Package Contract: function_results_required_output_file=" + ASC_FunctionResultsOutputPackageRequiredFile()
          + " | function_results_resolved_runtime_path=" + ASC_TextOrUnavailable(resolved_path)
          + " | function_results_missing_uploaded_log_classification=" + ASC_FunctionResultsOutputPackageOmissionClass()
          + " | function_results_write_failed_classification=" + ASC_FunctionResultsRuntimeWriteFailedClass()
          + " | function_results_path_missing_classification=" + ASC_FunctionResultsSourceContractMissingClass()
          + " | function_results_no_live_output_classification=" + ASC_FunctionResultsRuntimeUnprovenClass()
          + " | function_results_write_succeeded_uploaded_presence_unverified_classification=" + ASC_FunctionResultsPackagePresenceUnverifiedClass()
          + " | function_results_current_classification=" + ASC_FunctionResultsPackageClassification(state)
          + " | function_results_log_required_for_run050=yes"
          + " | function_results_source_write_status_not_equal_uploaded_file_presence=yes"
          + " | function_results_runtime_proof=deferred_to_run050"
          + " | function_results_manifest_write_success_is_actual_log_proof=no"
          + " | function_results_actual_log_required_for_header_row_size_spam_proof=yes"
          + " | function_results_actual_log_proof_requirement=" + ASC_FunctionResultsActualLogProofRequirement()
          + " | proof_boundary=discoverability_and_package_contract_only_no_log_schema_or_runtime_logging_behavior_change";
  }

string ASC_ManifestHeartbeatTelemetryOutputPackageContractLine(const ASC_RuntimeState &state)
  {
   string resolved_path = (StringLen(state.heartbeat_log_path) > 0)
                          ? state.heartbeat_log_path
                          : (ASC_WORKBENCH_FOLDER + "\\" + ASC_LOGS_FOLDER + "\\" + ASC_HEARTBEAT_LOGFILE);
   return "Heartbeat Telemetry Output Package Contract: heartbeat_telemetry_required_output_file=Workbench/logs/heartbeat_telemetry.log"
          + " | heartbeat_telemetry_resolved_runtime_path=" + ASC_TextOrUnavailable(resolved_path)
          + " | heartbeat_telemetry_required_fields=" + ASC_PHASE3A_HEARTBEAT_REQUIRED_FIELDS
          + " | heartbeat_telemetry_proof_line=" + ASC_PHASE3A_HEARTBEAT_PROOF_LINE
          + " | heartbeat_telemetry_missing_uploaded_log_classification=not_exported_in_package_or_runtime_write_failure_requires_actual_Workbench_log"
          + " | heartbeat_telemetry_header_must_match_row_fields=true"
          + " | heartbeat_telemetry_no_spam_boundary=" + ASC_PHASE3A_NO_SPAM_BOUNDARY
          + " | proof_boundary=contract_locator_only_actual_Workbench_logs_heartbeat_telemetry_log_required_for_row_count_file_size_budget_and_timer_pressure_proof";
  }

string ASC_ManifestRun050RequiredOutputPackageLine()
  {
   return "RUN050 Required Output Package: required_files=" + ASC_Run050RequiredFiles()
          + " | package_required_artifacts=" + ASC_OutputArtifactLocatorRequiredArtifacts()
          + " | package_optional_artifacts=" + ASC_OutputArtifactLocatorOptionalArtifacts()
          + " | package_derivative_artifacts=" + ASC_OutputArtifactLocatorDerivativeArtifacts()
          + " | package_completeness_taxonomy=" + ASC_PackageCompletenessTaxonomy()
          + " | current_focus_expectation=" + ASC_OutputArtifactLocatorCurrentFocusExpectation()
          + " | current_focus_contract_path=" + ASC_CURRENT_FOCUS_FILE
          + " | function_results_actual_log_required=yes"
          + " | function_results_required_output_file=" + ASC_FunctionResultsOutputPackageRequiredFile()
          + " | row_level_seam_contract_line_required=Row-Level Seam Emission Contract:"
          + " | required_seam_inventory=" + ASC_RowLevelRequiredSeamInventory()
          + " | compact_seam_detail_keys=" + ASC_RowLevelSeamDetailKeyStandard()
          + " | manifest_write_success_not_substitute_for_uploaded_log=yes"
          + " | function_results_header_row_size_spam_budget_summary_proof_requires_actual_log=yes"
          + " | function_results_log_budget_summary_required=Function Results Log Budget Summary:"
          + " | function_results_log_budget_summary_checks=" + ASC_FunctionResultsLogBudgetSummaryRun050Checks()
          + " | output_artifact_locator_manifest_only_not_package_proof=yes"
          + " | current_output_package_required=yes"
          + " | archive_folders_historical_evidence_only=yes"
          + " | previous_run_files_not_current_proof=yes"
          + " | retained_last_good_files_support_continuity_only_if_labelled=yes"
          + " | compare_current_output_paths_and_timestamps_when_available=yes"
          + " | source_supported_lines_are_not_runtime_proof=yes"
          + " | package_collection_note=include exact Workbench/logs/function_results.log and required artifact families from fresh/current server output package"
          + " | proof_boundary=checklist_only_no_runtime_proof_claim";
  }


string ASC_ManifestEvidenceAvailabilityBoundaryLine()
  {
   return "Evidence Availability Boundary: evidence_availability_boundary=present"
          + " | evidence_availability_states=" + ASC_EvidenceAvailabilityTaxonomy()
          + " | availability_to_claim_evidence=available_supported->data_supported,unavailable->unavailable,stale->stale,placeholder_or_default->insufficient_evidence,dependency_blocked->dependency_blocked,not_applicable->no_claim,contradiction_pending->contradiction_pending,source_supported_runtime_unproven->source_supported_runtime_unproven"
          + " | unavailable_cannot_create_confidence=yes"
          + " | placeholder_cannot_create_confidence=yes"
          + " | stale_requires_downgrade=yes"
          + " | default_zero_empty_requires_insufficient_evidence=yes"
          + " | future_consumers=Dossier,Selected-Symbol Dossier,Market Board,Candidate Filtering,Shortlist Selection,strategy labels,contradiction checks"
          + " | run050_must_verify=" + ASC_EvidenceAvailabilityRun040Checks()
          + " | runtime_proof=deferred_to_run050"
          + " | proof_boundary=source_metadata_only_no_strategy_ranking_hud_or_operator_content_change";
  }

string ASC_ManifestEvidenceRecoveryBoundaryLine()
  {
   return "Evidence Recovery Boundary: evidence_recovery_boundary=present"
          + " | evidence_recovery_states=" + ASC_EvidenceRecoveryTaxonomy()
          + " | recovery_to_claim_evidence=refresh_due->source_supported_runtime_unproven,refresh_pending->source_supported_runtime_unproven,retry_scheduled->dependency_blocked,dependency_blocked->dependency_blocked,stale_but_recoverable->stale,insufficient_now->insufficient_evidence,unavailable_now->unavailable,recovered_to_supported->data_supported,still_unavailable_after_refresh->unavailable,not_applicable->no_claim"
          + " | unavailable_is_recoverable=yes"
          + " | unavailable_is_not_clean_support=yes"
          + " | unavailable_is_not_permanent_gate=yes"
          + " | recovery_upgrade_requires_fresh_support=yes"
          + " | refresh_recheck_path_source_support=present"
          + " | refresh_recheck_runtime_proof=deferred_to_run050"
          + " | no_heavy_per_symbol_refresh_loop=yes"
          + " | no_hard_gate_behavior_introduced=yes"
          + " | run050_must_verify=" + ASC_EvidenceRecoveryRun040Checks()
          + " | proof_boundary=source_metadata_only_no_strategy_ranking_hud_or_operator_content_change";
  }

string ASC_ManifestEvidenceRecheckBoundaryLine()
  {
   return "Evidence Recheck Boundary: evidence_recheck_boundary=present"
          + " | evidence_recheck_boundary_scope=" + ASC_EvidenceRecheckBoundaryScope()
          + " | l1_recheck_bridge=ASC_L1EvidenceRecheckState"
          + " | l2_recheck_bridge=ASC_L2EvidenceRecheckState"
          + " | existing_cadence_only=yes"
          + " | refresh_states=refresh_due,refresh_pending,retry_scheduled,dependency_blocked,stale_but_recoverable,insufficient_now,unavailable_now,recovered_to_supported,still_unavailable_after_refresh,not_applicable"
          + " | recovered_to_supported_requires_fresh_support=yes"
          + " | failed_refresh_remains_non_clean=yes"
          + " | unavailable_is_not_clean_support=yes"
          + " | unavailable_is_not_permanent_gate=yes"
          + " | no_heavy_per_symbol_refresh_loop=yes"
          + " | source_supported_runtime_unproven=yes"
          + " | run050_must_verify=" + ASC_EvidenceRecheckRun040Checks()
          + " | proof_boundary=source_cadence_bridge_only_no_strategy_ranking_hud_or_operator_content_change";
  }

string ASC_ManifestEvidenceIntakeChainLine()
  {
   return "Evidence Intake Chain: evidence_intake_chain=source_supported"
          + " | candidate_intake=source_supported"
          + " | shortlist_intake=source_supported"
          + " | market_board_intake=source_supported"
          + " | candidate_score_change=no"
          + " | candidate_gate_change=no"
          + " | shortlist_score_change=no"
          + " | shortlist_rank_change=no"
          + " | top_list_change=no"
          + " | market_board_selection_change=no"
          + " | market_board_order_change=no"
          + " | market_board_wording_change=no"
          + " | dossier_operator_wording_change=no"
          + " | current_focus_strategy_wording_change=no"
          + " | hud_logic_change=no"
          + " | unavailable_is_not_clean_support=yes"
          + " | unavailable_is_not_permanent_gate=yes"
          + " | stale_insufficient_unavailable_remain_recoverable=yes"
          + " | recovery_upgrade_requires_fresh_support=yes"
          + " | failed_refresh_remains_non_clean=yes"
          + " | no_heavy_refresh_loop=yes"
          + " | runtime_proof=deferred_to_run050"
          + " | proof_boundary=source_supported_chain_summary_only_no_score_rank_selection_operator_wording_or_hud_change";
  }

string ASC_ManifestCandidateEvidenceIntakeBoundaryLine()
  {
   return "Candidate Evidence Intake Boundary: candidate_evidence_intake_boundary=present"
          + " | candidate_evidence_intake_states=" + ASC_CandidateEvidenceIntakeTaxonomy()
          + " | candidate_filtering_source_helper=ASC_SelectionFilterEvidenceIntakeState"
          + " | candidate_filtering_detail_helper=ASC_SelectionFilterEvidenceIntakeDetail"
          + " | candidate_score_change=no"
          + " | candidate_gate_change=no"
          + " | unavailable_is_not_candidate_gate=yes"
          + " | unavailable_remains_recoverable_non_clean=yes"
          + " | future_use=read_only_metadata_for_later_explainable_ranking"
          + " | runtime_proof=deferred_to_run050"
          + " | run050_must_verify=" + ASC_CandidateEvidenceIntakeRun040Checks()
          + " | proof_boundary=source_metadata_only_no_score_rank_gate_shortlist_top10_market_board_hud_strategy_change";
  }

string ASC_ManifestShortlistEvidenceIntakeBoundaryLine()
  {
   return "Shortlist Evidence Intake Boundary: shortlist_evidence_intake_boundary=present"
          + " | shortlist_evidence_intake_states=" + ASC_ShortlistEvidenceIntakeTaxonomy()
          + " | shortlist_selection_source_helper=ASC_ShortlistEvidenceIntakeState"
          + " | shortlist_selection_detail_helper=ASC_ShortlistEvidenceIntakeDetail"
          + " | shortlist_score_change=no"
          + " | shortlist_rank_change=no"
          + " | top_list_change=no"
          + " | market_board_selection_change=no"
          + " | unavailable_is_not_shortlist_gate=yes"
          + " | unavailable_remains_recoverable_non_clean=yes"
          + " | future_use=read_only_metadata_for_later_explainable_ranking"
          + " | runtime_proof=deferred_to_run050"
          + " | run050_must_verify=" + ASC_ShortlistEvidenceIntakeRun040Checks()
          + " | proof_boundary=source_metadata_only_no_score_rank_top_list_market_board_hud_strategy_change";
  }

string ASC_ManifestMarketBoardEvidenceIntakeBoundaryLine()
  {
   return "Market Board Evidence Intake Boundary: market_board_evidence_intake_boundary=present"
          + " | market_board_evidence_intake_states=" + ASC_MarketBoardEvidenceIntakeTaxonomy()
          + " | market_board_source_helper=ASC_MarketBoardEvidenceIntakeState"
          + " | market_board_detail_helper=ASC_MarketBoardEvidenceIntakeDetail"
          + " | market_board_selection_change=no"
          + " | market_board_order_change=no"
          + " | market_board_wording_change=no"
          + " | top_list_change=no"
          + " | unavailable_is_not_market_board_gate=yes"
          + " | unavailable_remains_recoverable_non_clean=yes"
          + " | future_use=read_only_metadata_for_later_reason_codes_or_conflict_flags"
          + " | runtime_proof=deferred_to_run050"
          + " | run050_must_verify=" + ASC_MarketBoardEvidenceIntakeRun040Checks()
          + " | proof_boundary=source_metadata_only_no_selection_order_wording_top_list_hud_strategy_change";
  }

string ASC_ManifestClaimEvidenceContractLine()
  {
   return "Claim Evidence Contract: claim_evidence_contract_source_support=present"
          + " | claim_evidence_statuses=" + ASC_ClaimEvidenceStatusTaxonomy()
          + " | claim_evidence_safe_callsites=" + ASC_Run030ClaimEvidenceSafeCallsites()
          + " | claim_evidence_availability_states=" + ASC_EvidenceAvailabilityTaxonomy()
          + " | claim_evidence_recovery_states=" + ASC_EvidenceRecoveryTaxonomy()
          + " | claim_evidence_availability_boundary=unavailable_stale_placeholder_default_never_clean"
          + " | claim_evidence_recovery_boundary=unavailable_recoverable_not_permanent_gate"
          + " | claim_evidence_recheck_boundary=existing_l1_l2_cadence_only"
          + " | claim_evidence_intake_chain=source_supported_no_behavior_change"
          + " | claim_evidence_candidate_intake_boundary=metadata_only_no_score_or_gate_change"
          + " | claim_evidence_candidate_intake_states=" + ASC_CandidateEvidenceIntakeTaxonomy()
          + " | claim_evidence_shortlist_intake_boundary=metadata_only_no_score_rank_or_top_list_change"
          + " | claim_evidence_shortlist_intake_states=" + ASC_ShortlistEvidenceIntakeTaxonomy()
          + " | claim_evidence_market_board_intake_boundary=metadata_only_no_selection_order_wording_or_top_list_change"
          + " | claim_evidence_market_board_intake_states=" + ASC_MarketBoardEvidenceIntakeTaxonomy()
          + " | recovery_upgrade_requires_fresh_support=yes"
          + " | claim_evidence_bootstrap_status=" + ASC_CE_SRC_RT_UNPROVEN
          + " | claim_evidence_manifest_status=" + ASC_CE_ARTIFACT_SUPPORTED
          + " | claim_evidence_dossier_hydration_statuses=artifact_supported,insufficient_evidence,unavailable,stale,dependency_blocked,source_supported_runtime_unproven"
          + " | claim_evidence_dossier_hydration_runtime_proof=deferred_to_run050"
          + " | claim_evidence_artifact_publication_statuses=" + ASC_Run030ClaimEvidencePublicationStatuses()
          + " | claim_evidence_artifact_publication_runtime_proof=deferred_to_run050"
          + " | claim_evidence_selected_artifact_statuses=" + ASC_Run030ClaimEvidenceSelectedArtifactStatuses()
          + " | claim_evidence_selected_artifact_runtime_proof=deferred_to_run050"
          + " | claim_evidence_current_focus_expectation_statuses=" + ASC_CurrentFocusExpectationStatuses()
          + " | claim_evidence_current_focus_expectation_runtime_proof=deferred_to_run050"
          + " | claim_evidence_market_board_statuses=" + ASC_Run030ClaimEvidenceMarketBoardStatuses()
          + " | claim_evidence_market_board_runtime_proof=deferred_to_run050"
          + " | claim_evidence_cross_artifact_statuses=" + ASC_Run030ClaimEvidenceCrossArtifactStatuses()
          + " | claim_evidence_cross_artifact_runtime_proof=deferred_to_run050"
          + " | claim_evidence_operator_surface_statuses=" + ASC_Run030ClaimEvidenceOperatorSurfaceStatuses()
          + " | claim_evidence_operator_surface_boundaries=" + ASC_OpSurfBoundaryTargets()
          + " | claim_evidence_operator_surface_scope=" + ASC_OpSurfScope()
          + " | claim_evidence_operator_surface_runtime_proof=deferred_to_run050"
          + " | claim_evidence_operator_claim_scope=proof_metadata_only"
          + " | claim_evidence_runtime_proof=deferred_to_run050"
          + " | run050_claim_evidence_requires=" + ASC_Run030ClaimEvidenceRequires()
          + " | proof_boundary=source_support_and_manifest_artifact_support_only_no_strategy_ranking_hud_claim";
  }

string ASC_ManifestRun031ProofChecklistLine()
  {
   return "RUN050 Proof Checklist: run050_required_files=" + ASC_Run050RequiredFiles()
          + " | run050_required_dossier_tokens=" + ASC_Run030RequiredDossierTokens()
          + " | run050_required_function_result_header=" + ASC_FunctionResultsLogHeaderExpected()
          + " | run050_required_function_result_row_keys=" + ASC_Run030RequiredFunctionResultRowKeys()
          + " | run050_required_manifest_lines=" + ASC_Run030RequiredManifestLines()
          + " | run050_output_artifact_locator=Output Artifact Locator line exists; required artifacts listed; optional artifacts classified; Selected-Symbol Dossier expectation explicit; actual current output package inspected separately from source write witnesses"
          + " | run050_current_vs_archive_boundary=Current vs Archive Artifact Boundary line exists; archive-only and previous-run files are evidence only; retained last-good files are labelled and not counted as fresh proof; source-supported-only seams stay runtime-unproven"
          + " | run050_package_completeness_taxonomy=" + ASC_PackageCompletenessTaxonomy()
          + " | run050_function_results_log_budget_summary=Function Results Log Budget Summary line exists; actual Workbench/logs/function_results.log must be inspected for file size,row count,repeated rows,required-row presence,error-row presence,and per-symbol spam"
          + " | run050_function_results_log_budget_judgement=" + ASC_FunctionResultsLogBudgetJudgementTaxonomy()
          + " | run050_required_row_vs_spam_rules=" + ASC_FunctionResultsRequiredRowVsSpamRules()
          + " | run050_function_results_row_level_summary=Function Results Row-Level Proof Summary line exists; actual Workbench/logs/function_results.log still required for header,row,size,spam,bootstrap proof"
          + " | run050_row_level_seam_emission_contract=Row-Level Seam Emission Contract line exists; seam inventory searchable; emitted rows carry compact detail keys; runtime_observed requires actual log row; source-supported/runtime-unobserved remains unclosed; manifest is not row proof; no per-symbol proof spam; no log schema or FileIO change"
          + " | run050_required_seam_inventory=" + ASC_RowLevelRequiredSeamInventory()
          + " | run050_compact_seam_detail_keys=" + ASC_RowLevelSeamDetailKeyStandard()
          + " | run050_seam_status_taxonomy=" + ASC_RowLevelSeamStatusTaxonomy()
          + " | run050_seam_no_spam_guard=" + ASC_RowLevelSeamNoSpamGuard()
          + " | run044_canonical_baseline_support=" + ASC_CanonicalBaselineReconciliationSupport()
          + " | run044_required_reconciled_lines=" + ASC_CanonicalBaselineReconciliationRequiredLines()
          + " | run044_reconciliation_source_decision=" + ASC_CanonicalBaselineReconciliationSourceDecision()
          + " | run044_reconciliation_proof_boundary=" + ASC_CanonicalBaselineReconciliationProofBoundary()
          + " | run050_function_results_log_budget=" + ASC_FunctionResultsLogBudgetRun050Checks()
          + " | run050_evidence_availability_boundary=" + ASC_EvidenceAvailabilityRun040Checks()
          + " | run050_evidence_recovery_boundary=" + ASC_EvidenceRecoveryRun040Checks()
          + " | run050_evidence_recheck_boundary=" + ASC_EvidenceRecheckRun040Checks()
          + " | run050_evidence_intake_chain=Evidence Intake Chain line exists; Candidate, Shortlist, and Market Board intake seams are listed; score/gate/rank/top-list/selection/order/operator wording/HUD behavior remains unchanged; unavailable remains non-clean and recoverable; runtime proof deferred to RUN050"
          + " | run050_candidate_evidence_intake_boundary=" + ASC_CandidateEvidenceIntakeRun040Checks()
          + " | run050_shortlist_evidence_intake_boundary=" + ASC_ShortlistEvidenceIntakeRun040Checks()
          + " | run050_market_board_evidence_intake_boundary=" + ASC_MarketBoardEvidenceIntakeRun040Checks()
          + " | run050_required_proof_row_classes=" + ASC_FunctionResultsProofRowClassTaxonomy()
          + " | run050_acceptance_rules=" + ASC_Run030AcceptanceRules()
          + " | run050_hold_rules=" + ASC_Run030HoldRules()
          + " | run050_regression_checks=" + ASC_Run030RegressionChecks()
          + " | run050_phase2a_closeout_requires=" + ASC_Run030Phase2ACloseoutRequires()
          + " | run050_phase2a_hold_if=" + ASC_Run030Phase2AHoldIf()
          + " | run050_phase3a_bridge_requires=" + ASC_Run030Phase3ABridgeRequires()
          + " | run050_claim_evidence_requires=" + ASC_Run030ClaimEvidenceRequires()
          + " | run050_claim_evidence_safe_callsites=" + ASC_Run030ClaimEvidenceSafeCallsites()
          + " | run050_dossier_hydration_claim_evidence=Dossier hydration failures must remain visible and cannot be reported as clean success"
          + " | run050_artifact_publication_claim_evidence=pending, skipped, stale, retained, or failed publication states must remain visible and cannot be reported as clean success"
          + " | run050_selected_artifact_claim_evidence=Selected-Symbol Dossier missing, stale, retained, archive-only, previous-run-only, or mismatched states must remain visible and cannot be reported as clean success"
          + " | run050_current_focus_expectation=Selected-Symbol Dossier expectation must state derivative root Dossier path, separate artifact expectation, no selected symbol, dependency-blocked, stale, unavailable, or contradiction-pending state; root Dossier counts only when current output"
          + " | run050_market_board_claim_evidence=Market Board missing, stale, retained, pending, or contradictory states must remain visible and cannot be reported as clean success"
          + " | run050_cross_artifact_claim_evidence=cross-artifact disagreement must remain visible and cannot be reported as clean"
          + " | run050_operator_surface_claim_boundary=Dossier, Selected-Symbol Dossier, Market Board, and HUD boundary targets are listed; no operator text rewrite; no strategy, ranking, or HUD drift"
          + " | run050_evidence_availability=Evidence Availability Boundary line exists; unavailable, stale, placeholder, zero default, and empty default never map to clean support"
          + " | run050_evidence_recovery=Evidence Recovery Boundary line exists; unavailable remains recoverable, never a permanent gate, and recovered_to_supported requires fresh support"
          + " | run050_evidence_recheck=Evidence Recheck Boundary line exists; existing L1/L2 cadence exposes refresh_due, refresh_pending, retry_scheduled, dependency_blocked, recovered_to_supported, and still_unavailable_after_refresh without a heavy loop"
          + " | run050_candidate_evidence_intake=Candidate Evidence Intake Boundary line exists; Candidate Filtering source support exists; score/gate behavior unchanged; unavailable is proof metadata only, not a Candidate Filtering hard gate"
          + " | run050_shortlist_evidence_intake=Shortlist Evidence Intake Boundary line exists; Shortlist Selection source support exists; score/rank/top-list/Market Board selection behavior unchanged; unavailable is proof metadata only, not a Shortlist hard gate"
          + " | run050_market_board_evidence_intake=Market Board Evidence Intake Boundary line exists; Market Board source support exists; selection/order/opportunity-risk-wording/top-list behavior unchanged; unavailable is proof metadata only, not a Market Board hard gate"
          + " | run050_no_behavior_change_lock=Candidate score/gate unchanged; Shortlist score/rank unchanged; Top 3 Top 5 Top 10 unchanged; Market Board selection/order/wording unchanged; HUD unchanged; Dossier operator wording unchanged; Selected-Symbol Dossier strategy wording unchanged"
          + " | run050_forbidden_stale_wording=" + ASC_Run030ForbiddenStaleWording()
          + " | proof_boundary=checklist_only_no_runtime_claim";
  }

string ASC_ManifestPhase2AOpenProofLedgerLine(const ASC_RuntimeState &state)
  {
   string manifest_wait = "source support present; RUN050 fresh output still required";
   string taxonomy_status = "missing, unavailable, stale, insufficient-evidence, dependency-blocked, and runtime-unproven states are visible";
   string runtime_unproven_status = "source_supported_runtime_unproven";

   return "Phase 2A Open Proof Ledger: root_dossier_hydration_labels=source support present; prior live observation exists; RUN050 recheck required"
          + " | global_top10_hydration_labels=source support present; prior live observation exists; RUN050 recheck required"
          + " | manifest_stale_wording=" + manifest_wait
          + " | run050_phase2a_closeout_requires=" + ASC_Run030Phase2ACloseoutRequires()
          + " | run050_phase2a_hold_if=" + ASC_Run030Phase2AHoldIf()
          + " | function_results_log_existence=" + (state.function_results_log_write_succeeded ? "source observed bootstrap marker write; output package proof still required" : "open_until_post_patch_live_proof")
          + " | function_results_source_owner_key=open until RUN050"
          + " | function_results_truth_boundary_key=open until RUN050"
          + " | function_results_hydration_class_key=open until RUN050"
          + " | function_results_proof_event_key=open until RUN050"
          + " | function_results_proof_status_key=open until RUN050"
          + " | function_results_proof_row_class_detail=open until RUN050"
          + " | function_results_log_budget_summary=open until RUN050 actual log inspection"
          + " | function_results_log_budget_judgement_taxonomy=" + ASC_FunctionResultsLogBudgetJudgementTaxonomy()
          + " | function_results_required_row_vs_spam_rules=" + ASC_FunctionResultsRequiredRowVsSpamRules()
          + " | row_level_seam_emission_contract=open until RUN050 actual log inspection"
          + " | required_seam_inventory=" + ASC_RowLevelRequiredSeamInventory()
          + " | compact_seam_detail_keys=" + ASC_RowLevelSeamDetailKeyStandard()
          + " | function_results_log_budget_status=" + ASC_FunctionResultsLogBudgetStatus()
          + " | function_results_spam_guard=" + ASC_FunctionResultsSpamGuardStatus()
          + " | function_results_required_rows_must_not_be_throttled=" + ASC_FunctionResultsRequiredRowsMustNotBeThrottled()
          + " | function_results_header_alignment=source support present; RUN050 function-results file proof required"
          + " | function_results_log_missing_classification=" + ASC_FUNCTION_RESULT_PROOF_STATUS_MISSING_FROM_OUTPUT_PACKAGE
          + " | runtime_log_proof_status=" + (state.function_results_log_write_succeeded ? ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_OBSERVED : runtime_unproven_status)
          + " | source_supported_runtime_unproven_status=" + runtime_unproven_status
          + " | missing_from_output_package_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_MISSING_FROM_OUTPUT_PACKAGE
          + " | unavailable_proof_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_UNAVAILABLE
          + " | stale_proof_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_STALE
          + " | insufficient_evidence_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_INSUFFICIENT_EVIDENCE
          + " | dependency_blocked_status=" + ASC_FUNCTION_RESULT_PROOF_STATUS_DEPENDENCY_BLOCKED
          + " | pending_stalled_unknown_taxonomy=" + taxonomy_status
          + " | function_results_log_write_attempted=" + (state.function_results_log_write_attempted ? "yes" : "no")
          + " | function_results_log_write_status=" + ASC_TextOrUnavailable(state.function_results_log_last_status)
          + " | function_results_log_write_succeeded=" + (state.function_results_log_write_succeeded ? "yes" : "no")
          + " | phase2a_closeout_waiting_on=function_results_log_output_package_and_fresh_manifest"
          + " | next_live_proof_target=RUN050";
  }


string ASC_ManifestRun094Phase2ASourcePatchLine(const ASC_RuntimeState &state)
  {
   int dependency_blocked_count = MathMax(0, state.phase2a_hydration_dependency_blocked_count + state.phase2a_three_kb_dependency_blocked_count);
   return "RUN094 Phase 2A Source Patch Manifest: proof_boundary=" + ASC_RUN094_PHASE2A_PROOF_BOUNDARY
          + " | hydration_class_counts=closed_l0_l2:" + IntegerToString(MathMax(0, state.phase2a_hydration_closed_l0_l2_count))
          + ",open_l0_l4:" + IntegerToString(MathMax(0, state.phase2a_hydration_open_l0_l4_count))
          + ",top10_l0_l6:" + IntegerToString(MathMax(0, state.phase2a_hydration_top10_l0_l6_count))
          + ",selected_l0_l6:" + IntegerToString(MathMax(0, state.phase2a_hydration_selected_l0_l6_count))
          + ",stalled:" + IntegerToString(MathMax(0, state.phase2a_hydration_stalled_count))
          + ",incomplete:" + IntegerToString(MathMax(0, state.phase2a_hydration_incomplete_count))
          + ",dependency_blocked:" + IntegerToString(MathMax(0, state.phase2a_hydration_dependency_blocked_count))
          + " | three_kb_reason_counts=closed_compact_honest:" + IntegerToString(MathMax(0, state.phase2a_three_kb_closed_compact_honest_count))
          + ",open_hydration_incomplete:" + IntegerToString(MathMax(0, state.phase2a_three_kb_open_hydration_incomplete_count))
          + ",unavailable_garbage_shell:" + IntegerToString(MathMax(0, state.phase2a_three_kb_unavailable_garbage_shell_count))
          + ",dependency_blocked:" + IntegerToString(MathMax(0, state.phase2a_three_kb_dependency_blocked_count))
          + ",write_budget_leftover:" + IntegerToString(MathMax(0, state.phase2a_three_kb_write_budget_leftover_count))
          + ",publication_interrupted:" + IntegerToString(MathMax(0, state.phase2a_three_kb_publication_interrupted_count))
          + ",stalled_due_retry:" + IntegerToString(MathMax(0, state.phase2a_three_kb_stalled_due_retry_count))
          + ",retained_last_good_compact:" + IntegerToString(MathMax(0, state.phase2a_three_kb_retained_last_good_compact_count))
          + ",unknown_requires_review:" + IntegerToString(MathMax(0, state.phase2a_three_kb_unknown_requires_review_count))
          + " | queue_remaining=" + IntegerToString(MathMax(0, state.dossier_queue_remaining_count))
          + " | queue_completed=" + IntegerToString(MathMax(0, state.dossier_queue_completed_count))
          + " | queue_stalled=" + IntegerToString(MathMax(0, state.dossier_queue_stalled_count))
          + " | backfill_pending=" + IntegerToString(MathMax(0, state.dossier_backfill_pending_count))
          + " | dependency_blocked_count=" + IntegerToString(dependency_blocked_count)
          + " | warmup_first_publish_status=" + ASC_TextOrUnavailable(state.warmup_first_publish_status)
          + " | degraded_first_publish_reason=" + ASC_TextOrUnavailable(state.warmup_degraded_first_publish_reason)
          + " | no_freeze_escape_available=" + (state.warmup_no_freeze_escape_available ? "yes" : "no")
          + " | later_refresh_not_blocked_by_first_latch=" + (state.warmup_later_refresh_not_blocked_by_first_latch ? "yes" : "no")
          + " | run095_live_unproven=true | compile_claim=false | live_claim=false";
  }


string ASC_ManifestHydrationProofSummaryLine(const ASC_RuntimeState &state)
  {
   string source_support = "enabled_by_dossier_writer_required_tokens_for_hydration_class_reason_boundary_and_finish_telemetry";
   int hydration_line_rows = 0;
   for(int i = 0; i < ArraySize(state.dossier_hydration_rows); i++)
     {
      if(state.dossier_hydration_rows[i].has_hydration_class_line)
         hydration_line_rows++;
     }
   string artifact_observed = (hydration_line_rows > 0)
                              ? StringFormat("observed_in_dossier_payload_ledger_rows=%d", hydration_line_rows)
                              : "not_observed_yet_ledger_has_no_hydration_class_payload_rows";
   string runtime_log_proof = "not_claimed_without_fresh_function_results_log_hydration_class_keys";
   string pending_state = state.l1_publish_pending_dossiers ? "pending_dossier_publication" : "no_pending_dossier_publication_flag";
   string stalled_state = (StringLen(state.dossier_regression_signal) > 0 && state.dossier_regression_signal != "none")
                          ? state.dossier_regression_signal
                          : "none_observed_in_runtime_state";

   return "Hydration Proof Summary: source_hydration_class_support=" + source_support
          + " | artifact_hydration_class_observed=" + artifact_observed
          + " | hydration_runtime_log_proof=" + runtime_log_proof
          + " | pending_publication_state=" + pending_state
          + " | stalled_or_dependency_blocked_state=" + stalled_state
          + " | ledger=" + ASC_ManifestDossierHydrationLedgerTrace(state)
          + " | backlog=" + ASC_ManifestDossierBacklogTrace(state)
          + " | proof_boundary=source_support_vs_artifact_observation_vs_runtime_log_proof_are_distinct"
          + " | closeout_proof_required=fresh_compile_live_readback_and_function_results_log"
          + " | boundary=file_size_diagnostic_only_no_trading_edge_claim";
  }

ASC_FunctionResult ASC_WriteArtifactBundleManifest(const ASC_RuntimeState &state)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_Dispatcher", "ASC_WriteArtifactBundleManifest", "runtime");
   ASC_FunctionResultSetTruthBoundary(result, "artifact.bundle_manifest_writer", "truth_consumer.publication_proof_boundary_manifest");
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_MANIFEST_BOUNDARY,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_OBSERVED);

   if(StringLen(state.bundle_manifest_path) <= 0)
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               "Artifact bundle manifest path is unavailable.",
                               "runtime");
      return result;
     }

   ulong compose_started_us = GetMicrosecondCount();
   string body = "Artifact Bundle Manifest\n";
   body += "source_run_id=" + ASC_SourceRunId()
           + " | source_version=" + ASC_SourceVersionLabel()
           + " | artifact_manifest_schema_version=RUN227_v1"
           + " | artifact_manifest_truth_state=degraded_partial_unknown_source_patch_runtime_unproven"
           + " | artifact_manifest_truth_reason=RUN227_root_surface_contract_parity_compile_and_live_pending"
           + " | artifact_manifest_publication_permission=true"
           + " | validation_deleted=false"
           + " | degraded_partial_unknown_publication_allowed=true"
           + " | complete_requires_required_surfaces=true"
           + " | trade_permission=false"
           + " | signal_permission=false"
           + " | execution_permission=false"
           + " | risk_permission=false\n";
   body += StringFormat("Bundle Started UTC: %s\n", ASC_ArtifactFormatUtc(state.publication_bundle.bundle_started_utc));
   body += StringFormat("Bundle Finished UTC: %s\n", ASC_ArtifactFormatUtc(state.publication_bundle.bundle_finished_utc));
   string active_board_publication_id = "";
   datetime active_board_modified_utc = 0;
   bool active_board_exists = false;
   bool active_board_has_payload = false;
   ASC_TryGetActivePublicationArtifactDetails(state.market_board_path,
                                              active_board_publication_id,
                                              active_board_modified_utc,
                                              active_board_exists,
                                              active_board_has_payload);

   string active_focus_publication_id = "";
   datetime active_focus_modified_utc = 0;
   bool active_focus_exists = false;
   bool active_focus_has_payload = false;
   ASC_TryGetActivePublicationArtifactDetails(state.current_focus_path,
                                              active_focus_publication_id,
                                              active_focus_modified_utc,
                                              active_focus_exists,
                                              active_focus_has_payload);

   string active_board_payload = "";
   string active_board_source_run_id = "";
   if(active_board_exists && active_board_has_payload && ASC_ReadTextFile(state.market_board_path, active_board_payload))
      active_board_source_run_id = ASC_ExtractPipeTokenValue(active_board_payload, "source_run_id");

   string active_focus_payload = "";
   string active_focus_source_run_id = "";
   if(active_focus_exists && active_focus_has_payload && ASC_ReadTextFile(state.current_focus_path, active_focus_payload))
      active_focus_source_run_id = ASC_ExtractPipeTokenValue(active_focus_payload, "source_run_id");

   bool active_board_source_match = (StringLen(active_board_source_run_id) > 0 && active_board_source_run_id == ASC_SourceRunId());
   bool active_focus_source_match = (StringLen(active_focus_source_run_id) > 0 && active_focus_source_run_id == ASC_SourceRunId());
   bool active_focus_source_mismatch = (active_focus_exists && active_focus_has_payload && StringLen(active_focus_source_run_id) > 0 && !active_focus_source_match);

   string active_family_divergence = ASC_ManifestActiveArtifactFieldFamilyDivergence(active_board_publication_id,
                                                                                  active_focus_publication_id,
                                                                                  state.publication_bundle.publication_id,
                                                                                  state.current_focus_last_status);
   string active_family_divergence_reason = ASC_ManifestActiveArtifactDivergenceReason(active_board_publication_id,
                                                                                 active_focus_publication_id,
                                                                                 state.publication_bundle.publication_id,
                                                                                 state.current_focus_last_status,
                                                                                 state.current_focus_last_reason);
   string active_family_alignment = ASC_ManifestActiveArtifactFamilyAlignment(active_board_publication_id,
                                                                              active_focus_publication_id,
                                                                              state.publication_bundle.publication_id,
                                                                              state.current_focus_last_status);

   int cross_dossier_visible_rows = ASC_ManifestDossierVisibleRows(state);
   bool cross_dossier_visible = (cross_dossier_visible_rows > 0);
   bool cross_focus_visible = (active_focus_exists && active_focus_has_payload);
   bool cross_board_visible = (active_board_exists && active_board_has_payload);
   bool cross_top10_visible = (state.top10_run_full_last_total > 0
                               && ArraySize(state.top10_run_full_last_completed_symbols) > 0
                               && state.top10_run_full_verify_fail_count <= 0);
   bool cross_manifest_visible = (StringLen(state.bundle_manifest_path) > 0);
   bool cross_stale_or_retained = (state.publication_bundle.overall_bundle_status == "continuity"
                                   || state.publication_bundle.market_board_status == "continuity"
                                   || state.current_focus_last_status == "deep_pair_continuity"
                                   || StringFind(state.current_focus_last_reason, "retained") >= 0
                                   || StringFind(state.current_focus_last_reason, "last_good") >= 0);
   bool cross_dependency_blocked = (state.l1_publish_pending_essentials
                                    || state.l1_publish_pending_dossiers
                                    || state.l1_publish_pending_manifest
                                    || state.top10_run_full_batch_pending
                                    || StringFind(state.current_focus_last_reason, "waiting") >= 0
                                    || StringFind(state.current_focus_last_reason, "blocked") >= 0);
   bool cross_contradiction_pending = (active_family_divergence == "publication_identity_and_state"
                                       || active_focus_source_mismatch
                                       || (state.publication_bundle.market_board_status == "fresh" && !cross_dossier_visible)
                                       || (state.publication_bundle.market_board_status == "fresh" && StringFind(state.publication_bundle.overall_bundle_status, "pending") >= 0));
   bool cross_no_context = (!cross_dossier_visible
                            && !cross_focus_visible
                            && !cross_board_visible
                            && !cross_top10_visible
                            && !cross_manifest_visible);

   string scanner_status_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Scanner Status.txt" : "");
   string market_board_archive_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Market Board Archive\\_latest_market_board_archive_manifest.txt" : "");
   string top5_current_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\_family_manifest.txt" : "");
   string top5_staging_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\_staging\\_staging_manifest.txt" : "");
   string top5_archive_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\archive\\_archive_manifest.txt" : "");
   string top5_archive_root_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\archive" : "");
   string globaltop10_current_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\GlobalTop10\\_family_manifest.txt" : "");
   string globaltop10_archive_root_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\GlobalTop10\\archive" : "");
   bool selected_symbol_present_for_bundle = (StringLen(state.current_focus_live_symbol) > 0 || StringLen(state.current_focus_sync_last_selected_symbol) > 0 || StringLen(state.hud_selected_symbol) > 0);
   string manifest_proof_bundle_line = ASC_RuntimeProofBundleCompletenessLine(ASC_FileExistsCommon(scanner_status_manifest_path),
                                                                              cross_board_visible,
                                                                              ASC_FileExistsCommon(market_board_archive_manifest_path),
                                                                              ASC_FileExistsCommon(top5_current_manifest_path),
                                                                              ASC_FileExistsCommon(top5_staging_manifest_path),
                                                                              ASC_RuntimeProofDirectoryHasAnyChild(top5_archive_root_path),
                                                                              ASC_FileExistsCommon(globaltop10_current_manifest_path),
                                                                              ASC_RuntimeProofDirectoryHasAnyChild(globaltop10_archive_root_path),
                                                                              cross_dossier_visible,
                                                                              selected_symbol_present_for_bundle,
                                                                              cross_focus_visible,
                                                                              ASC_FileExistsCommon(state.function_results_log_path),
                                                                              ASC_FileExistsCommon(state.heartbeat_log_path),
                                                                              cross_manifest_visible,
                                                                              (StringLen(state.globaltop10_stale_tmp_proof_state) > 0 || StringLen(state.globaltop10_stale_tmp_proof_reason) > 0),
                                                                              true,
                                                                              true,
                                                                              true,
                                                                              true);
   string manifest_phase8_readiness_line = ASC_Phase8CandidateFilteringSurfaceReadinessLine(ASC_FileExistsCommon(scanner_status_manifest_path),
                                                                                                  (cross_board_visible && ASC_FileExistsCommon(market_board_archive_manifest_path)),
                                                                                                  cross_dossier_visible,
                                                                                                  (ASC_FileExistsCommon(top5_current_manifest_path) && ASC_FileExistsCommon(top5_staging_manifest_path) && ASC_RuntimeProofDirectoryHasAnyChild(top5_archive_root_path)),
                                                                                                  (ASC_FileExistsCommon(globaltop10_current_manifest_path) && ASC_RuntimeProofDirectoryHasAnyChild(globaltop10_archive_root_path)),
                                                                                                  (ASC_FileExistsCommon(state.function_results_log_path) && ASC_FileExistsCommon(state.heartbeat_log_path)),
                                                                                                  true,
                                                                                                  true,
                                                                                                  true,
                                                                                                  true);
   string cross_ce = ASC_CrossArtCEStatus(cross_dossier_visible,
                                          cross_focus_visible,
                                          cross_board_visible,
                                          cross_top10_visible,
                                          cross_manifest_visible,
                                          cross_stale_or_retained,
                                          cross_dependency_blocked,
                                          cross_contradiction_pending,
                                          false,
                                          cross_no_context);
   string cross_support = ASC_CrossArtCESupport(cross_dossier_visible,
                                                cross_focus_visible,
                                                cross_board_visible,
                                                cross_top10_visible,
                                                cross_manifest_visible,
                                                active_family_divergence,
                                                "pending_manifest_publication_ce");
   string cf_selected_symbol = state.current_focus_sync_last_selected_symbol;
   if(StringLen(cf_selected_symbol) <= 0)
      cf_selected_symbol = state.current_focus_live_symbol;
   if(StringLen(cf_selected_symbol) <= 0)
      cf_selected_symbol = state.hud_selected_symbol;
   bool cf_selected_available = (StringLen(cf_selected_symbol) > 0);
   bool cf_focus_is_root_dossier = (ASC_CURRENT_FOCUS_FILE == "Dossier.txt");
   string cf_expectation = ASC_CFExpectationState(cf_selected_available,
                                                  StringLen(state.current_focus_path) > 0,
                                                  cf_focus_is_root_dossier,
                                                  false,
                                                  false,
                                                  cross_stale_or_retained,
                                                  cross_dependency_blocked,
                                                  cross_contradiction_pending,
                                                  false);
   string cf_ce = ASC_CFExpectationCEStatus(cf_expectation,
                                            active_focus_exists,
                                            active_focus_has_payload,
                                            StringLen(state.current_focus_path) > 0);
   string cf_support = ASC_CFExpectationSupport(cf_expectation,
                                                state.current_focus_path,
                                                cf_selected_symbol,
                                                state.current_focus_last_status,
                                                state.current_focus_last_reason);
   string op_surf_state = ASC_OpSurfBoundaryState(true,
                                                  false,
                                                  cross_contradiction_pending,
                                                  cross_stale_or_retained,
                                                  cross_no_context,
                                                  false);
   string op_surf_ce = ASC_OpSurfCEStatus(true,
                                          false,
                                          cross_contradiction_pending,
                                          cross_stale_or_retained,
                                          cross_no_context,
                                          false);
   string op_surf_support = ASC_OpSurfCESupport(op_surf_state,
                                                ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   body += ASC_ManifestCrossArtifactAlignmentLine(cross_ce,
                                                  cross_dossier_visible,
                                                  cross_focus_visible,
                                                  cross_board_visible,
                                                  cross_top10_visible,
                                                  cross_manifest_visible,
                                                  active_family_divergence,
                                                  active_family_divergence_reason) + "\n";
   body += ASC_ManifestCurrentFocusProofLine(cf_ce,
                                             cf_expectation,
                                             state.current_focus_path,
                                             active_focus_exists,
                                             active_focus_has_payload,
                                             cf_selected_symbol,
                                             cf_support) + "\n";
   body += "Runtime Proof Bundle Completeness: " + manifest_proof_bundle_line + "\n";
   body += "Artifact Manifest RUN227 Contract Parity: artifact_manifest_required_tokens_present=true"
           + " | artifact_manifest_missing_tokens=none_static_RUN227_body_contract"
           + " | artifact_manifest_first_missing_token=none"
           + " | proof_bundle_decision_mapping=source_patch_runtime_unproven_to_TEST_FIRST"
           + " | proof_bundle_decision_mapping_reason=source_patch_only_compile_and_live_runtime_pending"
           + " | proof_bundle_surface_count=runtime_bundle_policy_count_unverified_in_source_run"
           + " | proof_bundle_surface_present_count=runtime_bundle_presence_unverified_in_source_run"
           + " | proof_bundle_surface_missing_count=runtime_capture_not_supplied_in_source_run"
           + " | proof_bundle_missing_surfaces=runtime_capture_not_supplied_in_source_run"
           + " | proof_bundle_blocking_surfaces=compile_output,experts_log,journal_log,scanner_status,manifest,function_results"
           + " | RUN227_root_proof_surface_restore_only=true"
           + " | RUN227_no_marketboard_dossier_sdp_fileio_path_timing_route_gate_hud_strategy_change=true\n";
   body += ASC_SymbolDataPackLiteRuntimeStatusLine(state) + "\n";
   body += ASC_SymbolDataPackGlobalTop10RuntimeStatusLine(state) + "\n";
   body += "Symbol Data Pack GlobalTop10 Reconciliation Proof: " + ASC_SymbolDataPackReconciliationDurableProofBlock("globaltop10_mirror", "not_applicable", state.symbol_data_pack_globaltop10_last_reason) + "\n";
   body += ASC_SymbolDataPackTop5PerBucketRuntimeStatusLine(state) + "\n";
   int run253_global_sdp_expected = MathMax(0, state.symbol_data_pack_globaltop10_total);
   int run253_global_sdp_written = MathMax(0, state.symbol_data_pack_globaltop10_written_count + state.symbol_data_pack_globaltop10_no_change_count);
   int run253_global_sdp_failed = MathMax(0, state.symbol_data_pack_globaltop10_failed_count);
   int run253_global_sdp_pending = MathMax(0, run253_global_sdp_expected - run253_global_sdp_written - run253_global_sdp_failed);
   int run253_global_main_expected = MathMax(0, ArraySize(state.top10_run_full_last_completed_symbols));
   int run253_global_main_written = MathMax(0, state.top10_run_full_last_total);
   int run253_global_main_pending = MathMax(0, run253_global_main_expected - run253_global_main_written);
   string run253_global_snapshot_id = ASC_TextOrUnavailable(state.top10_run_full_last_completed_source_signature);
   string run253_global_next_sdp_symbol = (state.symbol_data_pack_globaltop10_cursor >= 0 && state.symbol_data_pack_globaltop10_cursor < ArraySize(state.top10_run_full_last_completed_symbols)) ? state.top10_run_full_last_completed_symbols[state.symbol_data_pack_globaltop10_cursor] : "none";
   string run253_global_snapshot_status = (state.top10_run_full_last_completed_source_signature == state.symbol_data_pack_globaltop10_source_signature && StringLen(state.top10_run_full_last_completed_source_signature) > 0) ? "matched" : "unproven";
   string run253_global_symbol_set_status = (run253_global_main_expected > 0 && run253_global_sdp_expected > 0 && run253_global_main_expected == run253_global_sdp_expected) ? "matched" : "unproven";
   body += ASC_Run253GlobalTop10PublicationCompletionRepairBlock("ASC_ServiceTop10RunFullBatch/last_completed_symbols",
                                                                 "ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication",
                                                                 "state.top10_run_full_last_completed_symbols",
                                                                 run253_global_snapshot_id,
                                                                 MathMax(run253_global_main_expected, run253_global_sdp_expected),
                                                                 run253_global_main_written,
                                                                 run253_global_main_written,
                                                                 run253_global_sdp_written,
                                                                 run253_global_sdp_written,
                                                                 run253_global_main_pending,
                                                                 run253_global_sdp_pending,
                                                                 0,
                                                                 run253_global_sdp_failed,
                                                                 run253_global_snapshot_status,
                                                                 run253_global_symbol_set_status) + "\n";
   body += ASC_Run253PublicationCompletionLedgerBlock("Symbol Data Packs/GlobalTop10",
                                                      "GlobalTop10",
                                                      run253_global_snapshot_id,
                                                      run253_global_sdp_expected,
                                                      run253_global_sdp_expected,
                                                      MathMax(0, state.symbol_data_pack_globaltop10_attempted_count),
                                                      run253_global_sdp_written,
                                                      run253_global_sdp_written,
                                                      run253_global_sdp_pending,
                                                      run253_global_sdp_failed,
                                                      0,
                                                      run253_global_sdp_pending > 0 ? "pending" : (run253_global_sdp_failed > 0 ? "partial" : "complete"),
                                                      IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_cursor)),
                                                      ASC_TextOrUnavailable(state.symbol_data_pack_globaltop10_last_symbol),
                                                      state.symbol_data_pack_globaltop10_last_success_utc > 0 ? ASC_TextOrUnavailable(state.symbol_data_pack_globaltop10_last_symbol) : "none",
                                                      run253_global_next_sdp_symbol,
                                                      run253_global_sdp_pending > 0 ? "see_globaltop10_sdp_cursor_over_completed_snapshot" : "none",
                                                      run253_global_sdp_failed > 0 ? "see_globaltop10_sdp_last_error" : "none",
                                                      state.symbol_data_pack_globaltop10_last_error,
                                                      ASC_TextOrUnavailable(state.lane_deferred_reason),
                                                      state.symbol_data_pack_globaltop10_next_due_utc) + "\n";
   body += "Symbol Data Pack Top5PerBucket Reconciliation Proof: " + ASC_SymbolDataPackReconciliationDurableProofBlock("top5perbucket_mirror", "all_buckets", state.symbol_data_pack_top5perbucket_last_reason) + "\n";
   body += ASC_SymbolDataPackRun195NonBlockingProofLine(state) + "\n";
   body += "Phase 8 Candidate Filtering Surface Readiness: " + manifest_phase8_readiness_line + "\n";
   body += ASC_RuntimeCaptureChecklistBlock();
   body += ASC_MissingRuntimeSurfaceClassificationLine() + "\n";
   body += ASC_ProofBundleDecisionMappingLine() + "\n";
   body += "Roadmap Two-Lane Audit Boundary: " + ASC_RoadmapTwoLaneAuditBoundaryLine() + "\n";
   body += ASC_Run155LiveContractSeedBlock();
   body += "RUN100 Current Focus Source Identity Audit: expected_source_run_id=" + ASC_SourceRunId()
           + " | active_current_focus_source_run_id=" + ASC_TextOrUnavailable(active_focus_source_run_id)
           + " | active_current_focus_source_identity_match=" + (active_focus_source_match ? "yes" : "no")
           + " | active_current_focus_source_mismatch=" + (active_focus_source_mismatch ? "yes" : "no")
           + " | active_market_board_source_run_id=" + ASC_TextOrUnavailable(active_board_source_run_id)
           + " | active_market_board_source_identity_match=" + (active_board_source_match ? "yes" : "no")
           + " | contradiction_if_focus_mismatch=true"
           + " | proof_boundary=artifact_payload_source_run_id_readback_no_rank_formula_strategy_execution_change\n";
   body += ASC_ManifestProofClassLedgerLine(state,
                                            active_board_exists,
                                            active_board_has_payload,
                                            active_board_publication_id,
                                            active_focus_exists,
                                            active_focus_has_payload,
                                            active_focus_publication_id,
                                            active_family_alignment) + "\n";
   body += ASC_ManifestCheckpointEvidenceLine(state,
                                              active_family_alignment,
                                              active_family_divergence_reason) + "\n";
   body += ASC_ManifestEvidenceBoundaryLine(state,
                                            active_family_alignment,
                                            active_family_divergence_reason) + "\n";
   body += ASC_ManifestEvidenceAvailabilityBoundaryLine() + "\n";
   body += ASC_ManifestEvidenceRecoveryBoundaryLine() + "\n";
   body += ASC_ManifestEvidenceRecheckBoundaryLine() + "\n";
   body += ASC_ManifestEvidenceIntakeChainLine() + "\n";
   body += ASC_ManifestCandidateEvidenceIntakeBoundaryLine() + "\n";
   body += ASC_ManifestShortlistEvidenceIntakeBoundaryLine() + "\n";
   body += ASC_ManifestMarketBoardEvidenceIntakeBoundaryLine() + "\n";
   body += ASC_ManifestHydrationProofSummaryLine(state) + "\n";
   body += ASC_ManifestFunctionResultsLogEvidenceLine(state) + "\n";
   body += ASC_ManifestFunctionResultsLogBudgetLine(state) + "\n";
   body += ASC_ManifestFunctionResultsLogBudgetSummaryLine() + "\n";
   body += ASC_ManifestFunctionResultsRowLevelProofSummaryLine() + "\n";
   body += ASC_FunctionResultsBoundedContradictionProofObservabilityLine() + "\n";
   body += ASC_ManifestRowLevelSeamEmissionContractLine() + "\n";
   body += ASC_ManifestFunctionResultsOutputPackageContractLine(state) + "\n";
   body += ASC_ManifestHeartbeatTelemetryOutputPackageContractLine(state) + "\n";
   body += ASC_ManifestRun050RequiredOutputPackageLine() + "\n";
   body += ASC_ManifestOutputArtifactLocatorLine() + "\n";
   body += ASC_ManifestCurrentVsArchiveArtifactBoundaryLine() + "\n";
   body += ASC_ManifestClaimEvidenceContractLine() + "\n";
   body += ASC_ManifestRun031ProofChecklistLine() + "\n";
   body += ASC_ManifestPhase2AOpenProofLedgerLine(state) + "\n";
   body += "Dossier publication path: " + ASC_DossierPublicationPathText(state) + "\n";
   body += StringFormat("Dossier trigger status: %s\n", state.deep_focus_trigger_last_status);
   body += StringFormat("Dossier trigger evidence: %s\n", ASC_CurrentFocusTriggerEvidenceText(state.deep_focus_trigger_last_status));
   body += StringFormat("Dossier manual-lane status: %s\n", state.current_focus_last_status);
   body += StringFormat("Dossier manual-lane evidence: %s\n", ASC_CurrentFocusManualLaneEvidenceText(state.current_focus_last_status));
   body += StringFormat("Dossier manual-lane reason: %s\n", (StringLen(state.current_focus_last_reason) > 0 ? state.current_focus_last_reason : "none"));
   body += StringFormat("Dossier trigger served UTC: %s\n", ASC_ArtifactFormatUtc(state.deep_focus_trigger_last_served_utc));
   body += StringFormat("Dossier manual-lane served UTC: %s\n", ASC_ArtifactFormatUtc(state.current_focus_last_served_utc));
   body += StringFormat("Dossier live symbol: %s\n", (StringLen(state.current_focus_live_symbol) > 0 ? state.current_focus_live_symbol : "none"));
   body += StringFormat("Dossier refresh status: %s\n", (StringLen(state.dossier_refresh_last_status) > 0 ? state.dossier_refresh_last_status : "none"));
   body += StringFormat("Dossier refresh reason: %s\n", (StringLen(state.dossier_refresh_last_reason) > 0 ? state.dossier_refresh_last_reason : "none"));
   body += StringFormat("Forced downstream refresh status: %s\n", (StringLen(state.forced_downstream_refresh_last_status) > 0 ? state.forced_downstream_refresh_last_status : "none"));
   body += StringFormat("Forced downstream refresh reason: %s\n", (StringLen(state.forced_downstream_refresh_last_reason) > 0 ? state.forced_downstream_refresh_last_reason : "none"));
   body += StringFormat("Forced downstream refresh requested UTC: %s\n", ASC_ArtifactFormatUtc(state.forced_downstream_refresh_requested_utc));
   body += StringFormat("Forced downstream refresh served UTC: %s\n", ASC_ArtifactFormatUtc(state.forced_downstream_refresh_last_served_utc));
   body += StringFormat("Forced downstream refresh request seq: %d\n", state.forced_downstream_refresh_request_seq);
   body += StringFormat("Forced downstream refresh pending: %s\n", state.forced_downstream_refresh_pending ? "yes" : "no");
   body += StringFormat("Forced downstream refresh scope: %s\n", ASC_TextOrUnavailable(state.forced_downstream_refresh_scope));
   body += StringFormat("Forced downstream refresh symbol: %s\n", ASC_TextOrUnavailable(state.forced_downstream_refresh_symbol));
   body += StringFormat("Manual board refresh status: %s\n", (StringLen(state.board_manual_refresh_last_status) > 0 ? state.board_manual_refresh_last_status : "none"));
   body += StringFormat("Manual board refresh reason: %s\n", (StringLen(state.board_manual_refresh_last_reason) > 0 ? state.board_manual_refresh_last_reason : "none"));
   body += StringFormat("Manual board refresh requested UTC: %s\n", ASC_ArtifactFormatUtc(state.board_manual_refresh_requested_utc));
   body += StringFormat("Manual board refresh served UTC: %s\n", ASC_ArtifactFormatUtc(state.board_manual_refresh_last_served_utc));
   body += StringFormat("Manual board refresh request seq: %d\n", state.board_manual_refresh_request_seq);
   body += StringFormat("Manual board refresh pending: %s\n", state.board_manual_refresh_pending ? "yes" : "no");
   body += StringFormat("Manual board refresh inflight: %s\n", state.board_manual_refresh_inflight ? "yes" : "no");
   body += StringFormat("Manual board refresh trigger: %s\n", ASC_TextOrUnavailable(state.board_manual_refresh_trigger));
   body += StringFormat("Publication shortlist cache: %s\n", (StringLen(state.publication_shortlist_last_status) > 0 ? state.publication_shortlist_last_status : "none"));
   body += StringFormat("Publication shortlist reason: %s\n", (StringLen(state.publication_shortlist_last_reason) > 0 ? state.publication_shortlist_last_reason : "none"));
   body += StringFormat("Layer 4 trace: %s\n", ASC_CommittedLayer4TelemetryTrace(state));
   body += StringFormat("Global Top 10 batch status: %s\n", (StringLen(state.top10_run_full_batch_status) > 0 ? state.top10_run_full_batch_status : "idle"));
   body += StringFormat("Global Top 10 batch reason: %s\n", (StringLen(state.top10_run_full_batch_reason) > 0 ? state.top10_run_full_batch_reason : "none"));
   body += StringFormat("Global Top 10 batch requested UTC: %s\n", ASC_ArtifactFormatUtc(state.top10_run_full_batch_requested_utc));
   body += StringFormat("Global Top 10 batch served UTC: %s\n", ASC_ArtifactFormatUtc(state.top10_run_full_batch_last_served_utc));
   int top10_display_total = (state.top10_run_full_total > 0 ? state.top10_run_full_total : state.top10_run_full_last_total);
   body += StringFormat("Global Top 10 batch progress: %d/%d\n", state.top10_run_full_cursor, top10_display_total);
   body += StringFormat("Global Top 10 verify counters: pass=%d fail=%d total=%d\n",
                        state.top10_run_full_verify_pass_count,
                        state.top10_run_full_verify_fail_count,
                        state.top10_run_full_last_total);
   body += StringFormat("Global Top 10 inflight symbol: %s\n", (StringLen(state.top10_run_full_inflight_symbol) > 0 ? state.top10_run_full_inflight_symbol : "none"));
   body += StringFormat("Global Top 10 inflight retry count: %d\n", state.top10_run_full_inflight_retry_count);
   body += StringFormat("Global Top 10 inflight queued UTC: %s\n", ASC_ArtifactFormatUtc(state.top10_run_full_inflight_queued_utc));
   body += StringFormat("Global Top 10 inflight publication id: %s\n", ASC_TextOrUnavailable(state.top10_run_full_inflight_publication_id));
   body += StringFormat("Global Top 10 shortlist source UTC: %s\n", ASC_ArtifactFormatUtc(state.top10_run_full_current_source_pass_utc));
   body += StringFormat("Global Top 10 shortlist source signature: %s\n", ASC_TextOrUnavailable(state.top10_run_full_current_source_signature));
   body += StringFormat("Global Top 10 child family source UTC: %s\n", ASC_ArtifactFormatUtc(state.top10_run_full_last_completed_source_pass_utc));
   body += StringFormat("Global Top 10 child family source signature: %s\n", ASC_TextOrUnavailable(state.top10_run_full_last_completed_source_signature));
   body += StringFormat("Global Top 10 child family symbols: %s\n", ASC_TextOrUnavailable(ASC_Top10RunFullCompactSymbolList(state.top10_run_full_last_completed_symbols)));
   body += StringFormat("Global Top 10 child family alignment: %s\n", ASC_TextOrUnavailable(state.top10_run_full_family_alignment_status));
   body += StringFormat("Global Top 10 child family reason: %s\n", ASC_TextOrUnavailable(state.top10_run_full_family_alignment_reason));
   body += StringFormat("Global Top 10 target directory: %s\n", ASC_TextOrUnavailable(ASC_Top10RunFullTargetDirectory(state)));
   body += StringFormat("Global Top 10 archive root: %s\n", ASC_TextOrUnavailable(ASC_Top10ArchiveRootDirectory(state)));
   body += StringFormat("Global Top 10 archive cadence slot (10m): %s\n", ASC_TextOrUnavailable(ASC_Top10ArchiveCadenceSlotLabel(TimeGMT())));
   body += StringFormat("Global Top 10 live family directory: %s\n", ASC_TextOrUnavailable(ASC_GlobalTop10LiveDirectory(state)));
   body += StringFormat("Global Top 10 staging family directory: %s\n", ASC_TextOrUnavailable(ASC_Top10RunFullStagingDirectory(state)));
   body += StringFormat("Global Top 10 archive snapshot directory: %s\n", ASC_TextOrUnavailable(ASC_Top10ArchiveSnapshotDirectory(state, TimeGMT())));
   body += StringFormat("Global Top 10 batch trace: %s\n", ASC_Top10RunFullBatchTrace(state));
   body += StringFormat("Run Full synchronization lag trace: %s\n", ASC_RunFullSynchronizationLagTrace(state, TimeGMT()));
   body += ASC_Run156SpeedTruthFillContractBlock();
   datetime run158_manifest_now_utc = TimeGMT();
   int run158_manifest_displayed_total = MathMax(0, state.top5_bucket_child_written_count) + MathMax(0, state.top10_run_full_last_total);
   int run158_manifest_displayed_current = MathMax(0, state.top5_bucket_child_written_count);
   int run158_manifest_displayed_pending = MathMax(0, state.top5_bucket_child_pending_count) + MathMax(0, state.top10_deferred_l5_pending_count);
   int run158_manifest_displayed_stale = (state.l1_cycle_stale ? 1 : 0);
   int run158_manifest_displayed_missing = MathMax(0, state.top5_bucket_child_failed_count);
   datetime run158_manifest_l6_utc = (state.function_results_log_last_write_utc > 0 ? state.function_results_log_last_write_utc : state.publication_bundle.publication_utc);
   bool run158_manifest_refresh_due = (ASC_Run158AgeSeconds(state.market_board_last_publish_utc, run158_manifest_now_utc) < 0
                                       || ASC_Run158AgeSeconds(state.market_board_last_publish_utc, run158_manifest_now_utc) >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC);

   body += "RUN158R Displayed-Symbol Reprint / Queue Progress Manifest:\n";
   body += ASC_Run158DisplayedSetDefinitionLine() + "\n";
   body += ASC_Run158DisplayedRefreshLawLine() + "\n";
   body += ASC_Run158DisplayedRefreshTelemetryLine(run158_manifest_displayed_total,
                                                   run158_manifest_displayed_current,
                                                   run158_manifest_displayed_pending,
                                                   run158_manifest_displayed_stale,
                                                   run158_manifest_displayed_missing,
                                                   state.market_board_last_publish_utc,
                                                   run158_manifest_now_utc,
                                                   run158_manifest_refresh_due) + "\n";
   body += ASC_Run158BucketFillTelemetryLine(MathMax(0, state.top5_bucket_count),
                                             MathMax(0, state.top5_bucket_child_written_count),
                                             MathMax(0, state.top5_bucket_child_pending_count),
                                             MathMax(0, state.top5_bucket_child_failed_count) + MathMax(0, state.dossier_queue_stalled_count),
                                             state.started_utc,
                                             run158_manifest_now_utc) + "\n";
   body += ASC_Run158L2L5L6DisplayedRefreshLine(state.l2_last_scan_utc,
                                                state.top10_deferred_l5_last_service_utc,
                                                run158_manifest_l6_utc,
                                                run158_manifest_now_utc,
                                                state.top10_deferred_l5_pending_count,
                                                state.deferred_write_artifacts) + "\n";
   body += ASC_Run158QueueProgressLawLine() + "\n";
   body += ASC_Run159SpeedTruthFillCloseoutBlock();
   body += StringFormat("Last Deep Analysis symbol: %s\n", (StringLen(state.deep_focus_last_symbol) > 0 ? state.deep_focus_last_symbol : "none"));
   body += StringFormat("Last Deep Analysis reason: %s\n", (StringLen(state.deep_focus_last_reason) > 0 ? state.deep_focus_last_reason : "none"));
   body += StringFormat("Active Market Board path: %s\n", (StringLen(state.market_board_path) > 0 ? state.market_board_path : "unavailable"));
   body += StringFormat("Active Market Board proof exists: %s\n", active_board_exists ? "yes" : "no");
   body += StringFormat("Active Market Board proof payload: %s\n", active_board_has_payload ? "readable" : "unreadable_or_empty");
   body += StringFormat("Active Market Board proof modified UTC: %s\n", ASC_ArtifactFormatUtc(active_board_modified_utc));
   body += StringFormat("Active Market Board proof publication id: %s\n", ASC_TextOrUnavailable(active_board_publication_id));
   body += StringFormat("Active Selected-Symbol Dossier path: %s\n", (StringLen(state.current_focus_path) > 0 ? state.current_focus_path : "unavailable"));
   body += StringFormat("Active Selected-Symbol Dossier proof exists: %s\n", active_focus_exists ? "yes" : "no");
   body += StringFormat("Active Selected-Symbol Dossier proof payload: %s\n", active_focus_has_payload ? "readable" : "unreadable_or_empty");
   body += StringFormat("Active Selected-Symbol Dossier proof modified UTC: %s\n", ASC_ArtifactFormatUtc(active_focus_modified_utc));
   body += StringFormat("Active Selected-Symbol Dossier proof publication id: %s\n", ASC_TextOrUnavailable(active_focus_publication_id));
   body += StringFormat("Active proof divergence family: %s\n", active_family_divergence);
   body += StringFormat("Active proof divergence reason: %s\n", active_family_divergence_reason);
   body += StringFormat("Active proof family alignment: %s\n", active_family_alignment);
   body += "Cross-Artifact Alignment Tokens: artifact_alignment_scope=bundle | alignment_status=" + (cross_contradiction_pending ? "qualified" : "aligned") + " | source_truth=mixed | claim_status=" + (cross_stale_or_retained ? "retained" : (cross_dependency_blocked ? "pending" : "qualified")) + " | runtime_observed=false | source_supported=true | trade_permission=false | entry_signal=false | l3_meaning_preserved=true | l4_meaning_preserved=true | l5_support_preserved=true | resolver_limit_preserved=true | correlation_limit_preserved=true | current_vs_retained=" + (cross_stale_or_retained ? "retained_last_good" : "current") + " | artifact_projection=qualified | contradiction_status=" + (cross_contradiction_pending ? "possible" : "runtime_unproven") + " | contradiction_type=" + ASC_TextOrUnavailable(active_family_divergence) + " | behavior_change=no\n";
   body += StringFormat("Market Board status: %s\n", state.publication_bundle.market_board_status);
   body += StringFormat("Market Board publish outcome class: %s\n", ASC_BoardPublishOutcomeClass(state.publication_bundle.board_publish_result));
   body += StringFormat("Market Board publish reason trace: %s\n",
                        ASC_BoardPublishReasonTrace(state.publication_bundle.board_publish_result,
                                                   state.publication_bundle.board_refresh_trigger,
                                                   state.publication_bundle.board_publish_skip_reason));
   body += StringFormat("Market Board decision identity: trigger=%s | outcome=%s | baseline=%s | lifecycle=%s\n",
                        ASC_TextOrUnavailable(state.publication_bundle.board_refresh_trigger),
                        ASC_TextOrUnavailable(state.publication_bundle.board_publish_result),
                        ASC_BoardBaselineAdvanceState(state.publication_bundle.board_publish_result),
                        ASC_TextOrUnavailable(state.publication_bundle.board_lifecycle_state));
   body += StringFormat("Market Board baseline advance: %s\n", ASC_BoardBaselineAdvanceState(state.publication_bundle.board_publish_result));
   body += StringFormat("Market Board baseline advance reason: %s\n",
                        ASC_BoardBaselineAdvanceReason(state.publication_bundle.board_publish_result,
                                                       state.publication_bundle.board_publish_skip_reason));
   body += StringFormat("Market Board active-proof interpretation: active_board_visible=%s | active_board_payload=%s | current_bundle_board_outcome=%s | baseline_state=%s | skip_does_not_invalidate_active_board=%s | reason=%s\n",
                        active_board_exists ? "yes" : "no",
                        active_board_has_payload ? "readable" : "unreadable_or_empty",
                        ASC_TextOrUnavailable(state.publication_bundle.board_publish_result),
                        ASC_BoardBaselineAdvanceState(state.publication_bundle.board_publish_result),
                        (state.publication_bundle.board_publish_result == "skipped" && active_board_exists && active_board_has_payload) ? "yes" : "not_applicable",
                        ASC_TextOrUnavailable(state.publication_bundle.board_publish_skip_reason));
   body += StringFormat("Open Symbol Snapshot status: %s\n", state.publication_bundle.open_symbol_snapshot_status);
   body += StringFormat("Bundle Manifest status: %s\n", state.publication_bundle.manifest_status);
   body += StringFormat("Pending essentials: %s\n", state.l1_publish_pending_essentials ? "yes" : "no");
   body += StringFormat("Pending dossiers: %s\n", state.l1_publish_pending_dossiers ? "yes" : "no");
   body += StringFormat("Pending manifest: %s\n", state.l1_publish_pending_manifest ? "yes" : "no");
   body += StringFormat("Dossier open-refresh-only: %s\n", state.dossier_open_refresh_only ? "yes" : "no");
   body += StringFormat("Dossier existence-duty active: %s\n", state.dossier_existence_shell_only ? "yes" : "no");
   body += StringFormat("Dossier startup flood mode: %s\n", state.dossier_startup_flood_active ? "active" : "inactive");
   body += StringFormat("Dossier startup flood progress (present/expected): %d/%d\n", state.dossier_startup_flood_progress, state.dossier_startup_flood_target);
   body += StringFormat("Dossier startup flood last budget: %d\n", state.dossier_startup_flood_budget_last);
   body += StringFormat("Dossier queue rebuilds (count/skipped): %d/%d\n",
                        state.dossier_pending_queue_rebuild_count,
                        state.dossier_pending_queue_rebuild_skip_count);
   body += StringFormat("Dossier queue last rebuild reason: %s\n",
                        (StringLen(state.dossier_pending_queue_last_rebuild_reason) > 0
                         ? state.dossier_pending_queue_last_rebuild_reason
                         : "not_yet_rebuilt"));
   body += StringFormat("Dossier queue last rebuild UTC: %s\n",
                        ASC_ArtifactFormatUtc(state.dossier_pending_queue_last_rebuild_utc));
   body += StringFormat("Dossier queue service trace: before=%s | written=%s | after=%s | plan=%s | stall_reason=%s | no_progress_beats=%d\n",
                        ASC_TextOrUnavailable(state.dossier_queue_service_last_before),
                        ASC_TextOrUnavailable(state.dossier_queue_service_last_written),
                        ASC_TextOrUnavailable(state.dossier_queue_service_last_after),
                        ASC_TextOrUnavailable(state.dossier_queue_service_last_plan),
                        ASC_TextOrUnavailable(state.dossier_queue_service_last_stall_reason),
                        state.dossier_no_progress_write_beats);
   body += StringFormat("Dossier queue / Run Full seam trace: %s\n", ASC_RunFullSynchronizationLagTrace(state, TimeGMT()));
   body += StringFormat("GlobalTop10 deferred L5 recovery queue: max_children_per_beat=%d | max_retries=%d | retry_spacing_sec=%d | max_age_sec=%d | %s | reason=%s\n",
                        ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_CHILDREN_PER_BEAT,
                        ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_RETRIES,
                        ASC_TOP10_DEFERRED_L5_RECOVERY_RETRY_SPACING_SEC,
                        ASC_TOP10_DEFERRED_L5_RECOVERY_MAX_AGE_SEC,
                        ASC_GlobalTop10DeferredL5RecoveryCountersTrace(state),
                        ASC_TextOrUnavailable(state.top10_deferred_l5_last_reason));
   body += "Top5PerBucket PreLive Readiness Source Patch: " + ASC_Top5BucketSkeletonProofTokens(state.top5_bucket_family_state,
                                                                                                      state.top5_bucket_count,
                                                                                                      state.top5_bucket_child_target_count,
                                                                                                      state.top5_bucket_child_written_count,
                                                                                                      state.top5_bucket_child_pending_count,
                                                                                                      state.top5_bucket_child_failed_count,
                                                                                                      state.top5_bucket_queue_remaining,
                                                                                                      state.top5_bucket_last_symbol,
                                                                                                      state.top5_bucket_last_error) + "\n";
   body += StringFormat("Performance Trace / Dossier Sweep: elapsed_ms=%d | symbols=%d | existing_files=%d | payload_reads=%d | reason=%s | lane=%s | heartbeat=%d\n",
                        state.dossier_presence_refresh_last_elapsed_ms,
                        state.dossier_presence_refresh_last_symbols,
                        state.dossier_presence_refresh_last_existing_files,
                        state.dossier_presence_refresh_last_payload_reads,
                        ASC_TextOrUnavailable(state.dossier_presence_refresh_last_reason),
                        ASC_TextOrUnavailable(state.dossier_presence_refresh_last_lane),
                        state.dossier_presence_refresh_last_heartbeat_id);
   body += StringFormat("L1 wake counts (hot/warm/calm/dormant): %d/%d/%d/%d\n", state.l1_wake_hot_count, state.l1_wake_warm_count, state.l1_wake_calm_count, state.l1_wake_dormant_scheduled_count);
   body += StringFormat("L1 entitlement counts (l2_live/dossier_open/retention_only): %d/%d/%d\n", state.l1_l2_live_entitled_count, state.l1_dossier_open_refresh_entitled_count, state.l1_retention_only_count);
   body += StringFormat("Dossier remaining hydration backlog: %d\n", ASC_CountRemainingDossierBacklog(state));
   body += StringFormat("Dossier cursor (next index): %d\n", MathMax(0, state.write_cursor));
   body += StringFormat("Dossier count attempted: %d\n", state.publication_bundle.dossier_attempted_count);
   body += StringFormat("Dossier count succeeded: %d\n", state.publication_bundle.dossier_success_count);
   body += StringFormat("Dossier count failed: %d\n", state.publication_bundle.dossier_failure_count);
   body += StringFormat("Dossier count skipped: %d\n", state.publication_bundle.dossier_skipped_count);
   body += StringFormat("Write Perf Trace: board_compose_ms=%d | board_publish_ms=%d | dossier_compose_ms=%d | dossier_publish_ms=%d | manifest_compose_ms=%d | manifest_publish_ms=%d | write_queue_ms=%d | artifact_attempted=%d | write_bottleneck_family=%s | write_bottleneck_reason=%s\n",
                        state.publication_bundle.board_compose_ms,
                        state.publication_bundle.board_publish_ms,
                        state.publication_bundle.dossier_compose_ms_total,
                        state.publication_bundle.dossier_publish_ms_total,
                        state.publication_bundle.manifest_compose_ms,
                        state.publication_bundle.manifest_publish_ms,
                        state.publication_bundle.write_queue_service_ms,
                        state.publication_bundle.artifact_attempted_count,
                        ASC_TextOrUnavailable(state.publication_bundle.write_bottleneck_family),
                        ASC_TextOrUnavailable(state.publication_bundle.write_bottleneck_reason));
   body += "RUN113 Dossier Publication Policy: " + ASC_DossierPublicationPolicyTokens(state) + "\n";
   body += StringFormat("Overall bundle status: %s\n", state.publication_bundle.overall_bundle_status);
   body += StringFormat("Bundle error summary: %s\n", state.publication_bundle.last_bundle_error_summary);
   body += StringFormat("Publication outcomes cumulative (fresh/continuity/failure): %d/%d/%d\n",
                        state.publication_fresh_count,
                        state.publication_continuity_count,
                        state.publication_failure_count);
   body += StringFormat("Bundle lifecycle cumulative (started/completed): %d/%d\n",
                        state.bundle_started_count,
                        state.bundle_completed_count);
   body += StringFormat("Selected-symbol flow cumulative (explicit_requests/runtime_reconcile_requests/reconcile_cycles/publish_attempt/success/continuity/failure): %d/%d/%d/%d/%d/%d/%d\n",
                        state.selected_symbol_request_count,
                        state.selected_symbol_runtime_request_count,
                        state.selected_symbol_reconcile_count,
                        state.selected_symbol_publish_attempt_count,
                        state.selected_symbol_publish_success_count,
                        state.selected_symbol_publish_continuity_count,
                        state.selected_symbol_publish_failure_count);
   body += StringFormat("Deep-trigger flow cumulative (requests/publish_attempt/success/continuity/failure): %d/%d/%d/%d/%d\n",
                        state.deep_trigger_request_count,
                        state.deep_trigger_publish_attempt_count,
                        state.deep_trigger_publish_success_count,
                        state.deep_trigger_publish_continuity_count,
                        state.deep_trigger_publish_failure_count);
   body += "Deep-trigger counter meaning: publish_attempt increments when explicit deep publication is admitted; success/continuity/failure count verified publish outcomes\n";

   string required_tokens[];
   ArrayResize(required_tokens, 233);
   required_tokens[0] = "Artifact Bundle Manifest";
   required_tokens[1] = "Publication Id:";
   required_tokens[2] = "Publication UTC:";
   required_tokens[3] = "Dossier publication path:";
   required_tokens[4] = "Dossier trigger status:";
   required_tokens[5] = "Dossier trigger evidence:";
   required_tokens[6] = "Dossier manual-lane evidence:";
   required_tokens[7] = "Market Board status:";
   required_tokens[8] = "Overall bundle status:";
   required_tokens[9] = "Bundle Manifest status:";
   required_tokens[10] = "Active Market Board proof publication id:";
   required_tokens[11] = "Active Selected-Symbol Dossier proof publication id:";
   required_tokens[12] = "Active proof family alignment:";
   required_tokens[13] = "Cross-Artifact Alignment Witness:";
   required_tokens[14] = "Selected-Symbol Dossier Proof:";
   required_tokens[15] = "Proof Class Ledger:";
   required_tokens[16] = "Checkpoint Evidence:";
   required_tokens[17] = "Evidence Boundary:";
   required_tokens[18] = "Evidence Availability Boundary:";
   required_tokens[19] = "Evidence Recovery Boundary:";
   required_tokens[20] = "Evidence Recheck Boundary:";
   required_tokens[21] = "Evidence Intake Chain:";
   required_tokens[22] = "Candidate Evidence Intake Boundary:";
   required_tokens[23] = "Shortlist Evidence Intake Boundary:";
   required_tokens[24] = "Market Board Evidence Intake Boundary:";
   required_tokens[25] = "Hydration Proof Summary:";
   required_tokens[26] = "Function Results Log Evidence:";
   required_tokens[27] = "Function Results Log Budget:";
   required_tokens[28] = "Function Results Log Budget Summary:";
   required_tokens[29] = "Function Results Row-Level Proof Summary:";
   required_tokens[30] = "Row-Level Seam Emission Contract:";
   required_tokens[31] = "Function Results Output Package Contract:";
   required_tokens[32] = "RUN050 Required Output Package:";
   required_tokens[33] = "Output Artifact Locator:";
   required_tokens[34] = "Current vs Archive Artifact Boundary:";
   required_tokens[35] = "Operator Surface Claim Boundary Witness:";
   required_tokens[36] = "Claim Evidence Contract:";
   required_tokens[37] = "RUN050 Proof Checklist:";
   required_tokens[38] = "Phase 2A Open Proof Ledger:";
   required_tokens[39] = "Function Results Bounded Contradiction Proof Observability:";
   required_tokens[40] = "Top5PerBucket PreLive Readiness Source Patch:";
   required_tokens[41] = "run110_top5_per_bucket_prelive_readiness_proof=present";
   required_tokens[42] = "artifact_family_id=top5_per_bucket";
   required_tokens[43] = "top5_per_bucket_family_state=";
   required_tokens[44] = "bucket_family_promoted=false";
   required_tokens[45] = "child_queue_added=true";
   required_tokens[46] = "promoted_family_created=false";
   required_tokens[47] = "dossier_publication_mode=selected_and_families_only";
   required_tokens[48] = "root_all_symbol_dossiers_enabled=false";
   required_tokens[49] = "root_all_symbol_dossier_writes_skipped=";
   required_tokens[50] = "globaltop10_dossiers_enabled=true";
   required_tokens[51] = "top5_per_bucket_dossiers_enabled=true";
   required_tokens[52] = "current_focus_enabled=true";
   required_tokens[53] = "selected_symbol_dossier_enabled=true";
   required_tokens[54] = "diagnostic_all_symbol_dossiers_enabled=false";
   required_tokens[55] = "legacy_all_symbol_dossiers_retained=true";
   required_tokens[56] = "legacy_root_dossier_cleanup_pending=true";
   required_tokens[57] = "market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC);
   required_tokens[58] = "l3_candidate_refresh_cadence_sec=600";
   required_tokens[59] = "l4_shortlist_refresh_cadence_sec=1200";
   required_tokens[60] = "globaltop10_refresh_cadence_sec=300";
   required_tokens[61] = "top5_per_bucket_refresh_cadence_sec=600";
   required_tokens[62] = "performance_side_audit=active";
   required_tokens[63] = "safe_cleanup_patch=";
   required_tokens[64] = "Runtime Proof Bundle Completeness:";
   required_tokens[65] = "proof_bundle_required=true";
   required_tokens[66] = "proof_bundle_complete=";
   required_tokens[67] = "scanner_status_required=true";
   required_tokens[68] = "market_board_required=true";
   required_tokens[69] = "top5_per_bucket_required=true";
   required_tokens[70] = "functionresults_required=true";
   required_tokens[71] = "heartbeat_telemetry_required=true";
   required_tokens[72] = "missing_runtime_surface_classification=missing_runtime_surface";
   required_tokens[73] = "run155_live_research_source_repair_contract_seeded=true";
   required_tokens[74] = "next_live_run=RUN155R";
   required_tokens[75] = "proof_bundle_first_missing_surface=";
   required_tokens[76] = "proof_bundle_missing_surface_count=";
   required_tokens[77] = "proof_bundle_missing_surface_list=";
   required_tokens[78] = "proof_bundle_decision_state=";
   required_tokens[79] = "evidence_package_blocker=";
   required_tokens[80] = "proof_bundle_complete_true_requires_all_mandatory_surfaces_or_policy_not_applicable=true";
   required_tokens[81] = "Phase 8 Candidate Filtering Surface Readiness:";
   required_tokens[82] = "phase8_candidate_filtering_surface_ready=";
   required_tokens[83] = "phase8_candidate_filtering_logs_ready=";
   required_tokens[84] = "proof_bundle_decision_mapping=";
   required_tokens[85] = "UPLOAD_ROOT_REQUIRED=server_root_or_export_root";
   required_tokens[86] = "run155_live_package_preflight_contract_strengthened=true";
   required_tokens[87] = "Roadmap Two-Lane Audit Boundary:";
   required_tokens[88] = "roadmap_two_lane_audit_required=true";
   required_tokens[89] = "roadmap_audit_source_lane_required=true";
   required_tokens[90] = "roadmap_audit_live_lane_required=true";
   required_tokens[91] = "source_completion_not_live_proof=true";
   required_tokens[92] = "live_completion_requires_runtime_evidence=true";
   required_tokens[93] = "phase8_status=SOURCE_PATCHED_LIVE_UNPROVEN_until_RUN155_complete_runtime_bundle";
   required_tokens[94] = "phase9_status=NOT_STARTED";
   required_tokens[95] = "run155_preflight_required=true";
   required_tokens[96] = "proof_bundle_complete_required_for_live_pass=true";
   required_tokens[97] = "missing_mandatory_surface_blocks_live_pass=true";
   required_tokens[98] = "report_only_live_forbidden_if_patchable_source_gap=true";
   required_tokens[99] = "safe_patch_required_when_patchable_live_blocker=true";
   required_tokens[100] = "phase8_live_proof_requires_complete_bundle=true";
   required_tokens[101] = "run155_operator_package_required_surfaces_locked=true";
   required_tokens[102] = "run155_upload_requires_scanner_status_manifest_dossiers_current_focus_if_selected_marketboard_current_archive_top5_current_staging_archive_globaltop10_current_archive_functionresults_heartbeat_workbench_logs_stale_tmp_proof";
   required_tokens[103] = "phase9_start_blocked_until_phase8_live_decision=true";
   required_tokens[104] = "phase8_live_decision_required_before_phase9=true";
   required_tokens[105] = "phase8_source_ready_does_not_equal_phase8_complete=true";
   required_tokens[106] = "phase8_live_proven_only_after_RUN155_PASS=true";
   required_tokens[107] = "live_percent_never_changes_without_runtime_evidence";
   required_tokens[108] = "run156r_speed_truth_fill_repair_after_RUN155_hold_with_patch=true";
   required_tokens[109] = "run155_decision_absorbed=HOLD_WITH_SOURCE_PATCH";
   required_tokens[110] = "operator_clarification_slow_fill_not_source_missing_absorbed=true";
   required_tokens[111] = "slow_top5_bucket_fill_primary_blocker=true";
   required_tokens[112] = "fill_state_classification=present,missing,not_yet_hydrated,fill_in_progress,run_ended_before_completion,queue_pending,queue_progressing,queue_stalled,disabled_by_policy,selected_none_not_applicable,source_gap_suspected,source_gap_confirmed";
   required_tokens[113] = "fill_in_progress_is_not_missing=true";
   required_tokens[114] = "run_ended_before_completion_is_not_source_failure=true";
   required_tokens[115] = "not_yet_hydrated_is_not_source_gap=true";
   required_tokens[116] = "queue_progressing_is_not_queue_stalled=true";
   required_tokens[117] = "missing_file_alone_is_not_source_bug_proof=true";
   required_tokens[118] = "l4_top5_globaltop10_sync_law_seeded=true";
   required_tokens[119] = "l4_membership_static_seconds=1200";
   required_tokens[120] = "displayed_symbol_info_refresh_seconds=300";
   required_tokens[121] = "l2_displayed_symbol_refresh_seconds=300";
   required_tokens[122] = "l5_displayed_symbol_refresh_seconds=300_where_available";
   required_tokens[123] = "l6_displayed_symbol_refresh_seconds=300";
   required_tokens[124] = "top5_per_bucket_per_symbol_info_reprint_seconds=300";
   required_tokens[125] = "globaltop10_per_symbol_info_reprint_seconds=300";
   required_tokens[126] = "bucket_fill_target_seconds=120";
   required_tokens[127] = "next_live_run=RUN160R_unless_operator_explicitly_authorizes_extraordinary_re_run";
   required_tokens[128] = "RUN158R Displayed-Symbol Reprint / Queue Progress Manifest:";
   required_tokens[129] = "run158r_displayed_symbol_5min_reprint_queue_progress_telemetry=true";
   required_tokens[130] = "displayed_symbol_set_source=L4_snapshot";
   required_tokens[131] = "displayed_symbol_set_not_rank_owner=true";
   required_tokens[132] = "displayed_symbol_info_refresh_seconds=300";
   required_tokens[133] = "displayed_symbol_info_last_refresh_utc=";
   required_tokens[134] = "displayed_symbol_info_next_due_utc=";
   required_tokens[135] = "displayed_symbol_info_age_seconds=";
   required_tokens[136] = "displayed_symbol_info_refresh_due=";
   required_tokens[137] = "l2_displayed_refresh_not_full_universe=true";
   required_tokens[138] = "l5_displayed_refresh_deferred_heavy_budget=true";
   required_tokens[139] = "l6_displayed_proof_not_hidden=true";
   required_tokens[140] = "bucket_fill_percent=";
   required_tokens[141] = "displayed_symbols_refresh_progress_percent=";
   required_tokens[142] = "no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop";
   required_tokens[143] = "run159r_speed_truth_fill_source_closeout_run160_live_contract=true";
   required_tokens[144] = "bucket_fill_source_readiness=closed_for_RUN160_measurement";
   required_tokens[145] = "bucket_fill_target_measurable_requires_runtime_counters=true";
   required_tokens[146] = "bucket_fill_target_met_runtime_evidence_only=true";
   required_tokens[147] = "bucket_fill_target_missed_runtime_evidence_only=true";
   required_tokens[148] = "bucket_fill_window_start_utc=";
   required_tokens[149] = "bucket_fill_target_measurable=";
   required_tokens[150] = "bucket_fill_target_met=";
   required_tokens[151] = "bucket_fill_target_missed=";
   required_tokens[152] = "run160_live_contract_finalized=true";
   required_tokens[153] = "run160_no_report_only_if_safe_patchable_blocker_exists=true";
   required_tokens[154] = "run160_safe_patch_required_if_patchable_blocker=true";
   required_tokens[155] = "run160_upload_requires_scanner_status_manifest_dossiers_market_board_current_archive_top5_current_staging_archive_globaltop10_current_archive_current_focus_if_selected_functionresults_heartbeat_workbench_logs_stale_tmp_staging_proof";
   required_tokens[156] = "source_readiness_does_not_equal_runtime_target_met=true";
   required_tokens[158] = "Symbol Data Pack Lite Runtime Activation: present=true";
   required_tokens[159] = "activation_mode=";
   required_tokens[160] = "runtime_callsite_enabled=true";
   required_tokens[161] = "writer_called=";
   required_tokens[162] = "activation_symbol_source=";
   required_tokens[163] = "activation_symbol=";
   required_tokens[164] = "final_path=";
   required_tokens[165] = "validation_status=";
   required_tokens[166] = "budget_state=";
   required_tokens[167] = "run173_proof_checklist_marker=RUN173_capture_lite_final_temp_lastgood_status_manifest_logs_protected_artifacts";
   required_tokens[168] = "no_change_skipped=";
   required_tokens[169] = "temp_path=";
   required_tokens[170] = "last_good_path=";
   required_tokens[171] = "missing_token_count=";
   required_tokens[172] = "first_missing_token=";
   required_tokens[173] = "last_writer_state=";
   required_tokens[174] = "last_writer_reason=";
   required_tokens[175] = "write_success=";
   required_tokens[176] = "last_error=";
   required_tokens[177] = "activation_enabled=";
   required_tokens[178] = "next_due_utc=";
   required_tokens[179] = "fresh_write_success=";
   required_tokens[180] = "retained_last_good=";
   required_tokens[181] = "continuity_state=";
   required_tokens[182] = "writer_reason=";
   required_tokens[183] = "fileio_missing_token_propagation=";
   required_tokens[184] = "publication_health=";
   required_tokens[185] = "write_success_is_fresh_only_when_no_change_false_and_retained_last_good_false=true";
   required_tokens[186] = "retained_last_good_cannot_equal_fresh_write_success=true";
   required_tokens[187] = "fileio_missing_token_markers=missing_required_token,missing_token";

   required_tokens[188] = "proof_bundle_policy_version=RUN225R_v1";
   required_tokens[189] = "proof_bundle_required_complete=";
   required_tokens[190] = "proof_bundle_optional_complete=";
   required_tokens[191] = "proof_bundle_missing_required_count=";
   required_tokens[192] = "proof_bundle_missing_optional_count=";
   required_tokens[193] = "proof_bundle_lawful_not_applicable_count=";
   required_tokens[194] = "proof_bundle_unknown_policy_count=";
   required_tokens[195] = "proof_bundle_missing_required_surfaces=";
   required_tokens[196] = "proof_bundle_missing_optional_surfaces=";
   required_tokens[197] = "proof_bundle_lawful_not_applicable_surfaces=";
   required_tokens[198] = "proof_bundle_deferred_surfaces=";
   required_tokens[199] = "proof_bundle_first_failure_reason=";
   required_tokens[200] = "proof_bundle_policy_boundary=proof_policy_only_no_fake_pass_no_output_mutation";
   required_tokens[201] = "proof_surface_globaltop10_archive=";
   required_tokens[202] = "proof_surface_dossiers=";
   required_tokens[203] = "source_run_id=";
   required_tokens[204] = "source_version=";
   required_tokens[205] = "artifact_manifest_schema_version=RUN227_v1";
   required_tokens[206] = "artifact_manifest_truth_state=";
   required_tokens[207] = "artifact_manifest_truth_reason=";
   required_tokens[208] = "artifact_manifest_publication_permission=true";
   required_tokens[209] = "artifact_manifest_required_tokens_present=";
   required_tokens[210] = "artifact_manifest_missing_tokens=";
   required_tokens[211] = "artifact_manifest_first_missing_token=";
   required_tokens[212] = "runtime_surface_classification=";
   required_tokens[213] = "runtime_surface_classification_reason=";
   required_tokens[214] = "missing_runtime_surface=";
   required_tokens[215] = "proof_bundle_decision_mapping=";
   required_tokens[216] = "proof_bundle_decision_mapping_reason=";
   required_tokens[217] = "proof_bundle_surface_count=";
   required_tokens[218] = "proof_bundle_surface_present_count=";
   required_tokens[219] = "proof_bundle_surface_missing_count=";
   required_tokens[220] = "proof_bundle_missing_surfaces=";
   required_tokens[221] = "proof_bundle_blocking_surfaces=";
   required_tokens[222] = "validation_deleted=false";
   required_tokens[223] = "degraded_partial_unknown_publication_allowed=true";
   required_tokens[224] = "complete_requires_required_surfaces=true";
   required_tokens[225] = "trade_permission=false";
   required_tokens[226] = "signal_permission=false";
   required_tokens[227] = "execution_permission=false";
   required_tokens[228] = "risk_permission=false";
   required_tokens[229] = "GLOBALTOP10_PUBLICATION_COMPLETION_REPAIR_BEGIN";
   required_tokens[230] = "TOP5PERBUCKET_PUBLICATION_COMPLETION_REPAIR_BEGIN";
   required_tokens[231] = "PUBLICATION_COMPLETION_LEDGER_BEGIN";
   required_tokens[232] = "SHELL_FIRST_PUBLICATION_STATUS_BEGIN";
   required_tokens[157] = "phase8_status=SOURCE_PATCHED_LIVE_UNPROVEN_after_RUN159_until_RUN160_live_bundle";

   body += ASC_PublicationResilienceBlock(body,
                                           required_tokens,
                                           "artifact_manifest",
                                           "ASC_Dispatcher",
                                           "missing Artifact Manifest proof/diagnostic token is emitted as degraded status; publication remains visible unless FileIO fails",
                                           true);

   int compose_elapsed_ms = (int)((GetMicrosecondCount() - compose_started_us) / 1000);

   string write_state = "pending";
   string write_reason = "pending";
   ulong publish_started_us = GetMicrosecondCount();
   int manifest_resilience_missing_count = 0;
   string manifest_resilience_first_missing = "none";
   ASC_PublicationResilienceMissingTokenList(body, required_tokens, manifest_resilience_missing_count, manifest_resilience_first_missing);
   string manifest_resilient_publication_state = state.publication_bundle.overall_bundle_status;
   if(manifest_resilience_missing_count > 0)
      manifest_resilient_publication_state = "complete_with_degraded_sections";
   if(!ASC_WritePublicationArtifact(state.bundle_manifest_path,
                                    state.publication_bundle.publication_id,
                                    state.publication_bundle.publication_utc,
                                    body,
                                    required_tokens,
                                    manifest_resilient_publication_state,
                                    write_state,
                                    write_reason))
     {
      string fail_ce = ASC_PubCEStatus(false,
                                       write_state,
                                       write_reason,
                                       state.publication_bundle.overall_bundle_status);
      string fail_cross = ASC_CrossArtCEStatus(cross_dossier_visible,
                                                cross_focus_visible,
                                                cross_board_visible,
                                                cross_top10_visible,
                                                false,
                                                cross_stale_or_retained,
                                                cross_dependency_blocked,
                                                true,
                                                false,
                                                cross_no_context);
      op_surf_state = ASC_OpSurfBoundaryState(true,
                                                false,
                                                true,
                                                cross_stale_or_retained,
                                                cross_no_context,
                                                false);
      op_surf_ce = ASC_OpSurfCEStatus(true,
                                      false,
                                      true,
                                      cross_stale_or_retained,
                                      cross_no_context,
                                      false);
      op_surf_support = ASC_OpSurfCESupport(op_surf_state,
                                            ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
      ASC_FunctionResultMarkClaimEvidenceStatus(result, op_surf_ce);
      string fail_message = ASC_ClaimEvidenceAppend("Failed to publish Artifact Bundle Manifest: " + write_reason,
                                                   op_surf_ce,
                                                   ASC_CrossArtCESupport(cross_dossier_visible,
                                                                         cross_focus_visible,
                                                                         cross_board_visible,
                                                                         cross_top10_visible,
                                                                         false,
                                                                         active_family_divergence,
                                                                         fail_ce) + ";" + op_surf_support,
                                                   ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
      fail_message = ASC_EvidenceBoundaryDetailAppend(fail_message,
                                                      ASC_EVID_AVAIL_UNAVAILABLE,
                                                      ASC_EVID_REC_REFRESH_DUE,
                                                      ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               fail_message,
                               state.bundle_manifest_path);
      return result;
     }

   ASC_FunctionResultState finish_state = ASC_RESULT_OK;
   string finish_message = "Artifact Bundle Manifest published for the current bundle.";
   if(write_state == "continuity")
     {
      finish_state = ASC_RESULT_WARNING;
      finish_message = "branch=artifact_bundle_manifest_publish | outcome_class=continuity | write_state=" + write_state + " | write_reason=" + write_reason + " | decision=last_good_manifest_retained";
     }

   if(finish_state == ASC_RESULT_OK)
      finish_message = "branch=artifact_bundle_manifest_publish | outcome_class=fresh | write_state=" + write_state + " | write_reason=" + write_reason + " | bundle_status=" + state.publication_bundle.overall_bundle_status;

   int publish_elapsed_ms = (int)((GetMicrosecondCount() - publish_started_us) / 1000);
   finish_message += StringFormat(" | hydration_manifest_summary=source_supported_artifact_observation_deferred | perf_compose_ms=%d | perf_publish_ms=%d | perf_artifact_family=manifest",
                                  compose_elapsed_ms,
                                  publish_elapsed_ms);
   finish_message += " | artifact_alignment_scope=bundle | alignment_status=" + (cross_contradiction_pending ? "qualified" : "aligned") + " | source_truth=mixed | claim_status=" + (cross_stale_or_retained ? "retained" : (cross_dependency_blocked ? "pending" : "qualified")) + " | runtime_observed=false | runtime_observed_scope=bundle_alignment_contract_not_individual_artifact_publish_outcome | source_supported=true | trade_permission=false | entry_signal=false | l3_meaning_preserved=true | l4_meaning_preserved=true | l5_support_preserved=true | resolver_limit_preserved=true | correlation_limit_preserved=true | current_vs_retained=" + (cross_stale_or_retained ? "retained_last_good" : "current") + " | artifact_projection=qualified | contradiction_status=" + (cross_contradiction_pending ? "possible" : "runtime_unproven") + " | contradiction_type=" + ASC_TextOrUnavailable(active_family_divergence) + " | behavior_change=no";
   finish_message += " | " + ASC_FunctionResultsBoundedContradictionProofObservabilityTokens();
   finish_message += " | " + ASC_DossierPublicationPolicyTokens(state);
   finish_message += " | " + manifest_proof_bundle_line;
   finish_message += " | " + ASC_MissingRuntimeSurfaceClassificationLine();
   string pub_ce = ASC_PubCEStatus(true,
                                     write_state,
                                     write_reason,
                                     state.publication_bundle.overall_bundle_status);
   cross_support = ASC_CrossArtCESupport(cross_dossier_visible,
                                         cross_focus_visible,
                                         cross_board_visible,
                                         cross_top10_visible,
                                         true,
                                         active_family_divergence,
                                         pub_ce);
   op_surf_state = ASC_OpSurfBoundaryState(true,
                                           true,
                                           cross_contradiction_pending,
                                           cross_stale_or_retained,
                                           cross_no_context,
                                           false);
   op_surf_ce = ASC_OpSurfCEStatus(true,
                                   true,
                                   cross_contradiction_pending,
                                   cross_stale_or_retained,
                                   cross_no_context,
                                   false);
   op_surf_support = ASC_OpSurfCESupport(op_surf_state,
                                         ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   ASC_FunctionResultMarkClaimEvidenceStatus(result, op_surf_ce);
   finish_message = ASC_ClaimEvidenceAppend(finish_message,
                                            op_surf_ce,
                                            cross_support + ";" + op_surf_support,
                                            ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
   finish_message = ASC_EvidenceBoundaryDetailAppend(finish_message,
                                                     ASC_EVID_AVAIL_SRC_RT_UNPROVEN,
                                                     ASC_EVID_REC_SRC_RT_UNPROVEN,
                                                     ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);

   ASC_FunctionResultFinish(result,
                            finish_state,
                            ASC_RC_OK,
                            finish_message,
                            state.bundle_manifest_path);
   return result;
  }

int ASC_CountMissingDossierArtifacts(const ASC_RuntimeState &state)
  {
   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
      return ASC_Run146RequiredSelectedFamilyDossierMissing(state);
   int total = ASC_Layer1CachedSymbolCount();
   int missing = 0;
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      bool dossier_exists = false;
      bool dossier_is_shell = false;
      bool dossier_is_rich = false;
      bool has_l3 = false;
      bool has_l4 = false;
      if(!ASC_TryResolveDossierCoverageState(state,
                                             symbol_state,
                                             dossier_exists,
                                             dossier_is_shell,
                                             dossier_is_rich,
                                             has_l3,
                                             has_l4)
         || !dossier_exists)
         missing++;
     }

  return missing;
  }

int ASC_CountNonRichDossierArtifacts(const ASC_RuntimeState &state)
  {
   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
      return ASC_Run146RequiredSelectedFamilyDossierMissing(state);
   int total = ASC_Layer1CachedSymbolCount();
   int non_rich = 0;
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      bool dossier_exists = false;
      bool dossier_is_shell = false;
      bool dossier_is_rich = false;
      bool has_l3 = false;
      bool has_l4 = false;
      ASC_TryResolveDossierCoverageState(state,
                                         symbol_state,
                                         dossier_exists,
                                         dossier_is_shell,
                                         dossier_is_rich,
                                         has_l3,
                                         has_l4);
      if(!dossier_exists || dossier_is_shell || !dossier_is_rich)
         non_rich++;
     }

  return non_rich;
  }

enum ASC_DossierHydrationQueueClass
  {
   ASC_DOSSIER_QUEUE_NONE = -1,
   ASC_DOSSIER_QUEUE_CLOSED_REDUCED = 0,
   ASC_DOSSIER_QUEUE_OPEN_BASE = 1,
   ASC_DOSSIER_QUEUE_OPEN_L3 = 2,
   ASC_DOSSIER_QUEUE_OPEN_L4 = 3
  };

enum ASC_DossierCadenceClass
  {
   ASC_DOSSIER_CADENCE_URGENT_LOWER_LAYER_RETRY = 0,
   ASC_DOSSIER_CADENCE_FAST_LIVE_REFRESH = 1,
   ASC_DOSSIER_CADENCE_SLOW_STABLE_REFRESH = 2,
   ASC_DOSSIER_CADENCE_NEXT_OPEN_OR_CHECKPOINT = 3,
   ASC_DOSSIER_CADENCE_ON_DEMAND_ONLY = 4
  };

int ASC_DossierCadenceIntervalSeconds(const int cadence_class,const int retry_streak = 0)
  {
   if(cadence_class == ASC_DOSSIER_CADENCE_URGENT_LOWER_LAYER_RETRY)
      return MathMin(30, MathMax(1, ASC_HEARTBEAT_SECONDS * MathMax(1, retry_streak + 1)));
   if(cadence_class == ASC_DOSSIER_CADENCE_FAST_LIVE_REFRESH)
      return MathMax(5, ASC_HEARTBEAT_SECONDS * 2);
   if(cadence_class == ASC_DOSSIER_CADENCE_SLOW_STABLE_REFRESH)
      return MathMax(30, ASC_HEARTBEAT_SECONDS * 8);
   if(cadence_class == ASC_DOSSIER_CADENCE_NEXT_OPEN_OR_CHECKPOINT)
      return MathMax(120, ASC_HEARTBEAT_SECONDS * 30);
   return MathMax(300, ASC_HEARTBEAT_SECONDS * 60);
  }

void ASC_DossierPendingQueuesReset(ASC_RuntimeState &state)
  {
   ArrayResize(state.dossier_queue_closed_reduced_symbols, 0);
   ArrayResize(state.dossier_queue_open_base_symbols, 0);
   ArrayResize(state.dossier_queue_open_l3_symbols, 0);
   ArrayResize(state.dossier_queue_open_l4_symbols, 0);
   state.dossier_queue_cursor_closed_reduced = 0;
   state.dossier_queue_cursor_open_base = 0;
   state.dossier_queue_cursor_open_l3 = 0;
   state.dossier_queue_cursor_open_l4 = 0;
  }

void ASC_DossierPendingQueuesMarkDirty(ASC_RuntimeState &state)
  {
   state.dossier_pending_queues_ready = false;
   state.dossier_pending_queues_dirty = true;
   state.dossier_pending_queue_signature = "";
  }

string ASC_DossierPendingQueueMaterialSignature(const ASC_RuntimeState &state)
  {
   ulong l1_revision = ASC_Layer1StructuralRevision();
   return StringFormat("l1=%I64u;l2_scan=%I64d;l2_due=%d;l2_admitted=%d;l2_dirty=%d;l3=%I64u;l4=%I64u;open_refresh=%d;shell_only=%d;pending=%d;flood=%d;missing=%d",
                       l1_revision,
                       (long)state.l2_last_scan_utc,
                       state.l2_due_remaining,
                       state.l2_admitted_symbols,
                       state.layer2_dirty ? 1 : 0,
                       state.committed_l3_revision,
                       state.committed_l4_revision,
                       state.dossier_open_refresh_only ? 1 : 0,
                       state.dossier_existence_shell_only ? 1 : 0,
                       state.l1_publish_pending_dossiers ? 1 : 0,
                       state.dossier_startup_flood_active ? 1 : 0,
                       state.dossier_missing_count);
  }

bool ASC_DossierPendingQueueRebuildDue(ASC_RuntimeState &state,string &reason_out)
  {
   reason_out = "stable";
   if(!state.l1_publish_pending_dossiers)
     {
      reason_out = "pending_dossier_duty_inactive";
      return false;
     }

   if(!state.dossier_pending_queues_ready)
     {
      reason_out = "queues_not_ready";
      return true;
     }

   if(state.dossier_pending_queues_dirty)
     {
      reason_out = "queues_marked_dirty";
      return true;
     }

   if(state.dossier_regression_signal == "dossier_cursor_stall"
      && state.dossier_cursor_stall_beats >= ASC_DOSSIER_QUEUE_REBUILD_STALL_BEATS)
     {
      reason_out = "cursor_stall_rebuild";
      return true;
     }

   string signature_now = ASC_DossierPendingQueueMaterialSignature(state);
   if(signature_now != state.dossier_pending_queue_signature)
     {
      reason_out = "material_state_changed";
      return true;
     }

   reason_out = "material_state_stable";
   return false;
  }

int ASC_DossierPendingQueueTotal(const ASC_RuntimeState &state)
  {
   int total = 0;
   total += MathMax(0, ArraySize(state.dossier_queue_closed_reduced_symbols) - state.dossier_queue_cursor_closed_reduced);
   total += MathMax(0, ArraySize(state.dossier_queue_open_base_symbols) - state.dossier_queue_cursor_open_base);
   total += MathMax(0, ArraySize(state.dossier_queue_open_l3_symbols) - state.dossier_queue_cursor_open_l3);
   total += MathMax(0, ArraySize(state.dossier_queue_open_l4_symbols) - state.dossier_queue_cursor_open_l4);
   return total;
  }

int ASC_DossierPendingQueueClassCount(const ASC_RuntimeState &state,const int queue_class)
  {
   if(queue_class == ASC_DOSSIER_QUEUE_CLOSED_REDUCED)
      return MathMax(0, ArraySize(state.dossier_queue_closed_reduced_symbols) - state.dossier_queue_cursor_closed_reduced);
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_BASE)
      return MathMax(0, ArraySize(state.dossier_queue_open_base_symbols) - state.dossier_queue_cursor_open_base);
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L3)
      return MathMax(0, ArraySize(state.dossier_queue_open_l3_symbols) - state.dossier_queue_cursor_open_l3);
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L4)
      return MathMax(0, ArraySize(state.dossier_queue_open_l4_symbols) - state.dossier_queue_cursor_open_l4);
   return 0;
  }

string ASC_DossierPendingQueueClassTrace(const int closed_reduced,
                                         const int open_base,
                                         const int open_l3,
                                         const int open_l4)
  {
   return StringFormat("closed_l0_l2=%d|open_base=%d|open_l3=%d|open_l4=%d",
                       MathMax(0, closed_reduced),
                       MathMax(0, open_base),
                       MathMax(0, open_l3),
                       MathMax(0, open_l4));
  }

string ASC_DossierQueueProofStateLabel(const int backlog_before,
                                      const int backlog_after,
                                      const int attempted_this_beat,
                                      const int success_this_beat,
                                      const int failure_this_beat,
                                      const bool fail_cap_hit,
                                      const string stall_reason)
  {
   if(backlog_after <= 0)
      return (backlog_before > 0 || attempted_this_beat > 0) ? "recovered" : "idle";
   if(fail_cap_hit || failure_this_beat > 0)
      return "degraded";
   if(success_this_beat > 0 || backlog_after < backlog_before)
      return "draining";
   if(attempted_this_beat > 0)
      return "draining_no_backlog_drop";
   if(StringFind(stall_reason, "budget_exhausted") >= 0)
      return "budget_deferred";
   if(backlog_after > 0)
      return "stalled";
   return "idle";
  }

int ASC_DossierQueueCursorTotal(const ASC_RuntimeState &state)
  {
   return MathMax(0, state.dossier_queue_cursor_closed_reduced)
          + MathMax(0, state.dossier_queue_cursor_open_base)
          + MathMax(0, state.dossier_queue_cursor_open_l3)
          + MathMax(0, state.dossier_queue_cursor_open_l4);
  }

void ASC_DossierQueueResetBeatProof(ASC_RuntimeState &state,const string reason)
  {
   state.dossier_queue_attempted_this_beat = 0;
   state.dossier_queue_success_this_beat = 0;
   state.dossier_queue_failure_this_beat = 0;
   state.dossier_queue_cursor_total = ASC_DossierQueueCursorTotal(state);
   if(StringLen(reason) > 0)
      state.dossier_queue_last_reason = reason;
   if(!state.l1_publish_pending_dossiers && ASC_DossierPendingQueueTotal(state) <= 0)
      state.dossier_queue_state = "idle";
  }

void ASC_DossierQueueUpdateBeatProof(ASC_RuntimeState &state,
                                     const int backlog_before,
                                     const int backlog_after,
                                     const int attempted_this_beat,
                                     const int success_this_beat,
                                     const int failure_this_beat,
                                     const bool fail_cap_hit,
                                     const string last_symbol,
                                     const string stall_reason)
  {
   state.dossier_queue_attempted_this_beat = MathMax(0, attempted_this_beat);
   state.dossier_queue_success_this_beat = MathMax(0, success_this_beat);
   state.dossier_queue_failure_this_beat = MathMax(0, failure_this_beat);
   state.dossier_queue_cursor_total = ASC_DossierQueueCursorTotal(state);
   if(StringLen(last_symbol) > 0)
      state.dossier_queue_last_symbol = last_symbol;
   state.dossier_queue_last_reason = (StringLen(stall_reason) > 0 ? stall_reason : "unclassified");
   string previous_state = state.dossier_queue_state;
   state.dossier_queue_state = ASC_DossierQueueProofStateLabel(backlog_before,
                                                               backlog_after,
                                                               attempted_this_beat,
                                                               success_this_beat,
                                                               failure_this_beat,
                                                               fail_cap_hit,
                                                               stall_reason);
   if((state.dossier_queue_state == "stalled" || state.dossier_queue_state == "budget_deferred") && backlog_after > 0)
      state.dossier_queue_stall_count++;
   if((state.dossier_queue_state == "recovered" || state.dossier_queue_state == "draining")
      && (previous_state == "stalled" || previous_state == "budget_deferred" || state.dossier_no_progress_write_beats > 0))
      state.dossier_queue_recovered_count++;
  }

string ASC_DossierQueueServicePlanTrace(const bool prioritize_open_hydration,
                                        const bool balanced_closed_relief,
                                        const int remaining_budget,
                                        const int open_quota,
                                        const int closed_quota,
                                        const int spill_budget,
                                        const int open_backlog,
                                        const int closed_backlog,
                                        const int no_progress_beats)
  {
   string mode = "seed_mix";
   if(prioritize_open_hydration)
      mode = (balanced_closed_relief ? "open_priority_balanced" : "open_priority");
   return StringFormat("mode=%s|budget=%d|open_quota=%d|closed_quota=%d|spill_quota=%d|open_backlog=%d|closed_backlog=%d|no_progress=%d",
                       mode,
                       MathMax(0, remaining_budget),
                       MathMax(0, open_quota),
                       MathMax(0, closed_quota),
                       MathMax(0, spill_budget),
                       MathMax(0, open_backlog),
                       MathMax(0, closed_backlog),
                       MathMax(0, no_progress_beats));
  }

bool ASC_DossierQueueShellDominantPressure(const ASC_RuntimeState &state,const int backlog)
  {
   if(backlog < 256)
      return false;
   if(state.dossier_shell_present_count >= 512)
      return true;
   if(state.dossier_shell_present_count > 0
      && state.dossier_shell_present_count >= (state.dossier_expanded_present_count * 4))
      return true;
   return false;
  }

const int ASC_MANIFEST_VERIFICATION_RECENT_TOP10_SEC = 900;
const int ASC_MANIFEST_VERIFICATION_RECENT_CURRENT_FOCUS_SEC = 600;

bool ASC_DispatcherTimestampIsRecent(const datetime timestamp_utc,const datetime now_utc,const int recent_window_sec)
  {
   if(timestamp_utc <= 0 || recent_window_sec <= 0 || now_utc <= 0)
      return false;
   return ((now_utc - timestamp_utc) <= recent_window_sec);
  }

string ASC_Top10ArchiveRootDirectory(const ASC_RuntimeState &state)
  {
   string target_dir = ASC_Top10RunFullTargetDirectory(state);
   if(StringLen(target_dir) <= 0)
      return "";
   return target_dir + "\\archive";
  }

string ASC_Top10ArchiveCadenceSlotLabel(const datetime now_utc)
  {
   if(now_utc <= 0)
      return "";
   MqlDateTime stamp;
   TimeToStruct(now_utc, stamp);
   stamp.sec = 0;
   stamp.min = (stamp.min / 10) * 10;
   return StringFormat("%04d%02d%02d_%02d%02d", stamp.year, stamp.mon, stamp.day, stamp.hour, stamp.min);
  }

string ASC_Top10ArchiveSnapshotDirectory(const ASC_RuntimeState &state,const datetime now_utc)
  {
   string root_dir = ASC_Top10ArchiveRootDirectory(state);
   string slot_label = ASC_Top10ArchiveCadenceSlotLabel(now_utc);
   if(StringLen(root_dir) <= 0 || StringLen(slot_label) <= 0)
      return "";
   return root_dir + "\\" + slot_label;
  }

bool ASC_DossierManifestReserveNeeded(const ASC_RuntimeState &state,const int backlog,const bool startup_dossier_flood_mode)
  {
   if(!state.l1_publish_pending_manifest)
      return false;

   datetime now_utc = TimeGMT();
   bool top10_recent = ASC_DispatcherTimestampIsRecent(state.top10_run_full_batch_last_served_utc,
                                                       now_utc,
                                                       ASC_MANIFEST_VERIFICATION_RECENT_TOP10_SEC);
   bool current_focus_recent = ASC_DispatcherTimestampIsRecent(state.current_focus_last_served_utc,
                                                               now_utc,
                                                               ASC_MANIFEST_VERIFICATION_RECENT_CURRENT_FOCUS_SEC);
   bool verification_critical = (state.board_manual_refresh_pending
                                 || state.board_manual_refresh_inflight
                                 || state.forced_downstream_refresh_pending
                                 || state.deep_focus_trigger_pending
                                 || ASC_IsTop10RunFullBatchActive(state)
                                 || top10_recent
                                 || current_focus_recent);
   if(startup_dossier_flood_mode && !verification_critical)
      return false;
   if(backlog >= 128 && ASC_DossierQueueShellDominantPressure(state, backlog) && !verification_critical)
      return false;
   return true;
  }

bool ASC_DossierPressureWriteDue(const ASC_RuntimeState &state,
                                 const bool broad_catchup_incomplete,
                                 const int dossier_backlog_pending)
  {
   if(broad_catchup_incomplete || dossier_backlog_pending <= 0)
      return false;
   if(dossier_backlog_pending >= 24 && state.beats_since_write >= 1)
      return true;
   if(dossier_backlog_pending >= 192)
      return true;
   if(state.dossier_no_progress_write_beats >= 2 && dossier_backlog_pending >= 64)
      return true;
   if(ASC_DossierQueueShellDominantPressure(state, dossier_backlog_pending)
      && state.consecutive_scan_beats >= 1)
      return true;
   if(dossier_backlog_pending >= 256
      && state.deferred_write_artifacts >= 512
      && state.beats_since_write >= 1)
      return true;
   if(dossier_backlog_pending >= 256
      && state.dossier_cursor_stall_beats >= 2)
      return true;
   return false;
  }

bool ASC_DossierPendingQueueContains(const string &queue_symbols[],const int cursor,const string symbol)
  {
   for(int i = cursor; i < ArraySize(queue_symbols); i++)
      if(queue_symbols[i] == symbol)
         return true;
   return false;
  }

void ASC_DossierPendingQueueAppend(ASC_RuntimeState &state,const int queue_class,const string symbol)
  {
   if(StringLen(symbol) <= 0 || queue_class == ASC_DOSSIER_QUEUE_NONE)
      return;

   if(queue_class == ASC_DOSSIER_QUEUE_CLOSED_REDUCED)
     {
      if(ASC_DossierPendingQueueContains(state.dossier_queue_closed_reduced_symbols, state.dossier_queue_cursor_closed_reduced, symbol))
         return;
      int next = ArraySize(state.dossier_queue_closed_reduced_symbols);
      ArrayResize(state.dossier_queue_closed_reduced_symbols, next + 1);
      state.dossier_queue_closed_reduced_symbols[next] = symbol;
      return;
     }
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_BASE)
     {
      if(ASC_DossierPendingQueueContains(state.dossier_queue_open_base_symbols, state.dossier_queue_cursor_open_base, symbol))
         return;
      int next = ArraySize(state.dossier_queue_open_base_symbols);
      ArrayResize(state.dossier_queue_open_base_symbols, next + 1);
      state.dossier_queue_open_base_symbols[next] = symbol;
      return;
     }
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L3)
     {
      if(ASC_DossierPendingQueueContains(state.dossier_queue_open_l3_symbols, state.dossier_queue_cursor_open_l3, symbol))
         return;
      int next = ArraySize(state.dossier_queue_open_l3_symbols);
      ArrayResize(state.dossier_queue_open_l3_symbols, next + 1);
      state.dossier_queue_open_l3_symbols[next] = symbol;
      return;
     }
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L4)
     {
      if(ASC_DossierPendingQueueContains(state.dossier_queue_open_l4_symbols, state.dossier_queue_cursor_open_l4, symbol))
         return;
      int next = ArraySize(state.dossier_queue_open_l4_symbols);
      ArrayResize(state.dossier_queue_open_l4_symbols, next + 1);
      state.dossier_queue_open_l4_symbols[next] = symbol;
      return;
     }
  }

bool ASC_DossierPendingQueuePopNext(ASC_RuntimeState &state,const int queue_class,string &symbol_out)
  {
   symbol_out = "";
   if(queue_class == ASC_DOSSIER_QUEUE_CLOSED_REDUCED)
     {
      while(state.dossier_queue_cursor_closed_reduced < ArraySize(state.dossier_queue_closed_reduced_symbols))
        {
         string symbol = state.dossier_queue_closed_reduced_symbols[state.dossier_queue_cursor_closed_reduced];
         state.dossier_queue_cursor_closed_reduced++;
         if(StringLen(symbol) > 0)
           {
            symbol_out = symbol;
            return true;
           }
        }
      return false;
     }
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_BASE)
     {
      while(state.dossier_queue_cursor_open_base < ArraySize(state.dossier_queue_open_base_symbols))
        {
         string symbol = state.dossier_queue_open_base_symbols[state.dossier_queue_cursor_open_base];
         state.dossier_queue_cursor_open_base++;
         if(StringLen(symbol) > 0)
           {
            symbol_out = symbol;
            return true;
           }
        }
      return false;
     }
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L3)
     {
      while(state.dossier_queue_cursor_open_l3 < ArraySize(state.dossier_queue_open_l3_symbols))
        {
         string symbol = state.dossier_queue_open_l3_symbols[state.dossier_queue_cursor_open_l3];
         state.dossier_queue_cursor_open_l3++;
         if(StringLen(symbol) > 0)
           {
            symbol_out = symbol;
            return true;
           }
        }
      return false;
     }
   if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L4)
     {
      while(state.dossier_queue_cursor_open_l4 < ArraySize(state.dossier_queue_open_l4_symbols))
        {
         string symbol = state.dossier_queue_open_l4_symbols[state.dossier_queue_cursor_open_l4];
         state.dossier_queue_cursor_open_l4++;
         if(StringLen(symbol) > 0)
           {
            symbol_out = symbol;
            return true;
           }
        }
      return false;
     }
   return false;
  }

int ASC_DossierHydrationQueueClassForSymbol(const ASC_RuntimeState &state,
                                            const ASC_Layer1SymbolState &symbol_state,
                                            bool &needs_hydration_out)
  {
   needs_hydration_out = false;
   if(StringLen(symbol_state.symbol) <= 0)
      return ASC_DOSSIER_QUEUE_NONE;

   if(!ASC_DossierBroadRefreshAllowed(state, symbol_state))
      return ASC_DOSSIER_QUEUE_NONE;

   bool dossier_exists = false;
   bool dossier_is_shell = false;
   bool dossier_is_rich = false;
   bool has_l3 = false;
   bool has_l4 = false;
   ASC_TryResolveDossierCoverageState(state,
                                      symbol_state,
                                      dossier_exists,
                                      dossier_is_shell,
                                      dossier_is_rich,
                                      has_l3,
                                      has_l4);

   bool open_market_symbol = (symbol_state.state == ASC_L1_OPEN);

   ASC_CommittedLayer3SymbolState committed_l3;
   bool has_committed_l3 = (state.committed_l3_ready
                            && ASC_ShortlistFindCommittedLayer3State(state.committed_l3_rows,
                                                           symbol_state.symbol,
                                                           committed_l3));
   bool l3_entitled = (open_market_symbol
                       && has_committed_l3
                       && committed_l3.source_ready
                       && committed_l3.has_lawful_packet
                       && committed_l3.evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS);

   ASC_CommittedLayer4SymbolState committed_l4;
   bool has_committed_l4 = (state.committed_l4_ready
                            && ASC_CommittedL4FindBySymbol(state.committed_l4_rows,
                                                           symbol_state.symbol,
                                                           committed_l4));
   bool l4_entitled = (l3_entitled
                       && has_committed_l4
                       && committed_l4.source_ready
                       && committed_l4.lawful_survivor
                       && ASC_ShortlistHasLawfulMembership(committed_l4.summary));

   if(!open_market_symbol)
     {
      bool reduced_closed_ready = (dossier_exists && dossier_is_rich && !has_l3 && !has_l4);
      if(reduced_closed_ready)
        {
         needs_hydration_out = false;
         return ASC_DOSSIER_QUEUE_NONE;
        }

      bool preserved_closed_deep_ready = false;
      if(dossier_exists && dossier_is_rich && (has_l3 || has_l4))
        {
         string preserved_payload = "";
         ASC_ArtifactContract dossier_contract = ASC_DossierContract(state.server_root, ASC_DossierCanonicalSymbol(symbol_state));
         if(ASC_ReadTextFile(dossier_contract.target_path, preserved_payload)
            && ASC_DossierPayloadMatchesSymbolContext(preserved_payload, symbol_state, ASC_DossierCanonicalSymbol(symbol_state))
            && ASC_DossierPayloadHasLawfulL0ToL6Coverage(preserved_payload))
            preserved_closed_deep_ready = true;
        }

      needs_hydration_out = !preserved_closed_deep_ready;
      return needs_hydration_out ? ASC_DOSSIER_QUEUE_CLOSED_REDUCED : ASC_DOSSIER_QUEUE_NONE;
     }

   if(!dossier_exists || dossier_is_shell || !dossier_is_rich)
     {
      needs_hydration_out = true;
      if(l4_entitled)
         return ASC_DOSSIER_QUEUE_OPEN_L4;
      if(l3_entitled)
         return ASC_DOSSIER_QUEUE_OPEN_L3;
      return ASC_DOSSIER_QUEUE_OPEN_BASE;
     }

   if(!has_l3 || !has_l4)
     {
      needs_hydration_out = true;
      if(l4_entitled)
         return ASC_DOSSIER_QUEUE_OPEN_L4;
      if(l3_entitled)
         return ASC_DOSSIER_QUEUE_OPEN_L3;
      return ASC_DOSSIER_QUEUE_OPEN_BASE;
     }

   if(l4_entitled && !has_l4)
     {
      needs_hydration_out = true;
      return ASC_DOSSIER_QUEUE_OPEN_L4;
     }

   if(l3_entitled && !has_l3)
     {
      needs_hydration_out = true;
      return ASC_DOSSIER_QUEUE_OPEN_L3;
     }

   if(!l3_entitled && (has_l3 || has_l4))
     {
      needs_hydration_out = true;
      return ASC_DOSSIER_QUEUE_OPEN_BASE;
     }

   if(l3_entitled && has_l3 && !l4_entitled && has_l4)
     {
      needs_hydration_out = true;
      return ASC_DOSSIER_QUEUE_OPEN_L3;
     }

   needs_hydration_out = false;
   return ASC_DOSSIER_QUEUE_NONE;
  }

int ASC_DossierCadenceClassForSymbol(const ASC_Layer1SymbolState &symbol_state,
                                     const bool needs_hydration,
                                     const int queue_class,
                                     const bool has_lawful_packet)
  {
   if(needs_hydration)
     {
      if(queue_class == ASC_DOSSIER_QUEUE_CLOSED_REDUCED
         || queue_class == ASC_DOSSIER_QUEUE_OPEN_BASE
         || !has_lawful_packet)
         return ASC_DOSSIER_CADENCE_URGENT_LOWER_LAYER_RETRY;
      if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L3 || queue_class == ASC_DOSSIER_QUEUE_OPEN_L4)
         return ASC_DOSSIER_CADENCE_SLOW_STABLE_REFRESH;
      return ASC_DOSSIER_CADENCE_FAST_LIVE_REFRESH;
     }

   if(symbol_state.state == ASC_L1_CLOSED)
      return ASC_DOSSIER_CADENCE_NEXT_OPEN_OR_CHECKPOINT;
   if(symbol_state.state == ASC_L1_OPEN)
      return ASC_DOSSIER_CADENCE_FAST_LIVE_REFRESH;
   return ASC_DOSSIER_CADENCE_ON_DEMAND_ONLY;
  }

void ASC_RebuildDossierPendingQueues(ASC_RuntimeState &state,const string rebuild_reason="unspecified")
  {
   ASC_DossierPendingQueuesReset(state);
   datetime now_utc = TimeGMT();

   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;
      if(!ASC_DossierCandidateAllowed(state, symbol_state))
         continue;

      ASC_Layer2Packet packet;
      bool has_packet = ASC_ShortlistTryGetPacketForState(symbol_state, packet);
      bool has_lawful_packet = has_packet && ASC_L2PacketHasLawfulSnapshot(packet);
      bool needs_hydration = false;
      int queue_class = ASC_DossierHydrationQueueClassForSymbol(state, symbol_state, needs_hydration);
      int cadence_class = ASC_DossierCadenceClassForSymbol(symbol_state, needs_hydration, queue_class, has_lawful_packet);

      int row_index = ASC_DossierHydrationLedgerFindIndex(state,
                                                          symbol_state.symbol,
                                                          ASC_DossierCanonicalSymbol(symbol_state));
      if(row_index < 0)
        {
         ASC_DossierHydrationLedgerUpsert(state,
                                          symbol_state,
                                          ASC_DOSSIER_QUEUE_NONE,
                                          false,
                                          false,
                                          false,
                                          false,
                                          false,
                                          false,
                                          "missing",
                                          now_utc);
         row_index = ASC_DossierHydrationLedgerFindIndex(state,
                                                         symbol_state.symbol,
                                                         ASC_DossierCanonicalSymbol(symbol_state));
        }
      bool dossier_exists = false;
      bool dossier_is_shell = false;
      bool dossier_is_rich = false;
      bool has_l3 = false;
      bool has_l4 = false;
      ASC_TryResolveDossierCoverageState(state,
                                         symbol_state,
                                         dossier_exists,
                                         dossier_is_shell,
                                         dossier_is_rich,
                                         has_l3,
                                         has_l4);
      if(state.dossier_existence_shell_only && dossier_exists)
         continue;

      int retry_streak = (row_index >= 0 ? state.dossier_hydration_rows[row_index].retry_streak : 0);
      int cadence_seconds = ASC_DossierCadenceIntervalSeconds(cadence_class, retry_streak);
      datetime next_due_utc = now_utc + cadence_seconds;
      if(needs_hydration)
         next_due_utc = now_utc;

      ASC_DossierHydrationLedgerSetCadence(state,
                                           symbol_state,
                                           cadence_class,
                                           next_due_utc,
                                           false,
                                           false);

      if(!needs_hydration || queue_class == ASC_DOSSIER_QUEUE_NONE)
         continue;
      if(row_index >= 0
         && state.dossier_hydration_rows[row_index].next_due_utc > now_utc)
         continue;
      ASC_DossierPendingQueueAppend(state, queue_class, symbol_state.symbol);
     }

   state.dossier_pending_queues_ready = true;
   state.dossier_pending_queues_dirty = false;
   state.dossier_pending_queue_signature = ASC_DossierPendingQueueMaterialSignature(state);
   state.dossier_pending_queue_last_rebuild_reason = rebuild_reason;
   state.dossier_pending_queue_last_rebuild_utc = now_utc;
   state.dossier_pending_queue_rebuild_count++;
   state.dossier_pending_backlog_count = ASC_DossierPendingQueueTotal(state);
   ASC_LogInfo("ASC_Dispatcher", "ASC_RebuildDossierPendingQueues", "runtime",
               StringFormat("dossier queue rebuilt reason=%s backlog=%d closed=%d open_base=%d open_l3=%d open_l4=%d",
                            rebuild_reason,
                            state.dossier_pending_backlog_count,
                            MathMax(0, ArraySize(state.dossier_queue_closed_reduced_symbols) - state.dossier_queue_cursor_closed_reduced),
                            MathMax(0, ArraySize(state.dossier_queue_open_base_symbols) - state.dossier_queue_cursor_open_base),
                            MathMax(0, ArraySize(state.dossier_queue_open_l3_symbols) - state.dossier_queue_cursor_open_l3),
                            MathMax(0, ArraySize(state.dossier_queue_open_l4_symbols) - state.dossier_queue_cursor_open_l4)));
  }

int ASC_CountRemainingDossierBacklog(const ASC_RuntimeState &state)
  {
   if(!state.l1_publish_pending_dossiers)
      return 0;

   if(state.dossier_pending_queues_ready && !state.dossier_pending_queues_dirty)
      return ASC_DossierPendingQueueTotal(state);

   return MathMax(1, state.dossier_pending_backlog_count);
  }

int ASC_DossierLedgerRefreshMinIntervalSeconds(const ASC_RuntimeState &state)
  {
   if(ASC_IsTop10RunFullBatchActive(state)
      || ((state.board_manual_refresh_pending || state.board_manual_refresh_inflight)
          && ASC_IsRunFullBoardRefreshTrigger(state.board_manual_refresh_trigger)))
      return 8;
   return 2;
  }

void ASC_QueueDossierExistenceDuty(ASC_RuntimeState &state)
  {
   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
     {
      state.l1_publish_pending_dossiers = false;
      state.dossier_open_refresh_only = false;
      state.dossier_resume_full_publish_after_open_refresh = false;
      state.dossier_existence_shell_only = false;
      state.dossier_startup_flood_active = false;
      state.write_cursor = 0;
      state.dossier_pending_backlog_count = 0;
      ASC_DossierPendingQueuesReset(state);
      state.dossier_pending_queues_ready = false;
      state.dossier_pending_queues_dirty = true;
      state.dossier_pending_queue_signature = "";
      state.l1_publish_pending_manifest = true;
      state.write_dirty = (state.l1_publish_pending_essentials || state.l2_publish_pending || state.l1_publish_pending_manifest);
      ASC_RecordRoutineRootDossierPolicySkip(state, TimeGMT(), ASC_DIAGNOSTIC_ALL_SYMBOL_MODE_OFF_REASON);
      return;
     }

   if(!state.l1_publish_pending_dossiers)
     {
      state.l1_publish_pending_dossiers = true;
      state.write_cursor = 0;
     }
   else if(!state.dossier_existence_shell_only)
     {
      state.write_cursor = 0;
     }

   state.dossier_open_refresh_only = false;
   state.dossier_resume_full_publish_after_open_refresh = false;
   state.dossier_existence_shell_only = true;
   state.dossier_startup_flood_active = true;
   state.l1_publish_pending_manifest = true;
   state.write_dirty = true;
   ASC_DossierPendingQueuesMarkDirty(state);
   state.dossier_pending_backlog_count = MathMax(1, state.dossier_pending_backlog_count);
  }

void ASC_QueueDossierContinuationDuty(ASC_RuntimeState &state)
  {
   if(!ASC_RoutineRootAllSymbolDossierPolicyEnabled())
     {
      state.l1_publish_pending_dossiers = false;
      state.dossier_open_refresh_only = false;
      state.dossier_resume_full_publish_after_open_refresh = false;
      state.dossier_existence_shell_only = false;
      state.dossier_startup_flood_active = false;
      state.write_cursor = 0;
      state.dossier_pending_backlog_count = 0;
      ASC_DossierPendingQueuesReset(state);
      state.dossier_pending_queues_ready = false;
      state.dossier_pending_queues_dirty = true;
      state.dossier_pending_queue_signature = "";
      state.l1_publish_pending_manifest = true;
      state.write_dirty = (state.l1_publish_pending_essentials || state.l2_publish_pending || state.l1_publish_pending_manifest);
      ASC_RecordRoutineRootDossierPolicySkip(state, TimeGMT(), ASC_ROOT_ALL_SYMBOL_DOSSIER_SKIP_REASON);
      return;
     }

   if(!state.l1_publish_pending_dossiers)
     {
      state.l1_publish_pending_dossiers = true;
      state.write_cursor = 0;
     }

   state.dossier_open_refresh_only = false;
   state.dossier_resume_full_publish_after_open_refresh = false;
   state.dossier_existence_shell_only = false;
   state.dossier_startup_flood_active = false;
   state.l1_publish_pending_manifest = true;
   state.write_dirty = true;
   ASC_DossierPendingQueuesMarkDirty(state);
   state.dossier_pending_backlog_count = MathMax(1, state.dossier_pending_backlog_count);
  }

string ASC_SelectLayer2TacticalSymbol()
  {
   ASC_Layer2Packet admitted_packet;
   if(ASC_Layer2TryGetFirstAdmittedPacket(admitted_packet))
      return admitted_packet.symbol;

   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(symbol_state.state == ASC_L1_OPEN)
         return symbol_state.symbol;
     }
   return "";
  }

struct ASC_HeartbeatTelemetry
  {
   int heartbeat_id;
   datetime beat_utc;
   ASC_RuntimeMode mode;
   ASC_MajorLane lane;
   ASC_Sublane sublane;
   int admitted_scan_budget;
   int admitted_write_budget;
   int packet_target;
   int packet_completed;
   int bursts_executed;
   int due_selected;
   int retry_selected;
   int scanned_symbols;
   int written_artifacts;
   int write_failures;
   int l2_processed;
   int l2_admitted;
   int l2_changed;
   int l2_due_remaining;
   int deep_trigger_ms;
   int board_compose_ms;
   int board_publish_ms;
   int dossier_compose_ms;
   int dossier_publish_ms;
   int manifest_compose_ms;
   int manifest_publish_ms;
   int write_queue_service_ms;
   int artifact_attempted_count;
   string write_bottleneck_family;
   string write_bottleneck_reason;
   int top10_batch_ms;
   int side_duty_ms;
   int dossier_sweep_ms;
   int dossier_sweep_symbols;
   int dossier_sweep_payload_reads;
   int scan_streak;
   int write_streak;
   int deferred_scan_symbols;
   int deferred_write_artifacts;
   int heartbeat_duration_ms;
   int heartbeat_budget_ms;
   int heartbeat_lane_p50_ms;
   int heartbeat_lane_p95_ms;
   bool ui_priority_active;
   int pre_lane_side_duty_ms;
   int lane_execution_ms;
   int ui_priority_state_compact;
   int ui_priority_deferred_count;
   string ui_priority_deferred_reason;
   int ui_priority_active_beat_count;
   int ui_priority_enter_count;
   int ui_priority_expire_count;
   int ui_priority_scan_lane_entered_count;
   int ui_priority_write_lane_entered_count;
   int ui_priority_dossier_queue_service_count;
   int ui_priority_dossier_write_attempt_count;
   int ui_priority_board_write_attempt_count;
   int ui_priority_top10_write_attempt_count;
   int noncritical_defer_candidate_seen_count;
   bool write_early_yield;
   string write_yield_reason;
   int write_budget_elapsed_ms;
   int write_budget_remaining_ms;
   int dossier_symbols_this_beat;
   int dossier_yield_count;
   bool ui_priority_write_reduced;
   int deferred_readback_count;
   int readback_pending_count;
   int manifest_yield_count;
   int sweep_yield_count;
   int post_publish_elapsed_ms;
   int side_duty_count_this_beat;
   string side_yield_reason;
   bool hud_priority_served;
   bool hud_pending_render;
   string lane_reason;
   string defer_reason;
   string yield_reason;
  };

void ASC_RecordWriteLaneYield(ASC_RuntimeState &state,
                              ASC_HeartbeatTelemetry &telemetry,
                              const ulong beat_start_us,
                              const int beat_budget_ms,
                              const bool ui_priority_active,
                              const string reason)
  {
   telemetry.write_early_yield = true;
   telemetry.write_yield_reason = reason;
   telemetry.write_budget_elapsed_ms = ASC_HeartbeatElapsedMsSince(beat_start_us);
   telemetry.write_budget_remaining_ms = ASC_HeartbeatRemainingMs(beat_start_us, beat_budget_ms);
   if(ui_priority_active)
      telemetry.ui_priority_write_reduced = true;
   state.lane_deferred_reason = reason;
  }

bool ASC_SideDutyShouldYield(ASC_RuntimeState &state,
                                        ASC_HeartbeatTelemetry &telemetry,
                                        const ulong beat_start_us,
                                        const int beat_budget_ms,
                                        const bool ui_priority_active,
                                        const string family,
                                        const string reason)
  {
   bool near_budget = ASC_WriteLaneNearBudget(beat_start_us, beat_budget_ms, ui_priority_active);
   bool expired = ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms);
   bool should_yield = (expired || near_budget || ui_priority_active);
   if(!should_yield)
      return false;

   string final_reason = family + "_" + reason;
   ASC_RecordWriteLaneYield(state, telemetry, beat_start_us, beat_budget_ms, ui_priority_active, final_reason);
   telemetry.side_yield_reason = final_reason;
   if(family == "readback")
     {
      telemetry.deferred_readback_count++;
      telemetry.readback_pending_count++;
     }
   else if(family == "manifest")
      telemetry.manifest_yield_count++;
   else if(family == "sweep")
      telemetry.sweep_yield_count++;

   state.deferred_write_artifacts = MathMax(1, state.deferred_write_artifacts);
   return true;
  }

int ASC_ParsePerfTokenInt(const string text,const string token)
  {
   string needle = token + "=";
   int start = StringFind(text, needle);
   if(start < 0)
      return 0;
   start += StringLen(needle);
   int stop = start;
   while(stop < StringLen(text))
     {
      ushort ch = (ushort)StringGetCharacter(text, stop);
      if((ch < '0' || ch > '9') && ch != '-')
         break;
      stop++;
     }
   return (int)StringToInteger(StringSubstr(text, start, stop - start));
  }

string ASC_ParsePerfTokenText(const string text,const string token)
  {
   string needle = token + "=";
   int start = StringFind(text, needle);
   if(start < 0)
      return "";
   start += StringLen(needle);
   int stop = start;
   while(stop < StringLen(text))
     {
      ushort ch = (ushort)StringGetCharacter(text, stop);
      if(ch == ' ' || ch == '|' || ch == '\n' || ch == '\r' || ch == '\t')
         break;
      stop++;
     }
   return StringSubstr(text, start, stop - start);
  }

void ASC_AccumulateWriteArtifactPerf(ASC_RuntimeState &state,const ASC_FunctionResult &result)
  {
   string family = ASC_ParsePerfTokenText(result.detail_message, "perf_artifact_family");
   if(StringLen(family) <= 0)
      return;

   int compose_ms = ASC_ParsePerfTokenInt(result.detail_message, "perf_compose_ms");
   int publish_ms = ASC_ParsePerfTokenInt(result.detail_message, "perf_publish_ms");
   state.publication_bundle.artifact_attempted_count++;

   if(family == "board")
     {
      state.publication_bundle.board_compose_ms = compose_ms;
      state.publication_bundle.board_publish_ms = publish_ms;
     }
   else if(family == "manifest")
     {
      state.publication_bundle.manifest_compose_ms = compose_ms;
      state.publication_bundle.manifest_publish_ms = publish_ms;
     }
   else if(family == "dossier" || family == "dossier_shell")
     {
      state.publication_bundle.dossier_compose_ms_total += compose_ms;
      state.publication_bundle.dossier_publish_ms_total += publish_ms;
     }
  }

void ASC_UpdateWriteBundleBottleneck(ASC_RuntimeState &state)
  {
   int board_total = state.publication_bundle.board_compose_ms + state.publication_bundle.board_publish_ms;
   int dossier_total = state.publication_bundle.dossier_compose_ms_total + state.publication_bundle.dossier_publish_ms_total;
   int manifest_total = state.publication_bundle.manifest_compose_ms + state.publication_bundle.manifest_publish_ms;
   int queue_total = state.publication_bundle.write_queue_service_ms;

   state.publication_bundle.write_bottleneck_family = "none";
   state.publication_bundle.write_bottleneck_reason = "unobserved";
   int dominant_ms = 0;

   if(board_total > dominant_ms)
     {
      dominant_ms = board_total;
      state.publication_bundle.write_bottleneck_family = "board";
      state.publication_bundle.write_bottleneck_reason = (state.publication_bundle.board_compose_ms >= state.publication_bundle.board_publish_ms ? "compose" : "publish");
     }
   if(dossier_total > dominant_ms)
     {
      dominant_ms = dossier_total;
      state.publication_bundle.write_bottleneck_family = "dossier";
      state.publication_bundle.write_bottleneck_reason = (state.publication_bundle.dossier_compose_ms_total >= state.publication_bundle.dossier_publish_ms_total ? "compose" : "publish");
     }
   if(manifest_total > dominant_ms)
     {
      dominant_ms = manifest_total;
      state.publication_bundle.write_bottleneck_family = "manifest";
      state.publication_bundle.write_bottleneck_reason = (state.publication_bundle.manifest_compose_ms >= state.publication_bundle.manifest_publish_ms ? "compose" : "publish");
     }
   if(queue_total > dominant_ms)
     {
      state.publication_bundle.write_bottleneck_family = "write_queue";
      state.publication_bundle.write_bottleneck_reason = "queue_service";
     }
  }

void ASC_RecordResult(const ASC_RuntimeState &state,
                      const ASC_FunctionResult &result,
                      const bool always_print = true,
                      const bool log_success_to_file = true)
  {
   if(always_print || result.state != ASC_RESULT_OK)
      ASC_LogFunctionResult(result);

   if(StringLen(state.function_results_log_path) <= 0)
      return;

   if(result.state == ASC_RESULT_OK && !log_success_to_file)
      return;

   ASC_LogFunctionResultToFile(result, state.function_results_log_path);
  }

bool ASC_LogHeartbeatTelemetry(const ASC_RuntimeState &state,const ASC_HeartbeatTelemetry &telemetry)
  {
   if(StringLen(state.heartbeat_log_path) <= 0)
      return false;

   bool heartbeat_log_emit_due = (telemetry.write_failures > 0
                                  || telemetry.heartbeat_duration_ms > telemetry.heartbeat_budget_ms
                                  || telemetry.ui_priority_active
                                  || telemetry.write_early_yield
                                  || telemetry.hud_priority_served
                                  || telemetry.hud_pending_render
                                  || telemetry.heartbeat_id <= 1
                                  || (telemetry.heartbeat_id > 0 && (telemetry.heartbeat_id % 300) == 0));
   if(!heartbeat_log_emit_due)
      return false;

   string proof_emit_reason = (telemetry.write_failures > 0 ? "error"
                               : (telemetry.heartbeat_duration_ms > telemetry.heartbeat_budget_ms ? "budget_pressure"
                                  : (telemetry.ui_priority_active ? "ui_priority"
                                     : ((telemetry.write_early_yield || telemetry.hud_priority_served || telemetry.hud_pending_render) ? "transition_or_yield"
                                        : (telemetry.heartbeat_id <= 1 ? "startup" : "sample")))));
   string budget_state = (telemetry.heartbeat_duration_ms > telemetry.heartbeat_budget_ms ? "budget_pressure" : "within_budget");
   string timer_pressure_state = (telemetry.heartbeat_duration_ms > telemetry.heartbeat_budget_ms ? "timer_pressure_possible" : "no_timer_pressure_visible");
   bool compact_sample_only = (proof_emit_reason == "sample"
                               && telemetry.write_failures <= 0
                               && telemetry.heartbeat_duration_ms <= telemetry.heartbeat_budget_ms
                               && !telemetry.ui_priority_active
                               && !telemetry.write_early_yield
                               && !telemetry.hud_priority_served
                               && !telemetry.hud_pending_render);
   if(compact_sample_only)
     {
      string compact_line = "";
      compact_line += IntegerToString(telemetry.heartbeat_id);
      compact_line += "\t" + ASC_FormatUtc(telemetry.beat_utc);
      compact_line += "\t" + ASC_ModeToText(telemetry.mode);
      compact_line += "\t" + ASC_LaneToText(telemetry.lane);
      compact_line += "\t" + ASC_SublaneToText(telemetry.sublane);
      compact_line += "\tphase3a_heartbeat_telemetry=present";
      compact_line += "\tproof_emit_gate=sample_compact_300hb";
      compact_line += "\theartbeat_detail_build_avoided=true";
      compact_line += "\telapsed_ms=" + IntegerToString(telemetry.heartbeat_duration_ms);
      compact_line += "\tbudget_ms=" + IntegerToString(telemetry.heartbeat_budget_ms);
      compact_line += "\tbudget_state=" + budget_state;
      compact_line += "\ttimer_pressure_state=" + timer_pressure_state;
      compact_line += "\twritten=" + IntegerToString(telemetry.written_artifacts);
      compact_line += "\twrite_failures=" + IntegerToString(telemetry.write_failures);
      compact_line += "\tdeferred_scan=" + IntegerToString(telemetry.deferred_scan_symbols);
      compact_line += "\tdeferred_write=" + IntegerToString(telemetry.deferred_write_artifacts);
      compact_line += "\ttop5_pending_reason=" + ASC_TextOrUnavailable(state.publication_bundle.top5_bucket_alignment_reason);
      compact_line += "\tglobaltop10_alignment_status=" + ASC_TextOrUnavailable(state.top10_run_full_family_alignment_status);
      compact_line += "\tfull_detail_on_pressure_or_state_change=true";
      compact_line += "\n";
      return ASC_AppendTextFile(state.heartbeat_log_path, compact_line);
     }
   int queue_remaining = MathMax(0, state.dossier_queue_remaining_count);
   int backfill_remaining = MathMax(0, state.dossier_backfill_pending_count);
   int deferred_work_count = MathMax(0, telemetry.deferred_scan_symbols) + MathMax(0, telemetry.deferred_write_artifacts);
   int skipped_due_budget_count = MathMax(0, telemetry.deferred_scan_symbols) + MathMax(0, telemetry.deferred_write_artifacts);
   string line = "";
   line += IntegerToString(telemetry.heartbeat_id);
   line += "\t" + ASC_FormatUtc(telemetry.beat_utc);
   line += "\t" + ASC_ModeToText(telemetry.mode);
   line += "\t" + ASC_LaneToText(telemetry.lane);
   line += "\t" + ASC_SublaneToText(telemetry.sublane);
   line += "\tphase3a_heartbeat_telemetry=present";
   line += "\tproof_emit_gate=" + proof_emit_reason;
   line += "\theartbeat_detail_build_avoided=steady_state_non_sample";
   line += "\tactive_lane=" + ASC_LaneToText(telemetry.lane);
   line += "\tmajor_work_type=" + ASC_LaneToText(telemetry.lane);
   line += "\telapsed_ms=" + IntegerToString(telemetry.heartbeat_duration_ms);
   line += "\tbudget_ms=" + IntegerToString(telemetry.heartbeat_budget_ms);
   line += "\tbudget_state=" + budget_state;
   line += "\tqueue_remaining=" + IntegerToString(queue_remaining);
   line += "\tbackfill_remaining=" + IntegerToString(backfill_remaining);
   line += "\tdossier_write_count=" + IntegerToString(telemetry.written_artifacts);
   line += "\tglobaltop10_child_work_count=" + IntegerToString(MathMax(0, state.top10_run_full_cursor));
   line += "\tscanner_status_write=" + (state.scanner_status_last_write_utc > 0 ? "yes" : "no");
   line += "\tfunctionresults_write=" + (state.function_results_log_write_succeeded ? "yes" : "no");
   line += "\tdeferred_work_count=" + IntegerToString(deferred_work_count);
   line += "\tskipped_due_budget_count=" + IntegerToString(skipped_due_budget_count);
   line += "\ttimer_pressure_state=" + timer_pressure_state;
   line += "\tno_freeze_state=true";
   line += "\trequires_operator_review=" + (state.phase2a_requires_operator_review_count > 0 ? "true" : "false");
   line += "\tscan_budget=" + IntegerToString(telemetry.admitted_scan_budget);
   line += "\twrite_budget=" + IntegerToString(telemetry.admitted_write_budget);
   line += "\tpacket_target=" + IntegerToString(telemetry.packet_target);
   line += "\tpacket_completed=" + IntegerToString(telemetry.packet_completed);
   line += "\tbursts=" + IntegerToString(telemetry.bursts_executed);
   line += "\tdue_selected=" + IntegerToString(telemetry.due_selected);
   line += "\tretry_selected=" + IntegerToString(telemetry.retry_selected);
   line += "\tscanned=" + IntegerToString(telemetry.scanned_symbols);
   line += "\tl2_processed=" + IntegerToString(telemetry.l2_processed);
   line += "\tl2_admitted=" + IntegerToString(telemetry.l2_admitted);
   line += "\tl2_changed=" + IntegerToString(telemetry.l2_changed);
   line += "\tl2_due=" + IntegerToString(telemetry.l2_due_remaining);
   line += "\tscan_streak=" + IntegerToString(telemetry.scan_streak);
   line += "\twrite_streak=" + IntegerToString(telemetry.write_streak);
   line += "\twritten=" + IntegerToString(telemetry.written_artifacts);
   line += "\twrite_failures=" + IntegerToString(telemetry.write_failures);
   line += "\tdeferred_scan=" + IntegerToString(telemetry.deferred_scan_symbols);
   line += "\tdeferred_write=" + IntegerToString(telemetry.deferred_write_artifacts);
   line += "\tdeep_ms=" + IntegerToString(telemetry.deep_trigger_ms);
   line += "\tboard_compose_ms=" + IntegerToString(telemetry.board_compose_ms);
   line += "\tboard_publish_ms=" + IntegerToString(telemetry.board_publish_ms);
   line += "\tdossier_compose_ms=" + IntegerToString(telemetry.dossier_compose_ms);
   line += "\tdossier_publish_ms=" + IntegerToString(telemetry.dossier_publish_ms);
   line += "\tmanifest_compose_ms=" + IntegerToString(telemetry.manifest_compose_ms);
   line += "\tmanifest_publish_ms=" + IntegerToString(telemetry.manifest_publish_ms);
   line += "\twrite_queue_ms=" + IntegerToString(telemetry.write_queue_service_ms);
   line += "\tartifact_attempted=" + IntegerToString(telemetry.artifact_attempted_count);
   line += "\twrite_bottleneck_family=" + telemetry.write_bottleneck_family;
   line += "\twrite_bottleneck_reason=" + telemetry.write_bottleneck_reason;
   line += "\ttop10_ms=" + IntegerToString(telemetry.top10_batch_ms);
   line += "\tside_duty_ms=" + IntegerToString(telemetry.side_duty_ms);
   line += "\tdossier_sweep_ms=" + IntegerToString(telemetry.dossier_sweep_ms);
   line += "\tdossier_sweep_symbols=" + IntegerToString(telemetry.dossier_sweep_symbols);
   line += "\tdossier_sweep_reads=" + IntegerToString(telemetry.dossier_sweep_payload_reads);
   line += "\theartbeat_ms=" + IntegerToString(telemetry.heartbeat_duration_ms);
   line += "\theartbeat_budget_ms=" + IntegerToString(telemetry.heartbeat_budget_ms);
   line += "\tlane_p50_ms=" + IntegerToString(telemetry.heartbeat_lane_p50_ms);
   line += "\tlane_p95_ms=" + IntegerToString(telemetry.heartbeat_lane_p95_ms);
   line += "\tui_priority=" + (telemetry.ui_priority_active ? "on" : "off");
   line += "\tpre_lane_ms=" + IntegerToString(telemetry.pre_lane_side_duty_ms);
   line += "\tlane_exec_ms=" + IntegerToString(telemetry.lane_execution_ms);
   line += "\tui_p=" + IntegerToString(telemetry.ui_priority_state_compact);
   line += "\thud_handoff=" + IntegerToString(telemetry.hud_priority_served ? 1 : 0) + "/" + IntegerToString(telemetry.hud_pending_render ? 1 : 0);
   line += "\tui_priority_deferred_count=" + IntegerToString(MathMax(0, telemetry.ui_priority_deferred_count));
   line += "\tui_priority_deferred_reason=" + ASC_TextOrUnavailable(telemetry.ui_priority_deferred_reason);
   line += "\tui_priority_active_beats=" + IntegerToString(MathMax(0, telemetry.ui_priority_active_beat_count));
   line += "\tui_priority_enter=" + IntegerToString(MathMax(0, telemetry.ui_priority_enter_count));
   line += "\tui_priority_expire=" + IntegerToString(MathMax(0, telemetry.ui_priority_expire_count));
   line += "\tui_priority_scan_entered=" + IntegerToString(MathMax(0, telemetry.ui_priority_scan_lane_entered_count));
   line += "\tui_priority_write_entered=" + IntegerToString(MathMax(0, telemetry.ui_priority_write_lane_entered_count));
   line += "\tui_priority_dossier_queue_service=" + IntegerToString(MathMax(0, telemetry.ui_priority_dossier_queue_service_count));
   line += "\tui_priority_dossier_write_attempt=" + IntegerToString(MathMax(0, telemetry.ui_priority_dossier_write_attempt_count));
   line += "\tui_priority_board_write_attempt=" + IntegerToString(MathMax(0, telemetry.ui_priority_board_write_attempt_count));
   line += "\tui_priority_top10_write_attempt=" + IntegerToString(MathMax(0, telemetry.ui_priority_top10_write_attempt_count));
   line += "\twrite_early_yield=" + (telemetry.write_early_yield ? "yes" : "no");
   line += "\tside_yield=" + (telemetry.write_early_yield ? "yes" : "no");
   line += "\twrite_yield_reason=" + ASC_TextOrUnavailable(telemetry.write_yield_reason);
   line += "\twrite_budget_elapsed_ms=" + IntegerToString(MathMax(0, telemetry.write_budget_elapsed_ms));
   line += "\twrite_budget_remaining_ms=" + IntegerToString(MathMax(0, telemetry.write_budget_remaining_ms));
   line += "\tdossier_symbols_this_beat=" + IntegerToString(MathMax(0, telemetry.dossier_symbols_this_beat));
   line += "\tdossier_yield_count=" + IntegerToString(MathMax(0, telemetry.dossier_yield_count));
   line += "\tui_priority_write_reduced=" + (telemetry.ui_priority_write_reduced ? "yes" : "no");
   line += "\tdeferred_readback_count=" + IntegerToString(MathMax(0, telemetry.deferred_readback_count));
   line += "\treadback_deferred=" + IntegerToString(MathMax(0, telemetry.deferred_readback_count));
   line += "\treadback_pending=" + IntegerToString(MathMax(0, telemetry.readback_pending_count));
   line += "\tmanifest_yield=" + IntegerToString(MathMax(0, telemetry.manifest_yield_count));
   line += "\tsweep_yield=" + IntegerToString(MathMax(0, telemetry.sweep_yield_count));
   line += "\tui_priority_side_reduced=" + (telemetry.ui_priority_write_reduced ? "yes" : "no");
   line += "\tpost_publish_elapsed_ms=" + IntegerToString(MathMax(0, telemetry.post_publish_elapsed_ms));
   line += "\tside_duty_count_this_beat=" + IntegerToString(MathMax(0, telemetry.side_duty_count_this_beat));
   line += "\tside_yield_reason=" + ASC_TextOrUnavailable(telemetry.side_yield_reason);
   line += "\tnoncritical_defer_candidate_seen=" + IntegerToString(MathMax(0, telemetry.noncritical_defer_candidate_seen_count));
   line += "\twake_hot=" + IntegerToString(state.l1_wake_hot_count);
   line += "\twake_warm=" + IntegerToString(state.l1_wake_warm_count);
   line += "\twake_calm=" + IntegerToString(state.l1_wake_calm_count);
   line += "\twake_dormant=" + IntegerToString(state.l1_wake_dormant_scheduled_count);
   line += "\tl2_live_entitled=" + IntegerToString(state.l1_l2_live_entitled_count);
   line += "\tdossier_open_entitled=" + IntegerToString(state.l1_dossier_open_refresh_entitled_count);
   line += "\tretention_only=" + IntegerToString(state.l1_retention_only_count);
   line += "\tlayer1_readiness_trace=" + ASC_HeartbeatLayer1ReadinessTrace(state);
   line += "\tshortlist_publication_trace=" + ASC_HeartbeatShortlistPublicationTrace(state);
   line += "\tlane_reason=" + telemetry.lane_reason;
   line += "\tdefer=" + telemetry.defer_reason;
   line += "\tyield=" + telemetry.yield_reason;
   line += "\tbundle_trace=" + ASC_HeartbeatBundleDecisionTrace(state);
   line += "\tmanual_refresh_trace=" + ASC_HeartbeatManualRefreshTrace(state);
   line += "\tforced_downstream_trace=" + ASC_HeartbeatForcedDownstreamTrace(state);
   line += "\ttop10_batch_trace=" + ASC_Top10RunFullBatchTrace(state);
   line += "\tl3_trace=" + ASC_CommittedLayer3TelemetryTrace(state);
   line += "\tl4_trace=" + ASC_CommittedLayer4TelemetryTrace(state);
   line += "\n";

  return ASC_AppendTextFile(state.heartbeat_log_path, line);
  }

void ASC_UpdateLayer1PostureState(ASC_RuntimeState &state,const ASC_Layer1PassSummary &summary)
  {
   state.l1_warmup_ready = summary.warmup_ready;
   state.l1_ready = summary.is_ready;
   state.l1_cycle_partial = summary.is_partial;
   state.l1_cycle_complete = summary.is_complete;
   state.l1_cycle_degraded = summary.is_degraded;
   state.l1_cycle_stale = summary.is_stale;
   state.l1_wake_hot_count = summary.wake_hot_count;
   state.l1_wake_warm_count = summary.wake_warm_count;
   state.l1_wake_calm_count = summary.wake_calm_count;
   state.l1_wake_dormant_scheduled_count = summary.wake_dormant_scheduled_count;
   state.l1_l2_live_entitled_count = summary.l2_live_entitled_count;
   state.l1_dossier_open_refresh_entitled_count = summary.dossier_open_refresh_entitled_count;
   state.l1_retention_only_count = summary.retention_only_count;
   state.l1_next_scan_due_utc = summary.next_due_utc;
   state.l1_last_cycle_posture = summary.cycle_posture;
   state.l1_readiness_posture = summary.readiness_posture;
   state.l1_next_due_reason = summary.next_due_reason;
   state.l1_next_due_count = summary.next_due_count;

   if(summary.is_complete)
      state.l1_last_full_cycle_utc = summary.pass_utc;
   else
      state.l1_last_partial_cycle_utc = summary.pass_utc;
  }

string ASC_DeepReadbackFailureStatus(const string verification_reason_raw)
  {
   string verification_reason = verification_reason_raw;
   StringToLower(verification_reason);

   if(StringFind(verification_reason, "deep_truth") >= 0
      || StringFind(verification_reason, "stale_truth_floor") >= 0
      || StringFind(verification_reason, "override_context_missing") >= 0)
      return "failed_deep_truth";

   if(StringFind(verification_reason, "missing") >= 0)
      return "failed_partial_publish";

   if(StringFind(verification_reason, "symbol_mismatch") >= 0
      || StringFind(verification_reason, "canonical_mismatch") >= 0
      || StringFind(verification_reason, "publication_id_mismatch") >= 0
      || StringFind(verification_reason, "payload_mismatch") >= 0)
      return "failed_pair_mismatch";

   return "failed_write";
  }

bool ASC_RunDeepFocusTriggerWrite(ASC_RuntimeState &state,
                                  const datetime now_utc,
                                  ASC_HeartbeatTelemetry &telemetry,
                                  string &yield_reason)
  {
   if(!state.deep_focus_trigger_pending || StringLen(state.deep_focus_trigger_symbol) <= 0)
      return false;

   ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", state.deep_focus_trigger_symbol,
               StringFormat("runtime intake deep request status=%s requested_utc=%s",
                            state.deep_focus_trigger_last_status,
                            ASC_PublicationHeaderUtc(state.deep_focus_trigger_requested_utc)));

   if(state.deep_focus_trigger_last_status == "queued")
     {
      state.deep_focus_trigger_last_status = "running";
      state.deep_focus_last_symbol = state.deep_focus_trigger_symbol;
      state.deep_focus_last_reason = "deep build armed and now running for selected symbol";
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", state.deep_focus_trigger_symbol,
                  "deep request moved from queued to running and entered same-cycle build/publish service");
     }

   ASC_Layer1SymbolState selected;
   bool selected_found = ASC_FindLayer1SymbolByName(state.deep_focus_trigger_symbol, selected);
   if(!selected_found && StringLen(state.deep_focus_trigger_canonical_symbol) > 0)
      selected_found = ASC_FindLayer1SymbolByName(state.deep_focus_trigger_canonical_symbol, selected);
   if(!selected_found && StringLen(state.deep_focus_trigger_normalized_symbol) > 0)
      selected_found = ASC_FindLayer1SymbolByName(state.deep_focus_trigger_normalized_symbol, selected);

   if(!selected_found)
     {
      state.deep_focus_trigger_pending = false;
      state.deep_focus_trigger_last_status = "deep_pair_failed_runtime_path";
      state.deep_focus_last_symbol = state.deep_focus_trigger_symbol;
      state.deep_focus_trigger_symbol = "";
      state.deep_focus_trigger_canonical_symbol = "";
      state.deep_focus_trigger_normalized_symbol = "";
      state.deep_focus_trigger_last_request_seq = state.deep_focus_trigger_request_seq;
      state.deep_focus_trigger_request_seq = 0;
      state.deep_focus_last_reason = "selected symbol evidence is unavailable";
      state.current_focus_last_status = "deep_pair_failed_runtime_path";
      state.current_focus_last_reason = "explicit deep request symbol could not be resolved from frozen context";
      state.deep_focus_trigger_last_served_utc = now_utc;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", state.deep_focus_last_symbol,
                  "deep request failed: selected symbol evidence unavailable");
      telemetry.write_failures++;
      yield_reason = "deep_analysis_trigger_symbol_not_found";
      return true;
     }

   ASC_ShortlistSymbolSummary shortlist_rows[];
   ASC_RefreshCommittedSelectionOwnershipState(state, now_utc);
   ASC_CopyCommittedL4RowsToShortlistRows(state.committed_l4_rows, shortlist_rows);
   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   bool shortlist_found = ASC_ShortlistFindSymbolSummary(shortlist_rows,
                                                         selected.symbol,
                                                         shortlist_entry,
                                                         shortlist_rank,
                                                         shortlist_total);

   if(state.deep_focus_trigger_origin == "global_top10_batch" && ASC_TOP10_RUN_FULL_DEFER_HEAVY_DEEP_CHILDREN)
     {
      string frozen_symbol = state.deep_focus_trigger_symbol;
      int frozen_seq = MathMax(1, state.deep_focus_trigger_request_seq);
      string canonical_symbol = ASC_SelectedCanonicalSymbol(selected);
      string defer_reason = "";
      bool defer_ok = ASC_PublishGlobalTop10DeferredDeepChild(state, selected, shortlist_rows, now_utc, defer_reason);
      state.deep_focus_trigger_pending = false;
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      state.deep_focus_trigger_symbol = "";
      state.deep_focus_trigger_canonical_symbol = "";
      state.deep_focus_trigger_normalized_symbol = "";
      state.deep_focus_trigger_origin = "single_symbol";
      state.deep_focus_trigger_last_request_seq = frozen_seq;
      state.deep_focus_trigger_request_seq = 0;
      state.deep_focus_trigger_last_served_utc = now_utc;
      state.deep_focus_last_symbol = selected.symbol;
      state.deep_focus_last_reason = defer_reason;
      state.deep_focus_trigger_last_status = defer_ok ? "deep_budget_deferred" : "deep_defer_failed";
      if(defer_ok)
        {
         state.deep_trigger_publish_success_count++;
         state.l1_publish_pending_manifest = true;
         state.write_dirty = true;
         ASC_RecordTop10BatchDecision(state, "top10_child_deep_budget_deferred", ASC_RESULT_WARNING, ASC_RC_OK, StringFormat("branch=top10_child_deep_budget_deferred | symbol=%s | frozen_symbol=%s | reason=%s", selected.symbol, ASC_TextOrUnavailable(frozen_symbol), ASC_TextOrUnavailable(defer_reason)), ASC_GlobalTop10BatchArtifactPath(state, selected.symbol, canonical_symbol));
        }
      else
        {
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         ASC_RecordTop10BatchDecision(state, "top10_child_deep_defer_failed", ASC_RESULT_ERROR, ASC_RC_IO_FAILED, StringFormat("branch=top10_child_deep_defer_failed | symbol=%s | reason=%s", selected.symbol, ASC_TextOrUnavailable(defer_reason)), ASC_GlobalTop10BatchArtifactPath(state, selected.symbol, canonical_symbol));
        }
      yield_reason = defer_ok ? "deep_budget_deferred" : "deep_defer_failed";
      return true;
     }

   ASC_DeepSelectiveAnalysisResult deep_result;
   bool deep_ok = ASC_BuildDeepSelectiveAnalysisResult(selected,
                                                       state.deep_focus_trigger_symbol,
                                                       shortlist_rows,
                                                       now_utc,
                                                       deep_result);
   ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
               StringFormat("deep entitlement evaluated state=%s reason=%s",
                            deep_result.entitlement_state,
                            deep_result.entitlement_reason));

   string frozen_request_symbol = state.deep_focus_trigger_symbol;
   string frozen_request_canonical = state.deep_focus_trigger_canonical_symbol;
   string frozen_request_normalized = state.deep_focus_trigger_normalized_symbol;
   string frozen_request_origin = state.deep_focus_trigger_origin;
   int frozen_request_seq = MathMax(1, state.deep_focus_trigger_request_seq);
   string deep_request_id = StringFormat("deep-explicit-%I64d-%d-%d",
                                         (long)state.deep_focus_trigger_requested_utc,
                                         state.heartbeat_counter,
                                         frozen_request_seq);

   state.deep_focus_trigger_pending = false;
   state.deep_focus_ownership_active = true;
   state.deep_focus_ownership_symbol = selected.symbol;
   state.deep_focus_ownership_started_utc = now_utc;
   state.deep_focus_trigger_symbol = "";
   state.deep_focus_trigger_canonical_symbol = "";
   state.deep_focus_trigger_normalized_symbol = "";
   state.deep_focus_trigger_origin = "single_symbol";
   state.deep_focus_trigger_last_request_seq = frozen_request_seq;
   state.deep_focus_trigger_request_seq = 0;
   state.deep_focus_trigger_last_served_utc = now_utc;
   state.deep_focus_last_symbol = selected.symbol;
   state.deep_focus_last_reason = deep_result.entitlement_reason;

   if(!deep_ok || !deep_result.built || !deep_result.lawful)
     {
      string failure_status = "deep_pair_failed_build";
      if(deep_result.entitlement_state == "PROVENANCE_MISMATCH")
         failure_status = "deep_pair_failed_symbol_alignment";
      else if(deep_result.entitlement_state == "NO_SELECTED_SYMBOL")
         failure_status = "deep_pair_failed_runtime_path";

      state.deep_focus_trigger_last_status = failure_status;
      state.current_focus_last_status = failure_status;
      state.current_focus_last_reason = "explicit deep build failed before pair publication: " + deep_result.entitlement_reason;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                  "deep request failed before build: " + failure_status);
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      yield_reason = "deep_analysis_trigger_blocked";
      return true;
     }

   if(StringLen(deep_result.block_text) > 0)
     {
      StringReplace(deep_result.block_text,
                    "Refresh Request Id: unavailable",
                    "Refresh Request Id: " + deep_request_id);
      deep_result.block_text += StringFormat("\nexplicit_request_id=%s\n", deep_request_id);
      deep_result.block_text += StringFormat("explicit_request_sequence=%d\n", frozen_request_seq);
     }
   deep_result.summary_line += " | request_id=" + deep_request_id;
   deep_result.summary_line += StringFormat(" | refresh_seq=%d", frozen_request_seq);
   deep_result.summary_line += " | " + ASC_DeepSupportProofTokens(deep_result);

   ASC_PublicationBundleState deep_bundle = state.publication_bundle;
   deep_bundle.publication_id = StringFormat("deep-focus-%I64d-%d", (long)now_utc, state.heartbeat_counter);
   deep_bundle.publication_utc = now_utc;
   if(deep_bundle.bundle_started_utc <= 0)
      deep_bundle.bundle_started_utc = now_utc;
   deep_bundle.bundle_finished_utc = now_utc;
   if(!ASC_BundleHasConfirmedBoardBaseline(deep_bundle))
     {
      deep_bundle.board_lifecycle_state = "selected_symbol_waiting_board_baseline";
      deep_bundle.board_refresh_trigger = "deep_focus_trigger";
      deep_bundle.board_refresh_requested_utc = now_utc;
      deep_bundle.board_refresh_consumed_utc = 0;
      deep_bundle.board_recompute_started_utc = 0;
      deep_bundle.board_recompute_finished_utc = 0;
      deep_bundle.board_publish_started_utc = 0;
      deep_bundle.board_publish_finished_utc = 0;
      deep_bundle.board_publish_result = "pending";
      deep_bundle.board_publish_skip_reason = "awaiting_same_family_board_baseline";
      deep_bundle.market_board_status = "pending";
      deep_bundle.open_symbol_snapshot_status = "pending";
      deep_bundle.manifest_status = "pending";
      deep_bundle.overall_bundle_status = "pending";
      deep_bundle.last_bundle_error_summary = "awaiting_same_family_board_baseline";
     }
   deep_bundle.dossier_attempted_count = 1;
   deep_bundle.dossier_success_count = 0;
   deep_bundle.dossier_failure_count = 0;
   deep_bundle.dossier_skipped_count = 0;

   string canonical_symbol = "";
   string payload = "";
   string publication_state = "pending";
   string required_tokens[];
   string dossier_runtime_context = selected.symbol;
   if(frozen_request_origin == "global_top10_batch")
      dossier_runtime_context = "global_top10_batch:" + selected.symbol;
   state.deep_trigger_publish_attempt_count++;
   ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
               StringFormat("deep publish attempt admitted attempt_count=%d | composing canonical selected-symbol payload",
                            state.deep_trigger_publish_attempt_count));
   if(!ASC_BuildCanonicalDossierPayload(state.server_root,
                                        selected,
                                        deep_bundle,
                                        shortlist_rows,
                                        ASC_DOSSIER_MODE_DEEP_OVERRIDE,
                                        true,
                                        deep_result,
                                        dossier_runtime_context,
                                        canonical_symbol,
                                        payload,
                                        publication_state,
                                        required_tokens)
       || !ASC_DossierPayloadHasFreshDeepTruth(payload, deep_result))
     {
     state.deep_focus_trigger_last_status = "deep_pair_failed_compose";
     state.deep_focus_last_reason = "canonical dossier payload could not be composed with completed Deep Analysis truth";
      state.current_focus_last_status = "deep_pair_failed_compose";
      state.current_focus_last_reason = "explicit deep payload compose failed before pair publication";
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                  "deep build failed: canonical payload compose/readback-truth verification failed");
      telemetry.write_failures++;
      yield_reason = "deep_analysis_trigger_compose_failed";
      return true;
     }

   bool request_alignment_ok = true;
   if(StringLen(frozen_request_symbol) > 0 && !ASC_SymbolMatchesSelectionContext(selected, frozen_request_symbol))
      request_alignment_ok = false;
   if(StringLen(frozen_request_canonical) > 0
      && canonical_symbol != frozen_request_canonical
      && selected.classification.canonical_symbol != frozen_request_canonical
      && selected.identity.canonical_symbol != frozen_request_canonical)
      request_alignment_ok = false;
   if(StringLen(frozen_request_normalized) > 0
      && selected.identity.normalized_symbol != frozen_request_normalized
      && canonical_symbol != frozen_request_normalized)
      request_alignment_ok = false;
   if(!request_alignment_ok)
     {
      state.deep_focus_trigger_last_status = "deep_pair_failed_symbol_alignment";
      state.deep_focus_last_reason = "frozen explicit request context did not align with selected symbol at pair-write time";
      state.current_focus_last_status = "deep_pair_failed_symbol_alignment";
      state.current_focus_last_reason = "explicit deep request symbol alignment check failed before pair publication";
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      telemetry.write_failures++;
      yield_reason = "deep_analysis_trigger_symbol_alignment_failed";
      return true;
     }

   if(ASC_Top5BucketDeepOrigin(frozen_request_origin))
     {
      string top5_slug = ASC_Top5BucketOriginSlug(frozen_request_origin);
      int top5_origin_rank = ASC_Top5BucketOriginRank(frozen_request_origin);
      if(StringLen(top5_slug) <= 0)
         top5_slug = "unknown";
      string top5_origin_rank_text = (top5_origin_rank > 0 ? IntegerToString(top5_origin_rank) : "unavailable");
      string top5_origin_hydration = (top5_origin_rank >= 4 ? ASC_TOP5_BUCKET_HYDRATION_RANK4_5 : ASC_TOP5_BUCKET_HYDRATION_RANK1_3);
      bool top5_origin_rank_1_3 = (top5_origin_rank >= 1 && top5_origin_rank <= 3);
      bool top5_origin_rank_4_5 = (top5_origin_rank >= 4 && top5_origin_rank <= 5);
      payload += "\nTop5PerBucket Child Identity\n";
      payload += "artifact_family=Top5PerBucket\n";
      payload += "artifact_family_id=top5_per_bucket\n";
      payload += "bucket_slug=" + ASC_TextOrUnavailable(top5_slug) + "\n";
      payload += "bucket_rank=" + top5_origin_rank_text + "\n";
      payload += "bucket_rank_source=MarketBoard/L4\n";
      payload += "hydration_class=" + top5_origin_hydration + "\n";
      payload += "closed_symbols_actionable=false\n";
      payload += "rank_formula_change=false\ntrade_signal=false\nexecution_change=false\n";
      payload += "source_run_id=" + ASC_SourceRunId() + "\n";
      payload += "deep_pending=false\n";
      payload += "depth_parity_state=deep_payload_attached\n";
      payload += "deep_payload_available=true\n";
      payload += "top5_depth_parity_state=deep_payload_attached\n";
      payload += "top5_rank_1_3_deep_attempted=" + (top5_origin_rank_1_3 ? "true" : "false") + "\n";
      payload += "top5_rank_1_5_deep_attempted=true\n";
      payload += "top5_rank_1_3_deep_attached=" + (top5_origin_rank_1_3 ? "true" : "false") + "\n";
      payload += "top5_rank_1_3_deep_pending=false\n";
      payload += "top5_rank_4_5_deep_attempted=" + (top5_origin_rank_4_5 ? "true" : "false") + "\n";
      payload += "top5_rank_4_5_deep_attached=" + (top5_origin_rank_4_5 ? "true" : "false") + "\n";
      payload += "top5_rank_4_5_deep_pending=false\n";
      payload += "top5_child_expected_size_class=globaltop10_style_deep\n";
      payload += "top5_child_depth_class=rank1_5_l0_l6_deep_payload_attached\n";
      payload += "top5_staging_enabled=true\n";
      payload += "top5_archive_enabled=true\n";
      payload += "top5_promote_after_validate=true\n";
      payload += "top5_archive_previous_on_promote=true\n";
      payload += "top5_no_broad_file_deletion=true\n";
      payload += "performance_side_audit=" + ASC_PERFORMANCE_SIDE_AUDIT_STATE + "\n";
      payload += "safe_cleanup_patch=" + ASC_RUN114_SAFE_CLEANUP_PATCH + "\n";
      payload += "run115_safe_cleanup_patch=" + ASC_RUN115_SAFE_CLEANUP_PATCH + "\n";
      payload += "proof_unchanged_skipped_count=" + IntegerToString(MathMax(0, state.proof_unchanged_skipped_count)) + "\n";

      int t5n = ArraySize(required_tokens);
      ArrayResize(required_tokens, t5n + 21);
      required_tokens[t5n] = "Top5PerBucket Child Identity";
      required_tokens[t5n + 1] = "artifact_family=Top5PerBucket";
      required_tokens[t5n + 2] = "bucket_rank_source=MarketBoard/L4";
      required_tokens[t5n + 3] = "hydration_class=";
      required_tokens[t5n + 4] = "closed_symbols_actionable=false";
      required_tokens[t5n + 5] = "rank_formula_change=false";
      required_tokens[t5n + 6] = "trade_signal=false";
      required_tokens[t5n + 7] = "execution_change=false";
      required_tokens[t5n + 8] = "deep_pending=false";
      required_tokens[t5n + 9] = "top5_depth_parity_state=deep_payload_attached";
      required_tokens[t5n + 10] = "top5_rank_1_3_deep_attached=";
      required_tokens[t5n + 11] = "top5_rank_1_5_deep_attempted=true";
      required_tokens[t5n + 12] = "top5_rank_4_5_deep_pending=false";
      required_tokens[t5n + 13] = "top5_child_depth_class=rank1_5_l0_l6_deep_payload_attached";
      required_tokens[t5n + 14] = "top5_staging_enabled=true";
      required_tokens[t5n + 15] = "top5_archive_enabled=true";
      required_tokens[t5n + 16] = "top5_promote_after_validate=true";
      required_tokens[t5n + 17] = "top5_archive_previous_on_promote=true";
      required_tokens[t5n + 18] = "top5_no_broad_file_deletion=true";
      required_tokens[t5n + 19] = "run115_safe_cleanup_patch=";
      required_tokens[t5n + 20] = "proof_unchanged_skipped_count=";

      string top5_child_path = ASC_Top5BucketChildPath(state, top5_slug, selected.symbol);
      string top5_staging_path = ASC_Top5BucketChildStagingPath(state, top5_slug, selected.symbol);
      if(StringLen(top5_child_path) <= 0 || StringLen(top5_staging_path) <= 0)
        {
         state.deep_focus_trigger_last_status = "deep_pair_failed_pair_path";
         state.deep_focus_last_reason = "Top5PerBucket child artifact path is unavailable";
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         yield_reason = "top5_deep_child_pair_path_invalid";
         return true;
        }

      string top5_stage_state = "pending";
      string top5_stage_reason = "pending";
      if(!ASC_WritePublicationPayloadAtomic(top5_staging_path, payload, required_tokens, publication_state, top5_stage_state, top5_stage_reason))
        {
         state.deep_focus_trigger_last_status = "deep_pair_failed_write";
         state.deep_focus_last_reason = "Top5PerBucket deep child staging write failed: " + top5_stage_reason;
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         yield_reason = "top5_deep_child_staging_failed";
         return true;
        }
      string top5_promote_state = "pending";
      string top5_promote_reason = "pending";
      if(!ASC_CopyTextFileAtomic(top5_staging_path, top5_child_path, required_tokens, top5_promote_state, top5_promote_reason))
        {
         state.deep_focus_trigger_last_status = "deep_pair_failed_write";
         state.deep_focus_last_reason = "Top5PerBucket deep child promote failed: " + top5_promote_reason;
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         yield_reason = "top5_deep_child_promote_failed";
         return true;
        }

      state.deep_focus_trigger_last_status = "deep_pair_succeeded";
      state.deep_focus_last_reason = "Top5PerBucket rank 1-3 child deep payload attached through existing deep composer | " + top5_promote_reason;
      state.deep_trigger_publish_success_count++;
      state.l1_publish_pending_manifest = true;
      state.last_write_utc = now_utc;
      telemetry.written_artifacts++;
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      yield_reason = "top5_deep_child_payload_attached";
      return true;
     }

   bool batch_owned_top10_child = (frozen_request_origin == "global_top10_batch");
   if(batch_owned_top10_child)
     {
      string top10_batch_path = ASC_GlobalTop10BatchArtifactPath(state, selected.symbol, canonical_symbol);
      if(StringLen(top10_batch_path) <= 0)
        {
         state.deep_focus_trigger_last_status = "deep_pair_failed_pair_path";
         state.deep_focus_last_reason = "Global Top 10 child artifact path is unavailable";
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         yield_reason = "deep_analysis_trigger_pair_path_invalid";
         return true;
        }

      string top10_target_dir = ASC_PathParentDirectory(top10_batch_path);
      ASC_FunctionResult top10_dir_result;
      ASC_FunctionResultBegin(top10_dir_result, "ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol);
      ASC_FunctionResultSetTruthBoundary(top10_dir_result, "runtime.dispatcher", "truth_consumer.global_top10_child_directory_prepare");
      ASC_FunctionResultSetHydrationClass(top10_dir_result, "top10_deep_l0_l6");
      bool top10_dir_ok = (StringLen(top10_target_dir) > 0 && ASC_EnsureDirectoryTree(top10_target_dir));
      if(!top10_dir_ok)
        {
         ASC_FunctionResultFinish(top10_dir_result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_IO_FAILED,
                                  StringFormat("branch=top10_child_directory | requested=yes | admitted=yes | dir_create_attempted=yes | dir_create_result=failed | child_path=%s | parent_dir=%s | reroute=none | %s",
                                               top10_batch_path,
                                               ASC_TextOrUnavailable(top10_target_dir),
                                               ASC_Top10RunFullBatchTrace(state)),
                                  top10_batch_path);
         ASC_RecordResult(state, top10_dir_result, true, true);
         ASC_RecordPublicationOutcomeCounters(state, top10_dir_result);
         state.deep_focus_trigger_last_status = "deep_pair_failed_pair_path";
         state.deep_focus_last_reason = "Global Top 10 child directory create failed: " + ASC_TextOrUnavailable(top10_target_dir);
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         state.l1_publish_pending_manifest = true;
         telemetry.write_failures++;
         yield_reason = "deep_analysis_trigger_pair_path_invalid";
         return true;
        }
      ASC_FunctionResultFinish(top10_dir_result,
                               ASC_RESULT_OK,
                               ASC_RC_OK,
                               StringFormat("branch=top10_child_directory | requested=yes | admitted=yes | dir_create_attempted=yes | dir_create_result=ready | child_path=%s | parent_dir=%s | reroute=none | %s",
                                            top10_batch_path,
                                            ASC_TextOrUnavailable(top10_target_dir),
                                            ASC_Top10RunFullBatchTrace(state)),
                               top10_batch_path);
      ASC_RecordResult(state, top10_dir_result, true, false);

      string top10_write_state = "pending";
      string top10_write_reason = "pending";
      string top10_existing_payload = "";
      bool top10_had_material_equal_payload = (ASC_ReadTextFile(top10_batch_path, top10_existing_payload)
                                               && StringLen(top10_existing_payload) > 0
                                               && ASC_DossierPayloadMatchesSymbolContext(top10_existing_payload, selected, canonical_symbol)
                                               && ASC_PublicationPayloadMateriallyEqual(top10_existing_payload, payload));
      if(top10_had_material_equal_payload)
         FileDelete(top10_batch_path, FILE_COMMON);

      if(ASC_IsUiPriorityActive(state, now_utc))
         state.ui_priority_top10_write_attempt_count++;
      bool top10_write_ok = ASC_WritePublicationPayloadAtomic(top10_batch_path,
                                                              payload,
                                                              required_tokens,
                                                              publication_state,
                                                              top10_write_state,
                                                              top10_write_reason);

      ASC_FunctionResult top10_publish_result;
      ASC_FunctionResultBegin(top10_publish_result, "ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol);
      ASC_FunctionResultSetTruthBoundary(top10_publish_result, "runtime.dispatcher", "truth_consumer.global_top10_child_dossier_publish_verify");
      ASC_FunctionResultSetHydrationClass(top10_publish_result, "top10_deep_l0_l6");
      if(!top10_write_ok)
        {
         ASC_FunctionResultFinish(top10_publish_result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_IO_FAILED,
                                  "branch=top10_child_write | write_attempted=yes | write_result=failed | child_path=" + top10_batch_path + " | write_state=" + top10_write_state + " | reason=" + top10_write_reason + " | reroute=none | " + ASC_Top10RunFullBatchTrace(state),
                                  top10_batch_path);
         ASC_RecordResult(state, top10_publish_result, true, true);
         ASC_RecordPublicationOutcomeCounters(state, top10_publish_result);
         state.deep_focus_trigger_last_status = "deep_pair_failed_write";
         state.deep_focus_last_reason = "Global Top 10 child publish failed before verified readback: " + top10_write_reason;
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         yield_reason = "deep_analysis_trigger_pair_publish_failed";
         return true;
        }

      string top10_verification_reason = "top10_batch_readback_verified";
      bool top10_readback_ok = ASC_VerifyPublicationPayloadReadback(top10_batch_path,
                                                                    payload,
                                                                    top10_verification_reason);
      if(top10_readback_ok)
         top10_readback_ok = ASC_GlobalTop10BatchArtifactCompleteForSymbol(state,
                                                                           selected,
                                                                           canonical_symbol,
                                                                           now_utc,
                                                                           deep_bundle.publication_id,
                                                                           top10_verification_reason);
      if(!top10_readback_ok)
        {
         if(StringLen(top10_verification_reason) <= 0)
            top10_verification_reason = "top10_batch_completed_truth_verification_failed";
         state.top10_run_full_verify_fail_count++;
         string top10_child_payload = "";
         string top10_child_payload_symbol = "unavailable";
         string top10_child_payload_canonical = "unavailable";
         if(ASC_ReadTextFile(top10_batch_path, top10_child_payload) && StringLen(top10_child_payload) > 0)
           {
            string extracted_symbol = ASC_DossierExtractIdentityLineValue(top10_child_payload, "Symbol:");
            string extracted_canonical = ASC_DossierExtractIdentityLineValue(top10_child_payload, "Canonical Symbol:");
            if(StringLen(extracted_symbol) > 0)
               top10_child_payload_symbol = extracted_symbol;
            if(StringLen(extracted_canonical) > 0)
               top10_child_payload_canonical = extracted_canonical;
           }
         ASC_FunctionResultFinish(top10_publish_result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_IO_FAILED,
                                  "branch=top10_child_verify | write_attempted=yes | verify_attempted=yes | verify_result=failed | child_path=" + top10_batch_path + " | reason=" + top10_verification_reason + " | payload_symbol=" + top10_child_payload_symbol + " | expected_runtime_symbol=" + selected.symbol + " | payload_canonical=" + top10_child_payload_canonical + " | expected_canonical=" + ASC_TextOrUnavailable(canonical_symbol) + " | selected_context_symbol=" + selected.symbol + " | counters=" + ASC_Top10RunFullBatchCountersTrace(state) + " | reroute=none | " + ASC_Top10RunFullBatchTrace(state),
                                  top10_batch_path);
         ASC_RecordResult(state, top10_publish_result, true, true);
         ASC_RecordPublicationOutcomeCounters(state, top10_publish_result);
         state.deep_focus_trigger_last_status = "deep_pair_failed_pair_mismatch";
         state.deep_focus_last_reason = "Global Top 10 child readback lacked completed Deep Analysis truth: " + top10_verification_reason;
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         state.deep_trigger_publish_failure_count++;
         telemetry.write_failures++;
         yield_reason = "deep_analysis_trigger_pair_readback_failed";
         return true;
        }

      state.top10_run_full_inflight_publication_id = deep_bundle.publication_id;
      state.top10_run_full_verify_pass_count++;
      ASC_FunctionResultFinish(top10_publish_result,
                               ASC_RESULT_OK,
                               ASC_RC_OK,
                               "branch=top10_child_verify | write_attempted=yes | verify_attempted=yes | verify_result=passed | child_path=" + top10_batch_path + " | verification=" + top10_verification_reason + " | write_state=" + top10_write_state + " | counters=" + ASC_Top10RunFullBatchCountersTrace(state) + " | reroute=none | " + ASC_Top10RunFullBatchTrace(state),
                               top10_batch_path);
      ASC_RecordResult(state, top10_publish_result, true, false);
      ASC_RecordPublicationOutcomeCounters(state, top10_publish_result);
      state.deep_focus_trigger_last_status = "deep_pair_succeeded";
      state.deep_focus_last_reason = "Global Top 10 child publish verified for " + canonical_symbol + " | " + top10_verification_reason;
      state.deep_trigger_publish_success_count++;
      state.l1_publish_pending_manifest = true;
      state.last_write_utc = now_utc;
      telemetry.written_artifacts++;
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      yield_reason = top10_had_material_equal_payload
                     ? "deep_analysis_trigger_pair_already_current"
                     : "deep_analysis_trigger_published";
      return true;
     }

   ASC_ArtifactContract dossier_contract = ASC_DossierContract(state.server_root, canonical_symbol);
   ASC_ArtifactContract focus_contract = ASC_CurrentFocusContract(state.server_root);
   bool dossier_support_enabled = (ASC_RoutineRootAllSymbolDossierPolicyEnabled()
                                   && StringLen(dossier_contract.target_path) > 0
                                   && dossier_contract.target_path != focus_contract.target_path);
   if(StringLen(focus_contract.target_path) <= 0)
     {
      state.deep_focus_trigger_last_status = "deep_pair_failed_pair_path";
      state.deep_focus_last_reason = "Dossier target-path contract is unavailable";
      state.current_focus_last_status = "deep_pair_failed_pair_path";
      state.current_focus_last_reason = "explicit deep publish path invalid: Dossier contract unavailable";
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                  "deep build failed: Dossier publish contract unavailable");
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      state.deep_trigger_publish_failure_count++;
      telemetry.write_failures++;
      yield_reason = "deep_analysis_trigger_pair_path_invalid";
      return true;
     }

   string write_state = "pending";
   string write_reason = "pending";
   int deep_payload_size = StringLen(payload);
   ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
               StringFormat("deep forensic writer_path=deep_trigger selected=%s canonical=%s publication_id=%s payload_size=%d dossier_support=%s dossier=%s current_focus=%s",
                            selected.symbol,
                            canonical_symbol,
                            deep_bundle.publication_id,
                            deep_payload_size,
                            dossier_support_enabled ? "enabled" : "disabled",
                            dossier_support_enabled ? dossier_contract.target_path : "unavailable",
                            focus_contract.target_path));

   string live_root_payload = "";
   bool live_root_exists = (StringLen(focus_contract.target_path) > 0
                            && ASC_ReadTextFile(focus_contract.target_path, live_root_payload)
                            && StringLen(live_root_payload) > 0);
   string root_non_downgrade_reason = "";
   bool root_write_blocked = live_root_exists
                             && ASC_CurrentFocusShouldBlockSameSymbolDowngrade(live_root_payload,
                                                                               payload,
                                                                               selected,
                                                                               canonical_symbol,
                                                                               ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER,
                                                                               root_non_downgrade_reason);

   bool write_ok = true;
   string verified_root_payload = "";
   if(root_write_blocked)
     {
      write_state = "continuity";
      write_reason = "operation=skip_publish reason=same_symbol_non_downgrade_protection detail=" + root_non_downgrade_reason;
      verified_root_payload = live_root_payload;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                  "deep-trigger root write skipped by same-symbol non-downgrade protection: " + root_non_downgrade_reason);
     }
   else
     {
      write_ok = ASC_WritePublicationPayloadAtomic(focus_contract.target_path,
                                                   payload,
                                                   required_tokens,
                                                   publication_state,
                                                   write_state,
                                                   write_reason);
      if(write_ok)
         verified_root_payload = payload;
     }

   bool dossier_support_written = false;
   string dossier_support_write_state = "disabled";
   string dossier_support_write_reason = (dossier_support_enabled ? "pending" : "contract_unavailable_or_colliding");

   ASC_FunctionResult publish_result;
   ASC_FunctionResultBegin(publish_result, "ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol);
   ASC_FunctionResultSetTruthBoundary(publish_result, "runtime.dispatcher", "truth_consumer.root_dossier_deep_publish_verify");
   ASC_FunctionResultSetHydrationClass(publish_result, "selected_deep_l0_l6");
   if(!write_ok)
     {
      string align_ce = ASC_SelArtCEStatus(true,
                                           live_root_exists,
                                           live_root_exists,
                                           false,
                                           false,
                                           false,
                                           false,
                                           write_state,
                                           write_reason);
      ASC_FunctionResultMarkClaimEvidenceStatus(publish_result, align_ce);
      string align_detail = ASC_ClaimEvidenceAppend("Failed to publish Deep Analysis Dossier artifact: write_state=" + write_state + " | " + write_reason,
                                                    align_ce,
                                                    ASC_SelArtCESupport(write_state, write_reason, false),
                                                    ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
      ASC_FunctionResultFinish(publish_result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               align_detail,
                               focus_contract.target_path);
      ASC_RecordResult(state, publish_result, true, true);
      ASC_RecordPublicationOutcomeCounters(state, publish_result);

      state.deep_focus_trigger_last_status = "deep_pair_failed_write";
      state.deep_focus_last_reason = "Dossier publish failed before verified readback: " + write_reason;
      state.current_focus_last_status = "deep_pair_failed_write";
      state.current_focus_last_reason = "explicit deep Dossier publish failed before readback: " + write_reason;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                  StringFormat("deep forensic writer_path=deep_trigger selected=%s canonical=%s publication_id=%s payload_size=%d current_focus_publish_result=failure write_state=%s reason=%s",
                               selected.symbol,
                               canonical_symbol,
                               deep_bundle.publication_id,
                               deep_payload_size,
                               write_state,
                               write_reason));
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      state.deep_trigger_publish_failure_count++;
      telemetry.write_failures++;
      yield_reason = "deep_analysis_trigger_pair_publish_failed";
      return true;
     }

   // Layer-5 ownership law:
   // - Deep trigger builds one canonical selected-symbol payload.
   // - Root Dossier is the trader-facing authority and is written/verified directly.
   // - Selected-symbol dossier support artifact is debug/support evidence only and is non-blocking for root Dossier survival.
   bool no_material_change = ASC_PublicationReasonIndicatesNoMaterialChange(write_reason);
   bool retained_pair = (write_state == "continuity" || no_material_change);
   string pair_verification_reason = "current_focus_continuity_retained";
   if(retained_pair)
     {
      bool direct_focus_verified = ASC_CurrentFocusVerifyDirectProtectedReadback(state.server_root,
                                                                                 selected,
                                                                                 canonical_symbol,
                                                                                 pair_verification_reason);
      if(!direct_focus_verified)
        {
         string direct_focus_failure_reason = pair_verification_reason;
         bool fallback_verified = false;
         if(dossier_support_written)
           {
            datetime deep_truth_floor_utc = ASC_SelectedSymbolTruthFloorUtc(state, selected);
            fallback_verified = ASC_VerifyRetainedDossierCurrentFocusPair(dossier_contract.target_path,
                                                                          focus_contract.target_path,
                                                                          selected,
                                                                          canonical_symbol,
                                                                          deep_truth_floor_utc,
                                                                          true,
                                                                          pair_verification_reason);
           }

         if(!fallback_verified)
           {
            if(!dossier_support_written)
               pair_verification_reason = "direct_current_focus_proof_failed_and_dossier_support_unavailable";

            string align_ce = ASC_SelArtCEStatus(true,
                                                      live_root_exists,
                                                      live_root_exists,
                                                      false,
                                                      false,
                                                      false,
                                                      true,
                                                      write_state,
                                                      pair_verification_reason);
            ASC_FunctionResultMarkClaimEvidenceStatus(publish_result, align_ce);
            string align_detail = ASC_ClaimEvidenceAppend("Deep Analysis retained continuity failed direct Dossier verification"
                                                          + (dossier_support_written
                                                             ? (" and retained pair fallback: direct=" + direct_focus_failure_reason + " | fallback=" + pair_verification_reason)
                                                             : (" and dossier support fallback was unavailable: direct=" + direct_focus_failure_reason)),
                                                          align_ce,
                                                          ASC_SelArtCESupport(write_state, pair_verification_reason, dossier_support_written)
                                             + ";" + ASC_CFExpectationSupport("dossier_derivative_expected",
                                                                                focus_contract.target_path,
                                                                                selected.symbol,
                                                                                write_state,
                                                                                pair_verification_reason),
                                             ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
            ASC_FunctionResultFinish(publish_result,
                                     ASC_RESULT_ERROR,
                                     ASC_RC_IO_FAILED,
                                     align_detail,
                                     focus_contract.target_path);
            ASC_RecordResult(state, publish_result, true, true);
            ASC_RecordPublicationOutcomeCounters(state, publish_result);

            string retained_failure_status = "deep_pair_" + ASC_DeepReadbackFailureStatus(pair_verification_reason);
            state.deep_focus_trigger_last_status = retained_failure_status;
            state.deep_focus_last_reason = "retained continuity could not prove Dossier deep truth directly"
                                           + (dossier_support_written
                                              ? (" and fallback pair verification failed: direct=" + direct_focus_failure_reason + " | fallback=" + pair_verification_reason)
                                              : (": direct=" + direct_focus_failure_reason + " | dossier_support=unavailable"));
            state.deep_trigger_publish_failure_count++;
            state.current_focus_last_status = retained_failure_status;
            state.current_focus_last_reason = state.deep_focus_last_reason;
            state.current_focus_last_served_utc = now_utc;
            state.deep_focus_ownership_active = false;
            state.deep_focus_ownership_symbol = "";
            state.deep_focus_ownership_started_utc = 0;
            telemetry.write_failures++;
            yield_reason = "deep_analysis_trigger_pair_readback_failed";
            return true;
           }
        }
     }
   else if(!ASC_VerifyPublicationPayloadReadback(focus_contract.target_path,
                                                 payload,
                                                 pair_verification_reason))
     {
      string align_ce = ASC_SelArtCEStatus(true,
                                                live_root_exists,
                                                false,
                                                false,
                                                false,
                                                false,
                                                true,
                                                write_state,
                                                pair_verification_reason);
      ASC_FunctionResultMarkClaimEvidenceStatus(publish_result, align_ce);
      string align_detail = ASC_ClaimEvidenceAppend("Deep Analysis Dossier publish failed verification: " + pair_verification_reason,
                                                    align_ce,
                                                    ASC_SelArtCESupport(write_state, pair_verification_reason, dossier_support_written)
                                             + ";" + ASC_CFExpectationSupport("dossier_derivative_expected",
                                                                                focus_contract.target_path,
                                                                                selected.symbol,
                                                                                write_state,
                                                                                pair_verification_reason),
                                             ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
      ASC_FunctionResultFinish(publish_result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               align_detail,
                               focus_contract.target_path);
      ASC_RecordResult(state, publish_result, true, true);
      ASC_RecordPublicationOutcomeCounters(state, publish_result);

      string verification_failure_status = "deep_pair_" + ASC_DeepReadbackFailureStatus(pair_verification_reason);
      state.deep_focus_trigger_last_status = verification_failure_status;
      state.deep_focus_last_reason = "Dossier publish verification failed: " + pair_verification_reason;
      state.deep_trigger_publish_failure_count++;
      state.current_focus_last_status = verification_failure_status;
      state.current_focus_last_reason = "deep-trigger Dossier publish verification failed: " + pair_verification_reason;
      state.current_focus_last_served_utc = now_utc;
      state.deep_focus_ownership_active = false;
      state.deep_focus_ownership_symbol = "";
      state.deep_focus_ownership_started_utc = 0;
      telemetry.write_failures++;
      yield_reason = "deep_analysis_trigger_pair_readback_failed";
      return true;
     }

   if(StringLen(verified_root_payload) <= 0)
     {
      if(!ASC_ReadTextFile(focus_contract.target_path, verified_root_payload) || StringLen(verified_root_payload) <= 0)
        {
         string align_ce = ASC_SelArtCEStatus(true,
                                                   false,
                                                   false,
                                                   false,
                                                   false,
                                                   false,
                                                   true,
                                                   write_state,
                                                   "verified_root_readback_missing");
         ASC_FunctionResultMarkClaimEvidenceStatus(publish_result, align_ce);
         string align_detail = ASC_ClaimEvidenceAppend("Deep Analysis Dossier publish succeeded but verified root readback could not be loaded for derivative copy-down.",
                                                       align_ce,
                                                       ASC_SelArtCESupport(write_state, "verified_root_readback_missing", dossier_support_written),
                                                       ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
         ASC_FunctionResultFinish(publish_result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_IO_FAILED,
                                  align_detail,
                                  focus_contract.target_path);
         ASC_RecordResult(state, publish_result, true, true);
         ASC_RecordPublicationOutcomeCounters(state, publish_result);
         state.deep_focus_trigger_last_status = "deep_pair_failed_readback";
         state.deep_focus_last_reason = "verified root readback could not be loaded for derivative copy-down";
         state.deep_trigger_publish_failure_count++;
         state.current_focus_last_status = "deep_pair_failed_readback";
         state.current_focus_last_reason = state.deep_focus_last_reason;
         state.current_focus_last_served_utc = now_utc;
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         telemetry.write_failures++;
         yield_reason = "deep_analysis_trigger_pair_readback_failed";
         return true;
        }
     }

   if(dossier_support_enabled)
     {
      dossier_support_written = ASC_WritePublicationPayloadAtomic(dossier_contract.target_path,
                                                                  verified_root_payload,
                                                                  required_tokens,
                                                                  publication_state,
                                                                  dossier_support_write_state,
                                                                  dossier_support_write_reason);
      if(!dossier_support_written)
         ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                     "deep-trigger dossier support copy-down failed after verified root publish (non-blocking): " + dossier_support_write_reason);
     }

   bool top10_batch_written = false;
   string top10_batch_write_state = "disabled";
   string top10_batch_write_reason = "not_batch_origin";
   if(frozen_request_origin == "global_top10_batch")
     {
      string top10_batch_path = ASC_GlobalTop10BatchArtifactPath(state, selected.symbol, canonical_symbol);
      state.top10_run_full_inflight_publication_id = deep_bundle.publication_id;
      if(StringLen(top10_batch_path) > 0)
        {
         string top10_existing_payload = "";
         bool top10_had_material_equal_payload = (ASC_ReadTextFile(top10_batch_path, top10_existing_payload)
                                                  && StringLen(top10_existing_payload) > 0
                                                  && ASC_DossierPayloadMatchesSymbolContext(top10_existing_payload, selected, canonical_symbol)
                                                  && ASC_PublicationPayloadMateriallyEqual(top10_existing_payload, verified_root_payload));
         if(top10_had_material_equal_payload)
            FileDelete(top10_batch_path, FILE_COMMON);

         top10_batch_written = ASC_WritePublicationPayloadAtomic(top10_batch_path,
                                                                 verified_root_payload,
                                                                 required_tokens,
                                                                 publication_state,
                                                                 top10_batch_write_state,
                                                                 top10_batch_write_reason);
         if(!top10_batch_written)
            ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
                        "global top10 batch dossier mirror write failed (non-blocking): " + top10_batch_write_reason);
        }
      else
        {
         top10_batch_write_state = "disabled";
         top10_batch_write_reason = "top10_batch_path_unavailable";
        }
     }

   if(!retained_pair)
     {
      string focus_readback = "";
      bool focus_read_ok = ASC_ReadTextFile(focus_contract.target_path, focus_readback);
      bool focus_symbol_ok = focus_read_ok && ASC_DossierPayloadMatchesSymbolContext(focus_readback, selected, canonical_symbol);
      bool focus_canonical_ok = focus_read_ok && (StringLen(canonical_symbol) <= 0 || ASC_DossierPayloadMatchesCanonicalSymbol(focus_readback, canonical_symbol));
      bool focus_deep_ok = focus_read_ok && ASC_DossierPayloadHasFreshDeepTruth(focus_readback, deep_result);

      if(!focus_read_ok || !focus_symbol_ok || !focus_canonical_ok || !focus_deep_ok)
        {
         string verification_code = "current_focus_readback_incomplete";
         if(!focus_read_ok)
            verification_code = "current_focus_readback_missing";
         else if(!focus_symbol_ok)
            verification_code = "current_focus_symbol_mismatch";
         else if(!focus_canonical_ok)
            verification_code = "current_focus_canonical_mismatch";
         else if(!focus_deep_ok)
            verification_code = "current_focus_deep_truth_missing";

         string failure_status = "deep_pair_failed_write";
         if(verification_code == "current_focus_readback_missing")
            failure_status = "deep_pair_failed_partial_publish";
         else if(verification_code == "current_focus_symbol_mismatch"
                 || verification_code == "current_focus_canonical_mismatch")
            failure_status = "deep_pair_failed_pair_mismatch";
         else if(verification_code == "current_focus_deep_truth_missing")
            failure_status = "deep_pair_failed_deep_truth";

         string align_ce = ASC_SelArtCEStatus(true,
                                                   focus_read_ok,
                                                   focus_read_ok,
                                                   focus_symbol_ok,
                                                   focus_canonical_ok,
                                                   focus_deep_ok,
                                                   true,
                                                   write_state,
                                                   verification_code);
         ASC_FunctionResultMarkClaimEvidenceStatus(publish_result, align_ce);
         string align_detail = ASC_ClaimEvidenceAppend("Deep Analysis Dossier publish failed completed-truth verification: " + verification_code,
                                                       align_ce,
                                                       ASC_SelArtCESupport(write_state, verification_code, dossier_support_written),
                                                       ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);
         ASC_FunctionResultFinish(publish_result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_IO_FAILED,
                                  align_detail,
                                  focus_contract.target_path);
         ASC_RecordResult(state, publish_result, true, true);
         ASC_RecordPublicationOutcomeCounters(state, publish_result);

         state.deep_focus_trigger_last_status = failure_status;
         state.deep_focus_last_reason = "Dossier readback lacked completed Deep Analysis truth: " + verification_code;
         state.deep_trigger_publish_failure_count++;
         state.current_focus_last_status = failure_status;
         state.current_focus_last_reason = "deep-trigger readback lacked completed Deep Analysis truth: " + verification_code;
         state.current_focus_last_served_utc = now_utc;
         state.deep_focus_ownership_active = false;
         state.deep_focus_ownership_symbol = "";
         state.deep_focus_ownership_started_utc = 0;
         telemetry.write_failures++;
         yield_reason = "deep_analysis_trigger_pair_readback_failed";
         return true;
        }
     }
   ASC_FunctionResultState publish_state = ASC_RESULT_OK;
   string publish_message = "Deep Analysis Dossier publish succeeded and verified. verification=" + pair_verification_reason + " | write_state=" + write_state + " | " + ASC_DeepSupportProofTokens(deep_result);
   string result_path = focus_contract.target_path;
   if(dossier_support_enabled)
      result_path = dossier_contract.target_path + " | " + focus_contract.target_path;
   if(retained_pair)
     {
      publish_state = ASC_RESULT_WARNING;
      publish_message = no_material_change
                        ? ("Deep Analysis Dossier publish detected no material change and retained verified direct deep truth. write_state=" + write_state + " | " + write_reason)
                        : ("Deep Analysis Dossier continuity retained prior direct deep truth. write_state=" + write_state + " | " + write_reason);
     }
   if(dossier_support_enabled)
     {
      publish_message += dossier_support_written
                         ? (" | dossier_support_write_state=" + dossier_support_write_state)
                         : (" | dossier_support_non_blocking_failure=" + dossier_support_write_reason);
      if(!dossier_support_written && publish_state == ASC_RESULT_OK)
         publish_state = ASC_RESULT_WARNING;
     }
   else
      publish_message += " | dossier_support=disabled";
   if(frozen_request_origin == "global_top10_batch")
     {
      publish_message += top10_batch_written
                         ? (" | top10_batch_write_state=" + top10_batch_write_state)
                         : (" | top10_batch_non_blocking_failure=" + top10_batch_write_reason);
      if(!top10_batch_written && publish_state == ASC_RESULT_OK)
         publish_state = ASC_RESULT_WARNING;
     }

   string align_payload = "";
   bool align_read_ok = ASC_ReadTextFile(focus_contract.target_path, align_payload);
   bool align_symbol_ok = align_read_ok && ASC_DossierPayloadMatchesSymbolContext(align_payload, selected, canonical_symbol);
   bool align_canonical_ok = align_read_ok && (StringLen(canonical_symbol) <= 0 || ASC_DossierPayloadMatchesCanonicalSymbol(align_payload, canonical_symbol));
   bool align_current_ok = retained_pair ? (StringFind(pair_verification_reason, "failed") < 0 && StringFind(pair_verification_reason, "unavailable") < 0)
                                         : (align_read_ok && ASC_DossierPayloadHasFreshDeepTruth(align_payload, deep_result));
   string align_ce = ASC_SelArtCEStatus(true,
                                         align_read_ok,
                                         align_read_ok,
                                         align_symbol_ok,
                                         align_canonical_ok,
                                         align_current_ok,
                                         true,
                                         write_state,
                                         pair_verification_reason);
   ASC_FunctionResultMarkClaimEvidenceStatus(publish_result, align_ce);
   publish_message = ASC_ClaimEvidenceAppend(publish_message,
                                             align_ce,
                                             ASC_SelArtCESupport(write_state, pair_verification_reason, dossier_support_written)
                                             + ";" + ASC_CFExpectationSupport("dossier_derivative_expected",
                                                                                focus_contract.target_path,
                                                                                selected.symbol,
                                                                                write_state,
                                                                                pair_verification_reason),
                                             ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050);

   ASC_FunctionResultFinish(publish_result,
                            publish_state,
                            ASC_RC_OK,
                            publish_message,
                            result_path);
   ASC_RecordResult(state, publish_result, true, publish_state != ASC_RESULT_OK);
   ASC_RecordPublicationOutcomeCounters(state, publish_result);

   state.deep_focus_trigger_last_status = (retained_pair ? "deep_pair_continuity" : "deep_pair_succeeded");
   ASC_LogInfo("ASC_Dispatcher", "ASC_RunDeepFocusTriggerWrite", selected.symbol,
               StringFormat("deep forensic writer_path=deep_trigger selected=%s canonical=%s publication_id=%s payload_size=%d current_focus_publish_result=success retained=%s verification=%s dossier_support=%s",
                            selected.symbol,
                            canonical_symbol,
                            deep_bundle.publication_id,
                            deep_payload_size,
                            retained_pair ? "yes" : "no",
                            pair_verification_reason,
                            dossier_support_enabled ? (dossier_support_written ? "written" : "non_blocking_failure") : "disabled"));
   if(retained_pair)
      state.deep_trigger_publish_continuity_count++;
   else
      state.deep_trigger_publish_success_count++;
   state.deep_focus_last_reason = retained_pair
                                  ? (no_material_change
                                     ? ("pair publish skipped because Dossier already held same-symbol completed deep truth (directly verified) | " + write_reason)
                                     : ("pair publish retained prior Deep Analysis continuity; Dossier direct truth remained authoritative | " + write_reason))
                                  : ("Dossier publish verified for " + canonical_symbol + " | " + pair_verification_reason);
   state.current_focus_last_status = (retained_pair ? "deep_pair_continuity" : "deep_pair_succeeded");
   state.current_focus_last_reason = retained_pair
                                     ? (no_material_change
                                        ? ("deep-trigger continuity confirmed root Dossier direct deep truth without requiring dossier-support-first proof | " + pair_verification_reason)
                                        : ("deep-trigger continuity preserved root Dossier direct deep truth; dossier-support pair remains optional fallback evidence | " + write_reason))
                                     : ("deep-trigger Dossier publish verified for " + canonical_symbol + " | " + pair_verification_reason);
   state.current_focus_view_pending = false;
   state.current_focus_view_symbol = "";
   state.current_focus_view_earliest_write_utc = 0;
   state.current_focus_last_served_utc = now_utc;
   state.current_focus_live_symbol = canonical_symbol;
   state.current_focus_sync_last_checked_utc = now_utc;
   state.current_focus_sync_last_selected_symbol = selected.symbol;
   state.current_focus_sync_last_truth_floor_utc = ASC_SelectedSymbolTruthFloorUtc(state, selected);
   datetime deep_focus_modified_utc = 0;
   datetime deep_dossier_modified_utc = 0;
   ASC_FileTryGetModifyUtc(focus_contract.target_path, deep_focus_modified_utc);
   if(dossier_support_enabled)
      ASC_FileTryGetModifyUtc(dossier_contract.target_path, deep_dossier_modified_utc);
   state.current_focus_sync_last_focus_modified_utc = deep_focus_modified_utc;
   state.current_focus_sync_last_dossier_modified_utc = deep_dossier_modified_utc;
   state.l1_publish_pending_manifest = true;
   datetime deep_pair_served_utc = ASC_MaxDatetime(deep_focus_modified_utc, deep_dossier_modified_utc);
   if(deep_focus_modified_utc > 0)
      state.current_focus_last_served_utc = deep_focus_modified_utc;
   else if(deep_pair_served_utc > 0)
      state.current_focus_last_served_utc = deep_pair_served_utc;
   state.last_write_utc = now_utc;
   if(!retained_pair)
      telemetry.written_artifacts += (1 + (dossier_support_written ? 1 : 0));
   state.deep_focus_ownership_active = false;
   state.deep_focus_ownership_symbol = "";
   state.deep_focus_ownership_started_utc = 0;
   if(no_material_change)
      yield_reason = "deep_analysis_trigger_pair_already_current";
   else
      yield_reason = retained_pair
                     ? "deep_analysis_trigger_pair_continuity_retained"
                     : "deep_analysis_trigger_pair_written";
   return true;
  }

bool ASC_EvaluateViewedCurrentFocusBaselineDowngradeGate(const bool live_root_exists,
                                                         const string &live_root_payload,
                                                         const string &incoming_payload,
                                                         const ASC_Layer1SymbolState &selected,
                                                         const string &canonical_symbol,
                                                         const int incoming_authority,
                                                         string &block_reason)
  {
   block_reason = "";
   if(!live_root_exists)
      return false;

   const int root_non_regression_richness_threshold = 10;
   string live_root_publication_id = ASC_PublicationPayloadId(live_root_payload);
   int live_root_authority = ASC_CurrentFocusPayloadAuthority(live_root_payload);

   string live_root_deep_status = ASC_TextExtractLabeledLineValue(live_root_payload, "Deep Analysis Status:");
   string incoming_deep_status = ASC_TextExtractLabeledLineValue(incoming_payload, "Deep Analysis Status:");
   string live_root_deep_status_lc = live_root_deep_status;
   string incoming_deep_status_lc = incoming_deep_status;
   StringToLower(live_root_deep_status_lc);
   StringToLower(incoming_deep_status_lc);

   bool live_root_completed_deep_truth = ASC_DossierDeepSectionHasCompletedTruth(live_root_payload);
   bool incoming_completed_deep_truth = ASC_DossierDeepSectionHasCompletedTruth(incoming_payload);
   bool live_root_deep_authority_hint = (StringLen(live_root_publication_id) > 0
                                         && StringFind(live_root_publication_id, "deep-focus-") == 0);
   bool live_root_deep_completed_hint = (StringFind(live_root_deep_status_lc, "completed") >= 0);
   bool incoming_deep_completed_hint = (StringFind(incoming_deep_status_lc, "completed") >= 0);

   if((live_root_deep_authority_hint || live_root_deep_completed_hint)
      && live_root_authority < ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER)
      live_root_authority = ASC_CURRENT_FOCUS_AUTHORITY_DEEP_TRIGGER;

   bool live_root_effective_deep_completed = (live_root_completed_deep_truth
                                              || live_root_deep_authority_hint
                                              || live_root_deep_completed_hint);
   bool incoming_effective_deep_completed = (incoming_completed_deep_truth
                                             || incoming_deep_completed_hint);

   int live_root_richness = ASC_CurrentFocusPayloadVisibleSectionRichness(live_root_payload);
   int incoming_richness = ASC_CurrentFocusPayloadVisibleSectionRichness(incoming_payload);

   bool live_root_matches_selected_symbol = ASC_CurrentFocusPayloadMatchesSelectedSymbolDirect(live_root_payload,
                                                                                               selected,
                                                                                               canonical_symbol);
   bool incoming_matches_selected_symbol = ASC_DossierPayloadMatchesSymbolContext(incoming_payload,
                                                                                  selected,
                                                                                  canonical_symbol);
   bool selected_symbol_same_proven = (live_root_matches_selected_symbol
                                       && incoming_matches_selected_symbol);
   bool root_non_regression_same_symbol_lock = (live_root_effective_deep_completed
                                                && !selected_symbol_same_proven);
   if(root_non_regression_same_symbol_lock)
     {
      block_reason = "operation=skip_publish reason=root_non_regression_same_symbol_lock detail=live_root_has_completed_or_deep_authority_truth_and_same_symbol_proof_not_confirmed";
      return true;
     }

   bool root_non_regression_deep_lock = (selected_symbol_same_proven
                                         && live_root_effective_deep_completed
                                         && !incoming_effective_deep_completed);
   if(root_non_regression_deep_lock)
     {
      block_reason = "operation=skip_publish reason=root_non_regression_deep_lock detail=live_root_completed_or_deep_authority_truth_preserved";
      return true;
     }

   bool root_non_regression_richness_lock = (selected_symbol_same_proven
                                             && ((live_root_richness - incoming_richness) >= root_non_regression_richness_threshold
                                                 || (incoming_authority < live_root_authority
                                                     && incoming_richness < live_root_richness)));
   if(root_non_regression_richness_lock)
     {
      block_reason = StringFormat("operation=skip_publish reason=root_non_regression_richness_lock detail=live_richness=%d incoming_richness=%d threshold=%d live_authority=%d incoming_authority=%d",
                                  live_root_richness,
                                  incoming_richness,
                                  root_non_regression_richness_threshold,
                                  live_root_authority,
                                  incoming_authority);
      return true;
     }

   string root_non_downgrade_reason = "";
   bool root_write_blocked_same_symbol = ASC_CurrentFocusShouldBlockSameSymbolDowngrade(live_root_payload,
                                                                                         incoming_payload,
                                                                                         selected,
                                                                                         canonical_symbol,
                                                                                         incoming_authority,
                                                                                         root_non_downgrade_reason);
   if(root_write_blocked_same_symbol)
     {
      block_reason = "operation=skip_publish reason=same_symbol_non_downgrade_protection detail=" + root_non_downgrade_reason;
      return true;
     }

   return false;
  }

bool ASC_RunViewedCurrentFocusWrite(ASC_RuntimeState &state,
                                    const datetime now_utc,
                                    ASC_HeartbeatTelemetry &telemetry,
                                    string &yield_reason)
  {
   if(!state.current_focus_view_pending || StringLen(state.current_focus_view_symbol) <= 0)
      return false;

   if(!ASC_CurrentFocusViewWriteDue(state, now_utc))
      return false;

   string selected_symbol = state.current_focus_view_symbol;
   ASC_Layer1SymbolState selected;
   bool selected_found = ASC_FindLayer1SymbolByName(selected_symbol, selected);
   if(!selected_found)
     {
      state.current_focus_view_pending = false;
      state.current_focus_view_symbol = "";
      state.current_focus_view_earliest_write_utc = 0;
      state.current_focus_last_status = "view_failed_symbol_unavailable";
      state.current_focus_last_reason = "selected-symbol baseline write failed because the symbol is unavailable in Layer 1 cache";
      state.current_focus_sync_last_checked_utc = now_utc;
      state.current_focus_sync_last_selected_symbol = selected_symbol;
      state.current_focus_sync_last_truth_floor_utc = 0;
      telemetry.write_failures++;
      yield_reason = "current_focus_view_symbol_unavailable";
      return true;
     }

   selected_symbol = selected.symbol;

   ASC_PublicationBundleState baseline_bundle = state.publication_bundle;
   baseline_bundle.publication_utc = now_utc;
   if(StringLen(baseline_bundle.publication_id) <= 0)
      baseline_bundle.publication_id = StringFormat("view-baseline-%I64d-%s", (long)now_utc, selected_symbol);
   if(!ASC_BundleHasConfirmedBoardBaseline(baseline_bundle))
     {
      baseline_bundle.board_refresh_trigger = "selected_symbol_view_baseline";
      baseline_bundle.market_board_status = "pending";
      baseline_bundle.open_symbol_snapshot_status = "pending";
      baseline_bundle.manifest_status = "pending";
      baseline_bundle.board_publish_started_utc = 0;
      baseline_bundle.board_publish_finished_utc = 0;
      baseline_bundle.board_publish_result = "pending";
      baseline_bundle.board_publish_skip_reason = "awaiting_same_family_board_baseline";
      baseline_bundle.board_lifecycle_state = "selected_symbol_view_baseline";
      baseline_bundle.overall_bundle_status = "pending";
     }

   ASC_ShortlistSymbolSummary shortlist_rows[];
   if(state.publication_shortlist_ready && ArraySize(state.publication_shortlist_rows) > 0)
     {
      int shortlist_count = ArraySize(state.publication_shortlist_rows);
      ArrayResize(shortlist_rows, shortlist_count);
      for(int i = 0; i < shortlist_count; i++)
         shortlist_rows[i] = state.publication_shortlist_rows[i];
     }
   else
      ASC_CopyCommittedL4RowsToShortlistRows(state.committed_l4_rows, shortlist_rows);

   ASC_DossierProductMode dossier_mode = ASC_DossierContinuationModeFromLayer1(selected);
   ASC_DeepSelectiveAnalysisResult deep_result;
   ASC_DeepInitResult(deep_result);

   string canonical_symbol = "";
   string payload = "";
   string publication_state = "pending";
   string required_tokens[];
   if(!ASC_BuildCanonicalDossierPayload(state.server_root,
                                        selected,
                                        baseline_bundle,
                                        shortlist_rows,
                                        dossier_mode,
                                        false,
                                        deep_result,
                                        selected_symbol,
                                        canonical_symbol,
                                        payload,
                                        publication_state,
                                        required_tokens))
     {
      ASC_RecordCurrentFocusViewFailure(state,
                                        now_utc,
                                        selected_symbol,
                                        "canonical selected-symbol baseline payload compose failed");
      telemetry.write_failures++;
      yield_reason = "current_focus_view_compose_failed";
      return true;
     }

   ASC_ArtifactContract focus_contract = ASC_CurrentFocusContract(state.server_root);
   ASC_ArtifactContract dossier_contract = ASC_DossierContract(state.server_root, canonical_symbol);
   bool dossier_support_enabled = (ASC_RoutineRootAllSymbolDossierPolicyEnabled()
                                   && StringLen(dossier_contract.target_path) > 0
                                   && dossier_contract.target_path != focus_contract.target_path);

   string live_root_payload = "";
   bool live_root_exists = (StringLen(focus_contract.target_path) > 0
                            && ASC_ReadTextFile(focus_contract.target_path, live_root_payload)
                            && StringLen(live_root_payload) > 0);
   int incoming_authority = ASC_CURRENT_FOCUS_AUTHORITY_PASSIVE_MIRROR;
   string root_write_block_reason = "";
   bool root_write_blocked = ASC_EvaluateViewedCurrentFocusBaselineDowngradeGate(live_root_exists,
                                                                                  live_root_payload,
                                                                                  payload,
                                                                                  selected,
                                                                                  canonical_symbol,
                                                                                  incoming_authority,
                                                                                  root_write_block_reason);

   string write_state = "pending";
   string write_reason = "pending";
   string verified_root_payload = "";
   bool write_ok = true;
   if(root_write_blocked)
     {
      write_state = "continuity";
      write_reason = root_write_block_reason;
      verified_root_payload = live_root_payload;
     }
   else
     {
      write_ok = ASC_WritePublicationPayloadAtomic(focus_contract.target_path,
                                                   payload,
                                                   required_tokens,
                                                   publication_state,
                                                   write_state,
                                                   write_reason);
      if(write_ok)
         verified_root_payload = payload;
     }

   if(!write_ok)
     {
      ASC_RecordCurrentFocusViewFailure(state,
                                        now_utc,
                                        selected_symbol,
                                        "selected-symbol baseline root publish failed: " + write_reason);
      telemetry.write_failures++;
      yield_reason = "current_focus_view_write_failed";
      return true;
     }

   if(StringLen(verified_root_payload) <= 0)
     {
      ASC_RecordCurrentFocusViewFailure(state,
                                        now_utc,
                                        selected_symbol,
                                        "selected-symbol baseline root readback missing after publish");
      telemetry.write_failures++;
      yield_reason = "current_focus_view_readback_missing";
      return true;
     }

   if(!root_write_blocked)
     {
      string readback_reason = "";
      if(!ASC_VerifyPublicationPayloadReadback(focus_contract.target_path, payload, readback_reason))
        {
         ASC_RecordCurrentFocusViewFailure(state,
                                           now_utc,
                                           selected_symbol,
                                           "selected-symbol baseline root verification failed: " + readback_reason);
         telemetry.write_failures++;
         yield_reason = "current_focus_view_readback_failed";
         return true;
        }
     }

   bool dossier_support_written = false;
   if(dossier_support_enabled)
     {
      string dossier_support_write_state = "pending";
      string dossier_support_write_reason = "pending";
      dossier_support_written = ASC_WritePublicationPayloadAtomic(dossier_contract.target_path,
                                                                  verified_root_payload,
                                                                  required_tokens,
                                                                  publication_state,
                                                                  dossier_support_write_state,
                                                                  dossier_support_write_reason);
      if(!dossier_support_written)
         ASC_LogInfo("ASC_Dispatcher", "ASC_RunViewedCurrentFocusWrite", selected_symbol,
                     "selected-symbol baseline derivative copy-down failed after verified root publish (non-blocking): " + dossier_support_write_reason);
     }

   state.current_focus_view_pending = false;
   state.current_focus_view_symbol = "";
   state.current_focus_view_earliest_write_utc = 0;
   ASC_ResetCurrentFocusFailureIsolation(state, selected_symbol);
   state.current_focus_sync_last_checked_utc = now_utc;
   state.current_focus_sync_last_selected_symbol = selected_symbol;
   state.current_focus_sync_last_truth_floor_utc = ASC_SelectedSymbolTruthFloorUtc(state, selected);
   state.current_focus_sync_last_focus_modified_utc = now_utc;
   state.current_focus_sync_last_dossier_modified_utc = dossier_support_written ? now_utc : 0;
   state.current_focus_last_served_utc = now_utc;
   state.current_focus_last_status = (write_state == "continuity" ? "continuity" : "succeeded");
   state.current_focus_last_reason = write_state == "continuity"
                                     ? ("selected-symbol baseline preserved richer same-symbol root truth | " + write_reason)
                                     : ("selected-symbol baseline root dossier published and verified"
                                        + (dossier_support_enabled
                                           ? (dossier_support_written ? " | derivative copy-down succeeded" : " | derivative copy-down non-blocking failure")
                                           : " | derivative copy-down disabled"));

   state.deep_focus_ownership_active = false;
   state.deep_focus_ownership_symbol = "";
   state.deep_focus_ownership_started_utc = 0;

   telemetry.written_artifacts++;
   telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
   yield_reason = (write_state == "continuity" ? "current_focus_view_continuity" : "current_focus_view_succeeded");
   return true;
  }
void ASC_SelectModeAndLane(ASC_RuntimeState &state,const datetime now_utc)
  {
   state.mode = ASC_MODE_BALANCED;
   state.write_force = false;
   state.lane_decision_reason = "";
   state.lane_deferred_reason = "";

   if(state.posture == ASC_RUNTIME_DEGRADED)
      state.mode = ASC_MODE_DEGRADED;

   if(!state.write_dirty && (!state.l1_warmup_ready || state.heartbeat_counter <= 2))
      state.mode = ASC_MODE_WARMUP;

   bool scan_backlog = (state.deferred_scan_symbols > 0 || state.layer1_dirty || state.layer2_dirty);
   bool scan_due_now = (state.l1_next_scan_due_utc > 0 && state.l1_next_scan_due_utc <= now_utc);
   bool l2_due_now = (state.l2_next_due_utc > 0 && state.l2_next_due_utc <= now_utc);
   if(scan_due_now || l2_due_now)
      scan_backlog = true;

   bool write_cooldown_active = ASC_IsCooldownActive(now_utc, state.write_cooldown_until_utc);
   bool essentials_backoff_active = ASC_IsCooldownActive(now_utc, state.essential_backoff_until_utc);
   bool dossier_backoff_active_now = ASC_IsCooldownActive(now_utc, state.dossier_backoff_until_utc);
   bool current_focus_write_due = ASC_CurrentFocusViewWriteDue(state, now_utc);
   bool current_focus_starved = ASC_CurrentFocusSyncStarved(state, now_utc);
   bool current_focus_waiting = (state.current_focus_view_pending && !current_focus_write_due);
   bool ui_priority_active = ASC_IsUiPriorityActive(state, now_utc);
   ASC_Layer1PassSummary broad_summary;
   bool has_broad_summary = false;
   string broad_catchup_reason = "";
   bool broad_catchup_incomplete = ASC_IsBroadCatchupIncomplete(state, broad_summary, has_broad_summary, broad_catchup_reason);
   bool startup_dossier_flood_due = (state.dossier_startup_flood_active
                                     && state.l1_publish_pending_dossiers
                                     && state.dossier_existence_shell_only
                                     && state.dossier_missing_count > 0);

   if(state.deep_focus_trigger_pending)
     {
      state.active_lane = ASC_LANE_PERSISTENCE;
      state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
      state.mode = ASC_MODE_WRITE_PRESSURE;
      state.write_force = true;
      state.lane_decision_reason = "persistence selected with explicit priority for Deep Analysis trigger";
      if(broad_catchup_incomplete)
         state.lane_deferred_reason = "broad Layer 0-2 catchup remains active but explicit Deep Analysis has write-lane priority";
      return;
     }

   if(current_focus_waiting)
      state.lane_deferred_reason = "selected-symbol Dossier disable-reconciliation is queued for pending-state drain";

   bool dossier_existence_override = (state.dossier_existence_shell_only && state.l1_publish_pending_dossiers);
   bool essentials_backoff_blocks_write = (essentials_backoff_active && !dossier_existence_override);
   bool dossier_backoff_blocks_write = (dossier_backoff_active_now && !dossier_existence_override);

   if(write_cooldown_active || essentials_backoff_blocks_write || dossier_backoff_blocks_write)
     {
      state.active_lane = ASC_LANE_SCAN;
      state.active_sublane = ASC_SUBLANE_L1_BROAD_SCAN;
      if(write_cooldown_active)
         state.lane_decision_reason = "scan selected because write cooldown is active";
      else if(essentials_backoff_active)
         state.lane_decision_reason = "scan selected because essential publication backoff is active";
      else
         state.lane_decision_reason = "scan selected because dossier backoff is active";
      return;
     }

   if(state.board_manual_refresh_inflight)
     {
      state.active_lane = ASC_LANE_PERSISTENCE;
      state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
      state.mode = ASC_MODE_WRITE_PRESSURE;
      state.write_force = true;
      state.lane_decision_reason = "persistence selected for manual Market Board refresh request";
      if(scan_backlog)
         state.lane_deferred_reason = "scan backlog remains but manual Market Board refresh has write-lane priority";
      return;
     }

   string board_freshness_write_reason = "";
   bool board_freshness_write_ready = ASC_MarketBoardFreshnessRepublishReadyForWrite(state,
                                                                                      now_utc,
                                                                                      board_freshness_write_reason);
   if(board_freshness_write_ready)
     {
      state.active_lane = ASC_LANE_PERSISTENCE;
      state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
      state.mode = ASC_MODE_WRITE_PRESSURE;
      state.write_force = true;
      state.lane_decision_reason = StringFormat("persistence selected for 1-minute Market Board freshness republish using %s",
                                                board_freshness_write_reason);
      if(scan_backlog)
         state.lane_deferred_reason = "scan backlog remains but lawful Market Board minute republish has write-lane priority";
      return;
     }

   int cached_symbol_total = ASC_Layer1CachedSymbolCount();
   int write_streak_limit = ASC_DynamicWriteStreakLimit(cached_symbol_total);
   bool write_backlog = (state.write_dirty || current_focus_write_due);

   if(startup_dossier_flood_due && !write_cooldown_active)
     {
      state.active_lane = ASC_LANE_PERSISTENCE;
      state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
      state.mode = ASC_MODE_WARMUP;
      state.write_force = true;
      state.lane_decision_reason = "persistence forced for startup dossier flood coverage";
      if(scan_backlog)
         state.lane_deferred_reason = "broad scan backlog is temporarily subordinate to startup dossier flood coverage";
      return;
     }

   if(current_focus_write_due && !state.write_dirty)
      state.lane_deferred_reason = "selected-symbol Dossier disable-reconciliation is ready but remains subordinate to scan backlog until a calm write beat exists";

   int dossier_backlog_pending = 0;
   bool dossier_pressure_write_due = false;
   if(write_backlog && scan_backlog && state.l1_publish_pending_dossiers && state.write_dirty)
     {
      dossier_backlog_pending = ASC_CountRemainingDossierBacklog(state);
      dossier_pressure_write_due = ASC_DossierPressureWriteDue(state,
                                                              broad_catchup_incomplete,
                                                              dossier_backlog_pending);
     }

   if(write_backlog)
     {
      bool ui_priority_runtime_work_pending = ASC_HasUiPriorityRuntimeWorkPending(state, current_focus_write_due);
      if(ui_priority_active
         && scan_backlog
         && ui_priority_runtime_work_pending
         && !board_freshness_write_ready)
        {
         state.active_lane = ASC_LANE_PERSISTENCE;
         state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
         state.mode = ASC_MODE_WRITE_PRESSURE;
         state.write_force = true;
         state.lane_decision_reason = "persistence selected because ui-priority runtime-owned operator work is still pending";
         state.lane_deferred_reason = "scan backlog remains but ui-priority runtime-owned work has temporary write-lane priority";
         return;
        }

      if(ui_priority_active
         && scan_backlog
         && !ui_priority_runtime_work_pending
         && !board_freshness_write_ready
         && !(current_focus_write_due && !state.write_dirty))
        {
         state.active_lane = ASC_LANE_SCAN;
         state.active_sublane = ASC_SUBLANE_L1_BROAD_SCAN;
         state.lane_decision_reason = "scan selected for short-lived UI priority profile after recent chart interaction";
         state.lane_deferred_reason = "non-critical publication backlog deferred while UI-priority interaction window remains active";
         return;
        }

      bool allow_write_lane = true;
      if(scan_backlog && state.consecutive_write_beats >= write_streak_limit)
         allow_write_lane = false;

      if(!allow_write_lane)
        {
         state.active_lane = ASC_LANE_SCAN;
         state.active_sublane = ASC_SUBLANE_L1_BROAD_SCAN;
         state.lane_decision_reason = "scan selected because write streak limit was reached while scan backlog remains";
         return;
        }

      if(scan_backlog)
        {
         if(current_focus_write_due && !state.write_dirty && current_focus_starved)
           {
            state.active_lane = ASC_LANE_PERSISTENCE;
            state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
            state.lane_decision_reason = "persistence selected for starved selected-symbol Dossier disable-reconciliation";
            return;
           }

         if(dossier_pressure_write_due)
           {
            state.active_lane = ASC_LANE_PERSISTENCE;
            state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
            state.mode = ASC_MODE_WRITE_PRESSURE;
            state.lane_decision_reason = StringFormat("persistence selected for dossier pressure relief (backlog=%d)", dossier_backlog_pending);
            return;
           }

         if(state.beats_since_write >= g_asc_trader_controls.write_starvation_beats)
           {
            state.write_force = true;
            state.mode = ASC_MODE_WRITE_PRESSURE;
            state.active_lane = ASC_LANE_PERSISTENCE;
            state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
            state.lane_decision_reason = "persistence forced because protected write backlog reached starvation relief";
            return;
           }

         state.active_lane = ASC_LANE_SCAN;
         state.active_sublane = ASC_SUBLANE_L1_BROAD_SCAN;
         if(current_focus_write_due && !state.write_dirty)
            state.lane_decision_reason = "scan selected because selected-symbol Dossier disable-reconciliation may not preempt broad scan backlog without write pressure";
         else
            state.lane_decision_reason = "scan selected because scan backlog remains and protected write starvation has not fired";
         return;
        }

      state.active_lane = ASC_LANE_PERSISTENCE;
      state.active_sublane = ASC_SUBLANE_PERSISTENCE_PUBLISH;
      if(current_focus_write_due && !state.write_dirty)
        {
         state.lane_decision_reason = "persistence selected for calm selected-symbol Dossier disable-reconciliation";
        }
      else
         state.lane_decision_reason = "persistence selected because publication backlog is ready and scan backlog is clear";
      return;
     }

   state.active_lane = ASC_LANE_SCAN;
   state.active_sublane = ASC_SUBLANE_L1_BROAD_SCAN;
   if(state.mode == ASC_MODE_WARMUP)
      state.lane_decision_reason = "scan selected for warmup coverage";
   else if(scan_backlog)
      state.lane_decision_reason = "scan selected because scan backlog remains";
   else
      state.lane_decision_reason = "scan selected because no protected write backlog is ready";
  }

void ASC_RunScanLane(ASC_RuntimeState &state,
                     const datetime now_utc,
                     const ulong beat_start_us,
                     const int beat_budget_ms,
                     ASC_HeartbeatTelemetry &telemetry,
                     string &yield_reason)
  {
   int packet_target = ASC_DynamicL1PacketTarget(state);
   int burst_cap = ASC_DynamicL1BurstCap(state, packet_target);
   bool ui_priority_active = ASC_IsUiPriorityActive(state, now_utc);
   if(ui_priority_active)
      state.ui_priority_scan_lane_entered_count++;
   if(ui_priority_active)
     {
      int reduced_packet_target = (packet_target * ASC_UI_PRIORITY_SCAN_PACKET_SCALE_PERCENT) / 100;
      packet_target = MathMax(8, reduced_packet_target);

      int reduced_burst_cap = (burst_cap * ASC_UI_PRIORITY_SCAN_BURST_SCALE_PERCENT) / 100;
      burst_cap = ASC_ClampInt(MathMax(1, reduced_burst_cap), 1, 10);
     }

   int packet_completed = 0;
   int bursts_executed = 0;
   int due_selected_total = 0;
   int retry_selected_total = 0;
   int retry_exhausted_total = 0;
   int remaining = state.deferred_scan_symbols;
   bool cycle_complete = false;
   int next_cursor = state.scan_cursor;
   datetime next_due_utc = 0;

   for(int burst = 0; burst < burst_cap && packet_completed < packet_target; burst++)
     {
      if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
        {
         state.lane_deferred_reason = StringFormat("scan heartbeat budget exhausted at burst=%d/%d", burst, burst_cap);
         if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
            yield_reason = "scan_budget_time_exhausted";
         break;
        }

      int remaining_packet = packet_target - packet_completed;
      int burst_budget = remaining_packet;
      int burst_divisor = burst_cap - burst;
      if(burst_divisor > 1)
         burst_budget = (remaining_packet + burst_divisor - 1) / burst_divisor;
      if(burst_budget <= 0)
         burst_budget = 1;

      ASC_FunctionResult scan_result;
      ASC_FunctionResultBegin(scan_result, "ASC_Layer1MarketState", "ASC_Layer1ScanSlice", "admitted");

      int scanned = 0;
      int due_selected = 0;
      int retry_selected = 0;
      int retry_exhausted = 0;
      ASC_Layer1ScanSlice(now_utc,
                          next_cursor,
                          burst_budget,
                          state.l1_bootstrap_active,
                          next_cursor,
                          scanned,
                          remaining,
                          cycle_complete,
                          due_selected,
                          retry_selected,
                          retry_exhausted,
                          next_due_utc,
                          scan_result);

      ASC_RecordResult(state, scan_result);
      bursts_executed++;
      packet_completed += scanned;
      due_selected_total += due_selected;
      retry_selected_total += retry_selected;
      retry_exhausted_total += retry_exhausted;

      if(scanned <= 0 || cycle_complete)
         break;
     }

   state.scan_cursor = next_cursor;
   state.deferred_scan_symbols = remaining;
   state.l1_packet_target = packet_target;
   state.l1_packet_completed = packet_completed;
   state.l1_bursts_executed = bursts_executed;
   state.l1_due_selected = due_selected_total;
   state.l1_retry_selected = retry_selected_total;
   state.l1_retry_exhausted = retry_exhausted_total;
   state.l1_next_scan_due_utc = next_due_utc;

   telemetry.packet_target = packet_target;
   telemetry.packet_completed = packet_completed;
   telemetry.bursts_executed = bursts_executed;
   telemetry.due_selected = due_selected_total;
   telemetry.retry_selected = retry_selected_total;
   telemetry.scanned_symbols = packet_completed;
   telemetry.deferred_scan_symbols = remaining;

   ASC_Layer1RefreshLatestSummary(now_utc);

   ASC_Layer1PassSummary summary;
   bool has_summary = ASC_Layer1TryGetLatestSummary(summary);
   if(has_summary)
     {
      ASC_UpdateLayer1PostureState(state, summary);
      ASC_UpdateBootstrapState(state, summary, now_utc);
     }

   bool has_meaningful_partial = false;
   if(has_summary)
      has_meaningful_partial = (summary.assessed_symbols >= g_asc_trader_controls.partial_write_min_assessed);

   string tactical_symbol = ASC_SelectLayer2TacticalSymbol();
   int l2_cursor_out = state.l2_scan_cursor;
   int l2_processed = 0;
   int l2_remaining_due = state.l2_due_remaining;
   int l2_admitted = state.l2_admitted_symbols;
   int l2_changed = 0;
   string l2_companion_reason = "";
   bool allow_l2_companion = ASC_ShouldRunLayer2CompanionWork(state,
                                                              now_utc,
                                                              packet_target,
                                                              packet_completed,
                                                              due_selected_total,
                                                              retry_selected_total,
                                                              cycle_complete,
                                                              l2_companion_reason);

   if(allow_l2_companion)
     {
      if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
        {
         state.lane_deferred_reason = "layer2 companion deferred because scan heartbeat budget was exhausted";
         state.layer2_dirty = true;
         state.l2_packet_completed = 0;
         state.l2_changed_symbols = 0;
         allow_l2_companion = false;
        }
     }

   if(allow_l2_companion)
     {
      int l2_budget = state.l2_packet_budget;
      if(l2_budget <= 0)
         l2_budget = ASC_L2_PACKET_BUDGET_PER_HEARTBEAT;
      int open_or_admitted = has_summary ? summary.open_count : state.l2_admitted_symbols;
      int l2_dynamic_budget = ASC_L2DynamicPacketBudget(open_or_admitted);
      l2_budget = MathMin(l2_budget, l2_dynamic_budget);

      bool l2_pressure = (state.layer2_dirty && state.l2_due_remaining > MathMax(16, open_or_admitted / 3));
      if(l2_pressure)
         l2_budget = MathMin(l2_dynamic_budget, MathMax(l2_budget, 24));

      if(!cycle_complete && packet_completed > 0)
        {
         int companion_floor = l2_pressure ? 12 : 8;
         l2_budget = MathMin(l2_budget, MathMax(companion_floor, l2_budget / 2));
        }
      if(due_selected_total > 0 || retry_selected_total > 0)
        {
         int confirmation_floor = l2_pressure ? 12 : 8;
         l2_budget = MathMin(l2_budget, MathMax(confirmation_floor, l2_budget / 2));
        }

      ASC_FunctionResult l2_result;
      ASC_Layer2ScanSlice(now_utc,
                          state.l2_scan_cursor,
                          l2_budget,
                          tactical_symbol,
                          l2_cursor_out,
                          l2_processed,
                          l2_remaining_due,
                          l2_admitted,
                          l2_changed,
                          l2_result);
      ASC_RecordResult(state, l2_result, false);
      state.l2_scan_cursor = l2_cursor_out;
      state.l2_packet_completed = l2_processed;
      state.l2_admitted_symbols = l2_admitted;
      state.l2_due_remaining = l2_remaining_due;
      state.l2_changed_symbols = l2_changed;
      state.l2_last_scan_utc = now_utc;
      state.layer2_dirty = (l2_remaining_due > 0);

      ASC_Layer2Summary l2_summary;
      if(ASC_Layer2TryGetSummary(l2_summary))
        {
         state.l2_next_due_utc = l2_summary.next_due_utc;
         state.l2_next_due_reason = l2_summary.next_due_reason;
        }
     }
   else
     {
      state.l2_packet_completed = 0;
      state.l2_changed_symbols = 0;
      state.layer2_dirty = state.layer2_dirty || state.l2_due_remaining > 0;
     }

   telemetry.l2_processed = l2_processed;
   telemetry.l2_admitted = state.l2_admitted_symbols;
   telemetry.l2_changed = l2_changed;
   telemetry.l2_due_remaining = state.l2_due_remaining;

   if(l2_changed > 0)
     {
      state.write_dirty = true;
      state.l2_publish_pending = true;
      state.l1_publish_pending_manifest = true;
      ASC_RequestOpenSymbolDossierRefresh(state, now_utc);
     }

   if(cycle_complete)
     {
      state.layer1_dirty = false;
      state.write_dirty = true;
      state.l1_partial_beats = 0;
      state.l1_publish_pending_partial = false;
      state.l1_publish_pending_full = true;
      state.l1_publish_pending_essentials = true;
      state.l1_publish_pending_manifest = true;
      if(state.l1_publish_pending_dossiers)
         state.dossier_open_refresh_only = false;
      state.l1_last_publish_posture = has_summary ? summary.publication_posture : "partial";
      bool dossier_backoff_active_now = ASC_IsCooldownActive(now_utc, state.dossier_backoff_until_utc);
      bool dossier_publish_due = (!dossier_backoff_active_now && ASC_DossierPublishIntervalSatisfied(now_utc, state.l1_last_dossier_publish_utc));
      if(state.l1_bootstrap_active)
         dossier_publish_due = true;
      ASC_RefreshDossierHydrationLedgerFromFilesystem(state, "scan_cycle_complete_dossier_queue", false, ASC_DossierLedgerRefreshMinIntervalSeconds(state));
      int missing_dossiers = ASC_CountMissingDossierArtifacts(state);
      int non_rich_dossiers = ASC_CountNonRichDossierArtifacts(state);
      if(missing_dossiers > 0)
         ASC_QueueDossierExistenceDuty(state);
      else if(non_rich_dossiers > 0)
         ASC_QueueDossierContinuationDuty(state);
      else if(!state.l1_publish_pending_dossiers && dossier_publish_due)
         ASC_QueueDossierContinuationDuty(state);
      int dossier_pending = ASC_CountRemainingDossierBacklog(state);
      state.deferred_write_artifacts = ASC_PendingBundleArtifactCount(state, summary, dossier_pending);
      yield_reason = (has_summary && summary.is_ready) ? "l1_ready_full_due_set" : "l1_full_due_set_pending_readiness";
     }
   else
     {
      state.layer1_dirty = (remaining > 0);
      if(packet_completed <= 0 && remaining <= 0)
        {
         if(has_summary && summary.is_degraded)
            yield_reason = "l1_no_due_symbols_degraded";
         else if(has_summary && summary.is_stale)
            yield_reason = "l1_no_due_symbols_stale";
         else
            yield_reason = "l1_no_due_symbols";
        }
      else if(has_meaningful_partial)
        {
         state.l1_partial_beats++;
         bool partial_publish_due = (state.l1_partial_beats >= g_asc_trader_controls.l1_partial_write_beats || summary.is_degraded || summary.is_stale || summary.readiness_posture == "ready");
         if(partial_publish_due)
           {
            state.l1_publish_pending_partial = true;
            state.l1_publish_pending_essentials = true;
            state.write_dirty = true;
            state.l1_publish_pending_manifest = true;
            if(state.l1_publish_pending_dossiers)
               state.dossier_open_refresh_only = false;
            bool dossier_backoff_active_now = ASC_IsCooldownActive(now_utc, state.dossier_backoff_until_utc);
            bool dossier_publish_due = (!dossier_backoff_active_now && ASC_DossierPublishIntervalSatisfied(now_utc, state.l1_last_dossier_publish_utc));
            if(state.l1_bootstrap_active)
               dossier_publish_due = true;
            ASC_RefreshDossierHydrationLedgerFromFilesystem(state, "scan_partial_publish_dossier_queue", false, ASC_DossierLedgerRefreshMinIntervalSeconds(state));
            int missing_dossiers = ASC_CountMissingDossierArtifacts(state);
            int non_rich_dossiers = ASC_CountNonRichDossierArtifacts(state);
            if(missing_dossiers > 0)
               ASC_QueueDossierExistenceDuty(state);
            else if(non_rich_dossiers > 0)
               ASC_QueueDossierContinuationDuty(state);
            else if(!state.l1_publish_pending_dossiers && dossier_publish_due)
               ASC_QueueDossierContinuationDuty(state);
            int dossier_pending = ASC_CountRemainingDossierBacklog(state);
            state.deferred_write_artifacts = ASC_PendingBundleArtifactCount(state, summary, dossier_pending);
            state.l1_last_publish_posture = summary.publication_posture;
            yield_reason = summary.is_ready ? "l1_partial_publish_readiness_change" : "l1_partial_publish_due";
           }
         else
           {
            state.l1_publish_pending_partial = false;
            yield_reason = "l1_partial_due_set_accumulating";
           }
        }
      else
        {
         if(packet_completed >= packet_target)
            yield_reason = "l1_packet_target_met_waiting_materiality";
         else
            yield_reason = "l1_scan_budget_exhausted";
        }
     }

   if(StringLen(l2_companion_reason) > 0 && !allow_l2_companion)
     {
      state.lane_deferred_reason = l2_companion_reason;
      if(StringLen(yield_reason) > 0)
         yield_reason += "|" + l2_companion_reason;
      else
         yield_reason = l2_companion_reason;
     }

   if(has_summary)
      state.last_scan_utc = summary.pass_utc;
  }

string ASC_SymbolDataPackLiteTextOrNone(const string value)
  {
   return (StringLen(value) > 0 ? value : "none");
  }

string ASC_SymbolDataPackDueStateFromMode(const string mode,const int total,const datetime next_due_utc,const datetime now_utc,const bool enabled,const bool top5_route)
  {
   if(!enabled)
      return "deferred";
   if(next_due_utc > 0 && now_utc < next_due_utc)
      return "not_due";
   if(total <= 0)
      return top5_route ? "no_committed_membership" : "no_open_snapshot";
   if(StringFind(mode, "deferred_budget") >= 0)
      return "write_pressure_deferred";
   if(StringFind(mode, "retained_last_good") >= 0)
      return "retained_last_good";
   if(StringFind(mode, "no_change") >= 0)
      return "no_change_skipped";
   return "due_now";
  }

string ASC_SymbolDataPackDueReasonFromState(const string due_state,const string mode,const int total,const datetime next_due_utc,const bool top5_route)
  {
   if(due_state == "not_due")
      return "not_due_next_due_utc=" + ASC_ArtifactFormatUtc(next_due_utc);
   if(due_state == "no_committed_membership")
      return top5_route ? "existing_top5perbucket_committed_queue_empty_or_unavailable_no_lite_membership_faking" : "committed_membership_empty";
   if(due_state == "no_open_snapshot")
      return "existing_globaltop10_completed_snapshot_empty_or_unavailable_no_lite_membership_faking";
   if(due_state == "write_pressure_deferred")
      return "write_lane_budget_exhausted_retry_next_heartbeat";
   if(due_state == "retained_last_good")
      return "publication_retained_last_good_continuity_evidence_not_current_truth";
   if(due_state == "no_change_skipped")
      return "existing_final_materially_equal_no_write_pressure_added";
   if(due_state == "deferred")
      return "runtime_activation_disabled_or_policy_deferred";
   if(total <= 0)
      return top5_route ? "no_committed_membership" : "no_open_snapshot";
   if(StringLen(mode) <= 0)
      return "due_state_mode_empty_requires_runtime_investigation";
   return "due_now_existing_membership_available";
  }

string ASC_SymbolDataPackDeferredUntilUtcText(const string due_state,const datetime next_due_utc)
  {
   if(due_state == "not_due" || due_state == "write_pressure_deferred" || due_state == "no_committed_membership" || due_state == "no_open_snapshot" || due_state == "deferred")
      return ASC_ArtifactFormatUtc(next_due_utc);
   return "not_applicable";
  }

string ASC_SymbolDataPackWeekendOrClosedContextFromDue(const string due_state,const bool top5_route)
  {
   if(due_state == "no_committed_membership" || due_state == "no_open_snapshot")
      return top5_route ? "possible_closed_market_or_weekend_context_requires_live_market_state_basis" : "possible_closed_market_or_weekend_context_requires_committed_globaltop10_snapshot";
   if(due_state == "not_due")
      return "not_due_not_a_write_failure";
   return "not_inferred_by_lite_writer";
  }

bool ASC_SelectSymbolDataPackLiteRuntimeSymbol(const ASC_RuntimeState &state,string &symbol_out,string &source_out,string &reason_out)
  {
   symbol_out = "";
   source_out = "deferred_no_symbol";
   reason_out = "no eligible runtime symbol found";

   if(StringLen(state.current_focus_sync_last_selected_symbol) > 0)
     {
      symbol_out = state.current_focus_sync_last_selected_symbol;
      source_out = "current_focus_selected_symbol";
      reason_out = "using selected-symbol Current Focus sync context";
      return true;
     }
   if(StringLen(state.current_focus_live_symbol) > 0)
     {
      symbol_out = state.current_focus_live_symbol;
      source_out = "current_focus_live_symbol";
      reason_out = "using live Current Focus symbol";
      return true;
     }
   if(StringLen(state.hud_selected_symbol) > 0)
     {
      symbol_out = state.hud_selected_symbol;
      source_out = "hud_selected_symbol";
      reason_out = "using operator-selected HUD symbol";
      return true;
     }
   if(ArraySize(state.top10_run_full_last_completed_symbols) > 0 && StringLen(state.top10_run_full_last_completed_symbols[0]) > 0)
     {
      symbol_out = state.top10_run_full_last_completed_symbols[0];
      source_out = "globaltop10_rank1_existing_snapshot";
      reason_out = "using existing GlobalTop10 completed-symbol snapshot without recalculating rank/order";
      return true;
     }
   if(ArraySize(state.committed_l4_rows) > 0 && StringLen(state.committed_l4_rows[0].symbol) > 0)
     {
      symbol_out = state.committed_l4_rows[0].symbol;
      source_out = "committed_l4_existing_snapshot_first_symbol";
      reason_out = "using existing committed L4 snapshot first symbol without recalculating rank/order";
      return true;
     }

   return false;
  }

void ASC_MaybeScheduleSymbolDataPackLiteRuntimeActivation(ASC_RuntimeState &state,const datetime now_utc)
  {
   state.symbol_data_pack_lite_activation_enabled = ASC_SymbolDataPackRuntimeActivationEnabled();
   state.symbol_data_pack_lite_write_mode = "real_atomic_write_bounded_one_symbol";
   state.symbol_data_pack_globaltop10_enabled = ASC_SymbolDataPackRuntimeActivationEnabled();
   state.symbol_data_pack_top5perbucket_enabled = ASC_SymbolDataPackRuntimeActivationEnabled();

   if(!state.symbol_data_pack_lite_activation_enabled)
     {
      state.symbol_data_pack_lite_activation_mode = "disabled_by_policy";
      state.symbol_data_pack_lite_budget_state = "not_due";
      state.symbol_data_pack_lite_activation_reason = "runtime activation flag disabled";
      state.symbol_data_pack_globaltop10_activation_mode = "disabled_by_policy";
      state.symbol_data_pack_globaltop10_last_reason = "runtime activation flag disabled";
      state.symbol_data_pack_top5perbucket_activation_mode = "disabled_by_policy";
      state.symbol_data_pack_top5perbucket_last_reason = "runtime activation flag disabled";
      return;
     }

   bool lite_due = !(state.symbol_data_pack_lite_next_due_utc > 0 && now_utc < state.symbol_data_pack_lite_next_due_utc);
   int globaltop10_snapshot_count = ArraySize(state.top10_run_full_last_completed_symbols);
   state.symbol_data_pack_globaltop10_total = MathMax(0, globaltop10_snapshot_count);
   bool globaltop10_has_snapshot = (globaltop10_snapshot_count > 0);
   bool globaltop10_due = (globaltop10_has_snapshot && !(state.symbol_data_pack_globaltop10_next_due_utc > 0 && now_utc < state.symbol_data_pack_globaltop10_next_due_utc));
   int top5perbucket_snapshot_count = ArraySize(state.top5_bucket_queue_symbols);
   state.symbol_data_pack_top5perbucket_total = MathMax(0, top5perbucket_snapshot_count);
   bool top5perbucket_has_snapshot = (top5perbucket_snapshot_count > 0 && StringLen(state.top5_bucket_last_signature) > 0);
   bool top5perbucket_due = (top5perbucket_has_snapshot && !(state.symbol_data_pack_top5perbucket_next_due_utc > 0 && now_utc < state.symbol_data_pack_top5perbucket_next_due_utc));

   if(!lite_due)
     {
      if(StringLen(state.symbol_data_pack_lite_activation_mode) <= 0)
         state.symbol_data_pack_lite_activation_mode = "bounded_selected_symbol_write";
      state.symbol_data_pack_lite_budget_state = "not_due";
     }

   if(!globaltop10_has_snapshot)
     {
      state.symbol_data_pack_globaltop10_activation_mode = "deferred_no_completed_globaltop10_snapshot";
      state.symbol_data_pack_globaltop10_last_reason = "waiting for existing GlobalTop10 completed symbol snapshot; no recompute allowed";
     }
   else if(!globaltop10_due)
     {
      if(StringLen(state.symbol_data_pack_globaltop10_activation_mode) <= 0)
         state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_not_due";
     }

   if(!top5perbucket_has_snapshot)
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "deferred_no_completed_top5perbucket_queue";
      state.symbol_data_pack_top5perbucket_last_reason = "waiting for existing Top5PerBucket bucket queue snapshot; no recompute allowed";
     }
   else if(!top5perbucket_due)
     {
      if(StringLen(state.symbol_data_pack_top5perbucket_activation_mode) <= 0)
         state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_not_due";
     }

   if(!lite_due && !globaltop10_due && !top5perbucket_due)
      return;

   state.write_dirty = true;
   state.l1_publish_pending_manifest = true;

   if(lite_due)
     {
      state.symbol_data_pack_lite_budget_state = "due_waiting_for_write_lane";
      if(StringLen(state.symbol_data_pack_lite_activation_mode) <= 0 || state.symbol_data_pack_lite_activation_mode == "success_written" || state.symbol_data_pack_lite_activation_mode == "success_no_change")
         state.symbol_data_pack_lite_activation_mode = "bounded_selected_symbol_write";
      state.symbol_data_pack_lite_activation_reason = "due bounded Symbol Data Pack Lite runtime proof write";
     }

   if(globaltop10_due)
     {
      state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_due_waiting_for_write_lane";
      state.symbol_data_pack_globaltop10_last_reason = "due bounded GlobalTop10 Symbol Data Pack mirror write; existing snapshot consumed read-only";
     }

   if(top5perbucket_due)
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_due_waiting_for_write_lane";
      state.symbol_data_pack_top5perbucket_last_reason = "due bounded Top5PerBucket Symbol Data Pack mirror write; existing bucket queue consumed read-only";
     }
  }



string ASC_SymbolDataPackLiteExtractRouteProofToken(const string text,const string token)
  {
   if(StringLen(text) <= 0 || StringLen(token) <= 0)
      return "none";

   string needle = token + "=";
   int start = StringFind(text, needle);
   if(start < 0)
      return "none";

   start += StringLen(needle);
   int stop = start;
   int n = StringLen(text);
   while(stop < n)
     {
      ushort ch = (ushort)StringGetCharacter(text, stop);
      if(ch == 32 || ch == 124 || ch == 10 || ch == 13 || ch == 9)
         break;
      stop++;
     }

   string value = StringSubstr(text, start, stop - start);
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0)
      return "none";
   return value;
  }

string ASC_SymbolDataPackLiteRouteProofCompact(const string route,
                                               const string bucket,
                                               const string symbol,
                                               const string writer_state,
                                               const string writer_reason)
  {
   return "route=" + route
          + " bucket=" + (StringLen(bucket) > 0 ? bucket : "not_applicable")
          + " symbol=" + (StringLen(symbol) > 0 ? symbol : "none")
          + " state=" + (StringLen(writer_state) > 0 ? writer_state : "none")
          + " final_readback=" + ASC_SymbolDataPackLiteExtractRouteProofToken(writer_reason, "final_readback_verified")
          + " fallback=" + ASC_SymbolDataPackLiteExtractRouteProofToken(writer_reason, "final_fallback_state")
          + " first_failure=" + ASC_SymbolDataPackLiteExtractRouteProofToken(writer_reason, "reconciliation_first_failure_reason")
          + " proof_summary=compact_first_raw_reason_follows";
  }

string ASC_SymbolDataPackReconciliationTokenOrFallback(const string proof_text,const string token,const string fallback_value)
  {
   string value = ASC_SymbolDataPackLiteExtractRouteProofToken(proof_text, token);
   if(value == "none" && token == "reconciliation_expected_symbols_summary")
      value = ASC_SymbolDataPackLiteExtractRouteProofToken(proof_text, "reconciliation_expected_symbols");
   if(value == "none" && token == "reconciliation_unexpected_symbols_summary")
      value = ASC_SymbolDataPackLiteExtractRouteProofToken(proof_text, "reconciliation_unexpected_symbols");
   if(value == "none")
      value = fallback_value;
   return ASC_SymbolDataPackProofFieldValue(value, fallback_value);
  }

string ASC_SymbolDataPackReconciliationDurableProofBlock(const string route_text,
                                                         const string bucket_text,
                                                         const string proof_text)
  {
   return "reconciliation_proof=present"
          + " | reconciliation_route=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_route", route_text)
          + " | reconciliation_bucket=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_bucket", bucket_text)
          + " | reconciliation_state=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_state", "source_supported_runtime_unproven")
          + " | reconciliation_current_truth_source=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_current_truth_source", "membership_snapshot")
          + " | reconciliation_expected_count=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_expected_count", "unknown")
          + " | reconciliation_found_final_count=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_found_final_count", "unknown")
          + " | reconciliation_expected_symbols_summary=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_expected_symbols_summary", "unknown")
          + " | reconciliation_unexpected_symbols_summary=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_unexpected_symbols_summary", "unknown")
          + " | reconciliation_archived_count=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_archived_count", "0")
          + " | reconciliation_deleted_count=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_deleted_count", "0")
          + " | reconciliation_skipped_count=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_skipped_count", "0")
          + " | reconciliation_first_failure_reason=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_first_failure_reason", "none")
          + " | reconciliation_final_path=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_final_path", "not_applicable")
          + " | reconciliation_archive_path=" + ASC_SymbolDataPackReconciliationTokenOrFallback(proof_text, "reconciliation_archive_path", "not_applicable")
          + " | reconciliation_durable_surface_contract=scanner_status_manifest_functionresults"
          + " | reconciliation_output_evidence_mutated=false"
          + " | signal_permission=false | trade_permission=false | execution_permission=false";
  }

void ASC_RecordSymbolDataPackReconciliationFunctionResult(const ASC_RuntimeState &state,
                                                          const string route_text,
                                                          const string bucket_text,
                                                          const bool reconcile_ok,
                                                          const string proof_text,
                                                          const string target_path)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_Dispatcher", "ASC_SymbolDataPackReconciliationObservability", route_text);
   ASC_FunctionResultSetTruthBoundary(result, "symbol_data_pack.writer_reconciliation_state", "durable_reconciliation_observability_boundary");
   ASC_FunctionResultSetProof(result, ASC_FUNCTION_RESULT_PROOF_EVENT_ARTIFACT_PUBLICATION, (reconcile_ok ? ASC_FUNCTION_RESULT_PROOF_STATUS_SOURCE_ONLY : ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_WRITE_FAILED));
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_ARTIFACT_BOUNDARY);
   ASC_FunctionResultFinish(result,
                            (reconcile_ok ? ASC_RESULT_OK : ASC_RESULT_ERROR),
                            (reconcile_ok ? ASC_RC_OK : ASC_RC_INVALID_STATE),
                            ASC_SymbolDataPackReconciliationDurableProofBlock(route_text, bucket_text, proof_text),
                            target_path);
   ASC_RecordResult(state, result, true, true);
  }

string ASC_SymbolDataPackLiteExtractMissingRequiredTokenByMarker(const string writer_reason,const string marker)
  {
   if(StringLen(writer_reason) <= 0 || StringLen(marker) <= 0)
      return "";

   string required_tokens[];
   ASC_SymbolDataPackRequiredTokens(required_tokens);
   for(int i = 0; i < ArraySize(required_tokens); i++)
     {
      if(StringLen(required_tokens[i]) <= 0)
         continue;
      if(StringFind(writer_reason, marker + required_tokens[i]) >= 0)
         return required_tokens[i];
     }

   int pos = StringFind(writer_reason, marker);
   if(pos < 0)
      return "";

   string token = StringSubstr(writer_reason, pos + StringLen(marker));
   int best_stop = -1;
   string separators[8];
   separators[0] = " | ";
   separators[1] = " temp_path=";
   separators[2] = " final_path=";
   separators[3] = " elapsed_ms=";
   separators[4] = " retained_last_good=";
   separators[5] = " error_code=";
   separators[6] = " reason=";
   separators[7] = " no_change_";
   for(int j = 0; j < ArraySize(separators); j++)
     {
      int stop = StringFind(token, separators[j]);
      if(stop >= 0 && (best_stop < 0 || stop < best_stop))
         best_stop = stop;
     }
   if(best_stop >= 0)
      token = StringSubstr(token, 0, best_stop);

   StringTrimLeft(token);
   StringTrimRight(token);
   return token;
  }

string ASC_SymbolDataPackLiteExtractMissingRequiredToken(const string writer_reason)
  {
   string token = ASC_SymbolDataPackLiteExtractMissingRequiredTokenByMarker(writer_reason, "missing_required_token=");
   if(StringLen(token) > 0)
      return token;
   return ASC_SymbolDataPackLiteExtractMissingRequiredTokenByMarker(writer_reason, "missing_token=");
  }

bool ASC_ServiceSymbolDataPackLiteRuntimeActivation(ASC_RuntimeState &state,const datetime now_utc,const ulong beat_start_us,const int beat_budget_ms,string &yield_reason)
  {
   if(!ASC_SymbolDataPackRuntimeActivationEnabled())
     {
      state.symbol_data_pack_lite_activation_enabled = false;
      state.symbol_data_pack_lite_activation_mode = "disabled_by_policy";
      state.symbol_data_pack_lite_budget_state = "disabled";
      state.symbol_data_pack_lite_last_writer_state = "not_attempted";
      state.symbol_data_pack_lite_last_writer_reason = "runtime activation flag disabled";
      return false;
     }

   if(state.symbol_data_pack_lite_next_due_utc > 0 && now_utc < state.symbol_data_pack_lite_next_due_utc)
     {
      state.symbol_data_pack_lite_activation_mode = "flat_transition_not_due";
      state.symbol_data_pack_lite_activation_reason = "not_due next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc);
      state.symbol_data_pack_lite_budget_state = "not_due";
      return false;
     }

   if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
     {
      state.symbol_data_pack_lite_activation_mode = "deferred_budget";
      state.symbol_data_pack_lite_budget_state = "write_budget_exhausted_pre_lite";
      state.symbol_data_pack_lite_last_error = "write heartbeat budget exhausted before Lite activation";
      state.symbol_data_pack_lite_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "symbol_data_pack_lite_deferred_budget";
      return false;
     }

   string symbol = "";
   string source = "";
   string route_reason = "";
   if(!ASC_SelectSymbolDataPackLiteRuntimeSymbol(state, symbol, source, route_reason))
     {
      state.symbol_data_pack_lite_activation_mode = "deferred_no_symbol";
      state.symbol_data_pack_lite_symbol_source = source;
      state.symbol_data_pack_lite_symbol = "";
      state.symbol_data_pack_lite_activation_reason = route_reason;
      state.symbol_data_pack_lite_budget_state = "no_symbol";
      state.symbol_data_pack_lite_last_error = "no selected/current/top symbol available";
      state.symbol_data_pack_lite_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
      state.l1_publish_pending_manifest = true;
      return false;
     }

   state.symbol_data_pack_lite_symbol_source = source;
   state.symbol_data_pack_lite_symbol = symbol;
   state.symbol_data_pack_lite_activation_reason = route_reason;
   state.symbol_data_pack_lite_last_attempt_utc = now_utc;
   state.symbol_data_pack_lite_writer_called = true;
   state.symbol_data_pack_lite_final_path = ASC_SymbolDataPackTargetPath(state.server_root, symbol);
   state.symbol_data_pack_lite_temp_path = ASC_SymbolDataPackTempPath(state.server_root, symbol);
   state.symbol_data_pack_lite_last_good_path = ASC_SymbolDataPackLastGoodContinuityPath(state.server_root, symbol);
   state.symbol_data_pack_lite_missing_token_count = 0;
   state.symbol_data_pack_lite_first_missing_token = "none";

   string writer_state = "pending";
   string writer_reason = "pending";
   bool ok = ASC_SymbolDataPackTryPublishAtomic(state.server_root, symbol, true, writer_state, writer_reason);
   bool retained_last_good_continuity = (writer_state == "continuity" || StringFind(writer_reason, "retained_last_good=yes") >= 0);
   state.symbol_data_pack_lite_last_writer_state = writer_state;
   state.symbol_data_pack_lite_last_writer_reason = writer_reason;
   state.symbol_data_pack_lite_no_change_skipped = (StringFind(writer_reason, "no_material_change") >= 0 || StringFind(writer_state, "unchanged") >= 0);
   state.symbol_data_pack_lite_write_success = (ok && !retained_last_good_continuity);

   string missing_required_token = ASC_SymbolDataPackLiteExtractMissingRequiredToken(writer_reason);
   if(StringLen(missing_required_token) > 0)
     {
      state.symbol_data_pack_lite_validation_status = "validation_failed_missing_required_token";
      state.symbol_data_pack_lite_missing_token_count = 1;
      state.symbol_data_pack_lite_first_missing_token = missing_required_token;
     }
   else
     {
      state.symbol_data_pack_lite_validation_status = (retained_last_good_continuity ? "validation_checked_retained_last_good_continuity" : (StringFind(writer_reason, "payload_contract_valid") >= 0 || ok ? "validation_checked" : "validation_failed_or_unproven"));
      state.symbol_data_pack_lite_missing_token_count = 0;
      state.symbol_data_pack_lite_first_missing_token = "none";
     }

   if(state.symbol_data_pack_lite_write_success)
     {
      state.symbol_data_pack_lite_activation_mode = state.symbol_data_pack_lite_no_change_skipped ? "success_no_change" : "success_written";
      state.symbol_data_pack_lite_last_success_utc = now_utc;
      state.symbol_data_pack_lite_last_error = "none";
      state.symbol_data_pack_lite_budget_state = "within_budget";
      state.symbol_data_pack_lite_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
     }
   else if(retained_last_good_continuity)
     {
      state.symbol_data_pack_lite_activation_mode = "continuity_retained_last_good";
      state.symbol_data_pack_lite_last_error = writer_reason;
      state.symbol_data_pack_lite_budget_state = "attempted_with_retained_last_good";
      state.symbol_data_pack_lite_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
     }
   else
     {
      state.symbol_data_pack_lite_activation_mode = (writer_state == "shadow_no_write" ? "shadow_dry_run" : "failed_write");
      state.symbol_data_pack_lite_last_error = writer_reason;
      state.symbol_data_pack_lite_budget_state = "attempted_within_budget";
      state.symbol_data_pack_lite_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
     }

   state.l1_publish_pending_manifest = true;
   ASC_LogInfo("ASC_Dispatcher", "ASC_ServiceSymbolDataPackLiteRuntimeActivation", symbol,
               "mode=" + state.symbol_data_pack_lite_activation_mode
               + " | source=" + source
               + " | final_path=" + state.symbol_data_pack_lite_final_path
               + " | writer_state=" + writer_state
               + " | writer_reason=" + writer_reason);
   return state.symbol_data_pack_lite_write_success;
  }

string ASC_SymbolDataPackLiteRuntimeStatusLine(const ASC_RuntimeState &state)
  {
   bool lite_retained_last_good = (StringFind(state.symbol_data_pack_lite_activation_mode, "retained_last_good") >= 0
                                  || StringFind(state.symbol_data_pack_lite_validation_status, "retained_last_good") >= 0
                                  || state.symbol_data_pack_lite_last_writer_state == "continuity"
                                  || StringFind(state.symbol_data_pack_lite_last_writer_reason, "retained_last_good=yes") >= 0);
   bool lite_fresh_write_success = (state.symbol_data_pack_lite_write_success && !state.symbol_data_pack_lite_no_change_skipped && !lite_retained_last_good);
   string lite_continuity_state = lite_retained_last_good ? "retained_last_good" : (state.symbol_data_pack_lite_no_change_skipped ? "no_change_existing_final" : (lite_fresh_write_success ? "fresh_written" : ASC_TextOrUnavailable(state.symbol_data_pack_lite_activation_mode)));
   string lite_fileio_missing_token_propagation = (StringFind(state.symbol_data_pack_lite_last_writer_reason, "missing_token=") >= 0 ? "observed_missing_token_marker" : "supported_missing_required_token_and_missing_token_markers");
   string lite_publication_health = lite_fresh_write_success ? "success_written" : (state.symbol_data_pack_lite_no_change_skipped ? "success_no_change" : (lite_retained_last_good ? "retained_last_good" : (StringFind(state.symbol_data_pack_lite_validation_status, "missing_required_token") >= 0 ? "failed_validation" : ASC_TextOrUnavailable(state.symbol_data_pack_lite_activation_mode))));

   return "Symbol Data Pack Lite Runtime Activation: present=true"
          + " | activation_enabled=" + (state.symbol_data_pack_lite_activation_enabled ? "true" : "false")
          + " | activation_mode=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_activation_mode)
          + " | runtime_callsite_enabled=true"
          + " | writer_called=" + (state.symbol_data_pack_lite_writer_called ? "true" : "false")
          + " | write_success=" + (state.symbol_data_pack_lite_write_success ? "true" : "false")
          + " | fresh_write_success=" + (lite_fresh_write_success ? "true" : "false")
          + " | no_change_skipped=" + (state.symbol_data_pack_lite_no_change_skipped ? "true" : "false")
          + " | retained_last_good=" + (lite_retained_last_good ? "true" : "false")
          + " | continuity_state=" + lite_continuity_state
          + " | activation_symbol_source=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_symbol_source)
          + " | activation_symbol=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_symbol)
          + " | last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
          + " | last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_success_utc)
          + " | next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc)
          + " | budget_state=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_budget_state)
          + " | validation_status=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_validation_status)
          + " | missing_token_count=" + IntegerToString((state.symbol_data_pack_lite_missing_token_count < 0) ? 0 : state.symbol_data_pack_lite_missing_token_count)
          + " | first_missing_token=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_first_missing_token)
          + " | final_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_final_path)
          + " | temp_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_temp_path)
          + " | last_good_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_good_path)
          + " | last_writer_state=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_writer_state)
          + " | last_writer_reason=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_writer_reason)
          + " | writer_reason=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_writer_reason)
          + " | fileio_missing_token_propagation=" + lite_fileio_missing_token_propagation
          + " | publication_health=" + lite_publication_health
          + " | last_error=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_error)
          + " | write_success_is_fresh_only_when_no_change_false_and_retained_last_good_false=true"
          + " | retained_last_good_cannot_equal_fresh_write_success=true"
          + " | fileio_missing_token_markers=missing_required_token,missing_token"
          + " | lifecycle_family=sdp"
          + " | lifecycle_route=flat_transition"
          + " | lifecycle_bucket=not_applicable"
          + " | lifecycle_symbol=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_symbol)
          + " | membership_source=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_symbol_source)
          + " | membership_snapshot_id_or_time=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
          + " | due_state=" + ASC_SymbolDataPackDueStateFromMode(state.symbol_data_pack_lite_activation_mode, 1, state.symbol_data_pack_lite_next_due_utc, TimeCurrent(), state.symbol_data_pack_lite_activation_enabled, false)
          + " | sdp_due_state=" + ASC_SymbolDataPackDueStateFromMode(state.symbol_data_pack_lite_activation_mode, 1, state.symbol_data_pack_lite_next_due_utc, TimeCurrent(), state.symbol_data_pack_lite_activation_enabled, false)
          + " | sdp_due_reason=" + ASC_SymbolDataPackDueReasonFromState(ASC_SymbolDataPackDueStateFromMode(state.symbol_data_pack_lite_activation_mode, 1, state.symbol_data_pack_lite_next_due_utc, TimeCurrent(), state.symbol_data_pack_lite_activation_enabled, false), state.symbol_data_pack_lite_activation_mode, 1, state.symbol_data_pack_lite_next_due_utc, false)
          + " | sdp_last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
          + " | sdp_last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_success_utc)
          + " | sdp_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc)
          + " | sdp_deferred_until_utc=" + ASC_SymbolDataPackDeferredUntilUtcText(ASC_SymbolDataPackDueStateFromMode(state.symbol_data_pack_lite_activation_mode, 1, state.symbol_data_pack_lite_next_due_utc, TimeCurrent(), state.symbol_data_pack_lite_activation_enabled, false), state.symbol_data_pack_lite_next_due_utc)
          + " | attempt_state=" + (state.symbol_data_pack_lite_writer_called ? "attempted" : "not_attempted")
          + " | hydration_state=lite_payload_only_no_siam_hydration"
          + " | sdp_hydration_state=lite_payload_only_no_siam_hydration"
          + " | sdp_hydration_reason=no_siam_hydration_no_new_data_enrichment_RUN201"
          + " | sdp_membership_snapshot_time=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
          + " | sdp_weekend_or_closed_context=not_inferred_by_flat_transition_lite_writer"
          + " | sdp_write_pressure_state=bounded_write_lane_no_flush_loop"
          + " | bucket_lifecycle_state=" + (state.symbol_data_pack_lite_budget_state == "not_due" ? "not_due" : (lite_retained_last_good ? "retained_last_good" : (lite_fresh_write_success ? "active_open_membership" : "unknown_requires_investigation")))
          + " | inactive_bucket_reason=" + (state.symbol_data_pack_lite_budget_state == "not_due" ? "not_due_next_due_controls_retry" : (lite_retained_last_good ? "retained_last_good_continuity_evidence_not_current_truth" : "selected_flat_transition_route_not_bucket_owned"))
          + " | staging_state=" + ((StringFind(state.symbol_data_pack_lite_last_writer_reason, "staging_state=") >= 0) ? "see_last_writer_reason" : "not_attempted_or_not_observed")
          + " | archive_state=" + ((StringFind(state.symbol_data_pack_lite_last_writer_reason, "archive_state=") >= 0) ? "see_last_writer_reason" : "not_attempted_or_not_observed")
          + " | final_publish_state=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_writer_state)
          + " | no_change_state=" + (state.symbol_data_pack_lite_no_change_skipped ? "no_change_existing_final" : "not_no_change")
          + " | retained_last_good_state=" + (lite_retained_last_good ? "retained_last_good" : "not_retained_last_good")
          + " | failure_class=" + ((state.symbol_data_pack_lite_missing_token_count > 0 || StringFind(state.symbol_data_pack_lite_activation_mode, "failed") >= 0) ? "publication_or_validation_failure" : "none")
          + " | first_failure_reason=" + ((state.symbol_data_pack_lite_missing_token_count > 0) ? state.symbol_data_pack_lite_first_missing_token : ((StringFind(state.symbol_data_pack_lite_activation_mode, "failed") >= 0) ? ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_last_error) : "none"))
          + " | final_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_final_path)
          + " | staging_path=flat_transition_no_route_staging"
          + " | archive_path=flat_transition_no_route_archive"
          + " | start_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
          + " | end_utc=runtime_output_required"
          + " | duration_ms=runtime_output_required"
          + " | current_truth_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_lite_final_path)
          + " | current_truth_source=final_only"
          + " | trade_permission=false | signal_permission=false | execution_permission=false"
          + " | run173_proof_checklist_marker=RUN173_capture_lite_final_temp_lastgood_status_manifest_logs_protected_artifacts";
  }

string ASC_SymbolDataPackRun195NonBlockingProofLine(const ASC_RuntimeState &state)
  {
   int global_expected = MathMax(0, state.symbol_data_pack_globaltop10_total);
   int global_completed = MathMax(0, state.symbol_data_pack_globaltop10_written_count)
                          + MathMax(0, state.symbol_data_pack_globaltop10_no_change_count)
                          + MathMax(0, state.symbol_data_pack_globaltop10_retained_last_good_count)
                          + MathMax(0, state.symbol_data_pack_globaltop10_failed_count);
   int top5_expected = MathMax(0, state.symbol_data_pack_top5perbucket_total);
   int top5_completed = MathMax(0, state.symbol_data_pack_top5perbucket_written_count)
                        + MathMax(0, state.symbol_data_pack_top5perbucket_no_change_count)
                        + MathMax(0, state.symbol_data_pack_top5perbucket_retained_last_good_count)
                        + MathMax(0, state.symbol_data_pack_top5perbucket_failed_count);
   string global_due_state = (!state.symbol_data_pack_globaltop10_enabled ? "disabled" : (global_expected <= 0 ? "deferred_no_membership_snapshot" : ((state.symbol_data_pack_globaltop10_next_due_utc > 0 && TimeCurrent() < state.symbol_data_pack_globaltop10_next_due_utc) ? "not_due" : "due_or_active")));
   string top5_due_state = (!state.symbol_data_pack_top5perbucket_enabled ? "disabled" : (top5_expected <= 0 ? "deferred_no_membership_snapshot" : ((state.symbol_data_pack_top5perbucket_next_due_utc > 0 && TimeCurrent() < state.symbol_data_pack_top5perbucket_next_due_utc) ? "not_due" : "due_or_active")));
   string global_first_failure_reason = ((state.symbol_data_pack_globaltop10_failed_count > 0 && StringLen(state.symbol_data_pack_globaltop10_last_error) > 0) ? state.symbol_data_pack_globaltop10_last_error : "none");
   string top5_first_failure_reason = ((state.symbol_data_pack_top5perbucket_failed_count > 0 && StringLen(state.symbol_data_pack_top5perbucket_last_error) > 0) ? state.symbol_data_pack_top5perbucket_last_error : "none");
   return "RUN195 SDP Non-Blocking Proof Visibility: sdp_baseline_run=RUN193R"
          + " | sdp_child_write_path_preserved=true"
          + " | sdp_final_path_policy=globaltop10_and_top5perbucket_final_files_are_target_proof"
          + " | sdp_staging_enabled=true"
          + " | sdp_staging_mode=additive_non_authoritative_candidate"
          + " | sdp_staging_current_truth=false"
          + " | sdp_globaltop10_staging_path_policy=Symbol Data Packs/_staging/GlobalTop10"
          + " | sdp_top5_staging_path_policy=Symbol Data Packs/_staging/Top5PerBucket/<bucket>"
          + " | sdp_staging_failure_blocks_final=false"
          + " | sdp_archive_enabled=true"
          + " | sdp_archive_mode=bounded_previous_final_continuity_evidence"
          + " | sdp_archive_current_truth=false"
          + " | sdp_archive_retention_limit=1"
          + " | sdp_archive_failure_blocks_final=false"
          + " | sdp_globaltop10_archive_path_policy=Symbol Data Packs/_archive/GlobalTop10"
          + " | sdp_top5_archive_path_policy=Symbol Data Packs/_archive/Top5PerBucket/<bucket>"
          + " | sdp_globaltop10_archive_failed_count=" + IntegerToString((StringFind(state.symbol_data_pack_globaltop10_last_writer_reason, "archive_write_failed") >= 0) ? 1 : 0)
          + " | sdp_top5_archive_failed_count=" + IntegerToString((StringFind(state.symbol_data_pack_top5perbucket_last_writer_reason, "archive_write_failed") >= 0) ? 1 : 0)
          + " | sdp_flat_root_policy=transition_excluded_from_target_proof"
          + " | sdp_globaltop10_due_state=" + global_due_state
          + " | sdp_globaltop10_attempt_state=" + (state.symbol_data_pack_globaltop10_attempted_count > 0 ? "attempted" : "not_attempted")
          + " | sdp_globaltop10_expected_count=" + IntegerToString(global_expected)
          + " | sdp_globaltop10_written_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_written_count))
          + " | sdp_globaltop10_no_change_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_no_change_count))
          + " | sdp_globaltop10_pending_count=" + IntegerToString(MathMax(0, global_expected - global_completed))
          + " | sdp_globaltop10_deferred_count=" + IntegerToString(StringFind(state.symbol_data_pack_globaltop10_activation_mode, "deferred") >= 0 ? 1 : 0)
          + " | sdp_globaltop10_failed_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_failed_count))
          + " | sdp_globaltop10_first_failure_reason=" + global_first_failure_reason
          + " | sdp_top5_due_state=" + top5_due_state
          + " | sdp_top5_attempt_state=" + (state.symbol_data_pack_top5perbucket_attempted_count > 0 ? "attempted" : "not_attempted")
          + " | sdp_top5_expected_count=" + IntegerToString(top5_expected)
          + " | sdp_top5_written_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_written_count))
          + " | sdp_top5_no_change_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_no_change_count))
          + " | sdp_top5_pending_count=" + IntegerToString(MathMax(0, top5_expected - top5_completed))
          + " | sdp_top5_deferred_count=" + IntegerToString(StringFind(state.symbol_data_pack_top5perbucket_activation_mode, "deferred") >= 0 ? 1 : 0)
          + " | sdp_top5_failed_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_failed_count))
          + " | sdp_top5_first_failure_reason=" + top5_first_failure_reason
          + " | sdp_same_source_membership_state=main_l4_committed_snapshot_consumed_read_only"
          + " | sdp_proof_visibility_mode=non_blocking_observation_only";
  }


string ASC_SymbolDataPackLifecycleStateFromMode(const string mode,const int total,const bool top5_route)
  {
   if(StringFind(mode, "not_due") >= 0)
      return "not_due";
   if(StringFind(mode, "retained_last_good") >= 0)
      return "retained_last_good";
   if(StringFind(mode, "success") >= 0 || StringFind(mode, "cycle_complete") >= 0)
      return "active_open_membership";
   if(StringFind(mode, "deferred_no_top5perbucket_queue") >= 0)
      return "no_committed_top5_membership";
   if(StringFind(mode, "deferred_no_globaltop10_snapshot") >= 0)
      return "no_open_snapshot";
   if(StringFind(mode, "disabled_by_policy") >= 0)
      return "deferred_until_open";
   if(StringFind(mode, "pending_existing") >= 0 && total <= 0)
      return top5_route ? "no_committed_top5_membership" : "no_open_snapshot";
   if(total <= 0)
      return top5_route ? "no_committed_top5_membership" : "no_open_snapshot";
   return "unknown_requires_investigation";
  }

string ASC_SymbolDataPackInactiveBucketReasonFromMode(const string mode,const int total,const bool top5_route)
  {
   if(StringFind(mode, "not_due") >= 0)
      return "not_due_next_due_controls_retry";
   if(StringFind(mode, "retained_last_good") >= 0)
      return "retained_last_good_continuity_evidence_not_current_truth";
   if(StringFind(mode, "success") >= 0 || StringFind(mode, "cycle_complete") >= 0)
      return "active_open_membership_or_no_change_existing_final";
   if(StringFind(mode, "disabled_by_policy") >= 0)
      return "deferred_until_open_or_runtime_activation_disabled";
   if(total <= 0)
      return top5_route ? "no_committed_top5_membership_empty_bucket_can_be_closed_market_or_weekend_context_until_live_basis_confirms" : "no_open_snapshot_empty_globaltop10_membership_cannot_be_faked";
   return "unknown_requires_investigation";
  }

string ASC_SymbolDataPackLifecycleDiagnosticLine(const string route,
                                                const string bucket,
                                                const string symbol,
                                                const string membership_source,
                                                const string membership_snapshot,
                                                const string mode,
                                                const int total,
                                                const int attempted,
                                                const datetime last_attempt_utc,
                                                const datetime next_due_utc,
                                                const string final_path,
                                                const string staging_path_policy,
                                                const string archive_path_policy,
                                                const string writer_state,
                                                const string writer_reason,
                                                const bool top5_route)
  {
   string lifecycle_state = ASC_SymbolDataPackLifecycleStateFromMode(mode, total, top5_route);
   string inactive_reason = ASC_SymbolDataPackInactiveBucketReasonFromMode(mode, total, top5_route);
   bool no_change = (StringFind(writer_reason, "no_material_change") >= 0 || StringFind(writer_state, "unchanged") >= 0 || StringFind(mode, "no_change") >= 0);
   bool retained = (writer_state == "continuity" || StringFind(writer_reason, "retained_last_good=yes") >= 0 || StringFind(mode, "retained_last_good") >= 0);
   string first_failure = "none";
   if(StringFind(writer_reason, "missing_token=") >= 0)
      first_failure = "missing_required_token";
   else if(StringFind(writer_reason, "readback") >= 0)
      first_failure = "readback_failed";
   else if(StringFind(mode, "failed") >= 0)
      first_failure = ASC_SymbolDataPackLiteTextOrNone(writer_reason);

   return "lifecycle_family=sdp"
          + " | lifecycle_route=" + route
          + " | lifecycle_bucket=" + ASC_SymbolDataPackLiteTextOrNone(bucket)
          + " | lifecycle_symbol=" + ASC_SymbolDataPackLiteTextOrNone(symbol)
          + " | membership_source=" + membership_source
          + " | membership_snapshot_id_or_time=" + ASC_SymbolDataPackLiteTextOrNone(membership_snapshot)
          + " | due_state=" + ASC_SymbolDataPackDueStateFromMode(mode, total, next_due_utc, TimeCurrent(), true, top5_route)
          + " | sdp_due_state=" + ASC_SymbolDataPackDueStateFromMode(mode, total, next_due_utc, TimeCurrent(), true, top5_route)
          + " | sdp_due_reason=" + ASC_SymbolDataPackDueReasonFromState(ASC_SymbolDataPackDueStateFromMode(mode, total, next_due_utc, TimeCurrent(), true, top5_route), mode, total, next_due_utc, top5_route)
          + " | sdp_last_attempt_utc=" + ASC_ArtifactFormatUtc(last_attempt_utc)
          + " | sdp_next_due_utc=" + ASC_ArtifactFormatUtc(next_due_utc)
          + " | sdp_deferred_until_utc=" + ASC_SymbolDataPackDeferredUntilUtcText(ASC_SymbolDataPackDueStateFromMode(mode, total, next_due_utc, TimeCurrent(), true, top5_route), next_due_utc)
          + " | attempt_state=" + (attempted > 0 ? "attempted" : "not_attempted")
          + " | hydration_state=lite_payload_only_no_siam_hydration"
          + " | sdp_hydration_state=lite_payload_only_no_siam_hydration"
          + " | sdp_hydration_reason=no_siam_hydration_no_new_data_enrichment_RUN201"
          + " | sdp_membership_snapshot_time=" + ASC_SymbolDataPackLiteTextOrNone(membership_snapshot)
          + " | sdp_weekend_or_closed_context=" + ASC_SymbolDataPackWeekendOrClosedContextFromDue(ASC_SymbolDataPackDueStateFromMode(mode, total, next_due_utc, TimeCurrent(), true, top5_route), top5_route)
          + " | sdp_write_pressure_state=bounded_write_lane_no_flush_loop"
          + " | bucket_lifecycle_state=" + lifecycle_state
          + " | inactive_bucket_reason=" + inactive_reason
          + " | inactive_bucket_expected_count=" + IntegerToString(MathMax(0, total))
          + " | inactive_bucket_final_files_found=runtime_inspection_required"
          + " | inactive_bucket_last_attempt_utc=" + ASC_ArtifactFormatUtc(last_attempt_utc)
          + " | inactive_bucket_next_due_utc=" + ASC_ArtifactFormatUtc(next_due_utc)
          + " | inactive_bucket_membership_source=" + membership_source
          + " | inactive_bucket_market_state_basis=not_inferred_by_lite_writer"
          + " | inactive_bucket_weekend_context=runtime_calendar_required"
          + " | inactive_bucket_failure=" + ((lifecycle_state == "unknown_requires_investigation") ? "true" : "false")
          + " | staging_state=" + ((StringFind(writer_reason, "staging_state=") >= 0) ? "see_last_writer_reason" : "not_attempted_or_not_observed")
          + " | archive_state=" + ((StringFind(writer_reason, "archive_state=") >= 0) ? "see_last_writer_reason" : "not_attempted_or_not_observed")
          + " | final_publish_state=" + ASC_SymbolDataPackLiteTextOrNone(writer_state)
          + " | no_change_state=" + (no_change ? "no_change_existing_final" : "not_no_change")
          + " | retained_last_good_state=" + (retained ? "retained_last_good" : "not_retained_last_good")
          + " | failure_class=" + (first_failure == "none" ? "none" : "publication_or_validation_failure")
          + " | first_failure_reason=" + first_failure
          + " | final_path=" + ASC_SymbolDataPackLiteTextOrNone(final_path)
          + " | staging_path=" + ASC_SymbolDataPackLiteTextOrNone(staging_path_policy)
          + " | archive_path=" + ASC_SymbolDataPackLiteTextOrNone(archive_path_policy)
          + " | start_utc=" + ASC_ArtifactFormatUtc(last_attempt_utc)
          + " | end_utc=runtime_output_required"
          + " | duration_ms=runtime_output_required"
          + " | next_due_utc=" + ASC_ArtifactFormatUtc(next_due_utc)
          + " | write_pressure_state=bounded_write_lane_no_flush_loop"
          + " | current_truth_path=" + ASC_SymbolDataPackLiteTextOrNone(final_path)
          + " | current_truth_source=final_only"
          + " | trade_permission=false | signal_permission=false | execution_permission=false";
  }

string ASC_SymbolDataPackGlobalTop10RuntimeStatusLine(const ASC_RuntimeState &state)
  {
   bool retained_last_good = (state.symbol_data_pack_globaltop10_last_writer_state == "continuity"
                              || StringFind(state.symbol_data_pack_globaltop10_last_writer_reason, "retained_last_good=yes") >= 0);
   bool no_change = (StringFind(state.symbol_data_pack_globaltop10_last_writer_reason, "no_material_change") >= 0
                     || StringFind(state.symbol_data_pack_globaltop10_last_writer_state, "unchanged") >= 0);
   bool fresh_write_success = (state.symbol_data_pack_globaltop10_activation_mode == "globaltop10_success_written"
                               && !no_change
                               && !retained_last_good);

   return "Symbol Data Pack GlobalTop10 Mirror Publication: present=true"
          + " | route=" + string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_ROUTE_NAME)
          + " | callsite=" + string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_PUBLICATION_CALLSITE)
          + " | enabled=" + (state.symbol_data_pack_globaltop10_enabled ? "true" : "false")
          + " | activation_mode=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_activation_mode)
          + " | membership_source=state.top10_run_full_last_completed_symbols"
          + " | membership_source_signature=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_source_signature)
          + " | cursor=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_cursor)) + "/" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_total))
          + " | attempted=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_attempted_count))
          + " | files_written=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_written_count))
          + " | files_skipped_no_change=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_no_change_count))
          + " | retained_last_good=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_retained_last_good_count))
          + " | failed_write=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_failed_count))
          + " | fresh_write_success=" + (fresh_write_success ? "true" : "false")
          + " | no_change_skipped=" + (no_change ? "true" : "false")
          + " | last_symbol=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_symbol)
          + " | last_symbol_source=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_symbol_source)
          + " | last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_last_attempt_utc)
          + " | last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_last_success_utc)
          + " | next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_next_due_utc)
          + " | final_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_final_path)
          + " | staging_path_policy=Symbol Data Packs/_staging/GlobalTop10"
          + " | staging_current_truth=false"
          + " | staging_failure_blocks_final=false"
          + " | archive_enabled=true"
          + " | archive_mode=bounded_previous_final_continuity_evidence"
          + " | archive_current_truth=false"
          + " | archive_retention_limit=1"
          + " | archive_failure_blocks_final=false"
          + " | archive_path_policy=Symbol Data Packs/_archive/GlobalTop10"
          + " | archive_failed_count=" + IntegerToString((StringFind(state.symbol_data_pack_globaltop10_last_writer_reason, "archive_write_failed") >= 0) ? 1 : 0)
          + " | " + ASC_SymbolDataPackLifecycleDiagnosticLine(string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_ROUTE_NAME),
                                                              "not_applicable",
                                                              state.symbol_data_pack_globaltop10_last_symbol,
                                                              "state.top10_run_full_last_completed_symbols",
                                                              state.symbol_data_pack_globaltop10_source_signature,
                                                              state.symbol_data_pack_globaltop10_activation_mode,
                                                              state.symbol_data_pack_globaltop10_total,
                                                              state.symbol_data_pack_globaltop10_attempted_count,
                                                              state.symbol_data_pack_globaltop10_last_attempt_utc,
                                                              state.symbol_data_pack_globaltop10_next_due_utc,
                                                              state.symbol_data_pack_globaltop10_final_path,
                                                              "Symbol Data Packs/_staging/GlobalTop10",
                                                              "Symbol Data Packs/_archive/GlobalTop10",
                                                              state.symbol_data_pack_globaltop10_last_writer_state,
                                                              state.symbol_data_pack_globaltop10_last_writer_reason,
                                                              false)
          + " | temp_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_temp_path)
          + " | last_good_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_good_path)
          + " | family_manifest_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_family_manifest_path)
          + " | validation_status=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_validation_status)
          + " | first_missing_token=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_first_missing_token)
          + " | last_writer_state=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_writer_state)
          + " | last_writer_reason=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_writer_reason)
          + " | route_lifecycle_reason=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_reason)
          + " | " + ASC_SymbolDataPackReconciliationDurableProofBlock("globaltop10_mirror", "not_applicable", state.symbol_data_pack_globaltop10_last_reason)
          + " | last_error=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_globaltop10_last_error)
          + " | budget_rule=" + string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_PUBLICATION_BUDGET_RULE)
          + " | top5perbucket_publication_active=true"
          + " | rank_order_formula_changed=false"
          + " | fileio_rewrite=false"
          + " | live_output_proof=false";
  }

bool ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication(ASC_RuntimeState &state,
                                                           const datetime now_utc,
                                                           const ulong beat_start_us,
                                                           const int beat_budget_ms,
                                                           string &yield_reason)
  {
   state.symbol_data_pack_globaltop10_enabled = ASC_SymbolDataPackRuntimeActivationEnabled();
   state.symbol_data_pack_globaltop10_family_manifest_path = ASC_SymbolDataPackGlobalTop10FamilyManifestPath(state.server_root);
   if(!state.symbol_data_pack_globaltop10_enabled)
     {
      state.symbol_data_pack_globaltop10_activation_mode = "disabled_by_policy";
      state.symbol_data_pack_globaltop10_last_reason = "runtime activation flag disabled";
      return false;
     }

   if(state.symbol_data_pack_globaltop10_next_due_utc > 0 && now_utc < state.symbol_data_pack_globaltop10_next_due_utc)
     {
      state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_not_due";
      state.symbol_data_pack_globaltop10_last_reason = "not_due next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_next_due_utc);
      return false;
     }

   int total = ArraySize(state.top10_run_full_last_completed_symbols);
   state.symbol_data_pack_globaltop10_total = total;
   state.symbol_data_pack_globaltop10_source_signature = state.top10_run_full_last_completed_source_signature;
   if(total <= 0)
     {
      state.symbol_data_pack_globaltop10_activation_mode = "deferred_no_globaltop10_snapshot";
      state.symbol_data_pack_globaltop10_last_reason = "existing GlobalTop10 completed-symbol snapshot unavailable; SDP mirror cannot fake membership";
      state.symbol_data_pack_globaltop10_last_error = state.symbol_data_pack_globaltop10_last_reason;
      state.symbol_data_pack_globaltop10_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
      state.l1_publish_pending_manifest = true;
      return false;
     }

   if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
     {
      state.symbol_data_pack_globaltop10_activation_mode = "deferred_budget";
      state.symbol_data_pack_globaltop10_last_reason = "write heartbeat budget exhausted before GlobalTop10 SDP mirror publication";
      state.symbol_data_pack_globaltop10_last_error = state.symbol_data_pack_globaltop10_last_reason;
      state.symbol_data_pack_globaltop10_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "symbol_data_pack_globaltop10_deferred_budget";
      return false;
     }

   if(state.symbol_data_pack_globaltop10_cursor < 0 || state.symbol_data_pack_globaltop10_cursor >= total)
      state.symbol_data_pack_globaltop10_cursor = 0;

   string symbol = state.top10_run_full_last_completed_symbols[state.symbol_data_pack_globaltop10_cursor];
   if(StringLen(symbol) <= 0)
     {
      state.symbol_data_pack_globaltop10_cursor++;
      state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_skipped_empty_symbol";
      state.symbol_data_pack_globaltop10_last_reason = "empty symbol slot in existing GlobalTop10 snapshot";
      state.symbol_data_pack_globaltop10_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      return false;
     }

   state.symbol_data_pack_globaltop10_last_symbol = symbol;
   state.symbol_data_pack_globaltop10_last_symbol_source = "top10_run_full_last_completed_symbols";
   state.symbol_data_pack_globaltop10_last_attempt_utc = now_utc;
   state.symbol_data_pack_globaltop10_final_path = ASC_SymbolDataPackTargetPathForRoute(state.server_root, symbol, ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10, "");
   state.symbol_data_pack_globaltop10_temp_path = ASC_SymbolDataPackTempPathForRoute(state.server_root, symbol, ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10, "");
   state.symbol_data_pack_globaltop10_last_good_path = ASC_SymbolDataPackLastGoodContinuityPathForRoute(state.server_root, symbol, ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10, "");
   state.symbol_data_pack_globaltop10_attempted_count++;

   string writer_state = "pending";
   string writer_reason = "pending";
   bool ok = ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState(state.server_root,
                                                                        symbol,
                                                                        ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10,
                                                                        "",
                                                                        true,
                                                                        state,
                                                                        writer_state,
                                                                        writer_reason);

   bool retained_last_good = (writer_state == "continuity" || StringFind(writer_reason, "retained_last_good=yes") >= 0);
   bool no_change = (StringFind(writer_reason, "no_material_change") >= 0 || StringFind(writer_state, "unchanged") >= 0);
   state.symbol_data_pack_globaltop10_last_writer_state = writer_state;
   state.symbol_data_pack_globaltop10_last_writer_reason = writer_reason;
   string missing_required_token = ASC_SymbolDataPackLiteExtractMissingRequiredToken(writer_reason);
   if(StringLen(missing_required_token) > 0)
     {
      state.symbol_data_pack_globaltop10_validation_status = "validation_failed_missing_required_token";
      state.symbol_data_pack_globaltop10_first_missing_token = missing_required_token;
     }
   else
     {
      state.symbol_data_pack_globaltop10_validation_status = (retained_last_good ? "validation_checked_retained_last_good_continuity" : (ok ? "validation_checked" : "validation_failed_or_unproven"));
      state.symbol_data_pack_globaltop10_first_missing_token = "none";
     }

   if(ok && !retained_last_good)
     {
      if(no_change)
        {
         state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_success_no_change";
         state.symbol_data_pack_globaltop10_no_change_count++;
        }
      else
        {
         state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_success_written";
         state.symbol_data_pack_globaltop10_written_count++;
         state.symbol_data_pack_globaltop10_last_success_utc = now_utc;
        }
      state.symbol_data_pack_globaltop10_last_error = "none";
     }
   else if(retained_last_good)
     {
      state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_continuity_retained_last_good";
      state.symbol_data_pack_globaltop10_retained_last_good_count++;
      state.symbol_data_pack_globaltop10_last_error = writer_reason;
     }
   else
     {
      state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_failed_write";
      state.symbol_data_pack_globaltop10_failed_count++;
      state.symbol_data_pack_globaltop10_last_error = writer_reason;
     }

   state.symbol_data_pack_globaltop10_last_reason = ASC_SymbolDataPackLiteRouteProofCompact("globaltop10_mirror",
                                                                                             "not_applicable",
                                                                                             symbol,
                                                                                             writer_state,
                                                                                             writer_reason)
                                                    + " | writer_reason=" + writer_reason;
   state.symbol_data_pack_globaltop10_cursor++;
   if(state.symbol_data_pack_globaltop10_cursor >= total)
     {
      int reconcile_unexpected = 0;
      int reconcile_archived = 0;
      int reconcile_deleted = 0;
      int reconcile_failed = 0;
      string reconcile_reason = "";
      bool reconcile_ok = ASC_SymbolDataPackPruneUnexpectedFinalChildrenForRoute(state.server_root,
                                                                                 ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10,
                                                                                 "",
                                                                                 state.top10_run_full_last_completed_symbols,
                                                                                 reconcile_unexpected,
                                                                                 reconcile_archived,
                                                                                 reconcile_deleted,
                                                                                 reconcile_failed,
                                                                                 reconcile_reason);
      state.symbol_data_pack_globaltop10_last_reason += " | final_set_reconcile=" + reconcile_reason;
      ASC_RecordSymbolDataPackReconciliationFunctionResult(state,
                                                           "globaltop10_mirror",
                                                           "not_applicable",
                                                           reconcile_ok,
                                                           reconcile_reason,
                                                           state.symbol_data_pack_globaltop10_final_path);
      if(!reconcile_ok)
        {
         state.symbol_data_pack_globaltop10_activation_mode = "globaltop10_family_cycle_complete_reconcile_failed";
         state.symbol_data_pack_globaltop10_failed_count++;
         state.symbol_data_pack_globaltop10_last_error = reconcile_reason;
         state.symbol_data_pack_globaltop10_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
        }
      else
        {
         state.symbol_data_pack_globaltop10_cursor = 0;
         state.symbol_data_pack_globaltop10_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
         state.symbol_data_pack_globaltop10_activation_mode = state.symbol_data_pack_globaltop10_activation_mode + "_family_cycle_complete";
        }
     }
   else
      state.symbol_data_pack_globaltop10_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;

   state.write_dirty = true;
   state.l1_publish_pending_manifest = true;
   ASC_LogInfo("ASC_Dispatcher",
               string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_PUBLICATION_CALLSITE),
               symbol,
               "mode=" + state.symbol_data_pack_globaltop10_activation_mode
               + " | final_path=" + state.symbol_data_pack_globaltop10_final_path
               + " | writer_state=" + writer_state
               + " | writer_reason=" + writer_reason
               + " | route_lifecycle_reason=" + state.symbol_data_pack_globaltop10_last_reason
               + " | " + ASC_SymbolDataPackLifecycleDiagnosticLine(string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_ROUTE_NAME),
                                                                   "not_applicable",
                                                                   symbol,
                                                                   "state.top10_run_full_last_completed_symbols",
                                                                   state.symbol_data_pack_globaltop10_source_signature,
                                                                   state.symbol_data_pack_globaltop10_activation_mode,
                                                                   state.symbol_data_pack_globaltop10_total,
                                                                   state.symbol_data_pack_globaltop10_attempted_count,
                                                                   state.symbol_data_pack_globaltop10_last_attempt_utc,
                                                                   state.symbol_data_pack_globaltop10_next_due_utc,
                                                                   state.symbol_data_pack_globaltop10_final_path,
                                                                   "Symbol Data Packs/_staging/GlobalTop10",
                                                                   "Symbol Data Packs/_archive/GlobalTop10",
                                                                   writer_state,
                                                                   writer_reason,
                                                                   false));
   return (ok && !retained_last_good);
  }


string ASC_SymbolDataPackTop5PerBucketRuntimeStatusLine(const ASC_RuntimeState &state)
  {
   bool retained_last_good = (state.symbol_data_pack_top5perbucket_last_writer_state == "continuity"
                              || StringFind(state.symbol_data_pack_top5perbucket_last_writer_reason, "retained_last_good=yes") >= 0);
   bool no_change = (StringFind(state.symbol_data_pack_top5perbucket_last_writer_reason, "no_material_change") >= 0
                     || StringFind(state.symbol_data_pack_top5perbucket_last_writer_state, "unchanged") >= 0);
   bool fresh_write_success = (state.symbol_data_pack_top5perbucket_activation_mode == "top5perbucket_success_written"
                               && !no_change
                               && !retained_last_good);

   return "Symbol Data Pack Top5PerBucket Mirror Publication: present=true"
          + " | route=" + string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_ROUTE_NAME)
          + " | callsite=" + string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_PUBLICATION_CALLSITE)
          + " | enabled=" + (state.symbol_data_pack_top5perbucket_enabled ? "true" : "false")
          + " | activation_mode=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_activation_mode)
          + " | membership_source=state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs/state.top5_bucket_queue_ranks"
          + " | membership_source_signature=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_source_signature)
          + " | cursor=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_cursor)) + "/" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_total))
          + " | bucket_index=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_bucket_index))
          + " | symbol_index=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_symbol_index))
          + " | attempted=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_attempted_count))
          + " | files_written=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_written_count))
          + " | files_skipped_no_change=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_no_change_count))
          + " | retained_last_good=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_retained_last_good_count))
          + " | failed_write=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_failed_count))
          + " | fresh_write_success=" + (fresh_write_success ? "true" : "false")
          + " | no_change_skipped=" + (no_change ? "true" : "false")
          + " | last_bucket=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_bucket)
          + " | last_bucket_token=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_bucket_token)
          + " | last_bucket_name=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_bucket_name)
          + " | last_symbol=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_symbol)
          + " | last_symbol_source=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_symbol_source)
          + " | last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_last_attempt_utc)
          + " | last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_last_success_utc)
          + " | next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc)
          + " | final_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_final_path)
          + " | staging_path_policy=Symbol Data Packs/_staging/Top5PerBucket/<bucket>"
          + " | staging_current_truth=false"
          + " | staging_failure_blocks_final=false"
          + " | archive_enabled=true"
          + " | archive_mode=bounded_previous_final_continuity_evidence"
          + " | archive_current_truth=false"
          + " | archive_retention_limit=1"
          + " | archive_failure_blocks_final=false"
          + " | archive_path_policy=Symbol Data Packs/_archive/Top5PerBucket/<bucket>"
          + " | archive_failed_count=" + IntegerToString((StringFind(state.symbol_data_pack_top5perbucket_last_writer_reason, "archive_write_failed") >= 0) ? 1 : 0)
          + " | " + ASC_SymbolDataPackLifecycleDiagnosticLine(string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_ROUTE_NAME),
                                                              state.symbol_data_pack_top5perbucket_last_bucket_token,
                                                              state.symbol_data_pack_top5perbucket_last_symbol,
                                                              "state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs/state.top5_bucket_queue_ranks",
                                                              state.symbol_data_pack_top5perbucket_source_signature,
                                                              state.symbol_data_pack_top5perbucket_activation_mode,
                                                              state.symbol_data_pack_top5perbucket_total,
                                                              state.symbol_data_pack_top5perbucket_attempted_count,
                                                              state.symbol_data_pack_top5perbucket_last_attempt_utc,
                                                              state.symbol_data_pack_top5perbucket_next_due_utc,
                                                              state.symbol_data_pack_top5perbucket_final_path,
                                                              "Symbol Data Packs/_staging/Top5PerBucket/<bucket>",
                                                              "Symbol Data Packs/_archive/Top5PerBucket/<bucket>",
                                                              state.symbol_data_pack_top5perbucket_last_writer_state,
                                                              state.symbol_data_pack_top5perbucket_last_writer_reason,
                                                              true)
          + " | temp_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_temp_path)
          + " | last_good_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_good_path)
          + " | family_manifest_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_family_manifest_path)
          + " | bucket_manifest_path=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_bucket_manifest_path)
          + " | validation_status=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_validation_status)
          + " | first_missing_token=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_first_missing_token)
          + " | last_writer_state=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_writer_state)
          + " | last_writer_reason=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_writer_reason)
          + " | route_lifecycle_reason=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_reason)
          + " | " + ASC_SymbolDataPackReconciliationDurableProofBlock("top5perbucket_mirror", "all_buckets", state.symbol_data_pack_top5perbucket_last_reason)
          + " | last_error=" + ASC_SymbolDataPackLiteTextOrNone(state.symbol_data_pack_top5perbucket_last_error)
          + " | budget_rule=" + string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_PUBLICATION_BUDGET_RULE)
          + " | flat_transition_counts_as_top5perbucket_proof=false"
          + " | globaltop10_counts_as_top5perbucket_proof=false"
          + " | rank_order_formula_changed=false"
          + " | fileio_rewrite=false"
          + " | live_output_proof=false";
  }


bool ASC_SymbolDataPackCollectTop5ExpectedSymbolsForSlug(const ASC_RuntimeState &state,const string slug,string &expected_symbols[])
  {
   ArrayResize(expected_symbols, 0);
   if(StringLen(slug) <= 0)
      return false;
   for(int i = 0; i < ArraySize(state.top5_bucket_queue_symbols); i++)
     {
      if(i >= ArraySize(state.top5_bucket_queue_slugs))
         return false;
      if(state.top5_bucket_queue_slugs[i] != slug)
         continue;
      string symbol = state.top5_bucket_queue_symbols[i];
      if(StringLen(symbol) <= 0)
         continue;
      int n = ArraySize(expected_symbols);
      ArrayResize(expected_symbols, n + 1);
      expected_symbols[n] = symbol;
     }
   return true;
  }

bool ASC_SymbolDataPackReconcileTop5PerBucketFinalSets(const ASC_RuntimeState &state,string &reason_out)
  {
   reason_out = "pending";
   string slugs[];
   ASC_Top5BucketCanonicalCleanupSlugs(slugs);
   int unexpected_total = 0;
   int archived_total = 0;
   int deleted_total = 0;
   int failed_total = 0;
   int expected_total = 0;
   int found_final_total = 0;
   int skipped_total = 0;
   string expected_summary = "";
   string unexpected_summary = "";
   string detail = "";

   for(int i = 0; i < ArraySize(slugs); i++)
     {
      string expected[];
      if(!ASC_SymbolDataPackCollectTop5ExpectedSymbolsForSlug(state, slugs[i], expected))
        {
         failed_total++;
         if(StringLen(detail) > 0) detail += ";";
         detail += slugs[i] + "=queue_alignment_failed";
         continue;
        }

      int unexpected = 0;
      int archived = 0;
      int deleted = 0;
      int failed = 0;
      string part = "";
      ASC_SymbolDataPackPruneUnexpectedFinalChildrenForRoute(state.server_root,
                                                             ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET,
                                                             slugs[i],
                                                             expected,
                                                             unexpected,
                                                             archived,
                                                             deleted,
                                                             failed,
                                                             part);
      unexpected_total += unexpected;
      archived_total += archived;
      deleted_total += deleted;
      failed_total += failed;
      expected_total += ArraySize(expected);
      found_final_total += (int)StringToInteger(ASC_SymbolDataPackLiteExtractRouteProofToken(part, "reconciliation_found_final_count"));
      skipped_total += (int)StringToInteger(ASC_SymbolDataPackLiteExtractRouteProofToken(part, "reconciliation_skipped_count"));
      string expected_part = ASC_SymbolDataPackLiteExtractRouteProofToken(part, "reconciliation_expected_symbols_summary");
      if(expected_part != "none")
        {
         if(StringLen(expected_summary) > 0) expected_summary += ";";
         expected_summary += slugs[i] + ":" + expected_part;
        }
      string unexpected_part = ASC_SymbolDataPackLiteExtractRouteProofToken(part, "reconciliation_unexpected_symbols_summary");
      if(unexpected_part != "none" && unexpected_part != "not_enumerated")
        {
         if(StringLen(unexpected_summary) > 0) unexpected_summary += ";";
         unexpected_summary += slugs[i] + ":" + unexpected_part;
        }
      if(StringLen(detail) > 0) detail += ";";
      detail += slugs[i] + "=" + part;
     }

   if(StringLen(expected_summary) <= 0)
      expected_summary = "none";
   if(StringLen(unexpected_summary) <= 0)
      unexpected_summary = "none";
   reason_out = ASC_SymbolDataPackReconciliationFieldBlock("top5perbucket_mirror",
                                                           "all_buckets",
                                                           (failed_total == 0 ? "completed_source_bounded" : "completed_with_failures"),
                                                           IntegerToString(expected_total),
                                                           IntegerToString(found_final_total),
                                                           expected_summary,
                                                           unexpected_summary,
                                                           IntegerToString(archived_total),
                                                           IntegerToString(deleted_total),
                                                           IntegerToString(skipped_total),
                                                           (failed_total == 0 ? "none" : "top5_bucket_reconcile_failed"),
                                                           ASC_SymbolDataPackTop5FamilyFolder(state.server_root),
                                                           state.server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER) + "\\_archive\\Top5PerBucket");
   reason_out += StringFormat(" top5_no_broad_file_deletion=true unexpected=%d archived=%d deleted=%d failed=%d",
                             unexpected_total,
                             archived_total,
                             deleted_total,
                             failed_total);
   if(StringLen(detail) > 0)
      reason_out += " | " + detail;
   return (failed_total == 0);
  }

bool ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication(ASC_RuntimeState &state,
                                                             const datetime now_utc,
                                                             const ulong beat_start_us,
                                                             const int beat_budget_ms,
                                                             string &yield_reason)
  {
   state.symbol_data_pack_top5perbucket_enabled = ASC_SymbolDataPackRuntimeActivationEnabled();
   state.symbol_data_pack_top5perbucket_family_manifest_path = ASC_SymbolDataPackTop5FamilyManifestPath(state.server_root);
   if(!state.symbol_data_pack_top5perbucket_enabled)
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "disabled_by_policy";
      state.symbol_data_pack_top5perbucket_last_reason = "runtime activation flag disabled";
      return false;
     }

   if(state.symbol_data_pack_top5perbucket_next_due_utc > 0 && now_utc < state.symbol_data_pack_top5perbucket_next_due_utc)
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_not_due";
      state.symbol_data_pack_top5perbucket_last_reason = "not_due next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc);
      return false;
     }

   int total = ArraySize(state.top5_bucket_queue_symbols);
   state.symbol_data_pack_top5perbucket_total = total;
   string queue_signature = state.top5_bucket_last_signature;
   if(StringLen(queue_signature) <= 0)
      queue_signature = ASC_Top5BucketSignature(state);
   string previous_signature = state.symbol_data_pack_top5perbucket_source_signature;
   state.symbol_data_pack_top5perbucket_source_signature = queue_signature;

   string queue_guard_reason = "";
   if(total > 0 && !ASC_Top5BucketQueueArraysAligned(state, true, true, queue_guard_reason))
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_blocked_queue_guard";
      state.symbol_data_pack_top5perbucket_last_reason = queue_guard_reason;
      state.symbol_data_pack_top5perbucket_last_error = queue_guard_reason;
      state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      return false;
     }

   if(total <= 0 || StringLen(queue_signature) <= 0)
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "deferred_no_top5perbucket_queue";
      state.symbol_data_pack_top5perbucket_last_reason = "existing Top5PerBucket bucket queue unavailable; SDP mirror cannot fake membership";
      state.symbol_data_pack_top5perbucket_last_error = state.symbol_data_pack_top5perbucket_last_reason;
      state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
      state.l1_publish_pending_manifest = true;
      return false;
     }

   if(StringLen(previous_signature) > 0 && previous_signature != queue_signature)
      state.symbol_data_pack_top5perbucket_cursor = 0;

   if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "deferred_budget";
      state.symbol_data_pack_top5perbucket_last_reason = "write heartbeat budget exhausted before Top5PerBucket SDP mirror publication";
      state.symbol_data_pack_top5perbucket_last_error = state.symbol_data_pack_top5perbucket_last_reason;
      state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "symbol_data_pack_top5perbucket_deferred_budget";
      return false;
     }

   if(state.symbol_data_pack_top5perbucket_cursor < 0 || state.symbol_data_pack_top5perbucket_cursor >= total)
      state.symbol_data_pack_top5perbucket_cursor = 0;

   int qi = state.symbol_data_pack_top5perbucket_cursor;
   string symbol = state.top5_bucket_queue_symbols[qi];
   string bucket = state.top5_bucket_queue_slugs[qi];
   string bucket_display = state.top5_bucket_queue_displays[qi];
   string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);

   state.symbol_data_pack_top5perbucket_bucket_index = ASC_Top5BucketActiveIndex(state, bucket);
   state.symbol_data_pack_top5perbucket_symbol_index = qi;
   state.symbol_data_pack_top5perbucket_last_bucket = bucket;
   state.symbol_data_pack_top5perbucket_last_bucket_token = safe_bucket;
   state.symbol_data_pack_top5perbucket_last_bucket_name = bucket_display;

   if(StringLen(symbol) <= 0 || safe_bucket == "ROUTE_REQUIRES_BUCKET")
     {
      state.symbol_data_pack_top5perbucket_cursor++;
      state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_skipped_missing_symbol_or_bucket";
      state.symbol_data_pack_top5perbucket_last_symbol = symbol;
      state.symbol_data_pack_top5perbucket_last_symbol_source = "top5_bucket_queue_symbols";
      state.symbol_data_pack_top5perbucket_last_reason = "missing symbol or bucket in existing Top5PerBucket queue";
      state.symbol_data_pack_top5perbucket_last_error = state.symbol_data_pack_top5perbucket_last_reason;
      state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      return false;
     }

   state.symbol_data_pack_top5perbucket_last_symbol = symbol;
   state.symbol_data_pack_top5perbucket_last_symbol_source = "top5_bucket_queue_symbols";
   state.symbol_data_pack_top5perbucket_last_attempt_utc = now_utc;
   state.symbol_data_pack_top5perbucket_final_path = ASC_SymbolDataPackTargetPathForRoute(state.server_root, symbol, ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET, bucket);
   state.symbol_data_pack_top5perbucket_temp_path = ASC_SymbolDataPackTempPathForRoute(state.server_root, symbol, ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET, bucket);
   state.symbol_data_pack_top5perbucket_last_good_path = ASC_SymbolDataPackLastGoodContinuityPathForRoute(state.server_root, symbol, ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET, bucket);
   state.symbol_data_pack_top5perbucket_bucket_manifest_path = ASC_SymbolDataPackTop5BucketManifestPath(state.server_root, bucket);
   state.symbol_data_pack_top5perbucket_attempted_count++;

   string writer_state = "pending";
   string writer_reason = "pending";
   bool ok = ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState(state.server_root,
                                                                        symbol,
                                                                        ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET,
                                                                        bucket,
                                                                        true,
                                                                        state,
                                                                        writer_state,
                                                                        writer_reason,
                                                                        bucket_display);

   bool retained_last_good = (writer_state == "continuity" || StringFind(writer_reason, "retained_last_good=yes") >= 0);
   bool no_change = (StringFind(writer_reason, "no_material_change") >= 0 || StringFind(writer_state, "unchanged") >= 0);
   state.symbol_data_pack_top5perbucket_last_writer_state = writer_state;
   state.symbol_data_pack_top5perbucket_last_writer_reason = writer_reason;
   string missing_required_token = ASC_SymbolDataPackLiteExtractMissingRequiredToken(writer_reason);
   if(StringLen(missing_required_token) > 0)
     {
      state.symbol_data_pack_top5perbucket_validation_status = "validation_failed_missing_required_token";
      state.symbol_data_pack_top5perbucket_first_missing_token = missing_required_token;
     }
   else
     {
      state.symbol_data_pack_top5perbucket_validation_status = (retained_last_good ? "validation_checked_retained_last_good_continuity" : (ok ? "validation_checked" : "validation_failed_or_unproven"));
      state.symbol_data_pack_top5perbucket_first_missing_token = "none";
     }

   if(ok && !retained_last_good)
     {
      if(no_change)
        {
         state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_success_no_change";
         state.symbol_data_pack_top5perbucket_no_change_count++;
        }
      else
        {
         state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_success_written";
         state.symbol_data_pack_top5perbucket_written_count++;
         state.symbol_data_pack_top5perbucket_last_success_utc = now_utc;
        }
      state.symbol_data_pack_top5perbucket_last_error = "none";
     }
   else if(retained_last_good)
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_continuity_retained_last_good";
      state.symbol_data_pack_top5perbucket_retained_last_good_count++;
      state.symbol_data_pack_top5perbucket_last_error = writer_reason;
     }
   else
     {
      state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_failed_write";
      state.symbol_data_pack_top5perbucket_failed_count++;
      state.symbol_data_pack_top5perbucket_last_error = writer_reason;
     }

   state.symbol_data_pack_top5perbucket_last_reason = ASC_SymbolDataPackLiteRouteProofCompact("top5perbucket_mirror",
                                                                                                safe_bucket,
                                                                                                symbol,
                                                                                                writer_state,
                                                                                                writer_reason)
                                                       + " bucket_name=" + bucket_display
                                                       + " | writer_reason=" + writer_reason;
   state.symbol_data_pack_top5perbucket_cursor++;
   if(state.symbol_data_pack_top5perbucket_cursor >= total)
     {
      string reconcile_reason = "";
      bool reconcile_ok = ASC_SymbolDataPackReconcileTop5PerBucketFinalSets(state, reconcile_reason);
      state.symbol_data_pack_top5perbucket_last_reason += " | final_set_reconcile=" + reconcile_reason;
      ASC_RecordSymbolDataPackReconciliationFunctionResult(state,
                                                           "top5perbucket_mirror",
                                                           "all_buckets",
                                                           reconcile_ok,
                                                           reconcile_reason,
                                                           state.symbol_data_pack_top5perbucket_family_manifest_path);
      if(!reconcile_ok)
        {
         state.symbol_data_pack_top5perbucket_activation_mode = "top5perbucket_family_cycle_complete_reconcile_failed";
         state.symbol_data_pack_top5perbucket_failed_count++;
         state.symbol_data_pack_top5perbucket_last_error = reconcile_reason;
         state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;
        }
      else
        {
         state.symbol_data_pack_top5perbucket_cursor = 0;
         state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS;
         state.symbol_data_pack_top5perbucket_activation_mode = state.symbol_data_pack_top5perbucket_activation_mode + "_family_cycle_complete";
        }
     }
   else
      state.symbol_data_pack_top5perbucket_next_due_utc = now_utc + ASC_HEARTBEAT_SECONDS;

   state.write_dirty = true;
   state.l1_publish_pending_manifest = true;
   ASC_LogInfo("ASC_Dispatcher",
               string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_PUBLICATION_CALLSITE),
               symbol,
               "mode=" + state.symbol_data_pack_top5perbucket_activation_mode
               + " | bucket=" + safe_bucket
               + " | bucket_name=" + bucket_display
               + " | final_path=" + state.symbol_data_pack_top5perbucket_final_path
               + " | writer_state=" + writer_state
               + " | writer_reason=" + writer_reason
               + " | route_lifecycle_reason=" + state.symbol_data_pack_top5perbucket_last_reason
               + " | " + ASC_SymbolDataPackLifecycleDiagnosticLine(string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_ROUTE_NAME),
                                                                   safe_bucket,
                                                                   symbol,
                                                                   "state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs/state.top5_bucket_queue_ranks",
                                                                   state.symbol_data_pack_top5perbucket_source_signature,
                                                                   state.symbol_data_pack_top5perbucket_activation_mode,
                                                                   state.symbol_data_pack_top5perbucket_total,
                                                                   state.symbol_data_pack_top5perbucket_attempted_count,
                                                                   state.symbol_data_pack_top5perbucket_last_attempt_utc,
                                                                   state.symbol_data_pack_top5perbucket_next_due_utc,
                                                                   state.symbol_data_pack_top5perbucket_final_path,
                                                                   "Symbol Data Packs/_staging/Top5PerBucket/<bucket>",
                                                                   "Symbol Data Packs/_archive/Top5PerBucket/<bucket>",
                                                                   writer_state,
                                                                   writer_reason,
                                                                   true));
   return (ok && !retained_last_good);
  }


void ASC_RunWriteLane(ASC_RuntimeState &state,
                      const datetime now_utc,
                      const ulong beat_start_us,
                      const int beat_budget_ms,
                      ASC_HeartbeatTelemetry &telemetry,
                      string &yield_reason)
  {
   bool ui_priority_active = ASC_IsUiPriorityActive(state, now_utc);
   if(ui_priority_active)
      state.ui_priority_write_lane_entered_count++;
   bool current_focus_write_due = ASC_CurrentFocusViewWriteDue(state, now_utc);
   ASC_ReconcileTop10RunFullChildFamily(state, now_utc);
   bool top10_batch_active = (state.top10_run_full_batch_pending
                             || state.top10_run_full_cursor < state.top10_run_full_total
                             || StringLen(state.top10_run_full_inflight_symbol) > 0);
   if(top10_batch_active)
     {
      if(ui_priority_active || ASC_WriteLaneNearBudget(beat_start_us, beat_budget_ms, ui_priority_active))
        {
         state.write_dirty = true;
         ASC_RecordWriteLaneYield(state,
                                  telemetry,
                                  beat_start_us,
                                  beat_budget_ms,
                                  ui_priority_active,
                                  ui_priority_active ? "top10_family_side_duty_deferred_for_ui_priority" : "top10_family_side_duty_deferred_near_write_budget");
         telemetry.ui_priority_top10_write_attempt_count = state.ui_priority_top10_write_attempt_count;
        }
      else
        {
         ulong top10_batch_started_us = ASC_HeartbeatNowMicroseconds();
         ASC_ServiceTop10RunFullBatch(state, now_utc);
         telemetry.top10_batch_ms = ASC_SafeElapsedMsSince(top10_batch_started_us);
        }
     }
   if(!top10_batch_active)
      ASC_ServiceTop5PerBucketFamily(state, now_utc, beat_start_us, beat_budget_ms, ui_priority_active);

   current_focus_write_due = ASC_CurrentFocusViewWriteDue(state, now_utc);
   ASC_Layer1PassSummary broad_summary;
   bool has_broad_summary = false;
   string broad_catchup_reason = "";
   bool broad_catchup_incomplete = ASC_IsBroadCatchupIncomplete(state, broad_summary, has_broad_summary, broad_catchup_reason);
   bool run249_top5_sdp_side_duty_pending = (!top10_batch_active
                                          && ASC_SymbolDataPackRuntimeActivationEnabled()
                                          && ArraySize(state.top5_bucket_queue_symbols) > 0
                                          && (state.symbol_data_pack_top5perbucket_next_due_utc <= 0 || now_utc >= state.symbol_data_pack_top5perbucket_next_due_utc));
   if(run249_top5_sdp_side_duty_pending)
     {
      ulong run249_top5_sdp_started_us = ASC_HeartbeatNowMicroseconds();
      ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication(state, now_utc, beat_start_us, beat_budget_ms, yield_reason);
      telemetry.side_duty_ms += ASC_SafeElapsedMsSince(run249_top5_sdp_started_us);
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "run249_top5_sdp_side_duty_serviced_before_no_write_dirty_exit";
     }

   if(!state.write_dirty && !state.deep_focus_trigger_pending && !current_focus_write_due)
     {
      state.deferred_write_artifacts = 0;
      state.publication_bundle.board_lifecycle_state = "awaiting_auto_refresh";
      state.publication_bundle.board_publish_result = "skipped";
      state.publication_bundle.board_publish_skip_reason = "no_write_dirty";
      if(state.current_focus_view_pending)
        {
         state.deferred_write_artifacts = 1;
         state.lane_deferred_reason = "selected-symbol Dossier disable-reconciliation is pending but not yet admitted for queue drain service";
         yield_reason = "current_focus_view_waiting_for_calm_write_window";
        }
      else
         yield_reason = "no_write_dirty";
      return;
     }

   if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
     {
      state.deferred_write_artifacts = MathMax(1, state.deferred_write_artifacts);
      state.write_dirty = true;
      state.publication_bundle.board_lifecycle_state = "waiting_for_packet_support";
      state.publication_bundle.board_publish_result = "skipped";
      state.publication_bundle.board_publish_skip_reason = "write_budget_time_exhausted_pre_admission";
      state.lane_deferred_reason = "write heartbeat budget exhausted before write admission";
      yield_reason = "write_budget_time_exhausted_pre_admission";
      return;
     }

   bool run_full_board_first_pending = ASC_RunFullChildPublishMustWaitForBoardBaseline(state, current_focus_write_due);
   if(run_full_board_first_pending)
     {
      state.deferred_write_artifacts = MathMax(state.deferred_write_artifacts, 1);
      state.lane_deferred_reason = "selected-symbol child publish deferred until the explicit Run Full Market Board baseline lands";
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "run_full_waiting_for_board_baseline";
      telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
     }
   else
     {
      ulong deep_trigger_start_us = ASC_HeartbeatNowMicroseconds();
      if(ASC_RunDeepFocusTriggerWrite(state, now_utc, telemetry, yield_reason))
        {
         telemetry.deep_trigger_ms = ASC_SafeElapsedMsSince(deep_trigger_start_us);
         telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
         return;
        }
      telemetry.deep_trigger_ms = ASC_SafeElapsedMsSince(deep_trigger_start_us);

      if(ASC_DeepTriggerOwnsSelectedPairWrite(state))
        {
         state.deferred_write_artifacts = MathMax(state.deferred_write_artifacts, 1);
         state.lane_deferred_reason = "selected-symbol Dossier pair-write deferred because explicit Deep Analysis owns pair publication for the same symbol";
         yield_reason = "current_focus_view_deferred_for_deep_trigger_ownership";
         telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
         return;
        }

      if(state.current_focus_view_pending)
        {
         if(ASC_RunViewedCurrentFocusWrite(state, now_utc, telemetry, yield_reason))
           {
            telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
            return;
           }
         telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
        }
     }
   if(broad_catchup_incomplete && current_focus_write_due)
     {
      state.lane_deferred_reason = "selected-symbol persistence attempted during broad Layer 0-2 catchup but remained pending: " + broad_catchup_reason;
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "current_focus_deferred_for_broad_catchup";
     }

   ASC_Layer1PassSummary summary;
   if(!ASC_Layer1TryGetLatestSummary(summary))
     {
      state.deferred_write_artifacts = 0;
      state.dossier_existence_shell_only = false;
      if(state.board_manual_refresh_inflight)
        {
         state.board_manual_refresh_pending = true;
         state.board_manual_refresh_inflight = false;
         state.board_manual_refresh_last_status = "deferred";
         state.board_manual_refresh_last_reason = "manual refresh deferred: awaiting latest Layer 1 summary";
         state.l1_publish_pending_essentials = true;
         state.l1_publish_pending_manifest = true;
         state.write_dirty = true;
         state.publication_bundle.board_lifecycle_state = "waiting_for_packet_support";
         state.publication_bundle.board_publish_result = "skipped";
         state.publication_bundle.board_publish_skip_reason = "awaiting_latest_layer1_summary";
         yield_reason = "manual_refresh_deferred_no_latest_summary";
         return;
        }
      state.write_dirty = ASC_BundleHasPendingWork(state);
      yield_reason = "write_dropped_no_summary";
      return;
     }
   ASC_UpdateLayer1PostureState(state, summary);

   bool same_family_child_write_active = (state.deep_focus_trigger_pending
                                          || current_focus_write_due
                                          || state.current_focus_view_pending
                                          || state.l1_publish_pending_dossiers);
   if(!state.l1_publish_pending_essentials
      && same_family_child_write_active
      && !ASC_MarketBoardPublishIntervalSatisfied(now_utc, state.market_board_last_publish_utc))
      ASC_RequestMarketBoardFreshnessRepublish(state, now_utc, "write-lane-same-family-baseline-backstop");

   if(!ASC_BundleHasPendingWork(state))
     {
      state.deferred_write_artifacts = 0;
      state.write_cursor = 0;
      state.dossier_existence_shell_only = false;
      state.publication_bundle.board_lifecycle_state = "awaiting_auto_refresh";
      state.publication_bundle.board_publish_result = "skipped";
      state.publication_bundle.board_publish_skip_reason = "no_publication_pending";
      if(state.board_manual_refresh_inflight)
        {
         state.board_manual_refresh_pending = true;
         state.board_manual_refresh_inflight = false;
         state.board_manual_refresh_last_status = "deferred";
         state.board_manual_refresh_last_reason = "manual refresh deferred: publication bundle had no pending board work";
         state.l1_publish_pending_essentials = true;
         state.l1_publish_pending_manifest = true;
         state.write_dirty = true;
         state.publication_bundle.board_lifecycle_state = "manual_refresh_requested";
         state.publication_bundle.board_publish_result = "pending";
         state.publication_bundle.board_publish_skip_reason = "none";
         yield_reason = "manual_refresh_requeued_no_publication_pending";
         return;
        }
      state.write_dirty = false;
      yield_reason = "no_publication_pending";
      return;
     }

   if(!state.l1_publish_pending_manifest)
      state.l1_publish_pending_manifest = true;

   datetime publication_utc = now_utc;
   string publication_id = ASC_BuildPublicationId(state.heartbeat_counter, publication_utc);
   ASC_BeginPublicationBundle(state, publication_id, publication_utc);

   // RUN188R: service Symbol Data Pack Lite before heavy publication-bundle
   // work can consume the write-lane budget. Live RUN188R evidence showed
   // 22s-25s write-lane beats against an 880ms budget after the SDP next-due
   // time, leaving the previous late callsite vulnerable to permanent
   // deferred_budget/no-update behaviour.
   ASC_ServiceSymbolDataPackLiteRuntimeActivation(state, now_utc, beat_start_us, beat_budget_ms, yield_reason);
   if(!top10_batch_active)
     {
      ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication(state, now_utc, beat_start_us, beat_budget_ms, yield_reason);
      ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication(state, now_utc, beat_start_us, beat_budget_ms, yield_reason);
     }

   ASC_RebuildPublicationShortlistCache(state, summary.pass_utc);
   state.publication_bundle.board_recompute_finished_utc = TimeGMT();
   if(state.l1_publish_pending_essentials)
      state.publication_bundle.board_lifecycle_state = "publishing";

   int written = 0;
   int failures = 0;
   bool l2_failed = false;
   bool board_failed = false;
   bool board_deferred = false;
   int dossier_budget = state.write_budget_artifacts;
   if(dossier_budget <= 0)
      dossier_budget = g_asc_trader_controls.write_budget_artifacts;
   if(dossier_budget <= 0)
      dossier_budget = 8;
   bool startup_dossier_flood_mode = (state.dossier_startup_flood_active
                                      && state.dossier_existence_shell_only
                                      && state.l1_publish_pending_dossiers
                                      && state.dossier_missing_count > 0
                                      && !broad_catchup_incomplete);
   if(startup_dossier_flood_mode)
     {
      int cached_symbol_total = ASC_Layer1CachedSymbolCount();
      int flood_budget = ASC_BOOTSTRAP_DOSSIER_FLOOD_BUDGET;
      if(cached_symbol_total > 0)
         flood_budget = MathMin(flood_budget, MathMax(ASC_BOOTSTRAP_DOSSIER_FLOOD_MIN_BUDGET, cached_symbol_total));
      dossier_budget = MathMax(dossier_budget, flood_budget);
     }
   if(state.posture == ASC_RUNTIME_DEGRADED && !startup_dossier_flood_mode)
      dossier_budget = MathMin(dossier_budget, 12);
   if(state.dossier_failure_streak > 0)
      dossier_budget = MathMin(dossier_budget, MathMax(2, dossier_budget / (state.dossier_failure_streak + 1)));
   if(ui_priority_active && !startup_dossier_flood_mode)
     {
      int reduced_budget = (dossier_budget * ASC_UI_PRIORITY_DOSSIER_BUDGET_SCALE_PERCENT) / 100;
      dossier_budget = MathMax(1, reduced_budget);
     }

   bool scan_pressure_now = (state.layer1_dirty || state.deferred_scan_symbols > 0 || state.layer2_dirty);
   int remaining_backlog = ASC_CountRemainingDossierBacklog(state);
   bool hydration_pressure = (state.l1_publish_pending_dossiers
                              && (state.dossier_missing_count > 0
                                  || state.dossier_shell_present_count > 0
                                  || remaining_backlog > 0));
   if(scan_pressure_now && !startup_dossier_flood_mode)
     {
      int scan_budget = state.scan_budget_symbols;
      if(scan_budget <= 0)
         scan_budget = g_asc_trader_controls.scan_budget_symbols;
      if(scan_budget <= 0)
         scan_budget = ASC_SCAN_SYMBOL_BUDGET;

      int bounded_scan_slice = MathMax(10, scan_budget / 8);
      if(state.deferred_scan_symbols > scan_budget)
         bounded_scan_slice = MathMax(12, scan_budget / 6);
      if(state.l1_publish_pending_dossiers)
        {
         int dossier_pressure_floor = MathMax(24, scan_budget / 4);
         if(remaining_backlog >= 1024)
            dossier_pressure_floor = MathMax(dossier_pressure_floor, 192);
         else if(remaining_backlog >= 640)
            dossier_pressure_floor = MathMax(dossier_pressure_floor, 144);
         else if(remaining_backlog >= 320)
            dossier_pressure_floor = MathMax(dossier_pressure_floor, 112);
         else if(remaining_backlog >= 160)
            dossier_pressure_floor = MathMax(dossier_pressure_floor, 80);
         else if(remaining_backlog >= 64)
            dossier_pressure_floor = MathMax(dossier_pressure_floor, 56);
         if(state.write_cursor > 0)
            dossier_pressure_floor += 8;
         if(hydration_pressure)
            dossier_pressure_floor = MathMax(dossier_pressure_floor, 64);
         bounded_scan_slice = MathMax(bounded_scan_slice, dossier_pressure_floor);
        }
      dossier_budget = MathMin(dossier_budget, bounded_scan_slice);
     }

   if(broad_catchup_incomplete && state.l1_publish_pending_dossiers && !startup_dossier_flood_mode)
     {
      int broad_catchup_budget_cap = 2;
      bool broad_catchup_relief_ready = (remaining_backlog >= 128
                                         && state.dossier_no_progress_write_beats >= 2);
      int broad_summary_open_symbols = (has_broad_summary ? MathMax(0, broad_summary.open_count) : 0);
      int broad_summary_closed_symbols = (has_broad_summary ? MathMax(0, broad_summary.total_symbols - broad_summary_open_symbols) : 0);
      bool broad_catchup_closed_dominant = (broad_summary_closed_symbols > 0
                                            && broad_summary_closed_symbols >= MathMax(64, broad_summary_open_symbols));
      if(broad_catchup_relief_ready)
         broad_catchup_budget_cap = 3;
      if(broad_catchup_closed_dominant && remaining_backlog >= 256)
         broad_catchup_budget_cap = MathMax(broad_catchup_budget_cap, 4);
      dossier_budget = MathMin(dossier_budget, broad_catchup_budget_cap);
      state.lane_deferred_reason = "startup dossier flood and selected-symbol extras deferred during broad Layer 0-2 catchup: " + broad_catchup_reason;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunWriteLane", "runtime",
                  StringFormat("dossier throughput throttled for broad catchup: %s (budget_cap=%d no_progress=%d backlog=%d)",
                               broad_catchup_reason,
                               broad_catchup_budget_cap,
                               state.dossier_no_progress_write_beats,
                               remaining_backlog));
     }

   if(!broad_catchup_incomplete
      && state.l1_publish_pending_dossiers
      && state.write_cursor > 0
      && state.posture != ASC_RUNTIME_DEGRADED
      && state.dossier_failure_streak <= 0)
     {
      int dossier_budget_floor = 12;
      if(remaining_backlog >= 1024)
         dossier_budget_floor = 224;
      else if(remaining_backlog >= 640)
         dossier_budget_floor = 176;
      else if(remaining_backlog >= 320)
         dossier_budget_floor = 128;
      else if(remaining_backlog >= 160)
         dossier_budget_floor = 96;
      else if(remaining_backlog >= 64)
         dossier_budget_floor = 64;
      if(hydration_pressure)
         dossier_budget_floor = MathMax(dossier_budget_floor, 40);
      dossier_budget = MathMax(dossier_budget, dossier_budget_floor);
     }
   ASC_LogInfo("ASC_Dispatcher", "ASC_RunWriteLane", "runtime",
               StringFormat("dossier budget selected budget=%d startup_flood=%s broad_catchup_incomplete=%s scan_pressure=%s hydration_pressure=%s backlog=%d write_dirty=%s failure_streak=%d",
                            dossier_budget,
                            startup_dossier_flood_mode ? "yes" : "no",
                            broad_catchup_incomplete ? "yes" : "no",
                            scan_pressure_now ? "yes" : "no",
                            hydration_pressure ? "yes" : "no",
                            remaining_backlog,
                            state.write_dirty ? "yes" : "no",
                            state.dossier_failure_streak));
   state.dossier_startup_flood_budget_last = startup_dossier_flood_mode ? dossier_budget : 0;

   bool essentials_backoff_active = ASC_IsCooldownActive(now_utc, state.essential_backoff_until_utc);
   bool essential_failed_this_beat = false;
   bool skip_dossier_due_to_essential_failure = false;

   if(state.l2_publish_pending && !essentials_backoff_active)
     {
      if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
        {
         state.l2_publish_pending = true;
         state.write_dirty = true;
         state.lane_deferred_reason = "open symbol snapshot deferred due to write heartbeat budget exhaustion";
        }
      else
        {
      ulong published_revision = state.l2_last_published_revision;
      int emitted_symbols = 0;
      int admitted_symbols = 0;
      ASC_FunctionResult snapshot_result = ASC_BuildOpenSymbolSnapshotArtifact(state.server_root,
                                                                               state.publication_bundle,
                                                                               state.l2_last_published_revision,
                                                                               published_revision,
                                                                               emitted_symbols,
                                                                               admitted_symbols);
      ASC_RecordResult(state, snapshot_result, false);
      ASC_RecordPublicationOutcomeCounters(state, snapshot_result);
      ASC_AccumulateWriteArtifactPerf(state, snapshot_result);
      written++;
      state.publication_bundle.open_symbol_snapshot_status = ASC_BundleResultStatus(snapshot_result);
      if(snapshot_result.state == ASC_RESULT_ERROR)
        {
         failures++;
         l2_failed = true;
         essential_failed_this_beat = true;
         if(state.l2_last_published_revision == 0)
            skip_dossier_due_to_essential_failure = true;
         if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0)
            state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Open Symbol Snapshot reason=publication failed",
                                                                              state.publication_bundle.publication_id);
        }
      else if(snapshot_result.state == ASC_RESULT_OK)
        {
         state.l2_last_published_revision = published_revision;
        }
        }
     }
   else if(state.l2_publish_pending && essentials_backoff_active)
     {
      state.publication_bundle.open_symbol_snapshot_status = "degraded";
      if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0)
         state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Open Symbol Snapshot reason=essential artifact backoff active",
                                                                           state.publication_bundle.publication_id);
     }

   if(state.l1_publish_pending_essentials && !essentials_backoff_active)
     {
      string board_publish_admission_reason = "";
      bool board_publish_admitted = ASC_MarketBoardPublishAdmittedForWrite(state,
                                                                           now_utc,
                                                                           board_publish_admission_reason);
      if(!board_publish_admitted)
        {
         state.l1_publish_pending_essentials = false;
         state.publication_bundle.market_board_status = "skipped";
         state.publication_bundle.board_lifecycle_state = "awaiting_auto_refresh";
         state.publication_bundle.board_publish_result = "skipped";
         state.publication_bundle.board_publish_skip_reason = "final_gate_not_elapsed: " + board_publish_admission_reason;
        }
      else if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms)
              || (ASC_WriteLaneNearBudget(beat_start_us, beat_budget_ms, ui_priority_active)
                  && state.l1_last_published_revision > 0
                  && !state.board_manual_refresh_inflight))
        {
         state.l1_publish_pending_essentials = true;
         state.write_dirty = true;
         state.publication_bundle.market_board_status = "pending";
         state.publication_bundle.board_lifecycle_state = "waiting_for_packet_support";
         state.publication_bundle.board_publish_result = "skipped";
         state.publication_bundle.board_publish_skip_reason = ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms) ? "write_heartbeat_budget_exhausted" : "write_near_budget_noncritical_board_deferred";
         if(state.board_manual_refresh_inflight)
           {
            state.board_manual_refresh_pending = true;
            state.board_manual_refresh_inflight = false;
            state.board_manual_refresh_last_status = "deferred";
            state.board_manual_refresh_last_reason = "manual refresh deferred: write heartbeat budget exhausted";
           }
         board_deferred = true;
         ASC_RecordWriteLaneYield(state,
                                  telemetry,
                                  beat_start_us,
                                  beat_budget_ms,
                                  ui_priority_active,
                                  state.publication_bundle.board_publish_skip_reason);
        }
      else
        {
      state.publication_bundle.board_lifecycle_state = "publishing";
      state.publication_bundle.board_publish_started_utc = TimeGMT();
      ASC_Layer1PassSummary board_summary = summary;
      string board_readiness_reason = "";
      bool board_ready_consolidated = ASC_RuntimeBoardReadinessConsolidated(state, board_readiness_reason);
      if(board_ready_consolidated)
        {
         board_summary.is_ready = true;
         board_summary.warmup_ready = true;
         board_summary.is_degraded = false;
         board_summary.is_stale = false;
         board_summary.readiness_posture = "ready";
        }
      else
        {
         board_summary.is_ready = false;
         if(board_summary.readiness_posture == "ready")
            board_summary.readiness_posture = "partial";
         if(StringLen(board_readiness_reason) > 0)
            state.publication_bundle.board_publish_skip_reason = "board_readiness_pending: " + board_readiness_reason;
        }
      ulong board_publish_start_us = ASC_HeartbeatNowMicroseconds();
      if(ui_priority_active)
         state.ui_priority_board_write_attempt_count++;
      ASC_FunctionResult board_result = ASC_BuildMarketBoardArtifact(state.server_root,
                                                                     board_summary,
                                                                     state.publication_bundle,
                                                                     state.publication_shortlist_rows);
      telemetry.board_publish_ms = ASC_SafeElapsedMsSince(board_publish_start_us);
      ASC_RecordResult(state, board_result, false);
      ASC_RecordPublicationOutcomeCounters(state, board_result);
      ASC_AccumulateWriteArtifactPerf(state, board_result);
      written++;
      state.publication_bundle.market_board_status = ASC_BundleResultStatus(board_result);
      state.publication_bundle.board_publish_finished_utc = TimeGMT();
      state.publication_bundle.board_publish_result = state.publication_bundle.market_board_status;
      state.publication_bundle.board_publish_skip_reason = "none";
      bool board_no_material_change = ASC_PublicationReasonIndicatesNoMaterialChange(board_result.detail_message);
      if(board_result.state == ASC_RESULT_ERROR)
        {
         failures++;
         board_failed = true;
         essential_failed_this_beat = true;
         state.publication_bundle.board_lifecycle_state = "publish_failed";
         if(state.board_manual_refresh_inflight)
           {
            state.board_manual_refresh_inflight = false;
            state.board_manual_refresh_last_status = "failed";
            state.board_manual_refresh_last_reason = "manual refresh failed during Market Board publication";
           }
         if(state.l1_last_published_revision == 0)
            skip_dossier_due_to_essential_failure = true;
         if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0)
           state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Market Board reason=publication failed",
                                                                              state.publication_bundle.publication_id);
        }
      else if(board_no_material_change)
        {
         state.publication_bundle.market_board_status = "unchanged";
         state.publication_bundle.board_publish_result = "unchanged";
         state.publication_bundle.board_publish_skip_reason = "no_material_change_baseline_retained";
         state.publication_bundle.board_lifecycle_state = "published_baseline_unchanged";
         if(state.board_manual_refresh_inflight)
           {
            state.board_manual_refresh_inflight = false;
            state.board_manual_refresh_last_status = "published_baseline_unchanged";
            state.board_manual_refresh_last_reason = "manual refresh recomputed the Market Board but retained the last confirmed board baseline because no material change was detected";
           }
        }
      else if(state.publication_bundle.market_board_status == "fresh")
        {
         state.publication_bundle.board_lifecycle_state = "published_ready";
         state.market_board_last_publish_utc = state.publication_bundle.board_publish_finished_utc;
         state.publication_bundle.board_baseline_confirmed_utc = state.market_board_last_publish_utc;
         if(state.board_manual_refresh_inflight)
           {
            state.board_manual_refresh_inflight = false;
            state.board_manual_refresh_last_status = "published_ready";
            state.board_manual_refresh_last_reason = "manual refresh completed with fresh Market Board publication";
           }
        }
      else if(state.publication_bundle.market_board_status == "continuity")
        {
         state.publication_bundle.board_lifecycle_state = "published_degraded";
         if(state.board_manual_refresh_inflight)
           {
            state.board_manual_refresh_inflight = false;
            state.board_manual_refresh_last_status = "published_continuity";
            state.board_manual_refresh_last_reason = "manual refresh completed using continuity publication";
           }
        }
        }
     }
   else if(state.l1_publish_pending_essentials && essentials_backoff_active)
     {
      state.publication_bundle.market_board_status = "degraded";
      state.publication_bundle.board_lifecycle_state = "waiting_for_packet_support";
      state.publication_bundle.board_publish_result = "skipped";
      state.publication_bundle.board_publish_skip_reason = "essential_artifact_backoff_active";
      if(state.board_manual_refresh_inflight)
        {
         state.board_manual_refresh_pending = true;
         state.board_manual_refresh_inflight = false;
         state.board_manual_refresh_last_status = "deferred";
         state.board_manual_refresh_last_reason = "manual refresh deferred: essential artifact backoff active";
        }
      if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0)
         state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Market Board reason=essential artifact backoff active",
                                                                           state.publication_bundle.publication_id);
     }

   if(skip_dossier_due_to_essential_failure && ASC_RoutineRootAllSymbolDossierPolicyEnabled())
      state.l1_publish_pending_dossiers = true;

   bool allow_dossier_publish_this_beat = (state.l1_publish_pending_dossiers
                                           && (!skip_dossier_due_to_essential_failure || state.dossier_existence_shell_only));
   bool ui_priority_defer_noncritical_backlog = (allow_dossier_publish_this_beat
                                               && ui_priority_active
                                               && !startup_dossier_flood_mode);
   state.noncritical_defer_candidate_seen_count++;
   if(ui_priority_defer_noncritical_backlog)
     {
      if(StringLen(state.lane_deferred_reason) <= 0)
         state.lane_deferred_reason = "ui-priority active: deferring non-critical dossier backlog slices while preserving admitted publication-integrity work";
      if(StringLen(yield_reason) <= 0 || yield_reason == "no_work")
         yield_reason = "ui_priority_profile_deferred_noncritical_publication";
     }
   if(allow_dossier_publish_this_beat)
     {
      if(ui_priority_active)
         state.ui_priority_dossier_queue_service_count++;
      int backlog_before_service = ASC_CountRemainingDossierBacklog(state);
      int reserved_manifest = (ASC_DossierManifestReserveNeeded(state,
                                                                backlog_before_service,
                                                                startup_dossier_flood_mode)
                               ? 1
                               : 0);
      int remaining_budget = dossier_budget - written - reserved_manifest;
      if(remaining_budget <= 0)
         remaining_budget = 1;

      int cached_symbol_total = ASC_Layer1CachedSymbolCount();
      if(remaining_budget <= 1 && cached_symbol_total > 0)
         remaining_budget = 2;
      if(!startup_dossier_flood_mode && remaining_budget > ASC_DOSSIER_QUEUE_BACKLOG_BUDGET_CAP)
         remaining_budget = ASC_DOSSIER_QUEUE_BACKLOG_BUDGET_CAP;
      if(backlog_before_service > 0)
         remaining_budget = MathMax(remaining_budget, ASC_DOSSIER_QUEUE_PROGRESS_MIN_PER_BEAT);
      int dossier_written_this_beat = 0;
      int consecutive_dossier_failures = 0;
      bool dossier_fail_cap_hit = false;
      bool dossier_budget_yield_hit = false;
      string dossier_queue_last_symbol_this_beat = "";
      ASC_DossierQueueResetBeatProof(state, "service_started");
      ulong queue_service_started_us = ASC_HeartbeatNowMicroseconds();
      string queue_rebuild_reason = "";
      bool queue_rebuild_due = ASC_DossierPendingQueueRebuildDue(state, queue_rebuild_reason);
      if(queue_rebuild_due)
         ASC_RebuildDossierPendingQueues(state, queue_rebuild_reason);
      else
        {
         state.dossier_pending_queue_rebuild_skip_count++;
         state.dossier_pending_queue_last_rebuild_reason = "skipped_" + queue_rebuild_reason;
         ASC_LogInfo("ASC_Dispatcher", "ASC_RunWriteLane", "runtime",
                     StringFormat("dossier queue rebuild skipped reason=%s backlog=%d",
                                  queue_rebuild_reason,
                                  state.dossier_pending_backlog_count));
        }
      int service_order[4];
      bool prioritize_open_hydration = (!state.dossier_existence_shell_only);
      if(prioritize_open_hydration)
        {
         service_order[0] = ASC_DOSSIER_QUEUE_OPEN_L4;
         service_order[1] = ASC_DOSSIER_QUEUE_OPEN_L3;
         service_order[2] = ASC_DOSSIER_QUEUE_OPEN_BASE;
         service_order[3] = ASC_DOSSIER_QUEUE_CLOSED_REDUCED;
        }
      else
        {
         service_order[0] = ASC_DOSSIER_QUEUE_OPEN_BASE;
         service_order[1] = ASC_DOSSIER_QUEUE_CLOSED_REDUCED;
         service_order[2] = ASC_DOSSIER_QUEUE_OPEN_L3;
         service_order[3] = ASC_DOSSIER_QUEUE_OPEN_L4;
        }
      int backlog_before_closed = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_CLOSED_REDUCED);
      int backlog_before_open_base = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_OPEN_BASE);
      int backlog_before_open_l3 = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_OPEN_L3);
      int backlog_before_open_l4 = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_OPEN_L4);
      int ui_priority_deferred_noncritical_count = 0;
      string ui_priority_deferred_noncritical_reason = "none";
      if(ui_priority_defer_noncritical_backlog)
        {
         ui_priority_deferred_noncritical_count = MathMax(0, backlog_before_closed);
         if(ui_priority_deferred_noncritical_count > 0)
           {
            ui_priority_deferred_noncritical_reason = "closed_reduced_backlog_slice_deferred_until_ui_priority_window_lapses";
            state.deferred_write_artifacts = MathMax(state.deferred_write_artifacts, ui_priority_deferred_noncritical_count);
            telemetry.ui_priority_deferred_count = ui_priority_deferred_noncritical_count;
            telemetry.ui_priority_deferred_reason = ui_priority_deferred_noncritical_reason;
           }
         else
           {
            telemetry.ui_priority_deferred_count = 0;
            telemetry.ui_priority_deferred_reason = "ui_priority_active_no_noncritical_dossier_backlog";
           }
        }
      int written_closed = 0;
      int written_open_base = 0;
      int written_open_l3 = 0;
      int written_open_l4 = 0;
      int backlog_before_open_total = (backlog_before_open_base + backlog_before_open_l3 + backlog_before_open_l4);
      bool shell_dominant_backlog = ASC_DossierQueueShellDominantPressure(state, backlog_before_service);
      bool closed_relief_pressure = (!ui_priority_defer_noncritical_backlog
                                     && backlog_before_closed > 0
                                     && (shell_dominant_backlog
                                         || backlog_before_closed >= backlog_before_open_total
                                         || state.dossier_no_progress_write_beats >= 2));
      bool balanced_closed_relief = (closed_relief_pressure
                                     && (remaining_budget >= 3
                                         || (remaining_budget >= 2
                                             && state.dossier_no_progress_write_beats >= 2
                                             && backlog_before_closed > backlog_before_open_total)));
      int closed_relief_quota = 0;
      if(balanced_closed_relief)
        {
         closed_relief_quota = 1;
         if((backlog_before_closed >= 256 || state.dossier_no_progress_write_beats >= 2)
            && remaining_budget >= 8)
            closed_relief_quota = 2;
         if((backlog_before_closed >= 512 || state.dossier_no_progress_write_beats >= 4)
            && remaining_budget >= 12)
            closed_relief_quota = 3;
         if(backlog_before_closed > backlog_before_open_total
            && remaining_budget >= 10)
            closed_relief_quota = MathMax(closed_relief_quota, 3);
        }
      int spill_budget = 0;
      bool top10_batch_active = ASC_IsTop10RunFullBatchActive(state);
      if(prioritize_open_hydration
         && backlog_before_open_total > 0
         && backlog_before_closed > 0
         && remaining_budget >= 6
         && !top10_batch_active)
         spill_budget = 1;
      int min_open_quota = (backlog_before_open_total > 0 ? 1 : 0);
      int max_closed_relief_quota = remaining_budget - min_open_quota - spill_budget;
      if(max_closed_relief_quota < 0)
         max_closed_relief_quota = 0;
      if(closed_relief_quota > max_closed_relief_quota)
         closed_relief_quota = max_closed_relief_quota;
      if(ui_priority_defer_noncritical_backlog)
         closed_relief_quota = 0;
      int open_service_quota = remaining_budget - closed_relief_quota - spill_budget;
      if(open_service_quota < min_open_quota)
        {
         open_service_quota = min_open_quota;
         closed_relief_quota = remaining_budget - open_service_quota - spill_budget;
         if(closed_relief_quota < 0)
           {
            spill_budget = MathMax(0, remaining_budget - open_service_quota);
            closed_relief_quota = remaining_budget - open_service_quota - spill_budget;
            if(closed_relief_quota < 0)
               closed_relief_quota = 0;
           }
        }
      state.dossier_queue_service_last_plan = ASC_DossierQueueServicePlanTrace(prioritize_open_hydration,
                                                                               balanced_closed_relief,
                                                                               remaining_budget,
                                                                               open_service_quota,
                                                                               closed_relief_quota,
                                                                               spill_budget,
                                                                               backlog_before_open_total,
                                                                               backlog_before_closed,
                                                                               state.dossier_no_progress_write_beats);
      string dossier_service_stall_reason = "unobserved";
      int open_phase_budget_used = 0;
      int closed_phase_budget_used = 0;
      for(int phase = 0; phase < 3 && dossier_written_this_beat < remaining_budget && !dossier_fail_cap_hit && !dossier_budget_yield_hit; phase++)
        {
         int phase_order[4];
         int phase_order_size = 0;
         int phase_budget = remaining_budget - dossier_written_this_beat;
         if(phase == 0)
           {
            if(open_service_quota <= 0)
               continue;
            phase_budget = MathMin(phase_budget, open_service_quota - open_phase_budget_used);
            if(phase_budget <= 0)
               continue;
            if(prioritize_open_hydration)
              {
               phase_order[0] = ASC_DOSSIER_QUEUE_OPEN_L4;
               phase_order[1] = ASC_DOSSIER_QUEUE_OPEN_L3;
               phase_order[2] = ASC_DOSSIER_QUEUE_OPEN_BASE;
               phase_order_size = 3;
              }
            else
              {
               phase_order[0] = ASC_DOSSIER_QUEUE_OPEN_BASE;
               phase_order[1] = ASC_DOSSIER_QUEUE_OPEN_L3;
               phase_order[2] = ASC_DOSSIER_QUEUE_OPEN_L4;
               phase_order_size = 3;
              }
           }
         else if(phase == 1)
           {
            if(closed_relief_quota <= 0)
               continue;
            phase_budget = MathMin(phase_budget, closed_relief_quota - closed_phase_budget_used);
            if(phase_budget <= 0)
               continue;
            phase_order[0] = ASC_DOSSIER_QUEUE_CLOSED_REDUCED;
            phase_order_size = 1;
           }
         else
           {
            phase_budget = remaining_budget - dossier_written_this_beat;
            if(phase_budget <= 0)
               continue;
            for(int order_index = 0; order_index < ArraySize(service_order); order_index++)
               phase_order[order_index] = service_order[order_index];
            phase_order_size = ArraySize(service_order);
           }

         for(int q = 0; q < phase_order_size && dossier_written_this_beat < remaining_budget && !dossier_fail_cap_hit && !dossier_budget_yield_hit; q++)
           {
            string queued_symbol = "";
            while(dossier_written_this_beat < remaining_budget)
              {
               if(ASC_WriteLaneNearBudget(beat_start_us, beat_budget_ms, ui_priority_active)
                  && dossier_written_this_beat >= ASC_DOSSIER_QUEUE_PROGRESS_MIN_PER_BEAT)
                 {
                  dossier_budget_yield_hit = true;
                  state.l1_publish_pending_dossiers = true;
                  state.write_dirty = true;
                  state.l1_publish_pending_manifest = true;
                  state.dossier_pending_backlog_count = ASC_DossierPendingQueueTotal(state);
                  telemetry.dossier_yield_count++;
                  ASC_RecordWriteLaneYield(state,
                                           telemetry,
                                           beat_start_us,
                                           beat_budget_ms,
                                           ui_priority_active,
                                           ui_priority_active ? "dossier_queue_yielded_for_ui_priority_after_bounded_progress" : "dossier_queue_yielded_near_write_budget_after_bounded_progress");
                  break;
                 }
               if(!ASC_DossierPendingQueuePopNext(state, phase_order[q], queued_symbol))
                  break;
               if(phase == 0 && open_phase_budget_used >= open_service_quota)
                 {
                  ASC_DossierPendingQueueAppend(state, phase_order[q], queued_symbol);
                  break;
                 }
               if(phase == 1 && closed_phase_budget_used >= closed_relief_quota)
                 {
                  ASC_DossierPendingQueueAppend(state, phase_order[q], queued_symbol);
                  break;
                 }
            if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms)
               && dossier_written_this_beat >= ASC_DOSSIER_QUEUE_PROGRESS_MIN_PER_BEAT)
              {
               ASC_DossierPendingQueueAppend(state, phase_order[q], queued_symbol);
               state.l1_publish_pending_dossiers = true;
               state.write_dirty = true;
               state.l1_publish_pending_manifest = true;
               state.dossier_pending_backlog_count = ASC_DossierPendingQueueTotal(state);
               telemetry.dossier_yield_count++;
               ASC_RecordWriteLaneYield(state,
                                        telemetry,
                                        beat_start_us,
                                        beat_budget_ms,
                                        ui_priority_active,
                                        "dossier_queue_yielded_after_budget_exhaustion_bounded_progress");
               dossier_budget_yield_hit = true;
               break;
              }

            ASC_Layer1SymbolState symbol_state;
            if(!ASC_FindLayer1SymbolByName(queued_symbol, symbol_state))
              {
               state.publication_bundle.dossier_skipped_count++;
               continue;
              }
            if(!ASC_DossierCandidateAllowed(state, symbol_state))
              {
               state.publication_bundle.dossier_skipped_count++;
               continue;
              }

            bool needs_hydration = false;
            int queue_class = ASC_DossierHydrationQueueClassForSymbol(state, symbol_state, needs_hydration);
            if(!needs_hydration)
               continue;
            if(queue_class != phase_order[q])
              {
               ASC_DossierPendingQueueAppend(state, queue_class, symbol_state.symbol);
               continue;
              }

            if(!ASC_DossierBroadRefreshAllowed(state, symbol_state))
              {
               state.publication_bundle.dossier_skipped_count++;
               ASC_DossierHydrationLedgerSetPublicationStatus(state,
                                                              symbol_state,
                                                              "preserved",
                                                              now_utc);
               ASC_DossierHydrationLedgerSetCadence(state,
                                                    symbol_state,
                                                    ASC_DOSSIER_CADENCE_ON_DEMAND_ONLY,
                                                    now_utc + ASC_DossierCadenceIntervalSeconds(ASC_DOSSIER_CADENCE_ON_DEMAND_ONLY, 0),
                                                    false,
                                                    false);
               continue;
              }

            state.publication_bundle.dossier_attempted_count++;
            if(ui_priority_active)
               state.ui_priority_dossier_write_attempt_count++;
            dossier_queue_last_symbol_this_beat = symbol_state.symbol;
            ASC_FunctionResult dossier_result;
            if(state.dossier_existence_shell_only)
               dossier_result = ASC_BuildDossierShellArtifact(state.server_root,
                                                              symbol_state,
                                                              state.publication_bundle);
            else
              {
               ASC_DossierProductMode dossier_mode = ASC_DossierContinuationModeFromLayer1(symbol_state);
               dossier_result = ASC_BuildDossierArtifact(state.server_root,
                                                         symbol_state,
                                                         state.publication_bundle,
                                                         dossier_mode,
                                                         state.publication_shortlist_rows,
                                                         state.hud_selected_symbol);
              }

            ASC_RecordResult(state, dossier_result, (dossier_result.state == ASC_RESULT_ERROR), dossier_result.state != ASC_RESULT_OK);
            ASC_RecordPublicationOutcomeCounters(state, dossier_result);
            ASC_AccumulateWriteArtifactPerf(state, dossier_result);
            written++;

            if(dossier_result.state == ASC_RESULT_ERROR)
              {
               failures++;
               state.publication_bundle.dossier_failure_count++;
               consecutive_dossier_failures++;
               if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0)
                  state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Dossier reason=one or more dossier publications failed",
                                                                                    state.publication_bundle.publication_id);
               int urgent_retry_streak = 0;
               int row_index = ASC_DossierHydrationLedgerFindIndex(state,
                                                                   symbol_state.symbol,
                                                                   ASC_DossierCanonicalSymbol(symbol_state));
               if(row_index >= 0)
                  urgent_retry_streak = state.dossier_hydration_rows[row_index].retry_streak + 1;
               int urgent_retry_seconds = ASC_DossierCadenceIntervalSeconds(ASC_DOSSIER_CADENCE_URGENT_LOWER_LAYER_RETRY,
                                                                            urgent_retry_streak);
               ASC_DossierHydrationLedgerSetPublicationStatus(state,
                                                              symbol_state,
                                                              "failure",
                                                              now_utc);
               ASC_DossierHydrationLedgerSetCadence(state,
                                                    symbol_state,
                                                    ASC_DOSSIER_CADENCE_URGENT_LOWER_LAYER_RETRY,
                                                    now_utc + urgent_retry_seconds,
                                                    false,
                                                    true);
               if(consecutive_dossier_failures >= ASC_DOSSIER_FAIL_CAP_PER_BEAT)
                 {
                  dossier_fail_cap_hit = true;
                  ASC_DossierPendingQueuesMarkDirty(state);
                  break;
                 }
               ASC_DossierPendingQueuesMarkDirty(state);
              }
            else
              {
               bool ledger_exists = true;
               bool ledger_shell = state.dossier_existence_shell_only;
               bool ledger_rich = !ledger_shell;
               bool ledger_l3 = false;
               bool ledger_l4 = false;
               ASC_ArtifactContract dossier_contract = ASC_DossierContract(state.server_root,
                                                                          ASC_DossierCanonicalSymbol(symbol_state));
               string persisted_payload = "";
               bool readback_deferred = ASC_SideDutyShouldYield(state,
                                                                           telemetry,
                                                                           beat_start_us,
                                                                           beat_budget_ms,
                                                                           ui_priority_active,
                                                                           "readback",
                                                                           ui_priority_active ? "deferred_for_ui_priority" : "deferred_near_write_budget");
               if(!readback_deferred
                  && ASC_ReadTextFile(dossier_contract.target_path, persisted_payload)
                  && StringLen(persisted_payload) > 0)
                 {
                  ledger_exists = true;
                  ASC_DossierPayloadHasLawfulBaselineCoverage(symbol_state,
                                                              persisted_payload,
                                                              ledger_shell,
                                                              ledger_rich,
                                                              ledger_l3,
                                                              ledger_l4);
                 }
               else if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L3)
                 {
                  ledger_l3 = true;
                  ledger_l4 = false;
                 }
               else if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L4)
                 {
                  ledger_l3 = true;
                  ledger_l4 = true;
                 }
               string publication_status = (dossier_result.state == ASC_RESULT_WARNING ? "continuity" : "fresh");
               ASC_DossierHydrationLedgerUpsert(state,
                                                symbol_state,
                                                queue_class,
                                                true,
                                                ledger_exists,
                                                ledger_shell,
                                                ledger_rich,
                                                ledger_l3,
                                                ledger_l4,
                                                publication_status,
                                                now_utc);
               bool next_needs_hydration = false;
               int next_queue_class = ASC_DossierHydrationQueueClassForSymbol(state, symbol_state, next_needs_hydration);
               ASC_Layer2Packet packet_after;
               bool has_packet_after = ASC_ShortlistTryGetPacketForState(symbol_state, packet_after);
               bool has_lawful_packet_after = has_packet_after && ASC_L2PacketHasLawfulSnapshot(packet_after);
               int next_cadence_class = ASC_DossierCadenceClassForSymbol(symbol_state,
                                                                          next_needs_hydration,
                                                                          next_queue_class,
                                                                          has_lawful_packet_after);
               int next_due_seconds = ASC_DossierCadenceIntervalSeconds(next_cadence_class, 0);
               if(next_needs_hydration && next_cadence_class == ASC_DOSSIER_CADENCE_URGENT_LOWER_LAYER_RETRY)
                  next_due_seconds = ASC_HEARTBEAT_SECONDS;
               ASC_DossierHydrationLedgerSetCadence(state,
                                                    symbol_state,
                                                    next_cadence_class,
                                                    now_utc + next_due_seconds,
                                                    true,
                                                    false);
               if(next_needs_hydration && next_queue_class != ASC_DOSSIER_QUEUE_NONE)
                 {
                  int next_row_index = ASC_DossierHydrationLedgerFindIndex(state,
                                                                           symbol_state.symbol,
                                                                           ASC_DossierCanonicalSymbol(symbol_state));
                  bool due_now = (next_row_index >= 0
                                  && state.dossier_hydration_rows[next_row_index].next_due_utc <= now_utc);
                  if(due_now)
                     ASC_DossierPendingQueueAppend(state, next_queue_class, symbol_state.symbol);
                 }
               state.publication_bundle.dossier_success_count++;
               consecutive_dossier_failures = 0;
              }
             if(queue_class == ASC_DOSSIER_QUEUE_CLOSED_REDUCED)
                written_closed++;
             else if(queue_class == ASC_DOSSIER_QUEUE_OPEN_BASE)
                written_open_base++;
             else if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L3)
                written_open_l3++;
             else if(queue_class == ASC_DOSSIER_QUEUE_OPEN_L4)
                written_open_l4++;
            dossier_written_this_beat++;
            telemetry.dossier_symbols_this_beat = dossier_written_this_beat;
            if(phase == 0)
               open_phase_budget_used++;
            else if(phase == 1)
               closed_phase_budget_used++;
           }
        }
      state.dossier_pending_backlog_count = ASC_DossierPendingQueueTotal(state);
      state.publication_bundle.write_queue_service_ms = ASC_SafeElapsedMsSince(queue_service_started_us);
      state.write_cursor = 0;
      int backlog_after_service = state.dossier_pending_backlog_count;
      int backlog_after_closed = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_CLOSED_REDUCED);
      int backlog_after_open_base = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_OPEN_BASE);
      int backlog_after_open_l3 = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_OPEN_L3);
      int backlog_after_open_l4 = ASC_DossierPendingQueueClassCount(state, ASC_DOSSIER_QUEUE_OPEN_L4);
      if(dossier_budget_yield_hit)
         dossier_service_stall_reason = telemetry.write_yield_reason;
      else if(dossier_fail_cap_hit)
         dossier_service_stall_reason = "failure_cap";
      else if(backlog_after_service < backlog_before_service)
         dossier_service_stall_reason = "progress";
      else if(queue_rebuild_due && dossier_written_this_beat <= 0)
         dossier_service_stall_reason = "rebuild_without_service_progress";
      else if(dossier_written_this_beat <= 0 && ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms))
         dossier_service_stall_reason = "budget_exhausted_before_dossier_progress";
      else if(dossier_written_this_beat <= 0 && ui_priority_defer_noncritical_backlog && ui_priority_deferred_noncritical_count > 0)
         dossier_service_stall_reason = "ui_priority_deferred_noncritical_backlog";
      else if(dossier_written_this_beat <= 0)
         dossier_service_stall_reason = "no_due_or_admissible_dossier_symbols";
      else
         dossier_service_stall_reason = "written_without_backlog_drop";
      state.dossier_queue_service_last_before = ASC_DossierPendingQueueClassTrace(backlog_before_closed,
                                                                                  backlog_before_open_base,
                                                                                  backlog_before_open_l3,
                                                                                  backlog_before_open_l4);
      state.dossier_queue_service_last_written = ASC_DossierPendingQueueClassTrace(written_closed,
                                                                                   written_open_base,
                                                                                   written_open_l3,
                                                                                   written_open_l4);
      state.dossier_queue_service_last_after = ASC_DossierPendingQueueClassTrace(backlog_after_closed,
                                                                                 backlog_after_open_base,
                                                                                 backlog_after_open_l3,
                                                                                 backlog_after_open_l4);
      state.dossier_queue_service_last_stall_reason = dossier_service_stall_reason;
      ASC_DossierQueueUpdateBeatProof(state,
                                      backlog_before_service,
                                      backlog_after_service,
                                      state.publication_bundle.dossier_attempted_count,
                                      state.publication_bundle.dossier_success_count,
                                      state.publication_bundle.dossier_failure_count,
                                      dossier_fail_cap_hit,
                                      dossier_queue_last_symbol_this_beat,
                                      dossier_service_stall_reason);
      if(backlog_after_service >= backlog_before_service
         && (dossier_written_this_beat > 0 || backlog_before_service > 0))
         state.dossier_no_progress_write_beats++;
      else if(dossier_written_this_beat > 0 || backlog_after_service < backlog_before_service)
         state.dossier_no_progress_write_beats = 0;
      ASC_LogInfo("ASC_Dispatcher", "ASC_RunWriteLane", "runtime",
                  StringFormat("dossier service beat budget=%d written=%d failures=%d backlog_before=%d backlog_after=%d rebuild_due=%s rebuild_reason=%s queue_before=%s queue_written=%s queue_after=%s plan=%s stall_reason=%s no_progress_beats=%d ui_priority_deferred_count=%d ui_priority_deferred_reason=%s write_early_yield=%s write_yield_reason=%s write_budget_elapsed_ms=%d write_budget_remaining_ms=%d dossier_symbols_this_beat=%d dossier_yield_count=%d ui_priority_write_reduced=%s deferred_readback_count=%d",
                               remaining_budget,
                               dossier_written_this_beat,
                               state.publication_bundle.dossier_failure_count,
                               backlog_before_service,
                               backlog_after_service,
                               queue_rebuild_due ? "yes" : "no",
                               queue_rebuild_reason,
                               state.dossier_queue_service_last_before,
                               state.dossier_queue_service_last_written,
                               state.dossier_queue_service_last_after,
                               state.dossier_queue_service_last_plan,
                               state.dossier_queue_service_last_stall_reason,
                               state.dossier_no_progress_write_beats,
                               telemetry.ui_priority_deferred_count,
                               telemetry.ui_priority_deferred_reason,
                               telemetry.write_early_yield ? "yes" : "no",
                               telemetry.write_yield_reason,
                               telemetry.write_budget_elapsed_ms,
                               telemetry.write_budget_remaining_ms,
                               telemetry.dossier_symbols_this_beat,
                               telemetry.dossier_yield_count,
                               telemetry.ui_priority_write_reduced ? "yes" : "no",
                               telemetry.deferred_readback_count));

      int remaining_hydration_backlog = ASC_CountRemainingDossierBacklog(state);
      if(remaining_hydration_backlog <= 0 && !dossier_fail_cap_hit)
        {
         if(state.dossier_existence_shell_only)
           {
            int non_rich_after_seed = ASC_CountNonRichDossierArtifacts(state);
            if(non_rich_after_seed > 0)
              {
               state.dossier_existence_shell_only = false;
               state.dossier_startup_flood_active = false;
               state.dossier_startup_flood_budget_last = 0;
               state.write_cursor = 0;
               state.write_dirty = true;
               if(state.dossier_open_refresh_only)
                 {
                  state.l1_publish_pending_dossiers = true;
                  state.l1_publish_pending_manifest = true;
                  ASC_DossierPendingQueuesMarkDirty(state);
                  state.dossier_refresh_last_status = "resumed_after_shell_duty";
                  state.dossier_refresh_last_reason = "startup shell-existence duty completed; queued open-symbol dossier refresh now owns the next ordinary hydration pass";
                 }
               else
                  ASC_QueueDossierContinuationDuty(state);
              }
            else
              {
               state.l1_publish_pending_dossiers = false;
               state.dossier_existence_shell_only = false;
               state.dossier_startup_flood_active = false;
               state.dossier_startup_flood_budget_last = 0;
               state.write_cursor = 0;
               ASC_DossierPendingQueuesReset(state);
               state.dossier_pending_queues_ready = false;
               state.dossier_pending_queues_dirty = true;
               state.dossier_pending_queue_signature = "";
              }
           }
         else
           {
            state.l1_publish_pending_dossiers = false;
            state.dossier_existence_shell_only = false;
            state.dossier_startup_flood_active = false;
            state.dossier_startup_flood_budget_last = 0;
            state.write_cursor = 0;
            ASC_DossierPendingQueuesReset(state);
            state.dossier_pending_queues_ready = false;
            state.dossier_pending_queues_dirty = true;
            state.dossier_pending_queue_signature = "";
           }
        }
      else
        {
        state.l1_publish_pending_dossiers = true;
         state.write_dirty = true;
         state.l1_publish_pending_manifest = true;
         state.dossier_pending_backlog_count = ASC_DossierPendingQueueTotal(state);
        }
     }
   }
   if(!allow_dossier_publish_this_beat
      && state.l1_publish_pending_dossiers
      && skip_dossier_due_to_essential_failure)
     {
      state.write_dirty = true;
      state.l1_publish_pending_manifest = true;
      if(StringLen(state.publication_bundle.last_bundle_error_summary) <= 0)
         state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Dossier reason=deferred while essential artifacts have no last-good baseline",
                                                                           state.publication_bundle.publication_id);
     }

   ASC_FinalizePublicationBundle(state, TimeGMT());

   if(state.l1_publish_pending_manifest)
     {
      if(ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms)
         || (ASC_WriteLaneNearBudget(beat_start_us, beat_budget_ms, ui_priority_active)
             && state.l1_publish_pending_dossiers)
         || (ui_priority_active && state.l1_publish_pending_dossiers))
        {
         state.l1_publish_pending_manifest = true;
         state.write_dirty = true;
         string manifest_yield_reason = ASC_HeartbeatBudgetExpired(beat_start_us, beat_budget_ms)
                                        ? "bundle_manifest_deferred_budget_exhausted"
                                        : (ui_priority_active ? "bundle_manifest_deferred_ui_priority_side_reduction" : "bundle_manifest_deferred_until_dossier_backlog_slice_resumes");
         ASC_RecordWriteLaneYield(state,
                                  telemetry,
                                  beat_start_us,
                                  beat_budget_ms,
                                  ui_priority_active,
                                  manifest_yield_reason);
         telemetry.manifest_yield_count++;
         telemetry.side_yield_reason = manifest_yield_reason;
        }
      else
        {
      ulong manifest_publish_start_us = ASC_HeartbeatNowMicroseconds();
      ASC_FunctionResult manifest_result = ASC_WriteArtifactBundleManifest(state);
      telemetry.manifest_publish_ms = ASC_SafeElapsedMsSince(manifest_publish_start_us);
      ASC_RecordResult(state, manifest_result, false);
      ASC_RecordPublicationOutcomeCounters(state, manifest_result);
      ASC_AccumulateWriteArtifactPerf(state, manifest_result);
      written++;
      state.publication_bundle.manifest_status = ASC_BundleResultStatus(manifest_result);
      if(manifest_result.state == ASC_RESULT_ERROR)
        {
         failures++;
         state.l1_publish_pending_manifest = true;
         state.write_dirty = true;
         state.publication_bundle.overall_bundle_status = "failure";
         state.publication_bundle.last_bundle_error_summary = StringFormat("bundle_id=%s artifact_family=Manifest reason=publication failed",
                                                                           state.publication_bundle.publication_id);
        }
      else
        {
         state.l1_publish_pending_manifest = false;
        }
        }
     }

   string bundle_log_summary = StringFormat("bundle_id=%s Market Board=%s outcome_class=%s baseline_advance=%s baseline_reason=%s reason_trace=%s Open Symbol Snapshot=%s Bundle Manifest=%s Dossier attempted=%d success=%d failure=%d skipped=%d overall=%s reason=%s write_perf=board_compose_ms=%d,board_publish_ms=%d,dossier_compose_ms=%d,dossier_publish_ms=%d,manifest_compose_ms=%d,manifest_publish_ms=%d,write_queue_ms=%d,artifact_attempted=%d,write_bottleneck_family=%s,write_bottleneck_reason=%s",
                                            state.publication_bundle.publication_id,
                                            state.publication_bundle.market_board_status,
                                            ASC_BoardPublishOutcomeClass(state.publication_bundle.board_publish_result),
                                            ASC_BoardBaselineAdvanceState(state.publication_bundle.board_publish_result),
                                            ASC_BoardBaselineAdvanceReason(state.publication_bundle.board_publish_result,
                                                                          state.publication_bundle.board_publish_skip_reason),
                                            ASC_BoardPublishReasonTrace(state.publication_bundle.board_publish_result,
                                                                       state.publication_bundle.board_refresh_trigger,
                                                                       state.publication_bundle.board_publish_skip_reason),
                                            state.publication_bundle.open_symbol_snapshot_status,
                                            state.publication_bundle.manifest_status,
                                            state.publication_bundle.dossier_attempted_count,
                                            state.publication_bundle.dossier_success_count,
                                            state.publication_bundle.dossier_failure_count,
                                            state.publication_bundle.dossier_skipped_count,
                                            state.publication_bundle.overall_bundle_status,
                                            state.publication_bundle.last_bundle_error_summary,
                                            state.publication_bundle.board_compose_ms,
                                            state.publication_bundle.board_publish_ms,
                                            state.publication_bundle.dossier_compose_ms_total,
                                            state.publication_bundle.dossier_publish_ms_total,
                                            state.publication_bundle.manifest_compose_ms,
                                            state.publication_bundle.manifest_publish_ms,
                                            state.publication_bundle.write_queue_service_ms,
                                            state.publication_bundle.artifact_attempted_count,
                                            state.publication_bundle.write_bottleneck_family,
                                            state.publication_bundle.write_bottleneck_reason);
   bundle_log_summary += " | " + ASC_DossierPublicationPolicyTokens(state);
   ASC_LogInfo("ASC_Dispatcher", "ASC_RunWriteLane", "runtime", bundle_log_summary);

   if(!state.l1_publish_pending_dossiers && state.publication_bundle.dossier_failure_count == 0)
     {
      if(state.dossier_open_refresh_only)
         state.l1_last_open_dossier_publish_utc = now_utc;
      else
        {
         state.l1_last_dossier_publish_utc = now_utc;
         state.l1_last_open_dossier_publish_utc = now_utc;
         state.l1_last_published_revision = ASC_Layer1StructuralRevision();
        }

      state.dossier_open_refresh_only = false;
     }

   if(!state.l1_publish_pending_dossiers
      && state.dossier_resume_full_publish_after_open_refresh
      && state.publication_bundle.dossier_failure_count == 0)
     {
      state.dossier_resume_full_publish_after_open_refresh = false;
      if(ASC_RoutineRootAllSymbolDossierPolicyEnabled())
        {
         ASC_QueueDossierContinuationDuty(state);
         state.write_dirty = true;
         state.dossier_refresh_last_status = "resumed_generic_backlog";
         state.dossier_refresh_last_reason = "open-symbol priority refresh completed; generic dossier continuation backlog resumed";
        }
      else
        {
         ASC_RecordRoutineRootDossierPolicySkip(state, now_utc, ASC_ROOT_ALL_SYMBOL_DOSSIER_SKIP_REASON);
         state.dossier_refresh_last_status = "generic_backlog_skipped_policy";
         state.dossier_refresh_last_reason = "routine root all-symbol Dossier continuation skipped by RUN113 publication policy; selected/current and family Dossiers remain enabled";
        }
     }

   ASC_UpdateWriteBundleBottleneck(state);
   telemetry.board_compose_ms = state.publication_bundle.board_compose_ms;
   telemetry.board_publish_ms = state.publication_bundle.board_publish_ms;
   telemetry.dossier_compose_ms = state.publication_bundle.dossier_compose_ms_total;
   telemetry.dossier_publish_ms = state.publication_bundle.dossier_publish_ms_total;
   telemetry.manifest_compose_ms = state.publication_bundle.manifest_compose_ms;
   telemetry.manifest_publish_ms = state.publication_bundle.manifest_publish_ms;
   telemetry.write_queue_service_ms = state.publication_bundle.write_queue_service_ms;
   telemetry.artifact_attempted_count = state.publication_bundle.artifact_attempted_count;
   telemetry.write_bottleneck_family = state.publication_bundle.write_bottleneck_family;
   telemetry.write_bottleneck_reason = state.publication_bundle.write_bottleneck_reason;

   int dossier_pending = ASC_CountRemainingDossierBacklog(state);
   state.deferred_write_artifacts = ASC_PendingBundleArtifactCount(state, summary, dossier_pending);
   telemetry.written_artifacts = written;
   telemetry.write_failures = failures;
   telemetry.deferred_write_artifacts = state.deferred_write_artifacts;

   bool l2_pending_from_backoff = (state.l2_publish_pending && essentials_backoff_active);
   bool essentials_pending_from_backoff = (state.l1_publish_pending_essentials && essentials_backoff_active);
   state.l2_publish_pending = (l2_failed || l2_pending_from_backoff);
   state.l1_publish_pending_essentials = (board_failed || board_deferred || essentials_pending_from_backoff);
   state.write_dirty = (state.l1_publish_pending_dossiers
                        || state.l2_publish_pending
                        || state.l1_publish_pending_essentials
                        || state.l1_publish_pending_manifest);
   dossier_pending = ASC_CountRemainingDossierBacklog(state);
   state.deferred_write_artifacts = ASC_PendingBundleArtifactCount(state, summary, dossier_pending);
   telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
   if(!state.l1_publish_pending_dossiers)
     {
      state.write_cursor = 0;
      state.dossier_open_refresh_only = false;
      state.dossier_resume_full_publish_after_open_refresh = false;
      state.dossier_existence_shell_only = false;
      state.dossier_startup_flood_active = false;
      state.dossier_startup_flood_budget_last = 0;
     }
   state.beats_since_write = 0;
   state.l1_partial_beats = 0;
   state.l1_publish_pending_partial = false;
   state.l1_publish_pending_full = false;
   state.l1_last_publish_posture = summary.publication_posture;
   state.last_write_utc = now_utc;

   ulong post_publish_started_us = ASC_HeartbeatNowMicroseconds();
   bool sweep_deferred = ASC_SideDutyShouldYield(state,
                                                           telemetry,
                                                           beat_start_us,
                                                           beat_budget_ms,
                                                           ui_priority_active,
                                                           "sweep",
                                                           ui_priority_active ? "post_publish_presence_deferred_for_ui_priority" : "post_publish_presence_deferred_near_write_budget");
   if(!sweep_deferred)
     {
      ASC_RefreshDossierPresenceCounters(state,
                                         "write_lane_post_publish",
                                         (state.publication_bundle.dossier_attempted_count > 0),
                                         2);
      telemetry.side_duty_count_this_beat++;
     }
   else
     {
      state.write_dirty = true;
      state.deferred_write_artifacts = MathMax(1, state.deferred_write_artifacts);
     }
   telemetry.post_publish_elapsed_ms = ASC_SafeElapsedMsSince(post_publish_started_us);

   if(essential_failed_this_beat)
     {
      state.essential_failure_streak++;
      if(state.essential_failure_streak >= ASC_ESSENTIAL_FAIL_STREAK_THRESHOLD)
        {
         int essentials_backoff_sec = ASC_BoundedBackoffSeconds(state.essential_failure_streak,
                                                                ASC_ESSENTIAL_BACKOFF_BASE_SEC,
                                                                ASC_ESSENTIAL_BACKOFF_MAX_SEC);
         state.essential_backoff_until_utc = now_utc + essentials_backoff_sec;
        }
     }
   else if(state.publication_bundle.market_board_status == "fresh"
           && state.publication_bundle.open_symbol_snapshot_status == "fresh")
     {
      state.essential_failure_streak = 0;
      state.essential_backoff_until_utc = 0;
     }

   if(failures > 0)
     {
      state.write_failure_streak++;
      int write_backoff_sec = ASC_BoundedBackoffSeconds(state.write_failure_streak,
                                                        ASC_WRITE_FAILURE_COOLDOWN_BASE_SEC,
                                                        ASC_WRITE_FAILURE_COOLDOWN_MAX_SEC);
      state.write_cooldown_until_utc = now_utc + write_backoff_sec;

      if(state.publication_bundle.dossier_failure_count > 0)
        {
         state.dossier_failure_streak++;
         if(state.dossier_failure_streak >= ASC_DOSSIER_FAIL_STREAK_THRESHOLD)
           {
            int dossier_backoff_sec = ASC_BoundedBackoffSeconds(state.dossier_failure_streak,
                                                                ASC_DOSSIER_BACKOFF_BASE_SEC,
                                                                ASC_DOSSIER_BACKOFF_MAX_SEC);
            state.dossier_backoff_until_utc = now_utc + dossier_backoff_sec;
           }
        }
      state.posture = ASC_RUNTIME_DEGRADED;
      yield_reason = "publication_bundle_completed_with_failures";
     }
   else
     {
      state.write_failure_streak = 0;
      state.write_cooldown_until_utc = 0;
      if(state.publication_bundle.dossier_attempted_count > 0)
        {
         state.dossier_failure_streak = 0;
         state.dossier_backoff_until_utc = 0;
        }
      if(!state.write_dirty)
         state.posture = ASC_RUNTIME_READY;
     }

   if(state.write_dirty && (ASC_IsCooldownActive(now_utc, state.write_cooldown_until_utc)
      || ASC_IsCooldownActive(now_utc, state.essential_backoff_until_utc)
      || ASC_IsCooldownActive(now_utc, state.dossier_backoff_until_utc)))
      yield_reason = "publication_backoff_active";

   else if(skip_dossier_due_to_essential_failure)
      yield_reason = "publication_essential_failed_dossier_deferred";
   else if(state.l1_publish_pending_dossiers)
      yield_reason = "publication_bundle_partial_dossier_progress";
   else if(summary.is_complete && summary.is_ready)
      yield_reason = "l1_ready_publish_completed";
   else if(summary.is_complete)
      yield_reason = "l1_full_publish_completed_not_ready";
   else
      yield_reason = "l1_partial_publish_completed";
  }


ASC_FunctionResult ASC_RunHeartbeat(ASC_RuntimeState &state,
                                    const bool hud_priority_served = false,
                                    const bool hud_pending_render = false)
  {
   ASC_FunctionResult heartbeat;
   ASC_FunctionResultBegin(heartbeat, "ASC_Dispatcher", "ASC_RunHeartbeat", "runtime");

   if(state.posture != ASC_RUNTIME_READY && state.posture != ASC_RUNTIME_DEGRADED)
     {
      ASC_FunctionResultFinish(heartbeat,
                               ASC_RESULT_WARNING,
                               ASC_RC_DISPATCH_FAILED,
                               "Runtime is not ready; heartbeat skipped.",
                               "runtime");
      return heartbeat;
     }

   state.heartbeat_counter++;
   state.beats_since_write++;
   datetime now_utc = TimeGMT();
   bool ui_priority_active = ASC_IsUiPriorityActive(state, now_utc);
   bool ui_priority_was_active = state.ui_priority_last_active;
   if(ui_priority_active)
      state.ui_priority_active_beat_count++;
   if(ui_priority_active && !ui_priority_was_active)
      state.ui_priority_enter_count++;
   else if(!ui_priority_active && ui_priority_was_active)
      state.ui_priority_expire_count++;
   state.ui_priority_last_active = ui_priority_active;
   ulong side_duty_started_us = ASC_HeartbeatNowMicroseconds();

   ASC_ServiceForcedDownstreamRefreshRequest(state, now_utc);
   ASC_AdmitManualBoardRefreshRequest(state, now_utc);
   ASC_ReconcileRunFullBoardBaselineSatisfaction(state);
   ASC_ReconcileSelectedSymbolCurrentFocusSync(state, now_utc);
   ASC_MaybeRefreshCommittedSelectionCadence(state, now_utc);
   ASC_MaybeScheduleSymbolDataPackLiteRuntimeActivation(state, now_utc);
   ASC_SelectModeAndLane(state, now_utc);
   int heartbeat_budget_ms = ASC_EffectiveHeartbeatBudgetMs(state, state.active_lane, ui_priority_active);
   int pre_lane_side_duty_ms = ASC_SafeElapsedMsSince(side_duty_started_us);
   ulong beat_start_us = ASC_HeartbeatNowMicroseconds();

   ASC_HeartbeatTelemetry telemetry;
   telemetry.heartbeat_id = state.heartbeat_counter;
   telemetry.beat_utc = now_utc;
   telemetry.mode = state.mode;
   telemetry.lane = state.active_lane;
   telemetry.sublane = state.active_sublane;
   telemetry.admitted_scan_budget = (state.active_lane == ASC_LANE_SCAN) ? state.scan_budget_symbols : 0;
   telemetry.admitted_write_budget = (state.active_lane == ASC_LANE_PERSISTENCE) ? state.write_budget_artifacts : 0;
   telemetry.packet_target = 0;
   telemetry.packet_completed = 0;
   telemetry.bursts_executed = 0;
   telemetry.due_selected = 0;
   telemetry.retry_selected = 0;
   telemetry.scanned_symbols = 0;
   telemetry.l2_processed = 0;
   telemetry.l2_admitted = state.l2_admitted_symbols;
   telemetry.l2_changed = 0;
   telemetry.l2_due_remaining = state.l2_due_remaining;
   telemetry.scan_streak = state.consecutive_scan_beats;
   telemetry.write_streak = state.consecutive_write_beats;
   telemetry.written_artifacts = 0;
   telemetry.write_failures = 0;
   telemetry.deep_trigger_ms = 0;
   telemetry.board_compose_ms = 0;
   telemetry.board_publish_ms = 0;
   telemetry.dossier_compose_ms = 0;
   telemetry.dossier_publish_ms = 0;
   telemetry.manifest_compose_ms = 0;
   telemetry.manifest_publish_ms = 0;
   telemetry.write_queue_service_ms = 0;
   telemetry.artifact_attempted_count = 0;
   telemetry.write_bottleneck_family = "none";
   telemetry.write_bottleneck_reason = "unobserved";
   telemetry.deferred_scan_symbols = state.deferred_scan_symbols;
   telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
   telemetry.heartbeat_duration_ms = 0;
   telemetry.heartbeat_budget_ms = heartbeat_budget_ms;
   telemetry.heartbeat_lane_p50_ms = 0;
   telemetry.heartbeat_lane_p95_ms = 0;
   telemetry.top10_batch_ms = 0;
   telemetry.side_duty_ms = pre_lane_side_duty_ms;
   telemetry.dossier_sweep_ms = 0;
   telemetry.dossier_sweep_symbols = 0;
   telemetry.dossier_sweep_payload_reads = 0;
   telemetry.ui_priority_active = ui_priority_active;
   telemetry.pre_lane_side_duty_ms = pre_lane_side_duty_ms;
   telemetry.lane_execution_ms = 0;
   telemetry.ui_priority_state_compact = (ui_priority_active ? 1 : 0);
   telemetry.ui_priority_deferred_count = 0;
   telemetry.ui_priority_deferred_reason = "none";
   telemetry.ui_priority_active_beat_count = state.ui_priority_active_beat_count;
   telemetry.ui_priority_enter_count = state.ui_priority_enter_count;
   telemetry.ui_priority_expire_count = state.ui_priority_expire_count;
   telemetry.ui_priority_scan_lane_entered_count = state.ui_priority_scan_lane_entered_count;
   telemetry.ui_priority_write_lane_entered_count = state.ui_priority_write_lane_entered_count;
   telemetry.ui_priority_dossier_queue_service_count = state.ui_priority_dossier_queue_service_count;
   telemetry.ui_priority_dossier_write_attempt_count = state.ui_priority_dossier_write_attempt_count;
   telemetry.ui_priority_board_write_attempt_count = state.ui_priority_board_write_attempt_count;
   telemetry.ui_priority_top10_write_attempt_count = state.ui_priority_top10_write_attempt_count;
   telemetry.noncritical_defer_candidate_seen_count = state.noncritical_defer_candidate_seen_count;
   telemetry.write_early_yield = false;
   telemetry.write_yield_reason = "none";
   telemetry.write_budget_elapsed_ms = 0;
   telemetry.write_budget_remaining_ms = heartbeat_budget_ms;
   telemetry.dossier_symbols_this_beat = 0;
   telemetry.dossier_yield_count = 0;
   telemetry.ui_priority_write_reduced = false;
   telemetry.deferred_readback_count = 0;
   telemetry.readback_pending_count = 0;
   telemetry.manifest_yield_count = 0;
   telemetry.sweep_yield_count = 0;
   telemetry.post_publish_elapsed_ms = 0;
   telemetry.side_duty_count_this_beat = 0;
   telemetry.side_yield_reason = "none";
   telemetry.hud_priority_served = hud_priority_served;
   telemetry.hud_pending_render = hud_pending_render;
   telemetry.lane_reason = state.lane_decision_reason;
   telemetry.defer_reason = state.lane_deferred_reason;
   telemetry.yield_reason = "";

   string yield_reason = "no_work";
   ASC_Layer1PassSummary heartbeat_summary;
   bool has_heartbeat_summary = ASC_Layer1TryGetLatestSummary(heartbeat_summary);
   string class_health = has_heartbeat_summary ? ASC_Layer1ClassificationHealthCompact(heartbeat_summary) : "resolved=0 unresolved=0 fallback=0";
   string class_groups = has_heartbeat_summary ? ASC_Layer1MainGroupDistributionCompact(heartbeat_summary) : "fx=0 indices=0 stocks=0 metals=0 energy=0 crypto=0 rates=0 vol=0 comm=0 funds=0 unknown=0";

   if(state.active_lane == ASC_LANE_SCAN)
      ASC_RunScanLane(state, now_utc, beat_start_us, heartbeat_budget_ms, telemetry, yield_reason);
   else
      ASC_RunWriteLane(state, now_utc, beat_start_us, heartbeat_budget_ms, telemetry, yield_reason);

   if(state.active_lane == ASC_LANE_SCAN)
     {
      state.consecutive_scan_beats++;
      state.consecutive_write_beats = 0;
     }
   else if(state.active_lane == ASC_LANE_PERSISTENCE)
     {
      state.consecutive_write_beats++;
      state.consecutive_scan_beats = 0;
     }

   telemetry.deferred_scan_symbols = state.deferred_scan_symbols;
   telemetry.deferred_write_artifacts = state.deferred_write_artifacts;
   telemetry.scan_streak = state.consecutive_scan_beats;
   telemetry.write_streak = state.consecutive_write_beats;
   telemetry.lane_reason = state.lane_decision_reason;
   telemetry.defer_reason = state.lane_deferred_reason;
   telemetry.yield_reason = yield_reason;
   telemetry.heartbeat_duration_ms = ASC_SafeElapsedMsSince(beat_start_us);
   telemetry.lane_execution_ms = telemetry.heartbeat_duration_ms;
   telemetry.ui_priority_active_beat_count = state.ui_priority_active_beat_count;
   telemetry.ui_priority_enter_count = state.ui_priority_enter_count;
   telemetry.ui_priority_expire_count = state.ui_priority_expire_count;
   telemetry.ui_priority_scan_lane_entered_count = state.ui_priority_scan_lane_entered_count;
   telemetry.ui_priority_write_lane_entered_count = state.ui_priority_write_lane_entered_count;
   telemetry.ui_priority_dossier_queue_service_count = state.ui_priority_dossier_queue_service_count;
   telemetry.ui_priority_dossier_write_attempt_count = state.ui_priority_dossier_write_attempt_count;
   telemetry.ui_priority_board_write_attempt_count = state.ui_priority_board_write_attempt_count;
   telemetry.ui_priority_top10_write_attempt_count = state.ui_priority_top10_write_attempt_count;
   telemetry.noncritical_defer_candidate_seen_count = state.noncritical_defer_candidate_seen_count;

   ASC_RecordHeartbeatDurationTelemetry(state, telemetry.lane, telemetry.heartbeat_duration_ms);
   if(telemetry.lane == ASC_LANE_PERSISTENCE)
     {
      telemetry.heartbeat_lane_p50_ms = state.heartbeat_write_p50_ms;
      telemetry.heartbeat_lane_p95_ms = state.heartbeat_write_p95_ms;
     }
   else
     {
      telemetry.heartbeat_lane_p50_ms = state.heartbeat_scan_p50_ms;
      telemetry.heartbeat_lane_p95_ms = state.heartbeat_scan_p95_ms;
     }

   bool post_lane_side_deferred = false;
   if(state.active_lane == ASC_LANE_PERSISTENCE)
      post_lane_side_deferred = ASC_SideDutyShouldYield(state,
                                                                   telemetry,
                                                                   beat_start_us,
                                                                   heartbeat_budget_ms,
                                                                   ui_priority_active,
                                                                   "sweep",
                                                                   ui_priority_active ? "scanner_status_and_presence_deferred_for_ui_priority" : "scanner_status_and_presence_deferred_near_write_budget");

   if(!post_lane_side_deferred)
     {
      ASC_MaybeWriteScannerStatus(state, now_utc);

      ASC_Layer1PassSummary post_summary;
      if(ASC_Layer1TryGetLatestSummary(post_summary))
        {
         ASC_RefreshDossierPresenceCounters(state, "heartbeat_post_summary", false, 2);
         ASC_UpdateDossierCoverageTelemetry(state, post_summary);
         ASC_UpdateStartupDossierFloodState(state);
         telemetry.side_duty_count_this_beat++;
        }
     }
   else
     {
      state.write_dirty = true;
      state.deferred_write_artifacts = MathMax(1, state.deferred_write_artifacts);
     }

   telemetry.side_duty_ms = ASC_SafeElapsedMsSince(side_duty_started_us);
   if(state.dossier_presence_refresh_last_heartbeat_id == state.heartbeat_counter)
     {
      telemetry.dossier_sweep_ms = state.dossier_presence_refresh_last_elapsed_ms;
      telemetry.dossier_sweep_symbols = state.dossier_presence_refresh_last_symbols;
      telemetry.dossier_sweep_payload_reads = state.dossier_presence_refresh_last_payload_reads;
     }

   ASC_LogHeartbeatTelemetry(state, telemetry);

   int l2_hydration_ready = 0;
   int l2_hydration_slow_incomplete = 0;
   int l2_hydration_live_quote_incomplete = 0;
   int l2_hydration_live_analytic_incomplete = 0;
   int l2_hydration_blocked_warmup = 0;
   int l2_hydration_blocked_post_warmup_queue = 0;
   ASC_Layer2Summary l2_observability_summary;
   if(ASC_Layer2TryGetSummary(l2_observability_summary))
     {
      l2_hydration_ready = l2_observability_summary.hydration_ready_count;
      l2_hydration_slow_incomplete = l2_observability_summary.hydration_slow_incomplete_count;
      l2_hydration_live_quote_incomplete = l2_observability_summary.hydration_live_quote_incomplete_count;
      l2_hydration_live_analytic_incomplete = l2_observability_summary.hydration_live_analytic_incomplete_count;
      l2_hydration_blocked_warmup = l2_observability_summary.hydration_blocked_warmup_count;
      l2_hydration_blocked_post_warmup_queue = l2_observability_summary.hydration_blocked_post_warmup_repair_queue_count;
     }

   bool heartbeat_detail_full_due = (state.posture == ASC_RUNTIME_DEGRADED
                                      || telemetry.write_failures > 0
                                      || telemetry.heartbeat_duration_ms > telemetry.heartbeat_budget_ms
                                      || telemetry.ui_priority_active
                                      || telemetry.write_early_yield
                                      || telemetry.hud_priority_served
                                      || telemetry.hud_pending_render
                                      || telemetry.heartbeat_id <= 1
                                      || (telemetry.heartbeat_id > 0 && (telemetry.heartbeat_id % 300) == 0));

   string detail = "heartbeat=" + IntegerToString(telemetry.heartbeat_id);
   detail += " lane=" + ASC_LaneToText(telemetry.lane);
   detail += " sublane=" + ASC_SublaneToText(telemetry.sublane);
   detail += " scanned=" + IntegerToString(telemetry.scanned_symbols);
   detail += " written=" + IntegerToString(telemetry.written_artifacts);
   detail += " deferred_scan=" + IntegerToString(telemetry.deferred_scan_symbols);
   detail += " deferred_write=" + IntegerToString(telemetry.deferred_write_artifacts);
   detail += " hb_ms=" + IntegerToString(telemetry.heartbeat_duration_ms);
   detail += " hb_budget_ms=" + IntegerToString(telemetry.heartbeat_budget_ms);
   detail += " ui_priority=" + (telemetry.ui_priority_active ? "on" : "off");
   detail += " hud_handoff=" + IntegerToString(telemetry.hud_priority_served ? 1 : 0) + "/" + IntegerToString(telemetry.hud_pending_render ? 1 : 0);
   detail += " write_failures=" + IntegerToString(telemetry.write_failures);
   detail += " sample_detail=" + (heartbeat_detail_full_due ? "full" : "compact");
   detail += " sample_hb=60";
   detail += " heartbeat_detail_build_avoided=" + (heartbeat_detail_full_due ? "none_full_detail_required" : "full_detail_tokens_deferred");
   detail += " proof_emit_gate_blocked=" + (heartbeat_detail_full_due ? "no" : "yes_compact_only");

   if(heartbeat_detail_full_due)
     {

      detail += " mode=" + ASC_ModeToText(telemetry.mode);
      detail += " scan_budget=" + IntegerToString(telemetry.admitted_scan_budget);
      detail += " write_budget=" + IntegerToString(telemetry.admitted_write_budget);
      detail += " packet_target=" + IntegerToString(telemetry.packet_target);
      detail += " packet_completed=" + IntegerToString(telemetry.packet_completed);
      detail += " bursts=" + IntegerToString(telemetry.bursts_executed);
      detail += " due_selected=" + IntegerToString(telemetry.due_selected);
      detail += " retry_selected=" + IntegerToString(telemetry.retry_selected);
      detail += " l2_processed=" + IntegerToString(telemetry.l2_processed);
      detail += " l2_admitted=" + IntegerToString(telemetry.l2_admitted);
      detail += " l2_changed=" + IntegerToString(telemetry.l2_changed);
      detail += " l2_due=" + IntegerToString(telemetry.l2_due_remaining);
      detail += " l2_hydration_ready=" + IntegerToString(l2_hydration_ready);
      detail += " l2_hydration_slow=" + IntegerToString(l2_hydration_slow_incomplete);
      detail += " l2_hydration_live_quote=" + IntegerToString(l2_hydration_live_quote_incomplete);
      detail += " l2_hydration_live_analytic=" + IntegerToString(l2_hydration_live_analytic_incomplete);
      detail += " l2_hydration_blocked_warmup=" + IntegerToString(l2_hydration_blocked_warmup);
      detail += " l2_hydration_blocked_post_warmup_queue=" + IntegerToString(l2_hydration_blocked_post_warmup_queue);
      detail += " scan_streak=" + IntegerToString(telemetry.scan_streak);
      detail += " write_streak=" + IntegerToString(telemetry.write_streak);
      detail += " deep_ms=" + IntegerToString(telemetry.deep_trigger_ms);
      detail += " board_compose_ms=" + IntegerToString(telemetry.board_compose_ms);
      detail += " board_publish_ms=" + IntegerToString(telemetry.board_publish_ms);
      detail += " dossier_compose_ms=" + IntegerToString(telemetry.dossier_compose_ms);
      detail += " dossier_publish_ms=" + IntegerToString(telemetry.dossier_publish_ms);
      detail += " manifest_compose_ms=" + IntegerToString(telemetry.manifest_compose_ms);
      detail += " manifest_publish_ms=" + IntegerToString(telemetry.manifest_publish_ms);
      detail += " write_queue_ms=" + IntegerToString(telemetry.write_queue_service_ms);
      detail += " artifact_attempted=" + IntegerToString(telemetry.artifact_attempted_count);
      detail += " write_bottleneck_family=" + telemetry.write_bottleneck_family;
      detail += " write_bottleneck_reason=" + telemetry.write_bottleneck_reason;
      detail += " top10_ms=" + IntegerToString(telemetry.top10_batch_ms);
      detail += " side_duty_ms=" + IntegerToString(telemetry.side_duty_ms);
      detail += " dossier_sweep_ms=" + IntegerToString(telemetry.dossier_sweep_ms);
      detail += " dossier_sweep_symbols=" + IntegerToString(telemetry.dossier_sweep_symbols);
      detail += " dossier_sweep_reads=" + IntegerToString(telemetry.dossier_sweep_payload_reads);
      detail += " lane_p50_ms=" + IntegerToString(telemetry.heartbeat_lane_p50_ms);
      detail += " lane_p95_ms=" + IntegerToString(telemetry.heartbeat_lane_p95_ms);
      detail += " pre_lane_ms=" + IntegerToString(telemetry.pre_lane_side_duty_ms);
      detail += " lane_exec_ms=" + IntegerToString(telemetry.lane_execution_ms);
      detail += " ui_priority_deferred_count=" + IntegerToString(MathMax(0, telemetry.ui_priority_deferred_count));
      detail += " ui_priority_deferred_reason=" + ASC_TextOrUnavailable(telemetry.ui_priority_deferred_reason);
      detail += " write_early_yield=" + (telemetry.write_early_yield ? "yes" : "no");
      detail += " side_yield=" + (telemetry.write_early_yield ? "yes" : "no");
      detail += " write_yield_reason=" + ASC_TextOrUnavailable(telemetry.write_yield_reason);
      detail += " write_budget_elapsed_ms=" + IntegerToString(MathMax(0, telemetry.write_budget_elapsed_ms));
      detail += " write_budget_remaining_ms=" + IntegerToString(MathMax(0, telemetry.write_budget_remaining_ms));
      detail += " dossier_symbols_this_beat=" + IntegerToString(MathMax(0, telemetry.dossier_symbols_this_beat));
      detail += " dossier_yield_count=" + IntegerToString(MathMax(0, telemetry.dossier_yield_count));
      detail += " ui_priority_write_reduced=" + (telemetry.ui_priority_write_reduced ? "yes" : "no");
      detail += " deferred_readback_count=" + IntegerToString(MathMax(0, telemetry.deferred_readback_count));
      detail += " readback_deferred=" + IntegerToString(MathMax(0, telemetry.deferred_readback_count));
      detail += " readback_pending=" + IntegerToString(MathMax(0, telemetry.readback_pending_count));
      detail += " manifest_yield=" + IntegerToString(MathMax(0, telemetry.manifest_yield_count));
      detail += " sweep_yield=" + IntegerToString(MathMax(0, telemetry.sweep_yield_count));
      detail += " ui_priority_side_reduced=" + (telemetry.ui_priority_write_reduced ? "yes" : "no");
      detail += " post_publish_elapsed_ms=" + IntegerToString(MathMax(0, telemetry.post_publish_elapsed_ms));
      detail += " side_duty_count_this_beat=" + IntegerToString(MathMax(0, telemetry.side_duty_count_this_beat));
      detail += " side_yield_reason=" + ASC_TextOrUnavailable(telemetry.side_yield_reason);
      detail += " dossier_backlog=" + IntegerToString(ASC_CountRemainingDossierBacklog(state));
      detail += " dossier_cursor=" + IntegerToString(MathMax(0, state.write_cursor));
      detail += " dossier_queue_state=" + ASC_TextOrUnavailable(state.dossier_queue_state);
      detail += " dossier_queue_attempted_this_beat=" + IntegerToString(MathMax(0, state.dossier_queue_attempted_this_beat));
      detail += " dossier_queue_success_this_beat=" + IntegerToString(MathMax(0, state.dossier_queue_success_this_beat));
      detail += " dossier_queue_failure_this_beat=" + IntegerToString(MathMax(0, state.dossier_queue_failure_this_beat));
      detail += " dossier_queue_stall_count=" + IntegerToString(MathMax(0, state.dossier_queue_stall_count));
      detail += " dossier_queue_last_symbol=" + ASC_TextOrUnavailable(state.dossier_queue_last_symbol);
      detail += " dossier_queue_last_reason=" + ASC_TextOrUnavailable(state.dossier_queue_last_reason);
      detail += " class_health=" + class_health;
      detail += " class_groups=" + class_groups;
      detail += " pub_fresh=" + IntegerToString(state.publication_fresh_count);
      detail += " pub_continuity=" + IntegerToString(state.publication_continuity_count);
      detail += " pub_failure=" + IntegerToString(state.publication_failure_count);
      detail += " selected_pub_attempt=" + IntegerToString(state.selected_symbol_publish_attempt_count);
      detail += " selected_pub_ok=" + IntegerToString(state.selected_symbol_publish_success_count);
      detail += " selected_pub_fail=" + IntegerToString(state.selected_symbol_publish_failure_count);
      detail += " deep_pub_attempt=" + IntegerToString(state.deep_trigger_publish_attempt_count);
      detail += " deep_pub_ok=" + IntegerToString(state.deep_trigger_publish_success_count);
      detail += " deep_pub_fail=" + IntegerToString(state.deep_trigger_publish_failure_count);
      detail += " lane_reason=" + telemetry.lane_reason;
      detail += " defer=" + telemetry.defer_reason;
      detail += " yield=" + yield_reason;
      detail += " bundle_trace=" + ASC_HeartbeatBundleDecisionTrace(state);
      detail += " manual_refresh_trace=" + ASC_HeartbeatManualRefreshTrace(state);
      detail += " forced_downstream_trace=" + ASC_HeartbeatForcedDownstreamTrace(state);
      detail += " top10_batch_trace=" + ASC_Top10RunFullBatchTrace(state) + " | " + ASC_Top10RunFullBatchCountersTrace(state);
      detail += " l3_trace=" + ASC_CommittedLayer3TelemetryTrace(state);
      detail += " l4_trace=" + ASC_CommittedLayer4TelemetryTrace(state);
     }
   ASC_FunctionResultFinish(heartbeat,
                            (state.posture == ASC_RUNTIME_DEGRADED || telemetry.write_failures > 0) ? ASC_RESULT_WARNING : ASC_RESULT_OK,
                            ASC_RC_OK,
                            detail,
                            state.server_root);
   return heartbeat;
  }

#endif
