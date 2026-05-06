#ifndef __ASC_DOSSIERS_MQH__
#define __ASC_DOSSIERS_MQH__

#include "ASC_Common.mqh"
#include "ASC_FileIO.mqh"
#include "ASC_Classification.mqh"

string ASC_DossierPublicationStateText(const ASC_ServerPaths &paths,const ASC_SymbolState &state)
  {
   string dossier_path=ASC_JoinPath(paths.universe_folder,state.dossier_file);
   bool published_now=state.publication_ok;
   bool prior_publication_exists=FileIsExist(dossier_path,FILE_COMMON);

   if(published_now)
      return("Current write promoted");
   if(prior_publication_exists)
      return("Current write pending; prior promoted dossier retained");
   return("Awaiting first successful dossier promotion");
  }

string ASC_DossierLastGoodStateText(const ASC_SymbolState &state)
  {
   if(state.snapshot_last_good_preserved)
      return("Yes - prior snapshot preserved after refresh failure");
   if(state.snapshot_has_last_good)
      return("Current fresh snapshot is the active last-good");
   return("No last-good snapshot yet");
  }

string ASC_DossierFilterGateText(const bool passed,const string pass_text,const string fail_text)
  {
   return((passed ? "PASS - " + pass_text : "HOLD - " + fail_text));
  }

string ASC_DossierOperatorText(string text)
  {
   StringReplace(text,"Layer 1","Market Status");
   StringReplace(text,"Layer 2","Open Symbol Snapshot");
   StringReplace(text,"Layer 3","Candidate Filtering");
   StringReplace(text,"Layer 4","Shortlist");
   StringReplace(text,"Layer 5","Deep Analysis");
   StringReplace(text,"prepared truth","grouping data");
   StringReplace(text,"Prepared bucket truth","Grouping data");
   StringReplace(text,"provisional","still loading");
   StringReplace(text,"reserved","not active");
   return(text);
  }

string ASC_DossierFilterReasonCode(const ASC_SymbolState &state)
  {
   switch(state.filter_readiness)
     {
      case ASC_FILTER_INELIGIBLE_MARKET_NOT_OPEN: return("L3_MARKET_NOT_OPEN");
      case ASC_FILTER_INELIGIBLE_SNAPSHOT_UNAVAILABLE: return("L3_SNAPSHOT_UNAVAILABLE");
      case ASC_FILTER_INELIGIBLE_TRADE_MODE_BLOCKED: return("L3_TRADE_MODE_BLOCKED");
      case ASC_FILTER_INELIGIBLE_VOLUME_INVALID: return("L3_VOLUME_INVALID");
      case ASC_FILTER_PENDING_CLASSIFICATION: return("L3_CLASSIFICATION_PENDING");
      case ASC_FILTER_PENDING_TICK_CONTINUITY: return("L3_TICK_CONTINUITY_PENDING");
      case ASC_FILTER_INELIGIBLE_DATA_INVALID: return("L3_DATA_INVALID");
      case ASC_FILTER_INELIGIBLE_SPREAD_EXCESSIVE: return("L3_SPREAD_EXCESSIVE");
      case ASC_FILTER_ELIGIBLE: return("L3_ELIGIBLE");
     }
   return("L3_PENDING_LAYER1_OR_2");
  }

string ASC_DossierShortlistReasonCode(const ASC_SymbolState &state)
  {
   switch(state.shortlist_readiness)
     {
      case ASC_SHORTLIST_INELIGIBLE_MARKET_NOT_OPEN: return("L4_MARKET_NOT_OPEN");
      case ASC_SHORTLIST_INELIGIBLE_FILTER_NOT_ELIGIBLE: return("L4_FILTER_NOT_ELIGIBLE");
      case ASC_SHORTLIST_INELIGIBLE_BUCKET_CAP_REACHED: return("L4_BUCKET_CAP_REACHED");
      case ASC_SHORTLIST_INELIGIBLE_GLOBAL_CAP_REACHED: return("L4_GLOBAL_CAP_REACHED");
      case ASC_SHORTLIST_SELECTED: return("L4_SELECTED");
     }
   return("L4_PENDING_LAYER3");
  }

string ASC_DossierSessionStatusText(const ASC_SymbolState &state)
  {
   if(state.has_trade_sessions)
      return(state.within_trade_session ? "In Session" : "Out Of Session");
   return("Session Unknown");
  }

string ASC_DossierTickStatusText(const ASC_SymbolState &state)
  {
   return(state.has_tick ? "Present" : "Missing");
  }

string ASC_DossierTickAgeText(const ASC_SymbolState &state)
  {
   return(state.tick_age_seconds>=0 ? IntegerToString((int)state.tick_age_seconds) + "s" : "Not Yet Available");
  }

