#ifndef __ASC_FILE_IO_MQH__
#define __ASC_FILE_IO_MQH__

bool ASC_EnsureDirectory(const string path)
  {
   if(StringLen(path) <= 0)
      return false;

   ResetLastError();
   if(FolderCreate(path))
      return true;

   int create_error = GetLastError();
   if(create_error == 5019 /* ERR_DIRECTORY_EXISTS */)
      return true;

   if(FileIsExist(path, FILE_COMMON))
      return true;

   return false;
  }

bool ASC_PathIsDirectorySeparator(const string ch)
  {
   return (ch == "\\" || ch == "/");
  }

int ASC_PathLastDirectorySeparatorIndex(const string path)
  {
   for(int i = StringLen(path) - 1; i >= 0; i--)
     {
      string ch = StringSubstr(path, i, 1);
      if(ASC_PathIsDirectorySeparator(ch))
         return i;
     }
   return -1;
  }

string ASC_PathParentDirectory(const string path)
  {
   int slash_index = ASC_PathLastDirectorySeparatorIndex(path);
   if(slash_index <= 0)
      return "";
   return StringSubstr(path, 0, slash_index);
  }

bool ASC_EnsureDirectoryTree(const string path)
  {
   if(StringLen(path) <= 0)
      return false;

   if(ASC_EnsureDirectory(path))
      return true;

   string parent = ASC_PathParentDirectory(path);
   if(StringLen(parent) <= 0 || parent == path)
      return false;

   if(!ASC_EnsureDirectoryTree(parent))
      return false;

   return ASC_EnsureDirectory(path);
  }

bool ASC_WriteTextFile(const string path,const string text)
  {
   int handle = FileOpen(path, FILE_WRITE | FILE_TXT | FILE_COMMON | FILE_UNICODE | FILE_SHARE_READ | FILE_SHARE_WRITE);
   if(handle == INVALID_HANDLE)
      return false;

   FileWriteString(handle, text);
   FileFlush(handle);
   FileClose(handle);
   return true;
  }

bool ASC_ReadTextFileWithFlags(const string path,const uint flags,string &text)
  {
   text = "";
   int handle = FileOpen(path, FILE_READ | FILE_TXT | FILE_COMMON | FILE_SHARE_READ | FILE_SHARE_WRITE | flags);
   if(handle == INVALID_HANDLE)
      return false;

   string rebuilt = "";
   while(!FileIsEnding(handle))
     {
      string part = FileReadString(handle);
      rebuilt += part;
      if(!FileIsEnding(handle))
         rebuilt += "\n";
     }

   FileClose(handle);
   text = rebuilt;
   return (StringLen(text) > 0);
  }

bool ASC_ReadTextFile(const string path,string &text)
  {
   if(ASC_ReadTextFileWithFlags(path, FILE_UNICODE, text))
      return true;
   return ASC_ReadTextFileWithFlags(path, FILE_ANSI, text);
  }

string ASC_NormalizeTextForReadbackCompare(const string text_raw)
  {
   string text = text_raw;
   if(StringLen(text) > 0)
     {
      ushort first = (ushort)StringGetCharacter(text, 0);
      if(first == 0xFEFF)
         text = StringSubstr(text, 1);
     }

   StringReplace(text, "\r", "");
   while(StringLen(text) > 0)
     {
      int last = StringLen(text) - 1;
      if(StringSubstr(text, last, 1) != "\n")
         break;
      text = StringSubstr(text, 0, last);
     }
   return text;
  }

bool ASC_PublicationPayloadExactlyEqual(const string expected_payload,const string actual_payload)
  {
   return (ASC_NormalizeTextForReadbackCompare(expected_payload) == ASC_NormalizeTextForReadbackCompare(actual_payload));
  }


bool ASC_FileExistsCommon(const string path)
  {
   if(StringLen(path) <= 0)
      return false;
   ResetLastError();
   return FileIsExist(path, FILE_COMMON);
  }


bool ASC_DeleteFileIfExists(const string path)
  {
   if(StringLen(path) <= 0)
      return false;
   if(!ASC_FileExistsCommon(path))
      return true;
   ResetLastError();
   return FileDelete(path, FILE_COMMON);
  }

