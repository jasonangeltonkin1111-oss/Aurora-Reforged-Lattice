#ifndef __IO_ARL_PATHS_MQH__
#define __IO_ARL_PATHS_MQH__

//+------------------------------------------------------------------+
//| ARL_Paths
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: CANONICAL FILE-SANDBOX PATHS ONLY.
//+------------------------------------------------------------------+
// Owner: io/paths
// Purpose: Owns output path construction and forbids random public paths.
// Inputs: product constants and artifact names
// Outputs: relative paths inside the MT5/Common Files sandbox
// Forbidden: writing payloads directly, account/server truth ownership

bool ARL_Paths_Init(){ return true; }

string ARL_Paths_ServerFolder()
  {
   return "Default";
  }

string ARL_Paths_CurrentFolder()
  {
   return ARL_OUTPUT_ROOT_FOLDER + "/" + ARL_Paths_ServerFolder() + "/Current";
  }

string ARL_Paths_StatusCurrent()
  {
   return ARL_Paths_CurrentFolder() + "/" + ARL_STATUS_CURRENT_FILE;
  }

string ARL_Paths_ManifestCurrent()
  {
   return ARL_Paths_CurrentFolder() + "/" + ARL_MANIFEST_CURRENT_FILE;
  }

string ARL_Paths_TempFor(const string final_path)
  {
   return final_path + ".tmp";
  }

int ARL_Paths_CommonFlag()
  {
   return FILE_COMMON;
  }

string ARL_Paths_Contract(){ return "COMMON_FILES_SANDBOX_CURRENT_ONLY"; }

#endif // __IO_ARL_PATHS_MQH__