string ASC_DossierSnapshotSummaryText(const ASC_SymbolState &state)
  {
   switch(state.snapshot_readiness)
     {
      case ASC_SNAPSHOT_WORKING_FRESH: return("Fresh");
      case ASC_SNAPSHOT_WORKING_LAST_GOOD: return("Last-Good");
      case ASC_SNAPSHOT_ELIGIBLE_PENDING_BUILD: return("Pending");
      case ASC_SNAPSHOT_DEGRADED_RETRY_PENDING: return("Pending / Retry");
      case ASC_SNAPSHOT_INELIGIBLE_SYMBOL_CLOSED:
      case ASC_SNAPSHOT_INELIGIBLE_MARKET_NOT_OPEN: return("Ineligible");
     }
   return("Pending");
  }

string ASC_DossierSnapshotAgeText(const ASC_SymbolState &state)
  {
   if(state.snapshot_last_built_at<=0)
      return("Not Yet Available");
   datetime now=TimeTradeServer();
   if(now<=0)
      now=TimeCurrent();
   long age=(long)(now-state.snapshot_last_built_at);
   if(age<0)
      age=0;
   return(IntegerToString((int)age) + "s");
  }

string ASC_DossierSnapshotContinuityModeText(const ASC_SymbolState &state)
  {
   if(state.snapshot_last_good_preserved)
      return("Preserved last-good packet remains active");
   if(state.snapshot_has_last_good)
      return("Fresh packet is also the active last-good");
   return("No last-good packet available yet");
  }

string ASC_DossierFilterSummaryText(const ASC_SymbolState &state)
  {
   if(state.filter_eligible || state.filter_readiness==ASC_FILTER_ELIGIBLE)
      return("Eligible");
   switch(state.filter_readiness)
     {
      case ASC_FILTER_PENDING_LAYER1_OR_2:
      case ASC_FILTER_PENDING_CLASSIFICATION:
      case ASC_FILTER_PENDING_TICK_CONTINUITY:
         return("Pending");
     }
   return("Not Eligible");
  }

string ASC_DossierShortlistSummaryText(const ASC_SymbolState &state)
  {
   if(state.shortlist_selected || state.shortlist_readiness==ASC_SHORTLIST_SELECTED)
      return("Selected");
   if(state.shortlist_readiness==ASC_SHORTLIST_PENDING_LAYER3)
      return("Pending");
   return("Not Selected");
  }

string ASC_DossierPrimaryReasonText(const ASC_RuntimeState &runtime,const ASC_SymbolState &state)
  {
   string shortlist_reason=ASC_DossierShortlistReasonCode(state);
   string filter_reason=ASC_DossierFilterReasonCode(state);
   string detail="";

   if(state.shortlist_selected)
     {
      detail=(state.shortlist_basis!="" ? ASC_DossierOperatorText(state.shortlist_basis) : "Shortlist admitted this symbol.");
      return(shortlist_reason + " | " + detail);
     }

   if(state.shortlist_readiness!=ASC_SHORTLIST_PENDING_LAYER3)
     {
      detail=(state.shortlist_pending_reason!="" ? ASC_DossierOperatorText(state.shortlist_pending_reason) : "Shortlist did not admit this symbol.");
      return(shortlist_reason + " | " + detail);
     }

   if(state.filter_eligible || state.filter_readiness!=ASC_FILTER_PENDING_LAYER1_OR_2)
     {
      if(state.filter_eligible)
         detail=(state.filter_characterization!="" ? ASC_DossierOperatorText(state.filter_characterization) : "Candidate Filtering admitted this symbol.");
      else
         detail=(state.filter_pending_reason!="" ? ASC_DossierOperatorText(state.filter_pending_reason) : "Candidate Filtering has not admitted this symbol.");
      return(filter_reason + " | " + detail);
     }

   if(state.snapshot_pending_reason!="")
      return("L2_PENDING | " + ASC_DossierOperatorText(state.snapshot_pending_reason));
   if(state.next_check_reason!="")
      return("L1_PENDING | " + ASC_DossierOperatorText(state.next_check_reason));
   if(runtime.open_symbol_snapshot.pending_reason!="")
      return("L2_PENDING | " + ASC_DossierOperatorText(runtime.open_symbol_snapshot.pending_reason));
   return("Pending");
  }