bool ASC_CopyTextFileAtomic(const string source_path,
                            const string target_path,
                            const string &required_tokens[],
                            string &write_state_out,
                            string &write_reason_out)
  {
   write_state_out = "pending";
   write_reason_out = "pending";

   string payload = "";
   if(!ASC_ReadTextFile(source_path, payload) || StringLen(payload) <= 0)
     {
      write_state_out = "source_missing";
      write_reason_out = "source_payload_missing";
      return false;
     }

   string publication_state = "pending";
   return ASC_WritePublicationPayloadAtomic(target_path,
                                            payload,
                                            required_tokens,
                                            publication_state,
                                            write_state_out,
                                            write_reason_out);
  }

bool ASC_FileTryGetModifyUtc(const string path,datetime &modify_utc_out)
  {
   modify_utc_out = 0;
   if(StringLen(path) <= 0)
      return false;

   ResetLastError();
   long modify_value = FileGetInteger(path, FILE_MODIFY_DATE, true);
   if(modify_value < 0)
      return false;

   modify_utc_out = (datetime)modify_value;
   return true;
  }

bool ASC_FileIsFreshSince(const string path,const datetime min_utc)
  {
   if(!ASC_FileExistsCommon(path))
      return false;
   if(min_utc <= 0)
      return true;

   datetime modify_utc = 0;
   if(!ASC_FileTryGetModifyUtc(path, modify_utc))
      return false;

   return (modify_utc >= min_utc);
  }

bool ASC_TextHasRequiredTokens(const string text,const string &required_tokens[])
  {
   for(int i = 0; i < ArraySize(required_tokens); i++)
     {
      if(StringLen(required_tokens[i]) <= 0)
         continue;
      if(StringFind(text, required_tokens[i]) < 0)
         return false;
     }
   return true;
  }

string ASC_FirstMissingRequiredToken(const string text,const string &required_tokens[])
  {
   for(int i = 0; i < ArraySize(required_tokens); i++)
     {
      if(StringLen(required_tokens[i]) <= 0)
         continue;
      if(StringFind(text, required_tokens[i]) < 0)
         return required_tokens[i];
     }
   return "";
  }

bool ASC_ReadAndCheckPayloadTokenContract(const string path,
                                const string &required_tokens[],
                                string &token_contract_reason_out)
  {
   token_contract_reason_out = "readback_token_contract_satisfied";

   string payload = "";
   if(!ASC_ReadTextFile(path, payload))
     {
      token_contract_reason_out = "payload readback failed";
      return false;
     }

   if(StringLen(payload) <= 0)
     {
      token_contract_reason_out = "payload is empty";
      return false;
     }

   string missing_token = ASC_FirstMissingRequiredToken(payload, required_tokens);
   if(StringLen(missing_token) > 0)
     {
      token_contract_reason_out = "required token contract failed missing_token=" + missing_token;
      return false;
     }

   return true;
  }

string ASC_PublicationPayloadId(const string text);

bool ASC_ReadAndCheckPayloadTokenContractAgainstExpected(const string path,
                                               const string expected_payload,
                                               const string &required_tokens[],
                                               string &token_contract_reason_out)
  {
   token_contract_reason_out = "readback_token_contract_satisfied";

   string payload = "";
   if(!ASC_ReadTextFile(path, payload))
     {
      token_contract_reason_out = "payload readback failed";
      return false;
     }

   if(StringLen(payload) <= 0)
     {
      token_contract_reason_out = "payload is empty";
      return false;
     }

   string missing_token = ASC_FirstMissingRequiredToken(payload, required_tokens);
   if(StringLen(missing_token) > 0)
     {
      token_contract_reason_out = "required token contract failed missing_token=" + missing_token;
      return false;
     }

   if(!ASC_PublicationPayloadExactlyEqual(expected_payload, payload))
     {
      token_contract_reason_out = StringFormat("payload readback mismatch expected_id=%s actual_id=%s",
                                           (StringLen(ASC_PublicationPayloadId(expected_payload)) > 0 ? ASC_PublicationPayloadId(expected_payload) : "unavailable"),
                                           (StringLen(ASC_PublicationPayloadId(payload)) > 0 ? ASC_PublicationPayloadId(payload) : "unavailable"));
      return false;
     }

   return true;
  }


