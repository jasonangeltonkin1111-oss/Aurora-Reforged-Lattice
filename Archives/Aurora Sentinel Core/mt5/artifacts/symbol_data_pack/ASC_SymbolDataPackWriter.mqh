#ifndef __ASC_SYMBOL_DATA_PACK_WRITER_MQH__
#define __ASC_SYMBOL_DATA_PACK_WRITER_MQH__

#include "ASC_SymbolDataPackComposer.mqh"
#include "../ASC_ArtifactTextHelpers.mqh"
#include "../../io/ASC_FileIO.mqh"

// RUN162R writer foundation. The atomic write path is implemented against existing ASC_FileIO helpers.
// RUN190R adds route-aware path helpers only. Family publication callsites remain future work for RUN191R/RUN192R.

string ASC_SymbolDataPackFileToken(const string symbol_raw)
  {
   return ASC_SymbolDataPackSafeFileToken(symbol_raw);
  }


string ASC_SymbolDataPackTrimmedCopy(const string raw_value)
  {
   string value = raw_value;
   StringTrimLeft(value);
   StringTrimRight(value);
   return value;
  }

string ASC_SymbolDataPackProofFieldValue(const string raw_value,const string fallback_value = "not_applicable")
  {
   string value = raw_value;
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0)
      value = fallback_value;
   StringReplace(value, " | ", "/");
   StringReplace(value, " ", "_");
   StringReplace(value, "\t", "_");
   StringReplace(value, "\r", "_");
   StringReplace(value, "\n", "_");
   if(StringLen(value) <= 0)
      return fallback_value;
   return value;
  }

string ASC_SymbolDataPackReconciliationFieldBlock(const string route_text,
                                                  const string bucket_text,
                                                  const string state_text,
                                                  const string expected_count_text,
                                                  const string found_final_count_text,
                                                  const string expected_symbols_text,
                                                  const string unexpected_symbols_text,
                                                  const string archived_count_text,
                                                  const string deleted_count_text,
                                                  const string skipped_count_text,
                                                  const string first_failure_reason_text,
                                                  const string final_path_text,
                                                  const string archive_path_text)
  {
   return "sdp_final_set_reconcile"
          + " reconciliation_route=" + ASC_SymbolDataPackProofFieldValue(route_text, "unknown_route")
          + " reconciliation_bucket=" + ASC_SymbolDataPackProofFieldValue(bucket_text, "not_applicable")
          + " reconciliation_state=" + ASC_SymbolDataPackProofFieldValue(state_text, "unknown")
          + " reconciliation_current_truth_source=membership_snapshot"
          + " reconciliation_expected_count=" + ASC_SymbolDataPackProofFieldValue(expected_count_text, "0")
          + " reconciliation_found_final_count=" + ASC_SymbolDataPackProofFieldValue(found_final_count_text, "not_enumerated")
          + " reconciliation_expected_symbols=" + ASC_SymbolDataPackProofFieldValue(expected_symbols_text, "none")
          + " reconciliation_expected_symbols_summary=" + ASC_SymbolDataPackProofFieldValue(expected_symbols_text, "none")
          + " reconciliation_unexpected_symbols=" + ASC_SymbolDataPackProofFieldValue(unexpected_symbols_text, "none")
          + " reconciliation_unexpected_symbols_summary=" + ASC_SymbolDataPackProofFieldValue(unexpected_symbols_text, "none")
          + " reconciliation_archived_count=" + ASC_SymbolDataPackProofFieldValue(archived_count_text, "0")
          + " reconciliation_deleted_count=" + ASC_SymbolDataPackProofFieldValue(deleted_count_text, "0")
          + " reconciliation_skipped_count=" + ASC_SymbolDataPackProofFieldValue(skipped_count_text, "0")
          + " reconciliation_first_failure_reason=" + ASC_SymbolDataPackProofFieldValue(first_failure_reason_text, "none")
          + " reconciliation_final_path=" + ASC_SymbolDataPackProofFieldValue(final_path_text, "not_applicable")
          + " reconciliation_archive_path=" + ASC_SymbolDataPackProofFieldValue(archive_path_text, "not_applicable");
  }

string ASC_SymbolDataPackTargetFolderForRoute(const string server_root,
                                                   const ASC_SymbolDataPackFamilyRoute route,
                                                   const string bucket)
  {
   if(StringLen(server_root) <= 0)
      return "";

   string folder = server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER);
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_GLOBAL_TOP10_FOLDER);

   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
     {
      string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);
      if(safe_bucket == "ROUTE_REQUIRES_BUCKET")
         return "";
      return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER) + "\\" + safe_bucket;
     }

   return folder;
  }

string ASC_SymbolDataPackTargetFolder(const string server_root)
  {
   return ASC_SymbolDataPackTargetFolderForRoute(server_root, ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION, "");
  }

string ASC_SymbolDataPackTop5FamilyFolder(const string server_root)
  {
   if(StringLen(server_root) <= 0)
      return "";
   return server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER) + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER);
  }

string ASC_SymbolDataPackTargetPathForRoute(const string server_root,
                                            const string symbol,
                                            const ASC_SymbolDataPackFamilyRoute route,
                                            const string bucket)
  {
   string folder = ASC_SymbolDataPackTargetFolderForRoute(server_root, route, bucket);
   if(StringLen(folder) <= 0)
      return "";
   return folder + "\\" + ASC_SymbolDataPackFileToken(symbol) + string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
  }

string ASC_SymbolDataPackTargetPath(const string server_root,const string symbol)
  {
   return ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION, "");
  }


string ASC_SymbolDataPackStagingFolderForRoute(const string server_root,
                                               const ASC_SymbolDataPackFamilyRoute route,
                                               const string bucket)
  {
   if(StringLen(server_root) <= 0)
      return "";

   string folder = server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER) + "\\_staging";
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_GLOBAL_TOP10_FOLDER);

   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
     {
      string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);
      if(safe_bucket == "ROUTE_REQUIRES_BUCKET")
         return "";
      return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER) + "\\" + safe_bucket;
     }

   return "";
  }

string ASC_SymbolDataPackStagingPathForRoute(const string server_root,
                                             const string symbol,
                                             const ASC_SymbolDataPackFamilyRoute route,
                                             const string bucket)
  {
   string folder = ASC_SymbolDataPackStagingFolderForRoute(server_root, route, bucket);
   if(StringLen(folder) <= 0)
      return "";
   return folder + "\\" + ASC_SymbolDataPackFileToken(symbol) + string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
  }

