#ifndef __ASC_TRADER_CONTROL_REGISTRY_MQH__
#define __ASC_TRADER_CONTROL_REGISTRY_MQH__

#include "../core/ASC_Constants.mqh"

enum ASC_TraderControlClass
  {
   ASC_CONTROL_CLASS_TRADER = 0,
   ASC_CONTROL_CLASS_ADVANCED = 1,
   ASC_CONTROL_CLASS_SYSTEM_OWNED = 2
  };

struct ASC_TraderControls
  {
   // HUD & Display
   bool hud_enabled;
   int hud_density_mode;
   int hud_rows_override;
   bool hud_show_health_strip;
   bool hud_show_source_labels;
   bool hud_verbose_proof;
   bool hud_parity_diagnostics_enabled;
   string browse_main_bucket_filter;
   string browse_stock_family_filter;
   string browse_stock_sector_filter;
   string browse_stock_industry_filter;

   // Market Board / Current Focus / Dossier
   int board_top_n;
   bool board_show_freshness;
   bool board_show_classification;
   bool current_focus_show_classification;
   bool current_focus_show_freshness;
   bool dossier_show_identity;
   bool dossier_show_market_state;
   bool dossier_show_freshness;
   bool dossier_show_classification;
   bool dossier_show_deep_selective_analysis;

   // Market State
   int l1_tick_freshness_sec;
   int l1_stale_age_sec;
   int l1_recheck_open_sec;
   int l1_recheck_closed_sec;
   int l1_recheck_uncertain_sec;
   int l1_recheck_unknown_sec;
   int l1_confirmation_retry_cap;
   int l1_warmup_unknown_max;
   int l1_warmup_uncertain_max;
   int l1_ready_unknown_max;
   int l1_ready_uncertain_max;
   int l1_stale_symbol_max;

   // Deep Selective Analysis controls (0 = manual-only)
   int deep_tf_m1_bars;
   int deep_tf_m5_bars;
   int deep_tf_m15_bars;
   int deep_tf_h1_bars;
   int deep_tf_h4_bars;
   int deep_tf_d1_bars;
   int deep_recent_tick_window;
   int deep_rolling_spread_window;

   // Advanced controls
   int scan_budget_symbols;
   int l1_packet_target;
   int l1_burst_max_per_heartbeat;
   int write_budget_artifacts;
   int write_starvation_beats;
   int partial_write_min_assessed;
   int l1_partial_write_beats;
  };

ASC_TraderControls g_asc_trader_controls;