string ASC_PublicationPayloadBody(const string payload)
  {
   string normalized = ASC_NormalizeTextForReadbackCompare(payload);
   int first_break = StringFind(normalized, "\n");
   if(first_break < 0)
      return normalized;

   int second_break = StringFind(normalized, "\n", first_break + 1);
   if(second_break < 0)
      return normalized;

   int body_start = second_break + 1;
   if(body_start < StringLen(normalized) && StringSubstr(normalized, body_start, 1) == "\n")
      body_start++;

   return StringSubstr(normalized, body_start);
  }

bool ASC_PublicationPayloadMateriallyEqual(const string existing_payload,const string candidate_payload)
  {
   if(StringLen(existing_payload) <= 0 || StringLen(candidate_payload) <= 0)
      return false;

   if(existing_payload == candidate_payload)
      return true;

   return (ASC_PublicationPayloadBody(existing_payload) == ASC_PublicationPayloadBody(candidate_payload));
  }


bool ASC_PublicationReasonContains(const string publication_reason,const string token)
  {
   return (StringLen(publication_reason) > 0
           && StringLen(token) > 0
           && StringFind(publication_reason, token) >= 0);
  }

bool ASC_PublicationReasonIndicatesNoMaterialChange(const string publication_reason)
  {
   return (ASC_PublicationReasonContains(publication_reason, "reason=no_material_change")
           || ASC_PublicationReasonContains(publication_reason, "operation=skip_write")
           || ASC_PublicationReasonContains(publication_reason, "operation=skip_pair_publish"));
  }


bool ASC_WriteTextFileAtomic(const string path,
                             const string text,
                             const string &required_tokens[],
                             const string desired_publication_state,
                             string &publication_state_out,
                             string &publication_reason_out)
  {
   publication_state_out = "pending";
   publication_reason_out = "pending publish";
   ulong publish_started_us = GetMicrosecondCount();

   if(StringLen(text) <= 0)
     {
      publication_state_out = "failure";
      publication_reason_out = "empty payload";
      return false;
     }

   string missing_token = ASC_FirstMissingRequiredToken(text, required_tokens);
   if(StringLen(missing_token) > 0)
     {
      publication_state_out = "failure";
      publication_reason_out = "required token contract failed missing_token=" + missing_token;
      return false;
     }

   string existing_payload = "";
   if(ASC_ReadTextFile(path, existing_payload)
      && ASC_PublicationPayloadMateriallyEqual(existing_payload, text))
     {
      publication_state_out = desired_publication_state;
      publication_reason_out = StringFormat("operation=skip_write final_path=%s elapsed_ms=%d reason=no_material_change", path, (int)((GetMicrosecondCount() - publish_started_us) / 1000));
      return true;
     }

   string parent_directory = ASC_PathParentDirectory(path);
   if(StringLen(parent_directory) <= 0 || !ASC_EnsureDirectoryTree(parent_directory))
     {
      publication_state_out = "failure";
      publication_reason_out = StringFormat("operation=ensure_directory final_path=%s parent=%s reason=directory_create_failed",
                                            path,
                                            (StringLen(parent_directory) > 0 ? parent_directory : "unavailable"));
      return false;
     }

   string temp_path = path + ".tmp";
   if(!ASC_WriteTextFile(temp_path, text))
     {
      int temp_error = GetLastError();
      string existing = "";
      string retained = "no";
      if(ASC_ReadTextFile(path, existing) && StringLen(existing) > 0)
        {
         publication_state_out = "continuity";
         retained = "yes";
         publication_reason_out = StringFormat("operation=write_temp temp_path=%s final_path=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=temp write failed",
                                               temp_path,
                                               path,
                                               temp_error,
                                               (int)((GetMicrosecondCount() - publish_started_us) / 1000),
                                               retained);
         return true;
        }
      else
        {
         publication_state_out = "failure";
         publication_reason_out = StringFormat("operation=write_temp temp_path=%s final_path=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=temp write failed",
                                               temp_path,
                                               path,
                                               temp_error,
                                               (int)((GetMicrosecondCount() - publish_started_us) / 1000),
                                               retained);
         return false;
        }
     }

   string token_contract_reason = "";
   if(!ASC_ReadAndCheckPayloadTokenContractAgainstExpected(temp_path, text, required_tokens, token_contract_reason))
     {
      FileDelete(temp_path, FILE_COMMON);
      string existing = "";
      string retained = "no";
      if(ASC_ReadTextFile(path, existing) && StringLen(existing) > 0)
        {
         publication_state_out = "continuity";
         retained = "yes";
         publication_reason_out = StringFormat("operation=readback_token_contract temp_path=%s final_path=%s elapsed_ms=%d retained_last_good=%s reason=%s",
                                               temp_path,
                                               path,
                                               (int)((GetMicrosecondCount() - publish_started_us) / 1000),
                                               retained,
                                               token_contract_reason);
         return true;
        }

      publication_state_out = "failure";
      publication_reason_out = StringFormat("operation=readback_token_contract temp_path=%s final_path=%s elapsed_ms=%d retained_last_good=%s reason=%s",
                                            temp_path,
                                            path,
                                            (int)((GetMicrosecondCount() - publish_started_us) / 1000),
                                            retained,
                                            token_contract_reason);
      return false;
     }

   ResetLastError();
   if(!FileMove(temp_path, FILE_COMMON, path, FILE_COMMON | FILE_REWRITE))
     {
      int promote_error = GetLastError();
      FileDelete(temp_path, FILE_COMMON);
      string existing = "";
      string retained = "no";
      if(ASC_ReadTextFile(path, existing) && StringLen(existing) > 0)
        {
         publication_state_out = "continuity";
         retained = "yes";
         publication_reason_out = StringFormat("operation=promote temp_path=%s final_path=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=promote failed",
                                               temp_path,
                                               path,
                                               promote_error,
                                               (int)((GetMicrosecondCount() - publish_started_us) / 1000),
                                               retained);
         return true;
        }
      else
        {
         publication_state_out = "failure";
         publication_reason_out = StringFormat("operation=promote temp_path=%s final_path=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=promote failed",
                                               temp_path,
                                               path,
                                               promote_error,
                                               (int)((GetMicrosecondCount() - publish_started_us) / 1000),
                                               retained);
         return false;
        }
     }

   publication_state_out = desired_publication_state;
   publication_reason_out = StringFormat("operation=promote temp_path=%s final_path=%s error_code=0 elapsed_ms=%d retained_last_good=no reason=temp write readback_token_contract_satisfied and promoted",
                                         temp_path,
                                         path,
                                         (int)((GetMicrosecondCount() - publish_started_us) / 1000));
   return true;
  }

