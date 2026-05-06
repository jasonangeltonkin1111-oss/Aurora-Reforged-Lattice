#ifndef __ASC_DOSSIERSYMBOLMETADATASECTION_MQH__
#define __ASC_DOSSIERSYMBOLMETADATASECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierSymbolMetadataSection(const string exchange,
                                             const string sector,
                                             const string industry,
                                             const string country,
                                             const string isin,
                                             const string base_currency,
                                             const string quote_currency,
                                             const string margin_currency,
                                             const string digits,
                                             const string point,
                                             const string contract_profile_summary,
                                             const int broker_supported_count,
                                             const int symbol_spec_supported_count,
                                             ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 11);
   values[0] = exchange;
   values[1] = sector;
   values[2] = industry;
   values[3] = country;
   values[4] = isin;
   values[5] = base_currency;
   values[6] = quote_currency;
   values[7] = margin_currency;
   values[8] = digits;
   values[9] = point;
   values[10] = contract_profile_summary;

   status_out.section_name = "symbol_metadata";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 11 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || broker_supported_count <= 0 || symbol_spec_supported_count <= 0)
      status_out.posture = "fallback";
   if(broker_supported_count <= 0 && symbol_spec_supported_count <= 1)
      status_out.posture = "degraded";
   status_out.note = StringFormat("broker_fields=%d spec_fields=%d",
                                  broker_supported_count,
                                  symbol_spec_supported_count);

   string section = "------------------------------------------------------------------------------\n";
   section += "Symbol Metadata\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Exchange: %s\n", exchange);
   section += StringFormat("Sector: %s\n", sector);
   section += StringFormat("Industry: %s\n", industry);
   section += StringFormat("Country: %s\n", country);
   section += StringFormat("ISIN: %s\n", isin);
   section += StringFormat("Base Currency: %s\n", base_currency);
   section += StringFormat("Quote Currency: %s\n", quote_currency);
   section += StringFormat("Margin Currency: %s\n", margin_currency);
   section += StringFormat("Digits: %s\n", digits);
   section += StringFormat("Point: %s\n", point);
   section += StringFormat("Contract Profile Summary: %s\n", contract_profile_summary);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
