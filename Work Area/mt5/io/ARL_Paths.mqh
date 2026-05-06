#ifndef __IO_ARL_PATHS_MQH__
#define __IO_ARL_PATHS_MQH__

//+------------------------------------------------------------------+
//| ARL_Paths
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN011R
//| Status: CANONICAL FILE-SANDBOX PATHS + FOLDER CHAIN PROOF.
//+------------------------------------------------------------------+
// Owner: io/paths
// Purpose: Owns output path construction, common/local diagnostics, and folder-chain creation for nested runtime outputs.
// Inputs: product constants and artifact names
// Outputs: relative paths inside the MT5/Common Files sandbox
// Forbidden: writing payloads directly, account/server truth ownership, duplicate output routes

bool ARL_Paths_Init(){ return true; }

string ARL_Paths_ServerFolder()
  {
   return "Default";
  }

string ARL_Paths_OutputRootFolder()
  {
   return ARL_OUTPUT_ROOT_FOLDER;
  }

string ARL_Paths_ServerRelativeFolder()
  {
   return ARL_Paths_OutputRootFolder() + "/" + ARL_Paths_ServerFolder();
  }

string ARL_Paths_CurrentFolder()
  {
   return ARL_Paths_ServerRelativeFolder() + "/Current";
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

string ARL_Paths_FileLocationMode()
  {
   return "COMMON_FILES";
  }

string ARL_Paths_CommonDataPath()
  {
   return TerminalInfoString(TERMINAL_COMMONDATA_PATH);
  }

string ARL_Paths_CommonFilesBasePath()
  {
   return TerminalInfoString(TERMINAL_COMMONDATA_PATH) + "\\Files";
  }

string ARL_Paths_TerminalDataPath()
  {
   return TerminalInfoString(TERMINAL_DATA_PATH);
  }

string ARL_Paths_TerminalFilesBasePath()
  {
   return TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL5\\Files";
  }

string ARL_Paths_AbsoluteCommonFilesStatusPattern()
  {
   return ARL_Paths_CommonFilesBasePath() + "\\" + ARL_OUTPUT_ROOT_FOLDER + "\\" + ARL_Paths_ServerFolder() + "\\Current\\" + ARL_STATUS_CURRENT_FILE;
  }
string ARL_Paths_AbsoluteCommonFilesFolder()
  {
   return ARL_Paths_CommonFilesBasePath() + "\\" + ARL_OUTPUT_ROOT_FOLDER + "\\" + ARL_Paths_ServerFolder() + "\\Current";
  }

string ARL_Paths_AbsoluteCommonFilesManifestPattern()
  {
   return ARL_Paths_CommonFilesBasePath() + "\\" + ARL_OUTPUT_ROOT_FOLDER + "\\" + ARL_Paths_ServerFolder() + "\\Current\\" + ARL_MANIFEST_CURRENT_FILE;
  }

bool ARL_Paths_CreateFolderLevel(const string folder_name,string &diagnostic,int &last_error)
  {
   ResetLastError();
   bool ok = FolderCreate(folder_name,FILE_COMMON);
   last_error = GetLastError();

   bool exists = false;
   bool already_exists_error = false;

   if(!ok)
     {
      exists = FileIsExist(folder_name,FILE_COMMON);
      already_exists_error = (last_error == ERR_FILE_ALREADY_EXISTS);
      if(exists || already_exists_error)
        {
         ok = true;
         last_error = 0;
        }
     }

   diagnostic += "folder='" + folder_name + "' ok=" + (ok ? "true" : "false") + " error=" + IntegerToString(last_error) + " exists=" + (exists ? "true" : "false") + "; ";
   return ok;
  }

bool ARL_Paths_EnsureCurrentFolderChain(string &diagnostic,int &last_error)
  {
   diagnostic = "mode=" + ARL_Paths_FileLocationMode() + "; ";
   last_error = 0;

   int level_error = 0;
   bool root_ok = ARL_Paths_CreateFolderLevel(ARL_Paths_OutputRootFolder(),diagnostic,level_error);
   if(!root_ok)
     {
      last_error = level_error;
      return false;
     }

   bool server_ok = ARL_Paths_CreateFolderLevel(ARL_Paths_ServerRelativeFolder(),diagnostic,level_error);
   if(!server_ok)
     {
      last_error = level_error;
      return false;
     }

   bool current_ok = ARL_Paths_CreateFolderLevel(ARL_Paths_CurrentFolder(),diagnostic,level_error);
   if(!current_ok)
     {
      last_error = level_error;
      return false;
     }

   last_error = 0;
   return true;
  }

string ARL_Paths_DiagnosticLine()
  {
   return "ARL paths: mode=" + ARL_Paths_FileLocationMode() +
          " | common_data=" + ARL_Paths_CommonDataPath() +
          " | common_files_base=" + ARL_Paths_CommonFilesBasePath() +
          " | terminal_data=" + ARL_Paths_TerminalDataPath() +
          " | terminal_files_base=" + ARL_Paths_TerminalFilesBasePath() +
          " | status_current=" + ARL_Paths_StatusCurrent() +
          " | manifest_current=" + ARL_Paths_ManifestCurrent();
  }

string ARL_Paths_Contract(){ return "COMMON_FILES_SANDBOX_CURRENT_ONLY_WITH_RUNTIME_FOLDER_CHAIN_DIAGNOSTICS"; }

#endif // __IO_ARL_PATHS_MQH__