string ASC_PublicationHeaderUtc(const datetime publication_utc)
  {
   if(publication_utc <= 0)
      return "Not yet observed";
   return TimeToString(publication_utc, TIME_DATE | TIME_SECONDS) + " UTC";
  }

string ASC_BuildPublicationHeader(const string publication_id,const datetime publication_utc)
  {
   string header = "";
   header += StringFormat("Publication Id: %s\n", (StringLen(publication_id) > 0 ? publication_id : "unavailable"));
   header += StringFormat("Publication UTC: %s\n\n", ASC_PublicationHeaderUtc(publication_utc));
   return header;
  }

bool ASC_WritePublicationArtifact(const string path,
                                  const string publication_id,
                                  const datetime publication_utc,
                                  const string body,
                                  const string &required_tokens[],
                                  const string desired_publication_state,
                                  string &publication_state_out,
                                  string &publication_reason_out)
  {
   string payload = ASC_BuildPublicationHeader(publication_id, publication_utc) + body;
   return ASC_WriteTextFileAtomic(path,
                                  payload,
                                  required_tokens,
                                  desired_publication_state,
                                  publication_state_out,
                                  publication_reason_out);
  }


bool ASC_WritePublicationPayloadAtomic(const string path,
                                       const string payload,
                                       const string &required_tokens[],
                                       const string desired_publication_state,
                                       string &publication_state_out,
                                       string &publication_reason_out)
  {
   return ASC_WriteTextFileAtomic(path,
                                  payload,
                                  required_tokens,
                                  desired_publication_state,
                                  publication_state_out,
                                  publication_reason_out);
  }

