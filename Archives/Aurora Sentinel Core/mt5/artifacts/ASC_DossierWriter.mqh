#ifndef __ASC_DOSSIER_WRITER_MQH__
#define __ASC_DOSSIER_WRITER_MQH__

#include "../logging/ASC_FunctionResults.mqh"
#include "../core/ASC_ResultCodes.mqh"
#include "../deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh"
#include "../io/ASC_FileIO.mqh"

#include "dossier/ASC_DossierContracts.mqh"
#include "dossier/ASC_DossierComposer.mqh"

string ASC_DossierCanonicalSymbol(const ASC_Layer1SymbolState &symbol_state)
  {
   if(StringLen(symbol_state.classification.canonical_symbol) > 0)
      return symbol_state.classification.canonical_symbol;
   if(StringLen(symbol_state.identity.canonical_symbol) > 0)
      return symbol_state.identity.canonical_symbol;
   if(StringLen(symbol_state.identity.normalized_symbol) > 0)
      return symbol_state.identity.normalized_symbol;
   return symbol_state.symbol;
  }

bool ASC_DossierWriterIsShellPayload(const string payload)
  {
   return (StringLen(payload) > 0
           && StringFind(payload, "\nHydration Status\n") >= 0
           && StringFind(payload, "- Shell Only: yes") >= 0
           && StringFind(payload, "Market State Shell") >= 0);
  }

bool ASC_DossierRootDirectSymbolPublicationAllowed()
  {
   return (ASC_ROOT_DIRECT_SYMBOL_DOSSIERS_COMPAT_ENABLED
           || ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED
           || ASC_DIAGNOSTIC_ALL_SYMBOL_DOSSIERS_ENABLED);
  }

