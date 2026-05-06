#ifndef __ASC_OPEN_SYMBOL_SNAPSHOT_WRITER_MQH__
#define __ASC_OPEN_SYMBOL_SNAPSHOT_WRITER_MQH__

#include "ASC_ArtifactContracts.mqh"
#include "ASC_ArtifactTextHelpers.mqh"
#include "../logging/ASC_FunctionResults.mqh"
#include "../core/ASC_Constants.mqh"
#include "../core/ASC_ResultCodes.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../io/ASC_FileIO.mqh"

ASC_ArtifactContract ASC_OpenSymbolSnapshotContract(const string server_root)
  {
   ASC_ArtifactContract contract;
   contract.family = ASC_ARTIFACT_OPEN_SYMBOL_SNAPSHOT;
   contract.artifact_name = "Open Symbol Snapshot";
   contract.target_path = server_root + "\\" + ASC_OPEN_SYMBOL_SNAPSHOT_FILE;
   contract.publication_state = ASC_PUBLICATION_PENDING;
   return contract;
  }

ASC_FunctionResult ASC_BuildOpenSymbolSnapshotArtifact(const string server_root,
                                                       const ASC_PublicationBundleState &bundle,
                                                       const ulong min_revision,
                                                       ulong &published_revision,
                                                       int &emitted_symbols,
                                                       int &admitted_symbols)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_OpenSymbolSnapshotWriter", "ASC_BuildOpenSymbolSnapshotArtifact", "runtime");
   ASC_ArtifactContract contract = ASC_OpenSymbolSnapshotContract(server_root);

   string subset_block = "";
   ulong latest_revision = 0;
   ASC_Layer2Summary summary;
   bool has_summary = ASC_Layer2TryGetSummary(summary);
   bool has_any = ASC_Layer2BuildChangedSubsetBlock(min_revision,
                                                    subset_block,
                                                    emitted_symbols,
                                                    admitted_symbols,
                                                    latest_revision);
   bool has_publishable_scope = (has_any || has_summary);
   string publication_state = "fresh";
   if(has_summary)
     {
      if(summary.degraded_count > 0)
         publication_state = "degraded";
      else if(summary.stale_count > 0)
         publication_state = "stale";
      else if(summary.continuity_count > 0)
         publication_state = "continuity";
     }
   else if(!has_any)
     {
      publication_state = "pending";
     }

   if(!has_publishable_scope)
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_WARNING,
                               ASC_RC_OK,
                               "Layer 2 summary is unavailable; Open Symbol Snapshot publication is deferred until scanner state is initialized.",
                               contract.target_path);
      return result;
     }

   string body = "Aurora Sentinel Core - Open Symbol Snapshot\n\n";
   body += "Header\n";
   body += StringFormat("- Product: %s\n", ASC_NAME);
   body += StringFormat("- Server: %s\n", ASC_ArtifactServerName());
   body += StringFormat("- Published At (UTC): %s\n", ASC_ArtifactFormatUtc(bundle.publication_utc));
   body += "\n" + ASC_RuntimeIdentityProofBlock("open_symbol_snapshot", server_root, "open_symbol_snapshot", bundle.publication_utc) + "\n";
   body += ASC_RootArtifactBreathingProofBlock("open_symbol_snapshot",
                                               bundle.publication_utc,
                                               0,
                                               0,
                                               bundle.board_publish_started_utc,
                                               bundle.board_publish_finished_utc,
                                               bundle.publication_utc,
                                               0,
                                               bundle.publication_utc,
                                               0,
                                               0,
                                               "",
                                               false,
                                               "open_symbol_snapshot_attempt_visible_before_success_timestamp_updates",
                                               bundle.write_bottleneck_family == "none" ? "true" : "unknown") + "\n";

   body += "\nPublication Scope\n";
   body += StringFormat("- Snapshot State: %s\n", ASC_ArtifactHumanizeLabel(publication_state));
   body += StringFormat("- Admitted Open Symbols: %d\n", admitted_symbols);
   body += StringFormat("- Changed Symbols Published: %d\n", emitted_symbols);
   body += StringFormat("- Revision Floor: %I64u\n", min_revision);
   body += StringFormat("- Latest Revision: %I64u\n", latest_revision);
   if(has_summary)
     {
      body += StringFormat("- Fresh/Aging/Stale/Degraded/Continuity: %d/%d/%d/%d/%d\n",
                           summary.fresh_count,
                           summary.aging_count,
                           summary.stale_count,
                           summary.degraded_count,
                           summary.continuity_count);
      body += StringFormat("- Specification Fresh/Stale/Degraded: %d/%d/%d\n",
                           summary.spec_ready_count,
                           summary.spec_stale_count,
                           summary.spec_degraded_count);
      body += StringFormat("- Due Symbols: %d\n", summary.due_symbols);
      body += StringFormat("- Specification Due Symbols: %d\n", summary.spec_due_count);
      body += StringFormat("- Next Due (UTC): %s | Reason: %s | Count: %d\n",
                           summary.next_due_utc > 0 ? ASC_ArtifactFormatUtc(summary.next_due_utc) : "unavailable",
                           summary.next_due_reason,
                           summary.next_due_count);
     }

   body += "\nChanged Open-Symbol Subset\n";
   if(admitted_symbols <= 0)
      body += "- No admitted open symbols are currently in scope; this snapshot truthfully clears the committed open-symbol set without inventing packet rows.\n";
   else if(emitted_symbols <= 0)
      body += "- No material open-symbol payload changes landed in this window; previously promoted open-symbol truth remains authoritative.\n";
   else
      body += subset_block;

   body += "\nOwnership Notes\n";
   body += "- Open Symbol Snapshot is committed open-market transport truth.\n";
   body += "- Focused-symbol reads do not force full snapshot rewrites.\n";
   body += "- Validation contract fields are exported with broker-truth values when available and 'unavailable' otherwise.\n";
   body += "- Live comparison uses broker screen truth without forced timestamp synchronization.\n";

   string required_tokens[];
   ArrayResize(required_tokens, 4);
   required_tokens[0] = "Aurora Sentinel Core - Open Symbol Snapshot";
   required_tokens[1] = "Header";
   required_tokens[2] = "Publication Scope";
   required_tokens[3] = "Changed Open-Symbol Subset";

   string write_state = "pending";
   string write_reason = "pending";
   if(!ASC_WritePublicationArtifact(contract.target_path,
                                    bundle.publication_id,
                                    bundle.publication_utc,
                                    body,
                                    required_tokens,
                                    publication_state,
                                    write_state,
                                    write_reason))
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               "Failed to write Open Symbol Snapshot artifact: " + write_reason,
                               contract.target_path);
      return result;
     }

   published_revision = latest_revision;

   ASC_FunctionResultState finish_state = ASC_RESULT_OK;
   string finish_message = (admitted_symbols > 0)
                           ? "Open Symbol Snapshot artifact written with changed subset only."
                           : "Open Symbol Snapshot artifact written with a truthful empty admitted-set state.";
   if(write_state == "continuity")
     {
      finish_state = ASC_RESULT_WARNING;
      finish_message = "Open Symbol Snapshot continuity publish retained the prior last-good artifact.";
     }

   ASC_FunctionResultFinish(result,
                            finish_state,
                            ASC_RC_OK,
                            finish_message,
                            contract.target_path);
   return result;
  }

#endif
