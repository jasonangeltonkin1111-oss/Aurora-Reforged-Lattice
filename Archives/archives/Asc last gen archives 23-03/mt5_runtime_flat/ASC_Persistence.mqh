#ifndef __ASC_PERSISTENCE_MQH__
#define __ASC_PERSISTENCE_MQH__

#include "ASC_Common.mqh"
#include "ASC_FileIO.mqh"
#include "ASC_Classification.mqh"

bool ASC_ParseKeyValueLine(const string line,string &key,string &value)
  {
   int pivot=StringFind(line,"=");
   if(pivot<0)
      return(false);
   key=ASC_Trim(StringSubstr(line,0,pivot));
   value=ASC_Trim(StringSubstr(line,pivot+1));
   return(key!="");
  }

bool ASC_ReadContinuityWithFallback(const string primary_path,string &body,ASC_Logger &logger)
  {
   if(ASC_ReadTextFile(primary_path,body) && body!="")
      return(true);

   string backup_path=primary_path + ".last-good";
   if(ASC_ReadTextFile(backup_path,body) && body!="")
     {
      logger.Warn("Persistence","restored from last-good backup for " + primary_path);
      return(true);
     }

   body="";
   return(false);
  }

void ASC_AssignRuntimeField(ASC_RuntimeState &state,const string key,const string value)
  {
   if(key=="Schema Version") state.schema_version=value;
   else if(key=="Server Raw") state.server_raw=value;
   else if(key=="Server Clean") state.server_clean=value;
   else if(key=="Runtime Mode") state.mode=ASC_RuntimeModeFromText(value);
   else if(key=="Boot At") ASC_TryParseDateTime(value,state.boot_at);
   else if(key=="Last Heartbeat") ASC_TryParseDateTime(value,state.last_heartbeat_at);
   else if(key=="Last Universe Sync") ASC_TryParseDateTime(value,state.last_universe_sync_at);
   else if(key=="Last Runtime Save") ASC_TryParseDateTime(value,state.last_runtime_save_at);
   else if(key=="Last Scheduler Save") ASC_TryParseDateTime(value,state.last_scheduler_save_at);
   else if(key=="Last Summary Save") ASC_TryParseDateTime(value,state.last_summary_save_at);
   else if(key=="Recovery Used") state.recovery_used=ASC_BoolFromText(value);
   else if(key=="Degraded") state.degraded=ASC_BoolFromText(value);
   else if(key=="Symbol Count") state.symbol_count=ASC_IntegerFromText(value);
   else if(key=="Processed This Heartbeat") state.processed_this_heartbeat=ASC_IntegerFromText(value);
   else if(key=="Scheduler Cursor") state.scheduler_cursor=ASC_IntegerFromText(value);
   else if(key=="Heartbeats Since Boot") state.heartbeats_since_boot=ASC_IntegerFromText(value);
   else if(key=="Total Symbols Discovered") state.total_symbols_discovered=ASC_IntegerFromText(value);
   else if(key=="Initial Symbols Assessed") state.initial_symbols_assessed=ASC_IntegerFromText(value);
   else if(key=="Primary Bucket Symbols Assessed") state.primary_bucket_symbols_assessed=ASC_IntegerFromText(value);
   else if(key=="Primary Bucket Symbol Count") state.primary_bucket_symbol_count=ASC_IntegerFromText(value);
   else if(key=="Compressed Primary Buckets Ready") state.compressed_primary_buckets_ready=ASC_BoolFromText(value);
   else if(key=="Warmup Minimum Met") state.warmup_minimum_met=ASC_BoolFromText(value);
   else if(key=="Warmup Progress Percent") state.warmup_progress_percent=ASC_IntegerFromText(value);
   else if(key=="Background Hydration Active") state.background_hydration_active=ASC_BoolFromText(value);
   else if(key=="Readiness Percent") state.readiness_percent=ASC_IntegerFromText(value);
   else if(key=="Prepared Last Batch Id") state.prepared_last_batch_id=ASC_IntegerFromText(value);
   else if(key=="Prepared Promoted Batch Count") state.prepared_promoted_batch_count=ASC_IntegerFromText(value);
   else if(key=="Prepared Pending Batch Count") state.prepared_pending_batch_count=ASC_IntegerFromText(value);
   else if(key=="Prepared Bounded Work Summary") state.prepared_bounded_work_summary=value;
   else if(key=="Open Symbol Snapshot Readiness") state.open_symbol_snapshot.readiness=ASC_SnapshotReadinessFromText(value);
   else if(key=="Open Symbol Snapshot Last Built") ASC_TryParseDateTime(value,state.open_symbol_snapshot.last_built_at);
   else if(key=="Open Symbol Snapshot Pending Reason") state.open_symbol_snapshot.pending_reason=value;
   else if(key=="Open Symbol Snapshot Has Last Good") state.open_symbol_snapshot.has_last_good=ASC_BoolFromText(value);
   else if(key=="Open Symbol Snapshot Last-Good Preserved") state.open_symbol_snapshot.last_good_preserved=ASC_BoolFromText(value);
   else if(key=="Open Symbol Snapshot Last-Good Built") ASC_TryParseDateTime(value,state.open_symbol_snapshot.last_good_built_at);
   else if(key=="Open Symbol Snapshot Controls Reserved") state.open_symbol_snapshot.cadence.controls_reserved=ASC_BoolFromText(value);
   else if(key=="Open Symbol Snapshot Reserved M1 Bars") state.open_symbol_snapshot.cadence.reserved_m1_bars=ASC_IntegerFromText(value);
   else if(key=="Open Symbol Snapshot Reserved M5 Bars") state.open_symbol_snapshot.cadence.reserved_m5_bars=ASC_IntegerFromText(value);
   else if(key=="Open Symbol Snapshot Reserved M15 Bars") state.open_symbol_snapshot.cadence.reserved_m15_bars=ASC_IntegerFromText(value);
   else if(key=="Candidate Filter Readiness") state.candidate_filter.readiness=ASC_FilterReadinessFromText(value);
   else if(key=="Candidate Filter Last Evaluated") ASC_TryParseDateTime(value,state.candidate_filter.last_evaluated_at);
   else if(key=="Candidate Filter Pending Reason") state.candidate_filter.pending_reason=value;
   else if(key=="Candidate Filter Characterization") state.candidate_filter.characterization=value;
   else if(key=="Candidate Filter Eligible") state.candidate_filter.eligible=ASC_BoolFromText(value);
   else if(key=="Shortlist Readiness") state.shortlist.readiness=ASC_ShortlistReadinessFromText(value);
   else if(key=="Shortlist Last Evaluated") ASC_TryParseDateTime(value,state.shortlist.last_evaluated_at);
   else if(key=="Shortlist Pending Reason") state.shortlist.pending_reason=value;
   else if(key=="Shortlist Basis") state.shortlist.basis=value;
   else if(key=="Shortlist Selected Bucket") state.shortlist.selected_bucket=value;
   else if(key=="Shortlist Selected") state.shortlist.selected=ASC_BoolFromText(value);
   else if(key=="Layer1 Boot Complete") state.layer1_boot_complete=ASC_BoolFromText(value);
   else if(key=="Layer1 Truth Published") state.layer1_truth_published=ASC_BoolFromText(value);
   else if(key=="Last Dispatcher Lane") state.last_dispatcher_lane=ASC_IntegerFromText(value);
   else if(key=="Last Dispatcher Summary") state.last_dispatcher_summary=value;
   else if(key=="Last Dispatcher At") ASC_TryParseDateTime(value,state.last_dispatcher_at);
   else if(key=="Shortlist Hold Until") ASC_TryParseDateTime(value,state.shortlist_hold_until);
   else if(key=="Shortlist Last Rebuild") ASC_TryParseDateTime(value,state.shortlist_last_rebuild_at);
   else if(key=="Shortlist Hold Window Seconds") state.shortlist_hold_window_seconds=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Bucket Prep Ms") state.diagnostics.last_bucket_prep_total_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Classification Loop Ms") state.diagnostics.last_classification_loop_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Bucket Sort Ms") state.diagnostics.last_bucket_sort_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Prepared Symbol Reorder Ms") state.diagnostics.last_prepared_symbol_reorder_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Final Promotion Ms") state.diagnostics.last_final_promotion_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Heartbeat Dispatch Ms") state.diagnostics.last_heartbeat_dispatch_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics HUD Render Ms") state.diagnostics.last_hud_render_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Page Switch Render Ms") state.diagnostics.last_page_switch_action_to_render_ms=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Warmup Progress Percent") state.diagnostics.warmup_progress_percent=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Bounded Work Summary") state.diagnostics.bounded_work_pressure_summary=value;
   else if(key=="Diagnostics Last Promoted Batch Id") state.diagnostics.last_promoted_prepared_batch_id=ASC_IntegerFromText(value);
   else if(key=="Diagnostics Active Hydration Priority Set") state.diagnostics.active_hydration_priority_set=value;
   else if(key=="Diagnostics Scheduler Priority Summary") state.diagnostics.scheduler_priority_summary=value;
   else if(key=="Diagnostics Last HUD Render At") ASC_TryParseDateTime(value,state.diagnostics.last_hud_render_at);
  }