string ASC_SymbolDataPackStagingPath(const string server_root,const string symbol)
  {
   return ASC_SymbolDataPackStagingPathForRoute(server_root, symbol, ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION, "");
  }

string ASC_SymbolDataPackArchiveFolderForRoute(const string server_root,
                                               const ASC_SymbolDataPackFamilyRoute route,
                                               const string bucket)
  {
   if(StringLen(server_root) <= 0)
      return "";

   string folder = server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER) + "\\_archive";
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_GLOBAL_TOP10_FOLDER);

   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
     {
      string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);
      if(safe_bucket == "ROUTE_REQUIRES_BUCKET")
         return "";
      return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER) + "\\" + safe_bucket;
     }

   return "";
  }

string ASC_SymbolDataPackArchivePathForRoute(const string server_root,
                                             const string symbol,
                                             const ASC_SymbolDataPackFamilyRoute route,
                                             const string bucket)
  {
   string folder = ASC_SymbolDataPackArchiveFolderForRoute(server_root, route, bucket);
   if(StringLen(folder) <= 0)
      return "";

   string archive_suffix = string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
   StringReplace(archive_suffix, ".txt", ".previous.txt");
   return folder + "\\" + ASC_SymbolDataPackFileToken(symbol) + archive_suffix;
  }


bool ASC_SymbolDataPackFileNameHasExactChildSuffix(const string file_name)
  {
   if(StringLen(file_name) <= 0)
      return false;
   if(StringFind(file_name, "\\") >= 0 || StringFind(file_name, "/") >= 0)
      return false;
   string suffix = string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
   int suffix_len = StringLen(suffix);
   int file_len = StringLen(file_name);
   if(suffix_len <= 0 || file_len <= suffix_len)
      return false;
   return (StringSubstr(file_name, file_len - suffix_len, suffix_len) == suffix);
  }

string ASC_SymbolDataPackExpectedSymbolListForProof(const string &expected_symbols[])
  {
   string result = "";
   int emitted = 0;
   for(int i = 0; i < ArraySize(expected_symbols); i++)
     {
      string symbol = ASC_SymbolDataPackTrimmedCopy(expected_symbols[i]);
      if(StringLen(symbol) <= 0)
         continue;
      if(emitted > 0)
         result += ",";
      result += ASC_SymbolDataPackFileToken(symbol);
      emitted++;
     }
   if(StringLen(result) <= 0)
      return "none";
   return result;
  }

bool ASC_SymbolDataPackFinalFileNameExpected(const string file_name,const string &expected_symbols[])
  {
   if(StringLen(file_name) <= 0)
      return false;
   if(!ASC_SymbolDataPackFileNameHasExactChildSuffix(file_name))
      return false;
   string suffix = string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
   for(int i = 0; i < ArraySize(expected_symbols); i++)
     {
      string symbol = ASC_SymbolDataPackTrimmedCopy(expected_symbols[i]);
      if(StringLen(symbol) <= 0)
         continue;
      string expected = ASC_SymbolDataPackFileToken(symbol) + suffix;
      if(file_name == expected)
         return true;
     }
   return false;
  }

bool ASC_SymbolDataPackArchiveAndDeleteUnexpectedFinalChild(const string server_root,
                                                           const ASC_SymbolDataPackFamilyRoute route,
                                                           const string bucket,
                                                           const string found_name,
                                                           int &archived_count,
                                                           int &deleted_count,
                                                           string &reason_out)
  {
   reason_out = "pending";
   string dir = ASC_SymbolDataPackTargetFolderForRoute(server_root, route, bucket);
   if(StringLen(dir) <= 0 || StringLen(found_name) <= 0)
     {
      reason_out = "sdp_final_reconcile_path_guard_failed";
      return false;
     }

   if(!ASC_SymbolDataPackFileNameHasExactChildSuffix(found_name))
     {
      reason_out = "sdp_final_reconcile_skipped_non_child_file name=" + found_name;
      return true;
     }

   string suffix = string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
   int suffix_pos = StringLen(found_name) - StringLen(suffix);
   string symbol_token = StringSubstr(found_name, 0, suffix_pos);
   string child_path = dir + "\\" + found_name;
   string archive_path = ASC_SymbolDataPackArchivePathForRoute(server_root, symbol_token, route, bucket);
   string archive_state = "pending";
   string archive_reason = "pending";
   string archive_required[];
   ArrayResize(archive_required, 0);

   if(StringLen(archive_path) > 0 && ASC_CopyTextFileAtomic(child_path, archive_path, archive_required, archive_state, archive_reason))
      archived_count++;
   else
     {
      reason_out = "sdp_final_reconcile_archive_failed child=" + child_path + " archive=" + archive_path + " state=" + archive_state + " reason=" + archive_reason;
      return false;
     }

   ResetLastError();
   if(FileDelete(child_path, FILE_COMMON))
     {
      deleted_count++;
      reason_out = "sdp_final_reconcile_archived_and_deleted child=" + child_path + " archive=" + archive_path;
      return true;
     }

   int delete_error = GetLastError();
   reason_out = "sdp_final_reconcile_delete_failed child=" + child_path + " archive=" + archive_path + " error=" + IntegerToString(delete_error);
   return false;
  }

