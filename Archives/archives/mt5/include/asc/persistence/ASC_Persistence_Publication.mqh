#ifndef ASC_PERSISTENCE_PUBLICATION_MQH
#define ASC_PERSISTENCE_PUBLICATION_MQH

#include "../config/ASC_Config_Defaults.mqh"
#include "../core/ASC_Core_RuntimeState.mqh"
#include "../layers/ASC_Layer1_MarketState.mqh"
#include "ASC_Persistence_Paths.mqh"

string ASC_TextFreshness(const ASC_FreshnessPosture value)
  {
   switch(value)
     {
      case ASC_FRESHNESS_FRESH:            return "Fresh";
      case ASC_FRESHNESS_STALE:            return "Stale";
      case ASC_FRESHNESS_DEGRADED:         return "Degraded";
      case ASC_FRESHNESS_PENDING_REFRESH:  return "Pending refresh";
      default:                             return "Unknown";
     }
  }

string ASC_TextCompleteness(const ASC_CompletenessPosture value)
  {
   switch(value)
     {
      case ASC_COMPLETENESS_COMPLETE: return "Complete";
      case ASC_COMPLETENESS_PARTIAL:  return "Partial";
      case ASC_COMPLETENESS_BLOCKED:  return "Blocked";
      default:                        return "Unknown";
     }
  }

string ASC_TextMarketState(const ASC_MarketStatePosture value)
  {
   switch(value)
     {
      case ASC_MARKET_STATE_OPEN:      return "Open";
      case ASC_MARKET_STATE_CLOSED:    return "Closed";
      case ASC_MARKET_STATE_UNCERTAIN: return "Uncertain";
      default:                         return "Unknown";
     }
  }

string ASC_TextFreshnessWindow(const datetime observed_at,
                                 const datetime reference_time)
  {
   if(observed_at <= 0 || reference_time <= 0)
      return "Observation time not available";

   int age_seconds = (int)(reference_time - observed_at);
   if(age_seconds < 0)
      age_seconds = 0;

   if(age_seconds <= ASC_DEFAULT_HEARTBEAT_SECONDS)
      return "Observed on the latest heartbeat";

   if(age_seconds < 60)
      return "Observed " + IntegerToString(age_seconds) + " seconds ago";

   int age_minutes = age_seconds / 60;
   if(age_minutes < 60)
      return "Observed " + IntegerToString(age_minutes) + " minutes ago";

   int age_hours = age_minutes / 60;
   return "Observed " + IntegerToString(age_hours) + " hours ago";
  }

string ASC_TextPublicationWindow(const datetime published_at,
                                 const datetime reference_time)
  {
   if(published_at <= 0)
      return "Not published yet";

   datetime effective_reference_time = reference_time;
   if(effective_reference_time <= 0)
      effective_reference_time = published_at;

   int age_seconds = (int)(effective_reference_time - published_at);
   if(age_seconds < 0)
      age_seconds = 0;

   if(age_seconds <= ASC_DEFAULT_HEARTBEAT_SECONDS)
      return "Published on the latest write cycle";

   if(age_seconds < 60)
      return "Published " + IntegerToString(age_seconds) + " seconds ago";

   int age_minutes = age_seconds / 60;
   if(age_minutes < 60)
      return "Published " + IntegerToString(age_minutes) + " minutes ago";

   int age_hours = age_minutes / 60;
   return "Published " + IntegerToString(age_hours) + " hours ago";
  }

string ASC_TextObservedState(const ASC_MarketStateRecord &record)
  {
   if(record.MarketState == ASC_MARKET_STATE_OPEN && record.Freshness == ASC_FRESHNESS_FRESH)
      return "Recent live evidence is available.";

   if(record.MarketState == ASC_MARKET_STATE_CLOSED)
      return "The symbol is currently outside a tradable session or explicitly unavailable.";

   if(record.MarketState == ASC_MARKET_STATE_UNCERTAIN)
      return "Evidence exists, but it is no longer fresh enough to treat as open with confidence.";

   return "The runtime still needs better evidence before presenting a stronger posture.";
  }

string ASC_TextLayerSlot(const ASC_LayerSlotStatus &slot)
  {
   string line = "Implemented: ";
   line += slot.Implemented ? "Yes" : "No";
   line += "\r\nStatus: " + slot.StatusNote;
   line += "\r\nLast Updated: " + TimeToString(slot.LastUpdateAt, TIME_DATE | TIME_SECONDS);
   return line;
  }

bool ASC_PublicationFileExists(const string relative_path)
  {
   ResetLastError();
   bool exists = FileIsExist(relative_path, FILE_COMMON);
   ResetLastError();
   return exists;
  }

