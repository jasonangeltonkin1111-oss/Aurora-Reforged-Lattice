#ifndef __ASC_DOSSIER_DEEP_PRICE_MAP_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_PRICE_MAP_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepPriceMapSection(const string nearest_support,
                                           const string nearest_resistance,
                                           const string key_reaction_zones,
                                           const string session_extremes,
                                           const string gap_void_imbalance_notes,
                                           const string price_map_notes,
                                           const bool owner_truth_available,
                                           const bool price_map_context_available,
                                           ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = nearest_support;
   values[1] = nearest_resistance;
   values[2] = key_reaction_zones;
   values[3] = session_extremes;
   values[4] = gap_void_imbalance_notes;
   values[5] = price_map_notes;

   status_out.section_name = "deep_price_map";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !price_map_context_available)
      status_out.posture = "fallback";
   if(!price_map_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s price_map_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  price_map_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Price Map\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Nearest Support: %s\n", nearest_support);
   section += StringFormat("Nearest Resistance: %s\n", nearest_resistance);
   section += StringFormat("Key Reaction Zones: %s\n", key_reaction_zones);
   section += StringFormat("Session Extremes: %s\n", session_extremes);
   section += StringFormat("Gap / Void / Imbalance Notes: %s\n", gap_void_imbalance_notes);
   section += StringFormat("Price Map Notes: %s\n", price_map_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