bool ASC_LoadRuntimeState(const ASC_ServerPaths &paths,ASC_RuntimeState &state,ASC_Logger &logger)
  {
   string body="";
   if(!ASC_ReadContinuityWithFallback(paths.runtime_state_file,body,logger))
      return(false);

   string lines[];
   int count=StringSplit(body,'\n',lines);
   for(int i=0;i<count;i++)
     {
      string key="";
      string value="";
      if(ASC_ParseKeyValueLine(lines[i],key,value))
         ASC_AssignRuntimeField(state,key,value);
     }

   if(state.schema_version=="")
     {
      logger.Warn("RuntimeState","runtime continuity missing schema version; ignoring restore");
      return(false);
     }

   state.runtime_dirty=false;
   logger.Info("RuntimeState","restored runtime continuity");
   return(true);
  }

bool ASC_LoadSchedulerState(const ASC_ServerPaths &paths,ASC_SymbolState &states[],const int count,ASC_Logger &logger)
  {
   string body="";
   if(!ASC_ReadContinuityWithFallback(paths.scheduler_state_file,body,logger))
      return(false);

   string lines[];
   int line_count=StringSplit(body,'\n',lines);
   int restored=0;
   for(int i=0;i<line_count;i++)
     {
      string line=ASC_Trim(lines[i]);
      if(line=="" || StringFind(line,"|")<0 || StringFind(line,"=")>=0)
         continue;

      string parts[];
      int part_count=StringSplit(line,'|',parts);
      if(part_count<8)
         continue;

      string symbol=ASC_Trim(parts[0]);
      for(int s=0;s<count;s++)
        {
         if(states[s].symbol!=symbol)
            continue;
         states[s].market_status=ASC_MarketStatusFromText(parts[1]);
         ASC_TryParseDateTime(parts[2],states[s].next_check_at);
         ASC_TryParseDateTime(parts[3],states[s].last_tick_seen_at);
         ASC_TryParseDateTime(parts[4],states[s].last_checked_at);
         states[s].uncertain_burst_count=ASC_IntegerFromText(parts[5]);
         states[s].status_note=parts[6];
         states[s].next_check_reason=parts[7];
         if(part_count>=25)
           {
            states[s].snapshot_readiness=ASC_SnapshotReadinessFromText(parts[8]);
            ASC_TryParseDateTime(parts[9],states[s].snapshot_last_built_at);
            states[s].snapshot_pending_reason=parts[10];
            states[s].snapshot_bid=ASC_NumberFromText(parts[11]);
            states[s].snapshot_ask=ASC_NumberFromText(parts[12]);
            states[s].snapshot_spread=ASC_NumberFromText(parts[13]);
            states[s].snapshot_day_high=ASC_NumberFromText(parts[14]);
            states[s].snapshot_day_low=ASC_NumberFromText(parts[15]);
            states[s].snapshot_point=ASC_NumberFromText(parts[16]);
            states[s].snapshot_digits=ASC_IntegerFromText(parts[17]);
            states[s].snapshot_contract_size=ASC_NumberFromText(parts[18]);
            states[s].snapshot_volume_min=ASC_NumberFromText(parts[19]);
            states[s].snapshot_volume_step=ASC_NumberFromText(parts[20]);
            states[s].snapshot_volume_max=ASC_NumberFromText(parts[21]);
            states[s].snapshot_trade_mode=ASC_IntegerFromText(parts[22]);
            states[s].snapshot_stops_level=ASC_IntegerFromText(parts[23]);
            states[s].snapshot_freeze_level=ASC_IntegerFromText(parts[24]);
           }
         if(part_count>=42)
           {
            states[s].snapshot_spread_floating=ASC_BoolFromText(parts[25]);
            states[s].snapshot_tick_size=ASC_NumberFromText(parts[26]);
            states[s].snapshot_tick_value=ASC_NumberFromText(parts[27]);
            states[s].snapshot_margin_currency=parts[28];
            states[s].snapshot_profit_currency=parts[29];
            states[s].snapshot_chart_mode=ASC_IntegerFromText(parts[30]);
            states[s].snapshot_trade_execution=ASC_IntegerFromText(parts[31]);
            states[s].snapshot_order_mode=ASC_IntegerFromText(parts[32]);
            states[s].snapshot_filling_mode=ASC_IntegerFromText(parts[33]);
            states[s].snapshot_gtc_mode=ASC_IntegerFromText(parts[34]);
            states[s].snapshot_expiration_mode=ASC_IntegerFromText(parts[35]);
            states[s].snapshot_swap_type=ASC_IntegerFromText(parts[36]);
            states[s].snapshot_swap_long=ASC_NumberFromText(parts[37]);
            states[s].snapshot_swap_short=ASC_NumberFromText(parts[38]);
            states[s].snapshot_spread_price=ASC_NumberFromText(parts[39]);
            states[s].snapshot_spread_percent=ASC_NumberFromText(parts[40]);
            states[s].snapshot_atr_m1=ASC_NumberFromText(parts[41]);
           }
         if(part_count>=46)
           {
            states[s].snapshot_spread_to_atr_percent=ASC_NumberFromText(parts[42]);
            states[s].snapshot_has_last_good=ASC_BoolFromText(parts[43]);
            states[s].snapshot_last_good_preserved=ASC_BoolFromText(parts[44]);
            ASC_TryParseDateTime(parts[45],states[s].snapshot_last_good_built_at);
           }
         if(part_count>=51)
           {
            states[s].filter_readiness=ASC_FilterReadinessFromText(parts[46]);
            ASC_TryParseDateTime(parts[47],states[s].filter_last_evaluated_at);
            states[s].filter_pending_reason=parts[48];
            states[s].filter_characterization=parts[49];
            states[s].filter_eligible=ASC_BoolFromText(parts[50]);
           }
         if(part_count>=57)
           {
            states[s].shortlist_readiness=ASC_ShortlistReadinessFromText(parts[51]);
            ASC_TryParseDateTime(parts[52],states[s].shortlist_last_evaluated_at);
            states[s].shortlist_pending_reason=parts[53];
            states[s].shortlist_basis=parts[54];
            states[s].shortlist_bucket=parts[55];
            states[s].shortlist_selected=ASC_BoolFromText(parts[56]);
           }
         if(part_count>=62)
           {
            states[s].shortlist_rank=ASC_IntegerFromText(parts[57]);
            states[s].shortlist_display_bucket=parts[58];
            states[s].shortlist_spill_fill=ASC_BoolFromText(parts[59]);
            ASC_TryParseDateTime(parts[60],states[s].layer5_last_update_at);
            states[s].publication_ok=ASC_BoolFromText(parts[61]);
           }
         if(part_count>=65)
           {
            states[s].snapshot_atr_m1_reliable=ASC_BoolFromText(parts[62]);
            states[s].snapshot_atr_m1_active_tr_count=ASC_IntegerFromText(parts[63]);
            ASC_TryParseDateTime(parts[64],states[s].last_dossier_write_at);
           }
         states[s].publication_ok=FileIsExist(ASC_JoinPath(paths.universe_folder,states[s].dossier_file),FILE_COMMON);
         states[s].dirty=true;
         restored++;
         break;
        }
     }

   logger.Info("SchedulerState","restored scheduler continuity for " + IntegerToString(restored) + " symbols");
   return(restored>0);
  }