bool ASC_SymbolDataPackPruneUnexpectedFinalChildrenForRoute(const string server_root,
                                                            const ASC_SymbolDataPackFamilyRoute route,
                                                            const string bucket,
                                                            const string &expected_symbols[],
                                                            int &unexpected_count,
                                                            int &archived_count,
                                                            int &deleted_count,
                                                            int &failed_count,
                                                            string &reason_out)
  {
   unexpected_count = 0;
   archived_count = 0;
   deleted_count = 0;
   failed_count = 0;
   reason_out = "pending";

   string route_text = ASC_SymbolDataPackFamilyRouteText(route);
   string bucket_text = (StringLen(bucket) > 0 ? bucket : "not_applicable");
   string expected_list = ASC_SymbolDataPackExpectedSymbolListForProof(expected_symbols);

   string dir = ASC_SymbolDataPackTargetFolderForRoute(server_root, route, bucket);
   if(StringLen(dir) <= 0)
     {
      reason_out = "sdp_final_reconcile_directory_unavailable reconciliation_route=" + route_text + " reconciliation_bucket=" + bucket_text;
      return false;
     }

   if(ArraySize(expected_symbols) <= 0)
     {
      reason_out = ASC_SymbolDataPackReconciliationFieldBlock(route_text,
                                                                 bucket_text,
                                                                 "deferred_no_source_owned_expected_set",
                                                                 "0",
                                                                 "not_enumerated",
                                                                 "none",
                                                                 "not_enumerated",
                                                                 "0",
                                                                 "0",
                                                                 "0",
                                                                 "no_committed_membership_no_delete",
                                                                 dir,
                                                                 ASC_SymbolDataPackArchiveFolderForRoute(server_root, route, bucket));
      return true;
     }

   string found_name = "";
   long handle = FileFindFirst(dir + "\\*.txt", found_name, FILE_COMMON);
   if(handle == INVALID_HANDLE)
     {
      reason_out = ASC_SymbolDataPackReconciliationFieldBlock(route_text,
                                                                 bucket_text,
                                                                 "no_existing_child_files",
                                                                 IntegerToString(ArraySize(expected_symbols)),
                                                                 "0",
                                                                 expected_list,
                                                                 "none",
                                                                 "0",
                                                                 "0",
                                                                 "0",
                                                                 "none",
                                                                 dir,
                                                                 ASC_SymbolDataPackArchiveFolderForRoute(server_root, route, bucket));
      return true;
     }

   string detail = "";
   string unexpected_symbols = "";
   int found_final_count = 0;
   int skipped_count = 0;
   do
     {
      if(StringLen(found_name) <= 0
         || found_name == string(ASC_SYMBOL_DATA_PACK_TARGET_FAMILY_MANIFEST)
         || found_name == string(ASC_SYMBOL_DATA_PACK_TARGET_BUCKET_MANIFEST)
         || StringFind(found_name, ".tmp") >= 0)
        {
         skipped_count++;
         continue;
        }

      if(!ASC_SymbolDataPackFileNameHasExactChildSuffix(found_name))
        {
         skipped_count++;
         continue;
        }

      found_final_count++;
      if(ASC_SymbolDataPackFinalFileNameExpected(found_name, expected_symbols))
        {
         skipped_count++;
         continue;
        }

      unexpected_count++;
      string unexpected_token = StringSubstr(found_name, 0, StringLen(found_name) - StringLen(string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX)));
      if(StringLen(unexpected_symbols) > 0) unexpected_symbols += ",";
      unexpected_symbols += unexpected_token;
      string child_reason = "";
      if(ASC_SymbolDataPackArchiveAndDeleteUnexpectedFinalChild(server_root, route, bucket, found_name, archived_count, deleted_count, child_reason))
        {
         if(StringLen(detail) > 0) detail += ";";
         detail += child_reason;
        }
      else
        {
         failed_count++;
         if(StringLen(detail) > 0) detail += ";";
         detail += child_reason;
        }
     }
   while(FileFindNext(handle, found_name));
   FileFindClose(handle);

   if(StringLen(unexpected_symbols) <= 0)
      unexpected_symbols = "none";
   reason_out = ASC_SymbolDataPackReconciliationFieldBlock(route_text,
                                                              bucket_text,
                                                              (failed_count == 0 ? "completed_source_bounded" : "completed_with_failures"),
                                                              IntegerToString(ArraySize(expected_symbols)),
                                                              IntegerToString(found_final_count),
                                                              expected_list,
                                                              unexpected_symbols,
                                                              IntegerToString(archived_count),
                                                              IntegerToString(deleted_count),
                                                              IntegerToString(skipped_count),
                                                              (failed_count == 0 ? "none" : "archive_or_delete_failed"),
                                                              dir,
                                                              ASC_SymbolDataPackArchiveFolderForRoute(server_root, route, bucket));
   if(StringLen(detail) > 0)
      reason_out += " | " + detail;
   return (failed_count == 0);
  }

bool ASC_SymbolDataPackTryArchivePreviousFinalForRoute(const string server_root,
                                                       const string symbol,
                                                       const string payload,
                                                       const ASC_SymbolDataPackFamilyRoute route,
                                                       const string bucket,
                                                       const string &required_tokens[],
                                                       string &archive_state_out,
                                                       string &archive_reason_out)
  {
   archive_state_out = "archive_not_attempted";
   archive_reason_out = "archive_not_attempted";

   string target_path = ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, route, bucket);
   string staging_path = ASC_SymbolDataPackStagingPathForRoute(server_root, symbol, route, bucket);
   string archive_path = ASC_SymbolDataPackArchivePathForRoute(server_root, symbol, route, bucket);
   if(StringLen(target_path) <= 0 || StringLen(archive_path) <= 0)
     {
      archive_state_out = "archive_write_failed_nonblocking";
      archive_reason_out = "archive_path_guard_failed target_or_archive_path_empty route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   if(archive_path == target_path || (StringLen(staging_path) > 0 && archive_path == staging_path))
     {
      archive_state_out = "archive_write_failed_nonblocking";
      archive_reason_out = "archive_path_guard_failed archive_path_must_not_equal_final_or_staging archive_path=" + archive_path;
      return false;
     }

   string previous_payload = "";
   if(!ASC_ReadTextFile(target_path, previous_payload) || StringLen(previous_payload) <= 0)
     {
      archive_state_out = "archive_no_previous_final";
      archive_reason_out = "archive skipped: no previous final file route=" + ASC_SymbolDataPackFamilyRouteText(route) + " final_path=" + target_path + " archive_path=" + archive_path;
      return true;
     }

   if(ASC_PublicationPayloadMateriallyEqual(previous_payload, payload))
     {
      archive_state_out = "archive_skipped_no_material_change";
      archive_reason_out = "archive skipped: no material change route=" + ASC_SymbolDataPackFamilyRouteText(route) + " final_path=" + target_path + " archive_path=" + archive_path;
      return true;
     }

   string write_state = "pending";
   string write_reason = "pending";
   bool archive_ok = ASC_WritePublicationPayloadAtomic(archive_path,
                                                       previous_payload,
                                                       required_tokens,
                                                       "archive_previous_final_saved",
                                                       write_state,
                                                       write_reason);
   if(archive_ok)
     {
      archive_state_out = "archive_previous_final_saved";
      archive_reason_out = "archive previous final saved route=" + ASC_SymbolDataPackFamilyRouteText(route)
                           + " archive_path=" + archive_path
                           + " archive_write_state=" + write_state
                           + " archive_write_reason=" + write_reason;
      return true;
     }

   archive_state_out = "archive_write_failed_nonblocking";
   archive_reason_out = "archive previous final write failed nonblocking route=" + ASC_SymbolDataPackFamilyRouteText(route)
                        + " archive_path=" + archive_path
                        + " archive_write_state=" + write_state
                        + " archive_write_reason=" + write_reason;
   return false;
  }