bool ASC_VerifyPublicationPayloadReadback(const string path,
                                          const string expected_payload,
                                          string &verification_reason)
  {
   verification_reason = "pending";

   string readback_payload = "";
   if(!ASC_ReadTextFile(path, readback_payload) || StringLen(readback_payload) <= 0)
     {
      verification_reason = "readback_missing path=" + path;
      return false;
     }

   string expected_id = ASC_PublicationPayloadId(expected_payload);
   string readback_id = ASC_PublicationPayloadId(readback_payload);
   if(!ASC_PublicationPayloadExactlyEqual(expected_payload, readback_payload))
     {
      verification_reason = StringFormat("readback_payload_mismatch path=%s expected_id=%s actual_id=%s",
                                         path,
                                         (StringLen(expected_id) > 0 ? expected_id : "unavailable"),
                                         (StringLen(readback_id) > 0 ? readback_id : "unavailable"));
      return false;
     }

   verification_reason = StringFormat("readback_verified path=%s publication_id=%s",
                                      path,
                                      (StringLen(readback_id) > 0 ? readback_id : "unavailable"));
   return true;
  }


bool ASC_WritePublicationPayloadPairAtomic(const string primary_path,
                                           const string primary_payload,
                                           const string secondary_path,
                                           const string secondary_payload,
                                           const string &required_tokens[],
                                           const string desired_publication_state,
                                           string &publication_state_out,
                                           string &publication_reason_out)
  {
   publication_state_out = "pending";
   publication_reason_out = "pending publish";
   ulong pair_publish_started_us = GetMicrosecondCount();

   if(StringLen(primary_path) <= 0 || StringLen(secondary_path) <= 0)
     {
      publication_state_out = "failure";
      publication_reason_out = "pair publish paths are unavailable";
      return false;
     }

   if(StringLen(primary_payload) <= 0 || StringLen(secondary_payload) <= 0)
     {
      publication_state_out = "failure";
      publication_reason_out = "pair publish payload is empty";
      return false;
     }

   string primary_parent = ASC_PathParentDirectory(primary_path);
   string secondary_parent = ASC_PathParentDirectory(secondary_path);
   if(StringLen(primary_parent) <= 0 || !ASC_EnsureDirectoryTree(primary_parent))
     {
      publication_state_out = "failure";
      publication_reason_out = StringFormat("operation=ensure_directory target=%s parent=%s reason=primary directory_create_failed",
                                            primary_path,
                                            (StringLen(primary_parent) > 0 ? primary_parent : "unavailable"));
      return false;
     }
   if(StringLen(secondary_parent) <= 0 || !ASC_EnsureDirectoryTree(secondary_parent))
     {
      publication_state_out = "failure";
      publication_reason_out = StringFormat("operation=ensure_directory target=%s parent=%s reason=secondary directory_create_failed",
                                            secondary_path,
                                            (StringLen(secondary_parent) > 0 ? secondary_parent : "unavailable"));
      return false;
     }

   string missing_primary = ASC_FirstMissingRequiredToken(primary_payload, required_tokens);
   string missing_secondary = ASC_FirstMissingRequiredToken(secondary_payload, required_tokens);
   if(StringLen(missing_primary) > 0 || StringLen(missing_secondary) > 0)
     {
      publication_state_out = "failure";
      publication_reason_out = StringFormat("pair publish token contract failed primary_missing=%s secondary_missing=%s",
                                            (StringLen(missing_primary) > 0 ? missing_primary : "none"),
                                            (StringLen(missing_secondary) > 0 ? missing_secondary : "none"));
      return false;
     }

   string primary_existing = "";
   string secondary_existing = "";
   bool primary_had_existing = ASC_ReadTextFile(primary_path, primary_existing) && StringLen(primary_existing) > 0;
   bool secondary_had_existing = ASC_ReadTextFile(secondary_path, secondary_existing) && StringLen(secondary_existing) > 0;

   if(primary_had_existing
      && secondary_had_existing
      && ASC_PublicationPayloadMateriallyEqual(primary_existing, primary_payload)
      && ASC_PublicationPayloadMateriallyEqual(secondary_existing, secondary_payload))
     {
      publication_state_out = desired_publication_state;
      publication_reason_out = StringFormat("operation=skip_pair_publish primary=%s secondary=%s elapsed_ms=%d reason=no_material_change", primary_path, secondary_path, (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000));
      return true;
     }

   string primary_temp = primary_path + ".tmp";
   string secondary_temp = secondary_path + ".tmp";

   if(!ASC_WriteTextFile(primary_temp, primary_payload))
     {
      int temp_error = GetLastError();
      FileDelete(primary_temp, FILE_COMMON);
      publication_state_out = (primary_had_existing && secondary_had_existing) ? "continuity" : "failure";
      publication_reason_out = StringFormat("operation=pair_write_temp target=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=primary temp write failed",
                                            primary_path,
                                            temp_error,
                                            (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000),
                                            (primary_had_existing && secondary_had_existing) ? "yes" : "no");
      return (publication_state_out == "continuity");
     }

   if(!ASC_WriteTextFile(secondary_temp, secondary_payload))
     {
      int temp_error = GetLastError();
      FileDelete(primary_temp, FILE_COMMON);
      FileDelete(secondary_temp, FILE_COMMON);
      publication_state_out = (primary_had_existing && secondary_had_existing) ? "continuity" : "failure";
      publication_reason_out = StringFormat("operation=pair_write_temp target=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=secondary temp write failed",
                                            secondary_path,
                                            temp_error,
                                            (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000),
                                            (primary_had_existing && secondary_had_existing) ? "yes" : "no");
      return (publication_state_out == "continuity");
     }

   string primary_token_contract_reason = "";
   if(!ASC_ReadAndCheckPayloadTokenContractAgainstExpected(primary_temp, primary_payload, required_tokens, primary_token_contract_reason))
     {
      FileDelete(primary_temp, FILE_COMMON);
      FileDelete(secondary_temp, FILE_COMMON);
      publication_state_out = (primary_had_existing && secondary_had_existing) ? "continuity" : "failure";
      publication_reason_out = StringFormat("operation=pair_readback_token_contract target=%s elapsed_ms=%d retained_last_good=%s reason=%s",
                                            primary_path,
                                            (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000),
                                            (primary_had_existing && secondary_had_existing) ? "yes" : "no",
                                            primary_token_contract_reason);
      return (publication_state_out == "continuity");
     }

   string secondary_token_contract_reason = "";
   if(!ASC_ReadAndCheckPayloadTokenContractAgainstExpected(secondary_temp, secondary_payload, required_tokens, secondary_token_contract_reason))
     {
      FileDelete(primary_temp, FILE_COMMON);
      FileDelete(secondary_temp, FILE_COMMON);
      publication_state_out = (primary_had_existing && secondary_had_existing) ? "continuity" : "failure";
      publication_reason_out = StringFormat("operation=pair_readback_token_contract target=%s elapsed_ms=%d retained_last_good=%s reason=%s",
                                            secondary_path,
                                            (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000),
                                            (primary_had_existing && secondary_had_existing) ? "yes" : "no",
                                            secondary_token_contract_reason);
      return (publication_state_out == "continuity");
     }

   ResetLastError();
   if(!FileMove(primary_temp, FILE_COMMON, primary_path, FILE_COMMON | FILE_REWRITE))
     {
      int promote_error = GetLastError();
      FileDelete(primary_temp, FILE_COMMON);
      FileDelete(secondary_temp, FILE_COMMON);
      publication_state_out = (primary_had_existing && secondary_had_existing) ? "continuity" : "failure";
      publication_reason_out = StringFormat("operation=pair_promote target=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=primary promote failed",
                                            primary_path,
                                            promote_error,
                                            (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000),
                                            (primary_had_existing && secondary_had_existing) ? "yes" : "no");
      return (publication_state_out == "continuity");
     }

   ResetLastError();
   if(!FileMove(secondary_temp, FILE_COMMON, secondary_path, FILE_COMMON | FILE_REWRITE))
     {
      int promote_error = GetLastError();
      string rollback_reason = "restored_last_good";
      if(primary_had_existing)
        {
         if(!ASC_WriteTextFile(primary_path, primary_existing))
            rollback_reason = "primary rollback failed";
        }
      else
        {
         if(!FileDelete(primary_path, FILE_COMMON))
            rollback_reason = "primary delete rollback failed";
        }

      FileDelete(secondary_temp, FILE_COMMON);
      publication_state_out = (primary_had_existing && secondary_had_existing) ? "continuity" : "failure";
      publication_reason_out = StringFormat("operation=pair_promote target=%s error_code=%d elapsed_ms=%d retained_last_good=%s reason=secondary promote failed (%s)",
                                            secondary_path,
                                            promote_error,
                                            (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000),
                                            (primary_had_existing && secondary_had_existing) ? "yes" : "no",
                                            rollback_reason);
      return (publication_state_out == "continuity");
     }

   publication_state_out = desired_publication_state;
   publication_reason_out = StringFormat("operation=pair_promote primary=%s secondary=%s error_code=0 elapsed_ms=%d retained_last_good=no reason=pair publish readback_token_contract_satisfied and promoted",
                                         primary_path,
                                         secondary_path,
                                         (int)((GetMicrosecondCount() - pair_publish_started_us) / 1000));
   return true;
  }