bool ASC_SaveRuntimeState(const ASC_ServerPaths &paths,ASC_RuntimeState &state,ASC_Logger &logger)
  {
   datetime saved_at=TimeCurrent();
   string now_text=ASC_DateTimeText(saved_at);
   string body="";
   body+="Schema Version=ASC Foundation v1\r\n";
   body+="Format Family=Runtime Continuity\r\n";
   body+="Product=" + ASC_PRODUCT_NAME + "\r\n";
   body+="Wrapper Version=" + ASC_WRAPPER_VERSION + "\r\n";
   body+="Active Capability=" + ASC_ACTIVE_CAPABILITY + "\r\n";
   body+="Next Planned Capability=" + ASC_NEXT_CAPABILITY + "\r\n";
   body+="Generated At=" + now_text + "\r\n";
   body+="Server Raw=" + state.server_raw + "\r\n";
   body+="Server Clean=" + state.server_clean + "\r\n";
   body+="Runtime Mode=" + ASC_RuntimeModeText(state.mode) + "\r\n";
   body+="Boot At=" + ASC_DateTimeText(state.boot_at) + "\r\n";
   body+="Last Heartbeat=" + ASC_DateTimeText(state.last_heartbeat_at) + "\r\n";
   body+="Last Universe Sync=" + ASC_DateTimeText(state.last_universe_sync_at) + "\r\n";
   body+="Last Runtime Save=" + now_text + "\r\n";
   body+="Last Scheduler Save=" + ASC_DateTimeText(state.last_scheduler_save_at) + "\r\n";
   body+="Last Summary Save=" + ASC_DateTimeText(state.last_summary_save_at) + "\r\n";
   body+="Recovery Used=" + ASC_BoolText(state.recovery_used) + "\r\n";
   body+="Degraded=" + ASC_BoolText(state.degraded) + "\r\n";
   body+="Symbol Count=" + IntegerToString(state.symbol_count) + "\r\n";
   body+="Processed This Heartbeat=" + IntegerToString(state.processed_this_heartbeat) + "\r\n";
   body+="Scheduler Cursor=" + IntegerToString(state.scheduler_cursor) + "\r\n";
   body+="Heartbeats Since Boot=" + IntegerToString(state.heartbeats_since_boot) + "\r\n";
   body+="Total Symbols Discovered=" + IntegerToString(state.total_symbols_discovered) + "\r\n";
   body+="Initial Symbols Assessed=" + IntegerToString(state.initial_symbols_assessed) + "\r\n";
   body+="Primary Bucket Symbols Assessed=" + IntegerToString(state.primary_bucket_symbols_assessed) + "\r\n";
   body+="Primary Bucket Symbol Count=" + IntegerToString(state.primary_bucket_symbol_count) + "\r\n";
   body+="Compressed Primary Buckets Ready=" + ASC_BoolText(state.compressed_primary_buckets_ready) + "\r\n";
   body+="Warmup Minimum Met=" + ASC_BoolText(state.warmup_minimum_met) + "\r\n";
   body+="Warmup Progress Percent=" + IntegerToString(state.warmup_progress_percent) + "\r\n";
   body+="Background Hydration Active=" + ASC_BoolText(state.background_hydration_active) + "\r\n";
   body+="Readiness Percent=" + IntegerToString(state.readiness_percent) + "\r\n";
   body+="Prepared Last Batch Id=" + IntegerToString(state.prepared_last_batch_id) + "\r\n";
   body+="Prepared Promoted Batch Count=" + IntegerToString(state.prepared_promoted_batch_count) + "\r\n";
   body+="Prepared Pending Batch Count=" + IntegerToString(state.prepared_pending_batch_count) + "\r\n";
   body+="Prepared Bounded Work Summary=" + state.prepared_bounded_work_summary + "\r\n";
   body+="Open Symbol Snapshot Readiness=" + ASC_SnapshotReadinessText(state.open_symbol_snapshot.readiness) + "\r\n";
   body+="Open Symbol Snapshot Last Built=" + ASC_DateTimeText(state.open_symbol_snapshot.last_built_at) + "\r\n";
   body+="Open Symbol Snapshot Pending Reason=" + state.open_symbol_snapshot.pending_reason + "\r\n";
   body+="Open Symbol Snapshot Has Last Good=" + ASC_BoolText(state.open_symbol_snapshot.has_last_good) + "\r\n";
   body+="Open Symbol Snapshot Last-Good Preserved=" + ASC_BoolText(state.open_symbol_snapshot.last_good_preserved) + "\r\n";
   body+="Open Symbol Snapshot Last-Good Built=" + ASC_DateTimeText(state.open_symbol_snapshot.last_good_built_at) + "\r\n";
   body+="Open Symbol Snapshot Controls Reserved=" + ASC_BoolText(state.open_symbol_snapshot.cadence.controls_reserved) + "\r\n";
   body+="Open Symbol Snapshot Reserved M1 Bars=" + IntegerToString(state.open_symbol_snapshot.cadence.reserved_m1_bars) + "\r\n";
   body+="Open Symbol Snapshot Reserved M5 Bars=" + IntegerToString(state.open_symbol_snapshot.cadence.reserved_m5_bars) + "\r\n";
   body+="Open Symbol Snapshot Reserved M15 Bars=" + IntegerToString(state.open_symbol_snapshot.cadence.reserved_m15_bars) + "\r\n";
   body+="Candidate Filter Readiness=" + ASC_FilterReadinessText(state.candidate_filter.readiness) + "\r\n";
   body+="Candidate Filter Last Evaluated=" + ASC_DateTimeText(state.candidate_filter.last_evaluated_at) + "\r\n";
   body+="Candidate Filter Pending Reason=" + state.candidate_filter.pending_reason + "\r\n";
   body+="Candidate Filter Characterization=" + state.candidate_filter.characterization + "\r\n";
   body+="Candidate Filter Eligible=" + ASC_BoolText(state.candidate_filter.eligible) + "\r\n";
   body+="Shortlist Readiness=" + ASC_ShortlistReadinessText(state.shortlist.readiness) + "\r\n";
   body+="Shortlist Last Evaluated=" + ASC_DateTimeText(state.shortlist.last_evaluated_at) + "\r\n";
   body+="Shortlist Pending Reason=" + state.shortlist.pending_reason + "\r\n";
   body+="Shortlist Basis=" + state.shortlist.basis + "\r\n";
   body+="Shortlist Selected Bucket=" + state.shortlist.selected_bucket + "\r\n";
   body+="Shortlist Selected=" + ASC_BoolText(state.shortlist.selected) + "\r\n";
   body+="Layer1 Boot Complete=" + ASC_BoolText(state.layer1_boot_complete) + "\r\n";
   body+="Layer1 Truth Published=" + ASC_BoolText(state.layer1_truth_published) + "\r\n";
   body+="Last Dispatcher Lane=" + IntegerToString(state.last_dispatcher_lane) + "\r\n";
   body+="Last Dispatcher Summary=" + state.last_dispatcher_summary + "\r\n";
   body+="Last Dispatcher At=" + ASC_DateTimeText(state.last_dispatcher_at) + "\r\n";
   body+="Shortlist Hold Until=" + ASC_DateTimeText(state.shortlist_hold_until) + "\r\n";
   body+="Shortlist Last Rebuild=" + ASC_DateTimeText(state.shortlist_last_rebuild_at) + "\r\n";
   body+="Shortlist Hold Window Seconds=" + IntegerToString(state.shortlist_hold_window_seconds) + "\r\n";
   body+="Diagnostics Bucket Prep Ms=" + IntegerToString((int)state.diagnostics.last_bucket_prep_total_ms) + "\r\n";
   body+="Diagnostics Classification Loop Ms=" + IntegerToString((int)state.diagnostics.last_classification_loop_ms) + "\r\n";
   body+="Diagnostics Bucket Sort Ms=" + IntegerToString((int)state.diagnostics.last_bucket_sort_ms) + "\r\n";
   body+="Diagnostics Prepared Symbol Reorder Ms=" + IntegerToString((int)state.diagnostics.last_prepared_symbol_reorder_ms) + "\r\n";
   body+="Diagnostics Final Promotion Ms=" + IntegerToString((int)state.diagnostics.last_final_promotion_ms) + "\r\n";
   body+="Diagnostics Heartbeat Dispatch Ms=" + IntegerToString((int)state.diagnostics.last_heartbeat_dispatch_ms) + "\r\n";
   body+="Diagnostics HUD Render Ms=" + IntegerToString((int)state.diagnostics.last_hud_render_ms) + "\r\n";
   body+="Diagnostics Page Switch Render Ms=" + IntegerToString((int)state.diagnostics.last_page_switch_action_to_render_ms) + "\r\n";
   body+="Diagnostics Warmup Progress Percent=" + IntegerToString(state.diagnostics.warmup_progress_percent) + "\r\n";
   body+="Diagnostics Bounded Work Summary=" + state.diagnostics.bounded_work_pressure_summary + "\r\n";
   body+="Diagnostics Last Promoted Batch Id=" + IntegerToString(state.diagnostics.last_promoted_prepared_batch_id) + "\r\n";
   body+="Diagnostics Active Hydration Priority Set=" + state.diagnostics.active_hydration_priority_set + "\r\n";
   body+="Diagnostics Scheduler Priority Summary=" + state.diagnostics.scheduler_priority_summary + "\r\n";
   body+="Diagnostics Last HUD Render At=" + ASC_DateTimeText(state.diagnostics.last_hud_render_at) + "\r\n";
   bool ok=ASC_AtomicWrite(paths.runtime_state_file,body,logger);
   if(ok)
     {
      state.last_runtime_save_at=saved_at;
      state.runtime_dirty=false;
      logger.Info("RuntimeState","saved runtime state");
     }
   return(ok);
  }