void ASC_DefaultTraderControls(ASC_TraderControls &controls)
  {
   controls.hud_enabled = ASC_HUD_ENABLED_DEFAULT;
   controls.hud_density_mode = 1;
   controls.hud_rows_override = 0;
   controls.hud_show_health_strip = true;
   controls.hud_show_source_labels = true;
   controls.hud_verbose_proof = false;
   controls.hud_parity_diagnostics_enabled = false;
   controls.browse_main_bucket_filter = "all";
   controls.browse_stock_family_filter = "all";
   controls.browse_stock_sector_filter = "all";
   controls.browse_stock_industry_filter = "all";

   controls.board_top_n = 10;
   controls.board_show_freshness = true;
   controls.board_show_classification = true;
   controls.current_focus_show_classification = true;
   controls.current_focus_show_freshness = true;
   controls.dossier_show_identity = true;
   controls.dossier_show_market_state = true;
   controls.dossier_show_freshness = true;
   controls.dossier_show_classification = true;
   controls.dossier_show_deep_selective_analysis = true;

   controls.l1_tick_freshness_sec = ASC_L1_TICK_FRESHNESS_SEC;
   controls.l1_stale_age_sec = ASC_L1_STALE_AGE_SEC;
   controls.l1_recheck_open_sec = ASC_L1_RECHECK_OPEN_SEC;
   controls.l1_recheck_closed_sec = ASC_L1_RECHECK_CLOSED_SEC;
   controls.l1_recheck_uncertain_sec = ASC_L1_RECHECK_UNCERTAIN_SEC;
   controls.l1_recheck_unknown_sec = ASC_L1_RECHECK_UNKNOWN_SEC;
   controls.l1_confirmation_retry_cap = ASC_L1_CONFIRMATION_RETRY_CAP;
   controls.l1_warmup_unknown_max = ASC_L1_WARMUP_UNKNOWN_MAX;
   controls.l1_warmup_uncertain_max = ASC_L1_WARMUP_UNCERTAIN_MAX;
   controls.l1_ready_unknown_max = ASC_L1_READY_UNKNOWN_MAX;
   controls.l1_ready_uncertain_max = ASC_L1_READY_UNCERTAIN_MAX;
   controls.l1_stale_symbol_max = ASC_L1_STALE_SYMBOL_MAX;

   controls.deep_tf_m1_bars = 350;
   controls.deep_tf_m5_bars = 350;
   controls.deep_tf_m15_bars = 350;
   controls.deep_tf_h1_bars = 150;
   controls.deep_tf_h4_bars = 150;
   controls.deep_tf_d1_bars = 150;
   controls.deep_recent_tick_window = 128;
   controls.deep_rolling_spread_window = 64;

   controls.scan_budget_symbols = ASC_SCAN_SYMBOL_BUDGET;
   controls.l1_packet_target = ASC_L1_BROAD_PACKET_TARGET;
   controls.l1_burst_max_per_heartbeat = ASC_L1_BURST_MAX_PER_HEARTBEAT;
   controls.write_budget_artifacts = ASC_WRITE_ARTIFACT_BUDGET;
   controls.write_starvation_beats = ASC_WRITE_STARVATION_BEATS;
   controls.partial_write_min_assessed = ASC_PARTIAL_WRITE_MIN_ASSESSED;
   controls.l1_partial_write_beats = ASC_L1_PARTIAL_WRITE_BEATS;
  }

int ASC_ClampInt(const int value,const int min_value,const int max_value)
  {
   if(value < min_value)
      return min_value;
   if(value > max_value)
      return max_value;
  return value;
  }

string ASC_NormalizeBrowseFilterToken(const string raw)
  {
   string token = raw;
   StringTrimLeft(token);
   StringTrimRight(token);
   StringToLower(token);
   StringReplace(token, " ", "_");
   StringReplace(token, "-", "_");
   StringReplace(token, "/", "_");
   while(StringFind(token, "__") >= 0)
      StringReplace(token, "__", "_");

   if(token == "stock_family_needs_review"
      || token == "stock_sector_needs_review"
      || token == "stock_industry_needs_review")
      token = "needs_review";
   else if(token == "funds/etfs" || token == "funds_etf" || token == "funds_etfs")
      token = "funds_etfs";

   if(StringLen(token) <= 0)
      token = "all";
   return token;
  }

