#ifndef __ASC_LOGGING_MQH__
#define __ASC_LOGGING_MQH__

#include "ASC_FunctionResults.mqh"
#include "../io/ASC_FileIO.mqh"


string ASC_FunctionResultStateToken(const ASC_FunctionResultState state)
  {
   switch(state)
     {
      case ASC_RESULT_OK: return "ok";
      case ASC_RESULT_WARNING: return "warning";
      case ASC_RESULT_ERROR: return "error";
     }
   return "unknown";
  }

int ASC_FunctionResultDurationMs(const ASC_FunctionResult &result)
  {
   if(result.started_utc <= 0 || result.finished_utc <= 0 || result.finished_utc < result.started_utc)
      return 0;
   return (int)((result.finished_utc - result.started_utc) * 1000);
  }

string ASC_FormatUtc(const datetime value)
  {
   if(value <= 0)
      return "n/a";
   return TimeToString(value, TIME_DATE | TIME_SECONDS);
  }

string ASC_FunctionResultLogField(const string value)
  {
   string field = value;
   if(StringLen(field) <= 0)
      field = "unspecified";
   StringReplace(field, "\r", " ");
   StringReplace(field, "\n", " ");
   StringReplace(field, "\t", " ");
   return field;
  }
#define ASC_FUNCTION_RESULTS_REPEAT_OK_DEDUPE_WINDOW_SEC 900
#define ASC_FUNCTION_RESULTS_RUN147_PRESSURE_GUARD "repeat_ok_dedupe_900sec_preserve_warning_error_fail_state_change_missing_stale_tmp_queue_stalled"

bool ASC_FunctionResultIsFailureOrWarning(const ASC_FunctionResult &result)
  {
   return (result.state != ASC_RESULT_OK || result.code != ASC_RC_OK);
  }

bool ASC_FunctionResultFileWriteAllowed(const ASC_FunctionResult &result)
  {
   if(ASC_FunctionResultIsFailureOrWarning(result))
      return true;

   string row_class = ASC_FunctionResultResolvedProofRowClass(result);
   if(row_class == ASC_PROOF_ROW_CLASS_STATE_CHANGE)
      return true;

   static string last_ok_key = "";
   static datetime last_ok_write_utc = 0;

   string key = result.module_name + "|" + result.function_name + "|" + result.scope + "|"
                + ASC_FunctionResultStateToken(result.state) + "|" + IntegerToString((int)result.code) + "|"
                + ASC_FunctionResultLogField(result.proof_event) + "|"
                + ASC_FunctionResultLogField(result.proof_status) + "|"
                + ASC_FunctionResultLogField(row_class) + "|"
                + ASC_FunctionResultLogField(result.target_path) + "|"
                + ASC_FunctionResultLogField(result.detail_message);
   datetime now_utc = TimeGMT();
   if(key == last_ok_key
      && last_ok_write_utc > 0
      && (now_utc - last_ok_write_utc) < ASC_FUNCTION_RESULTS_REPEAT_OK_DEDUPE_WINDOW_SEC)
      return false;

   last_ok_key = key;
   last_ok_write_utc = now_utc;
   return true;
  }

void ASC_LogInfo(const string module_name,
                 const string function_name,
                 const string scope,
                 const string detail)
  {
   PrintFormat("[ASC][INFO][%s::%s][%s] %s", module_name, function_name, scope, detail);
  }

bool ASC_FunctionResultConsoleWriteAllowed(const ASC_FunctionResult &result)
  {
   return true;
  }

void ASC_LogFunctionResult(const ASC_FunctionResult &result)
  {
   if(!ASC_FunctionResultConsoleWriteAllowed(result))
      return;
   PrintFormat("[ASC][RESULT][%s::%s][%s] state=%s(%d) code=%d duration_ms=%d source_owner=%s truth_boundary=%s hydration_class=%s proof_event=%s proof_status=%s proof_row_class=%s detail=%s target=%s",
               result.module_name,
               result.function_name,
               result.scope,
               ASC_FunctionResultStateToken(result.state),
               (int)result.state,
               (int)result.code,
               ASC_FunctionResultDurationMs(result),
               ASC_FunctionResultLogField(result.source_owner),
               ASC_FunctionResultLogField(result.truth_boundary),
               ASC_FunctionResultLogField(result.hydration_class),
               ASC_FunctionResultLogField(result.proof_event),
               ASC_FunctionResultLogField(result.proof_status),
               ASC_FunctionResultLogField(ASC_FunctionResultResolvedProofRowClass(result)),
               ASC_FunctionResultLogField(ASC_FunctionResultDetailWithProofRowClass(result)),
               ASC_FunctionResultLogField(result.target_path));
  }

string ASC_FunctionResultFileLogLine(const ASC_FunctionResult &result)
  {
   return StringFormat("%s\t%s\t%s\t%s\tstate=%s\tstate_code=%d\tcode=%d\tduration_ms=%d\tsource_owner=%s\ttruth_boundary=%s\thydration_class=%s\tproof_event=%s\tproof_status=%s\tdetail=%s\ttarget=%s\n",
                       ASC_FormatUtc(result.finished_utc > 0 ? result.finished_utc : TimeGMT()),
                       result.module_name,
                       result.function_name,
                       result.scope,
                       ASC_FunctionResultStateToken(result.state),
                       (int)result.state,
                       (int)result.code,
                       ASC_FunctionResultDurationMs(result),
                       ASC_FunctionResultLogField(result.source_owner),
                       ASC_FunctionResultLogField(result.truth_boundary),
                       ASC_FunctionResultLogField(result.hydration_class),
                       ASC_FunctionResultLogField(result.proof_event),
                       ASC_FunctionResultLogField(result.proof_status),
                       ASC_FunctionResultLogField(ASC_FunctionResultDetailWithProofRowClass(result)),
                       ASC_FunctionResultLogField(result.target_path));
  }

bool ASC_LogFunctionResultToFileObserved(const ASC_FunctionResult &result,
                                         const string log_path,
                                         int &last_error_out)
  {
   last_error_out = 0;
   if(StringLen(log_path) <= 0)
     {
      last_error_out = -1;
      return false;
     }

   if(!ASC_FunctionResultFileWriteAllowed(result))
      return true;

   ResetLastError();
   bool written = ASC_AppendTextFile(log_path, ASC_FunctionResultFileLogLine(result));
   last_error_out = written ? 0 : GetLastError();
   return written;
  }

bool ASC_LogFunctionResultToFile(const ASC_FunctionResult &result,const string log_path)
  {
   int ignored_last_error = 0;
   return ASC_LogFunctionResultToFileObserved(result, log_path, ignored_last_error);
  }

#endif
