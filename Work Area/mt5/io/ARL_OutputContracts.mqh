#ifndef __IO_ARL_OUTPUTCONTRACTS_MQH__
#define __IO_ARL_OUTPUTCONTRACTS_MQH__

//+------------------------------------------------------------------+
//| ARL_OutputContracts
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: REQUIRED TOKEN VALIDATION ONLY.
//+------------------------------------------------------------------+
// Owner: io/output contracts
// Purpose: Owns required-token checks for public artifacts.
// Inputs: artifact family and payload strings
// Outputs: true/false validation with compact reason
// Forbidden: suppressing partial data, rewriting payload content

bool ARL_OutputContracts_Init(){ return true; }

bool ARL_OutputContracts_Contains(const string payload,const string token)
  {
   return (StringFind(payload,token) >= 0);
  }

bool ARL_OutputContracts_ValidateStatusCurrent(const string payload,string &reason)
  {
   string required[12] = {"product_name","product_version","run_id","permission_text","heartbeat_count","scheduler_tick_count","file_writes_enabled","trade_permission","signal_permission","execution_permission","hud_permission","status_publication_result"};
   for(int i=0; i<ArraySize(required); i++)
     {
      if(!ARL_OutputContracts_Contains(payload,required[i]))
        {
         reason = "missing required token: " + required[i];
         return false;
        }
     }
   reason = "status required tokens present";
   return true;
  }

bool ARL_OutputContracts_ValidateManifestCurrent(const string payload,string &reason)
  {
   string required[9] = {"artifact_name","final_path","temp_path","publish_status","readback_status","no_change_skip","payload_size","permission_boundary","proof_boundary"};
   for(int i=0; i<ArraySize(required); i++)
     {
      if(!ARL_OutputContracts_Contains(payload,required[i]))
        {
         reason = "missing required token: " + required[i];
         return false;
        }
     }
   reason = "manifest required tokens present";
   return true;
  }

string ARL_OutputContracts_Contract(){ return "ACTIVE_REQUIRED_TOKEN_CHECKS"; }

#endif // __IO_ARL_OUTPUTCONTRACTS_MQH__
