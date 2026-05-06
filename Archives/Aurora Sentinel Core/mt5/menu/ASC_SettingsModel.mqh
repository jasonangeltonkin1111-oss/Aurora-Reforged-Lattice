#ifndef __ASC_SETTINGS_MODEL_MQH__
#define __ASC_SETTINGS_MODEL_MQH__

#include "../core/ASC_Types.mqh"

struct ASC_SettingDescriptor
  {
   string key;
   string value;
   ASC_MenuSafetyClass safety_class;
   string publication_mapping_owner;
  };

void ASC_DefaultTraderSettingDescriptors(ASC_SettingDescriptor &settings[])
  {
   ArrayResize(settings, 11);

   settings[0].key = "hud.density_mode";
   settings[0].value = "normal";
   settings[0].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[0].publication_mapping_owner = "hud";

   settings[1].key = "board.top_n";
   settings[1].value = "10";
   settings[1].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[1].publication_mapping_owner = "market_board";

   settings[2].key = "dossier.section_profile";
   settings[2].value = "identity+market_state+freshness+classification";
   settings[2].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[2].publication_mapping_owner = "dossier";

   settings[3].key = "layer1.recheck_profile";
   settings[3].value = "open:60 closed:300 uncertain:15 unknown:5";
   settings[3].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[3].publication_mapping_owner = "layer1";

   settings[4].key = "layer5.tf_bars";
   settings[4].value = "m1:0 m5:240 m15:200 h1:120 h4:80 d1:60";
   settings[4].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[4].publication_mapping_owner = "layer5_contract";

   settings[5].key = "browse.main_bucket_filter";
   settings[5].value = "all|fx|indices|stocks|metals|energy|crypto|rates|volatility|commodities|funds_etfs|unknown";
   settings[5].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[5].publication_mapping_owner = "hud_bucket_browse";

   settings[6].key = "browse.stock_family_filter";
   settings[6].value = "all|US Stocks|HK Stocks|Europe Stocks|UK Stocks|Canada Stocks|ADR / International Listings|ETF / ETP|REIT / Yield Vehicles|Needs Review";
   settings[6].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[6].publication_mapping_owner = "hud_bucket_browse";

   settings[7].key = "browse.stock_sector_filter";
   settings[7].value = "all|dynamic_by_universe";
   settings[7].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[7].publication_mapping_owner = "hud_bucket_browse";

   settings[8].key = "browse.stock_industry_filter";
   settings[8].value = "all|dynamic_by_universe";
   settings[8].safety_class = ASC_MENU_SAFE_RUNTIME;
   settings[8].publication_mapping_owner = "hud_bucket_browse";

   settings[9].key = "advanced.scan_write_budget";
   settings[9].value = "scan:224 write:40";
   settings[9].safety_class = ASC_MENU_DANGEROUS_RECONFIGURE;
   settings[9].publication_mapping_owner = "dispatcher_governor";

   settings[10].key = "future.layer6_layer7";
   settings[10].value = "reserved_non_active";
   settings[10].safety_class = ASC_MENU_NON_USER_FACING;
   settings[10].publication_mapping_owner = "future_placeholder";
  }

#endif
