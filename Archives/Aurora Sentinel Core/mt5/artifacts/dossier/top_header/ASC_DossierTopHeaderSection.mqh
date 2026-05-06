#ifndef __ASC_DOSSIERTOPHEADERSECTION_MQH__
#define __ASC_DOSSIERTOPHEADERSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"
#include "../../../core/ASC_Version.mqh"


string ASC_BuildDossierTopHeaderSection(const datetime generated_utc,
                                        const string last_successful_publish,
                                        const string artifact_revision,
                                        const string state_revision,
                                        const string schema_version,
                                        const string logic_version,
                                        const string freshness_compact,
                                        const string continuity_status,
                                        const string freshness_status,
                                        const string selected_symbol_status,
                                        const string deep_analysis_status,
                                        ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 11);
   values[0] = ASC_ArtifactFormatUtc(generated_utc);
   values[1] = last_successful_publish;
   values[2] = artifact_revision;
   values[3] = state_revision;
   values[4] = schema_version;
   values[5] = logic_version;
   values[6] = freshness_compact;
   values[7] = continuity_status;
   values[8] = freshness_status;
   values[9] = selected_symbol_status;
   values[10] = deep_analysis_status;

   status_out.section_name = "dossier_top_header";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 11 - status_out.populated_fields;
   status_out.continuity_used = (StringFind(continuity_status, "Retained") >= 0
                                 || StringFind(continuity_status, "Degraded") >= 0
                                 || StringFind(continuity_status, "Stale") >= 0);
   status_out.posture = "success";
   if(status_out.missing_fields > 0)
      status_out.posture = "fallback";
   if(status_out.continuity_used)
      status_out.posture = "degraded";
   status_out.note = (status_out.missing_fields > 0)
                     ? "one or more header values are unavailable"
                     : "header values projected from current owner-backed runtime truth";

   string section = "";
   section += StringFormat("Generated: %s\n", values[0]);
   section += StringFormat("Last Successful Publish: %s\n", values[1]);
   section += StringFormat("Artifact Revision: %s\n", values[2]);
   section += StringFormat("State Revision: %s\n", values[3]);
   section += StringFormat("Schema Version: %s\n", values[4]);
   section += ASC_ArtifactIdentityLine("dossier", continuity_status) + "\n";
   section += "source_run_id=" + ASC_SourceRunId() + " | source_identity_token=" + ASC_SourceIdentityToken() + " | artifact_written_by_run=" + ASC_SourceRunId() + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion() + " | build_identity_present=true\n";
   bool run092_dossier_review = (StringFind(continuity_status, "Retained") >= 0 || StringFind(continuity_status, "Stale") >= 0 || StringFind(continuity_status, "Degraded") >= 0 || StringFind(deep_analysis_status, "Pending") >= 0 || StringFind(deep_analysis_status, "Unavailable") >= 0);
   section += ASC_ArtifactAlignmentContractLine("dossier",
                                                selected_symbol_status,
                                                "board_signature_available_on_globaltop10_manifest",
                                                "derived_signature_available_on_globaltop10_child_context",
                                                "child_rank_available_on_child_context",
                                                selected_symbol_status,
                                                selected_symbol_status == "Global Top 10 Child" ? "child_header_visible" : "not_globaltop10_child",
                                                continuity_status,
                                                selected_symbol_status,
                                                status_out.posture,
                                                deep_analysis_status,
                                                run092_dossier_review ? "review_required" : "qualified_source_visible_live_unproven",
                                                run092_dossier_review ? 1 : 0,
                                                run092_dossier_review ? "stale_or_deep_pending_or_degraded" : ("runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN),
                                                run092_dossier_review) + "\n";
   section += ASC_ArtifactRun092ContradictionClassCatalogLine() + "\n";
   string run093_mirror_state = run092_dossier_review ? "mirror_degraded" : ("runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN);
   string run093_stale_boundary = run092_dossier_review ? "stale_or_retained_or_deep_pending_boundary_visible" : ("source_patched_live_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN);
   section += ASC_ArtifactRun093MirrorContractLine(selected_symbol_status,
                                                   selected_symbol_status,
                                                   selected_symbol_status,
                                                   selected_symbol_status,
                                                   run093_mirror_state,
                                                   status_out.posture,
                                                   deep_analysis_status,
                                                   run093_stale_boundary,
                                                   run092_dossier_review ? 1 : 0,
                                                   run092_dossier_review ? "stale_or_deep_pending_or_degraded" : ("runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN),
                                                   run092_dossier_review) + "\n";
   section += ASC_ArtifactRun093MirrorContradictionClassCatalogLine() + "\n";
   section += StringFormat("Logic Version: %s\n", values[5]);
   section += StringFormat("Freshness Compact: %s\n", values[6]);
   section += StringFormat("Continuity Status: %s\n", values[7]);
   section += StringFormat("Freshness Status: %s\n", values[8]);
   section += StringFormat("Selected Symbol Status: %s\n", values[9]);
   section += StringFormat("Deep Analysis Status: %s\n", values[10]);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