string ASC_DossierImmediateNote(const ASC_RuntimeState &runtime,const ASC_SymbolState &state,const ASC_SymbolClassification &classification,const bool classification_ready)
  {
   string note="Market " + ASC_MarketStatusText(state.market_status)
      + ", tick " + ASC_DossierTickStatusText(state)
      + ", snapshot " + ASC_DossierSnapshotSummaryText(state)
      + ", filter " + ASC_DossierFilterSummaryText(state)
      + ", shortlist " + ASC_DossierShortlistSummaryText(state) + ".";

   if(classification_ready)
      note+=" Group " + classification.primary_bucket + ".";

   string reason="";
   if(state.shortlist_selected && state.shortlist_basis!="")
      reason=ASC_DossierOperatorText(state.shortlist_basis);
   else if(state.shortlist_pending_reason!="")
      reason=ASC_DossierOperatorText(state.shortlist_pending_reason);
   else if(state.filter_pending_reason!="")
      reason=ASC_DossierOperatorText(state.filter_pending_reason);
   else if(state.status_note!="")
      reason=ASC_DossierOperatorText(state.status_note);
   else if(runtime.candidate_filter.pending_reason!="" && !state.filter_eligible)
      reason=ASC_DossierOperatorText(runtime.candidate_filter.pending_reason);

   if(reason!="")
      note+=" Note: " + reason;
   return(note);
  }

