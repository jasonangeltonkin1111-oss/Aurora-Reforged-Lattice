#ifndef __ASC_EXPLORER_SNAPSHOT_MQH__
#define __ASC_EXPLORER_SNAPSHOT_MQH__

#include "ASC_Common.mqh"
#include "ASC_FileIO.mqh"
#include "ASC_ExplorerBuckets.mqh"

extern ASC_ServerPaths g_paths;
extern ASC_RuntimeSettings g_settings;
extern ASC_RuntimeState g_runtime;
extern ASC_Logger g_logger;
extern ASC_PreparedBucketState g_prepared_buckets;
extern ASC_SymbolState g_symbols[];
extern int g_symbol_count;
extern int g_runtime_shortlist_selected_count;
extern int g_runtime_shortlist_pending_count;
extern int g_runtime_shortlist_filter_blocked_count;
extern int g_runtime_shortlist_global_cap_blocked_count;
extern int g_runtime_shortlist_bucket_cap_blocked_count;

string ASC_ExplorerSnapshotCapabilityState(const bool active,const string active_text,const string pending_text)
  {
   return(active ? active_text : pending_text);
  }

string ASC_ExplorerSnapshotFilePath(void)
  {
   return(ASC_JoinPath(g_paths.dev_folder,"ASC_EXPLORER_SNAPSHOT.txt"));
  }

string ASC_ExplorerSnapshotRemainingDueText(void)
  {
   string summary=ASC_ToLower(ASC_Trim(g_runtime.diagnostics.bounded_work_pressure_summary));
   int marker=StringFind(summary,"due=");
   if(marker<0)
      return("n/a");
   string remainder=StringSubstr(g_runtime.diagnostics.bounded_work_pressure_summary,marker+4);
   int separator=StringFind(remainder,"|");
   if(separator>=0)
      remainder=StringSubstr(remainder,0,separator);
   remainder=ASC_Trim(remainder);
   return(remainder=="" ? "n/a" : remainder);
  }

int ASC_ExplorerSnapshotOpenSymbolCount(void)
  {
   int count=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].market_status==ASC_MARKET_OPEN)
         count++;
     }
   return(count);
  }

int ASC_ExplorerSnapshotEligibleCount(void)
  {
   int count=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].filter_readiness==ASC_FILTER_ELIGIBLE && g_symbols[i].filter_eligible)
         count++;
     }
   return(count);
  }

int ASC_ExplorerSnapshotPendingCount(void)
  {
   int count=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      ASC_FilterReadinessStatus readiness=g_symbols[i].filter_readiness;
      if(readiness==ASC_FILTER_PENDING_LAYER1_OR_2
         || readiness==ASC_FILTER_PENDING_CLASSIFICATION
         || readiness==ASC_FILTER_PENDING_TICK_CONTINUITY)
         count++;
     }
   return(count);
  }

int ASC_ExplorerSnapshotIneligibleCount(void)
  {
   int count=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      ASC_FilterReadinessStatus readiness=g_symbols[i].filter_readiness;
      if(readiness!=ASC_FILTER_PENDING_LAYER1_OR_2
         && readiness!=ASC_FILTER_PENDING_CLASSIFICATION
         && readiness!=ASC_FILTER_PENDING_TICK_CONTINUITY
         && readiness!=ASC_FILTER_ELIGIBLE)
         count++;
     }
   return(count);
  }

string ASC_ExplorerSnapshotShortlistSelectedCountText(void)
  {
   int selected=0;
   for(int i=0;i<g_symbol_count;i++)
     {
      if(g_symbols[i].shortlist_selected)
         selected++;
     }
   return(IntegerToString(selected));
  }

string ASC_ExplorerSnapshotLayer3AggregateState(void)
  {
   if(g_runtime_filter_eligible_count>0)
      return("Eligible symbols present");
   if(g_runtime_filter_pending_count>0)
      return("Pending symbols present");
   if(g_runtime_filter_ineligible_count>0)
      return("Ineligible only");
   return("Pending / Watchlist not sampled yet");
  }
string ASC_ExplorerSnapshotMainBucketLine(const ASC_BucketViewModel &bucket)
  {
   int eligible_count=ASC_PreparedBucketEligibleCount(g_prepared_buckets,bucket,g_symbols,g_symbol_count);
   return(bucket.name + " | total=" + IntegerToString(bucket.resolved_symbol_count)
      + " | open=" + IntegerToString(bucket.open_symbol_count)
      + " | eligible=" + IntegerToString(eligible_count));
  }