string ASC_SymbolDataPackTempPathForRoute(const string server_root,
                                          const string symbol,
                                          const ASC_SymbolDataPackFamilyRoute route,
                                          const string bucket)
  {
   string target_path = ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, route, bucket);
   if(StringLen(target_path) <= 0)
      return "";
   return target_path + ".tmp";
  }

string ASC_SymbolDataPackTempPath(const string server_root,const string symbol)
  {
   return ASC_SymbolDataPackTempPathForRoute(server_root, symbol, ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION, "");
  }

string ASC_SymbolDataPackLastGoodContinuityPathForRoute(const string server_root,
                                                        const string symbol,
                                                        const ASC_SymbolDataPackFamilyRoute route,
                                                        const string bucket)
  {
   // Contract: no extra operator-facing last-good file. Existing final file is retained as continuity baseline.
   return ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, route, bucket);
  }

string ASC_SymbolDataPackLastGoodContinuityPath(const string server_root,const string symbol)
  {
   return ASC_SymbolDataPackLastGoodContinuityPathForRoute(server_root, symbol, ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION, "");
  }

string ASC_SymbolDataPackGlobalTop10FamilyManifestPath(const string server_root)
  {
   string folder = ASC_SymbolDataPackTargetFolderForRoute(server_root, ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10, "");
   if(StringLen(folder) <= 0)
      return "";
   return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_FAMILY_MANIFEST);
  }

string ASC_SymbolDataPackTop5FamilyManifestPath(const string server_root)
  {
   string folder = ASC_SymbolDataPackTop5FamilyFolder(server_root);
   if(StringLen(folder) <= 0)
      return "";
   return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_FAMILY_MANIFEST);
  }

string ASC_SymbolDataPackTop5BucketManifestPath(const string server_root,const string bucket)
  {
   string folder = ASC_SymbolDataPackTargetFolderForRoute(server_root, ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET, bucket);
   if(StringLen(folder) <= 0)
      return "";
   return folder + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_BUCKET_MANIFEST);
  }

bool ASC_SymbolDataPackShadowModeEnabled()
  {
   return ASC_SYMBOL_DATA_PACK_SHADOW_MODE_DEFAULT;
  }

bool ASC_SymbolDataPackRuntimeActivationEnabled()
  {
   return ASC_SYMBOL_DATA_PACK_FULL_RUNTIME_ACTIVATION;
  }