string ASC_BuildDossierText(const ASC_ServerPaths &paths,const ASC_RuntimeState &runtime,const ASC_SymbolState &state)
  {
   ASC_SymbolClassification classification;
   bool classification_ready=(ASC_CL_ClassifySymbol(runtime.server_clean,state.symbol,classification)
                              && classification.resolved
                              && classification.primary_bucket!="");

   string main_bucket=(classification_ready ? classification.primary_bucket : "Pending");
   string referenced_bucket=main_bucket;
   string selected_bucket=(state.shortlist_bucket=="" ? "Not Selected" : state.shortlist_bucket);
   string canonical_symbol=(classification_ready && classification.canonical_symbol!="" ? classification.canonical_symbol : "Not Yet Available");
   string display_name=(classification_ready && classification.display_name!="" ? classification.display_name : "Not Yet Available");
   string asset_class=(classification_ready ? classification.asset_class : "Pending");
   string sector=(classification_ready && classification.sector!="" ? classification.sector : "Pending");
   string industry=(classification_ready && classification.industry!="" ? classification.industry : "Pending");
   string theme=(classification_ready && classification.theme_bucket!="" ? classification.theme_bucket : "Pending");
   string subtype=(classification_ready && classification.subtype!="" ? classification.subtype : "Pending");
   string secondary_group=(classification_ready && classification.alias_kind!="" ? classification.alias_kind : "Pending");
   string match_kind=(classification_ready && classification.match_kind!="" ? classification.match_kind : "Pending");
   string review_status=(classification_ready && classification.review_status!="" ? classification.review_status : "Pending");
   string confidence=(classification_ready && classification.confidence!="" ? classification.confidence : "Pending");

   bool snapshot_available=state.snapshot_has_last_good;
   string snapshot_pending=(state.snapshot_pending_reason=="" ? runtime.open_symbol_snapshot.pending_reason : state.snapshot_pending_reason);
   string filter_pending=(state.filter_pending_reason=="" ? runtime.candidate_filter.pending_reason : state.filter_pending_reason);
   string shortlist_pending=state.shortlist_pending_reason;
   string shortlist_basis=(state.shortlist_basis=="" ? "Pending" : ASC_DossierOperatorText(state.shortlist_basis));

   string body="";
   body+="Aurora Sentinel Symbol Dossier\r\n";
   body+="========================================\r\n\r\n";

   body+="Header\r\n";
   body+="----------------------------------------\r\n";
   body+="Product: " + ASC_PRODUCT_NAME + "\r\n";
   body+="Symbol: " + state.symbol + "\r\n";
   body+="Server: " + paths.server_clean + "\r\n";
   body+="Generated At: " + ASC_DateTimeText(TimeCurrent()) + "\r\n";
   body+="Wrapper Version: " + ASC_WRAPPER_VERSION + "\r\n";
   body+="Runtime Mode: " + ASC_RuntimeModeText(runtime.mode) + "\r\n\r\n";

   body+="Operator Summary\r\n";
   body+="----------------------------------------\r\n";
   body+="Market: " + ASC_MarketStatusText(state.market_status) + "\r\n";
   body+="Tick: " + ASC_DossierTickStatusText(state) + " | Age: " + ASC_DossierTickAgeText(state) + "\r\n";
   body+="Session: " + ASC_DossierSessionStatusText(state) + "\r\n";
   body+="Snapshot: " + ASC_DossierSnapshotSummaryText(state) + "\r\n";
   body+="Filter: " + ASC_DossierFilterSummaryText(state) + "\r\n";
   body+="Shortlist: " + ASC_DossierShortlistSummaryText(state) + "\r\n";
   body+="Group: main=" + main_bucket + " | referenced=" + referenced_bucket + " | selected=" + selected_bucket + "\r\n";
   body+="Key Reason: " + ASC_DossierPrimaryReasonText(runtime,state) + "\r\n";
   body+="Immediate Note: " + ASC_DossierImmediateNote(runtime,state,classification,classification_ready) + "\r\n\r\n";

   body+="Current Trading State\r\n";
   body+="----------------------------------------\r\n";
   body+="Current Status: " + ASC_MarketStatusText(state.market_status) + "\r\n";
   body+="Status Note: " + (state.status_note=="" ? "Pending" : ASC_DossierOperatorText(state.status_note)) + "\r\n";
   body+="Tick Present: " + ASC_BoolText(state.has_tick) + "\r\n";
   body+="Last Tick Seen: " + ASC_DateTimeText(state.last_tick_seen_at) + "\r\n";
   body+="Tick Age Seconds: " + (state.tick_age_seconds>=0 ? IntegerToString((int)state.tick_age_seconds) : "Not Yet Available") + "\r\n";
   body+="Trade Sessions Available: " + ASC_BoolText(state.has_trade_sessions) + "\r\n";
   body+="Within Trade Session: " + ASC_BoolText(state.within_trade_session) + "\r\n";
   body+="Next Session Open: " + ASC_DateTimeText(state.next_session_open_at) + "\r\n";
   body+="Next Check: " + ASC_DateTimeText(state.next_check_at) + "\r\n";
   body+="Next Check Reason: " + ASC_DossierOperatorText(state.next_check_reason) + "\r\n";
   body+="Snapshot Last Built: " + ASC_DateTimeText(state.snapshot_last_built_at) + "\r\n";
   body+="Snapshot Age: " + ASC_DossierSnapshotAgeText(state) + "\r\n";
   body+="Snapshot State: " + ASC_SnapshotReadinessText(state.snapshot_readiness) + "\r\n";
   body+="Snapshot Continuity Mode: " + ASC_DossierSnapshotContinuityModeText(state) + "\r\n";
   body+="Snapshot Pending Reason: " + ASC_DossierOperatorText(snapshot_pending) + "\r\n";
   body+="Last-Good Snapshot: " + ASC_DossierLastGoodStateText(state) + "\r\n";
   body+="Bid: " + (snapshot_available ? DoubleToString(state.snapshot_bid,state.snapshot_digits) : "Pending") + "\r\n";
   body+="Ask: " + (snapshot_available ? DoubleToString(state.snapshot_ask,state.snapshot_digits) : "Pending") + "\r\n";
   body+="Spread: " + (snapshot_available ? DoubleToString(state.snapshot_spread,0) + " points" : "Pending") + "\r\n";
   body+="Spread Type: " + (snapshot_available ? string(state.snapshot_spread_floating ? "Floating" : "Fixed/Quoted") : "Pending") + "\r\n";
   body+="Spread Price: " + (snapshot_available ? DoubleToString(state.snapshot_spread_price,state.snapshot_digits) : "Pending") + "\r\n";
   body+="Spread Percent: " + (snapshot_available ? DoubleToString(state.snapshot_spread_percent,3) + "%" : "Pending") + "\r\n";
   body+="ATR M1 (14): " + (snapshot_available && state.snapshot_atr_m1>0.0 ? DoubleToString(state.snapshot_atr_m1,state.snapshot_digits) : "Not Yet Available") + "\r\n";
   body+="ATR M1 Reliable: " + (snapshot_available ? ASC_BoolText(state.snapshot_atr_m1_reliable) : "Pending") + "\r\n";
   body+="Spread / ATR Percent: " + (snapshot_available && state.snapshot_atr_m1_reliable && state.snapshot_atr_m1>0.0 ? DoubleToString(state.snapshot_spread_to_atr_percent,1) + "%" : "Not Used") + "\r\n";
   body+="Trade Mode: " + (snapshot_available ? ASC_SymbolTradeModeText(state.snapshot_trade_mode) : "Pending Snapshot") + "\r\n\r\n";

   body+="Capability Status Strip\r\n";
   body+="----------------------------------------\r\n";
   body+="1. Market State Detection: " + ASC_MarketStatusText(state.market_status) + " | Next check " + ASC_DateTimeText(state.next_check_at) + "\r\n";
   body+="2. Open Symbol Snapshot: " + ASC_SnapshotReadinessText(state.snapshot_readiness) + " | Last built " + ASC_DateTimeText(state.snapshot_last_built_at) + "\r\n";
   body+="3. Candidate Filtering: " + ASC_FilterReadinessText(state.filter_readiness) + " | Reason " + ASC_DossierFilterReasonCode(state) + "\r\n";
   body+="4. Shortlist Selection: " + ASC_ShortlistReadinessText(state.shortlist_readiness) + " | Reason " + ASC_DossierShortlistReasonCode(state) + "\r\n";
   body+="5. Deep Selective Analysis: " + (state.shortlist_selected ? "Cadence Active" : "Not Admitted") + " | Last cadence " + ASC_DateTimeText(state.layer5_last_update_at) + "\r\n\r\n";

   body+="Identity And Grouping\r\n";
   body+="----------------------------------------\r\n";
   body+="Symbol: " + state.symbol + "\r\n";
   body+="Canonical Symbol: " + canonical_symbol + "\r\n";
   body+="Display Name: " + display_name + "\r\n";
   body+="Asset Class: " + asset_class + "\r\n";
   body+="Main Bucket: " + main_bucket + "\r\n";
   body+="Referenced Bucket: " + referenced_bucket + "\r\n";
   body+="Selected Bucket: " + selected_bucket + "\r\n";
   body+="Secondary Group: " + secondary_group + "\r\n";
   body+="Theme: " + theme + "\r\n";
   body+="Sector: " + sector + "\r\n";
   body+="Industry: " + industry + "\r\n";
   body+="Subtype: " + subtype + "\r\n";
   body+="Match Status: " + match_kind + "\r\n";
   body+="Review Status: " + review_status + "\r\n";
   body+="Confidence: " + confidence + "\r\n";
   body+="Classification Notes: " + (classification_ready && classification.notes!="" ? classification.notes : "Pending") + "\r\n\r\n";

   body+="Market Status - Full Detail\r\n";
   body+="----------------------------------------\r\n";
   body+="Current Status: " + ASC_MarketStatusText(state.market_status) + "\r\n";
   body+="Status Note: " + (state.status_note=="" ? "Pending" : ASC_DossierOperatorText(state.status_note)) + "\r\n";
   body+="Last Tick Seen: " + ASC_DateTimeText(state.last_tick_seen_at) + "\r\n";
   body+="Tick Present: " + ASC_BoolText(state.has_tick) + "\r\n";
   body+="Tick Age Seconds: " + (state.tick_age_seconds>=0 ? IntegerToString((int)state.tick_age_seconds) : "Not Yet Available") + "\r\n";
   body+="Trade Sessions Available: " + ASC_BoolText(state.has_trade_sessions) + "\r\n";
   body+="Within Trade Session: " + ASC_BoolText(state.within_trade_session) + "\r\n";
   body+="Next Session Open: " + ASC_DateTimeText(state.next_session_open_at) + "\r\n";
   body+="Last Checked: " + ASC_DateTimeText(state.last_checked_at) + "\r\n";
   body+="Next Due: " + ASC_DateTimeText(state.next_check_at) + "\r\n";
   body+="Next Due Reason: " + ASC_DossierOperatorText(state.next_check_reason) + "\r\n";
   body+="Uncertain Burst Count: " + IntegerToString(state.uncertain_burst_count) + "\r\n\r\n";

   body+="Open Symbol Snapshot - Full Detail\r\n";
   body+="----------------------------------------\r\n";
   body+="Readiness: " + ASC_SnapshotReadinessText(state.snapshot_readiness) + "\r\n";
   body+="Last Built: " + ASC_DateTimeText(state.snapshot_last_built_at) + "\r\n";
   body+="Pending Reason: " + ASC_DossierOperatorText(snapshot_pending) + "\r\n";
   body+="Last-Good Available: " + ASC_BoolText(state.snapshot_has_last_good) + "\r\n";
   body+="Last-Good State: " + ASC_DossierLastGoodStateText(state) + "\r\n";
   body+="Last-Good Built: " + ASC_DateTimeText(state.snapshot_last_good_built_at) + "\r\n";
   body+="Snapshot Controls Enabled: " + ASC_BoolText(runtime.open_symbol_snapshot.cadence.controls_reserved) + "\r\n";
   body+="Snapshot Cadence Bars: M1=" + IntegerToString(runtime.open_symbol_snapshot.cadence.reserved_m1_bars) + ", M5=" + IntegerToString(runtime.open_symbol_snapshot.cadence.reserved_m5_bars) + ", M15=" + IntegerToString(runtime.open_symbol_snapshot.cadence.reserved_m15_bars) + "\r\n";
   if(snapshot_available)
     {
      body+="Bid: " + DoubleToString(state.snapshot_bid,state.snapshot_digits) + "\r\n";
      body+="Ask: " + DoubleToString(state.snapshot_ask,state.snapshot_digits) + "\r\n";
      body+="Spread: " + DoubleToString(state.snapshot_spread,0) + " points\r\n";
      body+="Spread Type: " + string(state.snapshot_spread_floating ? "Floating" : "Fixed/Quoted") + "\r\n";
      body+="Spread Price: " + DoubleToString(state.snapshot_spread_price,state.snapshot_digits) + "\r\n";
      body+="Spread Percent: " + DoubleToString(state.snapshot_spread_percent,3) + "%\r\n";
      body+="ATR M1 (14): " + (state.snapshot_atr_m1>0.0 ? DoubleToString(state.snapshot_atr_m1,state.snapshot_digits) : "Not Yet Available") + "\r\n";
      body+="ATR M1 Reliable: " + ASC_BoolText(state.snapshot_atr_m1_reliable) + "\r\n";
      body+="ATR Active TR Count: " + IntegerToString(state.snapshot_atr_m1_active_tr_count) + "\r\n";
      body+="Spread / ATR Percent: " + (state.snapshot_atr_m1_reliable && state.snapshot_atr_m1>0.0 ? DoubleToString(state.snapshot_spread_to_atr_percent,1) + "%" : "Not Used") + "\r\n";
      body+="Day High: " + DoubleToString(state.snapshot_day_high,state.snapshot_digits) + "\r\n";
      body+="Day Low: " + DoubleToString(state.snapshot_day_low,state.snapshot_digits) + "\r\n";
      body+="Point: " + DoubleToString(state.snapshot_point,8) + "\r\n";
      body+="Digits: " + IntegerToString(state.snapshot_digits) + "\r\n";
      body+="Tick Size: " + DoubleToString(state.snapshot_tick_size,8) + "\r\n";
      body+="Tick Value: " + DoubleToString(state.snapshot_tick_value,8) + "\r\n";
      body+="Contract Size: " + DoubleToString(state.snapshot_contract_size,2) + "\r\n";
      body+="Margin Currency: " + (state.snapshot_margin_currency=="" ? "Not Yet Available" : state.snapshot_margin_currency) + "\r\n";
      body+="Profit Currency: " + (state.snapshot_profit_currency=="" ? "Not Yet Available" : state.snapshot_profit_currency) + "\r\n";
      body+="Volume Min: " + DoubleToString(state.snapshot_volume_min,4) + "\r\n";
      body+="Volume Step: " + DoubleToString(state.snapshot_volume_step,4) + "\r\n";
      body+="Volume Max: " + DoubleToString(state.snapshot_volume_max,4) + "\r\n";
      body+="Trade Mode: " + ASC_SymbolTradeModeText(state.snapshot_trade_mode) + "\r\n";
      body+="Chart Mode Raw: " + IntegerToString((int)state.snapshot_chart_mode) + "\r\n";
      body+="Trade Execution Raw: " + IntegerToString((int)state.snapshot_trade_execution) + "\r\n";
      body+="Order Mode Raw: " + IntegerToString((int)state.snapshot_order_mode) + "\r\n";
      body+="Filling Mode Raw: " + IntegerToString((int)state.snapshot_filling_mode) + "\r\n";
      body+="GTC Mode Raw: " + IntegerToString((int)state.snapshot_gtc_mode) + "\r\n";
      body+="Expiration Mode Raw: " + IntegerToString((int)state.snapshot_expiration_mode) + "\r\n";
      body+="Stops Level: " + IntegerToString((int)state.snapshot_stops_level) + "\r\n";
      body+="Freeze Level: " + IntegerToString((int)state.snapshot_freeze_level) + "\r\n";
      body+="Swap Type Raw: " + IntegerToString((int)state.snapshot_swap_type) + "\r\n";
      body+="Swap Long: " + DoubleToString(state.snapshot_swap_long,8) + "\r\n";
      body+="Swap Short: " + DoubleToString(state.snapshot_swap_short,8) + "\r\n\r\n";
     }
   else
      body+="Snapshot Values: Pending first successful open-symbol refresh\r\n\r\n";

   body+="Candidate Filtering - Full Detail\r\n";
   body+="----------------------------------------\r\n";
   body+="Readiness: " + ASC_FilterReadinessText(state.filter_readiness) + "\r\n";
   body+="Last Evaluated: " + ASC_DateTimeText(state.filter_last_evaluated_at) + "\r\n";
   body+="Final Status: " + (state.filter_eligible ? "Eligible" : "Not Eligible Yet") + "\r\n";
   body+="Reason Code: " + ASC_DossierFilterReasonCode(state) + "\r\n";
   body+="Pending Reason: " + ASC_DossierOperatorText(filter_pending) + "\r\n";
   body+="Characterization: " + ASC_DossierOperatorText((state.filter_characterization=="" ? runtime.candidate_filter.characterization : state.filter_characterization)) + "\r\n";
   body+="Gate 1 / Market Open: " + ASC_DossierFilterGateText(state.market_status==ASC_MARKET_OPEN,"Market status confirms the symbol is Open.","Market status has not confirmed Open yet.") + "\r\n";
   body+="Gate 2 / Snapshot: " + ASC_DossierFilterGateText(((state.snapshot_readiness==ASC_SNAPSHOT_WORKING_FRESH || state.snapshot_readiness==ASC_SNAPSHOT_WORKING_LAST_GOOD) && state.snapshot_has_last_good),"Snapshot continuity is available.","There is no current or preserved snapshot continuity.") + "\r\n";
   body+="Gate 3 / Tick Continuity: " + ASC_DossierFilterGateText((state.filter_readiness!=ASC_FILTER_PENDING_TICK_CONTINUITY && state.has_tick && state.last_tick_seen_at>0 && state.tick_age_seconds>=0),(state.tick_age_seconds>=0 ? "Tick continuity is present at " + IntegerToString((int)state.tick_age_seconds) + " seconds." : "Tick continuity is present."),(state.tick_age_seconds>=0 ? "Tick continuity is stale at " + IntegerToString((int)state.tick_age_seconds) + " seconds." : "Tick continuity is not usable yet.")) + "\r\n";
   body+="Gate 4 / Snapshot Data Sanity: " + ASC_DossierFilterGateText((MathIsValidNumber(state.snapshot_bid) && state.snapshot_bid>0.0 && MathIsValidNumber(state.snapshot_ask) && state.snapshot_ask>=state.snapshot_bid && MathIsValidNumber(state.snapshot_point) && state.snapshot_point>0.0 && MathIsValidNumber(state.snapshot_contract_size) && state.snapshot_contract_size>0.0 && MathIsValidNumber(state.snapshot_spread_percent) && state.snapshot_spread_percent>=0.0 && MathIsValidNumber(state.snapshot_atr_m1) && state.snapshot_atr_m1>=0.0 && MathIsValidNumber(state.snapshot_spread_to_atr_percent) && state.snapshot_spread_to_atr_percent>=0.0),"Snapshot packet is internally sane.","Snapshot packet contains missing or invalid numeric fields.") + "\r\n";
   body+="Gate 5 / Trade Mode: " + ASC_DossierFilterGateText(!(state.snapshot_trade_mode==SYMBOL_TRADE_MODE_DISABLED || state.snapshot_trade_mode==SYMBOL_TRADE_MODE_CLOSEONLY),"Trade mode allows participation.","Trade mode blocks new participation.") + "\r\n";
   body+="Gate 6 / Volume Bounds: " + ASC_DossierFilterGateText((state.snapshot_volume_min>0.0 && state.snapshot_volume_step>0.0 && state.snapshot_volume_max>=state.snapshot_volume_min),"Volume bounds are usable.","Volume bounds are missing or invalid.") + "\r\n";
   body+="Gate 7 / Spread Normalization: " + ASC_DossierFilterGateText((state.snapshot_spread_percent<=ASC_LAYER3_MAX_SPREAD_PERCENT && (!state.snapshot_atr_m1_reliable || state.snapshot_atr_m1<=0.0 || state.snapshot_spread_to_atr_percent<=ASC_LAYER3_MAX_SPREAD_TO_ATR_PERCENT)),"Normalized spread is within watchlist limits.","Normalized spread is too wide for watchlist use.") + "\r\n";
   body+="Gate 8 / Characterization Source: " + ASC_DossierFilterGateText(classification_ready,"identity and bucketing provide a usable primary bucket.","identity and bucketing are not resolved enough yet.") + "\r\n";
   body+="Referenced Bucket: " + referenced_bucket + "\r\n";
   body+="Referenced Asset Class: " + asset_class + "\r\n";
   body+="Referenced Tick Age Seconds: " + (state.tick_age_seconds>=0 ? IntegerToString((int)state.tick_age_seconds) : "Pending") + "\r\n";
   body+="Referenced Spread Percent: " + (snapshot_available ? DoubleToString(state.snapshot_spread_percent,3) + "%" : "Pending") + "\r\n";
   body+="Referenced ATR M1: " + (state.snapshot_atr_m1>0.0 ? DoubleToString(state.snapshot_atr_m1,state.snapshot_digits) : "Pending") + "\r\n";
   body+="Referenced ATR M1 Reliable: " + ASC_BoolText(state.snapshot_atr_m1_reliable) + "\r\n";
   body+="Referenced ATR Active TR Count: " + IntegerToString(state.snapshot_atr_m1_active_tr_count) + "\r\n";
   body+="Referenced Spread / ATR Percent: " + (state.snapshot_atr_m1_reliable && state.snapshot_atr_m1>0.0 ? DoubleToString(state.snapshot_spread_to_atr_percent,1) + "%" : "Not Used") + "\r\n";
   body+="Referenced Margin Currency: " + (state.snapshot_margin_currency=="" ? "Pending" : state.snapshot_margin_currency) + "\r\n";
   body+="Referenced Profit Currency: " + (state.snapshot_profit_currency=="" ? "Pending" : state.snapshot_profit_currency) + "\r\n\r\n";

   body+="Shortlist Selection - Full Detail\r\n";
   body+="----------------------------------------\r\n";
   body+="Readiness: " + ASC_ShortlistReadinessText(state.shortlist_readiness) + "\r\n";
   body+="Last Evaluated: " + ASC_DateTimeText(state.shortlist_last_evaluated_at) + "\r\n";
   body+="Final Status: " + (state.shortlist_selected ? "Selected" : "Not Shortlisted") + "\r\n";
   body+="Reason Code: " + ASC_DossierShortlistReasonCode(state) + "\r\n";
   body+="Pending Reason: " + (shortlist_pending=="" ? "Pending" : ASC_DossierOperatorText(shortlist_pending)) + "\r\n";
   body+="Basis: " + shortlist_basis + "\r\n";
   body+="Selected Bucket: " + selected_bucket + "\r\n";
   body+="Gate 1 / Eligible: " + ASC_DossierFilterGateText(state.filter_eligible,"Candidate Filtering already admitted this symbol.","Candidate Filtering did not admit this symbol.") + "\r\n";
   body+="Gate 2 / Global Cap: " + ASC_DossierFilterGateText((state.shortlist_readiness!=ASC_SHORTLIST_INELIGIBLE_GLOBAL_CAP_REACHED),"Global shortlist cap still allowed admission.","Global shortlist cap blocked admission.") + "\r\n";
   body+="Gate 3 / Bucket Cap: " + ASC_DossierFilterGateText((state.shortlist_readiness!=ASC_SHORTLIST_INELIGIBLE_BUCKET_CAP_REACHED),"Bucket shortlist cap still allowed admission.","Bucket shortlist cap blocked admission.") + "\r\n";
   body+="Gate 4 / Selection Result: " + ASC_DossierFilterGateText(state.shortlist_selected,"Shortlist admitted this symbol into the bounded shortlist.","Shortlist did not admit this symbol into the bounded shortlist.") + "\r\n\r\n";

   body+="Runtime / Scheduler / Publication\r\n";
   body+="----------------------------------------\r\n";
   body+="Last Heartbeat: " + ASC_DateTimeText(runtime.last_heartbeat_at) + "\r\n";
   body+="Universe Sync: " + ASC_DateTimeText(runtime.last_universe_sync_at) + "\r\n";
   body+="Recovery Used: " + ASC_BoolText(runtime.recovery_used) + "\r\n";
   body+="Degraded Runtime: " + ASC_BoolText(runtime.degraded) + "\r\n";
   body+="Last Checked: " + ASC_DateTimeText(state.last_checked_at) + "\r\n";
   body+="Next Due: " + ASC_DateTimeText(state.next_check_at) + "\r\n";
   body+="Next Due Reason: " + ASC_DossierOperatorText(state.next_check_reason) + "\r\n";
   body+="Publication State: " + ASC_DossierPublicationStateText(paths,state) + "\r\n";
   body+="Last Dossier Write: " + ASC_DateTimeText(state.last_dossier_write_at) + "\r\n";
   body+="Priority Summary: " + runtime.diagnostics.scheduler_priority_summary + "\r\n\r\n";

   body+="Schema / Publication Metadata\r\n";
   body+="----------------------------------------\r\n";
   body+="Schema Family: " + ASC_SCHEMA_FAMILY + "\r\n";
   body+="Schema Version: ASC Foundation v1\r\n";
   body+="Active Capability: " + ASC_ACTIVE_CAPABILITY + "\r\n";
   body+="Next Planned Capability: " + ASC_NEXT_CAPABILITY + "\r\n";
   body+="Runtime Posture: " + ASC_RUNTIME_POSTURE + "\r\n";
   body+="Explorer Subsystem Version: " + ASC_EXPLORER_SUBSYSTEM_VERSION + "\r\n";
   body+="Dossier File: " + state.dossier_file + "\r\n";
   return(body);
  }

bool ASC_WriteDossier(const ASC_ServerPaths &paths,const ASC_RuntimeState &runtime,ASC_SymbolState &state,ASC_Logger &logger)
  {
   string final_path=ASC_JoinPath(paths.universe_folder,state.dossier_file);
   bool prior_publication_exists=FileIsExist(final_path,FILE_COMMON);

   // Build the dossier against honest PRE-WRITE publication state.
   state.publication_ok=prior_publication_exists;
   string text=ASC_BuildDossierText(paths,runtime,state);

   bool ok=ASC_AtomicWrite(final_path,text,logger);
   if(ok)
     {
      state.last_dossier_write_at=TimeCurrent();
      state.publication_ok=true;
      state.dirty=false;
      logger.Debug("Dossier","promoted dossier for " + state.symbol + " to " + final_path);
     }
   else
     {
      state.publication_ok=prior_publication_exists;
      if(prior_publication_exists)
         logger.Warn("Dossier","failed to promote current dossier for " + state.symbol + "; prior promoted dossier remains at " + final_path);
      else
         logger.Error("Dossier","failed to promote dossier for " + state.symbol + " to " + final_path);
     }
   return(ok);
  }

#endif
