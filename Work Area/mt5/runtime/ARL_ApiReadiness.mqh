#ifndef __RUNTIME_ARL_API_READINESS_MQH__
#define __RUNTIME_ARL_API_READINESS_MQH__

//+------------------------------------------------------------------+
//| ARL_ApiReadiness
//| Aurora Reforged Lattice — diagnostics only
//| Purpose: endpoint presence check + optional minimal WebRequest probe.
//+------------------------------------------------------------------+
// Owner: runtime/diagnostics
// Forbidden: trading, signal logic, execution permission, scoring, routing decisions.

string g_arl_api_endpoint = "";
bool   g_arl_api_probe_enabled = false;
bool   g_arl_api_ready = false;
bool   g_arl_api_probe_attempted = false;
int    g_arl_api_response_code = 0;
int    g_arl_api_last_error = 0;
string g_arl_api_detail = "NOT_RUN";
string g_arl_api_skip_reason = "NOT_RUN";
datetime g_arl_api_last_check_server_time = 0;

void ARL_ApiReadiness_Init(const string endpoint,const bool enable_probe)
  {
   g_arl_api_endpoint = endpoint;
   g_arl_api_probe_enabled = enable_probe;
   g_arl_api_ready = false;
   g_arl_api_probe_attempted = false;
   g_arl_api_response_code = 0;
   g_arl_api_last_error = 0;
   g_arl_api_detail = "INIT";
   g_arl_api_skip_reason = "INIT";
   g_arl_api_last_check_server_time = 0;
  }

bool ARL_ApiReadiness_RunCheck()
  {
   g_arl_api_last_check_server_time = TimeCurrent();
   g_arl_api_probe_attempted = false;
   g_arl_api_response_code = 0;
   g_arl_api_last_error = 0;

   string endpoint = g_arl_api_endpoint;
   StringTrimLeft(endpoint);
   StringTrimRight(endpoint);

   if(StringLen(endpoint) == 0)
     {
      g_arl_api_ready = false;
      g_arl_api_detail = "FAILED_MISSING_ENDPOINT";
      g_arl_api_skip_reason = "endpoint is empty";
      Print("ARL API readiness failed | endpoint=<empty> | request_skipped=", g_arl_api_skip_reason,
            " | last_error=", g_arl_api_last_error, " | response_code=", g_arl_api_response_code,
            " | hint=Add URL to MT5 Options > Expert Advisors > Allow WebRequest for listed URLs.");
      return false;
     }

   if(!g_arl_api_probe_enabled)
     {
      g_arl_api_ready = true;
      g_arl_api_detail = "DRY_VALIDATION_ONLY";
      g_arl_api_skip_reason = "probe disabled by input";
      Print("ARL API readiness dry validation | endpoint=", endpoint, " | request_skipped=", g_arl_api_skip_reason,
            " | hint=Enable probe and allow URL in MT5 Options > Expert Advisors > Allow WebRequest for listed URLs.");
      return true;
     }

   g_arl_api_probe_attempted = true;
   char post_data[];
   char response_data[];
   string response_headers = "";
   string request_headers = "Content-Type: text/plain\r\n";
   int timeout_ms = 1500;
   ResetLastError();
   int response_code = WebRequest("GET",endpoint,request_headers,timeout_ms,post_data,response_data,response_headers);
   g_arl_api_last_error = GetLastError();
   g_arl_api_response_code = response_code;

   if(response_code < 0)
     {
      g_arl_api_ready = false;
      g_arl_api_detail = "FAILED_WEBREQUEST";
      g_arl_api_skip_reason = "";
      Print("ARL API readiness failed | endpoint=", endpoint, " | request_attempted=true",
            " | last_error=", g_arl_api_last_error, " | response_code=", g_arl_api_response_code,
            " | hint=URL must be listed in MT5 Options > Expert Advisors > Allow WebRequest for listed URLs.");
      return false;
     }

   g_arl_api_ready = true;
   g_arl_api_detail = "PROBE_OK";
   g_arl_api_skip_reason = "";
   Print("ARL API readiness OK | endpoint=", endpoint, " | request_attempted=true",
         " | last_error=", g_arl_api_last_error, " | response_code=", g_arl_api_response_code);
   return true;
  }

void ARL_ApiReadiness_Tick()
  {
   if(!g_arl_api_probe_attempted && g_arl_api_probe_enabled)
      ARL_ApiReadiness_RunCheck();
  }

bool ARL_ApiReadiness_IsReady(){ return g_arl_api_ready; }
bool ARL_ApiReadiness_ProbeAttempted(){ return g_arl_api_probe_attempted; }
int ARL_ApiReadiness_ResponseCode(){ return g_arl_api_response_code; }
int ARL_ApiReadiness_LastError(){ return g_arl_api_last_error; }
string ARL_ApiReadiness_Endpoint(){ return g_arl_api_endpoint; }
string ARL_ApiReadiness_Detail(){ return g_arl_api_detail; }
string ARL_ApiReadiness_SkipReason(){ return g_arl_api_skip_reason; }
datetime ARL_ApiReadiness_LastCheckServerTime(){ return g_arl_api_last_check_server_time; }

#endif // __RUNTIME_ARL_API_READINESS_MQH__