string ASC_DossierRootDirectSuppressionDetail(const string canonical_symbol)
  {
   return "RUN193 direct root Dossier symbol output suppressed by default"
          + " | target=Dossiers/" + ASC_TextOrUnavailable(canonical_symbol) + ".txt"
          + " | compatibility_flag=" + (ASC_ROOT_DIRECT_SYMBOL_DOSSIERS_COMPAT_ENABLED ? "true" : "false")
          + " | root_all_symbol_dossiers_enabled=" + (ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false")
          + " | diagnostic_all_symbol_dossiers_enabled=" + (ASC_DIAGNOSTIC_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false")
          + " | policy=" + ASC_ROOT_DIRECT_SYMBOL_DOSSIER_POLICY_RUN193
          + " | skip_reason=" + ASC_ROOT_DIRECT_SYMBOL_DOSSIER_SKIP_REASON_RUN193
          + " | no_file_delete=true | fileio_rewrite=false | top_list_children_preserved=true | current_focus_preserved=true";
  }

ASC_FunctionResult ASC_DossierRootDirectSuppressedResult(const string function_name,
                                                         const ASC_Layer1SymbolState &symbol_state,
                                                         const string canonical_symbol,
                                                         const string target_path)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_DossierWriter", function_name, symbol_state.symbol);
   ASC_FunctionResultSetTruthBoundary(result, "artifact.dossier_writer", "truth_consumer.root_direct_symbol_dossier_suppression");
   ASC_FunctionResultSetHydrationClass(result, "root_direct_symbol_suppressed");
   ASC_FunctionResultMarkClaimEvidenceStatus(result, "source_patched_live_unproven_until_RUN195");
   ASC_FunctionResultFinish(result,
                            ASC_RESULT_WARNING,
                            ASC_RC_OK,
                            ASC_DossierRootDirectSuppressionDetail(canonical_symbol),
                            target_path);
   return result;
  }

bool ASC_DossierShouldPreserveExistingRichArtifact(const string server_root,
                                                   const ASC_Layer1SymbolState &symbol_state,
                                                   const string canonical_symbol)
  {
   if(StringLen(server_root) <= 0 || StringLen(canonical_symbol) <= 0)
      return false;

   ASC_ArtifactContract contract = ASC_DossierContract(server_root, canonical_symbol);
   string existing_payload = "";
   if(!ASC_ReadTextFile(contract.target_path, existing_payload) || StringLen(existing_payload) <= 0)
      return false;

   if(ASC_DossierWriterIsShellPayload(existing_payload))
      return false;

   if(!ASC_DossierPayloadMatchesSymbolContext(existing_payload, symbol_state, canonical_symbol))
      return false;

   return true;
  }



string ASC_DossierShellHydrationClassLabel(const ASC_Layer1SymbolState &symbol_state)
  {
   if(symbol_state.state == ASC_L1_CLOSED)
      return "closed_compact_l0_l2";
   if(symbol_state.state == ASC_L1_OPEN)
      return "pending_publication";
   return "unknown_unclassified";
  }

string ASC_DossierShellHydrationReason(const ASC_Layer1SymbolState &symbol_state)
  {
   if(symbol_state.state == ASC_L1_CLOSED)
      return "closed symbol retains compact Layer 1 shell truth while live L2/L3/L4/L5 evidence remains intentionally unavailable";
   if(symbol_state.state == ASC_L1_OPEN)
      return "open symbol shell exists before broad packet/shortlist/deep hydration is proven for this publish";
   return "market-state is not resolved enough to classify this shell beyond unknown";
  }

ASC_FunctionResult ASC_BuildDossierShellArtifact(const string server_root,
                                                 const ASC_Layer1SymbolState &symbol_state,
                                                 const ASC_PublicationBundleState &bundle)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_DossierWriter", "ASC_BuildDossierShellArtifact", symbol_state.symbol);
   ASC_FunctionResultSetTruthBoundary(result, "artifact.dossier_writer", "truth_consumer.dossier_shell_compose_publish");

   string canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   ASC_ArtifactContract contract = ASC_DossierContract(server_root, canonical_symbol);

   if(!ASC_DossierRootDirectSymbolPublicationAllowed())
      return ASC_DossierRootDirectSuppressedResult("ASC_BuildDossierShellArtifact",
                                                   symbol_state,
                                                   canonical_symbol,
                                                   contract.target_path);

   ulong compose_started_us = GetMicrosecondCount();

   if(ASC_DossierShouldPreserveExistingRichArtifact(server_root, symbol_state, canonical_symbol))
     {
      ASC_FunctionResultSetHydrationClass(result, "retained_rich_last_good");
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_WARNING,
                               ASC_RC_OK,
                               "Symbol Dossier shell publish retained the richer last-good dossier already present for this symbol.",
                               contract.target_path);
      return result;
     }

   string hydration_class = ASC_DossierShellHydrationClassLabel(symbol_state);
   string hydration_reason = ASC_DossierShellHydrationReason(symbol_state);
   ASC_FunctionResultSetHydrationClass(result, hydration_class);

   string body = "Aurora Sentinel Core - Symbol Dossier\n\n";
   body += "Header\n";
   body += StringFormat("- Symbol: %s\n", symbol_state.symbol);
   body += StringFormat("- Canonical Symbol: %s\n", canonical_symbol);
   body += StringFormat("- Published At (UTC): %s\n", ASC_ArtifactFormatUtc(bundle.publication_utc));
   body += StringFormat("- Bundle Id: %s\n", (StringLen(bundle.publication_id) > 0 ? bundle.publication_id : "runtime"));
   body += "\nMarket State Shell\n";
   body += StringFormat("- Market State: %s\n", ASC_L1StateToOperatorText(symbol_state.state));
   body += StringFormat("- Market-State Posture: %s\n", ASC_L1PostureToOperatorText(symbol_state));
   body += StringFormat("- Reason: %s\n", ASC_L1ReasonToOperatorText(symbol_state.reason));
   body += StringFormat("- Session Status: %s\n", ASC_L1SessionStatusToOperatorText(symbol_state));
   body += StringFormat("- Confidence: %s\n", ASC_L1ConfidenceToOperatorText(symbol_state.confidence));
   body += StringFormat("- Next Due Reason: %s\n", ASC_L1DueReasonToOperatorText(symbol_state.next_due_reason));
   body += StringFormat("- Timing Posture: %s\n", ASC_L1TimingStatusNotesToOperatorText(symbol_state));
   body += StringFormat("- Next Due (UTC): %s\n", symbol_state.next_due_utc > 0 ? ASC_ArtifactFormatUtc(symbol_state.next_due_utc) : "awaiting-first-check");
   body += StringFormat("- State Freshness: %s\n", ASC_L1FreshnessToOperatorText(symbol_state));
   body += StringFormat("- Stale: %s\n", symbol_state.is_stale ? "yes" : "no");
   body += StringFormat("- Degraded: %s\n", symbol_state.is_degraded ? "yes" : "no");
   body += "\nLayer 2 Baseline\n";
   body += "- Layer 2 packet/spec hydration: unavailable in this shell beat\n";
   body += "- Layer 2 ownership posture: dossier shell preserves missingness until later hydration pass\n";
   body += "- Layer 2/3/4/5 dependent fields: deferred (no fabricated packet/spec/board/deep truth)\n";
   body += "\nHydration Status\n";
   body += "- Shell Only: yes\n";
   body += "- Hydration Class: " + hydration_class + "\n";
   body += "- Hydration Reason: " + hydration_reason + "\n";
   body += "- Hydration Boundary: file size is diagnostic only; shell compactness is not treated as failure by itself\n";
   body += "- Rich Trader-Packet Hydration: awaiting later-layer packet/filter/shortlist/deep evidence\n";
   if(symbol_state.state == ASC_L1_CLOSED)
     {
      body += "\nClosed-Symbol Collapse\n";
      body += "- Live-path posture: dormant (closed session truth retained)\n";
      body += "- Layer 2 live packet cadence: not currently active for closed state\n";
      body += "- Refresh posture: scheduled calm wake recheck only\n";
     }

   string required_tokens[];
   ArrayResize(required_tokens, symbol_state.state == ASC_L1_CLOSED ? 8 : 7);
   required_tokens[0] = "Publication Id:";
   required_tokens[1] = "Publication UTC:";
   required_tokens[2] = "Aurora Sentinel Core - Symbol Dossier";
   required_tokens[3] = "Header";
   required_tokens[4] = "Market State Shell";
   required_tokens[5] = "Layer 2 Baseline";
   required_tokens[6] = "Hydration Status";
   int hydration_token_index = ArraySize(required_tokens);
   ArrayResize(required_tokens, hydration_token_index + 3);
   required_tokens[hydration_token_index] = "Hydration Class:";
   required_tokens[hydration_token_index + 1] = "Hydration Reason:";
   required_tokens[hydration_token_index + 2] = "Hydration Boundary:";
   if(symbol_state.state == ASC_L1_CLOSED)
      required_tokens[7] = "Closed-Symbol Collapse";

   int compose_elapsed_ms = (int)((GetMicrosecondCount() - compose_started_us) / 1000);

   string write_state = "pending";
   string write_reason = "pending";
   ulong publish_started_us = GetMicrosecondCount();
   if(!ASC_WritePublicationArtifact(contract.target_path,
                                    bundle.publication_id,
                                    bundle.publication_utc,
                                    body,
                                    required_tokens,
                                    "partial",
                                    write_state,
                                    write_reason))
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               "Failed to publish Symbol Dossier shell artifact: " + write_reason,
                               contract.target_path);
      return result;
     }

   ASC_FunctionResultState finish_state = ASC_RESULT_OK;
   string finish_message = "Symbol Dossier shell published with truthful Layer 1 scope.";
   if(write_state == "continuity")
     {
      finish_state = ASC_RESULT_WARNING;
      finish_message = "Symbol Dossier shell continuity publish retained the prior last-good artifact.";
     }

   int publish_elapsed_ms = (int)((GetMicrosecondCount() - publish_started_us) / 1000);
   finish_message += StringFormat(" | hydration_class=%s | perf_compose_ms=%d | perf_publish_ms=%d | perf_artifact_family=dossier_shell",
                                  hydration_class,
                                  compose_elapsed_ms,
                                  publish_elapsed_ms);

   ASC_FunctionResultFinish(result,
                            finish_state,
                            ASC_RC_OK,
                            finish_message,
                            contract.target_path);
   return result;
  }