string ASC_TextExtractLabeledLineValue(const string text_raw,const string label)
  {
   if(StringLen(label) <= 0 || StringLen(text_raw) <= 0)
      return "";

   string text = text_raw;
   StringReplace(text, "\r", "");
   int pos = StringFind(text, label);
   if(pos < 0)
      return "";

   int start = pos + (int)StringLen(label);
   int n = (int)StringLen(text);
   while(start < n)
     {
      ushort ch = (ushort)StringGetCharacter(text, start);
      if(ch != 32 && ch != 9)
         break;
      start++;
     }

   int stop = StringFind(text, "\n", start);
   if(stop < 0)
      stop = n;
   return StringSubstr(text, start, stop - start);
  }

string ASC_PublicationPayloadId(const string text)
  {
   return ASC_TextExtractLabeledLineValue(text, "Publication Id:");
  }

bool ASC_VerifyPublicationPayloadPairReadback(const string primary_path,
                                              const string expected_primary_payload,
                                              const string secondary_path,
                                              const string expected_secondary_payload,
                                              string &verification_reason)
  {
   verification_reason = "pending";

   string primary_readback = "";
   if(!ASC_ReadTextFile(primary_path, primary_readback) || StringLen(primary_readback) <= 0)
     {
      verification_reason = "readback_primary_missing path=" + primary_path;
      return false;
     }

   string secondary_readback = "";
   if(!ASC_ReadTextFile(secondary_path, secondary_readback) || StringLen(secondary_readback) <= 0)
     {
      verification_reason = "readback_secondary_missing path=" + secondary_path;
      return false;
     }

   string expected_primary_id = ASC_PublicationPayloadId(expected_primary_payload);
   string expected_secondary_id = ASC_PublicationPayloadId(expected_secondary_payload);
   string primary_readback_id = ASC_PublicationPayloadId(primary_readback);
   string secondary_readback_id = ASC_PublicationPayloadId(secondary_readback);

   if(!ASC_PublicationPayloadExactlyEqual(expected_primary_payload, primary_readback))
     {
      verification_reason = StringFormat("readback_primary_payload_mismatch path=%s expected_id=%s actual_id=%s",
                                         primary_path,
                                         (StringLen(expected_primary_id) > 0 ? expected_primary_id : "unavailable"),
                                         (StringLen(primary_readback_id) > 0 ? primary_readback_id : "unavailable"));
      return false;
     }

   if(!ASC_PublicationPayloadExactlyEqual(expected_secondary_payload, secondary_readback))
     {
      verification_reason = StringFormat("readback_secondary_payload_mismatch path=%s expected_id=%s actual_id=%s",
                                         secondary_path,
                                         (StringLen(expected_secondary_id) > 0 ? expected_secondary_id : "unavailable"),
                                         (StringLen(secondary_readback_id) > 0 ? secondary_readback_id : "unavailable"));
      return false;
     }

   if(StringLen(primary_readback_id) > 0
      && StringLen(secondary_readback_id) > 0
      && primary_readback_id != secondary_readback_id)
     {
      verification_reason = StringFormat("readback_pair_publication_id_mismatch primary_id=%s secondary_id=%s",
                                         primary_readback_id,
                                         secondary_readback_id);
      return false;
     }

   verification_reason = StringFormat("readback_pair_verified publication_id=%s",
                                      (StringLen(primary_readback_id) > 0 ? primary_readback_id : "unavailable"));
   return true;
  }

bool ASC_AppendTextFile(const string path,const string text)
  {
   int handle = FileOpen(path, FILE_READ | FILE_WRITE | FILE_TXT | FILE_COMMON | FILE_UNICODE | FILE_SHARE_READ | FILE_SHARE_WRITE);
   if(handle == INVALID_HANDLE)
      return false;

   FileSeek(handle, 0, SEEK_END);
   FileWriteString(handle, text);
   FileFlush(handle);
   FileClose(handle);
   return true;
  }

#endif
