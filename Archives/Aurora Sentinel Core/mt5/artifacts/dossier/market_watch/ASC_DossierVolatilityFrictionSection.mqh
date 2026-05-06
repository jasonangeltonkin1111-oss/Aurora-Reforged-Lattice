#ifndef __ASC_DOSSIERVOLATILITYFRICTIONSECTION_MQH__
#define __ASC_DOSSIERVOLATILITYFRICTIONSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierMarketWatchVolatilityFrictionSection(const string atr_value,
                                                            const string atr_pct,
                                                            const string spread_over_atr,
                                                            const string volatility_posture,
                                                            const string friction_posture,
                                                            const string liquidity_posture,
                                                            const string market_watch_notes,
                                                            const bool atr_available,
                                                            const bool continuity_sensitive,
                                                            const bool regime_liquidity_helpers_available,
                                                            ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 7);
   values[0] = atr_value;
   values[1] = atr_pct;
   values[2] = spread_over_atr;
   values[3] = volatility_posture;
   values[4] = friction_posture;
   values[5] = liquidity_posture;
   values[6] = market_watch_notes;

   status_out.section_name = "market_watch_volatility_friction";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 7 - status_out.populated_fields;
   status_out.continuity_used = continuity_sensitive;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !atr_available || !regime_liquidity_helpers_available)
      status_out.posture = "fallback";
   if(continuity_sensitive)
      status_out.posture = "degraded";
   if(!atr_available && !regime_liquidity_helpers_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("atr_available=%s continuity_sensitive=%s regime_liquidity_helpers_available=%s",
                                  atr_available ? "yes" : "no",
                                  continuity_sensitive ? "yes" : "no",
                                  regime_liquidity_helpers_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Volatility & Liquidity\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("ATR Value: %s\n", atr_value);
   section += StringFormat("ATR %%: %s\n", atr_pct);
   section += StringFormat("Spread / ATR: %s\n", spread_over_atr);
   section += StringFormat("Volatility Posture: %s\n", volatility_posture);
   section += StringFormat("Friction Posture: %s\n", friction_posture);
   section += StringFormat("Liquidity Posture: %s\n", liquidity_posture);
   section += StringFormat("Market Watch Notes: %s\n", market_watch_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
