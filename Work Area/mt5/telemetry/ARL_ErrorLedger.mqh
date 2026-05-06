#ifndef __TELEMETRY_ARL_ERRORLEDGER_MQH__
#define __TELEMETRY_ARL_ERRORLEDGER_MQH__

//+------------------------------------------------------------------+
//| ARL_ErrorLedger
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: COMPACT ERROR LEDGER ONLY.
//+------------------------------------------------------------------+
// Owner: telemetry/errors
// Purpose: Owns last runtime error capture and status summary.
// Inputs: module failure code/message/GetLastError values
// Outputs: compact last-error fields for status payloads
// Forbidden: concealing errors or converting errors into proof

int    g_arl_error_last_code = 0;
string g_arl_error_last_source = "NONE";
string g_arl_error_last_message = "NONE";
datetime g_arl_error_last_time = 0;

bool ARL_ErrorLedger_Init()
  {
   g_arl_error_last_code = 0;
   g_arl_error_last_source = "NONE";
   g_arl_error_last_message = "NONE";
   g_arl_error_last_time = 0;
   return true;
  }

void ARL_ErrorLedger_Record(const string source,const int code,const string message)
  {
   g_arl_error_last_source = source;
   g_arl_error_last_code = code;
   g_arl_error_last_message = message;
   g_arl_error_last_time = TimeCurrent();
  }

int ARL_ErrorLedger_LastCode()
  {
   return g_arl_error_last_code;
  }

string ARL_ErrorLedger_LastSource()
  {
   return g_arl_error_last_source;
  }

string ARL_ErrorLedger_LastMessage()
  {
   return g_arl_error_last_message;
  }

string ARL_ErrorLedger_Line()
  {
   return "ARL_ErrorLedger=ACTIVE;last_source=" + g_arl_error_last_source + ";last_code=" + IntegerToString(g_arl_error_last_code) + ";last_message=" + g_arl_error_last_message;
  }

#endif // __TELEMETRY_ARL_ERRORLEDGER_MQH__
