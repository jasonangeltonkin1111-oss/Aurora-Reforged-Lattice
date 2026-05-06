#ifndef __TELEMETRY_ARL_STATUSWRITER_MQH__
#define __TELEMETRY_ARL_STATUSWRITER_MQH__

//+------------------------------------------------------------------+
//| ARL_StatusWriter
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN011R
//| Status: STATUS_CURRENT COMPOSITION/PUBLISH + FAILURE-LOUD DIAGNOSTICS ONLY.
//+------------------------------------------------------------------+
// Owner: telemetry/status
// Purpose: Owns Status_Current payload composition and publication request.
// Inputs: heartbeat/scheduler/runtime metrics and file-publish settings
// Outputs: Status_Current.json through ARL_FilePublisher and Manifest_Current through manifest owner
// Forbidden: business logic, account scans, ranking, HUD, signals, execution, trading decisions

string g_arl_status_last_publication_code = "NEVER_RUN";
string g_arl_manifest_last_publication_code = "NEVER_RUN";
bool   g_arl_status_disabled_logged = false;
bool   g_arl_status_last_ok = false;
bool   g_arl_manifest_last_ok = false;
string g_arl_status_last_printed_code = "";
string g_arl_manifest_last_printed_code = "";


string ARL_StatusWriter_JsonEscape(const string raw)
  {
   string escaped = raw;
   StringReplace(escaped,"\\","\\\\");
   StringReplace(escaped,"\"","\\\"");
   return escaped;
  }
bool ARL_StatusWriter_Init()
  {
   g_arl_status_last_publication_code = "INIT";
   g_arl_manifest_last_publication_code = "INIT";
   g_arl_status_disabled_logged = false;
   g_arl_status_last_ok = false;
   g_arl_manifest_last_ok = false;
   g_arl_status_last_printed_code = "";
   g_arl_manifest_last_printed_code = "";
   return true;
  }

string ARL_StatusWriter_ComposePayload(const bool writes_enabled,const int timer_seconds,const int work_budget_ms,const bool allow_trading)
  {
   string payload = "{";
   payload += "\"product_name\":\"" + ARL_PRODUCT_NAME + "\",";
   payload += "\"product_version\":\"" + ARL_PRODUCT_VERSION + "\",";
   payload += "\"run_id\":\"" + ARL_PRODUCT_RUN_ID + "\",";
   payload += "\"product_channel\":\"" + ARL_PRODUCT_CHANNEL + "\",";
   payload += "\"product_state\":\"" + ARL_PRODUCT_STATE + "\",";
   payload += "\"permission_text\":\"" + ARL_PERMISSION_TEXT + "\",";
   payload += "\"generated_server_time\":\"" + TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS) + "\",";
   payload += "\"generated_utc_time\":\"" + TimeToString(TimeGMT(),TIME_DATE|TIME_SECONDS) + "\",";
   payload += "\"heartbeat_count\":" + IntegerToString((long)ARL_Heartbeat_Count()) + ",";
   payload += "\"heartbeat_status\":\"" + ARL_Heartbeat_Status() + "\",";
   payload += "\"scheduler_tick_count\":" + IntegerToString((long)ARL_Scheduler_TickCount()) + ",";
   payload += "\"scheduler_status\":\"" + ARL_Scheduler_Status() + "\",";
   payload += "\"last_cycle_ms\":" + IntegerToString(ARL_RuntimeMetrics_LastCycleMs()) + ",";
   payload += "\"max_cycle_ms\":" + IntegerToString(ARL_RuntimeMetrics_MaxCycleMs()) + ",";
   payload += "\"timer_seconds\":" + IntegerToString(timer_seconds) + ",";
   payload += "\"work_budget_ms\":" + IntegerToString(work_budget_ms) + ",";
   payload += "\"file_writes_enabled\":" + (writes_enabled ? "true" : "false") + ",";
   payload += "\"file_location_mode\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_FileLocationMode()) + "\",";
   payload += "\"common_data_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_CommonDataPath()) + "\",";
   payload += "\"common_files_base_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_CommonFilesBasePath()) + "\",";
   payload += "\"terminal_data_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_TerminalDataPath()) + "\",";
   payload += "\"terminal_files_base_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_TerminalFilesBasePath()) + "\",";
   payload += "\"expected_common_status_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_AbsoluteCommonFilesStatusPattern()) + "\",";
   payload += "\"expected_common_manifest_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_AbsoluteCommonFilesManifestPattern()) + "\",";
   payload += "\"status_final_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_StatusCurrent()) + "\",";
   payload += "\"status_temp_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_TempFor(ARL_Paths_StatusCurrent())) + "\",";
   payload += "\"manifest_final_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_ManifestCurrent()) + "\",";
   payload += "\"manifest_temp_path\":\"" + ARL_StatusWriter_JsonEscape(ARL_Paths_TempFor(ARL_Paths_ManifestCurrent())) + "\",";
   payload += "\"trade_permission\":false,";
   payload += "\"signal_permission\":false,";
   payload += "\"execution_permission\":false,";
   payload += "\"hud_permission\":false,";
   payload += "\"status_publication_result\":\"" + g_arl_status_last_publication_code + "\",";
   payload += "\"manifest_publication_result\":\"" + g_arl_manifest_last_publication_code + "\",";
   payload += "\"last_error_code\":" + IntegerToString(ARL_ErrorLedger_LastCode()) + ",";
   payload += "\"last_error_source\":\"" + ARL_StatusWriter_JsonEscape(ARL_ErrorLedger_LastSource()) + "\",";
   payload += "\"last_error_message\":\"" + ARL_StatusWriter_JsonEscape(ARL_ErrorLedger_LastMessage()) + "\"";
   payload += "}";
   return payload;
  }

