#ifndef __ASC_DOSSIER_DEEP_CORRELATION_EXTERNAL_CONTEXT_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_CORRELATION_EXTERNAL_CONTEXT_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepCorrelationExternalContextSection(const string cross_market_alignment,
                                                             const string related_symbols,
                                                             const string conflict_symbols,
                                                             const string beta_proxy_notes,
                                                             const string correlation_context_notes,
                                                             const bool owner_truth_available,
                                                             const bool external_context_available,
                                                             ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = cross_market_alignment;
   values[1] = related_symbols;
   values[2] = conflict_symbols;
   values[3] = beta_proxy_notes;
   values[4] = correlation_context_notes;

   status_out.section_name = "deep_peer_context_external";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !external_context_available)
      status_out.posture = "fallback";
   if(!external_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s external_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  external_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Peer Context & External Context\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Cross-Market Alignment: %s\n", cross_market_alignment);
   section += StringFormat("Related Symbols: %s\n", related_symbols);
   section += StringFormat("Conflict Symbols: %s\n", conflict_symbols);
   section += StringFormat("Beta / Proxy Notes: %s\n", beta_proxy_notes);
   section += StringFormat("Peer Context Notes: %s\n", correlation_context_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