bool ASC_SaveSchedulerState(const ASC_ServerPaths &paths,ASC_SymbolState &states[],const int count,ASC_Logger &logger)
  {
   string body="Schema Version=ASC Foundation v1\r\n";
   body+="Format Family=Scheduler Continuity\r\n";
   body+="Generated At=" + ASC_DateTimeText(TimeCurrent()) + "\r\n\r\n";
   for(int i=0;i<count;i++)
     {
      body+=states[i].symbol
         + "|" + ASC_MarketStatusText(states[i].market_status)
         + "|" + ASC_DateTimeText(states[i].next_check_at)
         + "|" + ASC_DateTimeText(states[i].last_tick_seen_at)
         + "|" + ASC_DateTimeText(states[i].last_checked_at)
         + "|" + IntegerToString(states[i].uncertain_burst_count)
         + "|" + states[i].status_note
         + "|" + states[i].next_check_reason
         + "|" + ASC_SnapshotReadinessText(states[i].snapshot_readiness)
         + "|" + ASC_DateTimeText(states[i].snapshot_last_built_at)
         + "|" + states[i].snapshot_pending_reason
         + "|" + DoubleToString(states[i].snapshot_bid,8)
         + "|" + DoubleToString(states[i].snapshot_ask,8)
         + "|" + DoubleToString(states[i].snapshot_spread,0)
         + "|" + DoubleToString(states[i].snapshot_day_high,8)
         + "|" + DoubleToString(states[i].snapshot_day_low,8)
         + "|" + DoubleToString(states[i].snapshot_point,8)
         + "|" + IntegerToString(states[i].snapshot_digits)
         + "|" + DoubleToString(states[i].snapshot_contract_size,2)
         + "|" + DoubleToString(states[i].snapshot_volume_min,4)
         + "|" + DoubleToString(states[i].snapshot_volume_step,4)
         + "|" + DoubleToString(states[i].snapshot_volume_max,4)
         + "|" + IntegerToString((int)states[i].snapshot_trade_mode)
         + "|" + IntegerToString((int)states[i].snapshot_stops_level)
         + "|" + IntegerToString((int)states[i].snapshot_freeze_level)
         + "|" + ASC_BoolText(states[i].snapshot_spread_floating)
         + "|" + DoubleToString(states[i].snapshot_tick_size,8)
         + "|" + DoubleToString(states[i].snapshot_tick_value,8)
         + "|" + states[i].snapshot_margin_currency
         + "|" + states[i].snapshot_profit_currency
         + "|" + IntegerToString((int)states[i].snapshot_chart_mode)
         + "|" + IntegerToString((int)states[i].snapshot_trade_execution)
         + "|" + IntegerToString((int)states[i].snapshot_order_mode)
         + "|" + IntegerToString((int)states[i].snapshot_filling_mode)
         + "|" + IntegerToString((int)states[i].snapshot_gtc_mode)
         + "|" + IntegerToString((int)states[i].snapshot_expiration_mode)
         + "|" + IntegerToString((int)states[i].snapshot_swap_type)
         + "|" + DoubleToString(states[i].snapshot_swap_long,8)
         + "|" + DoubleToString(states[i].snapshot_swap_short,8)
         + "|" + DoubleToString(states[i].snapshot_spread_price,8)
         + "|" + DoubleToString(states[i].snapshot_spread_percent,6)
         + "|" + DoubleToString(states[i].snapshot_atr_m1,8)
         + "|" + DoubleToString(states[i].snapshot_spread_to_atr_percent,6)
         + "|" + ASC_BoolText(states[i].snapshot_has_last_good)
         + "|" + ASC_BoolText(states[i].snapshot_last_good_preserved)
         + "|" + ASC_DateTimeText(states[i].snapshot_last_good_built_at)
         + "|" + ASC_FilterReadinessText(states[i].filter_readiness)
         + "|" + ASC_DateTimeText(states[i].filter_last_evaluated_at)
         + "|" + states[i].filter_pending_reason
         + "|" + states[i].filter_characterization
         + "|" + ASC_BoolText(states[i].filter_eligible)
         + "|" + ASC_ShortlistReadinessText(states[i].shortlist_readiness)
         + "|" + ASC_DateTimeText(states[i].shortlist_last_evaluated_at)
         + "|" + states[i].shortlist_pending_reason
         + "|" + states[i].shortlist_basis
         + "|" + states[i].shortlist_bucket
         + "|" + ASC_BoolText(states[i].shortlist_selected)
         + "|" + IntegerToString(states[i].shortlist_rank)
         + "|" + states[i].shortlist_display_bucket
         + "|" + ASC_BoolText(states[i].shortlist_spill_fill)
         + "|" + ASC_DateTimeText(states[i].layer5_last_update_at)
         + "|" + ASC_BoolText(states[i].publication_ok)
         + "|" + ASC_BoolText(states[i].snapshot_atr_m1_reliable)
         + "|" + IntegerToString(states[i].snapshot_atr_m1_active_tr_count)
         + "|" + ASC_DateTimeText(states[i].last_dossier_write_at)
         + "\r\n";
     }
   bool ok=ASC_AtomicWrite(paths.scheduler_state_file,body,logger);
   if(ok)
      logger.Info("SchedulerState","saved scheduler state");
   return(ok);
  }


