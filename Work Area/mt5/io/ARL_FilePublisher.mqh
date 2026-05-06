#ifndef __IO_ARL_FILEPUBLISHER_MQH__
#define __IO_ARL_FILEPUBLISHER_MQH__

//+------------------------------------------------------------------+
//| ARL_FilePublisher
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN011R
//| Status: STAGED WRITE + FOLDER CHAIN + READBACK + PROMOTE ONLY.
//+------------------------------------------------------------------+
// Owner: io/file publisher
// Purpose: Owns temp/write/flush/close/readback/promote/no-change publication.
// Inputs: final path, temp path, payload, required token validation status
// Outputs: ARL_FilePublishResult
// Forbidden: direct current writes, success without readback, strategy or trading logic

struct ARL_FilePublishResult
  {
   bool ok;
   bool no_change_skip;
   bool readback_ok;
   string code;
   string message;
   string final_path;
   string temp_path;
   int last_error;
   int bytes_written;
   int bytes_read;
   string payload_signature;
   string folder_diagnostic;
  };

bool ARL_FilePublisher_Init(){ return true; }

bool g_arl_filepublisher_disabled_logged = false;
bool g_arl_filepublisher_startup_diag_logged = false;
bool g_arl_filepublisher_probe_attempted = false;
string g_arl_filepublisher_last_printed_code = "";
bool g_arl_filepublisher_last_folder_ready = false;
int g_arl_filepublisher_last_folder_error = 0;
string g_arl_filepublisher_last_folder_diagnostic = "";

void ARL_FilePublisher_PrintStartupDiagnostics(const bool writes_enabled)
  {
   if(g_arl_filepublisher_startup_diag_logged)
      return;
   g_arl_filepublisher_startup_diag_logged = true;
   Print("ARL runtime IO diagnostics | product=", ARL_PRODUCT_NAME, " | version=", ARL_PRODUCT_VERSION, " | run_id=", ARL_PRODUCT_RUN_ID);
   Print("ARL runtime IO diagnostics | InpARL_EnableFileWrites=", (writes_enabled ? "true" : "false"), " | location_mode=", ARL_Paths_FileLocationMode());
   Print("ARL runtime IO diagnostics | TERMINAL_COMMONDATA_PATH=", ARL_Paths_CommonDataPath());
   Print("ARL runtime IO diagnostics | Common Files base=", ARL_Paths_CommonFilesBasePath());
   Print("ARL runtime IO diagnostics | TERMINAL_DATA_PATH=", ARL_Paths_TerminalDataPath());
   Print("ARL runtime IO diagnostics | Terminal local MQL5 Files base=", ARL_Paths_TerminalFilesBasePath());
   Print("ARL runtime IO diagnostics | status relative=", ARL_Paths_StatusCurrent());
   Print("ARL runtime IO diagnostics | manifest relative=", ARL_Paths_ManifestCurrent());
   Print("ARL runtime IO diagnostics | expected common status path=", ARL_Paths_AbsoluteCommonFilesStatusPattern());
   Print("ARL runtime IO diagnostics | expected common manifest path=", ARL_Paths_AbsoluteCommonFilesManifestPattern());
   Print("ARL runtime IO diagnostics | expected terminal-local status path=", ARL_Paths_AbsoluteTerminalFilesStatusPattern());
   Print("ARL runtime IO diagnostics | expected terminal-local manifest path=", ARL_Paths_AbsoluteTerminalFilesManifestPattern());
  }


