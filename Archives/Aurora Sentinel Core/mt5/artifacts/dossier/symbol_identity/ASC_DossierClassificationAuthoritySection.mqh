#ifndef __ASC_DOSSIERCLASSIFICATIONAUTHORITYSECTION_MQH__
#define __ASC_DOSSIERCLASSIFICATIONAUTHORITYSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierClassificationAuthoritySection(const string advanced_status,
                                                      const string advanced_main_bucket,
                                                      const string advanced_sub_group,
                                                      const string advanced_asset_class,
                                                      const string advanced_source,
                                                      const string advanced_confidence,
                                                      const string broker_main_bucket,
                                                      const string broker_sector,
                                                      const string broker_industry,
                                                      const string broker_exchange,
                                                      const string broker_country,
                                                      const string broker_notes,
                                                      const string resolved_main_bucket,
                                                      const string resolved_sub_group,
                                                      const string resolved_asset_class,
                                                      const string resolution_rule,
                                                      const string classification_conflict_status,
                                                      const string classification_notes,
                                                      const bool advanced_resolved,
                                                      const bool broker_support_present,
                                                      ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 18);
   values[0] = advanced_status;
   values[1] = advanced_main_bucket;
   values[2] = advanced_sub_group;
   values[3] = advanced_asset_class;
   values[4] = advanced_source;
   values[5] = advanced_confidence;
   values[6] = broker_main_bucket;
   values[7] = broker_sector;
   values[8] = broker_industry;
   values[9] = broker_exchange;
   values[10] = broker_country;
   values[11] = broker_notes;
   values[12] = resolved_main_bucket;
   values[13] = resolved_sub_group;
   values[14] = resolved_asset_class;
   values[15] = resolution_rule;
   values[16] = classification_conflict_status;
   values[17] = classification_notes;

   status_out.section_name = "classification_authority";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 18 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !advanced_resolved)
      status_out.posture = "fallback";
   if(!advanced_resolved && !broker_support_present)
      status_out.posture = "degraded";
   status_out.note = !advanced_resolved
                     ? "advanced classification unresolved; broker fields are supporting context only"
                     : (broker_support_present
                        ? "advanced classification resolved; broker metadata remains supporting evidence"
                        : "advanced classification resolved; broker metadata is sparse");

   string section = "------------------------------------------------------------------------------\n";
   section += "Classification\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Advanced Classification Status: %s\n", advanced_status);
   section += StringFormat("Advanced Main Bucket: %s\n", advanced_main_bucket);
   section += StringFormat("Advanced Sub-Group: %s\n", advanced_sub_group);
   section += StringFormat("Advanced Asset Class: %s\n", advanced_asset_class);
   section += StringFormat("Advanced Classification Source: %s\n", advanced_source);
   section += StringFormat("Advanced Classification Confidence: %s\n\n", advanced_confidence);
   section += StringFormat("Broker Main Bucket: %s\n", broker_main_bucket);
   section += StringFormat("Broker Sector: %s\n", broker_sector);
   section += StringFormat("Broker Industry: %s\n", broker_industry);
   section += StringFormat("Broker Exchange: %s\n", broker_exchange);
   section += StringFormat("Broker Country: %s\n", broker_country);
   section += StringFormat("Broker Classification Notes: %s\n\n", broker_notes);
   section += StringFormat("Resolved Main Bucket: %s\n", resolved_main_bucket);
   section += StringFormat("Resolved Sub-Group: %s\n", resolved_sub_group);
   section += StringFormat("Resolved Asset Class: %s\n", resolved_asset_class);
   section += StringFormat("Classification Resolution Rule: %s\n", resolution_rule);
   section += StringFormat("Classification Conflict Status: %s\n", classification_conflict_status);
   section += StringFormat("Classification Notes: %s\n", classification_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