string ASC_SummaryBucketIdFromClassification(const ASC_SymbolClassification &classification)
  {
   if(classification.asset_class=="FX") return("fx");
   if(classification.asset_class=="INDEX") return("indices");
   if(classification.asset_class=="METALS") return("metals");
   if(classification.asset_class=="ENERGY") return("energy");
   if(classification.asset_class=="CRYPTO") return("crypto");
   if(classification.asset_class=="STOCK") return("stocks");
   return("other");
  }

string ASC_SummaryMainBucketId(const ASC_SymbolState &state,const string server_clean)
  {
   ASC_SymbolClassification classification;
   if(ASC_CL_ClassifySymbol(server_clean,state.symbol,classification) && classification.resolved)
      return(ASC_SummaryBucketIdFromClassification(classification));
   return("other");
  }

string ASC_SummaryMainBucketName(const string bucket_id)
  {
   if(bucket_id=="fx") return("FX");
   if(bucket_id=="indices") return("Indices");
   if(bucket_id=="metals") return("Metals");
   if(bucket_id=="energy") return("Energy");
   if(bucket_id=="crypto") return("Crypto");
   if(bucket_id=="stocks") return("Stocks");
   return("Other");
  }

int ASC_SummaryBucketOrder(const string bucket_id)
  {
   if(bucket_id=="fx") return(0);
   if(bucket_id=="indices") return(1);
   if(bucket_id=="metals") return(2);
   if(bucket_id=="energy") return(3);
   if(bucket_id=="crypto") return(4);
   if(bucket_id=="stocks") return(5);
   return(6);
  }