string ARL_FilePublisher_PreflightLine(const bool writes_enabled,const bool allow_trading)
  {
   return "mode=" + ARL_Paths_FileLocationMode()
          + " | common_data=" + ARL_Paths_CommonDataPath()
          + " | common_files_base=" + ARL_Paths_CommonFilesBasePath()
          + " | relative_current_folder=" + ARL_Paths_CurrentFolder()
          + " | status_final=" + ARL_Paths_StatusCurrent()
          + " | status_temp=" + ARL_Paths_TempFor(ARL_Paths_StatusCurrent())
          + " | expected_common_status_abs=" + ARL_Paths_AbsoluteCommonFilesStatusPattern()
          + " | expected_terminal_local_status_abs=" + ARL_Paths_AbsoluteTerminalFilesStatusPattern()
          + " | manifest_final=" + ARL_Paths_ManifestCurrent()
          + " | manifest_temp=" + ARL_Paths_TempFor(ARL_Paths_ManifestCurrent())
          + " | expected_common_manifest_abs=" + ARL_Paths_AbsoluteCommonFilesManifestPattern()
          + " | expected_terminal_local_manifest_abs=" + ARL_Paths_AbsoluteTerminalFilesManifestPattern()
          + " | writes_enabled=" + (writes_enabled ? "true" : "false")
          + " | allow_trading=" + (allow_trading ? "true" : "false");
  }

bool ARL_FilePublisher_WriteCommonProbe(int &last_error)
  {
   last_error = 0;
   if(g_arl_filepublisher_probe_attempted)
      return true;
   g_arl_filepublisher_probe_attempted = true;

   string probe_path = "ARL_RuntimeWriteProbe.txt";
   string probe_payload = "ARL runtime diagnostic probe | " + ARL_PRODUCT_VERSION + " | " + ARL_PRODUCT_RUN_ID + " | " + TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS);
   ResetLastError();
   int handle = FileOpen(probe_path,FILE_WRITE|FILE_TXT|FILE_ANSI|ARL_Paths_CommonFlag()|FILE_SHARE_READ);
   if(handle == INVALID_HANDLE)
     {
      last_error = GetLastError();
      Print("ARL runtime IO probe FAILED | path=", probe_path, " | mode=", ARL_Paths_FileLocationMode(), " | last_error=", last_error);
      return false;
     }
   uint wrote = FileWriteString(handle,probe_payload);
   FileFlush(handle);
   FileClose(handle);
   Print("ARL runtime IO probe OK | path=", probe_path, " | mode=", ARL_Paths_FileLocationMode(), " | bytes_written=", (int)wrote);
   return true;
  }

void ARL_FilePublisher_PrintResultOnceOrOnFailure(const string artifact,const ARL_FilePublishResult &result)
  {
   if(result.ok && g_arl_filepublisher_last_printed_code == result.code)
      return;
   g_arl_filepublisher_last_printed_code = result.code;
   Print("ARL publish result: artifact=", artifact, "; code=", result.code, "; ok=", (result.ok ? "true" : "false"), "; last_error=", result.last_error, "; final=", result.final_path, "; temp=", result.temp_path, "; folder_ready=", (g_arl_filepublisher_last_folder_ready ? "true" : "false"));
   if(result.folder_diagnostic != "")
      Print("ARL publish folder diagnostic | ", result.folder_diagnostic);
   if(result.message != "")
      Print("ARL publish message | ", result.message);
  }

ARL_FilePublishResult ARL_FilePublisher_MakeResult(const bool ok,const string code,const string message,const string final_path,const string temp_path)
  {
   ARL_FilePublishResult r;
   r.ok = ok;
   r.no_change_skip = false;
   r.readback_ok = false;
   r.code = code;
   r.message = message;
   r.final_path = final_path;
   r.temp_path = temp_path;
   r.last_error = 0;
   r.bytes_written = 0;
   r.bytes_read = 0;
   r.payload_signature = "";
   r.folder_diagnostic = "";
   return r;
  }

bool ARL_FilePublisher_ReadAll(const string path,string &content,int &bytes_read,int &last_error)
  {
   content = "";
   bytes_read = 0;
   last_error = 0;
   ResetLastError();
   int handle = FileOpen(path,FILE_READ|FILE_TXT|FILE_ANSI|ARL_Paths_CommonFlag()|FILE_SHARE_READ);
   if(handle == INVALID_HANDLE)
     {
      last_error = GetLastError();
      return false;
     }
   ulong size = FileSize(handle);
   if(size > 0)
      content = FileReadString(handle,(int)size);
   bytes_read = (int)StringLen(content);
   FileClose(handle);
   return true;
  }