void ASC_PublicationDeleteFileIfExists(const string relative_path)
  {
   if(!ASC_PublicationFileExists(relative_path))
      return;

   ResetLastError();
   FileDelete(relative_path, FILE_COMMON);
   ResetLastError();
  }

bool ASC_PublicationWriteTempFile(const string relative_path,
                                  const string payload)
  {
   int handle = FileOpen(relative_path,
                         FILE_WRITE | FILE_TXT | FILE_ANSI | FILE_COMMON);
   if(handle == INVALID_HANDLE)
      return false;

   uint bytes_written = FileWriteString(handle, payload);
   FileFlush(handle);
   FileClose(handle);

   if(StringLen(payload) > 0 && bytes_written == 0)
      return false;

   if(!ASC_PublicationFileExists(relative_path))
      return false;

   return true;
  }

bool ASC_PublicationPromoteAtomicFile(const string final_path,
                                      const string payload)
  {
   string temp_path   = ASC_PathTempFile(final_path);
   string backup_path = ASC_PathLastGoodFile(final_path);

   ASC_PublicationDeleteFileIfExists(temp_path);

   if(!ASC_PublicationWriteTempFile(temp_path, payload))
     {
      ASC_PublicationDeleteFileIfExists(temp_path);
      return false;
     }

   bool target_exists = ASC_PublicationFileExists(final_path);
   if(target_exists)
     {
      ASC_PublicationDeleteFileIfExists(backup_path);
      if(!FileCopy(final_path, FILE_COMMON, backup_path, FILE_COMMON | FILE_REWRITE))
        {
         ASC_PublicationDeleteFileIfExists(temp_path);
         return false;
        }
     }

   if(!FileMove(temp_path, FILE_COMMON, final_path, FILE_COMMON | FILE_REWRITE))
     {
      ASC_PublicationDeleteFileIfExists(temp_path);

      if(target_exists && ASC_PublicationFileExists(backup_path) && !ASC_PublicationFileExists(final_path))
         FileCopy(backup_path, FILE_COMMON, final_path, FILE_COMMON | FILE_REWRITE);

      return false;
     }

   return true;
  }

bool ASC_PublicationWriteTextFile(const string relative_path,
                                  const string payload)
  {
   return ASC_PublicationPromoteAtomicFile(relative_path, payload);
  }

bool ASC_PublicationInitialize(ASC_RootRuntimeState &state)
  {
   string server_name = state.Runtime.Identity.ServerName;
   string server_root = ASC_PathServerRoot(server_name);

   if(!ASC_PathEnsurePublicationFolders(server_root))
      return false;

   state.Publication.OutputRoot        = server_root;
   state.Publication.SummaryPath       = ASC_PathSummaryFile(server_root);
   state.Publication.DossierFolderPath = ASC_PathDossierFolder(server_root);
   state.Publication.OutputReady       = true;
   state.Publication.WriteWindowOpen   = false;
   return true;
  }

bool ASC_PublicationBeginWriteWindow(ASC_RootRuntimeState &state)
  {
   if(!state.Publication.OutputReady)
      return false;

   state.Publication.WriteWindowOpen = true;
   state.Governor.AtomicLandingProtected = true;
   return true;
  }

void ASC_PublicationEndWriteWindow(ASC_RootRuntimeState &state)
  {
   state.Publication.WriteWindowOpen = false;
   state.Governor.AtomicLandingProtected = false;
  }

