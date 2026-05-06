#ifndef __ASC_TYPES_MQH__
#define __ASC_TYPES_MQH__

enum ASC_RuntimePosture
  {
   ASC_RUNTIME_BOOTSTRAP = 0,
   ASC_RUNTIME_READY     = 1,
   ASC_RUNTIME_DEGRADED  = 2,
   ASC_RUNTIME_STOPPED   = 3
  };

enum ASC_RuntimeMode
  {
   ASC_MODE_WARMUP         = 0,
   ASC_MODE_BALANCED       = 1,
   ASC_MODE_WRITE_PRESSURE = 2,
   ASC_MODE_DEGRADED       = 3
  };

enum ASC_PublicationState
  {
   ASC_PUBLICATION_PENDING    = 0,
   ASC_PUBLICATION_FRESH      = 1,
   ASC_PUBLICATION_STALE      = 2,
   ASC_PUBLICATION_DEGRADED   = 3,
   ASC_PUBLICATION_CONTINUITY = 4,
   ASC_PUBLICATION_FAILURE    = 5
  };

enum ASC_FunctionResultState
  {
   ASC_RESULT_OK      = 0,
   ASC_RESULT_WARNING = 1,
   ASC_RESULT_ERROR   = 2
  };

enum ASC_ArtifactFamily
  {
   ASC_ARTIFACT_MARKET_BOARD  = 0,
   ASC_ARTIFACT_CURRENT_FOCUS = 1,
   ASC_ARTIFACT_DOSSIER       = 2,
   ASC_ARTIFACT_OPEN_SYMBOL_SNAPSHOT = 3,
   ASC_ARTIFACT_SCANNER_STATUS = 4
  };

enum ASC_SymbolLifecycleState
  {
   ASC_SYMBOL_UNKNOWN        = 0,
   ASC_SYMBOL_DISCOVERED     = 1,
   ASC_SYMBOL_NORMALIZED     = 2,
   ASC_SYMBOL_CLASSIFIED     = 3,
   ASC_SYMBOL_NOT_ADMISSIBLE = 4
  };

enum ASC_CorrelationClass
  {
   ASC_CORRELATION_UNSET = 0,
   ASC_CORRELATION_LOW   = 1,
   ASC_CORRELATION_MID   = 2,
   ASC_CORRELATION_HIGH  = 3
  };

enum ASC_MenuSafetyClass
  {
   ASC_MENU_SAFE_RUNTIME          = 0,
   ASC_MENU_DANGEROUS_RECONFIGURE = 1,
   ASC_MENU_NON_USER_FACING       = 2
  };

enum ASC_MajorLane
  {
   ASC_LANE_SCAN        = 0,
   ASC_LANE_PERSISTENCE = 1,
   ASC_LANE_HUD         = 2,
   ASC_LANE_RECOVERY    = 3,
   ASC_LANE_FOCUS       = 4,
   ASC_LANE_CALCULATION = 5
  };

enum ASC_Sublane
  {
   ASC_SUBLANE_L1_BROAD_SCAN       = 0,
   ASC_SUBLANE_L1_CONFIRMATION     = 1,
   ASC_SUBLANE_PERSISTENCE_PUBLISH = 2
  };

struct ASC_SymbolIdentity
  {
   string raw_symbol;
   string normalized_symbol;
   string canonical_symbol;
   ASC_SymbolLifecycleState state;
  };

struct ASC_SymbolClassification
  {
   string raw_symbol;
   string normalized_symbol;
   string canonical_symbol;
   string asset_class;
   string primary_bucket;
   string main_bucket_id;
   string main_bucket_name;
   string sub_bucket_id;
   string sub_bucket_name;
   string sub_bucket_source;
   string hierarchy_l1_id;
   string hierarchy_l1_name;
   string hierarchy_l2_id;
   string hierarchy_l2_name;
   string hierarchy_l3_id;
   string hierarchy_l3_name;
   string stock_family_id;
   string stock_family_name;
   string stock_venue_family_id;
   string stock_venue_family_name;
   string stock_product_family_id;
   string stock_product_family_name;
   string stock_family_review_state;
   string stock_sector_id;
   string stock_sector_resolution_state;
   string stock_sector_source;
   string stock_industry_id;
   string stock_industry_resolution_state;
   string stock_industry_source;
   string stock_sub_industry_id;
   string stock_sub_industry_resolution_state;
   string stock_sub_industry_source;
   string stock_venue_region_id;
   string stock_venue_region_name;
   string stock_sector_name;
   string stock_industry_name;
   string stock_sub_industry_name;
   string stock_special_family_tag;
   string sector;
   string industry;
   string theme_bucket;
   string subtype;
   string alias_kind;
   string match_kind;
   string confidence;
   string review_status;
   string resolution_state;
   string notes;
   bool resolved;
  };

struct ASC_SymbolSpecification
  {
   string symbol;
   datetime last_refreshed_utc;
   long trade_mode;
   long execution_mode;
   long calculation_mode;
   long filling_mode;
   long expiration_mode;
   long order_mode;
   long chart_mode;
   long spread_float_mode;
   long digits;
   double point;
   double tick_size;
   double tick_value;
   double contract_size;
   double volume_min;
   double volume_max;
   double volume_step;
   long stop_distance_points;
   long freeze_distance_points;
   long swap_mode;
   double swap_long;
   double swap_short;
   double margin_initial;
   double margin_maintenance;
   string margin_currency;
   string profit_currency;
   bool has_trade_mode;
   bool has_execution_mode;
   bool has_calculation_mode;
   bool has_filling_mode;
   bool has_expiration_mode;
   bool has_order_mode;
   bool has_chart_mode;
   bool has_spread_float_mode;
   bool has_digits;
   bool has_point;
   bool has_tick_size;
   bool has_tick_value;
   bool has_contract_size;
   bool has_volume_min;
   bool has_volume_max;
   bool has_volume_step;
   bool has_stop_distance_points;
   bool has_freeze_distance_points;
   bool has_swap_mode;
   bool has_swap_long;
   bool has_swap_short;
   bool has_margin_initial;
   bool has_margin_maintenance;
   bool has_margin_currency;
   bool has_profit_currency;
  };

struct ASC_BrokerDescriptors
  {
   string sector;
   string industry;
   string isin;
   string trust_posture;
   bool has_sector;
   bool has_industry;
   bool has_isin;
  };

#endif