string ASC_ExplorerSnapshotStatePayload(void)
  {
   int open_symbols=ASC_ExplorerSnapshotOpenSymbolCount();
   int eligible_symbols=ASC_ExplorerSnapshotEligibleCount();
   int ineligible_symbols=ASC_ExplorerSnapshotIneligibleCount();
   int pending_symbols=ASC_ExplorerSnapshotPendingCount();

   string body="[Capability Status]\r\n";
   body+="Market Status: " + ASC_ExplorerSnapshotCapabilityState(g_runtime.layer1_boot_complete,"Ready","Preparing") + "\r\n";
   body+="Open Symbol Snapshot: " + ASC_SnapshotReadinessText(g_runtime.open_symbol_snapshot.readiness) + "\r\n";
   body+="Candidate Filtering: " + ASC_ExplorerSnapshotLayer3AggregateState() + "\r\n";
   body+="Shortlist: " + ASC_ShortlistReadinessText(g_runtime.shortlist.readiness) + " | hold until " + ASC_DateTimeText(g_runtime.shortlist_hold_until) + "\r\n";
   body+="Deep Analysis: promoted-set cadence only | last cadence wave flows through scheduler state and selective persistence.\r\n";

   body+="\r\n[Universe Summary]\r\n";
   body+="Total Symbols: " + IntegerToString(g_runtime.symbol_count) + "\r\n";
   body+="Open Symbols: " + IntegerToString(open_symbols) + "\r\n";
   body+="Eligible Symbols: " + IntegerToString(g_runtime_filter_eligible_count) + "\r\n";
   body+="Shortlisted Symbols: " + IntegerToString(g_runtime_shortlist_selected_count) + "\r\n";

   body+="\r\n[Main Buckets]\r\n";
   for(int i=0;i<ArraySize(g_prepared_buckets.buckets);i++)
     {
      ASC_BucketViewModel bucket=g_prepared_buckets.buckets[i];
      body+=ASC_ExplorerSnapshotMainBucketLine(bucket) + "\r\n";
     }

   body+="\r\n[Filter Summary]\r\n";
   body+="Eligible: " + IntegerToString(eligible_symbols) + "\r\n";
   body+="Ineligible: " + IntegerToString(ineligible_symbols) + "\r\n";
   body+="Pending: " + IntegerToString(g_runtime_filter_pending_count) + "\r\n";
   body+="\r\n[Shortlist Summary]\r\n";
   body+="Selected: " + IntegerToString(g_runtime_shortlist_selected_count) + "\r\n";
   body+="Pending: " + IntegerToString(g_runtime_shortlist_pending_count) + "\r\n";
   body+="Blocked By Filter: " + IntegerToString(g_runtime_shortlist_filter_blocked_count) + "\r\n";
   body+="Visible Slots Per Bucket: 5\r\n";
   body+="Current State: " + ASC_ShortlistReadinessText(g_runtime.shortlist.readiness) + "\r\n";

   body+="\r\n[Scheduler Summary]\r\n";
   body+="Heartbeat Budget: " + IntegerToString(g_settings.symbol_budget_per_heartbeat) + "\r\n";
   body+="Processed Last Pulse: " + IntegerToString(g_runtime.processed_this_heartbeat) + "\r\n";
   body+="Last Dispatcher Lane: " + ASC_DispatchLaneText((ASC_DispatchLane)g_runtime.last_dispatcher_lane) + "\r\n";
   body+="Last Dispatcher Summary: " + g_runtime.last_dispatcher_summary + "\r\n";
   body+="Remaining Due: " + ASC_ExplorerSnapshotRemainingDueText() + "\r\n";

   body+="\r\n[Notes]\r\n";
   body+="Read-only runtime snapshot; uses current runtime and grouping data only.\r\n";
   body+="Candidate Filtering is shown as an aggregate state, not the last processed symbol.\r\n";
   body+="Shortlist is active as a top-5-per-main-bucket set with a calm hold window and honest sparse-bucket spill fill.\r\n";
   return(body);
  }

string ASC_ExplorerSnapshotContent(const datetime stamped_at,const string state_payload)
  {
   string body="ASC Explorer Snapshot\r\n";
   body+="\r\n[Header]\r\n";
   body+="Wrapper Version: " + ASC_WRAPPER_VERSION + "\r\n";
   body+="Explorer Version: " + ASC_EXPLORER_SUBSYSTEM_VERSION + "\r\n";
   body+="Runtime Mode: " + ASC_RuntimeModeText(g_runtime.mode) + "\r\n";
   body+="Timestamp: " + ASC_DateTimeText(stamped_at) + "\r\n\r\n";
   body+=state_payload;
   return(body);
  }

bool ASC_WriteExplorerSnapshot()
  {
   static string s_last_snapshot_content="";
   static datetime s_last_snapshot_write_at=0;

   string state_payload=ASC_ExplorerSnapshotStatePayload();
   bool changed=(state_payload!=s_last_snapshot_content);
   datetime now=TimeTradeServer();
   if(now<=0)
      now=TimeCurrent();
   if(now<=0)
      now=g_runtime.last_heartbeat_at;

   if(!changed)
      return(false);
   if(s_last_snapshot_write_at>0 && (now-s_last_snapshot_write_at)<1)
      return(false);

   string path=ASC_ExplorerSnapshotFilePath();
   string content=ASC_ExplorerSnapshotContent(now,state_payload);
   if(!ASC_AtomicWrite(path,content,g_logger))
      return(false);

   s_last_snapshot_content=state_payload;
   s_last_snapshot_write_at=now;
   return(true);
  }

#endif