void ASC_SymbolDataPackRequiredTokens(string &required_tokens[])
  {
   ArrayResize(required_tokens, 196);
   required_tokens[0] = "# Symbol Data Pack Lite";
   required_tokens[1] = "Publication / Atomic Status";
   required_tokens[2] = "Family: " + string(ASC_SYMBOL_DATA_PACK_FAMILY);
   required_tokens[3] = "Safety Boundary";
   required_tokens[4] = "One File Rule: " + string(ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL);
   required_tokens[5] = "History Depth Contract";
   required_tokens[6] = "Tick / Spread Window Contract";
   required_tokens[7] = "Section Freshness Metadata Plan";
   required_tokens[8] = "Quote Snapshot Factual Section";
   required_tokens[9] = "Tick Activity Statistics Factual Section";
   required_tokens[10] = "Spread Statistics Factual Section";
   required_tokens[11] = "OHLC Timeframe Contract";
   required_tokens[12] = "Multi-Timeframe OHLC Summary";
   required_tokens[13] = "Recent Closed Candle Sequences";
   required_tokens[14] = "Daily / Weekly / Monthly High-Low Facts";
   required_tokens[15] = "Due-Only Recalculation By Timeframe";
   required_tokens[16] = "ATR / Volatility Facts";
   required_tokens[17] = "Volatility / Range Factual Section";
   required_tokens[18] = "Range-Position Factual Section";
   required_tokens[19] = "Pullback-Depth Factual Section";
   required_tokens[20] = "Spread-To-Volatility Burden Factual Section";
   required_tokens[21] = "Due-Only Recalculation For ATR / Range / Pullback";
   required_tokens[22] = "VWAP Formula / Source Method Decision";
   required_tokens[23] = "Session / Current-Day VWAP Facts";
   required_tokens[24] = "Daily / Previous-Day VWAP Facts";
   required_tokens[25] = "Anchored VWAP Facts";
   required_tokens[26] = "Volume-Source Quality Facts";
   required_tokens[27] = "VWAP Hydration / Retry / Last-Good Contract";
   required_tokens[28] = "Due-Only Recalculation For VWAP";
   required_tokens[29] = "Indicator Source Method Decision";
   required_tokens[30] = "Moving Average Numeric Facts";
   required_tokens[31] = "RSI Numeric Facts";
   required_tokens[32] = "MACD Numeric Facts";
   required_tokens[33] = "Bollinger Band Numeric Facts";
   required_tokens[34] = "ADX / DI Numeric Facts";
   required_tokens[35] = "Standard Deviation / Z-Score Numeric Facts";
   required_tokens[36] = "Indicator Hydration / Retry / Last-Good Contract";
   required_tokens[37] = "Due-Only Recalculation For Indicators";
   required_tokens[38] = "Symbol Data Pack Lite Health Map";
   required_tokens[39] = "Canonical Health State Vocabulary";
   required_tokens[40] = "Health Family Implementation Map";
   required_tokens[41] = "Section Completeness Map";
   required_tokens[42] = "Section Freshness Map";
   required_tokens[43] = "Retry / Hydration Health Map";
   required_tokens[44] = "Last-Good Health Map";
   required_tokens[45] = "Publication Health Summary";
   required_tokens[46] = "hard_absence_requires_bounded_proof_never_first_failure";
   required_tokens[47] = "one_health_section_inside_one_symbol_data_pack_file";
   required_tokens[48] = "RUN170 Live Proof Contract";
   required_tokens[49] = "RUN170 Capture Surface Checklist";
   required_tokens[50] = "RUN170 Safe Source Repair Rule";
   required_tokens[51] = "source_identity_must_match_RUN169R_closeout_or_HOLD_FAIL_by_mismatch";
   required_tokens[52] = "live_proof_research_and_safe_source_repair_only";
   required_tokens[53] = "no_strategy_execution_rank_order_formula_marketboard_top5_globaltop10_fileio_heartbeat_broad_hud_trade_history_or_full_universe_activation";
   required_tokens[54] = "RUN169 Closeout Boundary";
   required_tokens[55] = "RUN170 Source Identity Rule";
   required_tokens[56] = "RUN171 Bounded Runtime Activation";
   required_tokens[57] = "activation_mode=";
   required_tokens[58] = "activation_symbol_source=";
   required_tokens[59] = "activation_symbol=";
   required_tokens[60] = "runtime_callsite=ASC_ServiceSymbolDataPackLiteRuntimeActivation";
   required_tokens[61] = "runtime_budget_rule=one_symbol_due_only_no_full_universe_activation";
   required_tokens[62] = "RUN172 Triple-Check Seed";
   required_tokens[63] = "RUN173 Live Proof Seed";
   required_tokens[64] = "topology_contract=";
   required_tokens[65] = "flat_transition_status=";
   required_tokens[66] = "output_globaltop10_target_final_path=";
   required_tokens[67] = "output_top5perbucket_target_pattern=";
   required_tokens[68] = "Asset / Classification Identity";
   required_tokens[69] = "asset_class=";
   required_tokens[70] = "bucket=";
   required_tokens[71] = "symbol_family=";
   required_tokens[72] = "classification_source=";
   required_tokens[73] = "classification_confidence=";
   required_tokens[74] = "classification_missing_reason=";
   required_tokens[75] = "classification_boundary=route_fields_do_not_define_asset_identity";
   required_tokens[76] = "classification_inference_policy=no_suffix_or_folder_inference";
   required_tokens[77] = "Duplicate / Parallel Route Context";
   required_tokens[78] = "canonical_symbol_id=";
   required_tokens[79] = "duplicate_route_instance=";
   required_tokens[80] = "route_context_role=";
   required_tokens[81] = "route_context_authority=route_context_only_not_trade_or_selection_authority";
   required_tokens[82] = "parallel_route_family=";
   required_tokens[83] = "canonical_scope_for_siam_review=";
   required_tokens[84] = "duplicate_resolution_owner=";
   required_tokens[85] = "duplicate_inference_policy=no_filesystem_stale_scan_no_suffix_guessing";
   required_tokens[86] = "duplicate_missing_reason=";
   required_tokens[87] = "duplicate_context_boundary=data_review_metadata_only_no_signal_no_trade_no_rank_authority";
   required_tokens[88] = "DATA PURITY SUMMARY";
   required_tokens[89] = "purity_summary_version=RUN220R_v1";
   required_tokens[90] = "source_run=";
   required_tokens[91] = "build=";
   required_tokens[92] = "route_family=";
   required_tokens[93] = "route_bucket_name=";
   required_tokens[94] = "classification_source=";
   required_tokens[95] = "tick_window_60s_valid=";
   required_tokens[96] = "tick_window_300s_valid=";
   required_tokens[97] = "spread_window_60s_valid=";
   required_tokens[98] = "spread_window_300s_valid=";
   required_tokens[99] = "copy_ticks_cap_hit=";
   required_tokens[100] = "copy_ticks_truncation_state=";
   required_tokens[101] = "last_price_available=";
   required_tokens[102] = "last_price_status=";
   required_tokens[103] = "absence_state=";
   required_tokens[104] = "absence_reason=";
   required_tokens[105] = "ohlc_summary_ready=";
   required_tokens[106] = "recent_candle_sequences_ready=";
   required_tokens[107] = "quote_snapshot_utc=";
   required_tokens[108] = "tick_stats_snapshot_utc=";
   required_tokens[109] = "spread_stats_snapshot_utc=";
   required_tokens[110] = "ohlc_snapshot_utc=";
   required_tokens[111] = "recent_sequence_snapshot_utc=";
   required_tokens[112] = "specs_snapshot_utc=";
   required_tokens[113] = "session_snapshot_utc=";
   required_tokens[114] = "section_time_skew_seconds=";
   required_tokens[115] = "section_coherence_status=";
   required_tokens[116] = "section_coherence_reason=";
   required_tokens[117] = "section_coherence_policy=source_owned_timestamps_only_no_file_time_inference";
   required_tokens[118] = "symbol_specs_hydrated=";
   required_tokens[119] = "symbol_specs_source=";
   required_tokens[120] = "missing_specs=";
   required_tokens[121] = "specs_hydration_reason=";
   required_tokens[122] = "session_facts_hydrated=";
   required_tokens[123] = "session_facts_source=";
   required_tokens[124] = "missing_session_facts=";
   required_tokens[125] = "session_hydration_reason=";
   required_tokens[126] = "atr_facts_hydrated=";
   required_tokens[127] = "vwap_facts_hydrated=";
   required_tokens[128] = "indicator_facts_hydrated=";
   required_tokens[129] = "critical_purity_errors_count=";
   required_tokens[130] = "critical_purity_errors=";
   required_tokens[131] = "ready_for_siam_review=";
   required_tokens[132] = "ready_for_siam_reason=";
   required_tokens[133] = "signal_permission=false";
   required_tokens[134] = "trade_permission=false";
   required_tokens[135] = "execution_permission=false";
   required_tokens[136] = "risk_permission=false";
   required_tokens[137] = "prop_firm_permission=false";
   required_tokens[138] = "summary_boundary=data_review_only_not_signal_not_trade";
   required_tokens[139] = "canonical_scope_for_siam_review=";
   required_tokens[140] = "canonical_symbol_id=";
   required_tokens[141] = "asset_class=";
   required_tokens[142] = "bucket=";
   required_tokens[143] = "ready_for_siam_review=";
   required_tokens[144] = "summary_boundary=data_review_only_not_signal_not_trade";
   required_tokens[145] = "DEBUG_HEADER_BEGIN";
   required_tokens[146] = "DEBUG_HEADER_END";
   required_tokens[147] = "SIAM_DATA_BODY_BEGIN";
   required_tokens[148] = "SIAM_DATA_BODY_END";
   required_tokens[149] = "DATA_PURITY_SUMMARY_BEGIN";
   required_tokens[150] = "DATA_PURITY_SUMMARY_END";
   required_tokens[151] = "PROOF_AND_RECONCILIATION_BEGIN";
   required_tokens[152] = "PROOF_AND_RECONCILIATION_END";
   required_tokens[153] = "CLEANLINESS_BOUNDARY=truth_readability_only_no_field_deletion_no_signal_no_trade";
   required_tokens[154] = "crypto_health_applicable=";
   required_tokens[155] = "crypto_health_state=";
   required_tokens[156] = "crypto_health_reason=";
   required_tokens[157] = "crypto_health_inputs=";
   required_tokens[158] = "crypto_quote_age_state=";
   required_tokens[159] = "crypto_tick_activity_state=";
   required_tokens[160] = "crypto_spread_state=";
   required_tokens[161] = "crypto_last_price_state=";
   required_tokens[162] = "crypto_section_coherence_state=";
   required_tokens[163] = "crypto_missing_health_inputs=";
   required_tokens[164] = "crypto_copyticks_cap_warning=";
   required_tokens[165] = "crypto_health_boundary=data_quality_warning_only_not_signal_not_trade";
   required_tokens[166] = "SYMBOL_L3_L4_OWNER_MAP_BEGIN";
   required_tokens[167] = "symbol_l3_l4_owner_map_version=RUN247_v1";
   required_tokens[168] = "per_symbol_l3_l4_projection_available=";
   required_tokens[169] = "writer_calculates_l3_l4=false";
   required_tokens[170] = "SYMBOL_L3_L4_OWNER_MAP_END";
   required_tokens[171] = "SYMBOL_L3_L4_CONTEXT_BEGIN";
   required_tokens[172] = "symbol_l3_l4_context_version=RUN247_v1";
   required_tokens[173] = "symbol_l4_member=";
   required_tokens[174] = "symbol_l3_l4_blocks_trade=true";
   required_tokens[175] = "symbol_l3_l4_blocks_diagnostic_review=false";
   required_tokens[176] = "symbol_l3_l4_next_step=";
   required_tokens[177] = "SYMBOL_L3_L4_CONTEXT_END";
   required_tokens[178] = "SYMBOL_L3_L4_RUNTIME_JOIN_MAP_BEGIN";
   required_tokens[179] = "symbol_l3_l4_runtime_join_map_version=RUN247_v1";
   required_tokens[180] = "l3_row_match_status=";
   required_tokens[181] = "l4_row_match_status=";
   required_tokens[182] = "SIAM_SYMBOL_REVIEW_READINESS_BEGIN";
   required_tokens[183] = "siam_symbol_review_readiness_version=RUN247_v1";
   required_tokens[184] = "ready_for_siam_trade=no";
   required_tokens[185] = "SIAM_SYMBOL_REVIEW_READINESS_END";
   required_tokens[186] = "SIAM_SYMBOL_REVIEW_COMPLETENESS_BEGIN";
   required_tokens[187] = "siam_symbol_review_completeness_version=RUN254_v1";
   required_tokens[188] = "recommended_siam_action=";
   required_tokens[189] = "trade_ready=false";
   required_tokens[190] = "SIAM_SYMBOL_REVIEW_COMPLETENESS_END";
   required_tokens[191] = "SIAM_DATA_PURITY_SEMANTICS_BEGIN";
   required_tokens[192] = "allowed_section_coherence_values=clean,limited,stale,missing,not_applicable,blocked,unknown";
   required_tokens[193] = "queue_transport_not_file_proof=true";
   required_tokens[194] = "main_dossier_is_canonical=true";
   required_tokens[195] = "SIAM_DATA_PURITY_SEMANTICS_END";
  }