bool ASC_SummaryCandidatePreferred(const ASC_SymbolState &left,const ASC_SymbolState &right)
  {
   if(left.shortlist_selected!=right.shortlist_selected)
      return(left.shortlist_selected && !right.shortlist_selected);

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

void ASC_SummarySortStates(ASC_SymbolState &items[])
  {
   int total=ArraySize(items);
   for(int i=1;i<total;i++)
     {
      ASC_SymbolState key=items[i];
      int j=i-1;
      while(j>=0 && ASC_SummaryCandidatePreferred(key,items[j]))
        {
         items[j+1]=items[j];
         j--;
        }
      items[j+1]=key;
     }
  }

string ASC_SummaryReasonText(const ASC_SymbolState &state)
  {
   if(state.shortlist_selected)
      return(state.shortlist_basis);
   if(state.shortlist_pending_reason!="")
      return(state.shortlist_pending_reason);
   return(state.filter_pending_reason);
  }

bool ASC_SaveSummary(const ASC_ServerPaths &paths,ASC_RuntimeState &runtime,ASC_SymbolState &states[],const int count,ASC_Logger &logger)
  {
   datetime saved_at=TimeCurrent();
   int open_count=0;
   int closed_count=0;
   int uncertain_count=0;
   int unknown_count=0;
   int due_count=0;
   int shortlist_selected_count=0;
   int shortlist_pending_count=0;
   int shortlist_global_cap_blocked_count=0;
   int shortlist_bucket_cap_blocked_count=0;
   int eligible_not_selected_count=0;

   for(int i=0;i<count;i++)
     {
      if(states[i].dirty || states[i].next_check_at<=runtime.last_heartbeat_at)
         due_count++;
      switch(states[i].market_status)
        {
         case ASC_MARKET_OPEN: open_count++; break;
         case ASC_MARKET_CLOSED: closed_count++; break;
         case ASC_MARKET_UNCERTAIN: uncertain_count++; break;
         default: unknown_count++; break;
        }
      if(states[i].shortlist_selected)
         shortlist_selected_count++;
      if(states[i].shortlist_readiness==ASC_SHORTLIST_PENDING_LAYER3)
         shortlist_pending_count++;
      if(states[i].shortlist_readiness==ASC_SHORTLIST_INELIGIBLE_GLOBAL_CAP_REACHED)
         shortlist_global_cap_blocked_count++;
      if(states[i].shortlist_readiness==ASC_SHORTLIST_INELIGIBLE_BUCKET_CAP_REACHED)
         shortlist_bucket_cap_blocked_count++;
      if(states[i].filter_readiness==ASC_FILTER_ELIGIBLE && states[i].filter_eligible && !states[i].shortlist_selected)
         eligible_not_selected_count++;
     }

   string bucket_ids[];
   int bucket_count=6;
   ArrayResize(bucket_ids,bucket_count);
   bucket_ids[0]="fx";
   bucket_ids[1]="indices";
   bucket_ids[2]="metals";
   bucket_ids[3]="energy";
   bucket_ids[4]="crypto";
   bucket_ids[5]="stocks";

   string body="Summary Top 5 per Basket\r\n\r\n";
   body+="Product: " + ASC_PRODUCT_NAME + "\r\n";
   body+="Wrapper Version: " + ASC_WRAPPER_VERSION + "\r\n";
   body+="Schema Version: ASC Foundation v1\r\n";
   body+="Generated At: " + ASC_DateTimeText(saved_at) + "\r\n";
   body+="Server: " + runtime.server_clean + "\r\n";
   body+="Runtime Mode: " + ASC_RuntimeModeText(runtime.mode) + "\r\n";
   body+="Degraded: " + ASC_BoolText(runtime.degraded) + "\r\n";
   body+="Last Heartbeat: " + ASC_DateTimeText(runtime.last_heartbeat_at) + "\r\n";
   body+="Universe Size: " + IntegerToString(count) + "\r\n";
   body+="Due Now: " + IntegerToString(due_count) + "\r\n";
   body+="Open: " + IntegerToString(open_count) + "\r\n";
   body+="Closed: " + IntegerToString(closed_count) + "\r\n";
   body+="Uncertain: " + IntegerToString(uncertain_count) + "\r\n";
   body+="Unknown: " + IntegerToString(unknown_count) + "\r\n\r\n";

   body+="[Shortlist Aggregate]\r\n";
   body+="Selected: " + IntegerToString(shortlist_selected_count) + " / " + IntegerToString(runtime.symbol_count) + "\r\n";
   body+="Eligible Not Selected: " + IntegerToString(eligible_not_selected_count) + "\r\n";
   body+="Pending Identity: " + IntegerToString(shortlist_pending_count) + "\r\n";
   body+="Blocked By Global Cap: " + IntegerToString(shortlist_global_cap_blocked_count) + "\r\n";
   body+="Blocked By Bucket Cap: " + IntegerToString(shortlist_bucket_cap_blocked_count) + "\r\n";
   body+="Current State: " + ASC_ShortlistReadinessText(runtime.shortlist.readiness) + "\r\n\r\n";

   body+="Selection Surface: Layer 4 is active as bounded shortlist admission only. Rows below show shortlisted symbols first, then strongest eligible non-selected near-misses, grouped by main bucket.\r\n\r\n";

   for(int b=0;b<bucket_count;b++)
     {
      string bucket_id=bucket_ids[b];
      ASC_SymbolState bucket_rows[];
      ArrayResize(bucket_rows,0);
      for(int i=0;i<count;i++)
        {
         if(!(states[i].shortlist_selected || (states[i].filter_readiness==ASC_FILTER_ELIGIBLE && states[i].filter_eligible)))
            continue;
         string state_bucket=ASC_SummaryMainBucketId(states[i],runtime.server_clean);
         if(state_bucket!=bucket_id)
            continue;
         int slot=ArraySize(bucket_rows);
         ArrayResize(bucket_rows,slot+1);
         bucket_rows[slot]=states[i];
        }

      ASC_SummarySortStates(bucket_rows);
      body+="[" + ASC_SummaryMainBucketName(bucket_id) + "]\r\n";
      body+="Count: " + IntegerToString(ArraySize(bucket_rows)) + "\r\n";
      if(ArraySize(bucket_rows)<=0)
        {
         body+="No current shortlisted or eligible symbols.\r\n\r\n";
         continue;
        }

      int limit=(ArraySize(bucket_rows)<5 ? ArraySize(bucket_rows) : 5);
      for(int i=0;i<limit;i++)
        {
         ASC_SymbolState row=bucket_rows[i];
         string atr_text=(row.snapshot_atr_m1_reliable ? "Yes" : "No");
         string spread_atr_text=((row.snapshot_atr_m1_reliable && row.snapshot_atr_m1>0.0) ? DoubleToString(row.snapshot_spread_to_atr_percent,1) + "%" : "Not Used");
         string shortlist_text=(row.shortlist_selected ? "Selected" : "Eligible / Not Selected");
         body+=IntegerToString(i+1) + ". " + row.symbol
            + " | L3=" + ASC_FilterReadinessText(row.filter_readiness)
            + " | L4=" + ASC_ShortlistReadinessText(row.shortlist_readiness)
            + " | Status=" + shortlist_text
            + " | Spread=" + DoubleToString(row.snapshot_spread_percent,3) + "%"
            + " | ATR Reliable=" + atr_text
            + " | Spread/ATR=" + spread_atr_text
            + " | Tick Age=" + (row.tick_age_seconds>=0 ? IntegerToString((int)row.tick_age_seconds) + "s" : "Pending")
            + " | Trade Mode=" + ASC_SymbolTradeModeText(row.snapshot_trade_mode)
            + " | Reason=" + ASC_SummaryReasonText(row) + "\r\n";
        }
      body+="\r\n";
     }

   bool ok=ASC_AtomicWrite(paths.summary_file,body,logger);
   if(ok)
     {
      runtime.last_summary_save_at=saved_at;
      runtime.summary_dirty=false;
      logger.Info("Summary","saved trader shortlist summary");
     }
   return(ok);
  }

#endif