bool ARL_FilePublisher_WriteTemp(const string temp_path,const string payload,int &bytes_written,int &last_error)
  {
   bytes_written = 0;
   last_error = 0;
   ResetLastError();
   int handle = FileOpen(temp_path,FILE_WRITE|FILE_TXT|FILE_ANSI|ARL_Paths_CommonFlag()|FILE_SHARE_READ);
   if(handle == INVALID_HANDLE)
     {
      last_error = GetLastError();
      return false;
     }
   uint wrote = FileWriteString(handle,payload);
   FileFlush(handle);
   FileClose(handle);
   bytes_written = (int)wrote;
   return (wrote == (uint)StringLen(payload));
  }

ARL_FilePublishResult ARL_FilePublisher_Publish(const string final_path,const string payload,const bool writes_enabled,const string required_token)
  {
   string temp_path = ARL_Paths_TempFor(final_path);
   ARL_FilePublishResult result = ARL_FilePublisher_MakeResult(false,"INIT","publication not completed",final_path,temp_path);
   result.payload_signature = ARL_PayloadHash_Signature(payload);

   ARL_FilePublisher_PrintStartupDiagnostics(writes_enabled);

   if(!writes_enabled)
     {
      result.code = "WRITES_DISABLED";
      result.message = "file writes disabled by input; no files will be written; set InpARL_EnableFileWrites=true for runtime smoke; final_path=" + final_path + "; temp_path=" + temp_path;
      result.ok = false;
      if(!g_arl_filepublisher_disabled_logged)
        {
         g_arl_filepublisher_disabled_logged = true;
         Print("ARL runtime IO disabled by input. No files will be written. Set InpARL_EnableFileWrites=true for smoke test.");
        }
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }

   int probe_error = 0;
   ARL_FilePublisher_WriteCommonProbe(probe_error);

   g_arl_filepublisher_last_folder_ready = false;
   g_arl_filepublisher_last_folder_error = 0;
   g_arl_filepublisher_last_folder_diagnostic = "";
   string folder_diagnostic = "";
   int folder_error = 0;
   if(!ARL_Paths_EnsureCurrentFolderChain(folder_diagnostic,folder_error))
     {
      g_arl_filepublisher_last_folder_error = folder_error;
      g_arl_filepublisher_last_folder_diagnostic = folder_diagnostic;
      result.code = "FOLDER_CHAIN_CREATE_FAILED";
      result.message = "folder chain creation failed before nested write; final_path=" + final_path + "; temp_path=" + temp_path;
      result.last_error = folder_error;
      result.folder_diagnostic = folder_diagnostic;
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }
   g_arl_filepublisher_last_folder_ready = true;
   g_arl_filepublisher_last_folder_error = 0;
   g_arl_filepublisher_last_folder_diagnostic = folder_diagnostic;
   result.folder_diagnostic = folder_diagnostic;
   Print("ARL nested folder chain ready | ", folder_diagnostic);
   Print("ARL publish attempt | final=", final_path, " | temp=", temp_path, " | mode=", ARL_Paths_FileLocationMode());

   if(StringFind(payload,required_token) < 0)
     {
      result.code = "REQUIRED_TOKEN_MISSING";
      result.message = "payload missing required token: " + required_token + "; final_path=" + final_path + "; temp_path=" + temp_path;
      result.ok = false;
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }

   string current_payload = "";
   int current_bytes = 0;
   int current_error = 0;
   if(FileIsExist(final_path,ARL_Paths_CommonFlag()) && ARL_FilePublisher_ReadAll(final_path,current_payload,current_bytes,current_error))
     {
      if(ARL_PayloadHash_Equals(current_payload,payload))
        {
         result.ok = true;
         result.no_change_skip = true;
         result.readback_ok = true;
         result.code = "NO_CHANGE_SKIP";
         result.message = "current payload already matches requested payload; final_path=" + final_path;
         result.bytes_read = current_bytes;
         ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
         return result;
        }
     }

   if(FileIsExist(temp_path,ARL_Paths_CommonFlag()))
      FileDelete(temp_path,ARL_Paths_CommonFlag());

   int write_error = 0;
   int wrote = 0;
   if(!ARL_FilePublisher_WriteTemp(temp_path,payload,wrote,write_error))
     {
      result.code = "TEMP_WRITE_FAILED";
      result.message = "temp write failed; final_path=" + final_path + "; temp_path=" + temp_path;
      result.last_error = write_error;
      result.bytes_written = wrote;
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }
   result.bytes_written = wrote;

   string readback = "";
   int readback_bytes = 0;
   int readback_error = 0;
   if(!ARL_FilePublisher_ReadAll(temp_path,readback,readback_bytes,readback_error))
     {
      result.code = "TEMP_READBACK_FAILED";
      result.message = "temp readback failed; final_path=" + final_path + "; temp_path=" + temp_path;
      result.last_error = readback_error;
      result.bytes_read = readback_bytes;
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }
   result.bytes_read = readback_bytes;
   result.readback_ok = ARL_PayloadHash_Equals(readback,payload);
   if(!result.readback_ok)
     {
      result.code = "TEMP_READBACK_MISMATCH";
      result.message = "temp readback did not match payload; final_path=" + final_path + "; temp_path=" + temp_path;
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }

   ResetLastError();
   if(!FileMove(temp_path,ARL_Paths_CommonFlag(),final_path,ARL_Paths_CommonFlag()|FILE_REWRITE))
     {
      result.code = "PROMOTE_FAILED";
      result.message = "temp promote to current failed; final_path=" + final_path + "; temp_path=" + temp_path;
      result.last_error = GetLastError();
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }

   string final_readback = "";
   int final_bytes = 0;
   int final_error = 0;
   if(!ARL_FilePublisher_ReadAll(final_path,final_readback,final_bytes,final_error) || !ARL_PayloadHash_Equals(final_readback,payload))
     {
      result.code = "FINAL_READBACK_FAILED";
      result.message = "final readback failed after promote; final_path=" + final_path + "; temp_path=" + temp_path;
      result.last_error = final_error;
      result.bytes_read = final_bytes;
      result.ok = false;
      ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
      return result;
     }

   result.ok = true;
   result.code = "PUBLISHED";
   result.message = "temp written, read back, promoted, and final readback verified; final_path=" + final_path + "; temp_path=" + temp_path;
   result.bytes_read = final_bytes;
   ARL_FilePublisher_PrintResultOnceOrOnFailure(final_path,result);
   return result;
  }

string ARL_FilePublisher_ResultJson(const ARL_FilePublishResult &r)
  {
   return "{\"ok\":" + (r.ok ? "true" : "false") +
          ",\"code\":\"" + r.code + "\"" +
          ",\"message\":\"" + r.message + "\"" +
          ",\"last_error\":" + IntegerToString(r.last_error) +
          ",\"bytes_written\":" + IntegerToString(r.bytes_written) +
          ",\"bytes_read\":" + IntegerToString(r.bytes_read) +
          ",\"readback_ok\":" + (r.readback_ok ? "true" : "false") +
          ",\"no_change_skip\":" + (r.no_change_skip ? "true" : "false") +
          ",\"final_path\":\"" + r.final_path + "\"" +
          ",\"temp_path\":\"" + r.temp_path + "\"" +
          ",\"payload_signature\":\"" + r.payload_signature + "\"" +
          ",\"folder_diagnostic\":\"" + r.folder_diagnostic + "\"}";
  }

string ARL_FilePublisher_Contract(){ return "ACTIVE_STAGED_WRITE_FOLDER_CHAIN_READBACK_PROMOTE_NO_CHANGE_SKIP"; }

#endif // __IO_ARL_FILEPUBLISHER_MQH__