ASC_FunctionResult ASC_BuildDossierArtifact(const string server_root,
                                            const ASC_Layer1SymbolState &symbol_state,
                                            const ASC_PublicationBundleState &bundle,
                                            const ASC_DossierProductMode dossier_mode,
                                            const ASC_ShortlistSymbolSummary &shortlist_rows[],
                                            const string runtime_selected_symbol_context)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_DossierWriter", "ASC_BuildDossierArtifact", symbol_state.symbol);
   ASC_FunctionResultSetTruthBoundary(result, "artifact.dossier_writer", "truth_consumer.dossier_compose_publish");

   string preliminary_canonical_symbol = ASC_DossierCanonicalSymbol(symbol_state);
   ASC_ArtifactContract preliminary_contract = ASC_DossierContract(server_root, preliminary_canonical_symbol);
   if(!ASC_DossierRootDirectSymbolPublicationAllowed())
      return ASC_DossierRootDirectSuppressedResult("ASC_BuildDossierArtifact",
                                                   symbol_state,
                                                   preliminary_canonical_symbol,
                                                   preliminary_contract.target_path);

   ASC_DeepSelectiveAnalysisResult deep_result;
   ASC_DeepInitResult(deep_result);
   ulong compose_started_us = GetMicrosecondCount();

   string canonical_symbol = "";
   string payload = "";
   string publication_state = "pending";
   string required_tokens[];
   if(!ASC_BuildCanonicalDossierPayload(server_root,
                                        symbol_state,
                                        bundle,
                                        shortlist_rows,
                                        dossier_mode,
                                        false,
                                        deep_result,
                                        runtime_selected_symbol_context,
                                        canonical_symbol,
                                        payload,
                                        publication_state,
                                        required_tokens))
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_DISPATCH_FAILED,
                               "Failed to compose Symbol Dossier payload for lawful baseline coverage.",
                               symbol_state.symbol);
      return result;
     }

   ASC_ArtifactContract contract = ASC_DossierContract(server_root, canonical_symbol);

   int compose_elapsed_ms = (int)((GetMicrosecondCount() - compose_started_us) / 1000);

   string hydration_class = ASC_TextExtractLabeledLineValue(payload, "Hydration Class:");
   string hydration_reason = ASC_TextExtractLabeledLineValue(payload, "Hydration Reason:");
   string hydration_boundary = ASC_TextExtractLabeledLineValue(payload, "Hydration Boundary:");
   bool hydration_class_present = StringLen(hydration_class) > 0;
   bool hydration_reason_present = StringLen(hydration_reason) > 0;
   bool hydration_boundary_present = StringLen(hydration_boundary) > 0;
   ASC_FunctionResultSetHydrationClass(result, ASC_TextOrUnavailable(hydration_class));

   string write_state = "pending";
   string write_reason = "pending";
   ulong publish_started_us = GetMicrosecondCount();
   bool write_ok = ASC_WritePublicationPayloadAtomic(contract.target_path,
                                                     payload,
                                                     required_tokens,
                                                     publication_state,
                                                     write_state,
                                                     write_reason);
   if(!write_ok)
     {
      string fail_status = ASC_DossierHydrationClaimEvidenceStatus(false,
                                                                  hydration_class_present,
                                                                  hydration_reason_present,
                                                                  hydration_boundary_present,
                                                                  write_state,
                                                                  write_reason);
      string fail_detail = ASC_ClaimEvidenceAppend("Failed to publish Symbol Dossier artifact: " + write_reason,
                                                  fail_status,
                                                  ASC_DossierHydrationClaimEvidenceSupport(hydration_class_present,
                                                                                          hydration_reason_present,
                                                                                          hydration_boundary_present),
                                                  ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
      ASC_FunctionResultMarkClaimEvidenceStatus(result, fail_status);
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               fail_detail,
                               contract.target_path);
      return result;
     }

   ASC_FunctionResultState finish_state = ASC_RESULT_OK;
   string finish_message = "Symbol Dossier published with truthful shortlist selection and preserved symbol-scoped Deep Analysis state.";
   if(write_state == "continuity")
     {
      finish_state = ASC_RESULT_WARNING;
      finish_message = "Symbol Dossier continuity publish retained the prior last-good artifact.";
     }

   int publish_elapsed_ms = (int)((GetMicrosecondCount() - publish_started_us) / 1000);
   finish_message += StringFormat(" | hydration_class=%s | hydration_reason_present=%s | hydration_boundary_present=%s | perf_compose_ms=%d | perf_publish_ms=%d | perf_artifact_family=dossier",
                                  ASC_TextOrUnavailable(hydration_class),
                                  hydration_reason_present ? "yes" : "no",
                                  hydration_boundary_present ? "yes" : "no",
                                  compose_elapsed_ms,
                                  publish_elapsed_ms);
   string finish_status = ASC_DossierHydrationClaimEvidenceStatus(true,
                                                              hydration_class_present,
                                                              hydration_reason_present,
                                                              hydration_boundary_present,
                                                              write_state,
                                                              write_reason);
   ASC_FunctionResultMarkClaimEvidenceStatus(result, finish_status);
   finish_message = ASC_ClaimEvidenceAppend(finish_message,
                                            finish_status,
                                            ASC_DossierHydrationClaimEvidenceSupport(hydration_class_present,
                                                                                    hydration_reason_present,
                                                                                    hydration_boundary_present),
                                            ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);

   ASC_FunctionResultFinish(result,
                            finish_state,
                            ASC_RC_OK,
                            finish_message,
                            contract.target_path);
   return result;
  }

#endif
