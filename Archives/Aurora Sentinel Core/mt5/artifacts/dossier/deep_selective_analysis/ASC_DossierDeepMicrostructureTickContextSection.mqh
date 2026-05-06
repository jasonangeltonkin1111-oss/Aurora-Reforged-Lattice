#ifndef __ASC_DOSSIER_DEEP_MICROSTRUCTURE_TICK_CONTEXT_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_MICROSTRUCTURE_TICK_CONTEXT_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepMicrostructureTickContextSection(const string tick_evidence_status,
                                                            const string spread_evidence_status,
                                                            const string microstructure_notes,
                                                            const string quote_stability,
                                                            const string spread_stability,
                                                            const string execution_friction,
                                                            const string microstructure_risk_notes,
                                                            const bool owner_truth_available,
                                                            const bool tick_spread_context_available,
                                                            ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 7);
   values[0] = tick_evidence_status;
   values[1] = spread_evidence_status;
   values[2] = microstructure_notes;
   values[3] = quote_stability;
   values[4] = spread_stability;
   values[5] = execution_friction;
   values[6] = microstructure_risk_notes;

   status_out.section_name = "deep_microstructure_tick_context";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 7 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !tick_spread_context_available)
      status_out.posture = "fallback";
   if(!tick_spread_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s tick_spread_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  tick_spread_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Microstructure\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Tick Evidence Status: %s\n", tick_evidence_status);
   section += StringFormat("Spread Evidence Status: %s\n", spread_evidence_status);
   section += StringFormat("Microstructure Notes: %s\n", microstructure_notes);
   section += StringFormat("Quote Stability: %s\n", quote_stability);
   section += StringFormat("Spread Stability: %s\n", spread_stability);
   section += StringFormat("Execution Friction: %s\n", execution_friction);
   section += StringFormat("Microstructure Risk Notes: %s\n", microstructure_risk_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