bool ASC_SymbolDataPackPayloadValid(const string payload,string &reason_out)
  {
   reason_out = "payload_pending_validation";
   if(StringLen(payload) <= 0)
     {
      reason_out = "payload_empty";
      return false;
     }

   string required_tokens[];
   ASC_SymbolDataPackRequiredTokens(required_tokens);
   string missing_token = ASC_FirstMissingRequiredToken(payload, required_tokens);
   if(StringLen(missing_token) > 0)
     {
      reason_out = "missing_required_token=" + missing_token;
      return false;
     }

   reason_out = "payload_contract_valid";
   return true;
  }

bool ASC_SymbolDataPackWouldSkipNoChangeForRoute(const string server_root,
                                                  const string symbol,
                                                  const string payload,
                                                  const ASC_SymbolDataPackFamilyRoute route,
                                                  const string bucket,
                                                  string &reason_out)
  {
   reason_out = "no_change_check_pending";
   string path = ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, route, bucket);
   if(StringLen(path) <= 0)
     {
      reason_out = "path_guard_failed_target_empty route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   string existing_payload = "";
   if(!ASC_ReadTextFile(path, existing_payload))
     {
      reason_out = "no_existing_payload_for_compare route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   if(ASC_PublicationPayloadMateriallyEqual(existing_payload, payload))
     {
      reason_out = "operation=skip_write reason=no_material_change route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return true;
     }

   reason_out = "material_change_detected route=" + ASC_SymbolDataPackFamilyRouteText(route);
   return false;
  }

bool ASC_SymbolDataPackWouldSkipNoChange(const string server_root,
                                          const string symbol,
                                          const string payload,
                                          string &reason_out)
  {
   return ASC_SymbolDataPackWouldSkipNoChangeForRoute(server_root,
                                                      symbol,
                                                      payload,
                                                      ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION,
                                                      "",
                                                      reason_out);
  }

bool ASC_SymbolDataPackTryComposeDryRunForRoute(const string server_root,
                                                const string symbol,
                                                const ASC_SymbolDataPackFamilyRoute route,
                                                const string bucket,
                                                string &payload_out,
                                                string &reason_out,
                                                const string bucket_display="")
  {
   payload_out = "";
   reason_out = "pending";

   string safe_symbol = symbol;
   StringTrimLeft(safe_symbol);
   StringTrimRight(safe_symbol);
   if(StringLen(safe_symbol) <= 0)
     {
      reason_out = "path_guard_failed_symbol_empty route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET
      && ASC_SymbolDataPackSafeBucketToken(bucket) == "ROUTE_REQUIRES_BUCKET")
     {
      reason_out = "path_guard_failed_bucket_empty route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   payload_out = ASC_SymbolDataPackComposeSkeleton(safe_symbol, server_root, route, bucket, bucket_display);
   string sdp_required_tokens[];
   ASC_SymbolDataPackRequiredTokens(sdp_required_tokens);
   payload_out += ASC_PublicationResilienceBlock(payload_out,
                                                 sdp_required_tokens,
                                                 "symbol_data_pack_lite",
                                                 "ASC_SymbolDataPackWriter",
                                                 "missing ATR/session/identity/route/L3/L4 facts degrade trade-readiness but must not suppress SDP file output",
                                                 true);
   string validation_reason = "";
   if(!ASC_SymbolDataPackPayloadValid(payload_out, validation_reason))
     {
      reason_out = "dry_run_payload_contract_failed route=" + ASC_SymbolDataPackFamilyRouteText(route) + " " + validation_reason;
      return false;
     }

   reason_out = "dry_run_compose_only_no_file_write payload_contract_valid route=" + ASC_SymbolDataPackFamilyRouteText(route);
   return true;
  }

bool ASC_SymbolDataPackTryComposeDryRunForRouteWithRuntimeState(const string server_root,
                                                              const string symbol,
                                                              const ASC_SymbolDataPackFamilyRoute route,
                                                              const string bucket,
                                                              const ASC_RuntimeState &state,
                                                              string &payload_out,
                                                              string &reason_out,
                                                              const string bucket_display="")
  {
   ASC_SymbolDataPackRun247PrepareRuntimeOverrides(symbol, route, state);
   bool ok = ASC_SymbolDataPackTryComposeDryRunForRoute(server_root,
                                                        symbol,
                                                        route,
                                                        bucket,
                                                        payload_out,
                                                        reason_out,
                                                        bucket_display);
   ASC_SymbolDataPackRun247ClearRuntimeOverrides();
   if(ok)
      reason_out = reason_out + " runtime_join_override=RUN247_source_owned_runtime_rows";
   return ok;
  }

bool ASC_SymbolDataPackTryComposeDryRun(const string server_root,
                                        const string symbol,
                                        string &payload_out,
                                        string &reason_out)
  {
   return ASC_SymbolDataPackTryComposeDryRunForRoute(server_root,
                                                    symbol,
                                                    ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION,
                                                    "",
                                                    payload_out,
                                                    reason_out);
  }

bool ASC_SymbolDataPackTryWriteShadowForRoute(const string server_root,
                                              const string symbol,
                                              const ASC_SymbolDataPackFamilyRoute route,
                                              const string bucket,
                                              string &publication_state_out,
                                              string &publication_reason_out,
                                              const string bucket_display="")
  {
   publication_state_out = "shadow_no_write";
   publication_reason_out = "RUN162R_writer_atomic_foundation_ready_but_disabled_by_default";

   string target_path = ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, route, bucket);
   if(StringLen(target_path) <= 0)
     {
      publication_state_out = "path_guard_failed";
      publication_reason_out = "target_path_empty_server_root_symbol_or_bucket_missing route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   string payload = "";
   string compose_reason = "";
   if(!ASC_SymbolDataPackTryComposeDryRunForRoute(server_root, symbol, route, bucket, payload, compose_reason, bucket_display))
     {
      publication_state_out = "payload_guard_failed";
      publication_reason_out = compose_reason;
      return false;
     }

   string no_change_reason = "";
   bool would_skip = ASC_SymbolDataPackWouldSkipNoChangeForRoute(server_root, symbol, payload, route, bucket, no_change_reason);
   publication_reason_out = "shadow_mode_no_file_write route=" + ASC_SymbolDataPackFamilyRouteText(route)
                            + " target_path=" + target_path
                            + " temp_path=" + ASC_SymbolDataPackTempPathForRoute(server_root, symbol, route, bucket)
                            + " last_good_continuity_path=" + ASC_SymbolDataPackLastGoodContinuityPathForRoute(server_root, symbol, route, bucket)
                            + " no_change_probe=" + (would_skip ? "true" : "false")
                            + " no_change_reason=" + no_change_reason;
   return false;
  }

bool ASC_SymbolDataPackTryWriteShadow(const string server_root,
                                      const string symbol,
                                      string &publication_state_out,
                                      string &publication_reason_out)
  {
   return ASC_SymbolDataPackTryWriteShadowForRoute(server_root,
                                                  symbol,
                                                  ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION,
                                                  "",
                                                  publication_state_out,
                                                  publication_reason_out);
  }

bool ASC_SymbolDataPackTryPublishAtomicForRoute(const string server_root,
                                                const string symbol,
                                                const ASC_SymbolDataPackFamilyRoute route,
                                                const string bucket,
                                                const bool explicit_write_enabled,
                                                string &publication_state_out,
                                                string &publication_reason_out,
                                                const string bucket_display="")
  {
   publication_state_out = "write_disabled";
   publication_reason_out = "pending";

   string target_path = ASC_SymbolDataPackTargetPathForRoute(server_root, symbol, route, bucket);
   if(StringLen(target_path) <= 0)
     {
      publication_state_out = "path_guard_failed";
      publication_reason_out = "target_path_empty_server_root_symbol_or_bucket_missing route=" + ASC_SymbolDataPackFamilyRouteText(route);
      return false;
     }

   string payload = "";
   string compose_reason = "";
   if(!ASC_SymbolDataPackTryComposeDryRunForRoute(server_root, symbol, route, bucket, payload, compose_reason, bucket_display))
     {
      publication_state_out = "payload_guard_failed";
      publication_reason_out = compose_reason;
      return false;
     }

   if(!explicit_write_enabled || ASC_SymbolDataPackShadowModeEnabled() || !ASC_SymbolDataPackRuntimeActivationEnabled())
     {
      publication_state_out = "shadow_no_write";
      publication_reason_out = "atomic_publish_not_called_runtime_activation_disabled route=" + ASC_SymbolDataPackFamilyRouteText(route)
                               + " target_path=" + target_path
                               + " temp_path=" + ASC_SymbolDataPackTempPathForRoute(server_root, symbol, route, bucket)
                               + " last_good_continuity_path=" + ASC_SymbolDataPackLastGoodContinuityPathForRoute(server_root, symbol, route, bucket);
      return false;
     }

   string required_tokens[];
   ASC_SymbolDataPackRequiredTokens(required_tokens);

   string staging_path = ASC_SymbolDataPackStagingPathForRoute(server_root, symbol, route, bucket);
   string staging_state = "staging_not_attempted";
   string staging_reason = "staging_not_attempted";
   bool staging_ok = false;
   if(StringLen(staging_path) > 0 && staging_path != target_path)
     {
      staging_ok = ASC_WritePublicationPayloadAtomic(staging_path,
                                                     payload,
                                                     required_tokens,
                                                     "staging_candidate_written",
                                                     staging_state,
                                                     staging_reason);
      if(staging_ok)
        {
         if(staging_state == "continuity" || StringFind(staging_reason, "retained_last_good=yes") >= 0)
            staging_state = "staging_write_failed";
         else if(StringFind(staging_reason, "reason=no_material_change") >= 0 || StringFind(staging_reason, "operation=skip_write") >= 0)
            staging_state = "staging_candidate_written";
         else
            staging_state = "staging_readback_validated";
        }
      else
        {
         if(StringFind(staging_reason, "readback") >= 0 || StringFind(staging_reason, "token_contract") >= 0)
            staging_state = "staging_readback_failed";
         else
            staging_state = "staging_write_failed";
        }
     }
   else
     {
      staging_state = "staging_write_failed";
      staging_reason = "staging_path_empty_or_equals_final_path";
     }

   string archive_state = "archive_not_attempted";
   string archive_reason = "archive_not_attempted";
   ASC_SymbolDataPackTryArchivePreviousFinalForRoute(server_root,
                                                     symbol,
                                                     payload,
                                                     route,
                                                     bucket,
                                                     required_tokens,
                                                     archive_state,
                                                     archive_reason);

   string final_state = "final_publish_attempted";
   string final_reason = "pending";
   bool ok = ASC_WritePublicationPayloadAtomic(target_path,
                                               payload,
                                               required_tokens,
                                               "published",
                                               final_state,
                                               final_reason);

   string final_verify_reason = "not_attempted";
   bool final_readback_ok = false;
   if(ok)
      final_readback_ok = ASC_VerifyPublicationPayloadReadback(target_path, payload, final_verify_reason);

   string final_fallback_state = "not_attempted";
   string final_fallback_reason = "not_attempted";
   if((!ok || !final_readback_ok) && staging_ok && StringLen(staging_path) > 0 && staging_path != target_path)
     {
      final_fallback_state = "attempted_from_validated_staging_candidate";
      bool fallback_ok = ASC_CopyTextFileAtomic(staging_path,
                                                target_path,
                                                required_tokens,
                                                final_fallback_state,
                                                final_fallback_reason);
      if(fallback_ok)
        {
         string fallback_verify_reason = "pending";
         bool fallback_readback_ok = ASC_VerifyPublicationPayloadReadback(target_path, payload, fallback_verify_reason);
         final_verify_reason = "primary_final_verify=" + final_verify_reason + " fallback_final_verify=" + fallback_verify_reason;
         if(fallback_readback_ok)
           {
            ok = true;
            final_readback_ok = true;
            final_state = "published_after_staging_promote_fallback";
            final_reason = "operation=promote_from_validated_staging_candidate final_path=" + target_path + " staging_path=" + staging_path + " reason=primary_final_write_or_readback_failed_but_staging_candidate_promoted";
           }
         else
           {
            ok = false;
            final_readback_ok = false;
            final_state = "failure";
            final_reason = "operation=promote_from_validated_staging_candidate final_path=" + target_path + " staging_path=" + staging_path + " reason=fallback_final_readback_failed";
           }
        }
     }

   if(ok && !final_readback_ok)
     {
      ok = false;
      final_state = "failure";
      final_reason = "operation=final_readback_verify final_path=" + target_path + " reason=" + final_verify_reason;
     }

   publication_state_out = final_state;
   publication_reason_out = "family_route=" + ASC_SymbolDataPackFamilyRouteText(route)
                            + " route_bucket=" + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? ASC_SymbolDataPackSafeBucketToken(bucket) : "not_applicable")
                            + " route_bucket_name=" + ((route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET) ? ((StringLen(bucket_display) > 0) ? bucket_display : "none") : "not_applicable")
                            + " staging_enabled=true"
                            + " staging_mode=additive_non_authoritative_candidate"
                            + " staging_current_truth=false"
                            + " staging_failure_blocks_final=false"
                            + " staging_path=" + (StringLen(staging_path) > 0 ? staging_path : "none")
                            + " staging_state=" + staging_state
                            + " staging_reason=" + staging_reason
                            + " archive_enabled=true"
                            + " archive_mode=bounded_previous_final_continuity_evidence"
                            + " archive_current_truth=false"
                            + " archive_retention_limit=1"
                            + " archive_failure_blocks_final=false"
                            + " archive_path=" + (StringLen(ASC_SymbolDataPackArchivePathForRoute(server_root, symbol, route, bucket)) > 0 ? ASC_SymbolDataPackArchivePathForRoute(server_root, symbol, route, bucket) : "none")
                            + " archive_state=" + archive_state
                            + " archive_reason=" + archive_reason
                            + " final_publish_state=" + final_state
                            + " final_readback_verified=" + (final_readback_ok ? "true" : "false")
                            + " final_readback_reason=" + final_verify_reason
                            + " final_fallback_state=" + final_fallback_state
                            + " final_fallback_reason=" + final_fallback_reason
                            + " final_path=" + target_path
                            + " temp_path=" + ASC_SymbolDataPackTempPathForRoute(server_root, symbol, route, bucket)
                            + " last_good_continuity_path=" + ASC_SymbolDataPackLastGoodContinuityPathForRoute(server_root, symbol, route, bucket)
                            + " | " + final_reason;
   return ok;
  }

bool ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState(const string server_root,
                                                               const string symbol,
                                                               const ASC_SymbolDataPackFamilyRoute route,
                                                               const string bucket,
                                                               const bool explicit_write_enabled,
                                                               const ASC_RuntimeState &state,
                                                               string &publication_state_out,
                                                               string &publication_reason_out,
                                                               const string bucket_display="")
  {
   ASC_SymbolDataPackRun247PrepareRuntimeOverrides(symbol, route, state);
   bool ok = ASC_SymbolDataPackTryPublishAtomicForRoute(server_root,
                                                        symbol,
                                                        route,
                                                        bucket,
                                                        explicit_write_enabled,
                                                        publication_state_out,
                                                        publication_reason_out,
                                                        bucket_display);
   ASC_SymbolDataPackRun247ClearRuntimeOverrides();
   publication_reason_out = publication_reason_out + " runtime_join_override=RUN247_source_owned_runtime_rows";
   return ok;
  }


bool ASC_SymbolDataPackTryPublishAtomic(const string server_root,
                                        const string symbol,
                                        const bool explicit_write_enabled,
                                        string &publication_state_out,
                                        string &publication_reason_out)
  {
   return ASC_SymbolDataPackTryPublishAtomicForRoute(server_root,
                                                    symbol,
                                                    ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION,
                                                    "",
                                                    explicit_write_enabled,
                                                    publication_state_out,
                                                    publication_reason_out);
  }

#endif
