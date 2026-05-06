#ifndef __IO_ARL_PUBLICATIONMANIFEST_MQH__
#define __IO_ARL_PUBLICATIONMANIFEST_MQH__

//+------------------------------------------------------------------+
//| ARL_PublicationManifest
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN011R
//| Status: MANIFEST PAYLOAD/PUBLISH CALL + FAILURE-LOUD DIAGNOSTICS ONLY.
//+------------------------------------------------------------------+
// Owner: io/publication manifest
// Purpose: Owns Manifest_Current payload composition and publication call.
// Inputs: artifact name, status publication result
// Outputs: manifest payload and publish result
// Forbidden: publishing status directly, strategy logic, proof inflation

bool ARL_PublicationManifest_Init(){ return true; }

string ARL_PublicationManifest_Compose(const string artifact_name,const ARL_FilePublishResult &artifact_result)
  {
   string payload = "{";
   payload += "\"product_name\":\"" + ARL_PRODUCT_NAME + "\",";
   payload += "\"product_version\":\"" + ARL_PRODUCT_VERSION + "\",";
   payload += "\"run_id\":\"" + ARL_PRODUCT_RUN_ID + "\",";
   payload += "\"artifact_name\":\"" + artifact_name + "\",";
   payload += "\"final_path\":\"" + artifact_result.final_path + "\",";
   payload += "\"temp_path\":\"" + artifact_result.temp_path + "\",";
   payload += "\"file_location_mode\":\"" + ARL_Paths_FileLocationMode() + "\",";
   payload += "\"publish_status\":\"" + artifact_result.code + "\",";
   payload += "\"readback_status\":\"" + (artifact_result.readback_ok ? "OK" : "NOT_OK") + "\",";
   payload += "\"no_change_skip\":" + (artifact_result.no_change_skip ? "true" : "false") + ",";
   payload += "\"payload_size\":" + IntegerToString(artifact_result.bytes_written) + ",";
   payload += "\"generated_time\":\"" + TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS) + "\",";
   payload += "\"permission_boundary\":\"NO_TRADE_NO_SIGNAL_NO_EXECUTION_NO_HUD\",";
   payload += "\"proof_boundary\":\"COMPILE_OR_RUNTIME_PROOF_REQUIRED_BEFORE_READINESS_CLAIMS\"";
   payload += "}";
   return payload;
  }

ARL_FilePublishResult ARL_PublicationManifest_Publish(const ARL_FilePublishResult &artifact_result,const bool writes_enabled)
  {
   string manifest_payload = ARL_PublicationManifest_Compose("Status_Current",artifact_result);
   string reason = "";
   if(!ARL_OutputContracts_ValidateManifestCurrent(manifest_payload,reason))
     {
      ARL_FilePublishResult failed = ARL_FilePublisher_MakeResult(false,"MANIFEST_CONTRACT_FAILED",reason,ARL_Paths_ManifestCurrent(),ARL_Paths_TempFor(ARL_Paths_ManifestCurrent()));
      return failed;
     }
   return ARL_FilePublisher_Publish(ARL_Paths_ManifestCurrent(),manifest_payload,writes_enabled,"artifact_name");
  }

string ARL_PublicationManifest_Contract(){ return "ACTIVE_MANIFEST_CURRENT_FOR_STATUS_PUBLICATION"; }

#endif // __IO_ARL_PUBLICATIONMANIFEST_MQH__
