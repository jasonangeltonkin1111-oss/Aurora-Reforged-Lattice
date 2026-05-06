#ifndef __TELEMETRY_ARL_FUNCTIONRESULTS_MQH__
#define __TELEMETRY_ARL_FUNCTIONRESULTS_MQH__

//+------------------------------------------------------------------+
//| ARL_FunctionResults
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: COMPACT RESULT FORMATTING ONLY.
//+------------------------------------------------------------------+
// Owner: telemetry/function results
// Purpose: Owns compact function outcome text for debugging/status files.
// Inputs: function name/status/reason
// Outputs: function result line
// Forbidden: operator-facing essays, proof inflation, trading permission

bool ARL_FunctionResults_Init(){ return true; }

string ARL_FunctionResults_Format(const string function_name,const bool ok,const string code,const string message)
  {
   return function_name + "|ok=" + (ok ? "true" : "false") + "|code=" + code + "|message=" + message;
  }

string ARL_FunctionResults_Line(){ return "ARL_FunctionResults=ACTIVE"; }

#endif // __TELEMETRY_ARL_FUNCTIONRESULTS_MQH__