string ASC_PublicationBuildSummaryPayload(const ASC_RootRuntimeState &state)
  {
   datetime reference_time = state.Runtime.PhaseMarkers.LastHeartbeatAt;
   if(reference_time <= 0)
      reference_time = TimeCurrent();

   string payload = "Aurora Sentinel Core\r\n";
   payload += "====================\r\n\r\n";

   payload += "[OPERATOR_SUMMARY]\r\n";
   payload += "Server: " + state.Runtime.Identity.ServerName + "\r\n";
   payload += "Runtime Status: Running\r\n";
   payload += "Market Status Coverage: " + IntegerToString(state.Layer1.TotalSymbols) + " symbols observed\r\n";
   payload += "Observation Time: " + TimeToString(state.Layer1.LastScanAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Observation Freshness: " + ASC_TextFreshnessWindow(state.Layer1.LastScanAt, reference_time) + "\r\n";
   payload += "Latest Summary Publish: " + TimeToString(state.Layer1.LastSummaryPublishAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Latest Dossier Publish: " + TimeToString(state.Layer1.LastDossierPublishAt, TIME_DATE | TIME_SECONDS) + "\r\n\r\n";

   payload += "[RUNTIME_PRODUCT_IDENTITY]\r\n";
   payload += "Product: " + ASC_DEFAULT_PRODUCT_NAME + "\r\n";
   payload += "Version: v" + ASC_DEFAULT_PRODUCT_VERSION + "\r\n";
   payload += "Build: " + state.Runtime.Identity.BuildId + "\r\n";
   payload += "Runtime Session: " + state.Runtime.Identity.RuntimeSessionId + "\r\n";
   payload += "Started At: " + TimeToString(state.Runtime.Identity.StartedAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Last Heartbeat: " + TimeToString(state.Runtime.PhaseMarkers.LastHeartbeatAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Output Root: " + state.Publication.OutputRoot + "\r\n\r\n";

   payload += "[MARKET STATUS DISTRIBUTION]\r\n";
   payload += "Open: " + IntegerToString(state.Layer1.OpenCount) + "\r\n";
   payload += "Closed: " + IntegerToString(state.Layer1.ClosedCount) + "\r\n";
   payload += "Uncertain: " + IntegerToString(state.Layer1.UncertainCount) + "\r\n";
   payload += "Unknown: " + IntegerToString(state.Layer1.UnknownCount) + "\r\n\r\n";

   payload += "[CLASSIFICATION DISTRIBUTION]\r\n";
   payload += "Resolved: " + IntegerToString(state.Layer1.ResolvedClassificationCount) + "\r\n";
   payload += "Unresolved: " + IntegerToString(state.Layer1.UnknownClassificationCount) + "\r\n";
   payload += "FX: " + IntegerToString(state.Layer1.FxCount) + "\r\n";
   payload += "Indices: " + IntegerToString(state.Layer1.IndexCount) + "\r\n";
   payload += "Metals: " + IntegerToString(state.Layer1.MetalsCount) + "\r\n";
   payload += "Energy: " + IntegerToString(state.Layer1.EnergyCount) + "\r\n";
   payload += "Crypto: " + IntegerToString(state.Layer1.CryptoCount) + "\r\n";
   payload += "Stocks: " + IntegerToString(state.Layer1.StockCount) + "\r\n\r\n";

   payload += "[FRESHNESS POSTURE]\r\n";
   payload += "Fresh: " + IntegerToString(state.Layer1.FreshCount) + "\r\n";
   payload += "Stale: " + IntegerToString(state.Layer1.StaleCount) + "\r\n";
   payload += "Pending Refresh: " + IntegerToString(state.Layer1.PendingRefreshCount) + "\r\n";
   payload += "Degraded: " + IntegerToString(state.Layer1.DegradedCount) + "\r\n\r\n";

   payload += "[COMPLETENESS POSTURE]\r\n";
   payload += "Complete: " + IntegerToString(state.Layer1.CompleteCount) + "\r\n";
   payload += "Partial: " + IntegerToString(state.Layer1.PartialCount) + "\r\n";
   payload += "Blocked: " + IntegerToString(state.Layer1.BlockedCount) + "\r\n\r\n";

   payload += "[CADENCE VISIBILITY]\r\n";
   payload += "Latest Scan Duration: " + IntegerToString(state.Layer1.LastScanDurationMilliseconds) + " ms\r\n";
   payload += "Observation Freshness: " + ASC_TextFreshnessWindow(state.Layer1.LastScanAt, reference_time) + "\r\n";
   payload += "Summary Publication Timing: " + ASC_TextPublicationWindow(state.Layer1.LastSummaryPublishAt, reference_time) + "\r\n";
   payload += "Dossier Publication Timing: " + ASC_TextPublicationWindow(state.Layer1.LastDossierPublishAt, reference_time) + "\r\n\r\n";

   payload += "[PUBLICATION_METADATA]\r\n";
   payload += "Summary Path: " + state.Publication.SummaryPath + "\r\n";
   payload += "Dossier Folder: " + state.Publication.DossierFolderPath + "\r\n";
   payload += "Write Window Ready: " + (state.Publication.OutputReady ? "Yes" : "No") + "\r\n\r\n";

   payload += "[CLASSIFICATION VISIBILITY]\r\n";
   payload += "Coverage Source: Uploaded project classification evidence only\r\n";
   payload += "Coverage Note: Main group and subgroup come from deterministic archive-lineage rows when a lawful match exists.\r\n";
   payload += "Unresolved Symbols: " + IntegerToString(state.Layer1.UnknownClassificationCount) + "\r\n\r\n";

   payload += "[FORWARD SURFACE NOTES]\r\n";
   payload += "Classification is now evidence-backed where archive-lineage rows lawfully match the live symbol identity.\r\n";
   payload += "Open Symbol Snapshot, Selection Filter, Shortlist, and Deep Analysis remain future work and are not inferred in this summary.\r\n";
   return payload;
  }

bool ASC_PublicationWriteSummary(ASC_RootRuntimeState &state)
  {
   if(!state.Publication.OutputReady || !state.Publication.WriteWindowOpen)
      return false;

   string payload = ASC_PublicationBuildSummaryPayload(state);
   if(!ASC_PublicationWriteTextFile(state.Publication.SummaryPath, payload))
      return false;

   datetime now = TimeCurrent();
   if(now <= 0)
      now = TimeLocal();
   state.Publication.LastSummaryWriteAt = now;
   state.Layer1.LastSummaryPublishAt    = now;
   state.Layer1.PublicationReady        = true;
   state.Runtime.PhaseMarkers.LastStructuralCommitAt = now;
   state.Runtime.LifecycleState.StructuralArtifactsAvailable = true;
   return true;
  }

string ASC_PublicationBuildDossierPayload(const ASC_RootRuntimeState &state,
                                          const ASC_MarketStateRecord &record)
  {
   datetime reference_time = state.Runtime.PhaseMarkers.LastHeartbeatAt;
   if(reference_time <= 0)
      reference_time = TimeCurrent();

   string payload = "Aurora Sentinel Core\r\n";
   payload += "=====================\r\n\r\n";

   payload += "[OPERATOR_SUMMARY]\r\n";
   payload += "Symbol: " + record.Identity.DisplaySymbol + "\r\n";
   payload += "Display Name: " + record.Identity.DisplayName + "\r\n";
   payload += "Server: " + record.Identity.ServerName + "\r\n";
   payload += "Main Group: " + record.Identity.MainGroup + "\r\n";
   payload += "Subgroup: " + record.Identity.SubGroup + "\r\n";
   payload += "Market Status: " + ASC_TextMarketState(record.MarketState) + "\r\n";
   payload += "Freshness: " + ASC_TextFreshness(record.Freshness) + "\r\n";
   payload += "Completeness: " + ASC_TextCompleteness(record.Completeness) + "\r\n";
   payload += "Observation Time: " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Observation Freshness: " + ASC_TextFreshnessWindow(record.ObservedAt, reference_time) + "\r\n";
   payload += "Reason: " + record.StatusReason + "\r\n";
   payload += "Current Readiness Note: " + ASC_TextObservedState(record) + "\r\n\r\n";

   payload += "[RUNTIME_PRODUCT_IDENTITY]\r\n";
   payload += "Product: " + ASC_DEFAULT_PRODUCT_NAME + "\r\n";
   payload += "Version: v" + ASC_DEFAULT_PRODUCT_VERSION + "\r\n";
   payload += "Build: " + state.Runtime.Identity.BuildId + "\r\n";
   payload += "Runtime Session: " + state.Runtime.Identity.RuntimeSessionId + "\r\n\r\n";

   payload += "[SERVER_SYMBOL_IDENTITY]\r\n";
   payload += "Server: " + record.Identity.ServerName + "\r\n";
   payload += "Raw Symbol: " + record.Identity.RawBrokerSymbol + "\r\n";
   payload += "Display Symbol: " + record.Identity.DisplaySymbol + "\r\n";
   payload += "Normalized Symbol: " + record.Identity.NormalizedSymbol + "\r\n";
   payload += "Canonical Symbol: " + record.Identity.CanonicalSymbol + "\r\n";
   payload += "Symbol Key: " + record.Identity.SymbolKey + "\r\n";
   payload += "Display Name: " + record.Identity.DisplayName + "\r\n\r\n";

   payload += "[CLASSIFICATION]\r\n";
   payload += "Resolved: " + (record.Identity.ClassificationResolved ? "Yes" : "No") + "\r\n";
   payload += "Main Group: " + record.Identity.MainGroup + "\r\n";
   payload += "Subgroup: " + record.Identity.SubGroup + "\r\n";
   payload += "Asset Class: " + record.Identity.AssetClass + "\r\n";
   payload += "Sector: " + record.Identity.Sector + "\r\n";
   payload += "Industry: " + record.Identity.Industry + "\r\n";
   payload += "Theme: " + record.Identity.ThemeBucket + "\r\n";
   payload += "Subtype: " + record.Identity.Subtype + "\r\n";
   payload += "Classification Source: " + record.Identity.ClassificationSource + "\r\n";
   payload += "Match Path: " + record.Identity.ClassificationMatch + "\r\n";
   payload += "Confidence: " + record.Identity.ClassificationConfidence + "\r\n";
   payload += "Review Status: " + record.Identity.ClassificationReviewStatus + "\r\n";
   payload += "Note: " + record.Identity.ClassificationNote + "\r\n\r\n";

   payload += "[MARKET STATUS]\r\n";
   payload += "Implemented: Yes\r\n";
   payload += "Market Status: " + ASC_TextMarketState(record.MarketState) + "\r\n";
   payload += "Reason: " + record.StatusReason + "\r\n";
   payload += "Observation Time: " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Observation Freshness: " + ASC_TextFreshnessWindow(record.ObservedAt, reference_time) + "\r\n";
   payload += "Freshness: " + ASC_TextFreshness(record.Freshness) + "\r\n";
   payload += "Completeness: " + ASC_TextCompleteness(record.Completeness) + "\r\n\r\n";

   payload += "[OPEN SYMBOL SNAPSHOT]\r\n" + ASC_TextLayerSlot(state.LayerScaffold.Layer2) + "\r\n\r\n";
   payload += "[SELECTION FILTER]\r\n" + ASC_TextLayerSlot(state.LayerScaffold.Layer3) + "\r\n\r\n";
   payload += "[SHORTLIST]\r\n" + ASC_TextLayerSlot(state.LayerScaffold.Layer4) + "\r\n\r\n";
   payload += "[DEEP ANALYSIS]\r\n" + ASC_TextLayerSlot(state.LayerScaffold.Layer5) + "\r\n\r\n";

   payload += "[PUBLICATION_METADATA]\r\n";
   payload += "Summary Path: " + state.Publication.SummaryPath + "\r\n";
   payload += "Dossier Folder: " + state.Publication.DossierFolderPath + "\r\n";
   payload += "Dossier Path: " + ASC_PathDossierFile(state.Publication.OutputRoot, record.Identity.SymbolKey) + "\r\n";
   payload += "Latest Summary Publish: " + TimeToString(state.Layer1.LastSummaryPublishAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Latest Dossier Publish: " + TimeToString(state.Layer1.LastDossierPublishAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   payload += "Summary Publication Timing: " + ASC_TextPublicationWindow(state.Layer1.LastSummaryPublishAt, reference_time) + "\r\n";
   payload += "Dossier Publication Timing: " + ASC_TextPublicationWindow(state.Layer1.LastDossierPublishAt, reference_time) + "\r\n\r\n";

   payload += "[FORWARD SURFACE NOTES]\r\n";
   payload += "Classification is evidence-backed only when uploaded project rows lawfully match the live server symbol.\r\n";
   payload += "Open Symbol Snapshot, Selection Filter, Shortlist, and Deep Analysis remain scaffold-only here. No later-stage values are inferred in this dossier.\r\n";
   return payload;
  }

bool ASC_PublicationWriteDossier(ASC_RootRuntimeState &state,
                                 const ASC_MarketStateRecord &record)
  {
   if(!state.Publication.OutputReady || !state.Publication.WriteWindowOpen)
      return false;

   string payload = ASC_PublicationBuildDossierPayload(state, record);
   string path = ASC_PathDossierFile(state.Publication.OutputRoot, record.Identity.SymbolKey);
   if(!ASC_PublicationWriteTextFile(path, payload))
      return false;

   datetime now = TimeCurrent();
   if(now <= 0)
      now = TimeLocal();
   state.Publication.LastDossierWriteAt = now;
   state.Layer1.LastDossierPublishAt    = now;
   return true;
  }

bool ASC_PublicationWriteLayer1Outputs(ASC_RootRuntimeState &state)
  {
   if(!state.Publication.OutputReady)
      return false;

   if(!ASC_PublicationBeginWriteWindow(state))
      return false;

   bool success = true;
   int total_records = ArraySize(g_asc_layer1_records);

   for(int i = 0; i < total_records; i++)
     {
      ASC_MarketStateRecord record = g_asc_layer1_records[i];
      ASC_MarketStatePosture previous_published_state = record.LastPublishedState;
      bool previous_publish_seen = record.PublishedOnce;
      bool should_publish = (!previous_publish_seen || previous_published_state != record.MarketState);

      if(should_publish)
        {
         if(ASC_PublicationWriteDossier(state, record))
           {
            record.PublishedOnce = true;
            record.LastPublishedState = record.MarketState;
            record.LastPublishedAt = state.Layer1.LastScanAt;
            g_asc_layer1_records[i] = record;
           }
         else
           {
            success = false;
            break;
           }
        }
     }

   if(success)
      success = ASC_PublicationWriteSummary(state);

   ASC_PublicationEndWriteWindow(state);
   return success;
  }

#endif // ASC_PERSISTENCE_PUBLICATION_MQH
