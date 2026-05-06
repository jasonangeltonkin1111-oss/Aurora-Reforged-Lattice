#ifndef __IO_ARL_FILEPUBLISHER_MQH__
#define __IO_ARL_FILEPUBLISHER_MQH__

//+------------------------------------------------------------------+
//| ARL_FilePublisher
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: STAGED WRITE + READBACK + PROMOTE ONLY.
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
  };

bool ARL_FilePublisher_Init(){ return true; }

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
   return r;
  }

bool ARL_FilePublisher_ReadAll(const string path,string &content,int &bytes_read,int &last_error)
  {
   content = "";
   bytes_read = 0;
   last_error = 0;
   ResetLastError();
   int handle = FileOpen(path,FILE_READ|FILE_TXT|FILE_ANSI|FILE_COMMON|FILE_SHARE_READ);
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
   int handle = FileOpen(temp_path,FILE_WRITE|FILE_TXT|FILE_ANSI|FILE_COMMON|FILE_SHARE_READ);
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

   if(!writes_enabled)
     {
      result.code = "WRITES_DISABLED";
      result.message = "file writes disabled by input";
      result.ok = false;
      return result;
     }

   if(StringFind(payload,required_token) < 0)
     {
      result.code = "REQUIRED_TOKEN_MISSING";
      result.message = "payload missing required token: " + required_token;
      result.ok = false;
      return result;
     }

   string current_payload = "";
   int current_bytes = 0;
   int current_error = 0;
   if(FileIsExist(final_path,FILE_COMMON) && ARL_FilePublisher_ReadAll(final_path,current_payload,current_bytes,current_error))
     {
      if(ARL_PayloadHash_Equals(current_payload,payload))
        {
         result.ok = true;
         result.no_change_skip = true;
         result.readback_ok = true;
         result.code = "NO_CHANGE_SKIP";
         result.message = "current payload already matches requested payload";
         result.bytes_read = current_bytes;
         return result;
        }
     }

   if(FileIsExist(temp_path,FILE_COMMON))
      FileDelete(temp_path,FILE_COMMON);

   int write_error = 0;
   int wrote = 0;
   if(!ARL_FilePublisher_WriteTemp(temp_path,payload,wrote,write_error))
     {
      result.code = "TEMP_WRITE_FAILED";
      result.message = "temp write failed";
      result.last_error = write_error;
      result.bytes_written = wrote;
      return result;
     }
   result.bytes_written = wrote;

   string readback = "";
   int readback_bytes = 0;
   int readback_error = 0;
   if(!ARL_FilePublisher_ReadAll(temp_path,readback,readback_bytes,readback_error))
     {
      result.code = "TEMP_READBACK_FAILED";
      result.message = "temp readback failed";
      result.last_error = readback_error;
      result.bytes_read = readback_bytes;
      return result;
     }
   result.bytes_read = readback_bytes;
   result.readback_ok = ARL_PayloadHash_Equals(readback,payload);
   if(!result.readback_ok)
     {
      result.code = "TEMP_READBACK_MISMATCH";
      result.message = "temp readback did not match payload";
      return result;
     }

   ResetLastError();
   if(!FileMove(temp_path,FILE_COMMON,final_path,FILE_COMMON|FILE_REWRITE))
     {
      result.code = "PROMOTE_FAILED";
      result.message = "temp promote to current failed";
      result.last_error = GetLastError();
      return result;
     }

   string final_readback = "";
   int final_bytes = 0;
   int final_error = 0;
   if(!ARL_FilePublisher_ReadAll(final_path,final_readback,final_bytes,final_error) || !ARL_PayloadHash_Equals(final_readback,payload))
     {
      result.code = "FINAL_READBACK_FAILED";
      result.message = "final readback failed after promote";
      result.last_error = final_error;
      result.bytes_read = final_bytes;
      result.ok = false;
      return result;
     }

   result.ok = true;
   result.code = "PUBLISHED";
   result.message = "temp written, read back, promoted, and final readback verified";
   result.bytes_read = final_bytes;
   return result;
  }

string ARL_FilePublisher_ResultJson(const ARL_FilePublishResult &r)
  {
   return "{"ok":" + (r.ok ? "true" : "false") +
          ","code":"" + r.code + """ +
          ","message":"" + r.message + """ +
          ","last_error":" + IntegerToString(r.last_error) +
          ","bytes_written":" + IntegerToString(r.bytes_written) +
          ","bytes_read":" + IntegerToString(r.bytes_read) +
          ","readback_ok":" + (r.readback_ok ? "true" : "false") +
          ","no_change_skip":" + (r.no_change_skip ? "true" : "false") +
          ","final_path":"" + r.final_path + """ +
          ","temp_path":"" + r.temp_path + """ +
          ","payload_signature":"" + r.payload_signature + ""}";
  }

string ARL_FilePublisher_Contract(){ return "ACTIVE_STAGED_WRITE_READBACK_PROMOTE_NO_CHANGE_SKIP"; }

#endif // __IO_ARL_FILEPUBLISHER_MQH__