ARL_FilePublishResult ARL_StatusWriter_Publish(const bool writes_enabled,const int timer_seconds,const int work_budget_ms,const bool allow_trading)
  {
   if(!writes_enabled && !g_arl_status_disabled_logged)
     {
      g_arl_status_disabled_logged = true;
      Print("ARL StatusWriter: file writes disabled by input; status/manifest will not be written until InpARL_EnableFileWrites=true.");
     }

   Print("ARL publication preflight | ", ARL_FilePublisher_PreflightLine(writes_enabled,allow_trading));
   string payload = ARL_StatusWriter_ComposePayload(writes_enabled,timer_seconds,work_budget_ms,allow_trading);
   string reason = "";
   if(!ARL_OutputContracts_ValidateStatusCurrent(payload,reason))
     {
      ARL_ErrorLedger_Record("ARL_StatusWriter",0,reason);
      ARL_FilePublishResult failed = ARL_FilePublisher_MakeResult(false,"STATUS_CONTRACT_FAILED",reason,ARL_Paths_StatusCurrent(),ARL_Paths_TempFor(ARL_Paths_StatusCurrent()));
      g_arl_status_last_publication_code = failed.code;
      g_arl_status_last_ok = false;
      return failed;
     }

   ARL_FilePublishResult status_result = ARL_FilePublisher_Publish(ARL_Paths_StatusCurrent(),payload,writes_enabled,"product_name");
   g_arl_status_last_publication_code = status_result.code;
   g_arl_status_last_ok = status_result.ok;
   if(!status_result.ok)
     {
      Print("ARL StatusWriter publish failure | code=", status_result.code, " | last_error=", status_result.last_error, " | path=", status_result.final_path);
      ARL_ErrorLedger_Record("ARL_StatusWriter",status_result.last_error,status_result.message);
     }
   else if(g_arl_status_last_printed_code != status_result.code)
     {
      g_arl_status_last_printed_code = status_result.code;
      Print("ARL StatusWriter publish OK | code=", status_result.code, " | path=", status_result.final_path);
     }

   ARL_FilePublishResult manifest_result = ARL_PublicationManifest_Publish(status_result,writes_enabled);
   g_arl_manifest_last_publication_code = manifest_result.code;
   g_arl_manifest_last_ok = manifest_result.ok;
   if(!manifest_result.ok)
     {
      Print("ARL Manifest publish failure | code=", manifest_result.code, " | last_error=", manifest_result.last_error, " | path=", manifest_result.final_path);
      ARL_ErrorLedger_Record("ARL_PublicationManifest",manifest_result.last_error,manifest_result.message);
     }
   else if(g_arl_manifest_last_printed_code != manifest_result.code)
     {
      g_arl_manifest_last_printed_code = manifest_result.code;
      Print("ARL Manifest publish OK | code=", manifest_result.code, " | path=", manifest_result.final_path);
     }

   return status_result;
  }

string ARL_StatusWriter_Line()
  {
   return "ARL_StatusWriter=ACTIVE;status=" + g_arl_status_last_publication_code + ";manifest=" + g_arl_manifest_last_publication_code;
  }

#endif // __TELEMETRY_ARL_STATUSWRITER_MQH__