void ASC_NormalizeTraderControls(ASC_TraderControls &controls)
  {
   controls.hud_density_mode = ASC_ClampInt(controls.hud_density_mode, 0, 2);
   controls.hud_rows_override = ASC_ClampInt(controls.hud_rows_override, 0, 24);
   controls.browse_main_bucket_filter = ASC_NormalizeBrowseFilterToken(controls.browse_main_bucket_filter);
   controls.browse_stock_family_filter = ASC_NormalizeBrowseFilterToken(controls.browse_stock_family_filter);
   controls.browse_stock_sector_filter = ASC_NormalizeBrowseFilterToken(controls.browse_stock_sector_filter);
   controls.browse_stock_industry_filter = ASC_NormalizeBrowseFilterToken(controls.browse_stock_industry_filter);

   controls.board_top_n = ASC_ClampInt(controls.board_top_n, 0, 50);

   controls.l1_tick_freshness_sec = ASC_ClampInt(controls.l1_tick_freshness_sec, 5, 1800);
   controls.l1_stale_age_sec = ASC_ClampInt(controls.l1_stale_age_sec, 30, 7200);
   controls.l1_recheck_open_sec = ASC_ClampInt(controls.l1_recheck_open_sec, 5, 1800);
   controls.l1_recheck_closed_sec = ASC_ClampInt(controls.l1_recheck_closed_sec, 5, 3600);
   controls.l1_recheck_uncertain_sec = ASC_ClampInt(controls.l1_recheck_uncertain_sec, 1, 600);
   controls.l1_recheck_unknown_sec = ASC_ClampInt(controls.l1_recheck_unknown_sec, 1, 300);
   controls.l1_confirmation_retry_cap = ASC_ClampInt(controls.l1_confirmation_retry_cap, 1, 10);
   controls.l1_warmup_unknown_max = ASC_ClampInt(controls.l1_warmup_unknown_max, 0, 2000);
   controls.l1_warmup_uncertain_max = ASC_ClampInt(controls.l1_warmup_uncertain_max, 0, 2000);
   controls.l1_ready_unknown_max = ASC_ClampInt(controls.l1_ready_unknown_max, 0, 2000);
   controls.l1_ready_uncertain_max = ASC_ClampInt(controls.l1_ready_uncertain_max, 0, 2000);
   controls.l1_stale_symbol_max = ASC_ClampInt(controls.l1_stale_symbol_max, 0, 2000);

   controls.deep_tf_m1_bars = ASC_ClampInt(controls.deep_tf_m1_bars, 0, 5000);
   controls.deep_tf_m5_bars = ASC_ClampInt(controls.deep_tf_m5_bars, 0, 5000);
   controls.deep_tf_m15_bars = ASC_ClampInt(controls.deep_tf_m15_bars, 0, 5000);
   controls.deep_tf_h1_bars = ASC_ClampInt(controls.deep_tf_h1_bars, 0, 5000);
   controls.deep_tf_h4_bars = ASC_ClampInt(controls.deep_tf_h4_bars, 0, 5000);
   controls.deep_tf_d1_bars = ASC_ClampInt(controls.deep_tf_d1_bars, 0, 5000);
   controls.deep_recent_tick_window = ASC_ClampInt(controls.deep_recent_tick_window, 1, 2048);
   controls.deep_rolling_spread_window = ASC_ClampInt(controls.deep_rolling_spread_window, 1, 2048);

   controls.scan_budget_symbols = ASC_ClampInt(controls.scan_budget_symbols, 8, 4096);
   controls.l1_packet_target = ASC_ClampInt(controls.l1_packet_target, 8, 4096);
   controls.l1_burst_max_per_heartbeat = ASC_ClampInt(controls.l1_burst_max_per_heartbeat, 1, 16);
   controls.write_budget_artifacts = ASC_ClampInt(controls.write_budget_artifacts, 1, 512);
   controls.write_starvation_beats = ASC_ClampInt(controls.write_starvation_beats, 1, 20);
   controls.partial_write_min_assessed = ASC_ClampInt(controls.partial_write_min_assessed, 1, 4096);
   controls.l1_partial_write_beats = ASC_ClampInt(controls.l1_partial_write_beats, 1, 20);
  }

void ASC_ApplyTraderControls(const ASC_TraderControls &controls)
  {
   g_asc_trader_controls = controls;
  }

int ASC_DeepEnabledTimeframeCount()
  {
   int enabled = 0;
   if(g_asc_trader_controls.deep_tf_m1_bars > 0) enabled++;
   if(g_asc_trader_controls.deep_tf_m5_bars > 0) enabled++;
   if(g_asc_trader_controls.deep_tf_m15_bars > 0) enabled++;
   if(g_asc_trader_controls.deep_tf_h1_bars > 0) enabled++;
   if(g_asc_trader_controls.deep_tf_h4_bars > 0) enabled++;
   if(g_asc_trader_controls.deep_tf_d1_bars > 0) enabled++;
   return enabled;
  }

#endif
