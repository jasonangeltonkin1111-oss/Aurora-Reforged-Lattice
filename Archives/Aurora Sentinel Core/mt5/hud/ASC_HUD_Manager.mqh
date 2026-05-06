#ifndef __ASC_HUD_MANAGER_MQH__
#define __ASC_HUD_MANAGER_MQH__

#include "../core/ASC_RuntimeState.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh"
#include "../menu/ASC_TraderControlRegistry.mqh"
#include "../runtime/ASC_ServerPaths.mqh"
#include "../logging/ASC_Logging.mqh"
#include "../io/ASC_FileIO.mqh"
#include "../symbols/ASC_SymbolSpecification.mqh"
#include "../artifacts/ASC_ConsumerVisibilityProof.mqh"

#define ASC_HUD_PREFIX "ASC_HUD::"
#define ASC_HUD_ROW_SLOTS 20
#define ASC_HUD_HISTORY_LIMIT 24
#define ASC_HUD_HEADER_H 74
#define ASC_HUD_TOPNAV_H 30
#define ASC_HUD_BREADCRUMB_H 24
#define ASC_HUD_ACTION_H 26
#define ASC_HUD_SHELL_GAP 3
#define ASC_HUD_CONTENT_GAP 4
#define ASC_HUD_LIST_HEAD_H 78
#define ASC_HUD_LIST_ROWS_GAP 6
#define ASC_HUD_FOOTER_H 26
#define ASC_HUD_RESIZE_DEBOUNCE_MS 220
#define ASC_HUD_RESIZE_DEBOUNCE_HEARTBEATS 1
#define ASC_HUD_VIEWPORT_JITTER_PX 2
#define ASC_HUD_TRANSITION_GUARD_STRICT_MS 450
#define ASC_HUD_TRANSITION_GUARD_NAV_MS 180
#define ASC_HUD_CURRENT_FOCUS_CACHE_STALE_SEC 1
#define ASC_HUD_CURRENT_FOCUS_CACHE_MAX_STALE_SEC 2
#define ASC_HUD_PROOF_HF_HEARTBEAT_LIGHT 120
#define ASC_HUD_PROOF_HF_HEARTBEAT_VERBOSE 60
#define ASC_HUD_CLOCK_REFRESH_HEARTBEATS 1
#define ASC_HUD_SHORTLIST_SIGNATURE_RECHECK_HEARTBEATS 15
#define ASC_HUD_FAST_DISPLAY_REFRESH_MS 150
#define ASC_HUD_PARITY_DIAG_RECHECK_HEARTBEATS 30
#define ASC_HUD_STRUCTURE_RECHECK_LIGHT_HEARTBEATS 3
#define ASC_HUD_DATA_RECHECK_LIGHT_HEARTBEATS 2
#define ASC_HUD_TACTICAL_RECHECK_LIGHT_HEARTBEATS 2

enum ASC_HudPage
  {
   ASC_HUD_PAGE_OVERVIEW = 0,
   ASC_HUD_PAGE_MAIN_BUCKETS = 1,
   ASC_HUD_PAGE_BUCKET_LEADERS = 2,
   ASC_HUD_PAGE_SUB_GROUPS = 3,
   ASC_HUD_PAGE_SYMBOLS = 4,
   ASC_HUD_PAGE_SYMBOL_OVERVIEW = 5,
   ASC_HUD_PAGE_ASPECT_DETAIL = 6,
   ASC_HUD_PAGE_GLOBAL_TOP10 = 7
  };

enum ASC_HudStatView
  {
   ASC_HUD_STAT_NONE = 0,
   ASC_HUD_STAT_MARKET_ACTION = 1,
   ASC_HUD_STAT_TRADING_CONDITIONS = 2,
   ASC_HUD_STAT_MARKET_CONTEXT = 3,
   ASC_HUD_STAT_DEEP_ANALYSIS = 4,
   ASC_HUD_STAT_ACCOUNT_TRADE_CONTEXT = 5,
   ASC_HUD_STAT_PUBLICATION_RESULT_STATUS = 6
  };

enum ASC_HudSymbolSectionFamily
  {
   ASC_HUD_SYMBOL_SECTION_OVERVIEW = 0,
   ASC_HUD_SYMBOL_SECTION_MARKET_WATCH = 1,
   ASC_HUD_SYMBOL_SECTION_SPECIFICATION = 2,
   ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER = 3,
   ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT = 4,
   ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS = 5,
   ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_A = 6,
   ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_B = 7
  };

enum ASC_HudDeepSubPage
  {
   ASC_HUD_DEEP_SUBPAGE_THESIS = 0,
   ASC_HUD_DEEP_SUBPAGE_TIMING = 1,
   ASC_HUD_DEEP_SUBPAGE_STRUCTURE = 2,
   ASC_HUD_DEEP_SUBPAGE_EXECUTION = 3,
   ASC_HUD_DEEP_SUBPAGE_TIMEFRAMES = 4
  };

struct ASC_HudBucketRow
  {
   string id;
   string name;
   int total;
   int open_count;
   int closed_count;
   int uncertain_count;
   int unresolved_count;
   int canonical_global_order;
  };

struct ASC_HudSubBucketRow
  {
   string key;
   string sub_bucket_id;
   string bucket_id;
   string name;
   string source;
   int total;
   int open_count;
   int eligible_count;
   int canonical_bucket_order;
  };

enum ASC_HudBrowseNodeTier
  {
   ASC_HUD_BROWSE_MAIN_BUCKET = 0,
   ASC_HUD_BROWSE_STOCK_FAMILY = 1,
   ASC_HUD_BROWSE_STOCK_SECTOR = 2,
   ASC_HUD_BROWSE_STOCK_INDUSTRY = 3
  };

struct ASC_HudBrowseNode
  {
   string key;
   string parent_key;
   ASC_HudBrowseNodeTier tier;
   string id;
   string label;
   string source;
   int total;
   int open_count;
   int eligible_count;
   int first_child_slot;
   int last_child_slot;
   int next_sibling_slot;
   int canonical_scope_order;
  };

struct ASC_HudScopeRankingStats
  {
   int promoted_count;
   int ranked_count;
   int top_rank;
   double top_score;
   bool ranked_available;
  };

struct ASC_HudScopeRankingCacheEntry
  {
   string scope_key;
   ASC_HudScopeRankingStats stats;
  };

struct ASC_HudCanonicalAggregateMetrics
  {
   int best_global_rank;
   int best_bucket_rank;
   int best_raw_rank;
   int promoted_count;
   int ranked_count;
  };

enum ASC_HudRenderScope
  {
   ASC_HUD_SCOPE_NONE = 0,
   ASC_HUD_SCOPE_OVERVIEW = 1,
   ASC_HUD_SCOPE_LIST = 2,
   ASC_HUD_SCOPE_SYMBOL_OVERVIEW = 3,
   ASC_HUD_SCOPE_STAT_DETAIL = 4
  };

string ASC_HudRenderScopeName(const ASC_HudRenderScope scope)
  {
   switch(scope)
     {
      case ASC_HUD_SCOPE_NONE: return "none";
      case ASC_HUD_SCOPE_OVERVIEW: return "overview";
      case ASC_HUD_SCOPE_LIST: return "list";
      case ASC_HUD_SCOPE_SYMBOL_OVERVIEW: return "symbol_overview";
      case ASC_HUD_SCOPE_STAT_DETAIL: return "stat_detail";
     }
   return "unknown";
  }

enum ASC_HudNavigationDirtyFlag
  {
   ASC_HUD_NAV_DIRTY_NONE = 0,
   ASC_HUD_NAV_DIRTY_LIST = 1,
   ASC_HUD_NAV_DIRTY_PAGE = 2,
   ASC_HUD_NAV_DIRTY_SYMBOL = 4,
   ASC_HUD_NAV_DIRTY_DETAIL = 8
  };

struct ASC_HudObjectCacheEntry
  {
   string name;
   string signature;
   int object_type;
  };

struct ASC_HudPageCommandSurface
  {
   ASC_HudPage page;
   bool scope_refresh_ready;
   bool shortlist_refresh_ready;
   bool dedicated_top10_route_ready;
   bool visible_in_current_run;
   bool board_refresh_path_ready;
   string primary_command_label;
   string secondary_command_label;
   string authority_note;
   string rollout_note;
  };

struct ASC_HudRankSurfaceReadback
  {
   bool diversified_global_available;
   bool main_bucket_available;
   bool sub_bucket_available;
   bool full_field_available;
   string diversified_global_rank;
   string main_bucket_rank;
   string sub_bucket_rank;
   string full_field_rank;
   string owner_path;
   string owner_state_note;
  };

struct ASC_HudLookupEntry
  {
   string key;
   int index;
  };

struct ASC_HudPreparedSelectionRow
  {
   int layer1_index;
   ASC_Layer1SymbolState state;
   ASC_ShortlistSymbolSummary shortlist_entry;
   bool shortlist_found;
   int canonical_scope_rank;
   int canonical_global_rank;
   int canonical_raw_rank;
   string symbol_key;
  };

enum ASC_HudLeaderRowVisibilityState
  {
   ASC_HUD_LEADER_ROW_NOT_ADMITTED = 0,
   ASC_HUD_LEADER_ROW_PACKET_READY_VISIBLE = 1,
   ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE = 2,
   ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE = 3,
   ASC_HUD_LEADER_ROW_HIDDEN_BY_RULE = 4,
   ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE = 5
  };

struct ASC_HudLeaderTruthAudit
  {
   string shortlist_source;
   ulong shortlist_revision;
   datetime shortlist_pass_utc;
   ulong shortlist_signature_revision;
   datetime shortlist_signature_pass_utc;
   int bucket_admitted_count;
   int packet_ready_count;
   int packet_warmup_count;
   int hud_visible_count;
   int retained_last_good_count;
   int hidden_by_rule_count;
   int unavailable_market_watch_count;
   int anchor_unavailable_count;
   int snapshot_mismatch_count;
   ulong row_l2_max_revision;
   datetime row_l3_eval_latest_utc;
   string empty_state_cause;
   string trace_summary;
  };

struct ASC_HudState
  {
   bool initialized;
   bool visible;
   bool dirty;
   bool dirty_layout;
   bool dirty_data_light;
   bool dirty_data_heavy;
   bool queued_heavy_refresh;
   string queued_heavy_refresh_reason;
   bool dirty_navigation;
   int dirty_navigation_flags;
   bool has_summary;
   ASC_HudPage page;
   ASC_HudPage history_pages[ASC_HUD_HISTORY_LIMIT];
   string history_bucket[ASC_HUD_HISTORY_LIMIT];
   string history_sub_bucket[ASC_HUD_HISTORY_LIMIT];
   string history_browse_parent[ASC_HUD_HISTORY_LIMIT];
   string history_browse_node[ASC_HUD_HISTORY_LIMIT];
   string history_symbol[ASC_HUD_HISTORY_LIMIT];
   int history_offset[ASC_HUD_HISTORY_LIMIT];
   ASC_HudStatView history_stat[ASC_HUD_HISTORY_LIMIT];
   ASC_HudSymbolSectionFamily history_section[ASC_HUD_HISTORY_LIMIT];
   ASC_HudDeepSubPage history_deep_subpage[ASC_HUD_HISTORY_LIMIT];
   int history_count;
   ASC_HudPage forward_pages[ASC_HUD_HISTORY_LIMIT];
   string forward_bucket[ASC_HUD_HISTORY_LIMIT];
   string forward_sub_bucket[ASC_HUD_HISTORY_LIMIT];
   string forward_browse_parent[ASC_HUD_HISTORY_LIMIT];
   string forward_browse_node[ASC_HUD_HISTORY_LIMIT];
   string forward_symbol[ASC_HUD_HISTORY_LIMIT];
   int forward_offset[ASC_HUD_HISTORY_LIMIT];
   ASC_HudStatView forward_stat[ASC_HUD_HISTORY_LIMIT];
   ASC_HudSymbolSectionFamily forward_section[ASC_HUD_HISTORY_LIMIT];
   ASC_HudDeepSubPage forward_deep_subpage[ASC_HUD_HISTORY_LIMIT];
   int forward_count;

   string selected_bucket_id;
   string selected_sub_bucket_key;
   string selected_browse_parent_key;
   string selected_browse_node_key;
   string selected_symbol;
   int selected_symbol_layer1_index;
   ulong selected_symbol_layer1_revision;
   ASC_HudStatView selected_stat;
   ASC_HudSymbolSectionFamily selected_symbol_section;
   ASC_HudDeepSubPage selected_deep_subpage;
   int list_offset;

   ASC_Layer1PassSummary latest_summary;
   bool bootstrap_active;
   int live_entitled_count;
   int retention_only_count;
   int dossier_shell_presence_count;
   int dossier_rich_presence_count;
   ASC_HudBucketRow buckets[];
   ASC_HudSubBucketRow sub_buckets[];
   ASC_HudLookupEntry sub_bucket_lookup[];
   ASC_HudBrowseNode browse_nodes[];
   ASC_HudLookupEntry browse_node_lookup[];
   int leader_row_indices[];
   int symbol_indices[];
   int visible_bucket_slot_indices[];
   int visible_subgroup_slot_indices[];
   int visible_symbol_slot_indices[];
   int visible_leader_slot_indices[];
   ASC_HudCanonicalAggregateMetrics canonical_bucket_metrics[];
   ASC_HudLookupEntry canonical_bucket_metric_lookup[];
   ASC_HudCanonicalAggregateMetrics canonical_subgroup_metrics[];
   ASC_HudLookupEntry canonical_subgroup_metric_lookup[];
   ASC_HudCanonicalAggregateMetrics canonical_browse_metrics[];
   ASC_HudLookupEntry canonical_browse_metric_lookup[];
   bool visible_subgroup_slots_use_browse_nodes;
   ASC_HudPage visible_slot_map_page;
   string visible_slot_map_scope_signature;
   string visible_slot_map_filter_signature;
   string visible_slot_map_shortlist_signature;
   string selected_symbol_list_key;
   string selected_symbol_list_filter_signature;
   ulong selected_symbol_list_revision;
   ulong selected_symbol_list_shortlist_revision;

   string last_data_signature;
   string last_structure_signature;
   string last_tactical_signature;
   uint last_data_fingerprint;
   uint last_structure_fingerprint;
   uint last_tactical_fingerprint;
   string last_shortlist_signature;
   string last_shortlist_signature_source;
   ulong last_shortlist_signature_revision;
   datetime last_shortlist_signature_pass_utc;
   int last_shortlist_signature_count;
   string shortlist_order_hash_scope_key;
   ASC_HudPage shortlist_order_hash_page;
   string shortlist_order_hash_source;
   ulong shortlist_order_hash_revision;
   datetime shortlist_order_hash_pass_utc;
   int shortlist_order_hash_count;
   uint shortlist_order_hash_value;
   string shortlist_order_hash_signature;
   string last_shortlist_source;
   ulong last_shortlist_revision;
   datetime last_shortlist_pass_utc;
   int last_shortlist_count;
   int render_id;
   int objects_touched;
   int row_count;
   datetime last_render_utc;
   string transient_notice;
   datetime transient_notice_until;
   bool deep_trigger_pending;
   string deep_trigger_symbol;
   datetime deep_trigger_requested_utc;
   string deep_trigger_last_status;
   datetime deep_trigger_last_served_utc;
   string deep_trigger_runtime_reason;
   bool deep_change_seeded;
   string deep_change_refresh_key;
   string deep_change_last_summary;
   string deep_change_pressure;
   string deep_change_momentum;
   string deep_change_move_age;
   string deep_change_participation;
   string deep_change_execution;
   string deep_change_liquidity;
   string deep_change_timeframes;
   string deep_change_trigger;
   string current_focus_runtime_status;
   string current_focus_runtime_reason;
   string current_focus_runtime_live_symbol;
   datetime current_focus_runtime_last_served_utc;
   string current_focus_cache_text;
   datetime current_focus_cache_last_read_utc;
   datetime current_focus_cache_last_modified_utc;
   string current_focus_cache_state;
   string current_focus_cache_posture;
   bool current_focus_refresh_deferred;
   string current_focus_refresh_deferred_reason;
   datetime current_focus_refresh_deferred_utc;
   string view_model_page_type;
   string view_model_bucket;
   string view_model_sub_bucket;
   string view_model_selected_symbol;
   string view_model_selected_display_name;
   string view_model_market_state_label;
   string view_model_actionable_posture_label;
   string view_model_currentness_label;
   string view_model_current_focus_summary;
   string view_model_market_board_summary;
   string view_model_cache_posture;
   string view_model_version;
   uint view_model_last_built_ms;
   bool view_model_cache_hit;
   bool view_model_cache_miss;
   string view_model_dirty_reason;
   string cf_vm_symbol;
   string cf_vm_canonical;
   string cf_vm_deep_posture;
   string cf_vm_deep_summary;
   string cf_vm_score_context;
   string cf_vm_microstructure;
   string cf_vm_refresh_request_id;
   string cf_vm_published;
   bool cf_vm_completed_truth;
   string cf_vm_sweep_state;
   string cf_vm_bias_summary;
   string cf_vm_deep_readiness_summary;
   string cf_vm_timeframe_preview;
   int cf_vm_timeframe_row_count;
   string cf_vm_timeframe_rows[];
   ASC_HudPage last_rendered_page;
   string last_rendered_symbol;
   ASC_HudStatView last_rendered_stat;
   int viewport_w;
   int viewport_h;
   int viewport_pending_w;
   int viewport_pending_h;
   int viewport_committed_w;
   int viewport_committed_h;
   int list_slots_visible;
   int list_total_items;
   int list_total_pages;
   int list_current_page;
   int list_range_start;
   int list_range_end;
   int list_row_h_effective;
   int list_row_spacing_effective;
   int list_pack_remainder_px;
   int list_body_h;
   int list_body_w;
   datetime transition_until;
   uint transition_guard_until_ms;
   bool transition_guard_strict;
   string transition_label;
   ASC_HudPage transition_from;
   ASC_HudPage transition_to;
   bool pending_navigation_transition;
   string pending_navigation_label;
   datetime pending_navigation_requested_utc;
   string pending_navigation_reason;
   ASC_HudPage pending_navigation_target_page;
   string pending_navigation_target_symbol;
   bool hud_click_acknowledged;
   string hud_ack_label;
   bool hud_pending_render;
   string hud_pending_target_page;
   string hud_pending_target_symbol;
   string hud_deferred_render_reason;
   bool current_focus_sync_deferred;
   string current_focus_sync_deferred_symbol;
   datetime current_focus_sync_deferred_utc;
   bool queued_nav_click_pending;
   string queued_nav_click_control;
   datetime queued_nav_click_utc;
   ASC_HudRenderScope last_render_scope;
   ASC_HudObjectCacheEntry object_cache[];
   string object_cache_index_keys[];
   int object_cache_index_slots[];
   int object_cache_index_capacity;
   int object_cache_index_count;
   int render_mutations;
   bool redraw_pending;
   string last_render_context_signature;
   string last_render_snapshot_signature;
   int proof_snapshot_skip_count;
   int telemetry_render_enter_count;
   int telemetry_render_full_count;
   int telemetry_render_partial_count;
   int telemetry_render_skip_count;
   uint telemetry_render_elapsed_last_ms;
   uint telemetry_render_elapsed_max_ms;
   int telemetry_page_change_request_count;
   int telemetry_page_change_commit_count;
   uint telemetry_page_change_commit_elapsed_last_ms;
   uint telemetry_page_change_commit_elapsed_max_ms;
   uint telemetry_page_change_request_started_ms;
   ASC_HudPage telemetry_page_change_request_target;
   int telemetry_object_set_attempt_count;
   int telemetry_object_set_changed_count;
   int telemetry_object_set_noop_count;
   int telemetry_viewport_full_delete_count;
   uint telemetry_redraw_flush_elapsed_last_ms;
   uint telemetry_redraw_flush_elapsed_max_ms;
   int rebuild_tracked_symbols;
   int rebuild_assigned_symbols;
   int rebuild_fallback_symbols;
   int rebuild_lost_symbols;
   ulong last_rebuild_revision;
   string last_rebuild_sub_bucket_key;
   string last_leaders_bucket_id;
   string last_leaders_shortlist_signature;
   ASC_HudLeaderTruthAudit leader_truth_audit;
   int proof_full_rebuild_count;
   int proof_symbol_list_rebuild_count;
   int proof_render_pass_count;
   int proof_full_redraw_count;
   int proof_page_change_render_count;
   int proof_transition_window_active_beats;
   int proof_transition_lock_skip_count;
   int proof_object_create_total;
   int proof_object_delete_total;
   int proof_text_write_total;
   int proof_style_write_total;
   int proof_cycle_object_creates;
   int proof_cycle_object_deletes;
   int proof_cycle_text_writes;
   int proof_cycle_style_writes;
   int proof_cycle_redraws;
   int proof_object_cache_hit_count;
   int proof_object_cache_miss_count;
   int proof_object_text_skipped_same_count;
   int proof_object_style_skipped_same_count;
   int proof_object_visibility_skipped_same_count;
   int proof_object_property_read_count;
   int proof_object_find_count;
   int proof_object_delete_all_count;
   int proof_object_delete_single_count;
   int proof_object_delete_scoped_count;
   int proof_redraw_request_count;
   int proof_redraw_flush_count;
   int proof_redraw_suppressed_no_mutation_count;
   int hud_obj_set_skipped;
   int hud_obj_set_changed;
   int hud_obj_create_reused;
   int hud_obj_delete_avoided;
   int hud_scoped_hide_count;
   int hud_redraw_avoided;
   int hud_clock_minimal_update;
   int hud_full_render_avoided;
   int hud_viewport_reset_avoided;
   int hud_viewport_jitter_ignored;
   int hud_layout_dirty_skipped;
   int hud_transition_rebuild_avoided;
   string hud_full_reset_reason;
   int hud_layout_commit_count;
   int hud_transition_commit_count;
   int proof_last_render_mutation_count;
   double proof_last_render_object_cache_hit_ratio;
   string proof_last_render_scope;
   string proof_last_render_reason;
   int proof_nav_click_count;
   int proof_nav_ack_count;
   int proof_priority_render_count;
   int proof_priority_service_skip_count;
   string proof_priority_service_skip_reason;
   int proof_nav_fast_path_count;
   int proof_nav_slow_path_count;
   int proof_hud_file_read_count;
   int proof_current_focus_read_count;
   int hud_nav_file_reads;
   int hud_nav_current_focus_reads;
   int hud_nav_dossier_reads;
   int hud_nav_market_board_reads;
   int hud_nav_large_parse_count;
   int hud_nav_cache_hit_count;
   int hud_nav_cache_miss_count;
   int hud_nav_cache_deferred_count;
   int hud_background_cache_read_count;
   int hud_manual_cache_read_count;
   int hud_current_focus_cache_read_count;
   int hud_current_focus_file_read_count;
   int hud_deep_parse_attempt_count;
   uint hud_deep_parse_elapsed_last_ms;
   uint hud_deep_parse_elapsed_max_ms;
   int hud_view_model_hit_count;
   int hud_view_model_miss_count;
   uint hud_view_model_build_ms;
   string hud_view_model_dirty_reason;
   int hud_cache_stale_display_count;
   int hud_cache_placeholder_display_count;
   int hud_click_file_read_blocked_count;
   int hud_priority_cache_only_count;
   int current_focus_refresh_deferred_count;
   int current_focus_cache_stale_count;
   int deep_parse_deferred_count;
   int hud_cache_refresh_pending_count;
   uint hud_priority_render_last_ms;
   uint proof_last_click_to_ack_ms;
   uint proof_last_click_handler_total_ms;
   uint proof_last_deferred_render_wait_ms;
   uint proof_last_deferred_render_ms;
   bool proof_last_artifact_sync_deferred;
   bool proof_last_ordinary_navigation_fast_path;
   string proof_last_control_class;
   string proof_last_target_page;
   string proof_last_target_symbol;
   uint proof_last_render_build_ms;
   uint proof_last_chart_redraw_ms;
   uint proof_last_transition_total_ms;
   uint proof_last_object_update_ms;
   int proof_last_render_objects_created;
   int proof_last_render_objects_updated;
   int proof_last_render_objects_deleted;
   int proof_last_render_redraws;
   int proof_tactical_refresh_count;
   int proof_tactical_attempt_count;
   int proof_clock_refresh_count;
   int proof_clock_update_attempt_count;
   int proof_clock_label_change_success_count;
   int proof_clock_redraw_requested_count;
   int proof_clock_skipped_due_cadence_count;
   datetime proof_clock_last_attempt_utc;
   datetime proof_clock_last_success_utc;
   string proof_clock_last_visible_text_token;
   int proof_clock_elapsed_since_last_success_sec;
   int proof_selection_refresh_count;
   int proof_shortlist_refresh_count;
   int proof_full_analysis_refresh_count;
   int proof_refresh_request_seq;
   int proof_tactical_stall_beats;
   int proof_clock_stall_beats;
   datetime proof_last_log_utc;
   datetime last_tactical_refresh_utc;
   int proof_last_tactical_heartbeat_counter;
   int proof_last_logged_full_rebuild_count;
   int proof_last_logged_symbol_list_rebuild_count;
   int proof_last_logged_render_pass_count;
   int proof_last_logged_full_redraw_count;
   int proof_last_logged_transition_window_active_beats;
   int proof_last_logged_transition_lock_skip_count;
   int proof_last_logged_object_create_total;
   int proof_last_logged_object_delete_total;
   int proof_last_logged_text_write_total;
   int proof_last_logged_style_write_total;
   int proof_last_logged_tactical_refresh_count;
   int proof_last_logged_tactical_attempt_count;
   int proof_last_logged_clock_refresh_count;
   int proof_last_logged_clock_update_attempt_count;
   int proof_last_logged_clock_label_change_success_count;
   int proof_last_logged_clock_redraw_requested_count;
   int proof_last_logged_clock_skipped_due_cadence_count;
   datetime proof_last_logged_clock_last_attempt_utc;
   string proof_last_logged_clock_last_visible_text_token;
   int proof_last_logged_clock_elapsed_since_last_success_sec;
   int proof_last_logged_redraw_request_count;
   int proof_last_logged_redraw_flush_count;
   int proof_last_logged_redraw_suppressed_no_mutation_count;
   int proof_last_logged_tactical_stall_beats;
   int proof_last_logged_clock_stall_beats;
   bool proof_last_logged_summary_degraded;
   bool proof_last_logged_summary_stale;
   string proof_last_cycle_driver_summary;
   string proof_cached_high_frequency_summary;
   string proof_cached_low_frequency_summary;
   datetime proof_cached_low_frequency_built_utc;
   int hud_summary_build_skipped;
   int hud_summary_lowfreq_only;
   int proof_string_build_avoided;
   int proof_emit_gate_blocked;
   int hud_text_build_skipped;
   int hud_label_text_reused;
   int hud_label_set_skipped_text;
   int hud_row_text_cache_hit;
   int hud_status_text_cache_hit;
   int hud_clock_text_unchanged;
   int hud_render_string_build_avoided;
   int proof_scope_transition_count;
   int proof_scope_entry_list_count;
   int proof_scope_entry_symbol_count;
   int proof_footer_pager_visibility_changes;
   int proof_quick_actions_visibility_changes;
   int proof_symbol_lower_visibility_changes;
   int proof_list_family_visibility_changes;
   bool proof_footer_pager_visible;
   bool proof_quick_actions_visible;
   bool proof_symbol_lower_visible;
   bool proof_list_family_visible;
   bool overview_panels_hidden;
   bool list_panels_hidden;
   bool symbol_overview_panels_hidden;
   bool stat_panels_hidden;
   bool symbol_shared_hidden;
   bool symbols_scope_hidden;
   bool list_row_shell_prepared;
   int list_rows_rendered;
   string list_rows_render_signature;
   string market_watch_live_refresh_signature;
   datetime market_watch_live_last_log_utc;
   datetime market_watch_live_last_quote_utc;
   string market_watch_live_last_source;
   int proof_selected_symbol_live_refresh_count;
   datetime proof_last_selected_symbol_live_refresh_utc;
   int proof_fast_display_patch_count;
   int proof_fast_display_guard_reject_count;
   int parity_diag_structure_mismatch_count;
   int parity_diag_data_mismatch_count;
   int parity_diag_tactical_mismatch_count;
   int parity_diag_last_logged_heartbeat;
   uint fast_display_last_patch_ms;
   uint market_watch_live_last_patch_ms;
   bool market_watch_live_feed_active;
   string market_watch_live_feed_symbol;
   datetime market_watch_live_feed_started_utc;
   ASC_HudScopeRankingCacheEntry scope_ranking_cache[];
   string global_top10_cache_scope_key;
   string global_top10_cache_source;
   ulong global_top10_cache_revision;
   datetime global_top10_cache_pass_utc;
   int global_top10_cache_count;
   int global_top10_ordered_indices[];
   int global_top10_sort_buffer[];
   ASC_HudLookupEntry global_top10_dedupe_lookup[];
   bool chart_change_pending;
   uint chart_change_last_render_ms;
   bool resize_pending;
   bool resize_burst_active;
   bool resize_force_full_rebuild;
   uint resize_last_event_ms;
   int resize_last_event_heartbeat;
  };

ASC_HudState g_asc_hud;
ASC_ShortlistSymbolSummary g_asc_hud_shortlist_rows[];
datetime g_asc_hud_shortlist_cached_utc = 0;
ASC_HudLookupEntry g_asc_hud_shortlist_lookup[];
ulong g_asc_hud_shortlist_lookup_revision = 0;
ulong g_asc_hud_shortlist_lookup_built_revision = 0;
ASC_HudLookupEntry g_asc_hud_layer1_lookup[];
ulong g_asc_hud_layer1_lookup_built_revision = 0;
ASC_HudLookupEntry g_asc_hud_scope_ranking_lookup[];

ASC_HudSubBucketRow ASC_HudSelectedSubBucketRow(void);
bool ASC_HudDeepAnalysisEnabled(string &blocked_reason);
bool ASC_HudDeepActionContextReady(string &blocked_reason);
bool ASC_HudEmitCurrentFocusFromDeepTrigger(ASC_RuntimeState &runtime,string &notice_text);
bool ASC_HudSyncRuntimeSelectedSymbol(ASC_RuntimeState &runtime,const bool emit_log=true);
bool ASC_HudQueueViewedCurrentFocusSync(ASC_RuntimeState &runtime,const bool show_notice=false);
bool ASC_HudReadCurrentFocusCached(string &text,bool &used_stale_cache);
bool ASC_HudReadCurrentFocusFileCached(string &text,bool &used_stale_cache,const string access_class="background");
void ASC_HudMarkCurrentFocusRefreshDeferred(const string reason);
bool ASC_HudCurrentFocusNavigationSafe(string &text,bool &used_stale_cache);
void ASC_HudBuildCurrentFocusViewModel(const string text,const bool has_current_focus,const bool used_stale_cache);
void ASC_HudBuildNavigationViewModel(const ASC_RuntimeState &runtime,const string reason);
string ASC_HudExtractLabeledValue(const string text,const string label);
string ASC_HudCurrentFocusValue(const string text,const string label_a,const string label_b="",const string label_c="");
string ASC_HudDeepSummaryPreview(const string current_focus_text,const string fallback_label,const string primary_label,const string secondary_label="");
string ASC_HudDeepTacticalPreview(const string current_focus_text);
string ASC_HudDeepContextPreview(const string current_focus_text);
string ASC_HudTimeframeRowValueFirst(const string row,const string key_a,const string key_b="",const string key_c="");
bool ASC_HudExtractDeepTimeframeSection(const string current_focus_text,string &section);
void ASC_HudBuildDeepSectionViewModel(const string current_focus_text,
                                      string &timeframe_preview,
                                      string &bias_summary,
                                      string &readiness_summary,
                                      string &rows[],
                                      int &row_count);
string ASC_HudDeepBiasSummary(const string current_focus_text);
bool ASC_HudSelectedSymbolMatches(const ASC_Layer1SymbolState &candidate,const string symbol);
bool ASC_HudParityDiagnosticsEnabled();
void ASC_HudFlushParityDiagnostics(const int heartbeat_counter,const bool force_flush=false);
string ASC_HudSymbolSectionName(const ASC_HudSymbolSectionFamily section);
uint ASC_HudStructuralFingerprint(void);
uint ASC_HudPageLocalDataFingerprint(void);
uint ASC_HudDataFingerprint(void);
string ASC_HudPageLocalDataSignature(void);
uint ASC_HudTacticalFingerprint(void);
string ASC_HudTacticalSignature(void);
ASC_HudRenderScope ASC_HudRenderScopeForPage(const ASC_HudPage page);
void ASC_HudResetPanelsForScopeChange(const ASC_HudRenderScope from_scope,const ASC_HudRenderScope to_scope);
void ASC_HudAdoptRuntimeShortlistCache(const ASC_RuntimeState &runtime);
void ASC_HudEmitProofSummary(const ASC_RuntimeState &runtime,const bool rendered_now,const bool cadence_refresh);
bool ASC_HudRefreshSelectedSymbolTacticalFields();
bool ASC_HudRefreshSelectedSymbolMicroLive();
bool ASC_HudRefreshClockCadence(const int heartbeat_counter);
bool ASC_HudRefreshDisplayOnlyFastPath(const int heartbeat_counter,const bool from_chart_event);
void ASC_HudHideFooterPagerControls();
void ASC_HudHideSymbolQuickActionControls();
void ASC_HudHideSymbolLowerSectionControls();
void ASC_HudRebuildScopeRankingCache();
void ASC_HudTrackFamilyVisibility(bool &current,const bool next,int &counter);
bool ASC_HudMaterializeSymbolState(const int index,ASC_Layer1SymbolState &state);
void ASC_HudResetLookupCaches();
void ASC_HudInvalidateSelectedSymbolCache();
string ASC_HudNormalizeLookupKey(const string symbol);
void ASC_HudEnsureLookupCapacity(ASC_HudLookupEntry &rows[],const int required_size,const int reserve_step=64);
void ASC_HudEnsureIntArrayCapacity(int &rows[],const int required_size,const int reserve_step=64);
void ASC_HudSortLookupEntries(ASC_HudLookupEntry &rows[],const int left,const int right);
void ASC_HudInsertLookupEntrySorted(ASC_HudLookupEntry &rows[],const string key,const int index,const int reserve_step=64);
void ASC_HudCompactLookupEntries(ASC_HudLookupEntry &rows[]);
uint ASC_HudHashObjectCacheKey(const string name);
void ASC_HudEnsureObjectCacheIndexCapacity(const int target_count);
void ASC_HudInsertObjectCacheIndexEntry(const string name,const int slot);
string ASC_HudBrowseFilterSignature();
string ASC_HudRenderContextSignature();
string ASC_HudVisibleSnapshotSignature();
bool ASC_HudCanSkipRenderForUnchangedSnapshot();
bool ASC_HudCanApplyCommittedContextPatch();
bool ASC_HudCanApplyClockPatch();
string ASC_HudClockMetaText(const int heartbeat_counter,const datetime now_utc);
void ASC_HudTrackPageChangeRequest(const ASC_HudPage target_page);
string ASC_HudBuildCompactTelemetrySummary(const ASC_RuntimeState &runtime,const bool rendered_now,const bool cadence_refresh);
void ASC_HudClearDirtyFlags();
int ASC_HudFindLookupIndex(const ASC_HudLookupEntry &rows[],const string key);
void ASC_HudAddLookupAlias(ASC_HudLookupEntry &rows[],const string alias,const int index);
void ASC_HudEnsureShortlistLookupCache();
void ASC_HudEnsureLayer1LookupCache();
int ASC_HudResolveSelectedSymbolLayer1Index();
bool ASC_HudResolveShortlistLookup(const string symbol,ASC_ShortlistSymbolSummary &entry,int &rank_out,int &total_out);
bool ASC_HudPreparedRowComesBefore(const ASC_HudPreparedSelectionRow &left,const ASC_HudPreparedSelectionRow &right);
void ASC_HudSortPreparedSelectionRows(ASC_HudPreparedSelectionRow &rows[],const int left,const int right);
bool ASC_HudSetLabelTextIfExists(const string name,const string text);
void ASC_HudRequestRedraw();
void ASC_HudFlushPendingRedraw();
void ASC_HudRender(const ASC_RuntimeState &runtime);
bool ASC_HudPriorityServicePending();
bool ASC_HudServicePriorityNavigation(ASC_RuntimeState &runtime);
bool ASC_HudServiceDeferredCurrentFocusWork(ASC_RuntimeState &runtime,const bool allow_file_read,const string reason);
string ASC_HudClassifyControl(const string control_name);
bool ASC_HudControlIsOrdinaryNavigation(const string control_class);
void ASC_HudQueueNavigationIntent(const string label,const string reason,const string control_class);
void ASC_HudAckNavigationClick(const uint event_started_ms,const string label,const string reason,const string control_class);
void ASC_HudMarkCurrentFocusSyncDeferred(const string symbol);
void ASC_HudMarkDirtyLayout();
void ASC_HudMarkDirtyDataLight();
void ASC_HudMarkDirtyDataHeavy();
void ASC_HudQueueHeavyRefresh(const string reason);
void ASC_HudMarkDirtyNavigation(const int flags=ASC_HUD_NAV_DIRTY_PAGE);
int ASC_HudNavigationFlagsForPage(const ASC_HudPage page);
bool ASC_HudIsDirty();
void ASC_HudGoHome();
void ASC_HudGoBack();
void ASC_HudGoForward();
void ASC_HudOpenPage(const ASC_HudPage page);
void ASC_HudPagePrev();
void ASC_HudPageNext();
bool ASC_HudConsumeChartChangePending(const int heartbeat_counter);
bool ASC_HudViewportMaterialChange(const int old_w,const int old_h,const int new_w,const int new_h,bool &jitter_only);
bool ASC_HudPageNeedsHeavyDataset(const ASC_HudPage page);
void ASC_HudShowDeferredTransition(const string label);
void ASC_HudQueuePendingNavigationTransition(const string label);
bool ASC_HudIsTransitionGuardedControl(const string control_name);
bool ASC_HudIsStrictTransitionGuardedControl(const string control_name);
void ASC_HudQueueGuardedNavReplay(const string control_name);
bool ASC_HudTransitionGuardActive();
void ASC_HudArmTransitionGuard(const int lock_ms,const bool strict);
bool ASC_HudReplayQueuedGuardedNavClick();
bool ASC_HudIsHighFrequencyProofCadenceDue(const ASC_RuntimeState &runtime);
string ASC_HudBuildHighFrequencyProofSummary(const ASC_RuntimeState &runtime,const bool rendered_now,const bool cadence_refresh,const int tactical_age_sec,const int heartbeat_gap);
string ASC_HudBuildLowFrequencyProofSummary();
bool ASC_HudRequestManualMarketBoardRefresh(ASC_RuntimeState &runtime,string &status_reason);
bool ASC_HudRequestForcedDownstreamRefresh(ASC_RuntimeState &runtime,
                                           string &status_reason,
                                           const string scope,
                                           const string symbol = "",
                                           const string request_reason = "operator-forced downstream refresh queued from HUD");
bool ASC_HudPageShowsHigherRefreshControl(const ASC_HudPage page);
string ASC_HudHigherPageRefreshLabel(const ASC_HudPage page);
string ASC_HudHigherPageRefreshNotice(const ASC_HudPage page,const bool board_refresh_queued);
bool ASC_HudGlobalTop10SnapshotReady(const ASC_RuntimeState &runtime,string &readiness_reason,string &snapshot_source,datetime &snapshot_utc);
void ASC_HudRefreshHigherPageScope(ASC_RuntimeState &runtime,string &notice_text,string &log_action,string &board_status,const string &click_symbol);
bool ASC_HudPageHasHigherScopeRefresh(const ASC_HudPage page);
bool ASC_HudPageHasDedicatedRankSurface(const ASC_HudPage page);
string ASC_HudShortlistOrderScopeKey(const ASC_HudPage page);
void ASC_HudBuildPageCommandSurface(const ASC_HudPage page,ASC_HudPageCommandSurface &surface);
string ASC_HudPageCommandSummary(const ASC_HudPage page);
string ASC_HudPageRankSurfaceSummary(const ASC_HudPage page);
string ASC_HudLabelGlobalTop10();
void ASC_HudInvalidateVisibleSlotMaps();
string ASC_HudVisibleSlotMapScopeSignature();
string ASC_HudVisibleSlotMapShortlistSignature();
void ASC_HudRebuildVisibleSlotMapsIfNeeded();
int ASC_HudVisibleBucketBackingIndexAt(const int visible_index);
bool ASC_HudVisibleSubgroupBackingIndexAt(const int visible_index,int &backing_index,bool &use_browse_nodes);
int ASC_HudVisibleSymbolBackingIndexAt(const int visible_index);
int ASC_HudVisibleLeaderBackingIndexAt(const int visible_index);
int ASC_HudVisibleGlobalTop10Count();
bool ASC_HudTryGetGlobalTop10EntryByVisibleIndex(const int visible_index,ASC_ShortlistSymbolSummary &entry,int &shortlist_total);
bool ASC_HudBuildRankSurfaceReadback(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total,ASC_HudRankSurfaceReadback &readback);
string ASC_HudRankSurfaceSummaryLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total);
string ASC_HudRankSurfaceOwnerLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total);

void ASC_HudMarkDirtyLayout()
  {
   if(g_asc_hud.dirty_layout)
     {
      g_asc_hud.hud_layout_dirty_skipped++;
      return;
     }
   g_asc_hud.dirty_layout = true;
   g_asc_hud.dirty = true;
  }

bool ASC_HudViewportMaterialChange(const int old_w,const int old_h,const int new_w,const int new_h,bool &jitter_only)
  {
   jitter_only = false;
   if(new_w <= 0 || new_h <= 0)
      return false;
   if(old_w <= 0 || old_h <= 0)
      return true;
   int delta_w = MathAbs(new_w - old_w);
   int delta_h = MathAbs(new_h - old_h);
   if(delta_w == 0 && delta_h == 0)
      return false;
   if(delta_w <= ASC_HUD_VIEWPORT_JITTER_PX && delta_h <= ASC_HUD_VIEWPORT_JITTER_PX)
     {
      jitter_only = true;
      return false;
     }
   return true;
  }

void ASC_HudMarkDirtyDataLight()
  {
   g_asc_hud.dirty_data_light = true;
   g_asc_hud.dirty = true;
  }

void ASC_HudMarkDirtyDataHeavy()
  {
   g_asc_hud.dirty_data_heavy = true;
   g_asc_hud.dirty_data_light = true;
   g_asc_hud.dirty = true;
  }

void ASC_HudQueueHeavyRefresh(const string reason)
  {
   g_asc_hud.queued_heavy_refresh = true;
   g_asc_hud.queued_heavy_refresh_reason = reason;
  }

void ASC_HudMarkDirtyNavigation(const int flags)
  {
   g_asc_hud.dirty_navigation = true;
   g_asc_hud.dirty_navigation_flags |= flags;
   g_asc_hud.dirty = true;
  }

void ASC_HudClearDirtyFlags()
  {
   g_asc_hud.dirty = false;
   g_asc_hud.dirty_layout = false;
   g_asc_hud.dirty_data_light = false;
   g_asc_hud.dirty_data_heavy = false;
   g_asc_hud.dirty_navigation = false;
   g_asc_hud.dirty_navigation_flags = ASC_HUD_NAV_DIRTY_NONE;
  }

int ASC_HudNavigationFlagsForPage(const ASC_HudPage page)
  {
   int flags = ASC_HUD_NAV_DIRTY_PAGE;
   if(page == ASC_HUD_PAGE_MAIN_BUCKETS
      || page == ASC_HUD_PAGE_BUCKET_LEADERS
      || page == ASC_HUD_PAGE_SUB_GROUPS
      || page == ASC_HUD_PAGE_SYMBOLS
      || page == ASC_HUD_PAGE_GLOBAL_TOP10)
      flags |= ASC_HUD_NAV_DIRTY_LIST;
   if(page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || page == ASC_HUD_PAGE_ASPECT_DETAIL)
      flags |= ASC_HUD_NAV_DIRTY_SYMBOL;
   if(page == ASC_HUD_PAGE_ASPECT_DETAIL)
      flags |= ASC_HUD_NAV_DIRTY_DETAIL;
   return flags;
  }

bool ASC_HudIsDirty()
  {
   return (g_asc_hud.dirty_layout || g_asc_hud.dirty_data_light || g_asc_hud.dirty_data_heavy || g_asc_hud.dirty_navigation || g_asc_hud.dirty);
  }

bool ASC_HudPageNeedsHeavyDataset(const ASC_HudPage page)
  {
   return (page == ASC_HUD_PAGE_MAIN_BUCKETS
           || page == ASC_HUD_PAGE_BUCKET_LEADERS
           || page == ASC_HUD_PAGE_SUB_GROUPS
           || page == ASC_HUD_PAGE_SYMBOLS
           || page == ASC_HUD_PAGE_GLOBAL_TOP10);
  }

bool ASC_HudHeartbeatCadenceDue(const int heartbeat_counter,const int cadence)
  {
   int bounded = MathMax(1, cadence);
   if(heartbeat_counter <= 0)
      return true;
   return ((heartbeat_counter % bounded) == 0);
  }

bool ASC_HudPageNeedsPerBeatDataCheck(const ASC_HudPage page)
  {
   if(ASC_HudPageNeedsHeavyDataset(page))
      return true;
   return (page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || page == ASC_HUD_PAGE_ASPECT_DETAIL);
  }

void ASC_HudRequestRedraw()
  {
   if(!g_asc_trader_controls.hud_enabled)
      return;
   if(g_asc_hud.redraw_pending)
     {
      g_asc_hud.hud_redraw_avoided++;
      return;
     }
   g_asc_hud.proof_cycle_redraws++;
   g_asc_hud.proof_full_redraw_count++;
   g_asc_hud.proof_redraw_request_count++;
   g_asc_hud.redraw_pending = true;
  }

void ASC_HudFlushPendingRedraw()
  {
   if(!g_asc_trader_controls.hud_enabled)
      return;
   if(!g_asc_hud.redraw_pending)
     {
      if(g_asc_hud.render_mutations <= 0)
        {
         g_asc_hud.proof_redraw_suppressed_no_mutation_count++;
         g_asc_hud.hud_redraw_avoided++;
        }
      return;
     }
   uint redraw_started_ms = GetTickCount();
   ChartRedraw(0);
   uint redraw_elapsed_ms = GetTickCount() - redraw_started_ms;
   g_asc_hud.proof_last_chart_redraw_ms = redraw_elapsed_ms;
   g_asc_hud.telemetry_redraw_flush_elapsed_last_ms = redraw_elapsed_ms;
   if(redraw_elapsed_ms > g_asc_hud.telemetry_redraw_flush_elapsed_max_ms)
      g_asc_hud.telemetry_redraw_flush_elapsed_max_ms = redraw_elapsed_ms;
   g_asc_hud.proof_redraw_flush_count++;
   g_asc_hud.redraw_pending = false;
  }

bool ASC_HudPriorityServicePending()
  {
   if(!g_asc_trader_controls.hud_enabled)
      return false;
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   if(g_asc_hud.resize_pending || g_asc_hud.resize_burst_active || g_asc_hud.resize_force_full_rebuild || g_asc_hud.chart_change_pending)
      return false;
   if(g_asc_hud.dirty_data_heavy || g_asc_hud.queued_heavy_refresh)
      return false;
   return (g_asc_hud.dirty_navigation || g_asc_hud.pending_navigation_transition);
  }

bool ASC_HudServicePriorityNavigation(ASC_RuntimeState &runtime)
  {
   if(!ASC_HudPriorityServicePending())
      return false;
   if(g_asc_hud.dirty_data_heavy || g_asc_hud.queued_heavy_refresh)
     {
      g_asc_hud.proof_priority_service_skip_count++;
      g_asc_hud.proof_priority_service_skip_reason = g_asc_hud.dirty_data_heavy ? "dirty_data_heavy" : "queued_heavy_refresh";
      return false;
     }

   uint render_started_ms = GetTickCount();
   if(g_asc_hud.pending_navigation_requested_utc > 0)
     {
      datetime now_utc = TimeGMT();
      int wait_sec = (int)(now_utc - g_asc_hud.pending_navigation_requested_utc);
      if(wait_sec < 0)
         wait_sec = 0;
      g_asc_hud.proof_last_deferred_render_wait_ms = (uint)(wait_sec * 1000);
     }
   else
      g_asc_hud.proof_last_deferred_render_wait_ms = 0;

   ASC_HudBuildNavigationViewModel(runtime, "priority_navigation_render");
   ASC_HudRender(runtime);
   g_asc_hud.proof_last_deferred_render_ms = GetTickCount() - render_started_ms;
   g_asc_hud.hud_priority_render_last_ms = g_asc_hud.proof_last_deferred_render_ms;

   // SPR-04: priority navigation is cache-only. Do not queue selected-symbol
   // Current Focus reconciliation or warm the Current Focus file inside the
   // pre-heartbeat priority render path. The next normal heartbeat services
   // these deferred duties after click acknowledgement/render has already won.
   if(g_asc_hud.current_focus_sync_deferred && StringLen(g_asc_hud.current_focus_sync_deferred_symbol) > 0)
     {
      g_asc_hud.proof_last_artifact_sync_deferred = true;
      g_asc_hud.current_focus_refresh_deferred_count++;
      g_asc_hud.hud_cache_refresh_pending_count++;
     }

   if(g_asc_hud.current_focus_refresh_deferred)
     {
      g_asc_hud.hud_click_file_read_blocked_count++;
      g_asc_hud.hud_priority_cache_only_count++;
      g_asc_hud.hud_cache_refresh_pending_count++;
      if(g_asc_hud.current_focus_cache_state == "fresh")
         g_asc_hud.current_focus_cache_state = "pending";
      if(StringLen(g_asc_hud.current_focus_cache_posture) <= 0
         || g_asc_hud.current_focus_cache_posture == "Current Focus cache not warmed")
         g_asc_hud.current_focus_cache_posture = "Current Focus refresh pending; priority render used cache only";
     }

   if(g_asc_hud.pending_navigation_transition)
     {
      g_asc_hud.pending_navigation_transition = false;
      g_asc_hud.pending_navigation_label = "";
      g_asc_hud.pending_navigation_requested_utc = 0;
      g_asc_hud.pending_navigation_reason = "";
      g_asc_hud.pending_navigation_target_page = g_asc_hud.page;
      g_asc_hud.pending_navigation_target_symbol = g_asc_hud.selected_symbol;
     }
   g_asc_hud.hud_pending_render = false;
   g_asc_hud.hud_deferred_render_reason = "served";
   g_asc_hud.proof_priority_render_count++;
   g_asc_hud.proof_priority_service_skip_reason = "served";
   return true;
  }

bool ASC_HudConsumeChartChangePending(const int heartbeat_counter)
  {
   if(!g_asc_hud.resize_pending)
      return false;
   uint now_ms = GetTickCount();
   uint elapsed = now_ms - g_asc_hud.resize_last_event_ms;
   bool ms_ready = (elapsed >= ASC_HUD_RESIZE_DEBOUNCE_MS);
   bool heartbeat_ready = false;
   if(g_asc_hud.resize_last_event_heartbeat >= 0 && heartbeat_counter >= g_asc_hud.resize_last_event_heartbeat)
      heartbeat_ready = ((heartbeat_counter - g_asc_hud.resize_last_event_heartbeat) >= ASC_HUD_RESIZE_DEBOUNCE_HEARTBEATS);
   if(!ms_ready && !heartbeat_ready)
      return false;

   int chart_w = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0);
   int chart_h = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0);
   if(chart_w <= 0)
      chart_w = g_asc_hud.viewport_w;
   if(chart_h <= 0)
      chart_h = g_asc_hud.viewport_h;

   bool jitter_only = false;
   bool material_change = ASC_HudViewportMaterialChange(g_asc_hud.viewport_w, g_asc_hud.viewport_h, chart_w, chart_h, jitter_only);
   g_asc_hud.resize_pending = false;
   g_asc_hud.resize_burst_active = false;
   g_asc_hud.chart_change_pending = false;
   g_asc_hud.chart_change_last_render_ms = now_ms;
   g_asc_hud.viewport_pending_w = 0;
   g_asc_hud.viewport_pending_h = 0;

   if(!material_change)
     {
      if(jitter_only)
         g_asc_hud.hud_viewport_jitter_ignored++;
      else
         g_asc_hud.hud_viewport_reset_avoided++;
      g_asc_hud.resize_force_full_rebuild = false;
      g_asc_hud.hud_full_reset_reason = jitter_only ? "viewport_jitter_ignored" : "viewport_unchanged";
      return false;
     }

   g_asc_hud.resize_force_full_rebuild = true;
   g_asc_hud.hud_full_reset_reason = "material_viewport_change";
   return true;
  }


void ASC_HudShowDeferredTransition(const string label)
  {
   string banner = label;
   if(StringLen(banner) <= 0)
      banner = "Applying update...";
   g_asc_hud.transition_label = banner;
   g_asc_hud.transition_until = TimeGMT() + 1;
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return;
   ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "transition_text", banner);
   ASC_HudRequestRedraw();
  }

void ASC_HudArmTransitionGuard(const int lock_ms,const bool strict)
  {
   int bounded_ms = lock_ms;
   if(bounded_ms < 0)
      bounded_ms = 0;
   g_asc_hud.transition_guard_until_ms = GetTickCount() + (uint)bounded_ms;
   g_asc_hud.transition_guard_strict = strict;
  }

bool ASC_HudTransitionGuardActive()
  {
   if(g_asc_hud.transition_guard_until_ms == 0)
      return false;
   return ((int)(g_asc_hud.transition_guard_until_ms - GetTickCount()) > 0);
  }

void ASC_HudQueuePendingNavigationTransition(const string label)
  {
   string pending_label = label;
   if(StringLen(pending_label) <= 0)
      pending_label = "Navigating...";
   g_asc_hud.pending_navigation_transition = true;
   g_asc_hud.pending_navigation_label = pending_label;
   g_asc_hud.pending_navigation_requested_utc = TimeGMT();
   g_asc_hud.pending_navigation_reason = "navigation";
   g_asc_hud.pending_navigation_target_page = g_asc_hud.page;
   g_asc_hud.pending_navigation_target_symbol = g_asc_hud.selected_symbol;
   ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
   ASC_HudShowDeferredTransition(pending_label);
  }

string ASC_HudClassifyControl(const string control_name)
  {
   if(control_name == ASC_HUD_PREFIX + "btn_back" || control_name == ASC_HUD_PREFIX + "btn_forward")
      return "page_back_forward";
   if(control_name == ASC_HUD_PREFIX + "btn_buckets" || control_name == ASC_HUD_PREFIX + "btn_home" || control_name == ASC_HUD_PREFIX + "btn_top10")
      return "bucket_navigation";
   if(control_name == ASC_HUD_PREFIX + "btn_sub_groups" || control_name == ASC_HUD_PREFIX + "btn_leaders")
      return "sub_bucket_navigation";
   if(control_name == ASC_HUD_PREFIX + "btn_symbols")
      return "symbol_list_navigation";
   if(control_name == ASC_HUD_PREFIX + "btn_symbol" || control_name == ASC_HUD_PREFIX + "btn_details")
      return "symbol_detail_entry";
   if(control_name == ASC_HUD_PREFIX + "pager_prev" || control_name == ASC_HUD_PREFIX + "pager_next")
      return "page_back_forward";
   if(StringFind(control_name, ASC_HUD_PREFIX + "row_") == 0 && StringFind(control_name, "_btn") > 0)
     {
      if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
         return "bucket_navigation";
      if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
         return "sub_bucket_navigation";
      if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
         return "symbol_detail_entry";
      return "ordinary_navigation";
     }
   if(StringFind(control_name, ASC_HUD_PREFIX + "sym_stat_") == 0
      || StringFind(control_name, ASC_HUD_PREFIX + "deep_sub_") == 0
      || control_name == ASC_HUD_PREFIX + "act_semi")
      return "symbol_prev_next";
   if(control_name == ASC_HUD_PREFIX + "btn_sync" || control_name == ASC_HUD_PREFIX + "act_page_refresh")
      return "manual_refresh";
   if(control_name == ASC_HUD_PREFIX + "act_aurora")
      return "forced_downstream_refresh";
   if(control_name == ASC_HUD_PREFIX + "act_deep")
      return "deep_analysis_trigger";
   if(control_name == ASC_HUD_PREFIX + "act_full")
      return "higher_scope_refresh";
   return "unknown_or_legacy_control";
  }

bool ASC_HudControlIsOrdinaryNavigation(const string control_class)
  {
   return (control_class == "ordinary_navigation"
           || control_class == "page_back_forward"
           || control_class == "bucket_navigation"
           || control_class == "sub_bucket_navigation"
           || control_class == "symbol_list_navigation"
           || control_class == "symbol_detail_entry"
           || control_class == "symbol_prev_next");
  }

void ASC_HudQueueNavigationIntent(const string label,const string reason,const string control_class)
  {
   string pending_label = label;
   if(StringLen(pending_label) <= 0)
      pending_label = "Navigating...";
   g_asc_hud.pending_navigation_transition = true;
   g_asc_hud.pending_navigation_label = pending_label;
   g_asc_hud.pending_navigation_requested_utc = TimeGMT();
   g_asc_hud.pending_navigation_reason = reason;
   g_asc_hud.pending_navigation_target_page = g_asc_hud.page;
   g_asc_hud.pending_navigation_target_symbol = g_asc_hud.selected_symbol;
   g_asc_hud.hud_pending_render = true;
   g_asc_hud.hud_pending_target_page = ASC_HudPageName(g_asc_hud.page);
   g_asc_hud.hud_pending_target_symbol = g_asc_hud.selected_symbol;
   g_asc_hud.hud_deferred_render_reason = reason;
   g_asc_hud.proof_last_control_class = control_class;
   g_asc_hud.proof_last_target_page = ASC_HudPageName(g_asc_hud.page);
   g_asc_hud.proof_last_target_symbol = g_asc_hud.selected_symbol;
   ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
   ASC_HudShowDeferredTransition(pending_label);
  }

void ASC_HudAckNavigationClick(const uint event_started_ms,const string label,const string reason,const string control_class)
  {
   g_asc_hud.hud_click_acknowledged = true;
   g_asc_hud.hud_ack_label = label;
   g_asc_hud.proof_last_click_to_ack_ms = GetTickCount() - event_started_ms;
   g_asc_hud.proof_nav_ack_count++;
   g_asc_hud.proof_last_ordinary_navigation_fast_path = ASC_HudControlIsOrdinaryNavigation(control_class);
   if(g_asc_hud.proof_last_ordinary_navigation_fast_path)
      g_asc_hud.proof_nav_fast_path_count++;
   else
      g_asc_hud.proof_nav_slow_path_count++;
   ASC_HudQueueNavigationIntent(label, reason, control_class);
   ASC_HudFlushPendingRedraw();
  }

bool ASC_HudServiceDeferredCurrentFocusWork(ASC_RuntimeState &runtime,const bool allow_file_read,const string reason)
  {
   bool served_any = false;
   if(g_asc_hud.current_focus_sync_deferred && StringLen(g_asc_hud.current_focus_sync_deferred_symbol) > 0)
     {
      if(ASC_HudQueueViewedCurrentFocusSync(runtime, false))
        {
         served_any = true;
         g_asc_hud.current_focus_sync_deferred = false;
         g_asc_hud.current_focus_sync_deferred_symbol = "";
         g_asc_hud.current_focus_sync_deferred_utc = 0;
        }
     }

   if(g_asc_hud.current_focus_refresh_deferred)
     {
      if(!allow_file_read)
        {
         g_asc_hud.hud_click_file_read_blocked_count++;
         g_asc_hud.hud_priority_cache_only_count++;
         g_asc_hud.hud_cache_refresh_pending_count++;
         return served_any;
        }

      string warm_text = "";
      bool warm_stale = false;
      if(ASC_HudReadCurrentFocusFileCached(warm_text, warm_stale, reason))
         served_any = true;
      else
        {
         g_asc_hud.hud_cache_refresh_pending_count++;
         if(warm_stale)
            g_asc_hud.current_focus_cache_stale_count++;
        }
     }

   return served_any;
  }

void ASC_HudMarkCurrentFocusSyncDeferred(const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return;
   g_asc_hud.current_focus_sync_deferred = true;
   g_asc_hud.current_focus_sync_deferred_symbol = symbol;
   g_asc_hud.current_focus_sync_deferred_utc = TimeGMT();
   g_asc_hud.proof_last_artifact_sync_deferred = true;
  }

bool ASC_HudIsTransitionGuardedControl(const string control_name)
  {
   if(control_name == ASC_HUD_PREFIX + "btn_back"
      || control_name == ASC_HUD_PREFIX + "btn_forward"
      || control_name == ASC_HUD_PREFIX + "btn_home"
      || control_name == ASC_HUD_PREFIX + "btn_buckets"
      || control_name == ASC_HUD_PREFIX + "btn_top10"
      || control_name == ASC_HUD_PREFIX + "pager_prev"
      || control_name == ASC_HUD_PREFIX + "pager_next")
      return true;
   return false;
  }

bool ASC_HudIsStrictTransitionGuardedControl(const string control_name)
  {
   if(control_name == ASC_HUD_PREFIX + "btn_sync"
      || control_name == ASC_HUD_PREFIX + "act_page_refresh"
      || control_name == ASC_HUD_PREFIX + "act_top10_run_full"
      || control_name == ASC_HUD_PREFIX + "act_deep"
      || control_name == ASC_HUD_PREFIX + "act_full")
      return true;
   return false;
  }

void ASC_HudQueueGuardedNavReplay(const string control_name)
  {
   if(!ASC_HudIsTransitionGuardedControl(control_name))
      return;
   g_asc_hud.queued_nav_click_pending = true;
   g_asc_hud.queued_nav_click_control = control_name;
   g_asc_hud.queued_nav_click_utc = TimeGMT();
  }

bool ASC_HudReplayQueuedGuardedNavClick()
  {
   if(!g_asc_hud.queued_nav_click_pending)
      return false;
   if(g_asc_hud.resize_pending || g_asc_hud.resize_burst_active || ASC_HudTransitionGuardActive())
      return false;

   string control = g_asc_hud.queued_nav_click_control;
   g_asc_hud.queued_nav_click_pending = false;
   g_asc_hud.queued_nav_click_control = "";
   g_asc_hud.queued_nav_click_utc = 0;

   if(control == ASC_HUD_PREFIX + "btn_back")
      ASC_HudGoBack();
   else if(control == ASC_HUD_PREFIX + "btn_forward")
      ASC_HudGoForward();
   else if(control == ASC_HUD_PREFIX + "btn_home")
      ASC_HudGoHome();
   else if(control == ASC_HUD_PREFIX + "btn_buckets")
      ASC_HudOpenPage(ASC_HUD_PAGE_MAIN_BUCKETS);
   else if(control == ASC_HUD_PREFIX + "btn_top10")
      ASC_HudOpenPage(ASC_HUD_PAGE_GLOBAL_TOP10);
   else if(control == ASC_HUD_PREFIX + "pager_prev")
      ASC_HudPagePrev();
   else if(control == ASC_HUD_PREFIX + "pager_next")
      ASC_HudPageNext();
   else
      return false;
   return true;
  }

void ASC_HudResetLookupCaches()
  {
   g_asc_hud_shortlist_lookup_revision++;
   ArrayResize(g_asc_hud_shortlist_lookup, 0);
   g_asc_hud_shortlist_lookup_built_revision = 0;
   ArrayResize(g_asc_hud_layer1_lookup, 0);
   g_asc_hud_layer1_lookup_built_revision = 0;
   ArrayResize(g_asc_hud_scope_ranking_lookup, 0);
   ASC_HudInvalidateSelectedSymbolCache();
  }

void ASC_HudInvalidateSelectedSymbolCache()
  {
   g_asc_hud.selected_symbol_layer1_index = -1;
   g_asc_hud.selected_symbol_layer1_revision = 0;
   g_asc_hud.selected_symbol_list_key = "";
   g_asc_hud.selected_symbol_list_filter_signature = "";
   g_asc_hud.selected_symbol_list_revision = 0;
   g_asc_hud.selected_symbol_list_shortlist_revision = 0;
  }

string ASC_HudNormalizeLookupKey(const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return "";
   return ASC_NormalizeSymbolForMatch(symbol);
  }

void ASC_HudEnsureLookupCapacity(ASC_HudLookupEntry &rows[],const int required_size,const int reserve_step)
  {
   int current_size = ArraySize(rows);
   int reserve = reserve_step;
   if(reserve < 16)
      reserve = 16;
   if(required_size <= current_size)
     {
      if(current_size == 0)
         ArrayResize(rows, 0, reserve);
      return;
     }
   ArrayResize(rows, required_size, reserve);
  }

void ASC_HudEnsureIntArrayCapacity(int &rows[],const int required_size,const int reserve_step)
  {
   int current_size = ArraySize(rows);
   int reserve = reserve_step;
   if(reserve < 16)
      reserve = 16;
   if(required_size <= current_size)
     {
      if(current_size == 0)
         ArrayResize(rows, 0, reserve);
      return;
     }
   ArrayResize(rows, required_size, reserve);
  }

void ASC_HudSortLookupEntries(ASC_HudLookupEntry &rows[],const int left,const int right)
  {
   int i = left;
   int j = right;
   string pivot = rows[(left + right) / 2].key;
   while(i <= j)
     {
      while(rows[i].key < pivot)
         i++;
      while(rows[j].key > pivot)
         j--;
      if(i <= j)
        {
         if(i != j)
           {
            ASC_HudLookupEntry swap_entry = rows[i];
            rows[i] = rows[j];
            rows[j] = swap_entry;
           }
         i++;
         j--;
        }
     }
   if(left < j)
      ASC_HudSortLookupEntries(rows, left, j);
   if(i < right)
      ASC_HudSortLookupEntries(rows, i, right);
  }

void ASC_HudInsertLookupEntrySorted(ASC_HudLookupEntry &rows[],const string key,const int index,const int reserve_step)
  {
   int count = ArraySize(rows);
   int left = 0;
   int right = count - 1;
   while(left <= right)
     {
      int mid = (left + right) / 2;
      string mid_key = rows[mid].key;
      if(mid_key == key)
        {
         rows[mid].index = index;
         return;
        }
      if(mid_key < key)
         left = mid + 1;
      else
         right = mid - 1;
     }

   int insert_at = left;
   ASC_HudEnsureLookupCapacity(rows, count + 1, reserve_step);
   for(int i = count; i > insert_at; i--)
      rows[i] = rows[i - 1];
   rows[insert_at].key = key;
   rows[insert_at].index = index;
  }

void ASC_HudCompactLookupEntries(ASC_HudLookupEntry &rows[])
  {
   int total = ArraySize(rows);
   if(total <= 1)
      return;

   int write = 0;
   for(int read = 1; read < total; read++)
     {
      if(rows[write].key == rows[read].key)
        {
         if(rows[read].index < rows[write].index)
            rows[write].index = rows[read].index;
         continue;
        }
      write++;
      if(write != read)
         rows[write] = rows[read];
     }
   ArrayResize(rows, write + 1);
  }

string ASC_HudBrowseFilterSignature()
  {
   return StringFormat("%s|%s|%s|%s",
                       ASC_HudNormalizeBrowseId(g_asc_hud.selected_bucket_id, "all"),
                       ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_family_filter, "all"),
                       ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_sector_filter, "all"),
                       ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_industry_filter, "all"));
  }

int ASC_HudFindLookupIndex(const ASC_HudLookupEntry &rows[],const string key)
  {
   if(StringLen(key) <= 0)
      return -1;

   int left = 0;
   int right = ArraySize(rows) - 1;
   while(left <= right)
     {
      int mid = (left + right) / 2;
      string mid_key = rows[mid].key;
      if(mid_key == key)
         return rows[mid].index;
      if(mid_key < key)
         left = mid + 1;
      else
         right = mid - 1;
     }
   return -1;
  }

void ASC_HudAddLookupAlias(ASC_HudLookupEntry &rows[],const string alias,const int index)
  {
   string key = ASC_HudNormalizeLookupKey(alias);
   if(StringLen(key) <= 0)
      return;
   int next = ArraySize(rows);
   ASC_HudEnsureLookupCapacity(rows, next + 1);
   rows[next].key = key;
   rows[next].index = index;
  }

void ASC_HudEnsureShortlistLookupCache()
  {
   if(g_asc_hud_shortlist_lookup_built_revision == g_asc_hud_shortlist_lookup_revision)
      return;

   ArrayResize(g_asc_hud_shortlist_lookup, 0);
   int shortlist_total = ArraySize(g_asc_hud_shortlist_rows);
   if(shortlist_total > 0)
      ASC_HudEnsureLookupCapacity(g_asc_hud_shortlist_lookup, 0, MathMax(64, shortlist_total * 5));
   for(int i = 0; i < shortlist_total; i++)
     {
      ASC_HudAddLookupAlias(g_asc_hud_shortlist_lookup, g_asc_hud_shortlist_rows[i].symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_shortlist_lookup, g_asc_hud_shortlist_rows[i].state.symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_shortlist_lookup, g_asc_hud_shortlist_rows[i].state.identity.normalized_symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_shortlist_lookup, g_asc_hud_shortlist_rows[i].state.identity.canonical_symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_shortlist_lookup, g_asc_hud_shortlist_rows[i].state.classification.canonical_symbol, i);
     }
   if(ArraySize(g_asc_hud_shortlist_lookup) > 1)
     {
      ASC_HudSortLookupEntries(g_asc_hud_shortlist_lookup, 0, ArraySize(g_asc_hud_shortlist_lookup) - 1);
      ASC_HudCompactLookupEntries(g_asc_hud_shortlist_lookup);
     }
   g_asc_hud_shortlist_lookup_built_revision = g_asc_hud_shortlist_lookup_revision;
  }

void ASC_HudEnsureLayer1LookupCache()
  {
   ulong structural_revision = ASC_Layer1StructuralRevision();
   if(g_asc_hud_layer1_lookup_built_revision == structural_revision)
      return;

   ArrayResize(g_asc_hud_layer1_lookup, 0);
   int cache_total = ASC_Layer1CachedSymbolCount();
   if(cache_total > 0)
      ASC_HudEnsureLookupCapacity(g_asc_hud_layer1_lookup, 0, MathMax(64, cache_total * 4));
   for(int i = 0; i < cache_total; i++)
     {
      ASC_Layer1SymbolState state;
      if(!ASC_HudMaterializeSymbolState(i, state))
         continue;
      ASC_HudAddLookupAlias(g_asc_hud_layer1_lookup, state.symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_layer1_lookup, state.identity.normalized_symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_layer1_lookup, state.identity.canonical_symbol, i);
      ASC_HudAddLookupAlias(g_asc_hud_layer1_lookup, state.classification.canonical_symbol, i);
     }
   if(ArraySize(g_asc_hud_layer1_lookup) > 1)
     {
      ASC_HudSortLookupEntries(g_asc_hud_layer1_lookup, 0, ArraySize(g_asc_hud_layer1_lookup) - 1);
      ASC_HudCompactLookupEntries(g_asc_hud_layer1_lookup);
     }
   g_asc_hud_layer1_lookup_built_revision = structural_revision;
  }

bool ASC_HudResolveShortlistLookup(const string symbol,ASC_ShortlistSymbolSummary &entry,int &rank_out,int &total_out)
  {
   rank_out = 0;
   total_out = ASC_ShortlistCount(g_asc_hud_shortlist_rows);
   ASC_HudEnsureShortlistLookupCache();

   int lookup_index = ASC_HudFindLookupIndex(g_asc_hud_shortlist_lookup, ASC_HudNormalizeLookupKey(symbol));
   if(lookup_index < 0 || lookup_index >= ArraySize(g_asc_hud_shortlist_rows))
      return false;

   entry = g_asc_hud_shortlist_rows[lookup_index];
   rank_out = entry.rank;
   if(entry.shortlisted && !ASC_ShortlistHasLawfulMembership(entry))
     {
      ASC_ShortlistMarkMembershipInvalid(entry);
      rank_out = 0;
     }
   return true;
  }


int ASC_HudFindShortlistRowIndexBySymbol(const ASC_ShortlistSymbolSummary &rows[],const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return -1;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(ASC_ShortlistSymbolMatchesContext(rows[i], symbol))
         return i;
     }
   return -1;
  }

int ASC_HudBucketAdmittedCount(const ASC_ShortlistSymbolSummary &rows[],const string bucket_id)
  {
   if(StringLen(bucket_id) <= 0)
      return 0;
   int count = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistHasLawfulBucketMembership(rows[i]))
         continue;
      if(ASC_HudEffectiveMainBucketId(rows[i].state) != bucket_id)
         continue;
      if(!ASC_ConsumerAllowsOrdinaryL34(rows[i].state))
         continue;
      count++;
     }
   return count;
  }

int ASC_HudMergeRetainedBucketTop5Members(const ASC_ShortlistSymbolSummary &prior_rows[],ASC_ShortlistSymbolSummary &incoming_rows[])
  {
   int retained_count = 0;
   int prior_total = ArraySize(prior_rows);
   if(prior_total <= 0)
      return retained_count;

   for(int i = 0; i < prior_total; i++)
     {
      if(!ASC_ShortlistHasLawfulBucketMembership(prior_rows[i]))
         continue;
      if(!ASC_ConsumerAllowsOrdinaryL34(prior_rows[i].state))
         continue;

      string bucket_id = ASC_HudEffectiveMainBucketId(prior_rows[i].state);
      if(StringLen(bucket_id) <= 0)
         continue;

      if(ASC_HudFindShortlistRowIndexBySymbol(incoming_rows, prior_rows[i].symbol) >= 0)
         continue;

      int prior_bucket_admitted = ASC_HudBucketAdmittedCount(prior_rows, bucket_id);
      int incoming_bucket_admitted = ASC_HudBucketAdmittedCount(incoming_rows, bucket_id);
      int retention_floor = MathMin(ASC_SHORTLIST_BUCKET_SIZE, prior_bucket_admitted);
      if(retention_floor <= 0 || incoming_bucket_admitted >= retention_floor)
         continue;

      int next = ArraySize(incoming_rows);
      ArrayResize(incoming_rows, next + 1);
      incoming_rows[next] = prior_rows[i];
      retained_count++;
     }

   return retained_count;
  }

void ASC_HudAdoptRuntimeShortlistCache(const ASC_RuntimeState &runtime)
  {
   string incoming_source = "none";
   ulong incoming_revision = 0;
   datetime incoming_pass_utc = 0;
   int incoming_count = 0;
   bool use_publication_shortlist = (runtime.publication_shortlist_ready && ArraySize(runtime.publication_shortlist_rows) > 0);
   bool use_committed_l4_shortlist = (!use_publication_shortlist && runtime.committed_l4_ready && ArraySize(runtime.committed_l4_rows) > 0);

   if(use_publication_shortlist)
     {
      incoming_source = "publication_shortlist_rows";
      incoming_revision = runtime.committed_l3_revision;
      incoming_pass_utc = runtime.publication_shortlist_pass_utc;
      incoming_count = ArraySize(runtime.publication_shortlist_rows);
     }
   else
      if(use_committed_l4_shortlist)
        {
         incoming_source = "committed_l4_rows";
         incoming_revision = runtime.committed_l4_revision;
         incoming_pass_utc = runtime.committed_l4_pass_utc;
         incoming_count = ArraySize(runtime.committed_l4_rows);
        }

   bool identity_changed = (g_asc_hud.last_shortlist_source != incoming_source
                            || g_asc_hud.last_shortlist_revision != incoming_revision
                            || g_asc_hud.last_shortlist_pass_utc != incoming_pass_utc
                            || g_asc_hud.last_shortlist_count != incoming_count);
   if(!identity_changed)
      return;

   string prior_source = g_asc_hud.last_shortlist_source;
   ulong prior_revision = g_asc_hud.last_shortlist_revision;

   if(runtime.publication_shortlist_ready && ArraySize(runtime.publication_shortlist_rows) > 0)
     {
      ASC_ShortlistSymbolSummary prior_rows[];
      int prior_count = ArraySize(g_asc_hud_shortlist_rows);
      ArrayResize(prior_rows, prior_count);
      for(int i = 0; i < prior_count; i++)
         prior_rows[i] = g_asc_hud_shortlist_rows[i];

      ASC_ShortlistSymbolSummary adopted_rows[];
      int shortlist_count = ArraySize(runtime.publication_shortlist_rows);
      ArrayResize(adopted_rows, shortlist_count);
      for(int i = 0; i < shortlist_count; i++)
         adopted_rows[i] = runtime.publication_shortlist_rows[i];
      int retained_members = ASC_HudMergeRetainedBucketTop5Members(prior_rows, adopted_rows);

      ArrayResize(g_asc_hud_shortlist_rows, ArraySize(adopted_rows));
      for(int i = 0; i < ArraySize(adopted_rows); i++)
         g_asc_hud_shortlist_rows[i] = adopted_rows[i];
      g_asc_hud_shortlist_cached_utc = runtime.publication_shortlist_pass_utc;
      if(g_asc_hud_shortlist_cached_utc <= 0)
         g_asc_hud_shortlist_cached_utc = TimeGMT();
      g_asc_hud.last_shortlist_source = incoming_source;
      g_asc_hud.last_shortlist_revision = incoming_revision;
      g_asc_hud.last_shortlist_pass_utc = incoming_pass_utc;
      g_asc_hud.last_shortlist_count = incoming_count;
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudAdoptRuntimeShortlistCache", incoming_source,
                  StringFormat("shortlist_source_changed from=%s rev=%I64u to=%s rev=%I64u pass_utc=%s count=%d retained_bucket_members=%d adopted_count=%d",
                               prior_source,
                               prior_revision,
                               incoming_source,
                               incoming_revision,
                               TimeToString(g_asc_hud_shortlist_cached_utc, TIME_DATE | TIME_SECONDS),
                               incoming_count,
                               retained_members,
                               ArraySize(g_asc_hud_shortlist_rows)));
      ASC_HudResetLookupCaches();
      ASC_HudRebuildScopeRankingCache();
      return;
     }

   if(runtime.committed_l4_ready && ArraySize(runtime.committed_l4_rows) > 0)
     {
      ASC_ShortlistSymbolSummary prior_rows[];
      int prior_count = ArraySize(g_asc_hud_shortlist_rows);
      ArrayResize(prior_rows, prior_count);
      for(int i = 0; i < prior_count; i++)
         prior_rows[i] = g_asc_hud_shortlist_rows[i];

      ASC_ShortlistSymbolSummary adopted_rows[];
      int shortlist_count = ArraySize(runtime.committed_l4_rows);
      ArrayResize(adopted_rows, shortlist_count);
      for(int i = 0; i < shortlist_count; i++)
         adopted_rows[i] = runtime.committed_l4_rows[i].summary;
      int retained_members = ASC_HudMergeRetainedBucketTop5Members(prior_rows, adopted_rows);

      ArrayResize(g_asc_hud_shortlist_rows, ArraySize(adopted_rows));
      for(int i = 0; i < ArraySize(adopted_rows); i++)
         g_asc_hud_shortlist_rows[i] = adopted_rows[i];
      g_asc_hud_shortlist_cached_utc = runtime.committed_l4_pass_utc;
      if(g_asc_hud_shortlist_cached_utc <= 0)
         g_asc_hud_shortlist_cached_utc = TimeGMT();
      g_asc_hud.last_shortlist_source = incoming_source;
      g_asc_hud.last_shortlist_revision = incoming_revision;
      g_asc_hud.last_shortlist_pass_utc = incoming_pass_utc;
      g_asc_hud.last_shortlist_count = incoming_count;
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudAdoptRuntimeShortlistCache", incoming_source,
                  StringFormat("shortlist_source_changed from=%s rev=%I64u to=%s rev=%I64u pass_utc=%s count=%d retained_bucket_members=%d adopted_count=%d",
                               prior_source,
                               prior_revision,
                               incoming_source,
                               incoming_revision,
                               TimeToString(g_asc_hud_shortlist_cached_utc, TIME_DATE | TIME_SECONDS),
                               incoming_count,
                               retained_members,
                               ArraySize(g_asc_hud_shortlist_rows)));
      ASC_HudResetLookupCaches();
      ASC_HudRebuildScopeRankingCache();
      return;
     }

   if(ArraySize(g_asc_hud_shortlist_rows) > 0)
     {
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudAdoptRuntimeShortlistCache", "retained_last_good_shortlist",
                  StringFormat("retaining_existing_shortlist source=%s rev=%I64u cached_utc=%s while incoming source=%s rev=%I64u count=%d is not yet ready",
                               prior_source,
                               prior_revision,
                               TimeToString(g_asc_hud_shortlist_cached_utc, TIME_DATE | TIME_SECONDS),
                               incoming_source,
                               incoming_revision,
                               incoming_count));
      return;
     }

   ArrayResize(g_asc_hud_shortlist_rows, 0);
   g_asc_hud_shortlist_cached_utc = 0;
   g_asc_hud.last_shortlist_source = incoming_source;
   g_asc_hud.last_shortlist_revision = incoming_revision;
   g_asc_hud.last_shortlist_pass_utc = incoming_pass_utc;
   g_asc_hud.last_shortlist_count = incoming_count;
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudAdoptRuntimeShortlistCache", incoming_source,
               StringFormat("shortlist_source_changed from=%s rev=%I64u to=%s rev=%I64u pass_utc=%s count=%d",
                            prior_source,
                            prior_revision,
                            incoming_source,
                            incoming_revision,
                            TimeToString(g_asc_hud_shortlist_cached_utc, TIME_DATE | TIME_SECONDS),
                            incoming_count));
   ASC_HudResetLookupCaches();
   ASC_HudRebuildScopeRankingCache();
  }

string ASC_HudTrim(const string value)
  {
   int n = (int)StringLen(value);
   int s = 0;
   while(s < n)
     {
      ushort ch = (ushort)StringGetCharacter(value, s);
      if(ch != 32 && ch != 9 && ch != 10 && ch != 13)
         break;
      s++;
     }

   int e = n - 1;
   while(e >= s)
     {
      ushort ch = (ushort)StringGetCharacter(value, e);
      if(ch != 32 && ch != 9 && ch != 10 && ch != 13)
         break;
      e--;
     }

   if(e < s)
      return "";
  return StringSubstr(value, s, e - s + 1);
  }

string ASC_HudExtractLabeledValue(const string text,const string label)
  {
   if(StringLen(text) <= 0 || StringLen(label) <= 0)
      return "";

   int label_pos = StringFind(text, label, 0);
   if(label_pos < 0)
      return "";

   int value_start = label_pos + (int)StringLen(label);
   int text_len = (int)StringLen(text);
   while(value_start < text_len)
     {
      ushort ch = (ushort)StringGetCharacter(text, value_start);
      if(ch == 58 || ch == 61 || ch == 32 || ch == 9)
         value_start++;
      else
         break;
     }

   int value_end = text_len;
   int stop = StringFind(text, "\n", value_start);
   if(stop >= 0 && stop < value_end)
      value_end = stop;
   stop = StringFind(text, "\r", value_start);
   if(stop >= 0 && stop < value_end)
      value_end = stop;
   stop = StringFind(text, "|", value_start);
   if(stop >= 0 && stop < value_end)
      value_end = stop;

   if(value_end <= value_start)
      return "";
   return ASC_HudTrim(StringSubstr(text, value_start, value_end - value_start));
  }

string ASC_HudHumanizeToken(const string token_raw)
  {
   string token = ASC_HudTrim(token_raw);
   if(StringLen(token) <= 0)
      return "";

   string lower = token;
   StringToLower(lower);
   if(lower == "fx")
      return "Forex";

   if(lower == "us" || lower == "uk" || lower == "eu")
     {
      StringToUpper(lower);
      return lower;
     }

   int len = (int)StringLen(lower);
   if(len >= 2)
     {
      ushort c1 = (ushort)StringGetCharacter(lower, 0);
      ushort c2 = (ushort)StringGetCharacter(lower, 1);
      if((c1 >= 'a' && c1 <= 'z') && (c2 >= '0' && c2 <= '9'))
        {
         StringToUpper(lower);
         return lower;
        }
     }

   string head = StringSubstr(lower, 0, 1);
   StringToUpper(head);
   if(len == 1)
      return head;
   return head + StringSubstr(lower, 1);
  }

string ASC_HudHumanizeIdentifier(const string value)
  {
   string raw = ASC_HudTrim(value);
   if(StringLen(raw) <= 0)
      return "";

   string normalized = raw;
   StringReplace(normalized, "_", " ");
   StringReplace(normalized, "-", " ");
   while(StringFind(normalized, "  ") >= 0)
      StringReplace(normalized, "  ", " ");

   string out = "";
   int start = 0;
   int n = (int)StringLen(normalized);
   while(start < n)
     {
      int space = StringFind(normalized, " ", start);
      string part = (space < 0 ? StringSubstr(normalized, start) : StringSubstr(normalized, start, space - start));
      string human = ASC_HudHumanizeToken(part);
      if(StringLen(human) > 0)
        {
         if(StringLen(out) > 0)
            out += " ";
         out += human;
        }
      if(space < 0)
         break;
      start = space + 1;
     }

   return out;
  }

string ASC_HudMainBucketName(const string bucket_id)
  {
   string id = bucket_id;
   StringToLower(id);
   return ASC_MainBucketOperatorNameFromId(id);
  }

string ASC_HudSubBucketDisplayName(const string main_bucket_name,const string sub_bucket_name)
  {
   string trimmed = ASC_HudTrim(sub_bucket_name);
   if(StringLen(trimmed) <= 0)
      return "Unassigned";

   string main_name = ASC_HudTrim(main_bucket_name);
   if(StringLen(main_name) <= 0)
      return trimmed;

   string main_lower = main_name;
   StringToLower(main_lower);
   string sub_lower = trimmed;
   StringToLower(sub_lower);

   string prefix_space = main_lower + " ";
   int prefix_space_len = (int)StringLen(prefix_space);
   if(StringSubstr(sub_lower, 0, prefix_space_len) == prefix_space)
      return ASC_HudTrim(StringSubstr(trimmed, prefix_space_len));

   string prefix_slash = main_lower + " / ";
   int prefix_slash_len = (int)StringLen(prefix_slash);
   if(StringSubstr(sub_lower, 0, prefix_slash_len) == prefix_slash)
      return ASC_HudTrim(StringSubstr(trimmed, prefix_slash_len));

   return trimmed;
  }

int ASC_HudMainBucketSlot(const string bucket_id)
  {
   string id = bucket_id;
   StringToLower(id);
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
     {
      if(g_asc_hud.buckets[i].id == id)
         return i;
     }
  return -1;
  }

string ASC_HudEffectiveMainBucketId(const ASC_Layer1SymbolState &state)
  {
   return ASC_ClassificationCanonicalMainBucketId(state.classification);
  }

string ASC_HudFallbackSubBucketId(const string main_bucket_id)
  {
   return ASC_ClassificationFallbackSubBucketId(main_bucket_id);
  }

string ASC_HudEffectiveSubBucketId(const ASC_Layer1SymbolState &state,const string effective_main_bucket_id)
  {
   string sub_id = ASC_ClassificationCanonicalSubBucketId(state.classification);
   if(StringLen(sub_id) > 0)
      return sub_id;
   return ASC_HudFallbackSubBucketId(effective_main_bucket_id);
  }

string ASC_HudEffectiveSubBucketName(const ASC_Layer1SymbolState &state,const string effective_main_bucket_id)
  {
   string sub_name = ASC_ClassificationCanonicalSubBucketName(state.classification);
   if(StringLen(sub_name) > 0)
      return ASC_HudHumanizeIdentifier(sub_name);
   return ASC_HudHumanizeIdentifier(ASC_HudEffectiveSubBucketId(state, effective_main_bucket_id));
  }

string ASC_HudEffectiveMainBucketName(const ASC_Layer1SymbolState &state)
  {
   return ASC_HudMainBucketName(ASC_HudEffectiveMainBucketId(state));
  }

bool ASC_HudIsStockBucketId(const string bucket_id)
  {
   string id = ASC_HudTrim(bucket_id);
   StringToLower(id);
   return (id == "stocks");
  }

string ASC_HudNormalizeBrowseId(const string raw_id,const string fallback_id)
  {
   string id = ASC_HudTrim(raw_id);
   if(StringLen(id) <= 0)
      id = ASC_HudTrim(fallback_id);
   if(StringLen(id) <= 0)
      id = "needs_review";

   StringToLower(id);
   StringReplace(id, " ", "_");
   StringReplace(id, "-", "_");
   StringReplace(id, "/", "_");
   while(StringFind(id, "__") >= 0)
      StringReplace(id, "__", "_");
   return id;
  }

string ASC_HudBrowseNodeLabel(const string preferred_name,const string fallback_id)
  {
   string label = ASC_HudTrim(preferred_name);
   if(StringLen(label) > 0)
      return ASC_HudHumanizeIdentifier(label);
   return ASC_HudHumanizeIdentifier(ASC_HudNormalizeBrowseId(fallback_id, "needs_review"));
  }

string ASC_HudStockFamilyId(const ASC_Layer1SymbolState &state)
  {
   if(StringLen(ASC_HudTrim(state.classification.stock_venue_family_id)) > 0)
      return ASC_HudNormalizeBrowseId(state.classification.stock_venue_family_id, "needs_review");
   if(StringLen(ASC_HudTrim(state.classification.stock_family_id)) > 0)
      return ASC_HudNormalizeBrowseId(state.classification.stock_family_id, "needs_review");
   if(StringLen(ASC_HudTrim(state.classification.stock_product_family_id)) > 0)
      return ASC_HudNormalizeBrowseId(state.classification.stock_product_family_id, "needs_review");
   return "needs_review";
  }

string ASC_HudStockFamilyOperatorLabel(const string family_id_raw)
  {
   string family_id = ASC_HudNormalizeBrowseId(family_id_raw, "needs_review");
   if(family_id == "us_stocks") return "US Stocks";
   if(family_id == "hk_stocks") return "HK Stocks";
   if(family_id == "eu_stocks") return "Europe Stocks";
   if(family_id == "uk_stocks") return "UK Stocks";
   if(family_id == "canada_stocks") return "Canada Stocks";
   if(family_id == "adr_international") return "ADR / International Listings";
   if(family_id == "etf_etp") return "ETF / ETP";
   if(family_id == "reit_yield") return "REIT / Yield Vehicles";
   if(family_id == "needs_review") return "Needs Review";
   return "";
  }

string ASC_HudStockFamilyName(const ASC_Layer1SymbolState &state,const string family_id)
  {
   string canonical_label = ASC_HudStockFamilyOperatorLabel(family_id);
   if(StringLen(canonical_label) > 0)
      return canonical_label;

   if(StringLen(ASC_HudTrim(state.classification.stock_venue_family_name)) > 0)
      return ASC_HudBrowseNodeLabel(state.classification.stock_venue_family_name, family_id);
   if(StringLen(ASC_HudTrim(state.classification.stock_family_name)) > 0)
      return ASC_HudBrowseNodeLabel(state.classification.stock_family_name, family_id);
   if(StringLen(ASC_HudTrim(state.classification.stock_product_family_name)) > 0)
      return ASC_HudBrowseNodeLabel(state.classification.stock_product_family_name, family_id);
   return "Needs Review";
  }

string ASC_HudStockSectorId(const ASC_Layer1SymbolState &state)
  {
   return ASC_HudNormalizeBrowseId(state.classification.stock_sector_id, "needs_review");
  }

string ASC_HudStockSectorName(const ASC_Layer1SymbolState &state,const string sector_id)
  {
   if(StringLen(ASC_HudTrim(state.classification.stock_sector_name)) > 0)
      return ASC_HudBrowseNodeLabel(state.classification.stock_sector_name, sector_id);
   return "Needs Review";
  }

string ASC_HudStockIndustryId(const ASC_Layer1SymbolState &state)
  {
   return ASC_HudNormalizeBrowseId(state.classification.stock_industry_id, "needs_review");
  }

string ASC_HudStockIndustryName(const ASC_Layer1SymbolState &state,const string industry_id)
  {
   if(StringLen(ASC_HudTrim(state.classification.stock_industry_name)) > 0)
      return ASC_HudBrowseNodeLabel(state.classification.stock_industry_name, industry_id);
   return "Needs Review";
  }

int ASC_HudFindBrowseNode(const string key)
  {
   int left = 0;
   int right = ArraySize(g_asc_hud.browse_node_lookup) - 1;
   while(left <= right)
     {
      int mid = (left + right) / 2;
      string mid_key = g_asc_hud.browse_node_lookup[mid].key;
      if(mid_key == key)
         return g_asc_hud.browse_node_lookup[mid].index;
      if(mid_key < key)
         left = mid + 1;
      else
         right = mid - 1;
     }
   return -1;
  }

void ASC_HudInsertBrowseNodeLookup(const string key,const int slot)
  {
   int count = ArraySize(g_asc_hud.browse_node_lookup);
   int insert_at = 0;
   int left = 0;
   int right = count - 1;
   while(left <= right)
     {
      int mid = (left + right) / 2;
      string mid_key = g_asc_hud.browse_node_lookup[mid].key;
      if(mid_key == key)
        {
         g_asc_hud.browse_node_lookup[mid].index = slot;
         return;
        }
      if(mid_key < key)
         left = mid + 1;
      else
         right = mid - 1;
     }
   insert_at = left;

   ArrayResize(g_asc_hud.browse_node_lookup, count + 1, 64);
   for(int i = count; i > insert_at; i--)
      g_asc_hud.browse_node_lookup[i] = g_asc_hud.browse_node_lookup[i - 1];
   g_asc_hud.browse_node_lookup[insert_at].key = key;
   g_asc_hud.browse_node_lookup[insert_at].index = slot;
  }

int ASC_HudEnsureBrowseNode(const string key,
                            const string parent_key,
                            const ASC_HudBrowseNodeTier tier,
                            const string id,
                            const string label,
                            const string source)
  {
   int slot = ASC_HudFindBrowseNode(key);
   if(slot >= 0)
      return slot;

   int old_count = ArraySize(g_asc_hud.browse_nodes);
   ArrayResize(g_asc_hud.browse_nodes, old_count + 1, 64);
   slot = old_count;
   g_asc_hud.browse_nodes[slot].key = key;
   g_asc_hud.browse_nodes[slot].parent_key = parent_key;
   g_asc_hud.browse_nodes[slot].tier = tier;
   g_asc_hud.browse_nodes[slot].id = id;
   g_asc_hud.browse_nodes[slot].label = label;
   g_asc_hud.browse_nodes[slot].source = source;
   g_asc_hud.browse_nodes[slot].total = 0;
   g_asc_hud.browse_nodes[slot].open_count = 0;
   g_asc_hud.browse_nodes[slot].eligible_count = 0;
   g_asc_hud.browse_nodes[slot].first_child_slot = -1;
   g_asc_hud.browse_nodes[slot].last_child_slot = -1;
   g_asc_hud.browse_nodes[slot].next_sibling_slot = -1;
   g_asc_hud.browse_nodes[slot].canonical_scope_order = 2147483647;

   ASC_HudInsertBrowseNodeLookup(key, slot);

   if(StringLen(parent_key) > 0)
     {
      int parent_slot = ASC_HudFindBrowseNode(parent_key);
      if(parent_slot >= 0 && parent_slot < ArraySize(g_asc_hud.browse_nodes))
        {
         if(g_asc_hud.browse_nodes[parent_slot].first_child_slot < 0)
           {
            g_asc_hud.browse_nodes[parent_slot].first_child_slot = slot;
            g_asc_hud.browse_nodes[parent_slot].last_child_slot = slot;
           }
         else
           {
            int last_child_slot = g_asc_hud.browse_nodes[parent_slot].last_child_slot;
            if(last_child_slot >= 0 && last_child_slot < ArraySize(g_asc_hud.browse_nodes))
               g_asc_hud.browse_nodes[last_child_slot].next_sibling_slot = slot;
            g_asc_hud.browse_nodes[parent_slot].last_child_slot = slot;
           }
        }
     }
   return slot;
  }

void ASC_HudAccumulateBrowseNode(const int slot,const ASC_Layer1SymbolState &state)
  {
   if(slot < 0 || slot >= ArraySize(g_asc_hud.browse_nodes))
      return;
   g_asc_hud.browse_nodes[slot].total++;
   if(state.state == ASC_L1_OPEN)
      g_asc_hud.browse_nodes[slot].open_count++;
   if(state.classification.resolved)
      g_asc_hud.browse_nodes[slot].eligible_count++;
  }

string ASC_HudBrowseLeafKeyForState(const ASC_Layer1SymbolState &state,const string main_bucket_id)
  {
   if(!ASC_HudIsStockBucketId(main_bucket_id))
      return main_bucket_id + "|" + ASC_HudEffectiveSubBucketId(state, main_bucket_id);

   string family_id = ASC_HudStockFamilyId(state);
   string sector_id = ASC_HudStockSectorId(state);
   string industry_id = ASC_HudStockIndustryId(state);
   return "I|" + main_bucket_id + "|" + family_id + "|" + sector_id + "|" + industry_id;
  }

bool ASC_HudTryGetBrowseNode(const string key,ASC_HudBrowseNode &node)
  {
   int slot = ASC_HudFindBrowseNode(key);
   if(slot < 0)
      return false;
   node = g_asc_hud.browse_nodes[slot];
   return true;
  }

string ASC_HudBrowseNodePath(const string key,const bool include_root=false)
  {
   if(StringLen(key) <= 0)
      return "";

   string chain[];
   string cursor = key;
   int guard = 0;
   while(StringLen(cursor) > 0 && guard < 12)
     {
      ASC_HudBrowseNode node;
      if(!ASC_HudTryGetBrowseNode(cursor, node))
         break;
      if(include_root || node.tier != ASC_HUD_BROWSE_MAIN_BUCKET)
        {
         int old = ArraySize(chain);
         ArrayResize(chain, old + 1);
         chain[old] = node.label;
        }
      cursor = node.parent_key;
      guard++;
     }

   string out = "";
   for(int i = ArraySize(chain) - 1; i >= 0; i--)
     {
      if(StringLen(chain[i]) <= 0)
         continue;
      if(StringLen(out) > 0)
         out += " / ";
      out += chain[i];
     }
   return out;
  }

string ASC_HudOperatorClassificationPath(const ASC_Layer1SymbolState &state,const bool include_sub_industry=false)
  {
   string main_bucket_id = ASC_HudEffectiveMainBucketId(state);
   string main_bucket_name = ASC_HudMainBucketName(main_bucket_id);
   if(!ASC_HudIsStockBucketId(main_bucket_id))
     {
      string sub_bucket_name = ASC_HudEffectiveSubBucketName(state, main_bucket_id);
      return main_bucket_name + " / " + ASC_HudSubBucketDisplayName(main_bucket_name, sub_bucket_name);
     }

   string family_id = ASC_HudStockFamilyId(state);
   string family_name = ASC_HudStockFamilyName(state, family_id);
   string sector_name = ASC_HudTrim(state.classification.stock_sector_name);
   string industry_name = ASC_HudTrim(state.classification.stock_industry_name);
   string sub_industry_name = ASC_HudTrim(state.classification.stock_sub_industry_name);

   string path = main_bucket_name + " / " + family_name;
   if(StringLen(sector_name) > 0)
      path += " / " + ASC_HudHumanizeIdentifier(sector_name);
   else if(!state.classification.resolved)
      return path + " / Needs Review";

   if(StringLen(industry_name) > 0)
      path += " / " + ASC_HudHumanizeIdentifier(industry_name);
   if(include_sub_industry && StringLen(sub_industry_name) > 0)
      path += " / " + ASC_HudHumanizeIdentifier(sub_industry_name);
   return path;
  }

string ASC_HudCurrentStockBrowseHeading()
  {
   string parent_key = ASC_HudActiveStockBrowseParentKey();

   ASC_HudBrowseNode parent;
   if(!ASC_HudTryGetBrowseNode(parent_key, parent))
      return "Stock Groups";

   if(parent.tier == ASC_HUD_BROWSE_MAIN_BUCKET)
      return "Stock Family Groups";
   if(parent.tier == ASC_HUD_BROWSE_STOCK_FAMILY)
      return "Sector Groups";
   if(parent.tier == ASC_HUD_BROWSE_STOCK_SECTOR)
      return "Industry Groups";
   return "Stock Groups";
  }

string ASC_HudActiveStockBrowseParentKey()
  {
   string root_parent = "B|" + g_asc_hud.selected_bucket_id;
   string parent_key = g_asc_hud.selected_browse_parent_key;
   if(StringLen(parent_key) <= 0)
      return root_parent;
   if(!ASC_HudBrowseNodeHasAncestor(parent_key, root_parent))
      return root_parent;

   string candidate = parent_key;
   int guard = 0;
   while(StringLen(candidate) > 0 && guard < 16)
     {
      if(ASC_HudBrowseNodeValidForCurrentStockState(candidate, g_asc_hud.selected_bucket_id)
         && ASC_HudBrowseNodeHasAncestor(candidate, root_parent))
         return candidate;
      if(candidate == root_parent)
         break;
      string up_parent = ASC_HudBrowseParentKey(candidate);
      if(StringLen(up_parent) <= 0)
         break;
      candidate = up_parent;
      guard++;
     }
   return root_parent;
  }

string ASC_HudBrowseFilterSummary()
  {
   string main_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_main_bucket_filter, "all");
   string family_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_family_filter, "all");
   string sector_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_sector_filter, "all");
   string industry_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_industry_filter, "all");

   bool main_all = (main_filter == "all" || main_filter == "*" || main_filter == "any");
   bool family_all = (family_filter == "all" || family_filter == "*" || family_filter == "any");
   bool sector_all = (sector_filter == "all" || sector_filter == "*" || sector_filter == "any");
   bool industry_all = (industry_filter == "all" || industry_filter == "*" || industry_filter == "any");

   string summary = "Main: " + (main_all ? "All" : ASC_HudHumanizeIdentifier(main_filter));
   if(!family_all)
     {
      string family_label = ASC_HudStockFamilyOperatorLabel(family_filter);
      if(StringLen(family_label) <= 0)
         family_label = ASC_HudHumanizeIdentifier(family_filter);
      summary += " | Stock family: " + family_label;
     }
   if(!sector_all)
      summary += " | Sector: " + ASC_HudHumanizeIdentifier(sector_filter);
   if(!industry_all)
      summary += " | Industry: " + ASC_HudHumanizeIdentifier(industry_filter);
   return summary;
  }

bool ASC_HudControlIsAll(const string token)
  {
   string normalized = ASC_HudNormalizeBrowseId(token, "all");
   return (normalized == "all" || normalized == "*" || normalized == "any");
  }

bool ASC_HudBucketAllowedByControls(const string bucket_id)
  {
   string filter_id = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_main_bucket_filter, "all");
   if(ASC_HudControlIsAll(filter_id))
      return true;
   return (ASC_HudNormalizeBrowseId(bucket_id, "unknown") == filter_id);
  }

string ASC_HudBrowseAncestorIdForTier(const ASC_HudBrowseNode &node,const ASC_HudBrowseNodeTier tier)
  {
   if(node.tier == tier)
      return node.id;

   string cursor = node.parent_key;
   int guard = 0;
   while(StringLen(cursor) > 0 && guard < 12)
     {
      ASC_HudBrowseNode parent;
      if(!ASC_HudTryGetBrowseNode(cursor, parent))
         break;
      if(parent.tier == tier)
         return parent.id;
      cursor = parent.parent_key;
      guard++;
     }
   return "";
  }

bool ASC_HudBrowseNodeAllowedByControls(const ASC_HudBrowseNode &node)
  {
   if(!ASC_HudBucketAllowedByControls(g_asc_hud.selected_bucket_id))
      return false;
   if(!ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
      return true;

   string family_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_family_filter, "all");
   string sector_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_sector_filter, "all");
   string industry_filter = ASC_HudNormalizeBrowseId(g_asc_trader_controls.browse_stock_industry_filter, "all");

   string family_id = ASC_HudNormalizeBrowseId(ASC_HudBrowseAncestorIdForTier(node, ASC_HUD_BROWSE_STOCK_FAMILY), "all");
   string sector_id = ASC_HudNormalizeBrowseId(ASC_HudBrowseAncestorIdForTier(node, ASC_HUD_BROWSE_STOCK_SECTOR), "all");
   string industry_id = ASC_HudNormalizeBrowseId(ASC_HudBrowseAncestorIdForTier(node, ASC_HUD_BROWSE_STOCK_INDUSTRY), "all");

   if(!ASC_HudControlIsAll(family_filter) && family_id != family_filter)
      return false;
   if(!ASC_HudControlIsAll(sector_filter) && sector_id != sector_filter)
      return false;
   if(!ASC_HudControlIsAll(industry_filter) && industry_id != industry_filter)
      return false;
   return true;
  }

bool ASC_HudMaterializeSymbolState(const int index,ASC_Layer1SymbolState &state)
  {
   if(!ASC_Layer1GetCachedSymbol(index, state))
      return false;

   if(StringLen(state.symbol) <= 0)
     {
      string runtime_symbol = SymbolName(index, true);
      if(StringLen(runtime_symbol) > 0)
         state.symbol = runtime_symbol;
     }

   return (StringLen(state.symbol) > 0);
  }

string ASC_HudPageName(const ASC_HudPage page)
  {
   string markets = "Markets";
   string leaders = "Leaders";
   string groups = "Groups";
   switch(page)
     {
      case ASC_HUD_PAGE_MAIN_BUCKETS: return markets;
      case ASC_HUD_PAGE_BUCKET_LEADERS: return leaders;
      case ASC_HUD_PAGE_SUB_GROUPS: return groups;
      case ASC_HUD_PAGE_SYMBOLS: return "Symbols";
      case ASC_HUD_PAGE_GLOBAL_TOP10: return ASC_HudLabelGlobalTop10();
      case ASC_HUD_PAGE_SYMBOL_OVERVIEW: return "Overview";
      case ASC_HUD_PAGE_ASPECT_DETAIL: return ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section);
      default: return "Overview";
     }
  }

string ASC_HudLabelMarkets()
  {
   return "Markets";
  }

string ASC_HudLabelGroups()
  {
   return "Groups";
  }

string ASC_HudLabelLeaders()
  {
   return "Leaders";
  }

string ASC_HudBrowseRowButtonLabel(const ASC_HudPage page,const bool has_children=false,const ASC_HudBrowseNodeTier tier=ASC_HUD_BROWSE_MAIN_BUCKET)
  {
   if(page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return "Open";
   if(page == ASC_HUD_PAGE_SUB_GROUPS)
     {
      if(has_children)
        {
         if(tier == ASC_HUD_BROWSE_STOCK_FAMILY)
            return "Sectors";
         if(tier == ASC_HUD_BROWSE_STOCK_SECTOR)
            return "Industries";
         return "Open";
        }
      return "Symbols";
     }
   return "View";
  }

string ASC_HudLabelGlobalTop10()
  {
   return "Global Top 10";
  }

string ASC_HudGlobalTop10OverallLabel(const int rank)
  {
   if(rank <= 0)
      return "Overall pending";
   return "Overall " + IntegerToString(rank);
  }

string ASC_HudGlobalTop10PlacementLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total)
  {
   string line = ASC_HudGlobalTop10OverallLabel(entry.rank);
   if(shortlist_total > 0)
      line += " of " + IntegerToString(shortlist_total);

   string membership = ASC_ArtifactHumanizeLabel(entry.membership_state);
   if(StringLen(membership) <= 0 || membership == "Unavailable")
      membership = (entry.rank > 0 && entry.rank <= 3) ? "Promoted" : "Shortlisted";
   line += " | " + membership;
   return line;
  }

string ASC_HudGlobalTop10PremiumScopeLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total)
  {
   string bucket = ASC_HudEffectiveMainBucketName(entry.state);
   if(StringLen(bucket) <= 0)
      bucket = "Unclassified";

   string membership = ASC_ArtifactHumanizeLabel(entry.membership_state);
   if(StringLen(membership) <= 0 || membership == "Unavailable")
      membership = (entry.rank > 0 && entry.rank <= 3) ? "Promoted" : "Shortlisted";

   string line = ASC_HudGlobalTop10OverallLabel(entry.rank);
   if(shortlist_total > 0)
      line += " of " + IntegerToString(shortlist_total);
   line += " | Bucket " + bucket + " | Membership " + membership;
   return line;
  }

bool ASC_HudPageShowsHigherRefreshControl(const ASC_HudPage page)
  {
   return (page == ASC_HUD_PAGE_MAIN_BUCKETS
           || page == ASC_HUD_PAGE_BUCKET_LEADERS
           || page == ASC_HUD_PAGE_SUB_GROUPS
           || page == ASC_HUD_PAGE_SYMBOLS
           || page == ASC_HUD_PAGE_GLOBAL_TOP10);
  }

string ASC_HudHigherPageRefreshLabel(const ASC_HudPage page)
  {
   switch(page)
     {
      case ASC_HUD_PAGE_MAIN_BUCKETS:   return "Refresh Markets";
      case ASC_HUD_PAGE_BUCKET_LEADERS: return "Refresh Leaders";
      case ASC_HUD_PAGE_SUB_GROUPS:     return "Refresh Groups";
      case ASC_HUD_PAGE_SYMBOLS:        return "Refresh Symbols";
      case ASC_HUD_PAGE_GLOBAL_TOP10:   return "Refresh Top 10";
      default:                          return "Refresh Page";
     }
  }

string ASC_HudHigherPageRefreshNotice(const ASC_HudPage page,const bool board_refresh_queued)
  {
   switch(page)
     {
      case ASC_HUD_PAGE_MAIN_BUCKETS:   return "Markets scope refreshed from current lawful runtime readback.";
      case ASC_HUD_PAGE_BUCKET_LEADERS: return (board_refresh_queued
                                                ? "Leaders refresh queued; Market Board refresh requested."
                                                : "Leaders refresh queued; Market Board refresh is already pending.");
      case ASC_HUD_PAGE_SUB_GROUPS:     return "Groups refresh queued from the current bucket / subgroup readback.";
      case ASC_HUD_PAGE_SYMBOLS:        return "Symbols refresh queued from the current market/group readback.";
      case ASC_HUD_PAGE_GLOBAL_TOP10:   return "Global Top 10 refresh queued from current lawful shortlist/board carry.";
      default:                          return "Page refresh queued.";
     }
  }

bool ASC_HudGlobalTop10SnapshotReady(const ASC_RuntimeState &runtime,string &readiness_reason,string &snapshot_source,datetime &snapshot_utc)
  {
   readiness_reason = "";
   snapshot_source = "none";
   snapshot_utc = 0;

   if(runtime.l1_bootstrap_active)
     {
      readiness_reason = "warmup bootstrap still active";
      return false;
     }

   if(runtime.publication_shortlist_ready && ArraySize(runtime.publication_shortlist_rows) > 0)
     {
      snapshot_source = "published_shortlist_cache";
      snapshot_utc = runtime.publication_shortlist_pass_utc;
      readiness_reason = StringFormat("published shortlist cache ready with %d lawful rows", ArraySize(runtime.publication_shortlist_rows));
      return true;
     }

   if(runtime.committed_l4_ready && ArraySize(runtime.committed_l4_rows) > 0)
     {
      readiness_reason = StringFormat("committed Layer 4 runtime state has %d lawful rows but the published shortlist cache is not settled yet", ArraySize(runtime.committed_l4_rows));
      return false;
     }

   if(!runtime.l1_warmup_ready)
     {
      readiness_reason = "Layer 1 warmup is not complete yet and no settled published shortlist cache is available";
      return false;
     }

   readiness_reason = "Layer 4 shortlist truth is not settled yet";
   return false;
  }

void ASC_HudRefreshHigherPageScope(ASC_RuntimeState &runtime,string &notice_text,string &log_action,string &board_status,const string &click_symbol)
  {
   g_asc_hud.proof_refresh_request_seq++;

   ASC_HudInvalidateSelectedSymbolCache();
   ASC_HudQueueHeavyRefresh("higher_page_scope_refresh");

   bool board_refresh_queued = false;
   string downstream_status = "not_requested";
   string snapshot_reason = "not_applicable";
   string snapshot_source = "not_applicable";
   datetime snapshot_utc = 0;
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      g_asc_hud.proof_shortlist_refresh_count++;
      board_refresh_queued = ASC_HudRequestManualMarketBoardRefresh(runtime, board_status, "manual_hud_refresh_shortlist", "manual board refresh queued from HUD Refresh Shortlist control");
     }
   else if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
     {
      g_asc_hud.proof_shortlist_refresh_count++;
      bool snapshot_ready = ASC_HudGlobalTop10SnapshotReady(runtime, snapshot_reason, snapshot_source, snapshot_utc);
      if(snapshot_ready)
        {
         board_refresh_queued = ASC_HudRequestManualMarketBoardRefresh(runtime,
                                                                       board_status,
                                                                       "manual_hud_refresh_top10_snapshot",
                                                                       "snapshot-only Market Board publish queued from HUD Global Top 10 Refresh action using current settled shortlist carry");
        }
      else
        {
         board_status = "blocked_not_ready";
        }
     }

   ASC_HudMarkDirtyDataLight();
   ASC_HudRequestRedraw();
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
     {
      if(board_refresh_queued)
         notice_text = StringFormat("Global Top 10 snapshot publish queued from current settled truth. No downstream recalculation was requested. Source=%s | snapshot_utc=%s | Market Board=%s.",
                                    snapshot_source,
                                    ASC_FormatUtc(snapshot_utc),
                                    board_status);
      else if(board_status == "already_pending")
         notice_text = StringFormat("Global Top 10 snapshot publish was already pending. No downstream recalculation was requested. Source=%s | snapshot_utc=%s.",
                                    snapshot_source,
                                    ASC_FormatUtc(snapshot_utc));
      else
         notice_text = StringFormat("Global Top 10 is not ready for a fresh snapshot publish yet: %s. No downstream recalculation was requested.",
                                    snapshot_reason);
     }
   else
      notice_text = ASC_HudHigherPageRefreshNotice(g_asc_hud.page, board_refresh_queued);
   log_action = StringFormat("action=page_scope_refresh req_seq=%d page=%s board_refresh=%s board_status=%s downstream=%s snapshot_source=%s snapshot_utc=%s snapshot_reason=%s bucket=%s sub=%s symbol=%s",
                             g_asc_hud.proof_refresh_request_seq,
                             ASC_HudPageName(g_asc_hud.page),
                             board_refresh_queued ? "queued" : (StringLen(board_status) > 0 ? board_status : "not_needed_or_duplicate"),
                             board_status,
                             downstream_status,
                             snapshot_source,
                             ASC_FormatUtc(snapshot_utc),
                             snapshot_reason,
                             g_asc_hud.selected_bucket_id,
                             g_asc_hud.selected_sub_bucket_key,
                             click_symbol);
  }

bool ASC_HudPageHasHigherScopeRefresh(const ASC_HudPage page)
  {
   return (page == ASC_HUD_PAGE_MAIN_BUCKETS
           || page == ASC_HUD_PAGE_BUCKET_LEADERS
           || page == ASC_HUD_PAGE_SUB_GROUPS
           || page == ASC_HUD_PAGE_SYMBOLS
           || page == ASC_HUD_PAGE_GLOBAL_TOP10);
  }

bool ASC_HudPageHasDedicatedRankSurface(const ASC_HudPage page)
  {
   return (page == ASC_HUD_PAGE_BUCKET_LEADERS
           || page == ASC_HUD_PAGE_SYMBOLS
           || page == ASC_HUD_PAGE_GLOBAL_TOP10
           || page == ASC_HUD_PAGE_SYMBOL_OVERVIEW
           || page == ASC_HUD_PAGE_ASPECT_DETAIL);
  }

void ASC_HudBuildPageCommandSurface(const ASC_HudPage page,ASC_HudPageCommandSurface &surface)
  {
   surface.page = page;
   surface.scope_refresh_ready = ASC_HudPageHasHigherScopeRefresh(page);
   surface.shortlist_refresh_ready = (page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || page == ASC_HUD_PAGE_ASPECT_DETAIL);
   surface.dedicated_top10_route_ready = (page == ASC_HUD_PAGE_MAIN_BUCKETS
                                          || page == ASC_HUD_PAGE_BUCKET_LEADERS
                                          || page == ASC_HUD_PAGE_SUB_GROUPS
                                          || page == ASC_HUD_PAGE_SYMBOLS
                                          || page == ASC_HUD_PAGE_GLOBAL_TOP10);
   surface.visible_in_current_run = false;
   surface.board_refresh_path_ready = (page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || page == ASC_HUD_PAGE_ASPECT_DETAIL);
   surface.primary_command_label = ASC_HudPageShowsHigherRefreshControl(page) ? ASC_HudHigherPageRefreshLabel(page) : (surface.scope_refresh_ready ? "Page refresh available" : "View only");
   surface.secondary_command_label = surface.shortlist_refresh_ready ? "Refresh Shortlist" : (ASC_HudPageShowsHigherRefreshControl(page) ? "Current page route" : "Available in other pages");
   surface.authority_note = "HUD remains consumer-only; shortlist and board stay upstream owners.";
   surface.rollout_note = ASC_HudPageShowsHigherRefreshControl(page)
                          ? "Higher-page refresh is live through the existing page-command contract without adding HUD-owned rank math."
                          : (surface.scope_refresh_ready
                             ? "7.1 can wire higher-page refresh controls onto this contract without adding HUD-owned rank math."
                             : "Current page keeps existing symbol-only action flow in this run.");
  }

string ASC_HudPageCommandSummary(const ASC_HudPage page)
  {
   ASC_HudPageCommandSurface surface;
   ASC_HudBuildPageCommandSurface(page, surface);
   if(page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "Commands: Top 10 browse + refresh";
   if(page == ASC_HUD_PAGE_SYMBOLS)
      return "Commands: symbol browse + refresh";
   if(surface.scope_refresh_ready)
      return "Commands: page refresh available";
   if(surface.shortlist_refresh_ready)
      return "Commands: symbol actions available";
   return "Commands: browse";
  }

string ASC_HudPageRankSurfaceSummary(const ASC_HudPage page)
  {
   if(page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "Ranks: global Top 10";
   if(page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return "Ranks: bucket leaders + group carry";
   if(page == ASC_HUD_PAGE_SYMBOLS || page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || page == ASC_HUD_PAGE_ASPECT_DETAIL)
      return "Ranks: global, bucket, group, full-field";
   if(page == ASC_HUD_PAGE_SUB_GROUPS)
      return "Ranks: group scope + subgroup";
   return "Ranks: routing + breadth";
  }

bool ASC_HudBuildRankSurfaceReadback(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total,ASC_HudRankSurfaceReadback &readback)
  {
   readback.diversified_global_available = (entry.shortlisted && entry.rank > 0 && shortlist_total > 0);
   readback.main_bucket_available = (entry.bucket_rank > 0);
   readback.sub_bucket_available = (entry.sub_bucket_rank_available && entry.sub_bucket_rank > 0);
   readback.full_field_available = (entry.raw_rank > 0);
   readback.diversified_global_rank = readback.diversified_global_available
                                      ? ("#" + IntegerToString(entry.rank) + "/" + IntegerToString(shortlist_total))
                                      : "pending";
   readback.main_bucket_rank = readback.main_bucket_available
                               ? ("#" + IntegerToString(entry.bucket_rank))
                               : "n/a";
   readback.sub_bucket_rank = readback.sub_bucket_available
                              ? ("#" + IntegerToString(entry.sub_bucket_rank))
                             : "n/a";
   readback.full_field_rank = readback.full_field_available
                              ? ("#" + IntegerToString(entry.raw_rank))
                              : "n/a";
   readback.owner_path = "Overall, bucket, group, and full-field ranks follow shortlist and board data.";
   readback.owner_state_note = readback.sub_bucket_available
                               ? "Sub-group rank is precomputed upstream from the shortlist-owned scope seam; HUD only reads it."
                               : "Sub-group rank is n/a when that scope rank is not yet available.";
   return true;
  }

string ASC_HudRankSurfaceSummaryLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total)
  {
   return ASC_ShortlistRankStackReadbackText(entry, shortlist_total);
  }

string ASC_HudRankSurfaceOwnerLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total)
  {
   ASC_HudRankSurfaceReadback readback;
   ASC_HudBuildRankSurfaceReadback(entry, shortlist_total, readback);
   return readback.owner_path + " " + readback.owner_state_note;
  }

string ASC_HudSelectionLabel()
  {
   return "Selection";
  }

string ASC_HudShortlistLabel()
  {
   return "Shortlist";
  }

string ASC_HudDeepAnalysisLabel()
  {
   return "Full Analysis";
  }

string ASC_HudSymbolSectionName(const ASC_HudSymbolSectionFamily section)
  {
   switch(section)
     {
      case ASC_HUD_SYMBOL_SECTION_OVERVIEW: return "Overview";
      case ASC_HUD_SYMBOL_SECTION_MARKET_WATCH: return "Market Watch";
      case ASC_HUD_SYMBOL_SECTION_SPECIFICATION: return "Specs";
      case ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER: return ASC_HudSelectionLabel();
      case ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT: return ASC_HudShortlistLabel();
      case ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS: return ASC_HudDeepAnalysisLabel();
      case ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_A: return "Extra View A";
      case ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_B: return "Extra View B";
      default: return "Overview";
     }
  }

int ASC_HudSymbolSectionRowHeight(const int w)
  {
   // Keep the row pinned and readable on narrower and mid-width HUD widths by using two rows.
   if(w < 1400)
      return 56;
   return 32;
  }

string ASC_HudTradeModeText(const long trade_mode)
  {
   if(trade_mode == SYMBOL_TRADE_MODE_DISABLED)  return "disabled";
   if(trade_mode == SYMBOL_TRADE_MODE_LONGONLY)  return "long only";
   if(trade_mode == SYMBOL_TRADE_MODE_SHORTONLY) return "short only";
   if(trade_mode == SYMBOL_TRADE_MODE_CLOSEONLY) return "close only";
   if(trade_mode == SYMBOL_TRADE_MODE_FULL)      return "full";
   return "unavailable";
  }

string ASC_HudExecutionModeText(const long execution_mode)
  {
   if(execution_mode == SYMBOL_TRADE_EXECUTION_REQUEST) return "request";
   if(execution_mode == SYMBOL_TRADE_EXECUTION_INSTANT) return "instant";
   if(execution_mode == SYMBOL_TRADE_EXECUTION_MARKET)  return "market";
   if(execution_mode == SYMBOL_TRADE_EXECUTION_EXCHANGE) return "exchange";
  return "unavailable";
  }

string ASC_HudFillingModeText(const bool has_mode,const long mode_value)
  {
   if(!has_mode)
      return "unavailable";
   string parts = "";
   if((mode_value & ORDER_FILLING_FOK) == ORDER_FILLING_FOK)
      parts += "FOK, ";
   if((mode_value & ORDER_FILLING_IOC) == ORDER_FILLING_IOC)
      parts += "IOC, ";
   if((mode_value & ORDER_FILLING_RETURN) == ORDER_FILLING_RETURN)
      parts += "RETURN, ";
   if(StringLen(parts) <= 0)
      return "unavailable";
   return StringSubstr(parts, 0, StringLen(parts) - 2);
  }

string ASC_HudExpirationModeText(const bool has_mode,const long mode_value)
  {
   if(!has_mode)
      return "unavailable";
   string parts = "";
   if((mode_value & SYMBOL_EXPIRATION_GTC) == SYMBOL_EXPIRATION_GTC)
      parts += "GTC, ";
   if((mode_value & SYMBOL_EXPIRATION_DAY) == SYMBOL_EXPIRATION_DAY)
      parts += "DAY, ";
   if((mode_value & SYMBOL_EXPIRATION_SPECIFIED) == SYMBOL_EXPIRATION_SPECIFIED)
      parts += "SPECIFIED, ";
   if((mode_value & SYMBOL_EXPIRATION_SPECIFIED_DAY) == SYMBOL_EXPIRATION_SPECIFIED_DAY)
      parts += "SPECIFIED_DAY, ";
   if(StringLen(parts) <= 0)
      return "unavailable";
   return StringSubstr(parts, 0, StringLen(parts) - 2);
  }

string ASC_HudOrderModeText(const bool has_mode,const long mode_value)
  {
   if(!has_mode)
      return "unavailable";
   string parts = "";
   if((mode_value & SYMBOL_ORDER_MARKET) == SYMBOL_ORDER_MARKET)
      parts += "MARKET, ";
   if((mode_value & SYMBOL_ORDER_LIMIT) == SYMBOL_ORDER_LIMIT)
      parts += "LIMIT, ";
   if((mode_value & SYMBOL_ORDER_STOP) == SYMBOL_ORDER_STOP)
      parts += "STOP, ";
   if((mode_value & SYMBOL_ORDER_STOP_LIMIT) == SYMBOL_ORDER_STOP_LIMIT)
      parts += "STOP_LIMIT, ";
   if((mode_value & SYMBOL_ORDER_SL) == SYMBOL_ORDER_SL)
      parts += "SL, ";
   if((mode_value & SYMBOL_ORDER_TP) == SYMBOL_ORDER_TP)
      parts += "TP, ";
   if((mode_value & SYMBOL_ORDER_CLOSEBY) == SYMBOL_ORDER_CLOSEBY)
      parts += "CLOSEBY, ";
   if(StringLen(parts) <= 0)
      return "unavailable";
   return StringSubstr(parts, 0, StringLen(parts) - 2);
  }


string ASC_HudYesNo(const bool value)
  {
   return (value ? "Yes" : "No");
  }

string ASC_HudCurrentFocusPath()
  {
   return ASC_ServerRootPath() + "\\" + ASC_CURRENT_FOCUS_FILE;
  }

bool ASC_HudReadCurrentFocusText(string &text)
  {
   bool used_stale_cache = false;
   return ASC_HudReadCurrentFocusFileCached(text, used_stale_cache, "manual");
  }

void ASC_HudMarkCurrentFocusRefreshDeferred(const string reason)
  {
   g_asc_hud.current_focus_refresh_deferred = true;
   g_asc_hud.current_focus_refresh_deferred_reason = reason;
   g_asc_hud.current_focus_refresh_deferred_utc = TimeGMT();
   g_asc_hud.current_focus_cache_state = "refresh_deferred";
   g_asc_hud.current_focus_cache_posture = "Current Focus refresh deferred outside navigation";
   g_asc_hud.hud_nav_cache_deferred_count++;
   g_asc_hud.current_focus_refresh_deferred_count++;
   g_asc_hud.deep_parse_deferred_count++;
   g_asc_hud.hud_cache_refresh_pending_count++;
   g_asc_hud.hud_cache_placeholder_display_count++;
  }

bool ASC_HudCurrentFocusNavigationSafe(string &text,bool &used_stale_cache)
  {
   text = "";
   used_stale_cache = false;
   datetime now_utc = TimeGMT();
   if(StringLen(g_asc_hud.current_focus_cache_text) > 0)
     {
      bool stale_interval_elapsed = (g_asc_hud.current_focus_cache_last_read_utc <= 0
                                     || (now_utc - g_asc_hud.current_focus_cache_last_read_utc) >= ASC_HUD_CURRENT_FOCUS_CACHE_STALE_SEC);
      used_stale_cache = stale_interval_elapsed;
      text = g_asc_hud.current_focus_cache_text;
      g_asc_hud.current_focus_cache_state = stale_interval_elapsed ? "stale" : "fresh";
      g_asc_hud.current_focus_cache_posture = stale_interval_elapsed ? "cached Current Focus shown stale; refresh deferred" : "cached Current Focus shown fresh";
      g_asc_hud.hud_nav_cache_hit_count++;
      if(stale_interval_elapsed)
        {
         g_asc_hud.hud_cache_stale_display_count++;
         g_asc_hud.current_focus_cache_stale_count++;
         ASC_HudMarkCurrentFocusRefreshDeferred("navigation_stale_cache");
        }
      return true;
     }

   g_asc_hud.hud_nav_cache_miss_count++;
   ASC_HudMarkCurrentFocusRefreshDeferred("navigation_cache_missing");
   g_asc_hud.current_focus_cache_state = "missing";
   g_asc_hud.current_focus_cache_posture = "Current Focus cache missing; background/manual refresh required";
   return false;
  }

bool ASC_HudReadCurrentFocusCached(string &text,bool &used_stale_cache)
  {
   // RUN104R: render/navigation callers are deliberately cache-only. They must not
   // check file modification time or call ASC_ReadTextFile while the operator is changing pages.
   g_asc_hud.hud_current_focus_cache_read_count++;
   return ASC_HudCurrentFocusNavigationSafe(text, used_stale_cache);
  }

bool ASC_HudReadCurrentFocusFileCached(string &text,bool &used_stale_cache,const string access_class)
  {
   g_asc_hud.hud_current_focus_file_read_count++;
   used_stale_cache = false;
   text = "";

   datetime now_utc = TimeGMT();
   datetime known_modified_utc = 0;
   bool has_known_modified_utc = ASC_FileTryGetModifyUtc(ASC_HudCurrentFocusPath(), known_modified_utc);
   bool file_change_detected = false;
   if(has_known_modified_utc)
      file_change_detected = (known_modified_utc != g_asc_hud.current_focus_cache_last_modified_utc);
   else if(g_asc_hud.current_focus_cache_last_modified_utc > 0)
      file_change_detected = true;

   bool stale_interval_elapsed = (g_asc_hud.current_focus_cache_last_read_utc <= 0
                                  || (now_utc - g_asc_hud.current_focus_cache_last_read_utc) >= ASC_HUD_CURRENT_FOCUS_CACHE_STALE_SEC);
   bool need_refresh = (StringLen(g_asc_hud.current_focus_cache_text) <= 0 || stale_interval_elapsed || file_change_detected);

   if(need_refresh)
     {
      string fresh_text = "";
      if(ASC_ReadTextFile(ASC_HudCurrentFocusPath(), fresh_text))
        {
         g_asc_hud.proof_hud_file_read_count++;
         g_asc_hud.proof_current_focus_read_count++;
         if(access_class == "manual")
            g_asc_hud.hud_manual_cache_read_count++;
         else
            g_asc_hud.hud_background_cache_read_count++;
         g_asc_hud.current_focus_cache_text = fresh_text;
         g_asc_hud.current_focus_cache_last_read_utc = now_utc;
         g_asc_hud.current_focus_cache_last_modified_utc = (has_known_modified_utc ? known_modified_utc : 0);
         g_asc_hud.current_focus_cache_state = "fresh";
         g_asc_hud.current_focus_cache_posture = "Current Focus cache refreshed outside ordinary navigation";
         g_asc_hud.current_focus_refresh_deferred = false;
         g_asc_hud.current_focus_refresh_deferred_reason = "";
         g_asc_hud.current_focus_refresh_deferred_utc = 0;
         ASC_HudBuildCurrentFocusViewModel(fresh_text, true, false);
        }
      else
        {
         if(StringLen(g_asc_hud.current_focus_cache_text) > 0
            && g_asc_hud.current_focus_cache_last_read_utc > 0
            && (now_utc - g_asc_hud.current_focus_cache_last_read_utc) <= ASC_HUD_CURRENT_FOCUS_CACHE_MAX_STALE_SEC)
           {
            used_stale_cache = true;
            g_asc_hud.current_focus_cache_state = "stale";
            g_asc_hud.current_focus_cache_posture = "Current Focus file refresh failed; stale cache retained";
            g_asc_hud.hud_cache_stale_display_count++;
           }
         else
           {
            g_asc_hud.current_focus_cache_state = "manual_refresh_required";
            g_asc_hud.current_focus_cache_posture = "Current Focus unavailable; manual refresh required";
            return false;
           }
        }
     }

   if(StringLen(g_asc_hud.current_focus_cache_text) <= 0)
      return false;

   text = g_asc_hud.current_focus_cache_text;
   return true;
  }

void ASC_HudBuildCurrentFocusViewModel(const string text,const bool has_current_focus,const bool used_stale_cache)
  {
   if(!has_current_focus || StringLen(text) <= 0)
     {
      g_asc_hud.cf_vm_symbol = "";
      g_asc_hud.cf_vm_canonical = "";
      g_asc_hud.cf_vm_deep_posture = "";
      g_asc_hud.cf_vm_deep_summary = "";
      g_asc_hud.cf_vm_score_context = "";
      g_asc_hud.cf_vm_microstructure = "";
      g_asc_hud.cf_vm_refresh_request_id = "";
      g_asc_hud.cf_vm_published = "";
      g_asc_hud.cf_vm_completed_truth = false;
      g_asc_hud.cf_vm_sweep_state = "";
      g_asc_hud.cf_vm_bias_summary = "Bias S/M/H: pending";
      g_asc_hud.cf_vm_deep_readiness_summary = "subsections ready 0/8";
      g_asc_hud.cf_vm_timeframe_preview = "timeframe summary preview unavailable";
      g_asc_hud.cf_vm_timeframe_row_count = 0;
      ArrayResize(g_asc_hud.cf_vm_timeframe_rows, 9);
      for(int row_i = 0; row_i < 9; row_i++)
         g_asc_hud.cf_vm_timeframe_rows[row_i] = "";
      return;
     }

   g_asc_hud.cf_vm_symbol = ASC_HudCurrentFocusValue(text, "Canonical Symbol:", "Symbol:", "Focus Symbol:");
   g_asc_hud.cf_vm_canonical = ASC_HudCurrentFocusValue(text, "Canonical Symbol:", "Symbol:", "- Symbol:");
   g_asc_hud.cf_vm_deep_posture = ASC_HudCurrentFocusValue(text, "Deep Analysis Posture:", "- Deep Analysis Posture:", "Deep Analysis Outcome:");
   g_asc_hud.cf_vm_deep_summary = ASC_HudCurrentFocusValue(text, "Deep Analysis Summary:", "- Deep Analysis Summary:", "Deep Analysis Overview:");
   g_asc_hud.cf_vm_score_context = ASC_HudCurrentFocusValue(text, "Deep Score Context:", "score_context=");
   g_asc_hud.cf_vm_microstructure = ASC_HudCurrentFocusValue(text, "Deep Microstructure Summary:", "microstructure=");
   g_asc_hud.cf_vm_refresh_request_id = ASC_HudCurrentFocusValue(text, "Refresh Request Id:", "explicit_request_id=");
   g_asc_hud.cf_vm_published = ASC_HudCurrentFocusValue(text, "Publication UTC:", "Published At (UTC):", "Generated At:");
   g_asc_hud.cf_vm_completed_truth = ASC_DossierDeepSectionHasCompletedTruth(text);
   g_asc_hud.cf_vm_sweep_state = ASC_HudCurrentFocusValue(text, "Sweep State:", "Sweep:", "Liquidity Sweep State:");
   ArrayResize(g_asc_hud.cf_vm_timeframe_rows, 9);
   g_asc_hud.hud_deep_parse_attempt_count++;
   uint deep_parse_started_ms = GetTickCount();
   ASC_HudBuildDeepSectionViewModel(text,
                                    g_asc_hud.cf_vm_timeframe_preview,
                                    g_asc_hud.cf_vm_bias_summary,
                                    g_asc_hud.cf_vm_deep_readiness_summary,
                                    g_asc_hud.cf_vm_timeframe_rows,
                                    g_asc_hud.cf_vm_timeframe_row_count);
   g_asc_hud.hud_deep_parse_elapsed_last_ms = GetTickCount() - deep_parse_started_ms;
   if(g_asc_hud.hud_deep_parse_elapsed_last_ms > g_asc_hud.hud_deep_parse_elapsed_max_ms)
      g_asc_hud.hud_deep_parse_elapsed_max_ms = g_asc_hud.hud_deep_parse_elapsed_last_ms;
   g_asc_hud.view_model_current_focus_summary = (used_stale_cache ? "stale Current Focus cache" : "fresh Current Focus cache") + " | " + ASC_TextOrUnavailable(g_asc_hud.cf_vm_deep_summary);
  }

void ASC_HudBuildNavigationViewModel(const ASC_RuntimeState &runtime,const string reason)
  {
   uint started_ms = GetTickCount();
   g_asc_hud.view_model_page_type = ASC_HudPageName(g_asc_hud.page);
   g_asc_hud.view_model_bucket = g_asc_hud.selected_bucket_id;
   g_asc_hud.view_model_sub_bucket = g_asc_hud.selected_sub_bucket_key;
   g_asc_hud.view_model_selected_symbol = g_asc_hud.selected_symbol;
   g_asc_hud.view_model_selected_display_name = g_asc_hud.selected_symbol;
   g_asc_hud.view_model_market_state_label = "cached runtime state";
   g_asc_hud.view_model_actionable_posture_label = "display-only HUD cache";
   g_asc_hud.view_model_currentness_label = g_asc_hud.current_focus_cache_state;
   g_asc_hud.view_model_market_board_summary = "Market Board: runtime shortlist cache only during navigation";
   g_asc_hud.view_model_cache_posture = g_asc_hud.current_focus_cache_posture;
   g_asc_hud.view_model_version = "RUN104R_NAV_SAFE_VM";
   g_asc_hud.view_model_dirty_reason = reason;
   g_asc_hud.hud_view_model_dirty_reason = reason;
   g_asc_hud.view_model_cache_hit = (StringLen(g_asc_hud.current_focus_cache_text) > 0);
   g_asc_hud.view_model_cache_miss = !g_asc_hud.view_model_cache_hit;
   if(g_asc_hud.view_model_cache_hit)
      g_asc_hud.hud_view_model_hit_count++;
   else
      g_asc_hud.hud_view_model_miss_count++;
   g_asc_hud.view_model_last_built_ms = GetTickCount() - started_ms;
   g_asc_hud.hud_view_model_build_ms = g_asc_hud.view_model_last_built_ms;
  }


string ASC_HudCurrentFocusValue(const string text,const string label_a,const string label_b="",const string label_c="")
  {
   string value = "";
   if(StringLen(label_a) > 0)
      value = ASC_HudExtractLabeledValue(text, label_a);
   if(StringLen(value) <= 0 && StringLen(label_b) > 0)
      value = ASC_HudExtractLabeledValue(text, label_b);
   if(StringLen(value) <= 0 && StringLen(label_c) > 0)
      value = ASC_HudExtractLabeledValue(text, label_c);
   return value;
  }

string ASC_HudDeepSummaryPreview(const string current_focus_text,const string fallback_label,const string primary_label,const string secondary_label="")
  {
   string value = ASC_HudCurrentFocusValue(current_focus_text, primary_label, secondary_label);
   if(StringLen(value) <= 0)
      return fallback_label + " unavailable";
   return fallback_label + ": " + value;
  }

string ASC_HudDeepTacticalPreview(const string current_focus_text)
  {
   return ASC_HudDeepSummaryPreview(current_focus_text,
                                    "Tactical snapshot",
                                    "Deep Tactical Snapshot:",
                                    "summary=");
  }

string ASC_HudDeepContextPreview(const string current_focus_text)
  {
   string structure = ASC_HudCurrentFocusValue(current_focus_text,
                                               "Deep Structure/Liquidity:",
                                               "structure_liquidity=");
   string session = ASC_HudCurrentFocusValue(current_focus_text,
                                             "Deep Session Timing:",
                                             "session_timing=");
   string score = ASC_HudCurrentFocusValue(current_focus_text,
                                           "Deep Score Context:",
                                           "score_context=");
   string micro = ASC_HudCurrentFocusValue(current_focus_text,
                                           "Deep Microstructure Summary:",
                                           "microstructure=");

   string preview = "";
   if(StringLen(structure) > 0)
      preview += "Structure: " + structure;
   if(StringLen(session) > 0)
      preview += (StringLen(preview) > 0 ? " || " : "") + "Session: " + session;
   if(StringLen(score) > 0)
      preview += (StringLen(preview) > 0 ? " || " : "") + "Score: " + score;
   if(StringLen(micro) > 0)
      preview += (StringLen(preview) > 0 ? " || " : "") + "Micro: " + micro;
   if(StringLen(preview) <= 0)
      return "Full Analysis context preview unavailable";
   return preview;
  }

bool ASC_HudFindShortlistEntry(const string symbol,ASC_ShortlistSymbolSummary &entry,int &rank_out,int &total_out)
  {
   return ASC_HudResolveShortlistLookup(symbol, entry, rank_out, total_out);
  }

bool ASC_HudFindShortlistEntryForState(const ASC_Layer1SymbolState &state,ASC_ShortlistSymbolSummary &entry,int &rank_out,int &total_out)
  {
   if(ASC_HudResolveShortlistLookup(state.symbol, entry, rank_out, total_out))
      return true;
   if(ASC_HudResolveShortlistLookup(state.identity.normalized_symbol, entry, rank_out, total_out))
      return true;
   if(ASC_HudResolveShortlistLookup(state.classification.canonical_symbol, entry, rank_out, total_out))
      return true;
   if(ASC_HudResolveShortlistLookup(state.identity.canonical_symbol, entry, rank_out, total_out))
      return true;
   return false;
  }

int ASC_HudScopedShortlistCount(const string bucket_id,const string sub_bucket_key)
  {
   int count = 0;
   bool use_browse_leaf_scope = (StringFind(sub_bucket_key, "I|") == 0);
   string selected_sub_id = "";
   int divider = StringFind(sub_bucket_key, "|");
   if(!use_browse_leaf_scope && divider >= 0 && divider + 1 < StringLen(sub_bucket_key))
      selected_sub_id = StringSubstr(sub_bucket_key, divider + 1);

   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      if(!g_asc_hud_shortlist_rows[i].shortlisted || g_asc_hud_shortlist_rows[i].rank <= 0)
         continue;
      string effective_main_bucket_id = ASC_HudEffectiveMainBucketId(g_asc_hud_shortlist_rows[i].state);
      string effective_sub_bucket_id = ASC_HudEffectiveSubBucketId(g_asc_hud_shortlist_rows[i].state, effective_main_bucket_id);
      if(StringLen(bucket_id) > 0 && effective_main_bucket_id != bucket_id)
         continue;
      if(use_browse_leaf_scope)
        {
         string shortlist_leaf_key = ASC_HudBrowseLeafKeyForState(g_asc_hud_shortlist_rows[i].state, effective_main_bucket_id);
         if(shortlist_leaf_key != sub_bucket_key)
            continue;
        }
      if(StringLen(selected_sub_id) > 0 && effective_sub_bucket_id != selected_sub_id)
         continue;
      count++;
     }

   return count;
  }

int ASC_HudFindScopeRankingCacheSlot(const string scope_key)
  {
   if(StringLen(scope_key) <= 0)
      return -1;
   return ASC_HudFindLookupIndex(g_asc_hud_scope_ranking_lookup, scope_key);
  }

void ASC_HudAccumulateScopeRankingStats(const string scope_key,
                                        const bool is_ranking_pass,
                                        const bool is_shortlisted_ranked,
                                        const int rank,
                                        const double score)
  {
   if(StringLen(scope_key) <= 0)
      return;

   int slot = ASC_HudFindScopeRankingCacheSlot(scope_key);
   if(slot < 0)
     {
      int old = ArraySize(g_asc_hud.scope_ranking_cache);
      ArrayResize(g_asc_hud.scope_ranking_cache, old + 1, 32);
      slot = old;
      g_asc_hud.scope_ranking_cache[slot].scope_key = scope_key;
      g_asc_hud.scope_ranking_cache[slot].stats.promoted_count = 0;
      g_asc_hud.scope_ranking_cache[slot].stats.ranked_count = 0;
      g_asc_hud.scope_ranking_cache[slot].stats.top_rank = 0;
      g_asc_hud.scope_ranking_cache[slot].stats.top_score = 0.0;
      g_asc_hud.scope_ranking_cache[slot].stats.ranked_available = false;
      ASC_HudInsertLookupEntrySorted(g_asc_hud_scope_ranking_lookup, scope_key, slot, 32);
     }

   if(is_ranking_pass)
     {
      g_asc_hud.scope_ranking_cache[slot].stats.ranked_count++;
      if(!g_asc_hud.scope_ranking_cache[slot].stats.ranked_available
         || score > g_asc_hud.scope_ranking_cache[slot].stats.top_score)
         g_asc_hud.scope_ranking_cache[slot].stats.top_score = score;
      g_asc_hud.scope_ranking_cache[slot].stats.ranked_available = true;
     }

   if(is_shortlisted_ranked)
     {
      g_asc_hud.scope_ranking_cache[slot].stats.promoted_count++;
      if(g_asc_hud.scope_ranking_cache[slot].stats.top_rank <= 0
         || rank < g_asc_hud.scope_ranking_cache[slot].stats.top_rank)
         g_asc_hud.scope_ranking_cache[slot].stats.top_rank = rank;
     }
  }

void ASC_HudRebuildScopeRankingCache()
  {
   ArrayResize(g_asc_hud.scope_ranking_cache, 0);
   ArrayResize(g_asc_hud_scope_ranking_lookup, 0);
   if(ArraySize(g_asc_hud_shortlist_rows) <= 0)
      return;

   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      string main_bucket_id = ASC_HudEffectiveMainBucketId(g_asc_hud_shortlist_rows[i].state);
      string sub_bucket_id = ASC_HudEffectiveSubBucketId(g_asc_hud_shortlist_rows[i].state, main_bucket_id);
      string bucket_scope = "B|" + main_bucket_id;
      string sub_scope = "S|" + main_bucket_id + "|" + sub_bucket_id;
      bool is_ranking_pass = (g_asc_hud_shortlist_rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS);
      bool is_shortlisted_ranked = (g_asc_hud_shortlist_rows[i].shortlisted && g_asc_hud_shortlist_rows[i].rank > 0);
      int rank = g_asc_hud_shortlist_rows[i].rank;
      double score = g_asc_hud_shortlist_rows[i].shortlist_score;

      ASC_HudAccumulateScopeRankingStats(bucket_scope, is_ranking_pass, is_shortlisted_ranked, rank, score);
      ASC_HudAccumulateScopeRankingStats(sub_scope, is_ranking_pass, is_shortlisted_ranked, rank, score);
     }
   if(ArraySize(g_asc_hud_scope_ranking_lookup) > 1)
      ASC_HudSortLookupEntries(g_asc_hud_scope_ranking_lookup, 0, ArraySize(g_asc_hud_scope_ranking_lookup) - 1);
  }

void ASC_HudBuildScopeRankingStats(const string bucket_id,const string sub_bucket_key,ASC_HudScopeRankingStats &stats)
  {
   stats.promoted_count = 0;
   stats.ranked_count = 0;
   stats.top_rank = 0;
   stats.top_score = 0.0;
   stats.ranked_available = false;
   string scope_key = (StringLen(sub_bucket_key) > 0 ? ("S|" + sub_bucket_key) : ("B|" + bucket_id));
   int slot = ASC_HudFindScopeRankingCacheSlot(scope_key);
   if(slot >= 0)
      stats = g_asc_hud.scope_ranking_cache[slot].stats;
  }

void ASC_HudTrackFamilyVisibility(bool &current,const bool next,int &counter)
  {
   if(current == next)
      return;
   current = next;
   counter++;
  }

int ASC_HudBucketOrderIndex(const string bucket_id)
  {
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
      if(g_asc_hud.buckets[i].id == bucket_id)
         return i;
   return 1000;
  }

void ASC_HudResetCanonicalAggregateMaps()
  {
   ArrayResize(g_asc_hud.canonical_bucket_metrics, 0);
   ArrayResize(g_asc_hud.canonical_bucket_metric_lookup, 0);
   ArrayResize(g_asc_hud.canonical_subgroup_metrics, 0);
   ArrayResize(g_asc_hud.canonical_subgroup_metric_lookup, 0);
   ArrayResize(g_asc_hud.canonical_browse_metrics, 0);
   ArrayResize(g_asc_hud.canonical_browse_metric_lookup, 0);
  }

int ASC_HudEnsureCanonicalAggregateSlot(ASC_HudCanonicalAggregateMetrics &rows[],
                                        ASC_HudLookupEntry &lookup[],
                                        const string key)
  {
   if(StringLen(key) <= 0)
      return -1;
   int lookup_slot = ASC_HudFindLookupIndex(lookup, key);
   if(lookup_slot >= 0)
      return lookup[lookup_slot].index;

   int old = ArraySize(rows);
   ArrayResize(rows, old + 1, 64);
   rows[old].best_global_rank = 2147483647;
   rows[old].best_bucket_rank = 2147483647;
   rows[old].best_raw_rank = 2147483647;
   rows[old].promoted_count = 0;
   rows[old].ranked_count = 0;
   ASC_HudInsertLookupEntrySorted(lookup, key, old, 64);
   return old;
  }

void ASC_HudAccumulateCanonicalAggregateMetrics(ASC_HudCanonicalAggregateMetrics &rows[],
                                                ASC_HudLookupEntry &lookup[],
                                                const string key,
                                                const int global_rank,
                                                const int bucket_rank,
                                                const int raw_rank,
                                                const bool promoted,
                                                const bool ranked)
  {
   int slot = ASC_HudEnsureCanonicalAggregateSlot(rows, lookup, key);
   if(slot < 0)
      return;

   if(global_rank > 0 && global_rank < rows[slot].best_global_rank)
      rows[slot].best_global_rank = global_rank;
   if(bucket_rank > 0 && bucket_rank < rows[slot].best_bucket_rank)
      rows[slot].best_bucket_rank = bucket_rank;
   if(raw_rank > 0 && raw_rank < rows[slot].best_raw_rank)
      rows[slot].best_raw_rank = raw_rank;
   if(promoted)
      rows[slot].promoted_count++;
   if(ranked)
      rows[slot].ranked_count++;
  }

bool ASC_HudTryGetCanonicalAggregateMetrics(const ASC_HudCanonicalAggregateMetrics &rows[],
                                            const ASC_HudLookupEntry &lookup[],
                                            const string key,
                                            ASC_HudCanonicalAggregateMetrics &metrics)
  {
   int lookup_slot = ASC_HudFindLookupIndex(lookup, key);
   if(lookup_slot < 0)
      return false;
   int slot = lookup[lookup_slot].index;
   if(slot < 0 || slot >= ArraySize(rows))
      return false;
   metrics = rows[slot];
   return true;
  }

void ASC_HudRebuildCanonicalAggregateMaps()
  {
   ASC_HudResetCanonicalAggregateMaps();
   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      ASC_ShortlistSymbolSummary row = g_asc_hud_shortlist_rows[i];
      string main_bucket_id = ASC_HudEffectiveMainBucketId(row.state);
      string sub_bucket_id = ASC_HudEffectiveSubBucketId(row.state, main_bucket_id);
      bool promoted = (row.shortlisted && row.rank > 0);
      bool ranked = (row.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS);

      ASC_HudAccumulateCanonicalAggregateMetrics(g_asc_hud.canonical_bucket_metrics,
                                                 g_asc_hud.canonical_bucket_metric_lookup,
                                                 "B|" + main_bucket_id,
                                                 row.rank,
                                                 row.bucket_rank,
                                                 row.raw_rank,
                                                 promoted,
                                                 ranked);

      ASC_HudAccumulateCanonicalAggregateMetrics(g_asc_hud.canonical_subgroup_metrics,
                                                 g_asc_hud.canonical_subgroup_metric_lookup,
                                                 "S|" + main_bucket_id + "|" + sub_bucket_id,
                                                 row.rank,
                                                 row.bucket_rank,
                                                 row.raw_rank,
                                                 promoted,
                                                 ranked);

      ASC_HudAccumulateCanonicalAggregateMetrics(g_asc_hud.canonical_browse_metrics,
                                                 g_asc_hud.canonical_browse_metric_lookup,
                                                 "B|" + main_bucket_id,
                                                 row.rank,
                                                 row.bucket_rank,
                                                 row.raw_rank,
                                                 promoted,
                                                 ranked);

      if(ASC_HudIsStockBucketId(main_bucket_id))
        {
         string family_id = ASC_HudStockFamilyId(row.state);
         string sector_id = ASC_HudStockSectorId(row.state);
         string industry_id = ASC_HudStockIndustryId(row.state);

         ASC_HudAccumulateCanonicalAggregateMetrics(g_asc_hud.canonical_browse_metrics,
                                                    g_asc_hud.canonical_browse_metric_lookup,
                                                    "F|" + main_bucket_id + "|" + family_id,
                                                    row.rank,
                                                    row.bucket_rank,
                                                    row.raw_rank,
                                                    promoted,
                                                    ranked);
         ASC_HudAccumulateCanonicalAggregateMetrics(g_asc_hud.canonical_browse_metrics,
                                                    g_asc_hud.canonical_browse_metric_lookup,
                                                    "S|" + main_bucket_id + "|" + family_id + "|" + sector_id,
                                                    row.rank,
                                                    row.bucket_rank,
                                                    row.raw_rank,
                                                    promoted,
                                                    ranked);
         ASC_HudAccumulateCanonicalAggregateMetrics(g_asc_hud.canonical_browse_metrics,
                                                    g_asc_hud.canonical_browse_metric_lookup,
                                                    "I|" + main_bucket_id + "|" + family_id + "|" + sector_id + "|" + industry_id,
                                                    row.rank,
                                                    row.bucket_rank,
                                                    row.raw_rank,
                                                    promoted,
                                                    ranked);
        }
     }
  }

int ASC_HudCanonicalBucketGlobalOrder(const string bucket_id)
  {
   ASC_HudCanonicalAggregateMetrics metrics;
   if(!ASC_HudTryGetCanonicalAggregateMetrics(g_asc_hud.canonical_bucket_metrics,
                                              g_asc_hud.canonical_bucket_metric_lookup,
                                              "B|" + bucket_id,
                                              metrics))
      return 2147483647;
   if(metrics.best_global_rank < 2147483647)
      return metrics.best_global_rank;
   if(metrics.best_bucket_rank < 2147483647)
      return 1000000 + metrics.best_bucket_rank;
   if(metrics.best_raw_rank < 2147483647)
      return 2000000 + metrics.best_raw_rank;
   return 2147483647;
  }

int ASC_HudCanonicalSubBucketOrder(const string bucket_id,const string sub_bucket_id)
  {
   ASC_HudCanonicalAggregateMetrics metrics;
   if(!ASC_HudTryGetCanonicalAggregateMetrics(g_asc_hud.canonical_subgroup_metrics,
                                              g_asc_hud.canonical_subgroup_metric_lookup,
                                              "S|" + bucket_id + "|" + sub_bucket_id,
                                              metrics))
      return 2147483647;
   if(metrics.best_global_rank < 2147483647)
      return metrics.best_global_rank;
   if(metrics.best_bucket_rank < 2147483647)
      return 1000000 + metrics.best_bucket_rank;
   if(metrics.best_raw_rank < 2147483647)
      return 2000000 + metrics.best_raw_rank;
   return 2147483647;
  }

void ASC_HudApplyCanonicalBucketOrder()
  {
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
      g_asc_hud.buckets[i].canonical_global_order = ASC_HudCanonicalBucketGlobalOrder(g_asc_hud.buckets[i].id);

   int n = ArraySize(g_asc_hud.buckets);
   for(int i = 1; i < n; i++)
     {
      ASC_HudBucketRow value = g_asc_hud.buckets[i];
      int j = i - 1;
      while(j >= 0)
        {
         bool comes_first = false;
         if(value.canonical_global_order != g_asc_hud.buckets[j].canonical_global_order)
            comes_first = (value.canonical_global_order < g_asc_hud.buckets[j].canonical_global_order);
         else if(value.total != g_asc_hud.buckets[j].total)
            comes_first = (value.total > g_asc_hud.buckets[j].total);
         else
            comes_first = (StringCompare(value.id, g_asc_hud.buckets[j].id) < 0);
         if(!comes_first)
            break;
         g_asc_hud.buckets[j + 1] = g_asc_hud.buckets[j];
         j--;
        }
      g_asc_hud.buckets[j + 1] = value;
     }
  }

void ASC_HudApplyCanonicalSubBucketOrder()
  {
   for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
      g_asc_hud.sub_buckets[i].canonical_bucket_order = ASC_HudCanonicalSubBucketOrder(g_asc_hud.sub_buckets[i].bucket_id,
                                                                                        g_asc_hud.sub_buckets[i].sub_bucket_id);

   int n = ArraySize(g_asc_hud.sub_buckets);
   for(int i = 1; i < n; i++)
     {
      ASC_HudSubBucketRow value = g_asc_hud.sub_buckets[i];
      int j = i - 1;
      while(j >= 0)
        {
         bool comes_first = false;
         int value_bucket_index = ASC_HudBucketOrderIndex(value.bucket_id);
         int left_bucket_index = ASC_HudBucketOrderIndex(g_asc_hud.sub_buckets[j].bucket_id);
         if(value_bucket_index != left_bucket_index)
            comes_first = (value_bucket_index < left_bucket_index);
         else if(value.canonical_bucket_order != g_asc_hud.sub_buckets[j].canonical_bucket_order)
            comes_first = (value.canonical_bucket_order < g_asc_hud.sub_buckets[j].canonical_bucket_order);
         else if(value.total != g_asc_hud.sub_buckets[j].total)
            comes_first = (value.total > g_asc_hud.sub_buckets[j].total);
         else
            comes_first = (StringCompare(value.key, g_asc_hud.sub_buckets[j].key) < 0);
         if(!comes_first)
            break;
         g_asc_hud.sub_buckets[j + 1] = g_asc_hud.sub_buckets[j];
         j--;
        }
      g_asc_hud.sub_buckets[j + 1] = value;
     }
  }

int ASC_HudCanonicalBrowseNodeOrder(const ASC_HudBrowseNode &node)
  {
   if(node.tier == ASC_HUD_BROWSE_STOCK_FAMILY)
      return ASC_HudCanonicalSubBucketOrder(ASC_HudBrowseAncestorIdForTier(node, ASC_HUD_BROWSE_MAIN_BUCKET), node.id);

   ASC_HudCanonicalAggregateMetrics metrics;
   if(!ASC_HudTryGetCanonicalAggregateMetrics(g_asc_hud.canonical_browse_metrics,
                                              g_asc_hud.canonical_browse_metric_lookup,
                                              node.key,
                                              metrics))
      return 2147483647;
   if(metrics.best_global_rank < 2147483647)
      return metrics.best_global_rank;
   if(metrics.best_bucket_rank < 2147483647)
      return 1000000 + metrics.best_bucket_rank;
   if(metrics.best_raw_rank < 2147483647)
      return 2000000 + metrics.best_raw_rank;
   return 2147483647;
  }

void ASC_HudApplyCanonicalBrowseNodeOrder()
  {
   for(int i = 0; i < ArraySize(g_asc_hud.browse_nodes); i++)
      g_asc_hud.browse_nodes[i].canonical_scope_order = ASC_HudCanonicalBrowseNodeOrder(g_asc_hud.browse_nodes[i]);

   for(int parent_slot = 0; parent_slot < ArraySize(g_asc_hud.browse_nodes); parent_slot++)
     {
      int child_slots[];
      ArrayResize(child_slots, 0);
      int child_slot = g_asc_hud.browse_nodes[parent_slot].first_child_slot;
      while(child_slot >= 0 && child_slot < ArraySize(g_asc_hud.browse_nodes))
        {
         int next = ArraySize(child_slots);
         ArrayResize(child_slots, next + 1);
         child_slots[next] = child_slot;
         child_slot = g_asc_hud.browse_nodes[child_slot].next_sibling_slot;
        }
      int child_count = ArraySize(child_slots);
      if(child_count <= 1)
         continue;

      for(int i = 1; i < child_count; i++)
        {
         int value = child_slots[i];
         int j = i - 1;
         while(j >= 0)
           {
            ASC_HudBrowseNode value_node = g_asc_hud.browse_nodes[value];
            ASC_HudBrowseNode left_node = g_asc_hud.browse_nodes[child_slots[j]];
            bool comes_first = false;
            if(value_node.canonical_scope_order != left_node.canonical_scope_order)
               comes_first = (value_node.canonical_scope_order < left_node.canonical_scope_order);
            else if(value_node.total != left_node.total)
               comes_first = (value_node.total > left_node.total);
            else
               comes_first = (StringCompare(value_node.key, left_node.key) < 0);
            if(!comes_first)
               break;
            child_slots[j + 1] = child_slots[j];
            j--;
           }
         child_slots[j + 1] = value;
        }

      g_asc_hud.browse_nodes[parent_slot].first_child_slot = child_slots[0];
      g_asc_hud.browse_nodes[parent_slot].last_child_slot = child_slots[child_count - 1];
      for(int i = 0; i < child_count; i++)
        {
         int next_sibling = (i + 1 < child_count) ? child_slots[i + 1] : -1;
         g_asc_hud.browse_nodes[child_slots[i]].next_sibling_slot = next_sibling;
        }
     }
  }

bool ASC_HudStateMatchesSelectedScope(const ASC_Layer1SymbolState &state)
  {
   string effective_main_bucket_id = ASC_HudEffectiveMainBucketId(state);
   if(StringLen(g_asc_hud.selected_bucket_id) > 0
      && effective_main_bucket_id != g_asc_hud.selected_bucket_id)
      return false;

   if(StringLen(g_asc_hud.selected_sub_bucket_key) > 0)
     {
      if(ASC_HudIsStockBucketId(effective_main_bucket_id))
        {
         string leaf_key = ASC_HudBrowseLeafKeyForState(state, effective_main_bucket_id);
         if(g_asc_hud.selected_sub_bucket_key != leaf_key
            && !ASC_HudBrowseNodeHasAncestor(leaf_key, g_asc_hud.selected_sub_bucket_key))
            return false;
        }
      else
        {
         string sub_id = ASC_HudEffectiveSubBucketId(state, effective_main_bucket_id);
         string key = effective_main_bucket_id + "|" + sub_id;
         if(key != g_asc_hud.selected_sub_bucket_key)
            return false;
        }
     }

   return true;
  }

bool ASC_HudResolveSelectionTruth(const ASC_Layer1SymbolState &state,
                                  ASC_ShortlistSymbolSummary &shortlist_entry,
                                  int &shortlist_rank,
                                  int &shortlist_total,
                                  ASC_SelectionFilterEvaluation &filter_out,
                                  bool &has_filter_out,
                                  bool &has_packet_out,
                                  double &score_out)
  {
   bool shortlist_found = ASC_HudFindShortlistEntryForState(state, shortlist_entry, shortlist_rank, shortlist_total);
   has_filter_out = false;
   has_packet_out = false;
   score_out = 0.0;

   if(shortlist_found)
     {
      filter_out = shortlist_entry.filter;
      has_filter_out = true;
      has_packet_out = shortlist_entry.has_packet;
      score_out = shortlist_entry.shortlist_score;
      return true;
     }

   shortlist_rank = 0;
   shortlist_total = ASC_ShortlistCount(g_asc_hud_shortlist_rows);
   ASC_SelectionFilterInitFallbackPending(filter_out,
                                         "shortlist snapshot unavailable",
                                          "shortlist_owner_unavailable",
                                          "selection filter details are waiting for runtime shortlist publication");
   has_filter_out = true;
   return false;
  }

int ASC_HudSelectionOrderGroup(const bool shortlist_found,
                               const ASC_ShortlistSymbolSummary &shortlist_entry,
                               const ASC_SelectionFilterEvaluation &filter)
  {
   if(shortlist_found && shortlist_entry.shortlisted && shortlist_entry.rank > 0)
     {
      if(shortlist_entry.rank <= 3)
         return 0;
      if(shortlist_entry.rank <= 5)
         return 1;
     }

   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return 2;
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return 3;
   return 4;
  }

string ASC_HudFilterEligibilityLabel(const ASC_SelectionFilterEvaluation &filter)
  {
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "Score-ready";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Score pending";
   if(filter.eligibility_posture == "blocked")
      return "Blocked";
   if(filter.eligibility_posture == "degraded")
      return "Degraded";
   if(filter.eligibility_posture == "stale")
      return "Stale";
   return "Not eligible";
  }

string ASC_HudShortlistBandLabel(const string band_raw)
  {
   string band = ASC_HudTrim(band_raw);
   StringToLower(band);
   if(band == "promoted")
      return "Promoted";
   if(band == "shortlisted")
      return "Shortlisted";
   if(band == "reserve")
      return "Reserve";
   if(band == "pending")
      return "Pending";
   if(band == "blocked")
      return "Blocked";
   return "Unspecified";
  }

string ASC_HudSymbolFrictionSpreadLine(const bool has_filter,
                                       const ASC_SelectionFilterEvaluation &filter,
                                       const bool has_packet,
                                       const ASC_ShortlistSymbolSummary &shortlist_entry)
  {
   if(!has_filter)
      return "Friction pending • Spread pending";

   string friction = ASC_ArtifactHumanizeLabel(ASC_TextOrUnavailable(filter.execution_friction_posture));
   string spread_gate = filter.spread_is_sane ? "Spread sane" : "Spread stressed";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING && !filter.spread_is_sane)
      spread_gate = "Spread pending";

   if(has_packet && shortlist_entry.packet.valid_spread && shortlist_entry.packet.spread_points >= 0.0)
      return friction + " • " + spread_gate + " " + DoubleToString(shortlist_entry.packet.spread_points, 1) + "pt";
   return friction + " • " + spread_gate;
  }

string ASC_HudSymbolWhyNowLine(const bool shortlist_found,
                               const string membership_state,
                               const bool has_filter,
                               const ASC_SelectionFilterEvaluation &filter,
                               const bool is_fresh,
                               const bool spread_sane)
  {
   if(shortlist_found && membership_state == "shortlisted" && is_fresh && spread_sane)
      return "Fresh, spread-sane, and still carrying shortlist attention.";
   if(shortlist_found && membership_state == "reserve" && is_fresh)
      return "Live and score-ready, but currently parked in reserve.";
   if(shortlist_found && (membership_state == "blocked" || membership_state == "invalid"))
      return "Present in scope, but currently outside shortlist admission.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS && is_fresh)
      return "Live and eligible with enough selection evidence for a review click.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Opportunity is still building evidence; confirm on the next refresh.";
   return "Present in scope, but not currently compelling for immediate drilldown.";
  }

string ASC_HudSymbolWarningLine(const ASC_Layer1SymbolState &state,
                                const bool has_filter,
                                const ASC_SelectionFilterEvaluation &filter,
                                const bool shortlist_found,
                                const string membership_state)
  {
   if(state.is_degraded || state.is_stale)
      return "Warning: stale/degraded symbol state; treat this row as guarded.";
   if(has_filter && !filter.spread_is_sane)
      return "Warning: spread posture is stressed against current selection gates.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "Warning: selection gate is currently blocked.";
   if(shortlist_found && (membership_state == "blocked" || membership_state == "invalid"))
      return "Warning: shortlist owner marked this symbol outside current admission.";
   return "";
  }

string ASC_HudSymbolOverviewTotalPosture(const ASC_Layer1SymbolState &state,
                                         const bool has_live_packet,
                                         const bool has_filter,
                                         const ASC_SelectionFilterEvaluation &filter,
                                         const bool shortlist_found,
                                         const string membership_state)
  {
   bool fresh_now = !(state.is_degraded || state.is_stale);
   bool spread_sane = (has_filter && filter.spread_is_sane);

   if(shortlist_found && membership_state == "shortlisted" && has_live_packet && fresh_now && spread_sane)
      return "Live, clean, and carrying shortlist attention across scanner checks.";
   if(shortlist_found && membership_state == "reserve" && fresh_now)
      return "Tradable enough to watch, but still reserve-grade in shortlist terms.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS && fresh_now)
      return "Eligible and alive, but shortlist conviction is still building.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Evidence is still forming; treat this symbol as an active watch candidate.";
   if(state.is_degraded || state.is_stale || (has_filter && !filter.spread_is_sane))
      return "Technically alive, but quality is mixed and requires guarded interpretation.";
   return "Present in scope with limited current conviction across shortlist and Full Analysis posture.";
  }

string ASC_HudSymbolOverviewNextStep(const ASC_Layer1SymbolState &state,
                                     const bool has_live_packet,
                                     const bool has_filter,
                                     const ASC_SelectionFilterEvaluation &filter,
                                     const bool shortlist_found,
                                     const ASC_ShortlistSymbolSummary &shortlist_entry)
  {
   string membership_state = shortlist_found ? shortlist_entry.membership_state : "pending";
   bool spread_sane = (has_filter && filter.spread_is_sane);

   if(state.is_degraded || state.is_stale)
      return "Watch only; confirm fresh scanner state before acting on this symbol.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "Stand down for now; review Selection and reason before any Full Analysis action.";
   if(shortlist_found && membership_state == "shortlisted" && has_live_packet && spread_sane)
      return "Run Full Analysis now, then confirm entry conditions in Market Watch and Specs.";
   if(shortlist_found && membership_state == "reserve")
      return "Review Shortlist and monitor for promotion before opening Full Analysis.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Use Selection next-step guidance and recheck after the next shortlist refresh.";
   if(has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "Eligible but not promoted; compare peers in Symbols and review Shortlist.";
   return "Use Market Watch and Selection pages to resolve missing evidence before drilldown.";
  }

string ASC_HudOverviewSessionState(const ASC_Layer1SymbolState &state,
                                   const bool has_live_packet,
                                   const ASC_Layer2Packet &packet)
  {
   if(has_live_packet && (packet.valid_quote_session_status || packet.valid_trade_session_status))
     {
      string quote_state = packet.valid_quote_session_status ? packet.quote_session_status : "pending";
      string trade_state = packet.valid_trade_session_status ? packet.trade_session_status : quote_state;
      return "Session " + quote_state + " / " + trade_state;
     }
   return "Session " + ASC_L1ReasonToOperatorText(state.reason);
  }

string ASC_HudOverviewCompactPrimaryPosture(const ASC_Layer1SymbolState &state,
                                            const bool has_filter,
                                            const ASC_SelectionFilterEvaluation &filter,
                                            const bool shortlist_found,
                                            const string membership_state,
                                            const bool has_live_packet)
  {
   string shortlist_state = shortlist_found ? ASC_ArtifactHumanizeLabel(membership_state) : "Pending";
   string tradability_state = has_filter ? (filter.tradability_is_open ? "Tradable" : "Restricted") : "Pending";
   string spread_state = has_filter ? (filter.spread_is_sane ? "Spread sane" : "Spread stressed") : "Spread pending";
   string freshness_state = (state.is_degraded || state.is_stale) ? "Guarded freshness" : "Fresh";
   string snapshot_state = has_live_packet ? "Live snapshot" : "Snapshot pending";
   return tradability_state + " • " + shortlist_state + " • " + spread_state + " • " + freshness_state + " • " + snapshot_state;
  }

string ASC_HudMarketWatchSpreadRegime(const bool has_live_packet,const ASC_Layer2Packet &packet)
  {
   if(!has_live_packet)
      return "Spread regime pending";
   if(!packet.valid_spread || packet.bid <= 0.0)
      return "Spread regime unavailable";

   double spread_pct = ((packet.spread_points * packet.point) / packet.bid) * 100.0;
   if(spread_pct <= 0.03)
      return "Spread clean";
   if(spread_pct <= 0.08)
      return "Spread moderate";
   return "Spread hostile";
  }

string ASC_HudAppendCompactField(const string base,const string token)
  {
   if(StringLen(token) <= 0)
      return base;
   if(StringLen(base) <= 0)
      return token;
   return base + " | " + token;
  }

string ASC_HudMarketWatchExecutionCaution(const ASC_Layer1SymbolState &state,
                                          const bool has_live_packet,
                                          const ASC_Layer2Packet &packet,
                                          const bool has_filter,
                                          const ASC_SelectionFilterEvaluation &filter)
  {
   if(state.is_degraded || state.is_stale)
      return "Caution: scanner state is stale/degraded; treat live posture as guarded.";
   if(!has_live_packet)
      return "Caution: no live market-watch snapshot; avoid execution assumptions.";
   if(packet.packet_age_sec > 120)
      return "Caution: snapshot age is high for execution timing.";
   if(has_filter && !filter.spread_is_sane)
      return "Caution: spread gate is stressed against current selection rules.";
   return "No immediate execution caution from live timing or spread posture.";
  }

string ASC_HudSpecsTradingImpactSummary(const bool has_trade_mode,
                                        const long trade_mode,
                                        const bool has_execution,
                                        const bool has_filling,
                                        const bool has_min_volume,
                                        const bool has_volume_step,
                                        const bool has_stops_level,
                                        const bool has_freeze_points,
                                        const long freeze_points)
  {
   if(has_trade_mode && trade_mode == SYMBOL_TRADE_MODE_DISABLED)
      return "Trading is disabled for this symbol in current broker permissions.";
   if(!has_execution || !has_filling)
      return "Execution geometry is only partially known; apply conservative handling.";
   if(has_freeze_points && freeze_points > 0)
      return "Awkward execution geometry: freeze/stop distance constraints need active care.";
   if(has_stops_level || (has_min_volume && has_volume_step))
      return "Usable contract conditions, but size and distance rules require disciplined order geometry.";
   return "Normal contract conditions with no obvious execution restrictions.";
  }

string ASC_HudSelectionSupportsSummary(const bool has_filter,const ASC_SelectionFilterEvaluation &filter)
  {
   if(!has_filter)
      return "Support checks are pending the next shortlist update.";

   string supports = "";
   if(filter.market_state_is_open) supports += "market state, ";
   if(filter.freshness_is_current || filter.quote_freshness_is_acceptable) supports += "freshness, ";
   if(filter.spread_is_sane) supports += "spread posture, ";
   if(filter.tradability_is_open) supports += "tradability, ";
   if(filter.continuity_backed) supports += "continuity, ";
   if(filter.score_pack_ready) supports += "score context, ";
   if(StringLen(supports) <= 0)
      return "No strong supports are currently confirmed.";
   if(StringLen(supports) >= 2)
      supports = StringSubstr(supports, 0, StringLen(supports) - 2);
   return "Passed checks: " + supports + ".";
  }

string ASC_HudSelectionBlockersSummary(const bool has_filter,const ASC_SelectionFilterEvaluation &filter)
  {
   if(!has_filter)
      return "Current blockers are unavailable until the next shortlist update.";

   string blockers = "";
   if(!filter.market_state_is_open) blockers += "market state closed, ";
   if(!filter.freshness_is_current && !filter.quote_freshness_is_acceptable) blockers += "freshness lag, ";
   if(!filter.spread_is_sane) blockers += "spread stress, ";
   if(!filter.confidence_is_acceptable) blockers += "confidence soft, ";
   if(!filter.classification_is_resolved) blockers += "classification review pending, ";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL) blockers += "candidate posture blocked, ";
   if(StringLen(blockers) <= 0)
      return "No major blockers are currently active.";
   blockers = StringSubstr(blockers, 0, StringLen(blockers) - 2);
   return "Current blockers: " + blockers + ".";
  }

string ASC_HudSelectionWhyAliveSummary(const bool has_filter,const ASC_SelectionFilterEvaluation &filter)
  {
   if(!has_filter)
      return "Still active in Selection while shortlist evidence is loading.";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "Still alive because core checks remain supportive enough for candidate continuity.";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Surviving on partial support, but confirmation is still incomplete.";
   return "Candidate support is currently weak and requires fresh confirmation to recover.";
  }

string ASC_HudSelectionNextStepSummary(const bool has_filter,const ASC_SelectionFilterEvaluation &filter)
  {
   if(!has_filter)
      return "Wait for the next shortlist update before drawing a stronger conclusion.";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "Strong enough to keep watching, but shortlist meaning depends on cleaner follow-through.";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Needs cleaner structure and missing checks before shortlist meaning can improve.";
   return "Candidate support is weakening; stand down unless fresh checks recover.";
  }

string ASC_HudShortlistPeerStrengthSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
     {
      if(entry.rank <= 3)
         return "Peer strength: top-tier relative candidate in the current shortlist field.";
      if(entry.rank <= 10)
         return "Peer strength: watch-worthy shortlist contender with workable relative edge.";
      return "Peer strength: present in shortlist scope, but currently lower-ranked versus peers.";
     }
   if(entry.membership_state == "reserve")
      return "Peer strength: reserve-grade candidate with partial relative support.";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Peer strength: currently constrained and outside active shortlist pressure.";
   return "Peer strength: shortlist ranking is still pending.";
  }

string ASC_HudShortlistConflictSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   double conflict_penalty = entry.overall_board_conflict_penalty;
   double corr_penalty = entry.overall_board_correlation_penalty;
   bool conflict_active = (conflict_penalty > 0.20 || corr_penalty > 0.20);
   if(conflict_active)
      return "Conflict context: overlap pressure is active and reduces immediate conviction.";
   if(entry.overall_board_cluster_count > 1)
      return "Diversification context: peer clustering is present; keep exposure spread disciplined.";
   return "Diversification context: no major overlap pressure is currently visible.";
  }

string ASC_HudShortlistWhyAttentionSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
     {
      if(entry.rank <= 3)
         return "Earned attention through strong peer rank and supportive shortlist posture.";
      return "Earned attention by staying competitive in the current shortlist field.";
     }
   if(entry.membership_state == "reserve")
      return "Still visible because score quality remains usable, but promotion is not yet strong enough.";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Attention is currently constrained by shortlist admission limits or conflict pressure.";
   return "Shortlist attention is still forming and awaiting clearer rank placement.";
  }

string ASC_HudShortlistNextStepSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0 && entry.rank <= 3)
      return "Strong enough to justify Full Analysis review now, while monitoring overlap pressure.";
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
      return "Worth keeping on watch, but not yet a clean top-priority candidate.";
   if(entry.membership_state == "reserve")
      return "Reserve attention is real; wait for cleaner relative strength before escalation.";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Attention is constrained; reduce conviction until conflict/eligibility improves.";
   return "Hold watch posture until shortlist ranking becomes clearer.";
  }

string ASC_HudShortlistRankContextLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total)
  {
   return ASC_HudRankSurfaceSummaryLine(entry, shortlist_total);
  }

string ASC_HudShortlistBandMeaningSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   string band = ASC_HudTrim(entry.shortlist_band);
   StringToLower(band);
   if(band == "promoted")
      return "Placement meaning: promoted candidate carrying active shortlist conviction.";
   if(band == "shortlisted")
      return "Placement meaning: admitted and ranked inside active shortlist competition.";
   if(band == "reserve")
      return "Placement meaning: reserve-grade watch candidate; promotion pressure is still building.";
   if(band == "blocked" || band == "invalid")
      return "Placement meaning: outside active shortlist admission until constraints improve.";
   return "Placement meaning: pending until shortlist placement is published.";
  }

string ASC_HudShortlistPromotionPressureSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
     {
      if(entry.rank <= 3)
         return "Promotion pressure: already top-tier; hold quality to defend placement.";
      if(entry.rank <= 10)
         return "Promotion pressure: close enough to move up with cleaner relative strength.";
      return "Promotion pressure: meaningful, but requires stronger peer separation to advance.";
     }
   if(entry.membership_state == "reserve")
      return "Promotion pressure: reserve-grade; needs a clear quality lift for admission.";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Promotion pressure: constrained until eligibility and overlap improve.";
   return "Promotion pressure: pending while shortlist evidence stabilizes.";
  }

string ASC_HudShortlistRelativeStrengthSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   string peer_symbol = ASC_HudTrim(entry.overall_board_peer_symbol);
   if(StringLen(peer_symbol) > 0)
      return StringFormat("Relative strength: board %.1f vs peer %s (corr %.2f).",
                          entry.overall_board_score,
                          peer_symbol,
                          entry.overall_board_peer_correlation);
   return StringFormat("Relative strength: board %.1f | context %.1f | shortlist %.1f.",
                       entry.overall_board_score,
                       entry.shortlist_context_score,
                       entry.shortlist_score);
  }

string ASC_HudShortlistImproveSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
      return "Would improve: cleaner execution quality and less overlap to lift rank.";
   if(entry.membership_state == "reserve")
      return "Would improve: stronger shortlist score and cleaner stability posture.";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Would improve: recover gate quality, reduce conflict, then rebuild shortlist support.";
   return "Would improve: complete shortlist publication and stabilize supporting checks.";
  }

string ASC_HudShortlistWeakenSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.overall_board_conflict_penalty > 0.20 || entry.overall_board_correlation_penalty > 0.20)
      return "Would weaken: additional correlation/conflict pressure against nearby peers.";
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
      return "Would weaken: relative rank slip or degradation in shortlist quality posture.";
   if(entry.membership_state == "reserve")
      return "Would weaken: further drop in score quality or stability posture.";
   return "Would weaken: weaker shortlist evidence at the next publication pass.";
  }

string ASC_HudShortlistLikelyPathSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0 && entry.rank <= 3)
      return "Next likely path: defend promoted placement while watching conflict pressure.";
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
      return "Next likely path: stay shortlisted while competing for higher rank.";
   if(entry.membership_state == "reserve")
      return "Next likely path: reserve watch until promotion pressure converts.";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Next likely path: remain constrained until conflict and eligibility recover.";
   return "Next likely path: pending placement once shortlist publication refreshes.";
  }

string ASC_HudDeepSetupPosture(const string deep_posture_raw,
                               const string focus_posture_raw,
                               const string tactical_snapshot_raw,
                               const string structure_summary_raw)
  {
   string probe = deep_posture_raw + " " + focus_posture_raw + " " + tactical_snapshot_raw + " " + structure_summary_raw;
   string lowered = probe;
   StringToLower(lowered);
   if(StringFind(lowered, "breakout") >= 0)
      return "Breakout pressure";
   if(StringFind(lowered, "reversal") >= 0)
      return "Reversal candidate";
   if(StringFind(lowered, "squeeze") >= 0 || StringFind(lowered, "compression") >= 0)
      return "Compression setup";
   if(StringFind(lowered, "rejection") >= 0 || StringFind(lowered, "fade") >= 0)
      return "Rejection / fade posture";
   if(StringFind(lowered, "continuation") >= 0 || StringFind(lowered, "trend") >= 0)
      return "Continuation building";
   return "Wait / no clean setup yet";
  }

string ASC_HudDeepTimingPosture(const string trigger_status_text,
                                const string lifecycle_state,
                                const bool trigger_queued)
  {
   string lifecycle = lifecycle_state;
   StringToLower(lifecycle);
   string trigger = trigger_status_text;
   StringToLower(trigger);
   if(StringFind(lifecycle, "ready") >= 0 || StringFind(trigger, "served") >= 0)
      return "Armed";
   if(trigger_queued || StringFind(lifecycle, "queued") >= 0)
      return "Building";
   if(StringFind(lifecycle, "incomplete") >= 0 || StringFind(lifecycle, "awaiting") >= 0)
      return "Early";
   if(StringFind(lifecycle, "stale") >= 0)
      return "Fading";
   return "Not ready";
  }

string ASC_HudDeepTraderActionDecision(const string deep_posture,
                                       const string timing_posture,
                                       const bool has_focus_match,
                                       const bool focus_complete,
                                       const bool spread_sane)
  {
   if(!has_focus_match)
      return "Wait";
   if(!focus_complete)
      return "Watch closely";
   if(deep_posture == "Ready" && timing_posture == "Armed" && spread_sane)
      return "Ready now";
   if(deep_posture == "Attention" || timing_posture == "Building")
      return "Watch closely";
   if(!spread_sane)
      return "Reject";
   return "Wait";
  }

int ASC_HudCanonicalScopeRankForState(const ASC_Layer1SymbolState &state,const string selected_scope_key)
  {
   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   if(!ASC_HudResolveShortlistLookup(state.symbol, shortlist_entry, shortlist_rank, shortlist_total))
      return 2147483647;

   if(StringLen(selected_scope_key) > 0)
     {
      string main_bucket_id = ASC_HudEffectiveMainBucketId(state);
      string leaf_key = ASC_HudBrowseLeafKeyForState(state, main_bucket_id);
      bool stock_scope = ASC_HudIsStockBucketId(main_bucket_id);
      if(stock_scope)
        {
         if(selected_scope_key == leaf_key || ASC_HudBrowseNodeHasAncestor(leaf_key, selected_scope_key))
           {
            if(shortlist_entry.sub_bucket_rank_available && shortlist_entry.sub_bucket_rank > 0)
               return shortlist_entry.sub_bucket_rank;
           }
        }
      else
        {
         string sub_scope_key = main_bucket_id + "|" + ASC_HudEffectiveSubBucketId(state, main_bucket_id);
         if(sub_scope_key == selected_scope_key && shortlist_entry.sub_bucket_rank_available && shortlist_entry.sub_bucket_rank > 0)
            return shortlist_entry.sub_bucket_rank;
        }
     }

   if(shortlist_entry.bucket_rank > 0)
      return 1000000 + shortlist_entry.bucket_rank;
   if(shortlist_entry.rank > 0)
      return 2000000 + shortlist_entry.rank;
   if(shortlist_entry.raw_rank > 0)
      return 3000000 + shortlist_entry.raw_rank;
   return 2147483647;
  }

int ASC_HudCanonicalGlobalRankForState(const ASC_Layer1SymbolState &state)
  {
   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   if(!ASC_HudResolveShortlistLookup(state.symbol, shortlist_entry, shortlist_rank, shortlist_total))
      return 2147483647;
   if(shortlist_entry.rank > 0)
      return shortlist_entry.rank;
   if(shortlist_entry.raw_rank > 0)
      return 1000000 + shortlist_entry.raw_rank;
   return 2147483647;
  }

int ASC_HudCanonicalRawRankForState(const ASC_Layer1SymbolState &state)
  {
   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   if(!ASC_HudResolveShortlistLookup(state.symbol, shortlist_entry, shortlist_rank, shortlist_total))
      return 2147483647;
   if(shortlist_entry.raw_rank > 0)
      return shortlist_entry.raw_rank;
   return 2147483647;
  }

void ASC_HudSortPreparedSelectionRows(ASC_HudPreparedSelectionRow &rows[],const int left,const int right)
  {
   int n = ArraySize(rows);
   if(n <= 1)
      return;

   int first = left;
   int last = right;
   if(first < 0)
      first = 0;
   if(last >= n)
      last = n - 1;
   if(first >= last)
      return;

   for(int i = first + 1; i <= last; i++)
     {
      ASC_HudPreparedSelectionRow value = rows[i];
      int j = i - 1;
      while(j >= first && ASC_HudPreparedRowComesBefore(value, rows[j]))
        {
         rows[j + 1] = rows[j];
         j--;
        }
      rows[j + 1] = value;
     }
  }

bool ASC_HudPreparedRowComesBefore(const ASC_HudPreparedSelectionRow &left,const ASC_HudPreparedSelectionRow &right)
  {
   if(left.canonical_scope_rank != right.canonical_scope_rank)
      return (left.canonical_scope_rank < right.canonical_scope_rank);
   if(left.canonical_global_rank != right.canonical_global_rank)
      return (left.canonical_global_rank < right.canonical_global_rank);
   if(left.canonical_raw_rank != right.canonical_raw_rank)
      return (left.canonical_raw_rank < right.canonical_raw_rank);
   return (StringCompare(left.symbol_key, right.symbol_key) < 0);
  }

string ASC_HudBucketMetaText(const ASC_HudBucketRow &bucket)
  {
   ASC_HudScopeRankingStats stats;
   ASC_HudBuildScopeRankingStats(bucket.id, "", stats);
   string top_rank_text = (stats.top_rank > 0 ? ("Top #" + IntegerToString(stats.top_rank)) : "Top n/a");
   if(bucket.unresolved_count > 0)
      return StringFormat("Promoted %d | Ranked %d | %s | Needs Review %d", stats.promoted_count, stats.ranked_count, top_rank_text, bucket.unresolved_count);
   if(bucket.closed_count > 0)
      return StringFormat("Promoted %d | Ranked %d | %s | Closed %d", stats.promoted_count, stats.ranked_count, top_rank_text, bucket.closed_count);
   if(!stats.ranked_available)
      return StringFormat("Promoted %d | Ranked %d | Deterministic baseline view", stats.promoted_count, stats.ranked_count);
   return StringFormat("Promoted %d | Ranked %d | %s", stats.promoted_count, stats.ranked_count, top_rank_text);
  }

int ASC_HudBucketOpenPercent(const ASC_HudBucketRow &bucket)
  {
   if(bucket.total <= 0)
      return 0;
   int percent = (int)((100.0 * (double)bucket.open_count) / (double)bucket.total);
   if(percent < 0)
      percent = 0;
   if(percent > 100)
      percent = 100;
   return percent;
  }

string ASC_HudBucketTradabilityPosture(const ASC_HudBucketRow &bucket,const ASC_HudScopeRankingStats &stats)
  {
   int open_pct = ASC_HudBucketOpenPercent(bucket);
   double promoted_density = (bucket.total > 0 ? (double)stats.promoted_count / (double)bucket.total : 0.0);
   double unresolved_ratio = (bucket.total > 0 ? (double)bucket.unresolved_count / (double)bucket.total : 0.0);
   bool delayed = (g_asc_hud.has_summary && (g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded));

   if(delayed || unresolved_ratio >= 0.25 || open_pct < 25)
      return "Hostile";
   if(unresolved_ratio >= 0.12 || open_pct < 45 || promoted_density < 0.01)
      return "Mixed";
   return "Clean";
  }

string ASC_HudBucketWhyNowLine(const ASC_HudBucketRow &bucket,const ASC_HudScopeRankingStats &stats)
  {
   int open_pct = ASC_HudBucketOpenPercent(bucket);
   string tradability = ASC_HudBucketTradabilityPosture(bucket, stats);

   if(bucket.total <= 0)
      return "No active breadth yet; keep this bucket on background watch.";
   if(stats.promoted_count >= 3 && tradability == "Clean")
      return "Broad live coverage with clean conditions and multiple promoted candidates.";
   if(stats.promoted_count >= 1 && tradability == "Mixed")
      return "Active breadth with opportunity present, but tradability is mixed.";
   if(stats.promoted_count <= 0 && open_pct >= 50)
      return "Breadth is live, but promoted opportunity is still thin.";
   if(tradability == "Hostile")
      return "Conditions are fragile; use guarded sizing and wait for cleaner signal.";
   return "Narrow live opportunity despite available bucket coverage.";
  }

string ASC_HudSubBucketMetaText(const ASC_HudSubBucketRow &sub_bucket)
  {
   ASC_HudScopeRankingStats stats;
   ASC_HudBuildScopeRankingStats(sub_bucket.bucket_id, sub_bucket.key, stats);
   string source_text = ASC_HudTrim(sub_bucket.source);
   if(StringLen(source_text) <= 0)
      source_text = "runtime";
   else
      source_text = ASC_HudHumanizeIdentifier(source_text);

   if(stats.promoted_count > 0)
      return StringFormat("Promoted %d | Ranked %d | Top #%d | Source %s", stats.promoted_count, stats.ranked_count, stats.top_rank, source_text);
   if(stats.ranked_available)
      return StringFormat("Promoted 0 | Ranked %d | Source %s", stats.ranked_count, source_text);
   return StringFormat("Promoted 0 | Ranked 0 | Deterministic baseline view | Source %s", source_text);
  }

int ASC_HudScopeOpenPercent(const int open_count,const int total_count)
  {
   if(total_count <= 0)
      return 0;
   int percent = (int)((100.0 * (double)open_count) / (double)total_count);
   if(percent < 0)
      percent = 0;
   if(percent > 100)
      percent = 100;
   return percent;
  }

bool ASC_HudShortlistEntryInSubgroupScope(const ASC_ShortlistSymbolSummary &entry,
                                          const string bucket_id,
                                          const string subgroup_key,
                                          const bool stock_scope)
  {
   string main_bucket_id = ASC_HudEffectiveMainBucketId(entry.state);
   if(main_bucket_id != bucket_id)
      return false;

   if(stock_scope)
     {
      string leaf_key = ASC_HudBrowseLeafKeyForState(entry.state, main_bucket_id);
      if(leaf_key == subgroup_key)
         return true;
      return ASC_HudBrowseNodeHasAncestor(leaf_key, subgroup_key);
     }

   string sub_key = main_bucket_id + "|" + ASC_HudEffectiveSubBucketId(entry.state, main_bucket_id);
   return (sub_key == subgroup_key);
  }

void ASC_HudSubgroupOpportunitySnapshot(const string bucket_id,
                                        const string subgroup_key,
                                        const bool stock_scope,
                                        int &promoted_out,
                                        int &ranked_out,
                                        string &leader_symbol_out)
  {
   promoted_out = 0;
   ranked_out = 0;
   leader_symbol_out = "";

   int best_rank = 0;
   double best_score = -1e18;
   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      ASC_ShortlistSymbolSummary entry = g_asc_hud_shortlist_rows[i];
      if(!ASC_HudShortlistEntryInSubgroupScope(entry, bucket_id, subgroup_key, stock_scope))
         continue;

      string band = entry.shortlist_band;
      StringToLower(band);
      if(band == "promoted")
         promoted_out++;
      if(entry.shortlisted && entry.rank > 0)
         ranked_out++;

      bool better_leader = false;
      if(entry.shortlisted && entry.rank > 0)
        {
         if(best_rank <= 0 || entry.rank < best_rank)
            better_leader = true;
        }
      else if(best_rank <= 0 && entry.shortlist_score > best_score)
         better_leader = true;

      if(better_leader)
        {
         best_rank = (entry.shortlisted ? entry.rank : 0);
         best_score = entry.shortlist_score;
         leader_symbol_out = entry.symbol;
         if(StringLen(leader_symbol_out) <= 0)
            leader_symbol_out = entry.state.symbol;
        }
     }
  }

string ASC_HudSubgroupTradabilityPosture(const int total_count,
                                         const int open_count,
                                         const int ready_count,
                                         const int promoted_count)
  {
   int open_pct = ASC_HudScopeOpenPercent(open_count, total_count);
   double ready_ratio = (total_count > 0 ? (double)ready_count / (double)total_count : 0.0);
   double promoted_ratio = (total_count > 0 ? (double)promoted_count / (double)total_count : 0.0);
   bool delayed = (g_asc_hud.has_summary && (g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded));

   if(delayed || open_pct < 22 || ready_ratio < 0.30)
      return "Hostile";
   if(open_pct < 45 || ready_ratio < 0.55 || promoted_ratio < 0.01)
      return "Mixed";
   return "Clean";
  }

string ASC_HudSubgroupWhyNowLine(const int total_count,
                                 const int open_count,
                                 const int promoted_count,
                                 const string tradability_posture,
                                 const string leader_symbol)
  {
   int open_pct = ASC_HudScopeOpenPercent(open_count, total_count);
   bool has_leader = (StringLen(leader_symbol) > 0);

   if(total_count <= 0)
      return "No live breadth yet; keep this scope on watch.";
   if(promoted_count >= 2 && tradability_posture == "Clean" && has_leader)
      return "Broad live breadth with clean conditions and a clear leader.";
   if(promoted_count >= 1 && tradability_posture == "Mixed")
      return "Good breadth, but tradability is mixed.";
   if(promoted_count <= 0 && open_pct >= 45)
      return "Breadth is live, but promoted opportunity is limited.";
   if(tradability_posture == "Hostile")
      return "Conditions are fragile; wait for cleaner signal.";
   return "Narrow live opportunity despite acceptable coverage.";
  }


void ASC_HudReorderSelectedSymbolsByShortlistRank()
  {
   int total = ArraySize(g_asc_hud.symbol_indices);
   if(total <= 1)
      return;

   ASC_HudPreparedSelectionRow prepared_rows[];
   ArrayResize(prepared_rows, 0);
   string selected_scope_key = g_asc_hud.selected_sub_bucket_key;

   for(int i = 0; i < total; i++)
     {
      int layer1_index = g_asc_hud.symbol_indices[i];
      ASC_Layer1SymbolState state;
      if(!ASC_HudMaterializeSymbolState(layer1_index, state))
         continue;
      if(!ASC_HudStateMatchesSelectedScope(state))
         continue;

      int next = ArraySize(prepared_rows);
      ArrayResize(prepared_rows, next + 1, 64);
      prepared_rows[next].layer1_index = layer1_index;
      prepared_rows[next].state = state;
      int shortlist_rank_unused = 0;
      int shortlist_total_unused = 0;
      prepared_rows[next].shortlist_found = ASC_HudResolveShortlistLookup(state.symbol,
                                                                          prepared_rows[next].shortlist_entry,
                                                                          shortlist_rank_unused,
                                                                          shortlist_total_unused);
      prepared_rows[next].canonical_scope_rank = ASC_HudCanonicalScopeRankForState(state, selected_scope_key);
      prepared_rows[next].canonical_global_rank = ASC_HudCanonicalGlobalRankForState(state);
      prepared_rows[next].canonical_raw_rank = ASC_HudCanonicalRawRankForState(state);
      prepared_rows[next].symbol_key = state.symbol;
     }

   int n = ArraySize(prepared_rows);
   if(n > 1)
      ASC_HudSortPreparedSelectionRows(prepared_rows, 0, n - 1);

   ArrayResize(g_asc_hud.symbol_indices, n);
   for(int i = 0; i < n; i++)
      g_asc_hud.symbol_indices[i] = prepared_rows[i].layer1_index;
  }

string ASC_HudPriorityBand(const int rank,const int total)
  {
   if(rank <= 0 || total <= 0)
      return "Not yet ranked";
   if(rank == 1)
      return "Current top candidate";
   if(rank <= 3)
      return "High priority";
   if(rank <= 10)
      return "Watch closely";
   return "Background watch";
  }


string ASC_HudShortlistReason(const ASC_ShortlistSymbolSummary &entry)
  {
   string shortlist_reason = ASC_TextOrUnavailable(entry.shortlist_reason);
   if(shortlist_reason != "unavailable")
      return shortlist_reason;
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return ASC_TextOrUnavailable(entry.filter.next_required_step);
   return ASC_TextOrUnavailable(entry.filter.reason_summary);
  }

string ASC_HudFilterScoreSummary(const ASC_SelectionFilterEvaluation &filter)
  {
   string summary = ASC_TextOrUnavailable(filter.score_pack_summary);
   if(summary == "Unavailable")
      summary = StringFormat("Net %.1f | Gross %.1f", filter.score_net, filter.score_gross);

   string posture = ASC_TextOrUnavailable(filter.score_posture);
   string attention = ASC_TextOrUnavailable(filter.attention_posture);
   if(posture == "Unavailable" && attention == "Unavailable")
      return summary;
   if(attention == "Unavailable")
      return summary + " | Posture " + ASC_ArtifactHumanizeLabel(posture);
   if(posture == "Unavailable")
      return summary + " | Attention " + ASC_ArtifactHumanizeLabel(attention);
   return summary + " | Posture " + ASC_ArtifactHumanizeLabel(posture) + " | Attention " + ASC_ArtifactHumanizeLabel(attention);
  }

string ASC_HudShortlistScoreLine(const ASC_ShortlistSymbolSummary &entry)
  {
   string attention = ASC_TextOrUnavailable(entry.shortlist_attention_posture);
   if(attention == "Unavailable")
      return StringFormat("Shortlist %.1f | %s %.1f | Context %.1f",
                          entry.shortlist_score,
                          ASC_HudSelectionLabel(),
                          entry.shortlist_l3_score,
                          entry.shortlist_context_score);
   return StringFormat("Shortlist %.1f | %s %.1f | Context %.1f | Attention %s",
                       entry.shortlist_score,
                       ASC_HudSelectionLabel(),
                       entry.shortlist_l3_score,
                       entry.shortlist_context_score,
                       ASC_ArtifactHumanizeLabel(attention));
  }

string ASC_HudShortlistPostureLine(const ASC_ShortlistSymbolSummary &entry)
  {
   string line = "Posture " + ASC_ArtifactHumanizeLabel(entry.shortlist_posture);
   string attention = ASC_TextOrUnavailable(entry.shortlist_attention_posture);
   if(attention != "Unavailable")
      line += " | Attention " + ASC_ArtifactHumanizeLabel(attention);
   line += " | Stability " + ASC_ArtifactHumanizeLabel(entry.shortlist_stability_posture);
   line += " | Membership " + ASC_ArtifactHumanizeLabel(entry.membership_state);
   return line;
  }

string ASC_HudShortlistMeaningLine(const ASC_ShortlistSymbolSummary &entry)
  {
   string summary = ASC_TextOrUnavailable(entry.shortlist_score_summary);
   if(summary != "Unavailable")
      return summary;
   return ASC_HudShortlistReason(entry);
  }

string ASC_HudShortlistPriorityLine(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total)
  {
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
     {
      string bucket_text = (entry.bucket_rank > 0) ? (" | Bucket #" + IntegerToString(entry.bucket_rank)) : "";
      return ASC_HudShortlistLabel() + " rank " + IntegerToString(entry.rank) + " of " + IntegerToString(shortlist_total)
             + bucket_text + " | " + ASC_HudPriorityBand(entry.rank, shortlist_total);
     }
   if(entry.membership_state == "reserve")
      return "Score-ready reserve | " + ASC_HudShortlistMeaningLine(entry);
   if(entry.membership_state == "pending")
      return ASC_HudSelectionLabel() + " checks are still building evidence | " + ASC_TextOrUnavailable(entry.filter.next_required_step);
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Outside the current shortlist | " + ASC_TextOrUnavailable(entry.filter.reason_summary);
   return entry.filter.result_state_operator_text + " | " + ASC_HudShortlistMeaningLine(entry);
  }

string ASC_HudShortlistScopeMeta(const ASC_ShortlistSymbolSummary &entry,const int shortlist_scope_count)
  {
   string attention = ASC_TextOrUnavailable(entry.shortlist_attention_posture);
   if(entry.membership_state == "shortlisted" && entry.rank > 0)
      return (entry.rank <= 3)
             ? StringFormat("Promoted in current shortlist | Rank #%d of %d | Bucket #%d%s",
                            entry.rank,
                            shortlist_scope_count,
                            entry.bucket_rank,
                            attention != "Unavailable" ? (" | Attention " + ASC_ArtifactHumanizeLabel(attention)) : "")
             : StringFormat("Shortlisted in current shortlist | Rank #%d of %d | Bucket #%d%s",
                            entry.rank,
                            shortlist_scope_count,
                            entry.bucket_rank,
                            attention != "Unavailable" ? (" | Attention " + ASC_ArtifactHumanizeLabel(attention)) : "");

   if(entry.membership_state == "reserve")
      return "Score-ready but outside the current shortlist";
   if(entry.membership_state == "pending")
      return "Pending shortlist admission while selection evidence completes";
   if(entry.membership_state == "blocked" || entry.membership_state == "invalid")
      return "Not admitted to the current shortlist";
   return "Shortlist view is unavailable for this symbol";
  }


string ASC_HudShortlistOrderScopeKey(const ASC_HudPage page)
  {
   if(page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return "leaders|" + g_asc_hud.selected_bucket_id;
   if(page == ASC_HUD_PAGE_SUB_GROUPS)
      return "groups|" + g_asc_hud.selected_bucket_id;
   if(page == ASC_HUD_PAGE_SYMBOLS)
      return "symbols|" + g_asc_hud.selected_sub_bucket_key;
   if(page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "top10|global";
   if(page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return "markets|global";
   return "page|" + IntegerToString((int)page);
  }

string ASC_HudShortlistOrderingSignature()
  {
   ASC_HudPage scope_page = g_asc_hud.page;
   string scope_key = ASC_HudShortlistOrderScopeKey(scope_page);
   bool scope_changed = (g_asc_hud.shortlist_order_hash_page != scope_page
                         || g_asc_hud.shortlist_order_hash_scope_key != scope_key);
   bool shortlist_identity_changed = (g_asc_hud.shortlist_order_hash_source != g_asc_hud.last_shortlist_source
                                      || g_asc_hud.shortlist_order_hash_revision != g_asc_hud.last_shortlist_revision
                                      || g_asc_hud.shortlist_order_hash_pass_utc != g_asc_hud.last_shortlist_pass_utc
                                      || g_asc_hud.shortlist_order_hash_count != g_asc_hud.last_shortlist_count);
   if(!scope_changed
      && !shortlist_identity_changed
      && StringLen(g_asc_hud.shortlist_order_hash_signature) > 0)
      return g_asc_hud.shortlist_order_hash_signature;

   uint hash = 2166136261;
   hash = ASC_HudHashMixInt(hash, (int)scope_page);
   hash = ASC_HudHashMixString(hash, scope_key);
   hash = ASC_HudHashMixString(hash, g_asc_hud.last_shortlist_source);
   hash = ASC_HudHashMixInt(hash, (int)g_asc_hud.last_shortlist_revision);
   hash = ASC_HudHashMixInt(hash, (int)g_asc_hud.last_shortlist_pass_utc);
   hash = ASC_HudHashMixInt(hash, g_asc_hud.last_shortlist_count);

   int shortlist_rows = ArraySize(g_asc_hud_shortlist_rows);
   for(int i = 0; i < shortlist_rows; i++)
     {
      ASC_ShortlistSymbolSummary entry = g_asc_hud_shortlist_rows[i];
      string effective_main_bucket_id = ASC_HudEffectiveMainBucketId(entry.state);
      string shortlist_leaf_key = ASC_HudBrowseLeafKeyForState(entry.state, effective_main_bucket_id);
      bool include = true;
      if(scope_page == ASC_HUD_PAGE_BUCKET_LEADERS || scope_page == ASC_HUD_PAGE_SUB_GROUPS)
         include = (effective_main_bucket_id == g_asc_hud.selected_bucket_id);
      else if(scope_page == ASC_HUD_PAGE_SYMBOLS)
         include = (shortlist_leaf_key == g_asc_hud.selected_sub_bucket_key);
      if(!include)
         continue;

      hash = ASC_HudHashMixString(hash, entry.symbol);
      hash = ASC_HudHashMixString(hash, entry.membership_state);
      hash = ASC_HudHashMixInt(hash, entry.shortlisted ? 1 : 0);
      hash = ASC_HudHashMixInt(hash, entry.rank);
      hash = ASC_HudHashMixInt(hash, entry.bucket_rank);
      hash = ASC_HudHashMixInt(hash, entry.sub_bucket_rank_available ? entry.sub_bucket_rank : 0);
      hash = ASC_HudHashMixInt(hash, entry.raw_rank);
     }

   g_asc_hud.shortlist_order_hash_scope_key = scope_key;
   g_asc_hud.shortlist_order_hash_page = scope_page;
   g_asc_hud.shortlist_order_hash_source = g_asc_hud.last_shortlist_source;
   g_asc_hud.shortlist_order_hash_revision = g_asc_hud.last_shortlist_revision;
   g_asc_hud.shortlist_order_hash_pass_utc = g_asc_hud.last_shortlist_pass_utc;
   g_asc_hud.shortlist_order_hash_count = g_asc_hud.last_shortlist_count;
   g_asc_hud.shortlist_order_hash_value = hash;
   g_asc_hud.shortlist_order_hash_signature = StringFormat("scope=%s|meta=%s|%I64u|%I64d|%d|hash=%08X",
                                                           scope_key,
                                                           g_asc_hud.last_shortlist_source,
                                                           g_asc_hud.last_shortlist_revision,
                                                           (long)g_asc_hud.last_shortlist_pass_utc,
                                                           g_asc_hud.last_shortlist_count,
                                                           hash);
   return g_asc_hud.shortlist_order_hash_signature;
  }

void ASC_HudRenderSectionButton(const string name,
                                const string caption,
                                const int x,
                                const int y,
                                const int w,
                                const int h,
                                const ASC_HudSymbolSectionFamily section)
  {
   bool active = (g_asc_hud.selected_symbol_section == section);
   ASC_HudEnsureButton(name,
                       ASC_HudButtonLabelForWidth(caption, w - 8),
                       x,
                       y,
                       w,
                       h,
                       (active ? ASC_HudThemeBgCardAlt() : ASC_HudThemeBgPanel()),
                       (active ? ASC_HudThemeAccentPrimary() : ASC_HudThemeBorderBase()),
                       (active ? ASC_HudThemeTextPrimary() : ASC_HudThemeTextSecondary()));
  }

string ASC_HudDeepSubPageLabel(const ASC_HudDeepSubPage sub_page)
  {
   switch(sub_page)
     {
      case ASC_HUD_DEEP_SUBPAGE_THESIS: return "Thesis";
      case ASC_HUD_DEEP_SUBPAGE_TIMING: return "Timing";
      case ASC_HUD_DEEP_SUBPAGE_STRUCTURE: return "Structure";
      case ASC_HUD_DEEP_SUBPAGE_EXECUTION: return "Execution";
      case ASC_HUD_DEEP_SUBPAGE_TIMEFRAMES: return "Timeframes";
     }
   return "Thesis";
  }

void ASC_HudRenderDeepSubPageButton(const string name,
                                    const string caption,
                                    const int x,
                                    const int y,
                                    const int w,
                                    const int h,
                                    const ASC_HudDeepSubPage sub_page)
  {
   bool active = (g_asc_hud.selected_deep_subpage == sub_page);
   ASC_HudEnsureButton(name,
                       ASC_HudButtonLabelForWidth(caption, w - 8),
                       x, y, w, h,
                       (active ? ASC_HudThemeBgCardAlt() : ASC_HudThemeBgPanel()),
                       (active ? ASC_HudThemeAccentPrimary() : ASC_HudThemeBorderBase()),
                       (active ? ASC_HudThemeTextPrimary() : ASC_HudThemeTextSecondary()));
  }

string ASC_HudDeepNormalizeChangeValue(const string value)
  {
   string normalized = ASC_HudTrim(value);
   if(StringLen(normalized) <= 0)
      return "pending";
   return normalized;
  }

void ASC_HudDeepAppendChangeSignal(string &summary,const string signal)
  {
   if(StringLen(signal) <= 0)
      return;
   if(StringLen(summary) > 0)
      summary += " | ";
   summary += signal;
  }

string ASC_HudDeepBuildChangeSummary(const string refresh_key,
                                     const string pressure_state,
                                     const string momentum_state,
                                     const string move_age_state,
                                     const string participation_state,
                                     const string execution_state,
                                     const string liquidity_state,
                                     const string timeframe_state,
                                     const string trigger_state)
  {
   string pressure = ASC_HudDeepNormalizeChangeValue(pressure_state);
   string momentum = ASC_HudDeepNormalizeChangeValue(momentum_state);
   string move_age = ASC_HudDeepNormalizeChangeValue(move_age_state);
   string participation = ASC_HudDeepNormalizeChangeValue(participation_state);
   string execution = ASC_HudDeepNormalizeChangeValue(execution_state);
   string liquidity = ASC_HudDeepNormalizeChangeValue(liquidity_state);
   string timeframes = ASC_HudDeepNormalizeChangeValue(timeframe_state);
   string trigger = ASC_HudDeepNormalizeChangeValue(trigger_state);

   if(!g_asc_hud.deep_change_seeded || StringLen(g_asc_hud.deep_change_refresh_key) <= 0)
     {
      g_asc_hud.deep_change_seeded = true;
      g_asc_hud.deep_change_refresh_key = refresh_key;
      g_asc_hud.deep_change_pressure = pressure;
      g_asc_hud.deep_change_momentum = momentum;
      g_asc_hud.deep_change_move_age = move_age;
      g_asc_hud.deep_change_participation = participation;
      g_asc_hud.deep_change_execution = execution;
      g_asc_hud.deep_change_liquidity = liquidity;
      g_asc_hud.deep_change_timeframes = timeframes;
      g_asc_hud.deep_change_trigger = trigger;
      g_asc_hud.deep_change_last_summary = "First Full Analysis packet captured; baseline set for change tracking.";
      return g_asc_hud.deep_change_last_summary;
     }

   if(refresh_key == g_asc_hud.deep_change_refresh_key && StringLen(g_asc_hud.deep_change_last_summary) > 0)
      return g_asc_hud.deep_change_last_summary;

   string changed = "";
   if(pressure != g_asc_hud.deep_change_pressure) ASC_HudDeepAppendChangeSignal(changed, "pressure shifted");
   if(momentum != g_asc_hud.deep_change_momentum) ASC_HudDeepAppendChangeSignal(changed, "momentum acceleration changed");
   if(move_age != g_asc_hud.deep_change_move_age) ASC_HudDeepAppendChangeSignal(changed, "move age updated");
   if(participation != g_asc_hud.deep_change_participation) ASC_HudDeepAppendChangeSignal(changed, "participation posture changed");
   if(execution != g_asc_hud.deep_change_execution) ASC_HudDeepAppendChangeSignal(changed, "execution/friction posture changed");
   if(liquidity != g_asc_hud.deep_change_liquidity) ASC_HudDeepAppendChangeSignal(changed, "liquidity/range position changed");
   if(timeframes != g_asc_hud.deep_change_timeframes) ASC_HudDeepAppendChangeSignal(changed, "timeframe alignment changed");
   if(trigger != g_asc_hud.deep_change_trigger) ASC_HudDeepAppendChangeSignal(changed, "trigger posture changed");

   if(StringLen(changed) <= 0)
      g_asc_hud.deep_change_last_summary = "What changed: no material Full Analysis structure change since the last refresh.";
   else
      g_asc_hud.deep_change_last_summary = "What changed: " + changed + ".";

   g_asc_hud.deep_change_refresh_key = refresh_key;
   g_asc_hud.deep_change_pressure = pressure;
   g_asc_hud.deep_change_momentum = momentum;
   g_asc_hud.deep_change_move_age = move_age;
   g_asc_hud.deep_change_participation = participation;
   g_asc_hud.deep_change_execution = execution;
   g_asc_hud.deep_change_liquidity = liquidity;
   g_asc_hud.deep_change_timeframes = timeframes;
   g_asc_hud.deep_change_trigger = trigger;
   return g_asc_hud.deep_change_last_summary;
  }

int ASC_HudCharsForWidth(const int width_px,const int font_size)
  {
   if(width_px <= 0)
      return 0;
   int char_px = font_size - 1;
   if(char_px < 6)
      char_px = 6;
   return width_px / char_px;
  }

string ASC_HudClampText(const string value,const int max_chars)
  {
   if(max_chars <= 0)
      return "";

   int len = (int)StringLen(value);
   if(len <= max_chars)
      return value;
   if(max_chars <= 3)
      return StringSubstr(value, 0, max_chars);
  return StringSubstr(value, 0, max_chars - 3) + "...";
  }

string ASC_HudClampTextWordSafe(const string value,const int max_chars)
  {
   if(max_chars <= 0)
      return "";

   int len = (int)StringLen(value);
   if(len <= max_chars)
      return value;
   if(max_chars <= 6)
      return ASC_HudClampText(value, max_chars);

   int hard_cut = max_chars - 3;
   int min_cut = hard_cut / 2;
   if(min_cut < 4)
      min_cut = 4;

   int best_break = -1;
   for(int i = hard_cut - 1; i >= min_cut; i--)
     {
      string ch = StringSubstr(value, i, 1);
      if(ch == " " || ch == "," || ch == ";" || ch == ":" || ch == "/" || ch == "|" || ch == "-")
        {
         best_break = i;
         break;
        }
     }

   if(best_break > 0)
      return ASC_HudTrim(StringSubstr(value, 0, best_break)) + "...";
  return StringSubstr(value, 0, hard_cut) + "...";
  }

string ASC_HudTraderSafeSummary(const string value,const string fallback,const int max_chars=84)
  {
   string cleaned = ASC_HudTrim(value);
   if(StringLen(cleaned) <= 0)
      return fallback;

   string probe = cleaned;
   StringToLower(probe);
   if(StringFind(probe, "debug") >= 0
      || StringFind(probe, "trace") >= 0
      || StringFind(probe, "audit") >= 0
      || StringFind(probe, "raw dump") >= 0
      || StringFind(probe, "json") >= 0
      || StringFind(probe, "stack") >= 0
      || StringFind(cleaned, "{") >= 0
      || StringFind(cleaned, "}") >= 0)
      return fallback;

   StringReplace(cleaned, "\r", " ");
   StringReplace(cleaned, "\n", " ");
   while(StringFind(cleaned, "  ") >= 0)
      StringReplace(cleaned, "  ", " ");
   return ASC_HudClampText(cleaned, max_chars);
  }

string ASC_HudClampTextMiddle(const string value,const int max_chars)
  {
   if(max_chars <= 0)
      return "";

   int len = (int)StringLen(value);
   if(len <= max_chars)
      return value;
   if(max_chars <= 5)
      return ASC_HudClampText(value, max_chars);

   int head = (max_chars - 3) / 2;
   int tail = (max_chars - 3) - head;
   if(head < 2) head = 2;
   if(tail < 2) tail = 2;
   return StringSubstr(value, 0, head) + "..." + StringSubstr(value, len - tail, tail);
  }

int ASC_HudButtonWidthForLabel(const string label,const int font_size,const int min_w,const int max_w)
  {
   int width = 16 + ((int)StringLen(label) * MathMax(6, font_size - 1));
   if(width < min_w)
      width = min_w;
   if(width > max_w)
      width = max_w;
   return width;
  }

string ASC_HudButtonLabelForWidth(const string label,const int width_px,const int font_size=9)
  {
   return ASC_HudClampText(label, ASC_HudCharsForWidth(width_px - 12, font_size));
  }

void ASC_HudEnsureLabelClamped(const string name,const string text,const int x,const int y,const int size,const color clr,const int max_width_px)
  {
   int max_chars = ASC_HudCharsForWidth(max_width_px, size);
   string fitted = text;
   if((int)StringLen(fitted) > max_chars)
      fitted = ASC_HudClampText(fitted, max_chars);
   ASC_HudEnsureLabel(name, fitted, x, y, size, clr);
  }

void ASC_HudEnsureLabelAutoFit(const string name,
                               const string text,
                               const int x,
                               const int y,
                               const int preferred_size,
                               const int min_size,
                               const color clr,
                               const int max_width_px)
  {
   int chosen_size = preferred_size;
   if(chosen_size < min_size)
      chosen_size = min_size;

   for(int s = preferred_size; s >= min_size; s--)
     {
      int max_chars = ASC_HudCharsForWidth(max_width_px, s);
      if((int)StringLen(text) <= max_chars)
        {
         chosen_size = s;
         break;
        }
      chosen_size = s;
     }

   int chosen_chars = ASC_HudCharsForWidth(max_width_px, chosen_size);
   string fitted = text;
   if((int)StringLen(fitted) > chosen_chars)
      fitted = ASC_HudClampTextWordSafe(fitted, chosen_chars);
   ASC_HudEnsureLabel(name, fitted, x, y, chosen_size, clr);
  }

bool ASC_HudIsListPage()
  {
   return (g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS
           || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS
           || g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS
           || g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS
           || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10);
  }

int ASC_HudVisibleRowLimit()
  {
   if(g_asc_hud.list_slots_visible > 0)
      return g_asc_hud.list_slots_visible;

   if(g_asc_trader_controls.hud_rows_override > 0)
     {
      int overridden = g_asc_trader_controls.hud_rows_override;
      if(overridden > ASC_HUD_ROW_SLOTS)
         overridden = ASC_HUD_ROW_SLOTS;
      if(overridden < 1)
         overridden = 1;
      return overridden;
     }

   return 1;
  }

int ASC_HudRowHeight()
  {
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
     {
      if(g_asc_hud.viewport_h < 760)
         return 54;
      return 48;
     }
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      if(g_asc_hud.viewport_h < 760)
         return 54;
      return 51;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
     {
      if(g_asc_hud.viewport_h < 760)
         return 54;
      return 51;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
     {
      if(g_asc_hud.viewport_h < 760)
         return 54;
      return 51;
     }
  return 48;
  }

bool ASC_HudBrowseNodeHasChildren(const string parent_key)
  {
   if(StringLen(parent_key) <= 0)
      return false;
   int parent_slot = ASC_HudFindBrowseNode(parent_key);
   if(parent_slot < 0 || parent_slot >= ArraySize(g_asc_hud.browse_nodes))
      return false;
   return (g_asc_hud.browse_nodes[parent_slot].first_child_slot >= 0);
  }

int ASC_HudVisibleBrowseNodeCount(const string parent_key)
  {
   if(StringLen(parent_key) <= 0)
      return 0;
   int count = 0;
   int parent_slot = ASC_HudFindBrowseNode(parent_key);
   if(parent_slot < 0 || parent_slot >= ArraySize(g_asc_hud.browse_nodes))
      return 0;

   int child_slot = g_asc_hud.browse_nodes[parent_slot].first_child_slot;
   while(child_slot >= 0 && child_slot < ArraySize(g_asc_hud.browse_nodes))
     {
      if(ASC_HudBrowseNodeAllowedByControls(g_asc_hud.browse_nodes[child_slot]))
         count++;
      child_slot = g_asc_hud.browse_nodes[child_slot].next_sibling_slot;
     }
   return count;
  }

bool ASC_HudVisibleBrowseNodeAt(const string parent_key,const int visible_index,ASC_HudBrowseNode &node)
  {
   if(StringLen(parent_key) <= 0 || visible_index < 0)
      return false;
   int parent_slot = ASC_HudFindBrowseNode(parent_key);
   if(parent_slot < 0 || parent_slot >= ArraySize(g_asc_hud.browse_nodes))
      return false;

   int visible = -1;
   int child_slot = g_asc_hud.browse_nodes[parent_slot].first_child_slot;
   while(child_slot >= 0 && child_slot < ArraySize(g_asc_hud.browse_nodes))
     {
      if(ASC_HudBrowseNodeAllowedByControls(g_asc_hud.browse_nodes[child_slot]))
        {
         visible++;
         if(visible == visible_index)
           {
            node = g_asc_hud.browse_nodes[child_slot];
            return true;
           }
        }
      child_slot = g_asc_hud.browse_nodes[child_slot].next_sibling_slot;
     }
   return false;
  }

string ASC_HudBrowseParentKey(const string key)
  {
   int slot = ASC_HudFindBrowseNode(key);
   if(slot < 0)
      return "";
   return g_asc_hud.browse_nodes[slot].parent_key;
  }

bool ASC_HudBrowseNodeHasAncestor(const string node_key,const string ancestor_key)
  {
   if(StringLen(node_key) <= 0 || StringLen(ancestor_key) <= 0)
      return false;
   if(node_key == ancestor_key)
      return true;

   string cursor = ASC_HudBrowseParentKey(node_key);
   int guard = 0;
   while(StringLen(cursor) > 0 && guard < 16)
     {
      if(cursor == ancestor_key)
         return true;
      cursor = ASC_HudBrowseParentKey(cursor);
      guard++;
     }
   return false;
  }

bool ASC_HudBrowseNodeValidForCurrentStockState(const string node_key,const string bucket_id,const string required_parent_key="")
  {
   if(StringLen(node_key) <= 0)
      return false;

   ASC_HudBrowseNode node;
   if(!ASC_HudTryGetBrowseNode(node_key, node))
      return false;

   string root_key = "B|" + ASC_HudNormalizeBrowseId(bucket_id, "stocks");
   if(!ASC_HudBrowseNodeHasAncestor(node_key, root_key))
      return false;
   if(!ASC_HudBrowseNodeAllowedByControls(node))
      return false;
   if(StringLen(required_parent_key) > 0 && !ASC_HudBrowseNodeHasAncestor(node_key, required_parent_key))
      return false;
   return true;
  }

int ASC_HudListRowMinSpacing()
  {
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return 0;
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return 0;
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS || g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return 1;
   return 1;
  }

void ASC_HudInvalidateVisibleSlotMaps()
  {
   ArrayResize(g_asc_hud.visible_bucket_slot_indices, 0);
   ArrayResize(g_asc_hud.visible_subgroup_slot_indices, 0);
   ArrayResize(g_asc_hud.visible_symbol_slot_indices, 0);
   ArrayResize(g_asc_hud.visible_leader_slot_indices, 0);
   g_asc_hud.visible_subgroup_slots_use_browse_nodes = false;
   g_asc_hud.visible_slot_map_page = (ASC_HudPage)-1;
   g_asc_hud.visible_slot_map_scope_signature = "";
   g_asc_hud.visible_slot_map_filter_signature = "";
   g_asc_hud.visible_slot_map_shortlist_signature = "";
  }

string ASC_HudVisibleSlotMapScopeSignature()
  {
   string signature = "page=" + IntegerToString((int)g_asc_hud.page);
   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return signature + "|scope=markets";
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
     {
      if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
         return signature + "|bucket=" + g_asc_hud.selected_bucket_id + "|browse_parent=" + ASC_HudActiveStockBrowseParentKey();
      return signature + "|bucket=" + g_asc_hud.selected_bucket_id;
     }
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return signature
             + "|bucket=" + g_asc_hud.selected_bucket_id
             + "|sub=" + g_asc_hud.selected_sub_bucket_key
             + "|browse_parent=" + g_asc_hud.selected_browse_parent_key
             + "|browse_node=" + g_asc_hud.selected_browse_node_key;
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return signature + "|bucket=" + g_asc_hud.selected_bucket_id;
   return signature;
  }

string ASC_HudVisibleSlotMapShortlistSignature()
  {
   return g_asc_hud.last_shortlist_source
          + "|" + StringFormat("%I64u", g_asc_hud.last_shortlist_revision)
          + "|" + IntegerToString((int)g_asc_hud.last_shortlist_pass_utc)
          + "|" + IntegerToString(g_asc_hud.last_shortlist_count);
  }

int ASC_HudVisibleBucketBackingIndexAt(const int visible_index)
  {
   if(visible_index < 0 || visible_index >= ArraySize(g_asc_hud.visible_bucket_slot_indices))
      return -1;
   return g_asc_hud.visible_bucket_slot_indices[visible_index];
  }

bool ASC_HudVisibleSubgroupBackingIndexAt(const int visible_index,int &backing_index,bool &use_browse_nodes)
  {
   backing_index = -1;
   use_browse_nodes = g_asc_hud.visible_subgroup_slots_use_browse_nodes;
   if(visible_index < 0 || visible_index >= ArraySize(g_asc_hud.visible_subgroup_slot_indices))
      return false;
   backing_index = g_asc_hud.visible_subgroup_slot_indices[visible_index];
   return (backing_index >= 0);
  }

int ASC_HudVisibleSymbolBackingIndexAt(const int visible_index)
  {
   if(visible_index < 0 || visible_index >= ArraySize(g_asc_hud.visible_symbol_slot_indices))
      return -1;
   return g_asc_hud.visible_symbol_slot_indices[visible_index];
  }

int ASC_HudVisibleLeaderBackingIndexAt(const int visible_index)
  {
   if(visible_index < 0 || visible_index >= ArraySize(g_asc_hud.visible_leader_slot_indices))
      return -1;
   return g_asc_hud.visible_leader_slot_indices[visible_index];
  }

void ASC_HudRebuildVisibleSlotMapsIfNeeded()
  {
   string scope_signature = ASC_HudVisibleSlotMapScopeSignature();
   string filter_signature = ASC_HudBrowseFilterSignature();
   string shortlist_signature = ASC_HudVisibleSlotMapShortlistSignature();
   bool identity_changed = (g_asc_hud.visible_slot_map_page != g_asc_hud.page
                            || g_asc_hud.visible_slot_map_scope_signature != scope_signature
                            || g_asc_hud.visible_slot_map_filter_signature != filter_signature
                            || g_asc_hud.visible_slot_map_shortlist_signature != shortlist_signature);
   if(!identity_changed)
      return;

   ArrayResize(g_asc_hud.visible_bucket_slot_indices, 0);
   ArrayResize(g_asc_hud.visible_subgroup_slot_indices, 0);
   ArrayResize(g_asc_hud.visible_symbol_slot_indices, 0);
   ArrayResize(g_asc_hud.visible_leader_slot_indices, 0);
   g_asc_hud.visible_subgroup_slots_use_browse_nodes = false;

   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
     {
      if(!ASC_HudBucketAllowedByControls(g_asc_hud.buckets[i].id))
         continue;
      int old = ArraySize(g_asc_hud.visible_bucket_slot_indices);
      ArrayResize(g_asc_hud.visible_bucket_slot_indices, old + 1, 16);
      g_asc_hud.visible_bucket_slot_indices[old] = i;
     }

   if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
     {
      g_asc_hud.visible_subgroup_slots_use_browse_nodes = true;
      string parent_key = ASC_HudActiveStockBrowseParentKey();
      for(int i = 0; i < ArraySize(g_asc_hud.browse_nodes); i++)
        {
         if(g_asc_hud.browse_nodes[i].parent_key != parent_key)
            continue;
         if(!ASC_HudBrowseNodeAllowedByControls(g_asc_hud.browse_nodes[i]))
            continue;
         int old = ArraySize(g_asc_hud.visible_subgroup_slot_indices);
         ArrayResize(g_asc_hud.visible_subgroup_slot_indices, old + 1, 16);
         g_asc_hud.visible_subgroup_slot_indices[old] = i;
        }
     }
   else
     {
      for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
        {
         if(g_asc_hud.sub_buckets[i].bucket_id != g_asc_hud.selected_bucket_id)
            continue;
         int old = ArraySize(g_asc_hud.visible_subgroup_slot_indices);
         ArrayResize(g_asc_hud.visible_subgroup_slot_indices, old + 1, 16);
         g_asc_hud.visible_subgroup_slot_indices[old] = i;
        }
     }

   for(int i = 0; i < ArraySize(g_asc_hud.symbol_indices); i++)
     {
      ASC_Layer1SymbolState st;
      if(!ASC_HudMaterializeSymbolState(g_asc_hud.symbol_indices[i], st))
         continue;
      int old = ArraySize(g_asc_hud.visible_symbol_slot_indices);
      ArrayResize(g_asc_hud.visible_symbol_slot_indices, old + 1, 32);
      g_asc_hud.visible_symbol_slot_indices[old] = g_asc_hud.symbol_indices[i];
     }

   for(int i = 0; i < ArraySize(g_asc_hud.leader_row_indices); i++)
     {
      int shortlist_idx = g_asc_hud.leader_row_indices[i];
      if(shortlist_idx < 0 || shortlist_idx >= ArraySize(g_asc_hud_shortlist_rows))
         continue;
      if(!g_asc_hud_shortlist_rows[shortlist_idx].bucket_shortlisted || g_asc_hud_shortlist_rows[shortlist_idx].bucket_rank <= 0)
         continue;
      string shortlist_bucket_id = ASC_HudEffectiveMainBucketId(g_asc_hud_shortlist_rows[shortlist_idx].state);
      if(shortlist_bucket_id != g_asc_hud.selected_bucket_id)
         continue;
      int layer1_index = -1;
      ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(g_asc_hud_shortlist_rows[shortlist_idx], layer1_index);
      if(!ASC_HudLeaderRowStateIsVisible(visibility_state))
         continue;
      int old = ArraySize(g_asc_hud.visible_leader_slot_indices);
      ArrayResize(g_asc_hud.visible_leader_slot_indices, old + 1, 16);
      g_asc_hud.visible_leader_slot_indices[old] = shortlist_idx;
     }

   g_asc_hud.visible_slot_map_page = g_asc_hud.page;
   g_asc_hud.visible_slot_map_scope_signature = scope_signature;
   g_asc_hud.visible_slot_map_filter_signature = filter_signature;
   g_asc_hud.visible_slot_map_shortlist_signature = shortlist_signature;
  }

int ASC_HudVisibleRowCount()
  {
   ASC_HudRebuildVisibleSlotMapsIfNeeded();

   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return ArraySize(g_asc_hud.visible_bucket_slot_indices);

   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
      return ArraySize(g_asc_hud.visible_subgroup_slot_indices);

   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return ASC_HudVisibleGlobalTop10Count();

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return ArraySize(g_asc_hud.visible_symbol_slot_indices);

   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return ArraySize(g_asc_hud.visible_leader_slot_indices);

   return 0;
  }

bool ASC_HudGlobalTop10EntryComesBefore(const ASC_ShortlistSymbolSummary &left,
                                     const ASC_ShortlistSymbolSummary &right)
  {
   int left_rank = (left.rank > 0 ? left.rank : 2147483647);
   int right_rank = (right.rank > 0 ? right.rank : 2147483647);
   if(left_rank != right_rank)
      return (left_rank < right_rank);

   int left_raw_rank = (left.raw_rank > 0 ? left.raw_rank : 2147483647);
   int right_raw_rank = (right.raw_rank > 0 ? right.raw_rank : 2147483647);
   if(left_raw_rank != right_raw_rank)
      return (left_raw_rank < right_raw_rank);

   int left_bucket_rank = (left.bucket_rank > 0 ? left.bucket_rank : 2147483647);
   int right_bucket_rank = (right.bucket_rank > 0 ? right.bucket_rank : 2147483647);
   if(left_bucket_rank != right_bucket_rank)
      return (left_bucket_rank < right_bucket_rank);

   string left_symbol = (StringLen(left.symbol) > 0 ? left.symbol : left.state.symbol);
   string right_symbol = (StringLen(right.symbol) > 0 ? right.symbol : right.state.symbol);
   return (StringCompare(left_symbol, right_symbol) < 0);
  }

void ASC_HudGlobalTop10CacheInvalidate()
  {
   g_asc_hud.global_top10_cache_scope_key = "";
   g_asc_hud.global_top10_cache_source = "";
   g_asc_hud.global_top10_cache_revision = 0;
   g_asc_hud.global_top10_cache_pass_utc = 0;
   g_asc_hud.global_top10_cache_count = 0;
   ArrayResize(g_asc_hud.global_top10_ordered_indices, 0);
   ArrayResize(g_asc_hud.global_top10_sort_buffer, 0);
   ArrayResize(g_asc_hud.global_top10_dedupe_lookup, 0);
  }

bool ASC_HudGlobalTop10CacheMatches(const string scope_key)
  {
   if(StringLen(scope_key) <= 0)
      return false;
   if(g_asc_hud.global_top10_cache_scope_key != scope_key)
      return false;
   if(g_asc_hud.global_top10_cache_source != g_asc_hud.last_shortlist_source)
      return false;
   if(g_asc_hud.global_top10_cache_revision != g_asc_hud.last_shortlist_revision)
      return false;
   if(g_asc_hud.global_top10_cache_pass_utc != g_asc_hud.last_shortlist_pass_utc)
      return false;
   if(g_asc_hud.global_top10_cache_count != g_asc_hud.last_shortlist_count)
      return false;
   return true;
  }

void ASC_HudStableSortGlobalTop10Indices(int &ordered_indices[])
  {
   int total = ArraySize(ordered_indices);
   if(total <= 1)
      return;

   ArrayResize(g_asc_hud.global_top10_sort_buffer, total, 32);
   int width = 1;
   while(width < total)
     {
      int out = 0;
      for(int left = 0; left < total; left += (width * 2))
        {
         int mid = MathMin(left + width, total);
         int right = MathMin(mid + width, total);
         int i = left;
         int j = mid;
         while(i < mid && j < right)
           {
            int left_index = ordered_indices[i];
            int right_index = ordered_indices[j];
            ASC_ShortlistSymbolSummary left_entry = g_asc_hud_shortlist_rows[left_index];
            ASC_ShortlistSymbolSummary right_entry = g_asc_hud_shortlist_rows[right_index];
            bool take_left = false;
            if(ASC_HudGlobalTop10EntryComesBefore(left_entry, right_entry))
               take_left = true;
            else if(ASC_HudGlobalTop10EntryComesBefore(right_entry, left_entry))
               take_left = false;
            else
               take_left = true;

            if(take_left)
               g_asc_hud.global_top10_sort_buffer[out++] = ordered_indices[i++];
            else
               g_asc_hud.global_top10_sort_buffer[out++] = ordered_indices[j++];
           }

         while(i < mid)
            g_asc_hud.global_top10_sort_buffer[out++] = ordered_indices[i++];
         while(j < right)
            g_asc_hud.global_top10_sort_buffer[out++] = ordered_indices[j++];
        }

      for(int k = 0; k < total; k++)
         ordered_indices[k] = g_asc_hud.global_top10_sort_buffer[k];
      width *= 2;
     }
  }

int ASC_HudBuildOrderedGlobalTop10Indices(const string scope_key,int &ordered_indices[])
  {
   ArrayResize(ordered_indices, 0);
   if(StringLen(scope_key) <= 0)
      return 0;

   if(ASC_HudGlobalTop10CacheMatches(scope_key))
     {
      int cached_total = ArraySize(g_asc_hud.global_top10_ordered_indices);
      ArrayResize(ordered_indices, cached_total, 32);
      for(int i = 0; i < cached_total; i++)
         ordered_indices[i] = g_asc_hud.global_top10_ordered_indices[i];
      return cached_total;
     }

   ArrayResize(g_asc_hud.global_top10_dedupe_lookup, 0);

   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      ASC_ShortlistSymbolSummary candidate = g_asc_hud_shortlist_rows[i];
      if(!candidate.shortlisted || candidate.rank <= 0)
         continue;

      string candidate_symbol = (StringLen(candidate.symbol) > 0 ? candidate.symbol : candidate.state.symbol);
      string candidate_key = ASC_HudNormalizeLookupKey(candidate_symbol);
      if(StringLen(candidate_key) <= 0)
         continue;

      int existing_slot = ASC_HudFindLookupIndex(g_asc_hud.global_top10_dedupe_lookup, candidate_key);
      if(existing_slot < 0)
        {
         ASC_HudInsertLookupEntrySorted(g_asc_hud.global_top10_dedupe_lookup, candidate_key, i, 32);
         continue;
        }

      int existing_index = g_asc_hud.global_top10_dedupe_lookup[existing_slot].index;
      if(existing_index < 0 || existing_index >= ArraySize(g_asc_hud_shortlist_rows))
        {
         g_asc_hud.global_top10_dedupe_lookup[existing_slot].index = i;
         continue;
        }

      ASC_ShortlistSymbolSummary existing = g_asc_hud_shortlist_rows[existing_index];
      if(ASC_HudGlobalTop10EntryComesBefore(candidate, existing))
         g_asc_hud.global_top10_dedupe_lookup[existing_slot].index = i;
     }

   int dedupe_total = ArraySize(g_asc_hud.global_top10_dedupe_lookup);
   ArrayResize(ordered_indices, dedupe_total, 32);
   int ordered_total = 0;
   for(int i = 0; i < dedupe_total; i++)
     {
      int shortlist_index = g_asc_hud.global_top10_dedupe_lookup[i].index;
      if(shortlist_index < 0 || shortlist_index >= ArraySize(g_asc_hud_shortlist_rows))
         continue;
      ordered_indices[ordered_total++] = shortlist_index;
     }
   ArrayResize(ordered_indices, ordered_total, 32);

   ASC_HudStableSortGlobalTop10Indices(ordered_indices);

   ArrayResize(g_asc_hud.global_top10_ordered_indices, ordered_total, 32);
   for(int i = 0; i < ordered_total; i++)
      g_asc_hud.global_top10_ordered_indices[i] = ordered_indices[i];
   g_asc_hud.global_top10_cache_scope_key = scope_key;
   g_asc_hud.global_top10_cache_source = g_asc_hud.last_shortlist_source;
   g_asc_hud.global_top10_cache_revision = g_asc_hud.last_shortlist_revision;
   g_asc_hud.global_top10_cache_pass_utc = g_asc_hud.last_shortlist_pass_utc;
   g_asc_hud.global_top10_cache_count = g_asc_hud.last_shortlist_count;

   return ordered_total;
  }

int ASC_HudVisibleGlobalTop10Count()
  {
   string scope_key = ASC_HudShortlistOrderScopeKey(g_asc_hud.page);
   int ordered_indices[];
   return ASC_HudBuildOrderedGlobalTop10Indices(scope_key, ordered_indices);
  }

bool ASC_HudTryGetGlobalTop10EntryByVisibleIndex(const int visible_index,ASC_ShortlistSymbolSummary &entry,int &shortlist_total)
  {
   shortlist_total = ASC_ShortlistCount(g_asc_hud_shortlist_rows);
   if(visible_index < 0)
      return false;

   string scope_key = ASC_HudShortlistOrderScopeKey(g_asc_hud.page);
   int ordered_indices[];
   int ordered_total = ASC_HudBuildOrderedGlobalTop10Indices(scope_key, ordered_indices);
   if(visible_index >= ordered_total)
      return false;

   int shortlist_index = ordered_indices[visible_index];
   if(shortlist_index < 0 || shortlist_index >= ArraySize(g_asc_hud_shortlist_rows))
      return false;

   entry = g_asc_hud_shortlist_rows[shortlist_index];
   return true;
  }

void ASC_HudClampListOffsetForPaging(const int visible_slots,const int total_items)
  {
   if(visible_slots <= 0 || total_items <= 0)
     {
      g_asc_hud.list_offset = 0;
      return;
     }

   int max_offset = ((total_items - 1) / visible_slots) * visible_slots;
   if(g_asc_hud.list_offset > max_offset)
      g_asc_hud.list_offset = max_offset;
   if(g_asc_hud.list_offset < 0)
     g_asc_hud.list_offset = 0;
  }

void ASC_HudResolveRowPacking(const int list_body_h,
                              const int total_items,
                              int &row_h_out,
                              int &row_spacing_out,
                              int &visible_slots_out,
                              int &remainder_px_out)
  {
   int usable_rows_h = list_body_h;
   if(usable_rows_h < 0)
      usable_rows_h = 0;

   int base_row_h = ASC_HudRowHeight();
   int row_spacing = ASC_HudListRowMinSpacing();
   if(row_spacing < 0)
      row_spacing = 0;

   int min_row_h = base_row_h - 10;
   if(min_row_h < 38)
      min_row_h = 38;
   if(min_row_h > base_row_h)
      min_row_h = base_row_h;

   int max_slots = ASC_HUD_ROW_SLOTS;
   if(total_items > 0 && max_slots > total_items)
      max_slots = total_items;
   if(max_slots < 1)
      max_slots = 1;

   int best_slots = 1;
   int best_row_h = base_row_h;

   for(int slots = 1; slots <= max_slots; slots++)
     {
      int remaining = usable_rows_h - ((slots - 1) * row_spacing);
      if(remaining <= 0)
         break;

      int packed_row_h = remaining / slots;
      if(packed_row_h > base_row_h)
         packed_row_h = base_row_h;
      if(packed_row_h < min_row_h)
         continue;

      best_slots = slots;
      best_row_h = packed_row_h;
     }

   int used_h = (best_slots * best_row_h) + ((best_slots - 1) * row_spacing);
   int remainder = usable_rows_h - used_h;
   if(remainder < 0)
      remainder = 0;

   row_h_out = best_row_h;
   row_spacing_out = row_spacing;
   visible_slots_out = best_slots;
   remainder_px_out = remainder;
  }

void ASC_HudComputeListPaging(const int list_body_h,const int list_body_w)
  {
   g_asc_hud.list_body_h = list_body_h;
   g_asc_hud.list_body_w = list_body_w;
   g_asc_hud.list_total_items = ASC_HudVisibleRowCount();

   int packed_row_h = ASC_HudRowHeight();
   int packed_row_spacing = ASC_HudListRowMinSpacing();
   int visible_slots = 1;
   int remainder_px = 0;
   ASC_HudResolveRowPacking(list_body_h,
                            g_asc_hud.list_total_items,
                            packed_row_h,
                            packed_row_spacing,
                            visible_slots,
                            remainder_px);

   if(g_asc_trader_controls.hud_rows_override > 0)
     {
      visible_slots = g_asc_trader_controls.hud_rows_override;
      if(visible_slots < 1)
         visible_slots = 1;
      if(visible_slots > ASC_HUD_ROW_SLOTS)
         visible_slots = ASC_HUD_ROW_SLOTS;
      if(g_asc_hud.list_total_items > 0 && visible_slots > g_asc_hud.list_total_items)
         visible_slots = g_asc_hud.list_total_items;
      packed_row_h = ASC_HudRowHeight();
      packed_row_spacing = ASC_HudListRowMinSpacing();
      int used_h = (visible_slots * packed_row_h) + ((visible_slots - 1) * packed_row_spacing);
      remainder_px = list_body_h - used_h;
      if(remainder_px < 0)
         remainder_px = 0;
     }

   g_asc_hud.list_row_h_effective = packed_row_h;
   g_asc_hud.list_row_spacing_effective = packed_row_spacing;
   g_asc_hud.list_pack_remainder_px = remainder_px;

   g_asc_hud.list_slots_visible = visible_slots;
   ASC_HudClampListOffsetForPaging(visible_slots, g_asc_hud.list_total_items);

   g_asc_hud.list_total_pages = 1;
   g_asc_hud.list_current_page = 1;
   g_asc_hud.list_range_start = 0;
   g_asc_hud.list_range_end = 0;

   if(g_asc_hud.list_total_items > 0)
     {
      g_asc_hud.list_total_pages = (g_asc_hud.list_total_items + visible_slots - 1) / visible_slots;
      g_asc_hud.list_current_page = (g_asc_hud.list_offset / visible_slots) + 1;
      if(g_asc_hud.list_current_page > g_asc_hud.list_total_pages)
         g_asc_hud.list_current_page = g_asc_hud.list_total_pages;
      g_asc_hud.list_range_start = g_asc_hud.list_offset + 1;
      g_asc_hud.list_range_end = MathMin(g_asc_hud.list_total_items, g_asc_hud.list_offset + visible_slots);
     }
  }

string ASC_HudListFreshnessTag(const bool is_stale,const bool is_degraded)
  {
   if(is_degraded)
      return "Degraded";
   if(is_stale)
      return "Delayed";
   return "Fresh";
  }

string ASC_HudListConfidenceTag(const int total,const int unresolved)
  {
   if(total <= 0)
      return "Unknown";

   if(unresolved <= 0)
      return "High";

   double ratio = (double)unresolved / (double)total;
   if(ratio <= 0.15)
      return "High";
   if(ratio <= 0.35)
      return "Medium";
  return "Low";
  }

string ASC_HudReadinessTag(const int eligible,const int total)
  {
   if(total <= 0)
      return "Unknown";
   double ratio = (double)eligible / (double)total;
   if(ratio >= 0.85)
      return "Ready";
   if(ratio >= 0.60)
      return "Advancing";
   if(ratio >= 0.35)
      return "Mixed";
   return "Thin";
  }


uint ASC_HudHashObjectCacheKey(const string name)
  {
   uint hash = 2166136261;
   int len = StringLen(name);
   for(int i = 0; i < len; i++)
     {
      hash ^= (uint)StringGetCharacter(name, i);
      hash *= 16777619;
     }
   return hash;
  }

void ASC_HudEnsureObjectCacheIndexCapacity(const int target_count)
  {
   int required = MathMax(0, target_count);
   int current_capacity = g_asc_hud.object_cache_index_capacity;

   int next_capacity = 8;
   while(next_capacity < required * 2)
      next_capacity <<= 1;

   if(current_capacity >= required
      && ArraySize(g_asc_hud.object_cache_index_keys) == current_capacity
      && ArraySize(g_asc_hud.object_cache_index_slots) == current_capacity)
      return;

   if(current_capacity == next_capacity
      && ArraySize(g_asc_hud.object_cache_index_keys) == next_capacity
      && ArraySize(g_asc_hud.object_cache_index_slots) == next_capacity)
      return;

   g_asc_hud.object_cache_index_capacity = next_capacity;
   ArrayResize(g_asc_hud.object_cache_index_keys, next_capacity);
   ArrayResize(g_asc_hud.object_cache_index_slots, next_capacity);
   for(int i = 0; i < next_capacity; i++)
     {
      g_asc_hud.object_cache_index_keys[i] = "";
      g_asc_hud.object_cache_index_slots[i] = -1;
     }

   g_asc_hud.object_cache_index_count = 0;
   int cache_size = ArraySize(g_asc_hud.object_cache);
   for(int entry = 0; entry < cache_size; entry++)
      ASC_HudInsertObjectCacheIndexEntry(g_asc_hud.object_cache[entry].name, entry);
  }

void ASC_HudInsertObjectCacheIndexEntry(const string name,const int slot)
  {
   int capacity = g_asc_hud.object_cache_index_capacity;
   if(capacity <= 0)
      return;

   int mask = capacity - 1;
   int probe = (int)(ASC_HudHashObjectCacheKey(name) & (uint)mask);
   while(g_asc_hud.object_cache_index_slots[probe] >= 0)
      probe = (probe + 1) & mask;

   g_asc_hud.object_cache_index_keys[probe] = name;
   g_asc_hud.object_cache_index_slots[probe] = slot;
   g_asc_hud.object_cache_index_count++;
  }

int ASC_HudFindObjectCache(const string name)
  {
   int capacity = g_asc_hud.object_cache_index_capacity;
   if(capacity <= 0)
      return -1;

   int mask = capacity - 1;
   int probe = (int)(ASC_HudHashObjectCacheKey(name) & (uint)mask);
   int scanned = 0;
   while(scanned < capacity)
     {
      int slot = g_asc_hud.object_cache_index_slots[probe];
      if(slot < 0)
         return -1;
      if(g_asc_hud.object_cache_index_keys[probe] == name)
        {
         if(MQLInfoInteger(MQL_DEBUG) != 0)
           {
            if(slot < 0 || slot >= ArraySize(g_asc_hud.object_cache))
               PrintFormat("ASC HUD object cache index out-of-range: name=%s slot=%d size=%d", name, slot, ArraySize(g_asc_hud.object_cache));
            else
               if(g_asc_hud.object_cache[slot].name != name)
                  PrintFormat("ASC HUD object cache index mismatch: name=%s slot=%d slot_name=%s", name, slot, g_asc_hud.object_cache[slot].name);
           }
         return slot;
        }
      probe = (probe + 1) & mask;
      scanned++;
     }
   return -1;
  }

int ASC_HudFindObjectCacheTracked(const string name)
  {
   int slot = ASC_HudFindObjectCache(name);
   if(slot >= 0)
      g_asc_hud.proof_object_cache_hit_count++;
   else
      g_asc_hud.proof_object_cache_miss_count++;
   return slot;
  }

bool ASC_HudObjectExistsAfterCacheMiss(const string name)
  {
   g_asc_hud.proof_object_find_count++;
   return (ObjectFind(0, name) >= 0);
  }

void ASC_HudRebuildObjectCacheIndex()
  {
   int cache_size = ArraySize(g_asc_hud.object_cache);
   ASC_HudEnsureObjectCacheIndexCapacity(cache_size);
   int capacity = g_asc_hud.object_cache_index_capacity;
   int mask = capacity - 1;
   for(int i = 0; i < capacity; i++)
     {
      g_asc_hud.object_cache_index_keys[i] = "";
      g_asc_hud.object_cache_index_slots[i] = -1;
     }
   g_asc_hud.object_cache_index_count = 0;

   for(int entry = 0; entry < cache_size; entry++)
     {
      string name = g_asc_hud.object_cache[entry].name;
      int probe = (int)(ASC_HudHashObjectCacheKey(name) & (uint)mask);
      while(g_asc_hud.object_cache_index_slots[probe] >= 0)
         probe = (probe + 1) & mask;
      g_asc_hud.object_cache_index_keys[probe] = name;
      g_asc_hud.object_cache_index_slots[probe] = entry;
      g_asc_hud.object_cache_index_count++;
     }
  }

void ASC_HudInvalidateObjectCache(const string name)
  {
   int slot = ASC_HudFindObjectCache(name);
   if(slot < 0)
      return;
   int last = ArraySize(g_asc_hud.object_cache) - 1;
   if(slot != last)
      g_asc_hud.object_cache[slot] = g_asc_hud.object_cache[last];
   ArrayResize(g_asc_hud.object_cache, last);
   ASC_HudRebuildObjectCacheIndex();
  }

void ASC_HudClearObjectCache()
  {
   ArrayResize(g_asc_hud.object_cache, 0);
   ArrayResize(g_asc_hud.object_cache_index_keys, 0);
   ArrayResize(g_asc_hud.object_cache_index_slots, 0);
   g_asc_hud.object_cache_index_capacity = 0;
   g_asc_hud.object_cache_index_count = 0;
  }

bool ASC_HudCommitObjectSignature(const string name,const string signature,const int object_type=-1)
  {
   int slot = ASC_HudFindObjectCache(name);
   if(slot >= 0)
     {
      if(g_asc_hud.object_cache[slot].signature == signature)
        {
         if(object_type >= 0 && g_asc_hud.object_cache[slot].object_type < 0)
            g_asc_hud.object_cache[slot].object_type = object_type;
         return false;
        }
      g_asc_hud.object_cache[slot].signature = signature;
      if(object_type >= 0)
         g_asc_hud.object_cache[slot].object_type = object_type;
     }
   else
     {
      int old = ArraySize(g_asc_hud.object_cache);
      ASC_HudEnsureObjectCacheIndexCapacity(old + 1);
      ArrayResize(g_asc_hud.object_cache, old + 1);
      g_asc_hud.object_cache[old].name = name;
      g_asc_hud.object_cache[old].signature = signature;
      g_asc_hud.object_cache[old].object_type = object_type;
      ASC_HudInsertObjectCacheIndexEntry(name, old);
     }

   g_asc_hud.render_mutations++;
   return true;
  }

void ASC_HudEnsureRect(const string name,const int x,const int y,const int w,const int h,const color fill,const color border)
  {
   g_asc_hud.telemetry_object_set_attempt_count++;
   bool created = false;
   int cache_slot = ASC_HudFindObjectCacheTracked(name);
   bool known_object = (cache_slot >= 0);
   if(known_object)
      g_asc_hud.hud_obj_create_reused++;
   if(!known_object && !ASC_HudObjectExistsAfterCacheMiss(name))
     {
      ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
      g_asc_hud.hud_obj_set_changed += 4;
      ASC_HudInvalidateObjectCache(name);
      created = true;
      g_asc_hud.proof_cycle_object_creates++;
      g_asc_hud.proof_object_create_total++;
     }

   string signature = StringFormat("%d|%d|%d|%d|%d|%d", x, y, w, h, (int)fill, (int)border);
   if(!created && !ASC_HudCommitObjectSignature(name, signature, OBJ_RECTANGLE_LABEL))
     {
      g_asc_hud.telemetry_object_set_noop_count++;
      g_asc_hud.proof_object_style_skipped_same_count++;
      g_asc_hud.hud_obj_set_skipped += 6;
      return;
     }

   if(created)
      ASC_HudCommitObjectSignature(name, signature, OBJ_RECTANGLE_LABEL);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, h);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, fill);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, border);
   g_asc_hud.telemetry_object_set_changed_count++;
   g_asc_hud.hud_obj_set_changed += 6;
   g_asc_hud.proof_cycle_style_writes++;
   g_asc_hud.proof_style_write_total++;
  }

void ASC_HudApplySoftCorners(const string name,
                             const int x,
                             const int y,
                             const int w,
                             const int h,
                             const color corner_mask)
  {
   // Sample A uses squared shells. Keep this helper so call sites stay intact,
   // but hide all corner-mask fragments to prevent forced rounded boxes.
   string tl = name + "_corner_tl";
   string tr = name + "_corner_tr";
   string bl = name + "_corner_bl";
   string br = name + "_corner_br";
   ASC_HudEnsureRect(tl, 0, 0, 0, 0, corner_mask, corner_mask);
   ASC_HudEnsureRect(tr, 0, 0, 0, 0, corner_mask, corner_mask);
   ASC_HudEnsureRect(bl, 0, 0, 0, 0, corner_mask, corner_mask);
   ASC_HudEnsureRect(br, 0, 0, 0, 0, corner_mask, corner_mask);
  }

void ASC_HudEnsureLabel(const string name,const string text,const int x,const int y,const int size,const color clr)
  {
   g_asc_hud.telemetry_object_set_attempt_count++;
   int render_x = x;
   int render_y = y;
   int render_size = size;
   color render_color = clr;
   string render_text = text;
   int viewport_w = g_asc_hud.viewport_w;
   int viewport_h = g_asc_hud.viewport_h;
   if(viewport_w <= 0) viewport_w = 1;
   if(viewport_h <= 0) viewport_h = 1;
   bool hide_label = (StringLen(render_text) <= 0
                      || render_size <= 0
                      || render_x < 0
                      || render_y < 0
                      || render_x >= (viewport_w - 1)
                      || render_y >= (viewport_h - 1));
   if(!hide_label)
     {
      int available_w = viewport_w - render_x - 2;
      if(available_w <= 0)
         hide_label = true;
      else
        {
         int max_chars = ASC_HudCharsForWidth(available_w, render_size);
         if(max_chars <= 0)
            hide_label = true;
         else
            render_text = ASC_HudClampText(render_text, max_chars);
        }
     }
   if(hide_label)
     {
      render_x = 0;
      render_y = 0;
      render_size = 8;
      render_color = clrBlack;
      render_text = "";
     }

   bool created = false;
   int cache_slot = ASC_HudFindObjectCacheTracked(name);
   bool known_object = (cache_slot >= 0);
   if(known_object)
      g_asc_hud.hud_obj_create_reused++;
   if(!known_object && !ASC_HudObjectExistsAfterCacheMiss(name))
     {
      ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
      ObjectSetString(0, name, OBJPROP_FONT, "Consolas");
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 9);
      ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
      g_asc_hud.hud_obj_set_changed += 7;
      ASC_HudInvalidateObjectCache(name);
      created = true;
      g_asc_hud.proof_cycle_object_creates++;
      g_asc_hud.proof_object_create_total++;
     }

   string signature = StringFormat("%d|%d|%d|%d|%s", render_x, render_y, render_size, (int)render_color, render_text);
   if(!created && !ASC_HudCommitObjectSignature(name, signature, OBJ_LABEL))
     {
      g_asc_hud.telemetry_object_set_noop_count++;
      g_asc_hud.proof_object_text_skipped_same_count++;
      g_asc_hud.proof_object_style_skipped_same_count++;
      if(hide_label)
         g_asc_hud.proof_object_visibility_skipped_same_count++;
      g_asc_hud.hud_obj_set_skipped += 7;
      return;
     }

   if(created)
      ASC_HudCommitObjectSignature(name, signature, OBJ_LABEL);

   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, render_x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, render_y);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, render_size);
   ObjectSetInteger(0, name, OBJPROP_COLOR, render_color);
   ObjectSetString(0, name, OBJPROP_TEXT, render_text);
   g_asc_hud.telemetry_object_set_changed_count++;
   g_asc_hud.hud_obj_set_changed += 7;
   g_asc_hud.proof_cycle_text_writes++;
   g_asc_hud.proof_text_write_total++;
   g_asc_hud.proof_cycle_style_writes++;
   g_asc_hud.proof_style_write_total++;
  }

bool ASC_HudSetLabelTextIfExists(const string name,const string text)
  {
   g_asc_hud.telemetry_object_set_attempt_count++;
   int slot = ASC_HudFindObjectCacheTracked(name);
   if(slot < 0 && !ASC_HudObjectExistsAfterCacheMiss(name))
     {
      g_asc_hud.telemetry_object_set_noop_count++;
      return false;
     }

   slot = ASC_HudFindObjectCache(name);
   if(slot >= 0)
     {
      string signature = g_asc_hud.object_cache[slot].signature;
      int divider = StringFind(signature, "|");
      divider = (divider >= 0 ? StringFind(signature, "|", divider + 1) : -1);
      divider = (divider >= 0 ? StringFind(signature, "|", divider + 1) : -1);
      divider = (divider >= 0 ? StringFind(signature, "|", divider + 1) : -1);
      string cached_text = (divider >= 0 ? StringSubstr(signature, divider + 1) : "");
      if(cached_text == text)
        {
         g_asc_hud.telemetry_object_set_noop_count++;
         g_asc_hud.proof_object_text_skipped_same_count++;
         g_asc_hud.hud_obj_set_skipped++;
         g_asc_hud.hud_label_set_skipped_text++;
         g_asc_hud.hud_label_text_reused++;
         return false;
        }

      int prefix_len = (divider >= 0 ? divider + 1 : 0);
      string next_signature = (prefix_len > 0 ? StringSubstr(signature, 0, prefix_len) : "0|0|8|0|") + text;
      if(!ASC_HudCommitObjectSignature(name, next_signature, OBJ_LABEL))
        {
         g_asc_hud.telemetry_object_set_noop_count++;
         return false;
        }
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      g_asc_hud.hud_obj_set_changed++;
      g_asc_hud.telemetry_object_set_changed_count++;
      g_asc_hud.proof_cycle_text_writes++;
      g_asc_hud.proof_text_write_total++;
      return true;
     }

   ASC_HudCommitObjectSignature(name, "0|0|8|0|" + text, OBJ_LABEL);
   ObjectSetString(0, name, OBJPROP_TEXT, text);
   g_asc_hud.hud_obj_set_changed++;
   g_asc_hud.telemetry_object_set_changed_count++;
   g_asc_hud.proof_cycle_text_writes++;
   g_asc_hud.proof_text_write_total++;
   return true;
  }

void ASC_HudEnsureButton(const string name,const string caption,const int x,const int y,const int w,const int h,const color bg,const color border,const color text_clr)
  {
   g_asc_hud.telemetry_object_set_attempt_count++;
   bool created = false;
   int cache_slot = ASC_HudFindObjectCacheTracked(name);
   bool known_object = (cache_slot >= 0);
   if(known_object)
      g_asc_hud.hud_obj_create_reused++;
   if(!known_object && !ASC_HudObjectExistsAfterCacheMiss(name))
     {
      ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
      ObjectSetString(0, name, OBJPROP_FONT, "Consolas");
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 9);
      g_asc_hud.hud_obj_set_changed += 5;
      ASC_HudInvalidateObjectCache(name);
      created = true;
      g_asc_hud.proof_cycle_object_creates++;
      g_asc_hud.proof_object_create_total++;
     }

   string button_caption = caption;
   if(w > 0 && h > 0 && StringLen(button_caption) > 0)
     {
      int max_chars = ASC_HudCharsForWidth(w - 16, 9);
      button_caption = ASC_HudClampText(button_caption, max_chars);
     }

   string signature = StringFormat("%d|%d|%d|%d|%d|%d|%d|%s", x, y, w, h, (int)bg, (int)border, (int)text_clr, button_caption);
   if(!created && !ASC_HudCommitObjectSignature(name, signature, OBJ_BUTTON))
     {
      g_asc_hud.telemetry_object_set_noop_count++;
      g_asc_hud.proof_object_text_skipped_same_count++;
      g_asc_hud.proof_object_style_skipped_same_count++;
      if(w <= 0 || h <= 0 || StringLen(button_caption) <= 0)
         g_asc_hud.proof_object_visibility_skipped_same_count++;
      g_asc_hud.hud_obj_set_skipped += 9;
      return;
     }

   if(created)
      ASC_HudCommitObjectSignature(name, signature, OBJ_BUTTON);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, h);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, bg);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, border);
   ObjectSetInteger(0, name, OBJPROP_COLOR, text_clr);
   ObjectSetString(0, name, OBJPROP_TEXT, button_caption);
   ObjectSetInteger(0, name, OBJPROP_STATE, false);
   g_asc_hud.telemetry_object_set_changed_count++;
   g_asc_hud.hud_obj_set_changed += 9;
   g_asc_hud.proof_cycle_text_writes++;
   g_asc_hud.proof_text_write_total++;
   g_asc_hud.proof_cycle_style_writes++;
   g_asc_hud.proof_style_write_total++;
  }

color ASC_HudThemeBgRoot() { return C'3,3,3'; }           // #030303
color ASC_HudThemeBgPanel() { return C'13,15,20'; }       // #0D0F14
color ASC_HudThemeBgCard() { return C'21,26,35'; }        // #151A23
color ASC_HudThemeBgCardAlt() { return C'24,31,42'; }     // elevated dark panel
color ASC_HudThemeBgPanelAlt() { return C'16,21,30'; }
color ASC_HudThemeBgLayer2() { return ASC_HudThemeBgCard(); } // #151A23
color ASC_HudThemeBgLayer3() { return C'12,16,24'; }

color ASC_HudThemeBorderBase() { return C'44,54,70'; }    // dark-platinum edge
color ASC_HudThemeBorderEdge() { return C'78,90,112'; }    // brighter shell edge
color ASC_HudThemeBorderFocus() { return C'179,136,255'; }// #B388FF
color ASC_HudThemeBorderWarning() { return C'255,184,77'; }// #FFB84D
color ASC_HudThemeBorderError() { return C'255,90,122'; } // #FF5A7A

color ASC_HudThemeTextPrimary() { return C'245,247,250'; }   // #F5F7FA
color ASC_HudThemeTextSecondary() { return C'184,194,211'; } // #B8C2D3
color ASC_HudThemeTextMuted() { return C'138,150,170'; }     // muted platinum

color ASC_HudThemeAccentPrimary() { return C'179,136,255'; }   // #B388FF
color ASC_HudThemeAccentSecondary() { return C'82,229,255'; }  // #52E5FF
color ASC_HudThemeAccentTactical() { return C'76,255,181'; }   // #4CFFB5
color ASC_HudThemeAccentWarning() { return C'255,184,77'; }    // #FFB84D
color ASC_HudThemeAccentSelected() { return C'82,229,255'; }   // #52E5FF
color ASC_HudThemeAccentError() { return C'255,90,122'; }      // #FF5A7A
color ASC_HudThemeAccentCardA() { return ASC_HudThemeAccentPrimary(); }
color ASC_HudThemeAccentCardB() { return ASC_HudThemeAccentSecondary(); }
color ASC_HudThemeAccentCardC() { return ASC_HudThemeAccentSelected(); }
color ASC_HudThemeAccentCardD() { return ASC_HudThemeAccentTactical(); }

void ASC_HudThemeButton(const bool selected,color &bg,color &border,color &text)
  {
   bg = selected ? ASC_HudThemeBgCardAlt() : ASC_HudThemeBgPanelAlt();
   border = selected ? ASC_HudThemeBorderFocus() : ASC_HudThemeBorderBase();
   text = selected ? ASC_HudThemeTextPrimary() : ASC_HudThemeTextSecondary();
  }

void ASC_HudThemeActionButton(const bool enabled,const bool selected,color &bg,color &border,color &text)
  {
   if(selected)
     {
      bg = ASC_HudThemeBgCardAlt();
      border = ASC_HudThemeAccentPrimary();
      text = ASC_HudThemeTextPrimary();
      return;
     }

   if(enabled)
     {
      bg = ASC_HudThemeBgPanelAlt();
      border = ASC_HudThemeAccentSecondary();
      text = ASC_HudThemeTextPrimary();
      return;
     }

   bg = ASC_HudThemeBgPanel();
   border = ASC_HudThemeBorderBase();
  text = ASC_HudThemeTextMuted();
  }

void ASC_HudThemeSemanticChip(const string chip_text,const bool focused,color &bg,color &border,color &text)
  {
   string lowered = chip_text;
   StringToLower(lowered);

   bg = focused ? ASC_HudThemeBgCardAlt() : ASC_HudThemeBgLayer3();
   border = focused ? ASC_HudThemeAccentPrimary() : ASC_HudThemeBorderBase();
   text = focused ? ASC_HudThemeTextPrimary() : ASC_HudThemeTextSecondary();

   bool warning_state = (StringFind(lowered, "blocked") >= 0
                         || StringFind(lowered, "stale") >= 0
                         || StringFind(lowered, "friction high") >= 0
                         || StringFind(lowered, "risk high") >= 0
                         || StringFind(lowered, "spread high") >= 0);
   if(warning_state)
     {
      bg = ASC_HudThemeBgPanel();
      border = ASC_HudThemeBorderWarning();
      text = ASC_HudThemeAccentWarning();
      return;
     }

   bool positive_state = (StringFind(lowered, "promoted") >= 0
                          || StringFind(lowered, "deep ready") >= 0
                          || StringFind(lowered, "ready now") >= 0);
   if(positive_state)
     {
      bg = ASC_HudThemeBgPanelAlt();
      border = ASC_HudThemeAccentPrimary();
      text = ASC_HudThemeTextPrimary();
      return;
     }

   bool watch_state = (StringFind(lowered, "reserve") >= 0
                       || StringFind(lowered, "watch") >= 0
                       || StringFind(lowered, "pending") >= 0);
   if(watch_state)
     {
      bg = ASC_HudThemeBgPanelAlt();
      border = ASC_HudThemeAccentSecondary();
      text = ASC_HudThemeTextPrimary();
      return;
     }
  }

void ASC_HudThemeRowSurface(const int row_index,const bool warning,const bool focused,color &bg,color &border,color &accent)
  {
   bg = (row_index % 2 == 0) ? ASC_HudThemeBgCard() : ASC_HudThemeBgCardAlt();
   border = warning ? ASC_HudThemeBorderWarning() : ASC_HudThemeBorderBase();
   accent = warning ? ASC_HudThemeAccentWarning() : ASC_HudThemeAccentTactical();
   if(focused)
     {
      bg = ASC_HudThemeBgCardAlt();
      border = ASC_HudThemeBorderFocus();
      accent = ASC_HudThemeAccentPrimary();
     }
  }

void ASC_HudDeleteObjects()
  {
   g_asc_hud.telemetry_viewport_full_delete_count++;
   g_asc_hud.proof_object_property_read_count++;
   int total = ObjectsTotal(0, 0, -1);
   for(int i = total - 1; i >= 0; i--)
     {
      g_asc_hud.proof_object_property_read_count++;
      string name = ObjectName(0, i, 0, -1);
      if(StringFind(name, ASC_HUD_PREFIX) == 0)
        {
         ObjectDelete(0, name);
         g_asc_hud.proof_cycle_object_deletes++;
         g_asc_hud.proof_object_delete_total++;
         g_asc_hud.proof_object_delete_single_count++;
        }
     }
   ASC_HudClearObjectCache();
  }

bool ASC_HudIsGlobalObjectName(const string name)
  {
   if(name == ASC_HUD_PREFIX + "bg")
      return true;
   if(name == ASC_HUD_PREFIX + "header"
      || name == ASC_HUD_PREFIX + "header_glow"
      || name == ASC_HUD_PREFIX + "topnav"
      || name == ASC_HUD_PREFIX + "crumb_zone"
      || name == ASC_HUD_PREFIX + "breadcrumb"
      || name == ASC_HUD_PREFIX + "nav_back_divider")
      return true;
   if(StringFind(name, ASC_HUD_PREFIX + "nav_") == 0)
      return true;
   if(StringFind(name, ASC_HUD_PREFIX + "hdr_") == 0)
      return true;
   if(StringFind(name, ASC_HUD_PREFIX + "crumb_") == 0)
      return true;
   if(StringFind(name, ASC_HUD_PREFIX + "transition_") == 0)
      return true;
   if(name == ASC_HUD_PREFIX + "status_strip"
      || name == ASC_HUD_PREFIX + "status_bar"
      || name == ASC_HUD_PREFIX + "status_text")
      return true;
   if(name == ASC_HUD_PREFIX + "btn_home"
      || name == ASC_HUD_PREFIX + "btn_buckets"
      || name == ASC_HUD_PREFIX + "btn_leaders"
      || name == ASC_HUD_PREFIX + "btn_sub_groups"
      || name == ASC_HUD_PREFIX + "btn_symbols"
      || name == ASC_HUD_PREFIX + "btn_top10"
      || name == ASC_HUD_PREFIX + "btn_symbol"
      || name == ASC_HUD_PREFIX + "btn_details"
      || name == ASC_HUD_PREFIX + "btn_detail"
      || name == ASC_HUD_PREFIX + "btn_back"
      || name == ASC_HUD_PREFIX + "btn_forward")
      return true;
   return false;
  }

void ASC_HudDeletePageLocalObjects()
  {
   g_asc_hud.telemetry_viewport_full_delete_count++;
   int total = ArraySize(g_asc_hud.object_cache);
   for(int i = total - 1; i >= 0; i--)
     {
      string name = g_asc_hud.object_cache[i].name;
      if(StringLen(name) <= 0)
         continue;
      if(ASC_HudIsGlobalObjectName(name))
         continue;

      int object_type = g_asc_hud.object_cache[i].object_type;
      if(object_type < 0)
        {
         g_asc_hud.proof_object_property_read_count++;
         object_type = (int)ObjectGetInteger(0, name, OBJPROP_TYPE);
        }
      if(object_type == OBJ_RECTANGLE_LABEL)
        {
         ASC_HudEnsureRect(name, 0, 0, 0, 0, clrBlack, clrBlack);
         g_asc_hud.proof_object_delete_scoped_count++;
         g_asc_hud.hud_obj_delete_avoided++;
         g_asc_hud.hud_scoped_hide_count++;
         continue;
        }
      if(object_type == OBJ_LABEL)
        {
         ASC_HudEnsureLabel(name, "", 0, 0, 8, clrBlack);
         g_asc_hud.proof_object_delete_scoped_count++;
         g_asc_hud.hud_obj_delete_avoided++;
         g_asc_hud.hud_scoped_hide_count++;
         continue;
        }
      if(object_type == OBJ_BUTTON)
        {
         ASC_HudEnsureButton(name, "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
         g_asc_hud.proof_object_delete_scoped_count++;
         g_asc_hud.hud_obj_delete_avoided++;
         g_asc_hud.hud_scoped_hide_count++;
         continue;
        }

      ObjectDelete(0, name);
      ASC_HudInvalidateObjectCache(name);
      g_asc_hud.proof_cycle_object_deletes++;
      g_asc_hud.proof_object_delete_total++;
      g_asc_hud.proof_object_delete_single_count++;
     g_asc_hud.proof_object_delete_scoped_count++;
     }
  }

void ASC_HudTrackPageChangeRequest(const ASC_HudPage target_page)
  {
   g_asc_hud.telemetry_page_change_request_count++;
   g_asc_hud.telemetry_page_change_request_started_ms = GetTickCount();
   g_asc_hud.telemetry_page_change_request_target = target_page;
  }

void ASC_HudPushHistory()
  {
   if(g_asc_hud.history_count >= ASC_HUD_HISTORY_LIMIT)
     {
      for(int i = 1; i < ASC_HUD_HISTORY_LIMIT; i++)
        {
         g_asc_hud.history_pages[i - 1] = g_asc_hud.history_pages[i];
         g_asc_hud.history_bucket[i - 1] = g_asc_hud.history_bucket[i];
         g_asc_hud.history_sub_bucket[i - 1] = g_asc_hud.history_sub_bucket[i];
         g_asc_hud.history_browse_parent[i - 1] = g_asc_hud.history_browse_parent[i];
         g_asc_hud.history_browse_node[i - 1] = g_asc_hud.history_browse_node[i];
         g_asc_hud.history_symbol[i - 1] = g_asc_hud.history_symbol[i];
         g_asc_hud.history_offset[i - 1] = g_asc_hud.history_offset[i];
         g_asc_hud.history_stat[i - 1] = g_asc_hud.history_stat[i];
         g_asc_hud.history_section[i - 1] = g_asc_hud.history_section[i];
         g_asc_hud.history_deep_subpage[i - 1] = g_asc_hud.history_deep_subpage[i];
        }
      g_asc_hud.history_count = ASC_HUD_HISTORY_LIMIT - 1;
     }

   int slot = g_asc_hud.history_count;
   g_asc_hud.history_pages[slot] = g_asc_hud.page;
   g_asc_hud.history_bucket[slot] = g_asc_hud.selected_bucket_id;
   g_asc_hud.history_sub_bucket[slot] = g_asc_hud.selected_sub_bucket_key;
   g_asc_hud.history_browse_parent[slot] = g_asc_hud.selected_browse_parent_key;
   g_asc_hud.history_browse_node[slot] = g_asc_hud.selected_browse_node_key;
   g_asc_hud.history_symbol[slot] = g_asc_hud.selected_symbol;
   g_asc_hud.history_offset[slot] = g_asc_hud.list_offset;
   g_asc_hud.history_stat[slot] = g_asc_hud.selected_stat;
   g_asc_hud.history_section[slot] = g_asc_hud.selected_symbol_section;
   g_asc_hud.history_deep_subpage[slot] = g_asc_hud.selected_deep_subpage;
   g_asc_hud.history_count++;
  }

void ASC_HudClearForwardHistory()
  {
   g_asc_hud.forward_count = 0;
  }

void ASC_HudPushForwardCurrent()
  {
   if(g_asc_hud.forward_count >= ASC_HUD_HISTORY_LIMIT)
     {
      for(int i = 1; i < ASC_HUD_HISTORY_LIMIT; i++)
        {
         g_asc_hud.forward_pages[i - 1] = g_asc_hud.forward_pages[i];
         g_asc_hud.forward_bucket[i - 1] = g_asc_hud.forward_bucket[i];
         g_asc_hud.forward_sub_bucket[i - 1] = g_asc_hud.forward_sub_bucket[i];
         g_asc_hud.forward_browse_parent[i - 1] = g_asc_hud.forward_browse_parent[i];
         g_asc_hud.forward_browse_node[i - 1] = g_asc_hud.forward_browse_node[i];
         g_asc_hud.forward_symbol[i - 1] = g_asc_hud.forward_symbol[i];
         g_asc_hud.forward_offset[i - 1] = g_asc_hud.forward_offset[i];
         g_asc_hud.forward_stat[i - 1] = g_asc_hud.forward_stat[i];
         g_asc_hud.forward_section[i - 1] = g_asc_hud.forward_section[i];
         g_asc_hud.forward_deep_subpage[i - 1] = g_asc_hud.forward_deep_subpage[i];
        }
      g_asc_hud.forward_count = ASC_HUD_HISTORY_LIMIT - 1;
     }

   int slot = g_asc_hud.forward_count;
   g_asc_hud.forward_pages[slot] = g_asc_hud.page;
   g_asc_hud.forward_bucket[slot] = g_asc_hud.selected_bucket_id;
   g_asc_hud.forward_sub_bucket[slot] = g_asc_hud.selected_sub_bucket_key;
   g_asc_hud.forward_browse_parent[slot] = g_asc_hud.selected_browse_parent_key;
   g_asc_hud.forward_browse_node[slot] = g_asc_hud.selected_browse_node_key;
   g_asc_hud.forward_symbol[slot] = g_asc_hud.selected_symbol;
   g_asc_hud.forward_offset[slot] = g_asc_hud.list_offset;
   g_asc_hud.forward_stat[slot] = g_asc_hud.selected_stat;
   g_asc_hud.forward_section[slot] = g_asc_hud.selected_symbol_section;
   g_asc_hud.forward_deep_subpage[slot] = g_asc_hud.selected_deep_subpage;
   g_asc_hud.forward_count++;
  }

void ASC_HudLogNavigationRestore(const string stage,const string reason)
  {
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudNavigationRestore", g_asc_hud.selected_symbol,
               StringFormat("stage=%s reason=%s page=%s bucket=%s sub=%s symbol=%s offset=%d back=%d forward=%d",
                            stage,
                            reason,
                            ASC_HudPageName(g_asc_hud.page),
                            g_asc_hud.selected_bucket_id,
                            g_asc_hud.selected_sub_bucket_key,
                            g_asc_hud.selected_symbol,
                            g_asc_hud.list_offset,
                            g_asc_hud.history_count,
                            g_asc_hud.forward_count));
  }

void ASC_HudNormalizeRestoredState(const string stage)
  {
   string reason = "state_valid";
   if(StringLen(g_asc_hud.selected_bucket_id) <= 0 || !ASC_HudBucketAllowedByControls(g_asc_hud.selected_bucket_id))
     {
      string prior = g_asc_hud.selected_bucket_id;
      g_asc_hud.selected_bucket_id = "unknown";
      reason = "bucket_fallback_from_" + prior;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS && ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
     {
      string root_parent = "B|" + g_asc_hud.selected_bucket_id;
      if(StringLen(g_asc_hud.selected_browse_parent_key) <= 0
         || !ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_browse_parent_key, g_asc_hud.selected_bucket_id)
         || !ASC_HudBrowseNodeHasAncestor(g_asc_hud.selected_browse_parent_key, root_parent))
        {
         g_asc_hud.selected_browse_parent_key = root_parent;
         reason = "browse_parent_rebased";
        }
     }

   if((g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
      && StringLen(g_asc_hud.selected_symbol) > 0)
     {
      if(ASC_HudResolveSelectedSymbolLayer1Index() < 0)
        {
         reason = "symbol_not_in_scope_fallback_symbols";
         g_asc_hud.page = ASC_HUD_PAGE_SYMBOLS;
         g_asc_hud.selected_symbol = "";
         g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
         g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_THESIS;
         g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
        }
     }

   ASC_HudLogNavigationRestore(stage, reason);
  }

void ASC_HudLogLeadersScope(const string stage,const string source,const string reason)
  {
   string detail = StringFormat("stage=%s source=%s reason=%s page=%s bucket=%s sub=%s symbol=%s list_offset=%d page_idx=%d/%d rows=%d range=%d-%d",
                                stage,
                                source,
                                reason,
                                ASC_HudPageName(g_asc_hud.page),
                                g_asc_hud.selected_bucket_id,
                                g_asc_hud.selected_sub_bucket_key,
                                g_asc_hud.selected_symbol,
                                g_asc_hud.list_offset,
                                g_asc_hud.list_current_page,
                                g_asc_hud.list_total_pages,
                                ArraySize(g_asc_hud.leader_row_indices),
                                g_asc_hud.list_range_start,
                                g_asc_hud.list_range_end);
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudLeadersScope", g_asc_hud.selected_symbol, detail);
  }

void ASC_HudGoHome()
  {
   if(g_asc_hud.page == ASC_HUD_PAGE_OVERVIEW)
      return;

   ASC_HudTrackPageChangeRequest(ASC_HUD_PAGE_OVERVIEW);
   ASC_HudPushHistory();
   ASC_HudClearForwardHistory();
   g_asc_hud.transition_from = g_asc_hud.page;
   g_asc_hud.transition_to = ASC_HUD_PAGE_OVERVIEW;
   g_asc_hud.transition_label = "Home";
   g_asc_hud.transition_until = TimeGMT() + 1;
   ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
   g_asc_hud.page = ASC_HUD_PAGE_OVERVIEW;
   g_asc_hud.list_offset = 0;
   g_asc_hud.selected_browse_parent_key = "";
   g_asc_hud.selected_browse_node_key = "";
   ASC_HudInvalidateSelectedSymbolCache();
   ASC_HudMarkDirtyNavigation(ASC_HudNavigationFlagsForPage(g_asc_hud.page));
  }

void ASC_HudGoBack()
  {
   if(g_asc_hud.history_count <= 0)
     {
      ASC_HudSetNotice("Back stack empty. Returned to Overview.");
      ASC_HudGoHome();
      return;
     }

   ASC_HudPushForwardCurrent();
   string prior_bucket_id = g_asc_hud.selected_bucket_id;
   int slot = g_asc_hud.history_count - 1;
   g_asc_hud.transition_from = g_asc_hud.page;
   g_asc_hud.transition_to = g_asc_hud.history_pages[slot];
   ASC_HudTrackPageChangeRequest(g_asc_hud.history_pages[slot]);
   g_asc_hud.transition_label = "Back";
   g_asc_hud.transition_until = TimeGMT() + 1;
   ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
   g_asc_hud.page = g_asc_hud.history_pages[slot];
   g_asc_hud.selected_bucket_id = g_asc_hud.history_bucket[slot];
   g_asc_hud.selected_sub_bucket_key = g_asc_hud.history_sub_bucket[slot];
   g_asc_hud.selected_browse_parent_key = g_asc_hud.history_browse_parent[slot];
   g_asc_hud.selected_browse_node_key = g_asc_hud.history_browse_node[slot];
   g_asc_hud.selected_symbol = g_asc_hud.history_symbol[slot];
   g_asc_hud.list_offset = g_asc_hud.history_offset[slot];
   g_asc_hud.selected_stat = g_asc_hud.history_stat[slot];
   g_asc_hud.selected_symbol_section = g_asc_hud.history_section[slot];
   g_asc_hud.selected_deep_subpage = g_asc_hud.history_deep_subpage[slot];
   g_asc_hud.history_count--;
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      string restore_reason = "history restore";
      if(StringLen(g_asc_hud.selected_bucket_id) <= 0)
        {
         if(StringLen(prior_bucket_id) > 0 && ASC_HudBucketAllowedByControls(prior_bucket_id))
           {
            g_asc_hud.selected_bucket_id = prior_bucket_id;
            restore_reason = "history bucket missing -> kept prior bucket context";
           }
         else
           {
            g_asc_hud.selected_bucket_id = "unknown";
            restore_reason = "history bucket missing -> fallback unknown";
           }
        }
      ASC_HudRebuildBucketLeadersList();
      g_asc_hud.last_leaders_bucket_id = g_asc_hud.selected_bucket_id;
      g_asc_hud.last_leaders_shortlist_signature = ASC_HudShortlistOrderingSignature();
      if(g_asc_hud.list_offset < 0)
         g_asc_hud.list_offset = 0;
      ASC_HudLogLeadersScope("restored_scope", "history+leader_rebuild", restore_reason);
     }
   ASC_HudNormalizeRestoredState("back_restore");
   ASC_HudInvalidateSelectedSymbolCache();
   ASC_HudMarkDirtyNavigation(ASC_HudNavigationFlagsForPage(g_asc_hud.page));
  }

void ASC_HudGoForward()
  {
   if(g_asc_hud.forward_count <= 0)
     {
      ASC_HudSetNotice("Forward stack empty.");
      return;
     }

   ASC_HudPushHistory();
   int slot = g_asc_hud.forward_count - 1;
   g_asc_hud.transition_from = g_asc_hud.page;
   g_asc_hud.transition_to = g_asc_hud.forward_pages[slot];
   ASC_HudTrackPageChangeRequest(g_asc_hud.forward_pages[slot]);
   g_asc_hud.transition_label = "Forward";
   g_asc_hud.transition_until = TimeGMT() + 1;
   ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
   g_asc_hud.page = g_asc_hud.forward_pages[slot];
   g_asc_hud.selected_bucket_id = g_asc_hud.forward_bucket[slot];
   g_asc_hud.selected_sub_bucket_key = g_asc_hud.forward_sub_bucket[slot];
   g_asc_hud.selected_browse_parent_key = g_asc_hud.forward_browse_parent[slot];
   g_asc_hud.selected_browse_node_key = g_asc_hud.forward_browse_node[slot];
   g_asc_hud.selected_symbol = g_asc_hud.forward_symbol[slot];
   g_asc_hud.list_offset = g_asc_hud.forward_offset[slot];
   g_asc_hud.selected_stat = g_asc_hud.forward_stat[slot];
   g_asc_hud.selected_symbol_section = g_asc_hud.forward_section[slot];
   g_asc_hud.selected_deep_subpage = g_asc_hud.forward_deep_subpage[slot];
   g_asc_hud.forward_count--;

   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      ASC_HudRebuildBucketLeadersList();
      g_asc_hud.last_leaders_bucket_id = g_asc_hud.selected_bucket_id;
      g_asc_hud.last_leaders_shortlist_signature = ASC_HudShortlistOrderingSignature();
      if(g_asc_hud.list_offset < 0)
         g_asc_hud.list_offset = 0;
      ASC_HudLogLeadersScope("restored_scope", "forward+leader_rebuild", "forward restore");
     }

   ASC_HudNormalizeRestoredState("forward_restore");
   ASC_HudInvalidateSelectedSymbolCache();
   ASC_HudMarkDirtyNavigation(ASC_HudNavigationFlagsForPage(g_asc_hud.page));
  }

void ASC_HudOpenPage(const ASC_HudPage page)
  {
   ASC_HudPage prior_page = g_asc_hud.page;
   if(prior_page != page)
     {
      ASC_HudTrackPageChangeRequest(page);
      ASC_HudPushHistory();
      ASC_HudClearForwardHistory();
      g_asc_hud.transition_from = prior_page;
      g_asc_hud.transition_to = page;
      g_asc_hud.transition_label = "Navigate";
      g_asc_hud.transition_until = TimeGMT() + 1;
      ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
     }

   g_asc_hud.page = page;
   if(page == ASC_HUD_PAGE_MAIN_BUCKETS)
     {
      g_asc_hud.selected_browse_parent_key = "";
      g_asc_hud.selected_browse_node_key = "";
     }
   else if(page == ASC_HUD_PAGE_SUB_GROUPS && ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
     {
      string root_parent = "B|" + g_asc_hud.selected_bucket_id;
      if(StringLen(g_asc_hud.selected_browse_parent_key) <= 0
         || !ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_browse_parent_key, g_asc_hud.selected_bucket_id)
         || !ASC_HudBrowseNodeHasAncestor(g_asc_hud.selected_browse_parent_key, root_parent))
         g_asc_hud.selected_browse_parent_key = root_parent;
     }

   bool list_target = (page == ASC_HUD_PAGE_MAIN_BUCKETS
                       || page == ASC_HUD_PAGE_BUCKET_LEADERS
                       || page == ASC_HUD_PAGE_SUB_GROUPS
                       || page == ASC_HUD_PAGE_SYMBOLS);
   if(list_target)
      g_asc_hud.list_offset = 0;

   bool symbol_target = (page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || page == ASC_HUD_PAGE_ASPECT_DETAIL);
   bool same_symbol_context = ((prior_page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || prior_page == ASC_HUD_PAGE_ASPECT_DETAIL) && symbol_target);
   if(list_target || !same_symbol_context)
      ASC_HudInvalidateSelectedSymbolCache();

   if(ASC_HudPageNeedsHeavyDataset(page) && g_asc_hud.queued_heavy_refresh)
     {
      ASC_HudMarkDirtyDataHeavy();
      g_asc_hud.queued_heavy_refresh = false;
      g_asc_hud.queued_heavy_refresh_reason = "";
     }

   ASC_HudMarkDirtyNavigation(ASC_HudNavigationFlagsForPage(page));
  }

void ASC_HudResetRows()
  {
   string ids[] = {"fx", "indices", "stocks", "metals", "energy", "crypto", "rates", "volatility", "commodities", "funds_etfs", "unknown"};
   ArrayResize(g_asc_hud.buckets, ArraySize(ids));
   for(int i = 0; i < ArraySize(ids); i++)
     {
      g_asc_hud.buckets[i].id = ids[i];
      g_asc_hud.buckets[i].name = ASC_HudMainBucketName(ids[i]);
      g_asc_hud.buckets[i].total = 0;
      g_asc_hud.buckets[i].open_count = 0;
      g_asc_hud.buckets[i].closed_count = 0;
      g_asc_hud.buckets[i].uncertain_count = 0;
      g_asc_hud.buckets[i].unresolved_count = 0;
      g_asc_hud.buckets[i].canonical_global_order = 2147483647;
     }

   ArrayResize(g_asc_hud.sub_buckets, 0);
   ArrayResize(g_asc_hud.sub_bucket_lookup, 0);
   ArrayResize(g_asc_hud.browse_nodes, 0);
   ArrayResize(g_asc_hud.browse_node_lookup, 0);
   ArrayResize(g_asc_hud.leader_row_indices, 0);
   ArrayResize(g_asc_hud.symbol_indices, 0);
   ArrayResize(g_asc_hud.canonical_bucket_metrics, 0);
   ArrayResize(g_asc_hud.canonical_bucket_metric_lookup, 0);
   ArrayResize(g_asc_hud.canonical_subgroup_metrics, 0);
   ArrayResize(g_asc_hud.canonical_subgroup_metric_lookup, 0);
   ArrayResize(g_asc_hud.canonical_browse_metrics, 0);
   ArrayResize(g_asc_hud.canonical_browse_metric_lookup, 0);
   g_asc_hud.selected_symbol_list_key = "";
   g_asc_hud.selected_symbol_list_filter_signature = "";
   g_asc_hud.selected_symbol_list_revision = 0;
   g_asc_hud.selected_symbol_list_shortlist_revision = 0;
  }

int ASC_HudFindSubBucket(const string key)
  {
   int left = 0;
   int right = ArraySize(g_asc_hud.sub_bucket_lookup) - 1;
   while(left <= right)
     {
      int mid = (left + right) / 2;
      string mid_key = g_asc_hud.sub_bucket_lookup[mid].key;
      if(mid_key == key)
         return g_asc_hud.sub_bucket_lookup[mid].index;
      if(mid_key < key)
         left = mid + 1;
      else
         right = mid - 1;
     }
   return -1;
  }

void ASC_HudInsertSubBucketLookup(const string key,const int slot)
  {
   int count = ArraySize(g_asc_hud.sub_bucket_lookup);
   int left = 0;
   int right = count - 1;
   while(left <= right)
     {
      int mid = (left + right) / 2;
      string mid_key = g_asc_hud.sub_bucket_lookup[mid].key;
      if(mid_key == key)
        {
         g_asc_hud.sub_bucket_lookup[mid].index = slot;
         return;
        }
      if(mid_key < key)
         left = mid + 1;
      else
         right = mid - 1;
     }

   int insert_at = left;
   ArrayResize(g_asc_hud.sub_bucket_lookup, count + 1, 64);
   for(int i = count; i > insert_at; i--)
      g_asc_hud.sub_bucket_lookup[i] = g_asc_hud.sub_bucket_lookup[i - 1];
   g_asc_hud.sub_bucket_lookup[insert_at].key = key;
   g_asc_hud.sub_bucket_lookup[insert_at].index = slot;
  }

void ASC_HudRebuildData()
  {
   ASC_HudResetRows();
   g_asc_hud.rebuild_tracked_symbols = 0;
   g_asc_hud.rebuild_assigned_symbols = 0;
   g_asc_hud.rebuild_fallback_symbols = 0;
   g_asc_hud.rebuild_lost_symbols = 0;

   int cache_total = ASC_Layer1CachedSymbolCount();
   g_asc_hud.rebuild_tracked_symbols = cache_total;

   for(int i = 0; i < cache_total; i++)
     {
      ASC_Layer1SymbolState state;
      if(!ASC_HudMaterializeSymbolState(i, state))
         continue;

      string effective_main_bucket_id = ASC_HudEffectiveMainBucketId(state);
      int slot = ASC_HudMainBucketSlot(effective_main_bucket_id);
      if(slot < 0)
        {
         effective_main_bucket_id = "unknown";
         slot = ASC_HudMainBucketSlot(effective_main_bucket_id);
        }
      if(slot >= 0)
        {
         g_asc_hud.buckets[slot].total++;
         if(state.state == ASC_L1_OPEN) g_asc_hud.buckets[slot].open_count++;
         if(state.state == ASC_L1_CLOSED) g_asc_hud.buckets[slot].closed_count++;
         if(state.state == ASC_L1_UNCERTAIN) g_asc_hud.buckets[slot].uncertain_count++;
         if(!state.classification.resolved) g_asc_hud.buckets[slot].unresolved_count++;
         g_asc_hud.rebuild_assigned_symbols++;
        }

      string main_node_key = "B|" + effective_main_bucket_id;
      int main_node_slot = ASC_HudEnsureBrowseNode(main_node_key,
                                                   "",
                                                   ASC_HUD_BROWSE_MAIN_BUCKET,
                                                   effective_main_bucket_id,
                                                   ASC_HudMainBucketName(effective_main_bucket_id),
                                                   "canonical");
      ASC_HudAccumulateBrowseNode(main_node_slot, state);

      if(ASC_HudIsStockBucketId(effective_main_bucket_id))
        {
         string family_id = ASC_HudStockFamilyId(state);
         string family_name = ASC_HudStockFamilyName(state, family_id);
         string family_key = "F|" + effective_main_bucket_id + "|" + family_id;
         int family_slot = ASC_HudEnsureBrowseNode(family_key,
                                                   main_node_key,
                                                   ASC_HUD_BROWSE_STOCK_FAMILY,
                                                   family_id,
                                                   family_name,
                                                   "classification");
         ASC_HudAccumulateBrowseNode(family_slot, state);

         string sector_id = ASC_HudStockSectorId(state);
         string sector_name = ASC_HudStockSectorName(state, sector_id);
         string sector_key = "S|" + effective_main_bucket_id + "|" + family_id + "|" + sector_id;
         int sector_slot = ASC_HudEnsureBrowseNode(sector_key,
                                                   family_key,
                                                   ASC_HUD_BROWSE_STOCK_SECTOR,
                                                   sector_id,
                                                   sector_name,
                                                   "classification");
         ASC_HudAccumulateBrowseNode(sector_slot, state);

         string industry_id = ASC_HudStockIndustryId(state);
         string industry_name = ASC_HudStockIndustryName(state, industry_id);
         string industry_key = "I|" + effective_main_bucket_id + "|" + family_id + "|" + sector_id + "|" + industry_id;
         int industry_slot = ASC_HudEnsureBrowseNode(industry_key,
                                                     sector_key,
                                                     ASC_HUD_BROWSE_STOCK_INDUSTRY,
                                                     industry_id,
                                                     industry_name,
                                                     "classification");
         ASC_HudAccumulateBrowseNode(industry_slot, state);
        }

      string sub_id = ASC_HudEffectiveSubBucketId(state, effective_main_bucket_id);
      string sub_name = ASC_HudEffectiveSubBucketName(state, effective_main_bucket_id);
      string native_sub_id = ASC_HudTrim(state.classification.sub_bucket_id);
      if(StringLen(native_sub_id) <= 0)
         g_asc_hud.rebuild_fallback_symbols++;
      if(slot >= 0)
        {
         string key = effective_main_bucket_id + "|" + sub_id;
         int sub_slot = ASC_HudFindSubBucket(key);
         if(sub_slot < 0)
           {
            int old = ArraySize(g_asc_hud.sub_buckets);
            ArrayResize(g_asc_hud.sub_buckets, old + 1, 64);
            sub_slot = old;
            g_asc_hud.sub_buckets[sub_slot].key = key;
            g_asc_hud.sub_buckets[sub_slot].sub_bucket_id = sub_id;
            g_asc_hud.sub_buckets[sub_slot].bucket_id = effective_main_bucket_id;
            string human_sub = ASC_HudHumanizeIdentifier((StringLen(sub_name) > 0) ? sub_name : sub_id);
            g_asc_hud.sub_buckets[sub_slot].name = (StringLen(human_sub) > 0 ? human_sub : "Unassigned");
            g_asc_hud.sub_buckets[sub_slot].source = state.classification.sub_bucket_source;
            g_asc_hud.sub_buckets[sub_slot].total = 0;
            g_asc_hud.sub_buckets[sub_slot].open_count = 0;
            g_asc_hud.sub_buckets[sub_slot].eligible_count = 0;
            g_asc_hud.sub_buckets[sub_slot].canonical_bucket_order = 2147483647;
            ASC_HudInsertSubBucketLookup(key, sub_slot);
           }

         g_asc_hud.sub_buckets[sub_slot].total++;
         if(state.state == ASC_L1_OPEN) g_asc_hud.sub_buckets[sub_slot].open_count++;
         if(state.classification.resolved) g_asc_hud.sub_buckets[sub_slot].eligible_count++;

         if(ASC_HudStateMatchesSelectedScope(state))
           {
            int old_symbol_count = ArraySize(g_asc_hud.symbol_indices);
            ArrayResize(g_asc_hud.symbol_indices, old_symbol_count + 1, 64);
            g_asc_hud.symbol_indices[old_symbol_count] = i;
           }
        }
     }

   if(g_asc_hud.rebuild_tracked_symbols > g_asc_hud.rebuild_assigned_symbols)
      g_asc_hud.rebuild_lost_symbols += (g_asc_hud.rebuild_tracked_symbols - g_asc_hud.rebuild_assigned_symbols);

   ASC_HudRebuildCanonicalAggregateMaps();
   ASC_HudApplyCanonicalBucketOrder();
   ASC_HudApplyCanonicalSubBucketOrder();
   ASC_HudApplyCanonicalBrowseNodeOrder();

   if(StringLen(g_asc_hud.selected_sub_bucket_key) > 0)
      ASC_HudReorderSelectedSymbolsByShortlistRank();

   if(StringLen(g_asc_hud.selected_symbol) <= 0 && ArraySize(g_asc_hud.symbol_indices) > 0)
     {
      ASC_Layer1SymbolState state;
      if(ASC_HudMaterializeSymbolState(g_asc_hud.symbol_indices[0], state))
         g_asc_hud.selected_symbol = state.symbol;
     }
  }

string ASC_HudPublicationPosture(const ASC_Layer1PassSummary &summary)
  {
   if(summary.is_degraded) return "Degraded";
   if(summary.is_partial) return "In Progress";
   return "Ready";
  }

string ASC_HudReadinessText()
  {
   if(!g_asc_hud.has_summary)
      return "Awaiting Confirmation";
   if(g_asc_hud.latest_summary.is_ready)
      return "Ready";
   if(g_asc_hud.latest_summary.warmup_ready)
      return "Warm";
   return "Partial";
  }

string ASC_HudQualityStatusText()
  {
   if(!g_asc_hud.has_summary)
      return "Awaiting Confirmation";
   if(g_asc_hud.latest_summary.is_degraded)
      return "Degraded";
   if(g_asc_hud.latest_summary.is_stale)
      return "Delayed";
   if(g_asc_hud.latest_summary.is_partial)
      return "In Progress";
   return "Fresh";
  }

string ASC_HudHealthReason()
  {
   if(!g_asc_hud.has_summary)
      return "Awaiting first scanner pass";
   if(g_asc_hud.latest_summary.is_degraded)
      return ASC_Layer1OperatorSummaryReason(g_asc_hud.latest_summary);
   if(g_asc_hud.latest_summary.is_stale)
      return ASC_Layer1OperatorSummaryReason(g_asc_hud.latest_summary);
   if(g_asc_hud.latest_summary.is_partial)
      return ASC_Layer1OperatorSummaryReason(g_asc_hud.latest_summary);
   return "Scanner checks are fresh.";
  }

string ASC_HudSymbolPosture(const ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   if(state.is_degraded) return "Degraded";
   if(state.is_stale) return "Delayed";
   if(state.observed_at_utc <= 0 || now_utc <= 0) return "Unknown";

   int age = (int)(now_utc - state.observed_at_utc);
   if(age < 0) age = 0;
   if(age <= g_asc_trader_controls.l1_tick_freshness_sec) return "Fresh";
   if(age <= g_asc_trader_controls.l1_tick_freshness_sec * 4) return "Aging";
  return "Delayed";
  }

string ASC_HudListFreshnessState(const bool is_stale,const bool is_degraded)
  {
   if(is_stale || is_degraded)
      return "Delayed";
   return "Good";
  }

string ASC_HudSymbolFreshnessState(const ASC_Layer1SymbolState &state)
  {
   if(state.is_stale || state.is_degraded)
      return "Delayed";
   return "Good";
  }

string ASC_HudPrimaryOpenClosedState(const int state)
  {
   if(state == ASC_L1_OPEN)
      return "Open";
   return "Closed";
  }

string ASC_HudAgeText(const datetime observed_at_utc,const datetime now_utc)
  {
   if(observed_at_utc <= 0 || now_utc <= 0 || now_utc < observed_at_utc)
      return "Unknown";

   int age = (int)(now_utc - observed_at_utc);
   if(age < 60) return IntegerToString(age) + "s";
   if(age < 3600) return IntegerToString(age / 60) + "m";
   return IntegerToString(age / 3600) + "h";
  }

string ASC_HudDateTimeText(const datetime value_utc)
  {
   if(value_utc <= 0)
      return "Not yet observed";
   return TimeToString(value_utc, TIME_DATE | TIME_SECONDS);
  }

string ASC_HudSymbolEligibilityText(const ASC_Layer1SymbolState &state)
  {
   if(state.state == ASC_L1_OPEN && !state.is_stale && !state.is_degraded)
      return "Yes";
   return "No";
  }

string ASC_HudSymbolStatusNote(const ASC_Layer1SymbolState &state)
  {
   string note = ASC_L1ReasonToOperatorText(state.reason);
   if(StringLen(note) <= 0)
      note = "Status note pending.";
   return note;
  }

string ASC_HudSymbolShortlistText(const ASC_Layer1SymbolState &state)
  {
   if(state.state == ASC_L1_OPEN && !state.is_stale && !state.is_degraded)
      return "Priority";
   if(state.state == ASC_L1_OPEN)
      return "Watch";
   return "n/a";
  }

string ASC_HudSymbolNextCheckPosture(const ASC_Layer1SymbolState &state)
  {
   string due_state = ASC_L1DueReasonToOperatorText(state.next_due_reason);
   if(StringLen(due_state) <= 0)
      due_state = "Pending";
   return ASC_L1DueClassToText(state.due_class) + " / " + due_state;
  }

string ASC_HudDeepAnalysisPostureTag(const ASC_Layer1SymbolState &state,const bool has_live_packet)
  {
   if(!state.classification.resolved)
      return "Override (classification needs review)";
   if(ASC_DeepEnabledTimeframeCount() <= 0)
      return "Override (safe timeframe defaults)";
   if(state.state != ASC_L1_OPEN)
      return "Override (closed/dormant context)";
   if(!has_live_packet)
      return "Override (historical-only support)";
   if(state.is_degraded)
      return "Override (degraded support)";
   if(state.is_stale)
      return "Override (stale support)";
   return "Ready";
  }

string ASC_HudDeepAnalysisCompactSummary(const ASC_Layer1SymbolState &state,const bool has_live_packet)
  {
   string posture = ASC_HudDeepAnalysisPostureTag(state, has_live_packet);
   if(posture == "Ready")
      return "Explicit override accepted with live support.";
   if(posture == "Override (classification needs review)")
      return "Explicit override accepted with classification that still needs review.";
   if(posture == "Override (safe timeframe defaults)")
      return "Explicit override accepted; runtime will use safe default timeframes.";
   if(posture == "Override (stale support)")
      return "Explicit override run is available with stale packet support.";
   if(posture == "Override (degraded support)")
      return "Explicit override run is available with degraded packet support.";
   if(posture == "Override (historical-only support)")
      return "Explicit override run is available with historical-only support.";
   if(posture == "Override (closed/dormant context)")
      return "Explicit override run is available in closed or dormant market context.";
   if(posture == "Controls off")
      return "Full Analysis controls are turned off for every enabled timeframe.";
  return "This symbol is not currently eligible for Full Analysis.";
  }

string ASC_HudDeepRelationshipStatus(const ASC_Layer1SymbolState &state,
                                     const bool has_live_packet,
                                     const bool shortlist_found,
                                     const int shortlist_rank,
                                     const bool pair_aligned,
                                     const bool pair_known)
  {
   string posture = ASC_HudDeepAnalysisPostureTag(state, has_live_packet);
   if(posture != "Ready")
      return "Full Analysis relationship: " + posture;
   if(!shortlist_found || shortlist_rank <= 0)
      return "Full Analysis relationship: explicit override is active outside shortlist.";
   if(shortlist_rank > 3)
      return StringFormat("Full Analysis relationship: explicit override is active at shortlist rank %d.", shortlist_rank);
   if(pair_known && !pair_aligned)
      return "Full Analysis relationship: explicit override accepted, but selected symbol readback must align before trust.";
   return StringFormat("Full Analysis relationship: explicit override accepted for shortlist rank %d.", shortlist_rank);
  }

string ASC_HudDeepTriggerStatusText(const string raw_status)
  {
   string status = raw_status;
   StringToLower(status);
   if(status == "queued")
      return "trigger queued";
   if(status == "running")
      return "trigger running";
   if(status == "deep_pair_succeeded" || status == "succeeded")
      return "last trigger succeeded";
   if(status == "deep_pair_continuity" || status == "continuity")
      return "last trigger retained prior lawful publish";
   if(status == "deep_pair_failed_write")
      return "last trigger failed: pair write failed";
   if(status == "deep_pair_failed_partial_publish")
      return "last trigger failed: partial pair publication";
   if(status == "deep_pair_failed_pair_mismatch")
      return "last trigger failed: pair readback mismatch";
   if(status == "deep_pair_failed_deep_truth")
      return "last trigger failed: Full Analysis readback mismatch";
   if(status == "deep_pair_failed_symbol_alignment")
      return "last trigger failed: frozen request symbol alignment failed";
   if(status == "deep_pair_failed_ownership_conflict")
      return "last trigger failed: ownership conflict";
   if(status == "deep_pair_failed_runtime_path")
      return "last trigger failed: runtime path unavailable";
   if(status == "deep_pair_failed_build")
      return "last trigger failed: Full Analysis build failed";
   return "idle";
  }

string ASC_HudCurrentFocusOutcomeText(const string raw_status)
  {
   string status = raw_status;
   StringToLower(status);
   if(status == "view_queued")
      return "selected symbol sync queued";
   if(status == "view_deferred")
      return "selected symbol sync deferred";
   if(status == "view_failed_write")
      return "selected symbol sync retry deferred after write failure";
   if(status == "view_verified_current")
      return "selected symbol package already current and verified";
   if(status == "view_succeeded")
      return "selected symbol package published and verified";
   if(status == "view_continuity")
      return "selected symbol continuity retained and verified";
   if(status == "state_aligned")
      return "runtime state aligned from artifact readback";
   if(status == "not_selected")
      return "no selected symbol is active for sync";
   if(status == "deep_pair_succeeded")
      return "Full Analysis package published and verified";
   if(status == "deep_pair_continuity")
      return "Full Analysis continuity retained and verified";
   if(status == "deep_pair_failed_write")
      return "Full Analysis package write failed";
   if(status == "deep_pair_failed_partial_publish")
      return "Full Analysis partial publish failure";
   if(status == "deep_pair_failed_pair_mismatch")
      return "Full Analysis package mismatch";
   if(status == "deep_pair_failed_deep_truth")
      return "Full Analysis readback mismatch";
   if(status == "deep_pair_failed_symbol_alignment")
      return "Full Analysis symbol alignment failure";
   if(status == "deep_pair_failed_ownership_conflict")
      return "Full Analysis ownership conflict";
   if(status == "deep_pair_failed_runtime_path")
      return "Full Analysis runtime path failure";
   if(status == "deep_pair_failed_compose")
      return "Full Analysis compose failure";
   if(status == "deep_pair_failed_pair_path")
      return "Full Analysis package path failure";
   if(status == "deep_pair_failed_build")
      return "Full Analysis build failure";
   if(StringLen(status) <= 0 || status == "idle")
      return "Not yet reported";
   return ASC_ArtifactHumanizeLabel(raw_status);
  }

string ASC_HudDeepLifecycleState(const ASC_Layer1SymbolState &selected,
                                 const string trigger_status,
                                 const bool trigger_queued,
                                 const bool focus_matches,
                                 const bool focus_has_completed_block,
                                 const string focus_deep_posture,
                                 const bool deep_view_opened)
  {
   string status = trigger_status;
   StringToLower(status);

   if(trigger_queued || status == "queued")
      return "queued";
   if(status == "running")
      return "running";
   if(status == "deep_pair_continuity" || status == "continuity")
      return (focus_matches && focus_has_completed_block) ? "continuity retained" : "continuity pending alignment";
   if(status == "deep_pair_failed_build")
      return "build failed";
   if(status == "deep_pair_failed_partial_publish")
      return "partial publish failure";
   if(status == "deep_pair_failed_pair_mismatch")
      return "pair mismatch";
   if(status == "deep_pair_failed_deep_truth")
      return "Full Analysis truth missing";
   if(status == "deep_pair_failed_symbol_alignment")
      return "symbol alignment failed";
   if(status == "deep_pair_failed_ownership_conflict")
      return "ownership conflict";
   if(status == "deep_pair_failed_runtime_path")
      return "runtime path failed";
   if(status == "deep_pair_failed_compose")
      return "compose failed";
   if(status == "deep_pair_failed_pair_path")
      return "pair path failed";
   if(StringFind(status, "deep_pair_failed_") == 0)
      return "failed";
   if((status == "deep_pair_succeeded" || status == "succeeded") && focus_matches && focus_has_completed_block)
     {
      string posture = focus_deep_posture;
      StringToLower(posture);
      if(StringFind(posture, "degraded") >= 0)
         return "degraded";
      if(StringFind(posture, "delayed") >= 0 || StringFind(posture, "stale") >= 0)
         return "degraded";
      return "succeeded";
     }
   if((status == "deep_pair_succeeded" || status == "succeeded" || status == "deep_pair_continuity" || status == "continuity") && (!focus_matches || !focus_has_completed_block))
      return "publish pending alignment";
   if(status == "idle")
      return deep_view_opened ? "view opened (no trigger armed)" : "idle";
   if(selected.is_degraded || selected.is_stale)
      return "degraded";
   return deep_view_opened ? "view opened (no trigger armed)" : "idle";
  }

string ASC_HudDeepReadinessSummary(const string current_focus_text)
  {
   int canonical_subsection_total = 8; // deep_analysis_overview + cross_timeframe_summary + timeframe_analytic_summary + decision_support + ohlc_by_enabled_timeframe + recent_tick_activity + live_spread_rollover + preservation_state
   if(StringLen(current_focus_text) <= 0)
      return "no readback";

   if(ASC_DossierDeepSectionHasCompletedTruth(current_focus_text))
      return StringFormat("subsections ready %d/%d", canonical_subsection_total, canonical_subsection_total);

   return StringFormat("subsections ready 0/%d | readback is placeholder, stale partial, or non-completed",
                       canonical_subsection_total);
  }

string ASC_HudTimeframeRowValue(const string row,const string key)
  {
   if(StringLen(row) <= 0 || StringLen(key) <= 0)
      return "";
   string token = key + "=";
   int start = StringFind(row, token);
   if(start < 0)
      return "";
   start += StringLen(token);
   int stop = StringFind(row, " | ", start);
   if(stop < 0)
      stop = StringLen(row);
  return StringSubstr(row, start, stop - start);
  }

bool ASC_HudExtractDeepTimeframeSection(const string current_focus_text,string &section)
  {
   uint parse_started_ms = GetTickCount();
   section = "";
   bool extracted = false;
   if(StringLen(current_focus_text) > 0)
     {
      string text = current_focus_text;
      StringReplace(text, "\r", "");
      string start_token = "\ntimeframe_analytic_summary\n----------------------------------------\n";
      int start = StringFind(text, start_token);
      if(start >= 0)
        {
         start += StringLen(start_token);

         int stop = StringFind(text, "\ndecision_support\n", start);
         if(stop < 0)
            stop = StringFind(text, "\ntimeframe_settings\n", start);
         if(stop < 0)
            stop = StringLen(text);
         if(stop > start)
           {
            section = StringSubstr(text, start, stop - start);
            extracted = (StringLen(section) > 0);
           }
        }
     }

   uint parse_elapsed_ms = GetTickCount() - parse_started_ms;
   g_asc_hud.hud_deep_parse_elapsed_last_ms = parse_elapsed_ms;
   if(parse_elapsed_ms > g_asc_hud.hud_deep_parse_elapsed_max_ms)
      g_asc_hud.hud_deep_parse_elapsed_max_ms = parse_elapsed_ms;
   return extracted;
  }

void ASC_HudBuildDeepSectionViewModel(const string current_focus_text,
                                      string &timeframe_preview,
                                      string &bias_summary,
                                      string &readiness_summary,
                                      string &rows[],
                                      int &row_count)
  {
   uint parse_started_ms = GetTickCount();
   g_asc_hud.hud_deep_parse_attempt_count++;
   timeframe_preview = "timeframe summary preview unavailable";
   bias_summary = "Bias S/M/H: pending";
   readiness_summary = "subsections ready 0/8";
   row_count = 0;
   ArrayResize(rows, 9);
   for(int reset_i = 0; reset_i < 9; reset_i++)
      rows[reset_i] = "";

   if(StringLen(current_focus_text) <= 0)
     {
      uint parse_elapsed_ms = GetTickCount() - parse_started_ms;
      g_asc_hud.hud_deep_parse_elapsed_last_ms = parse_elapsed_ms;
      if(parse_elapsed_ms > g_asc_hud.hud_deep_parse_elapsed_max_ms)
         g_asc_hud.hud_deep_parse_elapsed_max_ms = parse_elapsed_ms;
      return;
     }

   readiness_summary = ASC_HudDeepReadinessSummary(current_focus_text);
   string section = "";
   if(!ASC_HudExtractDeepTimeframeSection(current_focus_text, section))
     {
      uint parse_elapsed_ms = GetTickCount() - parse_started_ms;
      g_asc_hud.hud_deep_parse_elapsed_last_ms = parse_elapsed_ms;
      if(parse_elapsed_ms > g_asc_hud.hud_deep_parse_elapsed_max_ms)
         g_asc_hud.hud_deep_parse_elapsed_max_ms = parse_elapsed_ms;
      return;
     }

   string preview = "";
   string drift_labels[3];
   int drift_count = 0;
   int consumed_preview = 0;
   int cursor = 0;
   while(cursor < StringLen(section))
     {
      int line_end = StringFind(section, "\n", cursor);
      if(line_end < 0)
         line_end = StringLen(section);
      string line = StringSubstr(section, cursor, line_end - cursor);
      cursor = line_end + 1;
      if(StringLen(line) <= 0 || StringFind(line, " | ") <= 0)
         continue;

      int label_stop = StringFind(line, " | ");
      string tf = StringSubstr(line, 0, label_stop);

      if(consumed_preview < 2)
        {
         string atr = ASC_HudTimeframeRowValue(line, "ATR");
         string atr_pct = ASC_HudTimeframeRowValue(line, "ATR%%");
         string regime_preview = ASC_HudTimeframeRowValue(line, "Regime");
         string friction = ASC_HudTimeframeRowValue(line, "Friction Posture");
         string liquidity = ASC_HudTimeframeRowValue(line, "Liquidity Posture");
         string spread = ASC_HudTimeframeRowValue(line, "Spread Posture");
         string readiness = ASC_HudTimeframeRowValue(line, "Freshness/Readiness Note");
         string compact = tf
                          + " ATR=" + ASC_TextOrUnavailable(atr)
                          + " ATR%=" + ASC_TextOrUnavailable(atr_pct)
                          + " Regime=" + ASC_TextOrUnavailable(regime_preview)
                          + " Friction=" + ASC_TextOrUnavailable(friction)
                          + " Liquidity=" + ASC_TextOrUnavailable(liquidity)
                          + " Spread=" + ASC_TextOrUnavailable(spread)
                          + " Ready=" + ASC_TextOrUnavailable(readiness);
         if(StringLen(preview) > 0)
            preview += " || ";
         preview += compact;
         consumed_preview++;
        }

      if(drift_count < 3)
        {
         string drift = ASC_HudTimeframeRowValueFirst(line, "Drift Posture", "Drift");
         drift_labels[drift_count] = ASC_TextOrUnavailable(drift);
         drift_count++;
        }

      if(row_count < 9)
        {
         string drift = ASC_HudTimeframeRowValueFirst(line, "Drift Posture", "Drift");
         string momentum = ASC_HudTimeframeRowValueFirst(line, "Momentum Posture", "Momentum");
         string regime = ASC_HudTimeframeRowValueFirst(line, "Regime/Volatility Posture", "Regime", "Volatility Posture");
         string range_pos = ASC_HudTimeframeRowValueFirst(line, "Position in Range", "Range Position");
         string dist_hi = ASC_HudTimeframeRowValueFirst(line, "Distance to Recent High", "Distance to High");
         string dist_lo = ASC_HudTimeframeRowValueFirst(line, "Distance to Recent Low", "Distance to Low");
         string participation = ASC_HudTimeframeRowValueFirst(line, "Participation Posture", "Participation");
         rows[row_count] = tf
                           + " | Drift " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(drift), "pending", 20)
                           + " | Mom " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(momentum), "pending", 20)
                           + " | Regime " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(regime), "pending", 20)
                           + " | Range " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(range_pos), "pending", 20)
                           + " | High/Low " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(dist_hi), "pending", 16) + "/" + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(dist_lo), "pending", 16)
                           + " | Part " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(participation), "pending", 20);
         row_count++;
        }
     }

   if(StringLen(preview) > 0)
      timeframe_preview = "timeframe summary preview: " + preview;

   if(drift_count > 0)
     {
      string short_bias = drift_labels[0];
      string mid_bias = (drift_count > 1 ? drift_labels[1] : drift_labels[0]);
      string high_bias = (drift_count > 2 ? drift_labels[2] : mid_bias);
      bias_summary = "Bias S/M/H: " + short_bias + " / " + mid_bias + " / " + high_bias;
     }

   uint parse_elapsed_ms = GetTickCount() - parse_started_ms;
   g_asc_hud.hud_deep_parse_elapsed_last_ms = parse_elapsed_ms;
   if(parse_elapsed_ms > g_asc_hud.hud_deep_parse_elapsed_max_ms)
      g_asc_hud.hud_deep_parse_elapsed_max_ms = parse_elapsed_ms;
  }

string ASC_HudDeepTimeframePreview(const string current_focus_text)
  {
   string preview = "";
   string bias = "";
   string readiness = "";
   string rows[];
   int row_count = 0;
   ASC_HudBuildDeepSectionViewModel(current_focus_text, preview, bias, readiness, rows, row_count);
   return preview;
  }

string ASC_HudTimeframeRowValueFirst(const string row,const string key_a,const string key_b="",const string key_c="")
  {
   string value = ASC_HudTimeframeRowValue(row, key_a);
   if(StringLen(value) > 0)
      return value;
   if(StringLen(key_b) > 0)
     {
      value = ASC_HudTimeframeRowValue(row, key_b);
      if(StringLen(value) > 0)
         return value;
     }
   if(StringLen(key_c) > 0)
     {
      value = ASC_HudTimeframeRowValue(row, key_c);
      if(StringLen(value) > 0)
         return value;
     }
   return "";
  }

int ASC_HudBuildDeepTimeframeDecisionRows(const string current_focus_text,string &rows[])
  {
   string preview = "";
   string bias = "";
   string readiness = "";
   int row_count = 0;
   ASC_HudBuildDeepSectionViewModel(current_focus_text, preview, bias, readiness, rows, row_count);
   return row_count;
  }

string ASC_HudDeepBiasSummary(const string current_focus_text)
  {
   string preview = "";
   string bias = "";
   string readiness = "";
   string rows[];
   int row_count = 0;
   ASC_HudBuildDeepSectionViewModel(current_focus_text, preview, bias, readiness, rows, row_count);
   return bias;
  }


void ASC_HudEnsureSelectedDefaults()
  {
   string previous_symbol = g_asc_hud.selected_symbol;
   if(StringLen(g_asc_hud.selected_bucket_id) <= 0)
      g_asc_hud.selected_bucket_id = "unknown";

   bool bucket_exists = false;
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
      if(g_asc_hud.buckets[i].id == g_asc_hud.selected_bucket_id && ASC_HudBucketAllowedByControls(g_asc_hud.buckets[i].id))
         bucket_exists = true;
   if(!bucket_exists)
     {
      g_asc_hud.selected_bucket_id = "unknown";
      bool fallback_assigned = false;
      for(int b = 0; b < ArraySize(g_asc_hud.buckets); b++)
        {
         if(g_asc_hud.buckets[b].total <= 0)
            continue;
         if(!ASC_HudBucketAllowedByControls(g_asc_hud.buckets[b].id))
            continue;
         g_asc_hud.selected_bucket_id = g_asc_hud.buckets[b].id;
         fallback_assigned = true;
         break;
        }
      if(!fallback_assigned)
        {
         for(int b = 0; b < ArraySize(g_asc_hud.buckets); b++)
           {
            if(!ASC_HudBucketAllowedByControls(g_asc_hud.buckets[b].id))
               continue;
            g_asc_hud.selected_bucket_id = g_asc_hud.buckets[b].id;
            break;
           }
        }
     }

   if(!ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
     {
      g_asc_hud.selected_browse_parent_key = "";
      g_asc_hud.selected_browse_node_key = "";
     }
   else
     {
      string root_parent_key = "B|" + g_asc_hud.selected_bucket_id;
      if(StringLen(g_asc_hud.selected_browse_parent_key) <= 0
         || !ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_browse_parent_key, g_asc_hud.selected_bucket_id)
         || !ASC_HudBrowseNodeHasAncestor(g_asc_hud.selected_browse_parent_key, root_parent_key))
         g_asc_hud.selected_browse_parent_key = root_parent_key;

      if(StringLen(g_asc_hud.selected_browse_node_key) > 0
         && !ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_browse_node_key,
                                                        g_asc_hud.selected_bucket_id,
                                                        g_asc_hud.selected_browse_parent_key))
         g_asc_hud.selected_browse_node_key = "";
     }

   bool sub_exists = false;
   if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
     {
      sub_exists = (StringLen(g_asc_hud.selected_sub_bucket_key) > 0
                    && ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_sub_bucket_key,
                                                                  g_asc_hud.selected_bucket_id,
                                                                  g_asc_hud.selected_browse_parent_key)
                    && !ASC_HudBrowseNodeHasChildren(g_asc_hud.selected_sub_bucket_key));
      if(!sub_exists)
         g_asc_hud.selected_sub_bucket_key = "";

      if(StringLen(g_asc_hud.selected_sub_bucket_key) <= 0
         && StringLen(g_asc_hud.selected_browse_node_key) > 0
         && ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_browse_node_key,
                                                       g_asc_hud.selected_bucket_id,
                                                       g_asc_hud.selected_browse_parent_key)
         && !ASC_HudBrowseNodeHasChildren(g_asc_hud.selected_browse_node_key))
        {
         g_asc_hud.selected_sub_bucket_key = g_asc_hud.selected_browse_node_key;
         sub_exists = true;
        }
     }
   else
     {
      for(int j = 0; j < ArraySize(g_asc_hud.sub_buckets); j++)
         if(g_asc_hud.sub_buckets[j].key == g_asc_hud.selected_sub_bucket_key)
            sub_exists = true;
     }

   if(!sub_exists)
     {
      g_asc_hud.selected_sub_bucket_key = "";
      g_asc_hud.selected_browse_node_key = "";
      if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
        {
         g_asc_hud.selected_browse_parent_key = "B|" + g_asc_hud.selected_bucket_id;
        }
      else
        {
         g_asc_hud.selected_browse_parent_key = "";
         for(int k = 0; k < ArraySize(g_asc_hud.sub_buckets); k++)
           {
            if(g_asc_hud.sub_buckets[k].bucket_id == g_asc_hud.selected_bucket_id)
              {
               g_asc_hud.selected_sub_bucket_key = g_asc_hud.sub_buckets[k].key;
               break;
              }
           }
        }
     }
   else if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id) && StringLen(g_asc_hud.selected_browse_parent_key) <= 0)
      g_asc_hud.selected_browse_parent_key = "B|" + g_asc_hud.selected_bucket_id;

   if(StringLen(g_asc_hud.selected_symbol) <= 0 && ArraySize(g_asc_hud.symbol_indices) > 0)
     {
      ASC_Layer1SymbolState state;
      if(ASC_HudMaterializeSymbolState(g_asc_hud.symbol_indices[0], state))
         g_asc_hud.selected_symbol = state.symbol;
     }
   if(g_asc_hud.selected_symbol != previous_symbol)
      ASC_HudInvalidateSelectedSymbolCache();
  }

void ASC_HudRebuildSelectedSymbolList()
  {
   string selected_key = g_asc_hud.selected_sub_bucket_key;
   if(StringLen(selected_key) <= 0)
     {
      ArrayResize(g_asc_hud.symbol_indices, 0);
      g_asc_hud.selected_symbol_list_key = "";
      g_asc_hud.selected_symbol_list_filter_signature = "";
      g_asc_hud.selected_symbol_list_revision = 0;
      g_asc_hud.selected_symbol_list_shortlist_revision = 0;
      return;
     }

   ulong structural_revision = ASC_Layer1StructuralRevision();
   string filter_signature = ASC_HudBrowseFilterSignature();
   if(g_asc_hud.selected_symbol_list_revision == structural_revision
      && g_asc_hud.selected_symbol_list_key == selected_key
      && g_asc_hud.selected_symbol_list_filter_signature == filter_signature
      && g_asc_hud.selected_symbol_list_shortlist_revision == g_asc_hud_shortlist_lookup_revision)
      return;

   ArrayResize(g_asc_hud.symbol_indices, 0);
   int cache_total = ASC_Layer1CachedSymbolCount();
   if(cache_total > 0)
      ASC_HudEnsureIntArrayCapacity(g_asc_hud.symbol_indices, 0, MathMax(64, cache_total / 4));
   for(int i = 0; i < cache_total; i++)
     {
      ASC_Layer1SymbolState state;
      if(!ASC_HudMaterializeSymbolState(i, state))
         continue;

      string main_bucket_id = ASC_HudEffectiveMainBucketId(state);
      string key = ASC_HudBrowseLeafKeyForState(state, main_bucket_id);
      if(ASC_HudIsStockBucketId(main_bucket_id))
        {
         ASC_HudBrowseNode leaf;
         if(ASC_HudTryGetBrowseNode(key, leaf) && !ASC_HudBrowseNodeAllowedByControls(leaf))
            continue;
        }
      if(!ASC_HudStateMatchesSelectedScope(state))
         continue;

      int old_count = ArraySize(g_asc_hud.symbol_indices);
      ASC_HudEnsureIntArrayCapacity(g_asc_hud.symbol_indices, old_count + 1, 64);
      g_asc_hud.symbol_indices[old_count] = i;
     }

   ASC_HudReorderSelectedSymbolsByShortlistRank();
   g_asc_hud.selected_symbol_list_key = selected_key;
   g_asc_hud.selected_symbol_list_filter_signature = filter_signature;
   g_asc_hud.selected_symbol_list_revision = structural_revision;
   g_asc_hud.selected_symbol_list_shortlist_revision = g_asc_hud_shortlist_lookup_revision;
  }

int ASC_HudFindLayer1IndexForShortlistEntry(const ASC_ShortlistSymbolSummary &entry)
  {
   ASC_HudEnsureLayer1LookupCache();
   int layer1_index = ASC_HudFindLookupIndex(g_asc_hud_layer1_lookup, ASC_HudNormalizeLookupKey(entry.symbol));
   if(layer1_index >= 0)
      return layer1_index;
   layer1_index = ASC_HudFindLookupIndex(g_asc_hud_layer1_lookup, ASC_HudNormalizeLookupKey(entry.state.symbol));
   if(layer1_index >= 0)
      return layer1_index;
   layer1_index = ASC_HudFindLookupIndex(g_asc_hud_layer1_lookup, ASC_HudNormalizeLookupKey(entry.state.identity.normalized_symbol));
   if(layer1_index >= 0)
      return layer1_index;
   layer1_index = ASC_HudFindLookupIndex(g_asc_hud_layer1_lookup, ASC_HudNormalizeLookupKey(entry.state.classification.canonical_symbol));
   if(layer1_index >= 0)
      return layer1_index;
   layer1_index = ASC_HudFindLookupIndex(g_asc_hud_layer1_lookup, ASC_HudNormalizeLookupKey(entry.state.identity.canonical_symbol));
   if(layer1_index >= 0)
      return layer1_index;
   return -1;
  }


string ASC_HudLeaderRowVisibilityStateLabel(const ASC_HudLeaderRowVisibilityState state)
  {
   switch(state)
     {
      case ASC_HUD_LEADER_ROW_PACKET_READY_VISIBLE: return "bucket_rank_carried_packet_ready";
      case ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE: return "bucket_rank_carried_packet_warmup";
      case ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE: return "bucket_rank_carried_retained_last_good";
      case ASC_HUD_LEADER_ROW_HIDDEN_BY_RULE: return "bucket_rank_hidden_by_rule";
      case ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE: return "bucket_rank_carried_snapshot_fallback";
     }
   return "not_admitted";
  }

ASC_HudLeaderRowVisibilityState ASC_HudLeaderRowVisibilityStateForEntry(const ASC_ShortlistSymbolSummary &entry,int &layer1_index_out)
  {
   layer1_index_out = -1;
   if(!ASC_ShortlistHasLawfulBucketMembership(entry))
      return ASC_HUD_LEADER_ROW_NOT_ADMITTED;

   string bucket_id = ASC_HudEffectiveMainBucketId(entry.state);
   if(bucket_id != g_asc_hud.selected_bucket_id)
      return ASC_HUD_LEADER_ROW_NOT_ADMITTED;

   if(!ASC_ConsumerAllowsOrdinaryL34(entry.state))
      return ASC_HUD_LEADER_ROW_HIDDEN_BY_RULE;

   layer1_index_out = ASC_HudFindLayer1IndexForShortlistEntry(entry);

   bool packet_ready = (entry.has_packet
                        && entry.packet.hydration_family == ASC_L2_HYDRATION_READY);
   bool continuity_backed = (entry.has_packet
                             && (entry.packet.continuity_backed || entry.packet.has_last_good));
   bool packet_warmup = (!entry.has_packet
                         || entry.packet.hydration_gate_code == "blocked_by_warmup");

   if(packet_ready)
      return ASC_HUD_LEADER_ROW_PACKET_READY_VISIBLE;
   if(continuity_backed)
      return ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE;
   if(packet_warmup)
      return ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE;
   if(layer1_index_out < 0)
      return ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE;

   return ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE;
  }

bool ASC_HudLeaderRowStateIsVisible(const ASC_HudLeaderRowVisibilityState state)
  {
   return (state == ASC_HUD_LEADER_ROW_PACKET_READY_VISIBLE
           || state == ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE
           || state == ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE
           || state == ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE);
  }

void ASC_HudResolveLeaderDisplayState(const ASC_ShortlistSymbolSummary &entry,
                                      ASC_HudLeaderRowVisibilityState &visibility_state,
                                      ASC_Layer1SymbolState &display_state,
                                      bool &using_retained_state,
                                      bool &using_shortlist_fallback,
                                      int &layer1_index_out)
  {
   visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(entry, layer1_index_out);
   display_state = entry.state;
   using_retained_state = (visibility_state == ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE);
   using_shortlist_fallback = false;

   if(layer1_index_out >= 0 && ASC_HudMaterializeSymbolState(layer1_index_out, display_state))
      return;

   using_shortlist_fallback = true;
  }

void ASC_HudResetLeaderTruthAudit(ASC_HudLeaderTruthAudit &audit)
  {
   audit.shortlist_source = "";
   audit.shortlist_revision = 0;
   audit.shortlist_pass_utc = 0;
   audit.shortlist_signature_revision = 0;
   audit.shortlist_signature_pass_utc = 0;
   audit.bucket_admitted_count = 0;
   audit.packet_ready_count = 0;
   audit.packet_warmup_count = 0;
   audit.hud_visible_count = 0;
   audit.retained_last_good_count = 0;
   audit.hidden_by_rule_count = 0;
   audit.unavailable_market_watch_count = 0;
   audit.anchor_unavailable_count = 0;
   audit.snapshot_mismatch_count = 0;
   audit.row_l2_max_revision = 0;
   audit.row_l3_eval_latest_utc = 0;
   audit.empty_state_cause = "not-evaluated";
   audit.trace_summary = "";
  }

void ASC_HudBuildLeaderTruthAudit(ASC_HudLeaderTruthAudit &audit)
  {
   ASC_HudResetLeaderTruthAudit(audit);
   audit.shortlist_source = g_asc_hud.last_shortlist_source;
   audit.shortlist_revision = g_asc_hud.last_shortlist_revision;
   audit.shortlist_pass_utc = g_asc_hud.last_shortlist_pass_utc;
   audit.shortlist_signature_revision = g_asc_hud.last_shortlist_signature_revision;
   audit.shortlist_signature_pass_utc = g_asc_hud.last_shortlist_signature_pass_utc;

   if(StringLen(g_asc_hud.selected_bucket_id) <= 0)
     {
      audit.empty_state_cause = "no_bucket_selected";
      audit.trace_summary = "bucket=none";
      return;
     }

   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      int layer1_index = -1;
      ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(g_asc_hud_shortlist_rows[i], layer1_index);
      if(visibility_state == ASC_HUD_LEADER_ROW_NOT_ADMITTED)
         continue;

      audit.bucket_admitted_count++;

      if(g_asc_hud_shortlist_rows[i].has_packet && g_asc_hud_shortlist_rows[i].packet.revision > audit.row_l2_max_revision)
         audit.row_l2_max_revision = g_asc_hud_shortlist_rows[i].packet.revision;
      if(g_asc_hud_shortlist_rows[i].filter.evaluated_at_utc > audit.row_l3_eval_latest_utc)
         audit.row_l3_eval_latest_utc = g_asc_hud_shortlist_rows[i].filter.evaluated_at_utc;

      if(!g_asc_hud_shortlist_rows[i].has_packet || !g_asc_hud_shortlist_rows[i].packet.valid_bid || !g_asc_hud_shortlist_rows[i].packet.valid_ask || !g_asc_hud_shortlist_rows[i].packet.valid_spread)
         audit.unavailable_market_watch_count++;
      if(!g_asc_hud_shortlist_rows[i].correlation_summary.anchor_packet_ready)
         audit.anchor_unavailable_count++;
      if(g_asc_hud_shortlist_rows[i].has_packet && (g_asc_hud_shortlist_rows[i].packet.continuity_backed || g_asc_hud_shortlist_rows[i].packet.has_last_good))
         audit.retained_last_good_count++;

      if(visibility_state == ASC_HUD_LEADER_ROW_HIDDEN_BY_RULE)
         audit.hidden_by_rule_count++;
      if(visibility_state == ASC_HUD_LEADER_ROW_PACKET_READY_VISIBLE)
         audit.packet_ready_count++;
      else if(visibility_state == ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE)
         audit.packet_warmup_count++;
      if(visibility_state == ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE)
         audit.snapshot_mismatch_count++;
      if(ASC_HudLeaderRowStateIsVisible(visibility_state))
         audit.hud_visible_count++;
     }

   bool delayed = (g_asc_hud.has_summary && (g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded));
   if(audit.bucket_admitted_count <= 0)
      audit.empty_state_cause = "no_admitted_rows";
   else if(audit.hud_visible_count <= 0 && audit.snapshot_mismatch_count > 0)
      audit.empty_state_cause = "snapshot_mismatch";
   else if(audit.hud_visible_count <= 0 && audit.hidden_by_rule_count > 0)
      audit.empty_state_cause = "admitted_but_hidden_by_rule";
   else if(audit.hud_visible_count <= 0 && audit.packet_warmup_count > 0)
      audit.empty_state_cause = "admitted_but_packet_warmup";
   else if(audit.hud_visible_count <= 0 && audit.retained_last_good_count > 0)
      audit.empty_state_cause = "last_good_available_not_visible";
   else if(delayed)
      audit.empty_state_cause = "stale_publish";
   else
      audit.empty_state_cause = "healthy_or_nonempty";

   string audit_source = (StringLen(audit.shortlist_source) > 0 ? audit.shortlist_source : "none");
   string audit_trace = "bucket=" + g_asc_hud.selected_bucket_id
                        + " source=" + audit_source
                        + " shortlist_rev=" + IntegerToString((long)audit.shortlist_revision)
                        + " shortlist_pass=" + TimeToString(audit.shortlist_pass_utc, TIME_DATE | TIME_SECONDS)
                        + " shortlist_sig_rev=" + IntegerToString((long)audit.shortlist_signature_revision);
   audit_trace += " admitted=" + IntegerToString(audit.bucket_admitted_count)
                  + " packet_ready=" + IntegerToString(audit.packet_ready_count)
                  + " packet_warmup=" + IntegerToString(audit.packet_warmup_count)
                  + " hud_visible=" + IntegerToString(audit.hud_visible_count);
   audit_trace += " retained=" + IntegerToString(audit.retained_last_good_count)
                  + " hidden=" + IntegerToString(audit.hidden_by_rule_count)
                  + " unavailable=" + IntegerToString(audit.unavailable_market_watch_count)
                  + " anchor_unavailable=" + IntegerToString(audit.anchor_unavailable_count)
                  + " snapshot_mismatch=" + IntegerToString(audit.snapshot_mismatch_count);
   audit_trace += " row_l2_max=" + IntegerToString((long)audit.row_l2_max_revision)
                  + " row_l3_eval_latest=" + TimeToString(audit.row_l3_eval_latest_utc, TIME_DATE | TIME_SECONDS)
                  + " empty_cause=" + audit.empty_state_cause;
   audit.trace_summary = audit_trace;
  }

string ASC_HudLeaderTruthAuditCompact()
  {
   ASC_HudBuildLeaderTruthAudit(g_asc_hud.leader_truth_audit);
   return g_asc_hud.leader_truth_audit.trace_summary;
  }

void ASC_HudRequestCurrentBucketTop5Overlay()
  {
   string overlay_symbols[];
   ArrayResize(overlay_symbols, 0);

   if(StringLen(g_asc_hud.selected_bucket_id) > 0)
     {
      for(int rank = 1; rank <= 5 && ArraySize(overlay_symbols) < 5; rank++)
        {
         for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
           {
            ASC_ShortlistSymbolSummary entry = g_asc_hud_shortlist_rows[i];
            if(!entry.bucket_shortlisted || entry.bucket_rank != rank)
               continue;

            string bucket_id = ASC_HudEffectiveMainBucketId(entry.state);
            if(bucket_id != g_asc_hud.selected_bucket_id)
               continue;
            if(!ASC_ConsumerAllowsOrdinaryL34(entry.state))
               continue;

            int next = ArraySize(overlay_symbols);
            ArrayResize(overlay_symbols, next + 1);
            overlay_symbols[next] = entry.symbol;
            break;
           }
        }
     }

   ASC_L2SetTop5OverlayTargets(overlay_symbols, ArraySize(overlay_symbols), TimeGMT());
  }

bool ASC_HudLeaderRowComesBefore(const int left_index,const int right_index)
  {
   if(left_index < 0 || left_index >= ArraySize(g_asc_hud_shortlist_rows))
      return false;
   if(right_index < 0 || right_index >= ArraySize(g_asc_hud_shortlist_rows))
      return true;

   ASC_ShortlistSymbolSummary left = g_asc_hud_shortlist_rows[left_index];
   ASC_ShortlistSymbolSummary right = g_asc_hud_shortlist_rows[right_index];

   int left_bucket_rank = (left.bucket_rank > 0 ? left.bucket_rank : 2147483647);
   int right_bucket_rank = (right.bucket_rank > 0 ? right.bucket_rank : 2147483647);
   if(left_bucket_rank != right_bucket_rank)
      return (left_bucket_rank < right_bucket_rank);

   if(ASC_HudGlobalTop10EntryComesBefore(left, right))
      return true;
   if(ASC_HudGlobalTop10EntryComesBefore(right, left))
      return false;
   return (left_index < right_index);
  }

void ASC_HudMergeLeaderRowIndexRuns(int &values[],int &buffer[],const int left,const int mid,const int right)
  {
   int i = left;
   int j = mid;
   int k = left;
   while(i < mid && j < right)
     {
      bool left_before_right = ASC_HudLeaderRowComesBefore(values[i], values[j]);
      bool right_before_left = ASC_HudLeaderRowComesBefore(values[j], values[i]);
      if(left_before_right || !right_before_left)
         buffer[k++] = values[i++];
      else
         buffer[k++] = values[j++];
     }

   while(i < mid)
      buffer[k++] = values[i++];
   while(j < right)
      buffer[k++] = values[j++];

   for(int copy = left; copy < right; copy++)
      values[copy] = buffer[copy];
  }

void ASC_HudSortLeaderRowIndices(int &values[])
  {
   int count = ArraySize(values);
   if(count <= 1)
      return;

   int buffer[];
   ArrayResize(buffer, count, 16);

   for(int width = 1; width < count; width *= 2)
     {
      int run = width * 2;
      for(int left = 0; left < count; left += run)
        {
         int mid = left + width;
         if(mid > count)
            mid = count;
         int right = left + run;
         if(right > count)
            right = count;
         if(mid >= right)
            continue;
         ASC_HudMergeLeaderRowIndexRuns(values, buffer, left, mid, right);
        }
     }
  }

void ASC_HudRebuildBucketLeadersList()
  {
   ArrayResize(g_asc_hud.leader_row_indices, 0);
   if(StringLen(g_asc_hud.selected_bucket_id) <= 0)
     {
      ASC_HudRequestCurrentBucketTop5Overlay();
      return;
     }

   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      string shortlist_bucket_id = ASC_HudEffectiveMainBucketId(g_asc_hud_shortlist_rows[i].state);
      if(shortlist_bucket_id != g_asc_hud.selected_bucket_id)
         continue;

      int layer1_index = -1;
      ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(g_asc_hud_shortlist_rows[i], layer1_index);
      if(!ASC_HudLeaderRowStateIsVisible(visibility_state))
         continue;

      int next = ArraySize(g_asc_hud.leader_row_indices);
      ArrayResize(g_asc_hud.leader_row_indices, next + 1, 16);
      g_asc_hud.leader_row_indices[next] = i;
     }

   ASC_HudSortLeaderRowIndices(g_asc_hud.leader_row_indices);

   ASC_HudBuildLeaderTruthAudit(g_asc_hud.leader_truth_audit);
   ASC_HudRequestCurrentBucketTop5Overlay();
   ASC_HudLogLeadersScope("leader_dataset_built",
                          "shortlist_cache",
                          g_asc_hud.leader_truth_audit.trace_summary);
  }

uint ASC_HudHashMixString(const uint seed,const string value)
  {
   uint hash = seed;
   int n = (int)StringLen(value);
   for(int i = 0; i < n; i++)
     {
      hash ^= (uint)(ushort)StringGetCharacter(value, i);
      hash *= 16777619;
     }
   return hash;
  }

uint ASC_HudHashMixInt(const uint seed,const int value)
  {
   uint hash = seed;
   hash ^= (uint)value;
   hash *= 16777619;
   return hash;
  }

uint ASC_HudStructuralFingerprint()
  {
   uint hash = 2166136261;
   ASC_Layer1PassSummary summary;
   if(!ASC_Layer1TryGetLatestSummary(summary))
     {
      hash = ASC_HudHashMixString(hash, "no-summary");
      hash = ASC_HudHashMixInt(hash, (int)ASC_Layer1StructuralRevision());
      return hash;
     }

   // Structural fingerprint must stay cheap to preserve smooth 1-second tactical updates.
   hash = ASC_HudHashMixInt(hash, (int)ASC_Layer1StructuralRevision());
   hash = ASC_HudHashMixInt(hash, summary.total_symbols);
   hash = ASC_HudHashMixInt(hash, summary.resolved_classification_count);
   hash = ASC_HudHashMixInt(hash, summary.unresolved_classification_count);
   hash = ASC_HudHashMixString(hash, g_asc_hud.selected_bucket_id);
   hash = ASC_HudHashMixString(hash, g_asc_hud.selected_sub_bucket_key);
   hash = ASC_HudHashMixString(hash, g_asc_hud.selected_symbol);
   hash = ASC_HudHashMixInt(hash, (int)g_asc_hud.page);
   hash = ASC_HudHashMixInt(hash, (int)g_asc_hud.selected_symbol_section);
   return hash;
  }

uint ASC_HudPageLocalDataFingerprint()
  {
   uint hash = 2166136261;
   ASC_Layer1PassSummary summary;
   if(!ASC_Layer1TryGetLatestSummary(summary))
     {
      hash = ASC_HudHashMixString(hash, "no-summary");
      hash = ASC_HudHashMixInt(hash, (int)ASC_Layer1StructuralRevision());
      return hash;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
     {
      ASC_Layer1SymbolState selected;
      if(!ASC_HudFindSelectedSymbol(selected))
        {
         hash = ASC_HudHashMixString(hash, "selected-missing");
         hash = ASC_HudHashMixString(hash, g_asc_hud.selected_symbol);
         return hash;
        }

      hash = ASC_HudHashMixString(hash, "symbol-page");
      hash = ASC_HudHashMixString(hash, selected.symbol);
      hash = ASC_HudHashMixInt(hash, (int)selected.state);
      hash = ASC_HudHashMixInt(hash, (int)selected.confidence);
      hash = ASC_HudHashMixString(hash, selected.next_check);
      string main_bucket = ASC_HudEffectiveMainBucketId(selected);
      hash = ASC_HudHashMixString(hash, main_bucket);
      hash = ASC_HudHashMixString(hash, ASC_HudEffectiveSubBucketId(selected, main_bucket));
      return hash;
     }

   hash = ASC_HudHashMixString(hash, "overview-page");
   hash = ASC_HudHashMixInt(hash, summary.assessed_symbols);
   hash = ASC_HudHashMixInt(hash, summary.remaining_symbols);
   hash = ASC_HudHashMixInt(hash, summary.due_symbols);
   hash = ASC_HudHashMixInt(hash, summary.stale_symbols);
   hash = ASC_HudHashMixInt(hash, summary.degraded_symbols);
   hash = ASC_HudHashMixInt(hash, summary.next_due_count);
   hash = ASC_HudHashMixString(hash, summary.readiness_posture);
   hash = ASC_HudHashMixString(hash, summary.publication_posture);
   return hash;
  }

uint ASC_HudTacticalFingerprint(void)
  {
   uint hash = 2166136261;
   if(!(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL))
      return ASC_HudHashMixString(hash, "non-symbol-page");
   if(StringLen(g_asc_hud.selected_symbol) <= 0)
      return ASC_HudHashMixString(hash, "symbol-page|none-selected");

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
     {
      hash = ASC_HudHashMixString(hash, "symbol-page|missing-selected");
      hash = ASC_HudHashMixString(hash, g_asc_hud.selected_symbol);
      return hash;
     }

   hash = ASC_HudHashMixString(hash, selected.symbol);
   hash = ASC_HudHashMixInt(hash, (int)selected.observed_at_utc);
   hash = ASC_HudHashMixInt(hash, (int)selected.state);
   hash = ASC_HudHashMixInt(hash, (int)selected.confidence);
   hash = ASC_HudHashMixString(hash, selected.next_check);
   hash = ASC_HudHashMixInt(hash, (int)g_asc_hud.selected_symbol_section);
   hash = ASC_HudHashMixString(hash, g_asc_hud.deep_trigger_last_status);
   hash = ASC_HudHashMixString(hash, g_asc_hud.deep_trigger_symbol);
   hash = ASC_HudHashMixString(hash, g_asc_hud.deep_trigger_runtime_reason);
   hash = ASC_HudHashMixString(hash, g_asc_hud.current_focus_runtime_status);
   hash = ASC_HudHashMixString(hash, g_asc_hud.current_focus_runtime_live_symbol);
   hash = ASC_HudHashMixString(hash, g_asc_hud.current_focus_runtime_reason);
   hash = ASC_HudHashMixInt(hash, (int)g_asc_hud.current_focus_runtime_last_served_utc);

   ASC_Layer2Packet packet;
   bool has_packet = ASC_Layer2TryGetPacketBySymbol(selected.symbol, packet) && (packet.admitted || packet.tactical_only);
   if(has_packet)
     {
      hash = ASC_HudHashMixInt(hash, (int)packet.last_built_utc);
      hash = ASC_HudHashMixInt(hash, (int)packet.last_good_utc);
      hash = ASC_HudHashMixInt(hash, (int)MathRound(packet.bid * 100000.0));
      hash = ASC_HudHashMixInt(hash, (int)MathRound(packet.ask * 100000.0));
      hash = ASC_HudHashMixInt(hash, (int)MathRound(packet.spread_points * 10.0));
      hash = ASC_HudHashMixInt(hash, (int)packet.freshness);
      hash = ASC_HudHashMixInt(hash, packet.packet_age_sec);
     }
   else
      hash = ASC_HudHashMixString(hash, "snapshot-pending");

   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   ASC_SelectionFilterEvaluation filter;
   bool has_filter = false;
   bool has_filter_packet = false;
   double filter_score = 0.0;
   bool shortlist_found = ASC_HudResolveSelectionTruth(selected,
                                                       shortlist_entry,
                                                       shortlist_rank,
                                                       shortlist_total,
                                                       filter,
                                                       has_filter,
                                                       has_filter_packet,
                                                       filter_score);
   if(has_filter)
     {
      hash = ASC_HudHashMixString(hash, shortlist_found ? "shortlist:ranked" : "shortlist:unranked");
      hash = ASC_HudHashMixInt(hash, shortlist_rank);
      hash = ASC_HudHashMixInt(hash, shortlist_total);
      hash = ASC_HudHashMixString(hash, filter.result_state_operator_text);
      hash = ASC_HudHashMixString(hash, filter.reason_summary);
      hash = ASC_HudHashMixString(hash, filter.next_required_step);
      hash = ASC_HudHashMixInt(hash, has_filter_packet ? 1 : 0);
      hash = ASC_HudHashMixInt(hash, (int)MathRound((shortlist_found ? shortlist_entry.shortlist_score : filter_score) * 10.0));
     }
   else
      hash = ASC_HudHashMixString(hash, "shortlist-pending");

   return hash;
  }

uint ASC_HudDataFingerprint()
  {
   uint hash = ASC_HudPageLocalDataFingerprint();
   hash = ASC_HudHashMixInt(hash, (int)ASC_HudStructuralFingerprint());
   return hash;
  }

string ASC_HudStructuralSignature()
  {
   ASC_Layer1PassSummary summary;
   if(!ASC_Layer1TryGetLatestSummary(summary))
      return "no-summary|" + IntegerToString((int)ASC_Layer1StructuralRevision());

   // Structural signature must stay cheap to preserve smooth 1-second tactical updates.
   return IntegerToString((int)ASC_Layer1StructuralRevision())
          + "|" + IntegerToString(summary.total_symbols)
          + "|" + IntegerToString(summary.resolved_classification_count)
          + "|" + IntegerToString(summary.unresolved_classification_count)
          + "|" + g_asc_hud.selected_bucket_id
          + "|" + g_asc_hud.selected_sub_bucket_key
          + "|" + g_asc_hud.selected_symbol
          + "|" + IntegerToString((int)g_asc_hud.page)
          + "|" + IntegerToString((int)g_asc_hud.selected_symbol_section);
  }

string ASC_HudPageLocalDataSignature()
  {
   ASC_Layer1PassSummary summary;
   if(!ASC_Layer1TryGetLatestSummary(summary))
      return "no-summary|" + IntegerToString((int)ASC_Layer1StructuralRevision());

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
     {
      ASC_Layer1SymbolState selected;
      if(!ASC_HudFindSelectedSymbol(selected))
         return "selected-missing|" + g_asc_hud.selected_symbol;

      string selected_signature = selected.symbol
                                  + "|" + IntegerToString((int)selected.state)
                                  + "|" + IntegerToString((int)selected.confidence)
                                  + "|" + selected.next_check
                                  + "|" + ASC_HudEffectiveMainBucketId(selected)
                                  + "|" + ASC_HudEffectiveSubBucketId(selected, ASC_HudEffectiveMainBucketId(selected));

      return "symbol-page|" + selected_signature;
     }

   string base = IntegerToString(summary.assessed_symbols)
                + "|" + IntegerToString(summary.remaining_symbols)
                + "|" + IntegerToString(summary.due_symbols)
                + "|" + IntegerToString(summary.stale_symbols)
                + "|" + IntegerToString(summary.degraded_symbols)
                + "|" + IntegerToString(summary.next_due_count)
                + "|" + summary.readiness_posture
                + "|" + summary.publication_posture;

   return "overview-page|" + base;
  }

string ASC_HudTacticalSignature(void)
  {
   if(!(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL))
      return "non-symbol-page";
   if(StringLen(g_asc_hud.selected_symbol) <= 0)
      return "symbol-page|none-selected";

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
      return "symbol-page|missing-selected|" + g_asc_hud.selected_symbol;

   string signature = selected.symbol
                      + "|" + IntegerToString((int)selected.observed_at_utc)
                      + "|" + IntegerToString((int)selected.state)
                      + "|" + IntegerToString((int)selected.confidence)
                      + "|" + selected.next_check
                      + "|" + IntegerToString((int)g_asc_hud.selected_symbol_section)
                      + "|deep=" + g_asc_hud.deep_trigger_last_status
                      + "|deep_symbol=" + g_asc_hud.deep_trigger_symbol
                      + "|deep_reason=" + g_asc_hud.deep_trigger_runtime_reason
                      + "|focus_status=" + g_asc_hud.current_focus_runtime_status
                      + "|focus_live=" + g_asc_hud.current_focus_runtime_live_symbol
                      + "|focus_reason=" + g_asc_hud.current_focus_runtime_reason
                      + "|focus_served=" + IntegerToString((int)g_asc_hud.current_focus_runtime_last_served_utc);

   ASC_Layer2Packet packet;
   bool has_packet = ASC_Layer2TryGetPacketBySymbol(selected.symbol, packet) && (packet.admitted || packet.tactical_only);
   if(has_packet)
     {
      signature += "|" + IntegerToString((int)packet.last_built_utc);
      signature += "|" + IntegerToString((int)packet.last_good_utc);
      signature += "|" + IntegerToString((int)MathRound(packet.bid * 100000.0));
      signature += "|" + IntegerToString((int)MathRound(packet.ask * 100000.0));
      signature += "|" + IntegerToString((int)MathRound(packet.spread_points * 10.0));
      signature += "|" + IntegerToString((int)packet.freshness);
      signature += "|" + IntegerToString(packet.packet_age_sec);
     }
   else
      signature += "|snapshot-pending";

   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   ASC_SelectionFilterEvaluation filter;
   bool has_filter = false;
   bool has_filter_packet = false;
   double filter_score = 0.0;
   bool shortlist_found = ASC_HudResolveSelectionTruth(selected,
                                                       shortlist_entry,
                                                       shortlist_rank,
                                                       shortlist_total,
                                                       filter,
                                                       has_filter,
                                                       has_filter_packet,
                                                       filter_score);
   if(has_filter)
     {
      signature += shortlist_found
                   ? ("|shortlist:" + IntegerToString(shortlist_rank) + "/" + IntegerToString(shortlist_total))
                   : "|shortlist:unranked";
      signature += "|" + filter.result_state_operator_text;
      signature += "|" + filter.reason_summary;
      signature += "|" + filter.next_required_step;
      signature += "|" + IntegerToString(has_filter_packet ? 1 : 0);
      signature += "|" + DoubleToString(shortlist_found ? shortlist_entry.shortlist_score : filter_score, 1);
     }
   else
      signature += "|shortlist-pending";

   return signature;
  }

string ASC_HudDataSignature()
  {
   return ASC_HudPageLocalDataSignature() + "|" + ASC_HudStructuralSignature();
  }

string ASC_HudRenderContextSignature()
  {
   string signature = IntegerToString((int)ASC_Layer1StructuralRevision())
                      + "|page=" + IntegerToString((int)g_asc_hud.page)
                      + "|bucket=" + g_asc_hud.selected_bucket_id
                      + "|sub=" + g_asc_hud.selected_sub_bucket_key
                      + "|parent=" + g_asc_hud.selected_browse_parent_key
                      + "|node=" + g_asc_hud.selected_browse_node_key
                      + "|symbol=" + g_asc_hud.selected_symbol
                      + "|section=" + IntegerToString((int)g_asc_hud.selected_symbol_section)
                      + "|deep=" + IntegerToString((int)g_asc_hud.selected_deep_subpage)
                      + "|offset=" + IntegerToString(g_asc_hud.list_offset)
                      + "|filter=" + ASC_HudBrowseFilterSignature();

   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS
      || g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS
      || g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
     {
      signature += "|shortlist_source=" + g_asc_hud.last_shortlist_source;
      signature += "|shortlist_rev=" + IntegerToString((int)g_asc_hud.last_shortlist_revision);
      signature += "|shortlist_pass=" + IntegerToString((int)g_asc_hud.last_shortlist_pass_utc);
      signature += "|shortlist_count=" + IntegerToString(g_asc_hud.last_shortlist_count);
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
     {
      signature += "|shortlist_source=" + g_asc_hud.last_shortlist_source;
      signature += "|shortlist_rev=" + IntegerToString((int)g_asc_hud.last_shortlist_revision);
      signature += "|shortlist_pass=" + IntegerToString((int)g_asc_hud.last_shortlist_pass_utc);
      signature += "|shortlist_count=" + IntegerToString(g_asc_hud.last_shortlist_count);
      signature += "|top10_visible=" + IntegerToString(ASC_HudVisibleGlobalTop10Count());
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
     {
      signature += "|symbol_list_key=" + g_asc_hud.selected_symbol_list_key;
      signature += "|symbol_list_rev=" + IntegerToString((int)g_asc_hud.selected_symbol_list_revision);
      signature += "|symbol_list_shortlist_rev=" + IntegerToString((int)g_asc_hud.selected_symbol_list_shortlist_revision);
     }

   return signature;
  }

string ASC_HudVisibleSnapshotSignature()
  {
   string signature = ASC_HudRenderContextSignature() + "|data=" + ASC_HudDataSignature();

   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS
      || g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS
      || g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS
      || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10
      || g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
     {
      string shortlist_order_hash = ASC_HudShortlistOrderingSignature();
      signature += "|order_hash=" + shortlist_order_hash;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
      signature += "|tactical=" + ASC_HudTacticalSignature();

   return signature;
  }

bool ASC_HudCanSkipRenderForUnchangedSnapshot()
  {
   if(!ASC_HudIsDirty())
      return false;
   if(g_asc_hud.dirty_layout || g_asc_hud.dirty_navigation)
      return false;
   if(g_asc_hud.resize_pending || g_asc_hud.resize_burst_active || g_asc_hud.resize_force_full_rebuild)
      return false;
   if(g_asc_hud.chart_change_pending)
      return false;
   if(StringLen(g_asc_hud.last_render_snapshot_signature) <= 0)
      return false;
   return (ASC_HudVisibleSnapshotSignature() == g_asc_hud.last_render_snapshot_signature);
  }

bool ASC_HudParityDiagnosticsEnabled()
  {
   return (g_asc_trader_controls.hud_parity_diagnostics_enabled && MQLInfoInteger(MQL_DEBUG) != 0);
  }

void ASC_HudFlushParityDiagnostics(const int heartbeat_counter,const bool force_flush=false)
  {
   if(!ASC_HudParityDiagnosticsEnabled())
      return;

   int pending_total = g_asc_hud.parity_diag_structure_mismatch_count
                       + g_asc_hud.parity_diag_data_mismatch_count
                       + g_asc_hud.parity_diag_tactical_mismatch_count;
   if(pending_total <= 0)
      return;

   int cadence = MathMax(1, ASC_HUD_PARITY_DIAG_RECHECK_HEARTBEATS);
   bool cadence_due = (heartbeat_counter > 0 && (heartbeat_counter % cadence) == 0);
   bool first_batch = (g_asc_hud.parity_diag_last_logged_heartbeat <= 0);
   if(!force_flush && !cadence_due && !first_batch)
      return;

   PrintFormat("ASC HUD dirty parity diagnostics: mismatches[structure=%d data=%d tactical=%d] heartbeat=%d",
               g_asc_hud.parity_diag_structure_mismatch_count,
               g_asc_hud.parity_diag_data_mismatch_count,
               g_asc_hud.parity_diag_tactical_mismatch_count,
               heartbeat_counter);

   g_asc_hud.parity_diag_structure_mismatch_count = 0;
   g_asc_hud.parity_diag_data_mismatch_count = 0;
   g_asc_hud.parity_diag_tactical_mismatch_count = 0;
   g_asc_hud.parity_diag_last_logged_heartbeat = heartbeat_counter;
  }

bool ASC_HudCanApplyCommittedContextPatch()
  {
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   if(ASC_HudIsDirty())
      return false;
   if(StringLen(g_asc_hud.last_render_context_signature) <= 0)
      return false;
   if(g_asc_hud.resize_pending || g_asc_hud.resize_burst_active || g_asc_hud.resize_force_full_rebuild)
      return false;
   if(g_asc_hud.chart_change_pending)
      return false;
   return (ASC_HudRenderContextSignature() == g_asc_hud.last_render_context_signature);
  }

bool ASC_HudCanApplyClockPatch()
  {
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   if(g_asc_hud.resize_pending || g_asc_hud.resize_burst_active || g_asc_hud.resize_force_full_rebuild)
      return false;
   if(g_asc_hud.chart_change_pending)
      return false;
   bool header_clock_cached = (ASC_HudFindObjectCacheTracked(ASC_HUD_PREFIX + "hdr_clock_text") >= 0);
   bool overview_clock_cached = (ASC_HudFindObjectCacheTracked(ASC_HUD_PREFIX + "ov_clock_text") >= 0);
   return (header_clock_cached || overview_clock_cached);
  }

string ASC_HudClockMetaText(const int heartbeat_counter,const datetime now_utc)
  {
   string heartbeat_label = (heartbeat_counter > 0 ? IntegerToString(heartbeat_counter) : "warming");
   return "Heartbeat #" + heartbeat_label + " • " + TimeToString(now_utc, TIME_MINUTES|TIME_SECONDS);
  }

string ASC_HudBreadcrumb()
  {
   string markets = ASC_HudLabelMarkets();
   string leaders = ASC_HudLabelLeaders();
   string groups = ASC_HudLabelGroups();
   string bucket_name = ASC_HudMainBucketName(g_asc_hud.selected_bucket_id);
   ASC_HudSubBucketRow selected_sub = ASC_HudSelectedSubBucketRow();
   string sub_name = (StringLen(selected_sub.name) > 0 ? selected_sub.name : groups);
   string symbol_name = (StringLen(g_asc_hud.selected_symbol) > 0 ? g_asc_hud.selected_symbol : "Symbols");
   bool stock_bucket = ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id);

   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return "Overview / " + markets;
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return markets + " / " + bucket_name + " / " + leaders;
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
     {
      if(stock_bucket)
        {
         string parent_key = ASC_HudActiveStockBrowseParentKey();
         string stock_path = ASC_HudBrowseNodePath(parent_key);
         if(StringLen(stock_path) > 0)
            return markets + " / " + bucket_name + " / " + stock_path + " / " + ASC_HudCurrentStockBrowseHeading();
        }
      return markets + " / " + bucket_name + " / " + groups;
     }
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "Overview / " + ASC_HudLabelGlobalTop10();

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
     {
      if(stock_bucket)
        {
         string stock_scope = ASC_HudBrowseNodePath(g_asc_hud.selected_sub_bucket_key);
         if(StringLen(stock_scope) > 0)
            return markets + " / " + bucket_name + " / " + stock_scope + " / Symbols";
        }
      return bucket_name + " / " + sub_name + " / Symbols";
     }
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW)
      return markets + " / " + bucket_name + " / " + sub_name + " / " + symbol_name + " / Overview";
   if(g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
      return markets + " / " + bucket_name + " / " + sub_name + " / " + symbol_name + " / " + ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section);
  return "Overview";
  }

string ASC_HudCompactTrailText(const string trail,const int max_chars)
  {
   if(max_chars <= 0)
      return "";
   if(StringLen(trail) <= max_chars)
      return trail;

   string parts[];
   ArrayResize(parts, 0);
   int start = 0;
   int guard = 0;
   while(start < StringLen(trail) && guard < 24)
     {
      int sep = StringFind(trail, " / ", start);
      string token = (sep >= 0 ? StringSubstr(trail, start, sep - start) : StringSubstr(trail, start));
      token = ASC_HudTrim(token);
      if(StringLen(token) > 0)
        {
         int old = ArraySize(parts);
         ArrayResize(parts, old + 1);
         parts[old] = token;
        }
      if(sep < 0)
         break;
      start = sep + 3;
      guard++;
     }

   int count = ArraySize(parts);
   if(count <= 1)
      return ASC_HudClampTextMiddle(trail, max_chars);

   string head = parts[0];
   string tail = parts[count - 1];
   string prior = (count >= 2 ? parts[count - 2] : "");

   string compact = head + " / ... / " + prior + " / " + tail;
   if(StringLen(compact) <= max_chars)
      return compact;

   compact = ASC_HudClampText(head, MathMax(8, max_chars / 5)) + " / ... / " + prior + " / " + tail;
   if(StringLen(compact) <= max_chars)
      return compact;

   compact = "... / " + prior + " / " + tail;
   if(StringLen(compact) <= max_chars)
      return compact;

   compact = "... / " + tail;
   if(StringLen(compact) <= max_chars)
      return compact;

   return ASC_HudClampTextMiddle(tail, max_chars);
  }

ASC_HudStatView ASC_HudStatForSection(const ASC_HudSymbolSectionFamily section)
  {
   switch(section)
     {
      case ASC_HUD_SYMBOL_SECTION_OVERVIEW:
         return ASC_HUD_STAT_MARKET_ACTION;
      case ASC_HUD_SYMBOL_SECTION_MARKET_WATCH:
         return ASC_HUD_STAT_MARKET_CONTEXT;
      case ASC_HUD_SYMBOL_SECTION_SPECIFICATION:
         return ASC_HUD_STAT_TRADING_CONDITIONS;
      case ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER:
         return ASC_HUD_STAT_PUBLICATION_RESULT_STATUS;
      case ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT:
         return ASC_HUD_STAT_ACCOUNT_TRADE_CONTEXT;
      case ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS:
         return ASC_HUD_STAT_DEEP_ANALYSIS;
      case ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_A:
         return ASC_HUD_STAT_ACCOUNT_TRADE_CONTEXT;
      case ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_B:
         return ASC_HUD_STAT_PUBLICATION_RESULT_STATUS;
     }
   return ASC_HUD_STAT_MARKET_ACTION;
  }

int ASC_HudReadinessPercent()
  {
   if(!g_asc_hud.has_summary || g_asc_hud.latest_summary.total_symbols <= 0)
      return 0;
   int ready_symbols = g_asc_hud.latest_summary.open_count + g_asc_hud.latest_summary.closed_count;
   int percent = (int)((100.0 * ready_symbols) / g_asc_hud.latest_summary.total_symbols);
   if(percent < 0) percent = 0;
   if(percent > 100) percent = 100;
   return percent;
  }

int ASC_HudCoveragePercent()
  {
   if(!g_asc_hud.has_summary || g_asc_hud.latest_summary.total_symbols <= 0)
      return 0;
   int percent = (int)((100.0 * g_asc_hud.latest_summary.assessed_symbols) / g_asc_hud.latest_summary.total_symbols);
   if(percent < 0) percent = 0;
   if(percent > 100) percent = 100;
   return percent;
  }

int ASC_HudBucketUniverseCount()
  {
   int total = 0;
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
      total += g_asc_hud.buckets[i].total;
   return total;
  }

int ASC_HudSubBucketUniverseCount()
  {
   int total = 0;
   for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
      total += g_asc_hud.sub_buckets[i].total;
   return total;
  }

string ASC_HudBucketDistributionCompact()
  {
   int fx = 0;
   int indices = 0;
   int stocks = 0;
   int metals = 0;
   int energy = 0;
   int crypto = 0;
   int rates = 0;
   int volatility = 0;
   int commodities = 0;
   int funds = 0;
   int unknown = 0;
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
     {
      string id = g_asc_hud.buckets[i].id;
      int total = g_asc_hud.buckets[i].total;
      if(id == "fx") fx += total;
      else if(id == "indices") indices += total;
      else if(id == "stocks") stocks += total;
      else if(id == "metals") metals += total;
      else if(id == "energy") energy += total;
      else if(id == "crypto") crypto += total;
      else if(id == "rates") rates += total;
      else if(id == "volatility") volatility += total;
      else if(id == "commodities") commodities += total;
      else if(id == "funds_etfs") funds += total;
      else unknown += total;
     }
   return StringFormat("fx=%d indices=%d stocks=%d metals=%d energy=%d crypto=%d rates=%d vol=%d comm=%d funds=%d unknown=%d",
                       fx, indices, stocks, metals, energy, crypto, rates, volatility, commodities, funds, unknown);
  }

string ASC_HudSubGroupDistributionCompact()
  {
   int fx = 0;
   int indices = 0;
   int stocks = 0;
   int metals = 0;
   int energy = 0;
   int crypto = 0;
   int rates = 0;
   int volatility = 0;
   int commodities = 0;
   int funds = 0;
   int unknown = 0;
   for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
     {
      string id = g_asc_hud.sub_buckets[i].bucket_id;
      if(id == "fx") fx++;
      else if(id == "indices") indices++;
      else if(id == "stocks") stocks++;
      else if(id == "metals") metals++;
      else if(id == "energy") energy++;
      else if(id == "crypto") crypto++;
      else if(id == "rates") rates++;
      else if(id == "volatility") volatility++;
      else if(id == "commodities") commodities++;
      else if(id == "funds_etfs") funds++;
      else unknown++;
     }
  return StringFormat("fx=%d indices=%d stocks=%d metals=%d energy=%d crypto=%d rates=%d vol=%d comm=%d funds=%d unknown=%d",
                       fx, indices, stocks, metals, energy, crypto, rates, volatility, commodities, funds, unknown);
  }

bool ASC_HudMainGroupDistributionMatchesSummary()
  {
   if(!g_asc_hud.has_summary)
      return true;

   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
     {
      string id = g_asc_hud.buckets[i].id;
      int actual = g_asc_hud.buckets[i].total;
      int expected = -1;
      if(id == "fx") expected = g_asc_hud.latest_summary.main_group_fx_count;
      else if(id == "indices") expected = g_asc_hud.latest_summary.main_group_indices_count;
      else if(id == "stocks") expected = g_asc_hud.latest_summary.main_group_stocks_count;
      else if(id == "metals") expected = g_asc_hud.latest_summary.main_group_metals_count;
      else if(id == "energy") expected = g_asc_hud.latest_summary.main_group_energy_count;
      else if(id == "crypto") expected = g_asc_hud.latest_summary.main_group_crypto_count;
      else if(id == "rates") expected = g_asc_hud.latest_summary.main_group_rates_count;
      else if(id == "volatility") expected = g_asc_hud.latest_summary.main_group_volatility_count;
      else if(id == "commodities") expected = g_asc_hud.latest_summary.main_group_commodities_count;
      else if(id == "funds_etfs") expected = g_asc_hud.latest_summary.main_group_funds_etfs_count;
      else if(id == "unknown") expected = g_asc_hud.latest_summary.main_group_unknown_count;

      if(expected >= 0 && actual != expected)
         return false;
     }

   return true;
  }

string ASC_HudClassificationGuardLine()
  {
   if(!g_asc_hud.has_summary)
      return "Classification guard: summary unavailable";

   int unresolved_visible = 0;
   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
      unresolved_visible += g_asc_hud.buckets[i].unresolved_count;

   int resolved = g_asc_hud.latest_summary.resolved_classification_count;
   int unresolved = g_asc_hud.latest_summary.unresolved_classification_count;
   int fallback = g_asc_hud.latest_summary.fallback_classification_count;
   int total = resolved + unresolved;
   double fallback_ratio = (total > 0 ? (double)fallback / (double)total : 0.0);

   bool distribution_match = ASC_HudMainGroupDistributionMatchesSummary();
   bool unresolved_match = (unresolved_visible == unresolved);

   string posture = "stable";
   if(!distribution_match || !unresolved_match || fallback_ratio >= 0.40)
      posture = "alert";
   else if(g_asc_hud.rebuild_fallback_symbols > 0 || fallback_ratio >= 0.20)
      posture = "watch";

   return StringFormat("Classification %s | Distribution %s | Review %d | Routing %.0f%%",
                       posture,
                       distribution_match ? "aligned" : "drift",
                       unresolved,
                       fallback_ratio * 100.0);
  }

string ASC_HudCoverageText()
  {
   if(!g_asc_hud.has_summary)
      return "Coverage 0/0";
   return StringFormat("Coverage %d/%d", g_asc_hud.latest_summary.assessed_symbols, g_asc_hud.latest_summary.total_symbols);
  }

string ASC_HudUniverseStateSummaryText()
  {
   if(!g_asc_hud.has_summary)
      return "Universe 0 | Open 0 | Closed 0 | Uncertain 0 | Unknown 0";
   return StringFormat("Universe %d | Open %d | Closed %d | Uncertain %d | Unknown %d",
                       g_asc_hud.latest_summary.total_symbols,
                       g_asc_hud.latest_summary.open_count,
                       g_asc_hud.latest_summary.closed_count,
                       g_asc_hud.latest_summary.uncertain_count,
                       g_asc_hud.latest_summary.unknown_count);
  }

string ASC_HudWorkloadSummaryText()
  {
   if(!g_asc_hud.has_summary)
      return "Assessed 0 | Due 0 | Remaining 0";
   return StringFormat("Assessed %d | Due %d | Remaining %d",
                       g_asc_hud.latest_summary.assessed_symbols,
                       g_asc_hud.latest_summary.due_symbols,
                       g_asc_hud.latest_summary.remaining_symbols);
  }

string ASC_HudAttentionSummaryText()
  {
   if(!g_asc_hud.has_summary)
      return "Degraded 0 | Delayed 0 | Needs Review 0";
   return StringFormat("Degraded %d | Delayed %d | Needs Review %d",
                       g_asc_hud.latest_summary.degraded_symbols,
                       g_asc_hud.latest_summary.stale_symbols,
                       g_asc_hud.latest_summary.unresolved_classification_count);
  }

string ASC_HudReadinessSummaryText()
  {
   return StringFormat("Readiness %d%% (%s)", ASC_HudReadinessPercent(), ASC_HudReadinessText());
  }

string ASC_HudQualitySummaryText()
  {
   return "Quality " + ASC_HudQualityStatusText();
  }

string ASC_HudOverviewTrustPosture()
  {
   if(!g_asc_hud.has_summary)
      return "Trust pending";
   if(g_asc_hud.latest_summary.is_degraded)
      return "Trust alert";
   if(g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_partial)
      return "Trust watch";
   if(ASC_HudCoveragePercent() < 80)
      return "Trust watch";
   return "Trust ready";
  }

string ASC_HudOverviewFocusBucketLine()
  {
   string best_name = "";
   int best_score = -1;
   int best_open = 0;
   int best_promoted = 0;

   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
     {
      ASC_HudBucketRow bucket = g_asc_hud.buckets[i];
      if(bucket.total <= 0)
         continue;

      ASC_HudScopeRankingStats ranking;
      ASC_HudBuildScopeRankingStats(bucket.id, "", ranking);
      int score = (ranking.promoted_count * 6) + (ranking.ranked_count * 3) + bucket.open_count;

      if(score > best_score)
        {
         best_score = score;
         best_name = bucket.name;
         best_open = bucket.open_count;
         best_promoted = ranking.promoted_count;
        }
     }

   if(best_score < 0)
      return "No concentration signal yet";

   return StringFormat("%s | Open %d | Promoted %d", best_name, best_open, best_promoted);
  }

string ASC_HudOverviewFocusBucketName()
  {
   string best_name = "";
   int best_score = -1;

   for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
     {
      ASC_HudBucketRow bucket = g_asc_hud.buckets[i];
      if(bucket.total <= 0)
         continue;

      ASC_HudScopeRankingStats ranking;
      ASC_HudBuildScopeRankingStats(bucket.id, "", ranking);
      int score = (ranking.promoted_count * 6) + (ranking.ranked_count * 3) + bucket.open_count;
      if(score > best_score)
        {
         best_score = score;
         best_name = bucket.name;
        }
     }

   if(best_score < 0 || StringLen(best_name) <= 0)
      return "No focus market yet";
   return best_name;
  }

string ASC_HudOverviewShortlistFlowLine()
  {
   int promoted = 0;
   int shortlisted = 0;
   int reserve = 0;
   int pending = 0;
   for(int i = 0; i < ArraySize(g_asc_hud_shortlist_rows); i++)
     {
      string band = g_asc_hud_shortlist_rows[i].shortlist_band;
      StringToLower(band);
      if(band == "promoted")
         promoted++;
      else if(band == "shortlisted")
         shortlisted++;
      else if(band == "reserve")
         reserve++;
      else if(band == "pending")
         pending++;
     }

   return StringFormat("Promoted %d | Shortlisted %d | Reserve %d | Pending %d",
                       promoted,
                       shortlisted,
                       reserve,
                       pending);
  }

string ASC_HudOverviewAttentionLine()
  {
   if(!g_asc_hud.has_summary)
      return "Waiting for first scanner pass before attention can be scored.";

   int degraded = g_asc_hud.latest_summary.degraded_symbols;
   int delayed = g_asc_hud.latest_summary.stale_symbols;
   int due = g_asc_hud.latest_summary.due_symbols;
   int needs_review = g_asc_hud.latest_summary.unresolved_classification_count;

   if(degraded <= 0 && delayed <= 0 && due <= 0 && needs_review <= 0)
      return "No immediate warning lane is active.";

   string line = StringFormat("Degraded %d | Delayed %d | Due %d | Needs Review %d",
                              degraded,
                              delayed,
                              due,
                              needs_review);
   return line;
  }

string ASC_HudSubsetScopeLine()
  {
   string markets = ASC_HudLabelMarkets();
   string leaders = ASC_HudLabelLeaders();
   string groups = ASC_HudLabelGroups();
   int page_visible = g_asc_hud.list_total_items;
   int page_from = g_asc_hud.list_range_start;
   int page_to = g_asc_hud.list_range_end;

   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return StringFormat("%s %d-%d/%d", markets, page_from, page_to, page_visible);
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return StringFormat("%s %d-%d/%d", leaders, page_from, page_to, page_visible);
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return StringFormat("Global Top 10 %d-%d/%d", page_from, page_to, page_visible);
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
      return StringFormat("%s %d-%d/%d", groups, page_from, page_to, page_visible);
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return StringFormat("Symbols %d-%d/%d", page_from, page_to, page_visible);
  return "List";
  }

string ASC_HudListHierarchyLabel()
  {
   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return "Market View";
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return "Leaders View";
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "Best Overall View";
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
      return "Group View";
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return "Symbol View";
   return "Browse View";
  }

string ASC_HudListEmptyStateTitle()
  {
   string markets = ASC_HudLabelMarkets();
   string leaders = ASC_HudLabelLeaders();
   string groups = ASC_HudLabelGroups();
   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return "No " + markets + " Yet";
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
      return "No " + leaders + " Yet";
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "No Global Top 10 Entries Yet";
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
      return "No " + groups + " in This Market";
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return "No Symbols in This Group";
   return "No Rows";
  }

string ASC_HudListEmptyStateSummary()
  {
   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
      return "Waiting for scanner coverage to land market distribution.";
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      ASC_HudBuildLeaderTruthAudit(g_asc_hud.leader_truth_audit);
      return "No currently renderable bucket-wide top-five leaders are available on this page. Cause trace: " + g_asc_hud.leader_truth_audit.empty_state_cause + ".";
     }
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return "The lawful diversified overall shortlist/board carry is not yet ready to populate this premium best-overall page.";
   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
      return "This market currently has no landed groups in the active browse scope.";
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      return "No symbols are currently admitted in this selected scope.";
   return "Rows are currently unavailable.";
  }

string ASC_HudListEmptyStateDetail()
  {
   bool delayed = (g_asc_hud.has_summary && (g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded));
   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      ASC_HudBuildLeaderTruthAudit(g_asc_hud.leader_truth_audit);
      return StringFormat("Leader trace: admitted %d | packet-ready %d | warmup %d | visible %d | retained %d | hidden %d | snapshot-mismatch %d | unavailable %d | cause %s",
                          g_asc_hud.leader_truth_audit.bucket_admitted_count,
                          g_asc_hud.leader_truth_audit.packet_ready_count,
                          g_asc_hud.leader_truth_audit.packet_warmup_count,
                          g_asc_hud.leader_truth_audit.hud_visible_count,
                          g_asc_hud.leader_truth_audit.retained_last_good_count,
                          g_asc_hud.leader_truth_audit.hidden_by_rule_count,
                          g_asc_hud.leader_truth_audit.snapshot_mismatch_count,
                          g_asc_hud.leader_truth_audit.unavailable_market_watch_count,
                          g_asc_hud.leader_truth_audit.empty_state_cause);
     }
   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return StringFormat("Global Top 10 trace: visible %d | shortlist total %d | source diversified overall shortlist/board carry | no HUD-owned re-rank.",
                          ASC_HudVisibleGlobalTop10Count(),
                          ASC_ShortlistCount(g_asc_hud_shortlist_rows));
   if(delayed)
      return "Scanner posture is delayed/degraded; keep missingness explicit and await the next lawful refresh.";
   return "This surface is intentionally non-blank; no row truth has been omitted.";
  }

string ASC_HudBrowseIntegrityLine()
  {
   int tracked = g_asc_hud.rebuild_tracked_symbols;
   int assigned = g_asc_hud.rebuild_assigned_symbols;
   int fallback = g_asc_hud.rebuild_fallback_symbols;
   int lost = g_asc_hud.rebuild_lost_symbols;

   if(tracked <= 0)
      return "Browse truth pending";

   if(lost > 0)
      return StringFormat("Browse degraded | Assigned %d/%d | Lost %d | Review-routed %d", assigned, tracked, lost, fallback);

   return StringFormat("Browse ready | Assigned %d/%d | Review-routed %d", assigned, tracked, fallback);
  }

string ASC_HudScannerAvailabilityLine1(const ASC_Layer1SymbolState &state)
  {
   if(state.classification.resolved)
      return "Confirmed";
   return "Awaiting Confirmation";
  }

string ASC_HudScannerAvailabilityLine2(const ASC_Layer1SymbolState &state)
  {
   if(state.classification.resolved)
      return "Coverage Active | Market State " + ASC_L1StateToOperatorText(state.state);
   return "Coverage Partial | Market State Unknown";
  }

string ASC_HudScannerAvailabilityLine3(const ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   return "Freshness " + ASC_HudSymbolPosture(state, now_utc) + " | Observed Age " + ASC_HudAgeText(state.observed_at_utc, now_utc);
  }

string ASC_HudStatusStripLine()
  {
   int tracked = g_asc_hud.has_summary ? g_asc_hud.latest_summary.total_symbols : 0;
   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
     {
      return StringFormat("%s • Assessed %d • Due %d • Remaining %d • Universe %d",
                          ASC_HudPageName(g_asc_hud.page),
                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.assessed_symbols : 0),
                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.due_symbols : 0),
                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.remaining_symbols : 0),
                          tracked);
     }

   string status = ASC_HudPageName(g_asc_hud.page)
                   + " • Scope " + ASC_HudListHierarchyLabel()
                   + " • " + ASC_HudPageCommandSummary(g_asc_hud.page)
                   + " • " + ASC_HudPageRankSurfaceSummary(g_asc_hud.page);
   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS || g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS || g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
      status = status + " • " + ASC_HudSubsetScopeLine();
   status = status + " • Universe " + IntegerToString(tracked);
   return status;
  }

void ASC_HudSetNotice(const string message,const int ttl_seconds=8)
  {
   g_asc_hud.transient_notice = message;
   g_asc_hud.transient_notice_until = TimeGMT() + ttl_seconds;
   ASC_HudMarkDirtyDataLight();
  }

void ASC_HudRenderHeader(const int x,const int y,const int w)
  {
   bool compact = (w < 1200);
   bool tight = (w < 980);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "header", x, y, w, ASC_HUD_HEADER_H, ASC_HudThemeBgPanel(), ASC_HudThemeBorderEdge());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "header", x, y, w, ASC_HUD_HEADER_H, ASC_HudThemeBgRoot());
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "header_glow", x + 8, y + 6, w - 16, 1, ASC_HudThemeAccentSecondary(), ASC_HudThemeAccentSecondary());

   int shell_padding_x = (tight ? 9 : 11);
   int shell_padding_y = (tight ? 5 : 6);
   int clock_box_w = MathMax((tight ? 198 : 216), MathMin((compact ? 282 : 320), w / 4));
   int clock_x = x + w - clock_box_w - shell_padding_x;
   int left_x = x + shell_padding_x;
   int lane_w = clock_x - left_x - (tight ? 10 : 12);
   if(lane_w < (tight ? 220 : 280))
     {
      clock_box_w = (tight ? 182 : 198);
      clock_x = x + w - clock_box_w - shell_padding_x;
      lane_w = MathMax((tight ? 196 : 236), clock_x - left_x - (tight ? 8 : 10));
     }

   int lane_top = y + shell_padding_y;
   int lane_title_h = (tight ? 13 : 14);
   int lane_subtitle_h = 10;
   int lane_runtime_h = 16;
   int lane_gap = 2;

   int title_y = lane_top;
   int subtitle_y = title_y + lane_title_h + lane_gap;
   int runtime_y = subtitle_y + lane_subtitle_h + lane_gap;

   ASC_HudEnsureRect(ASC_HUD_PREFIX + "hdr_identity_chip", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "hdr_identity_chip_t", "", 0, 0, 8, clrBlack);

   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_title", "Aurora Sentinel Scanner", left_x, title_y, (tight ? 13 : 15), ASC_HudThemeTextPrimary(), lane_w);
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_subtitle", "Operational command view", left_x, subtitle_y, 8, ASC_HudThemeTextSecondary(), lane_w);

   int tracked = (g_asc_hud.has_summary ? g_asc_hud.latest_summary.total_symbols : 0);
   string runtime_line = "Health "
                         + (g_asc_hud.has_summary ? "READY" : "AWAITING CONFIRMATION")
                         + " • Coverage " + IntegerToString(ASC_HudCoveragePercent()) + "%";
   int runtime_chip_w = MathMax((tight ? 182 : 220), MathMin((tight ? 292 : 332), (lane_w * 58) / 100));
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "hdr_runtime_chip", left_x, runtime_y, runtime_chip_w, lane_runtime_h, ASC_HudThemeBgLayer3(), ASC_HudThemeBorderBase());
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_runtime_chip_t", runtime_line, left_x + 6, runtime_y + 3, 8, ASC_HudThemeTextPrimary(), runtime_chip_w - 10);

   string status_line = "Universe " + IntegerToString(tracked)
                        + " • Workload " + ASC_HudWorkloadSummaryText()
                        + " • Posture " + ASC_HudAttentionSummaryText();
   if(compact)
      status_line = "Universe " + IntegerToString(tracked) + " • Posture " + ASC_HudAttentionSummaryText();
   if(tight)
      status_line = "Universe " + IntegerToString(tracked) + " • Health " + ASC_HudReadinessSummaryText();
   int mode_x = left_x + runtime_chip_w + 8;
   int mode_w = lane_w - runtime_chip_w - 10;
   if(mode_w < 72)
      mode_w = 72;
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_mode", status_line, mode_x, runtime_y + 3, 8, ASC_HudThemeTextMuted(), mode_w);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "hdr_warmup", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "hdr_version", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "hdr_title_legacy", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "hdr_subtitle_legacy", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "hdr_runtime_legacy", "", 0, 0, 8, clrBlack);

   int clock_panel_h = ASC_HUD_HEADER_H - (shell_padding_y * 2);
   int clock_panel_y = y + shell_padding_y;
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "hdr_clock_panel", clock_x, clock_panel_y, clock_box_w, clock_panel_h, ASC_HudThemeBgLayer2(), ASC_HudThemeBorderBase());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "hdr_clock_panel", clock_x, clock_panel_y, clock_box_w, clock_panel_h, ASC_HudThemeBgPanel());
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "hdr_clock_bar", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_clock_title", "UTC", clock_x + 10, clock_panel_y + 3, 8, ASC_HudThemeTextMuted(), clock_box_w - 20);
   datetime now_utc = TimeGMT();
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_clock_text", TimeToString(now_utc, TIME_DATE|TIME_SECONDS), clock_x + 10, clock_panel_y + 20, 10, ASC_HudThemeTextPrimary(), clock_box_w - 20);
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "hdr_clock_meta",
                             ASC_HudClockMetaText(g_asc_hud.proof_last_tactical_heartbeat_counter, now_utc),
                             clock_x + 10,
                             clock_panel_y + clock_panel_h - 13,
                             8,
                             ASC_HudThemeTextMuted(),
                             clock_box_w - 20);
  }

void ASC_HudRenderTopNav(const int x,const int y,const int w)
  {
   string markets = ASC_HudLabelMarkets();
   string leaders = ASC_HudLabelLeaders();
   string groups = ASC_HudLabelGroups();
   bool tight = (w < 980);
   bool compact = (w < 1160);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "topnav", x, y, w, ASC_HUD_TOPNAV_H, ASC_HudThemeBgLayer3(), ASC_HudThemeBorderBase());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "topnav", x, y, w, ASC_HUD_TOPNAV_H, ASC_HudThemeBgRoot());

   color nav_bg = ASC_HudThemeBgPanelAlt();
   color nav_border = ASC_HudThemeBorderBase();
   color nav_text_muted = ASC_HudThemeTextMuted();
   color active_bg = ASC_HudThemeBgCardAlt();
   color active_border = ASC_HudThemeAccentPrimary();
   color action_bg = ASC_HudThemeBgPanel();
   color action_border = ASC_HudThemeAccentSelected();
   color action_text = ASC_HudThemeTextPrimary();
   color action_bg_disabled = ASC_HudThemeBgLayer2();
   color action_border_disabled = ASC_HudThemeBorderBase();
   color action_text_disabled = ASC_HudThemeTextMuted();

   int btn_h = (tight ? 22 : 24);
   int btn_y = y + ((ASC_HUD_TOPNAV_H - btn_h) / 2);
   int nav_pad = (tight ? 8 : 12);
   int tab_gap = (tight ? 5 : 8);
   int group_gap = (tight ? 8 : 14);
   int nav_right = x + w - nav_pad;
   int bx = x + nav_pad;
   int back_w = (tight ? 56 : 72);
   int forward_w = (tight ? 64 : 82);
   if(bx + back_w + tab_gap + forward_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_back",
                          "Back",
                          bx,
                          btn_y,
                          back_w,
                          btn_h,
                          (g_asc_hud.history_count > 0 ? action_bg : action_bg_disabled),
                          (g_asc_hud.history_count > 0 ? action_border : action_border_disabled),
                          (g_asc_hud.history_count > 0 ? action_text : action_text_disabled));
      bx += back_w + tab_gap;
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_forward",
                          "Next",
                          bx,
                          btn_y,
                          forward_w,
                          btn_h,
                          (g_asc_hud.forward_count > 0 ? action_bg : action_bg_disabled),
                          (g_asc_hud.forward_count > 0 ? action_border : action_border_disabled),
                          (g_asc_hud.forward_count > 0 ? action_text : action_text_disabled));
      bx += forward_w;
      int divider_x = bx + (group_gap / 2) - 1;
      ASC_HudEnsureRect(ASC_HUD_PREFIX + "nav_back_divider", divider_x, y + 7, 2, ASC_HUD_TOPNAV_H - 14, ASC_HudThemeBorderFocus(), ASC_HudThemeBorderFocus());
      bx += group_gap;
     }
   else
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_back", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_forward", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureRect(ASC_HUD_PREFIX + "nav_back_divider", 0, 0, 0, 0, clrBlack, clrBlack);
     }

   int core_tab_count = 6;
   bool has_selected_symbol = (StringLen(g_asc_hud.selected_symbol) > 0);
   bool symbol_context = has_selected_symbol
                         && (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW
                             || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
   bool show_detail_nav = has_selected_symbol && g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL;
   int symbol_w = (tight ? 96 : 110);
   int detail_w = (tight ? 118 : 136);
   int symbol_context_reserve = 0;
   if(symbol_context)
      symbol_context_reserve += symbol_w + tab_gap;
   if(show_detail_nav)
      symbol_context_reserve += detail_w + tab_gap;
   int core_tabs_right = nav_right - symbol_context_reserve;
   if(core_tabs_right < bx)
      core_tabs_right = bx;
   int available_tabs_w = core_tabs_right - bx;
   int tab_w = (available_tabs_w - (tab_gap * (core_tab_count - 1))) / core_tab_count;
   int tab_min_w = (tight ? 56 : 72);
   int tab_max_w = (tight ? 96 : 128);
   if(tab_w < tab_min_w)
      tab_w = tab_min_w;
   if(tab_w > tab_max_w)
      tab_w = tab_max_w;

   string overview_label = tight ? "Home" : "Overview";
   if(bx + tab_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_home", ASC_HudButtonLabelForWidth(overview_label, tab_w), bx, btn_y, tab_w, btn_h, (g_asc_hud.page == ASC_HUD_PAGE_OVERVIEW ? active_bg : nav_bg), (g_asc_hud.page == ASC_HUD_PAGE_OVERVIEW ? active_border : nav_border), (g_asc_hud.page == ASC_HUD_PAGE_OVERVIEW ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += tab_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_home", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   string top10_label = tight ? "Top 10" : ASC_HudLabelGlobalTop10();
   if(compact && !tight)
      top10_label = "Top 10";
   if(bx + tab_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_top10", ASC_HudButtonLabelForWidth(top10_label, tab_w), bx, btn_y, tab_w, btn_h, (g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10 ? active_bg : nav_bg), (g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10 ? active_border : nav_border), (g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10 ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += tab_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_top10", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   string markets_label = tight ? "Markets" : markets;
   if(compact && !tight)
      markets_label = "Markets";
   if(bx + tab_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_buckets", ASC_HudButtonLabelForWidth(markets_label, tab_w), bx, btn_y, tab_w, btn_h, (g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS ? active_bg : nav_bg), (g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS ? active_border : nav_border), (g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += tab_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_buckets", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   string leaders_label = tight ? "Leaders" : leaders;
   if(compact && !tight)
      leaders_label = "Leaders";
   if(bx + tab_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_leaders", ASC_HudButtonLabelForWidth(leaders_label, tab_w), bx, btn_y, tab_w, btn_h, (g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS ? active_bg : nav_bg), (g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS ? active_border : nav_border), (g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += tab_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_leaders", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   string groups_label = tight ? "Groups" : groups;
   if(compact && !tight)
      groups_label = "Groups";
   if(bx + tab_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_sub_groups", ASC_HudButtonLabelForWidth(groups_label, tab_w), bx, btn_y, tab_w, btn_h, (g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS ? active_bg : nav_bg), (g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS ? active_border : nav_border), (g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += tab_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_sub_groups", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   string symbols_label = "Symbols";
   if(bx + tab_w <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_symbols", ASC_HudButtonLabelForWidth(symbols_label, tab_w), bx, btn_y, tab_w, btn_h, (g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS ? active_bg : nav_bg), (g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS ? active_border : nav_border), (g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += tab_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_symbols", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   if(symbol_context && (bx + symbol_w) <= nav_right)
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_symbol",
                          ASC_HudButtonLabelForWidth(g_asc_hud.selected_symbol, symbol_w),
                          bx,
                          btn_y,
                          symbol_w,
                          btn_h,
                          (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW ? active_bg : nav_bg),
                          (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW ? active_border : nav_border),
                          (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW ? ASC_HudThemeTextPrimary() : nav_text_muted));
      bx += symbol_w + tab_gap;
     }
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_symbol", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   if(show_detail_nav && (bx + detail_w) <= nav_right)
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_details",
                          ASC_HudButtonLabelForWidth(ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section), detail_w),
                          bx,
                          btn_y,
                          detail_w,
                          btn_h,
                          active_bg,
                          active_border,
                          ASC_HudThemeTextPrimary());
   else
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_details", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudRenderBreadcrumbZone(const int x,const int y,const int w)
  {
   bool tight = (w < 880);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "crumb_zone", x, y, w, ASC_HUD_BREADCRUMB_H, ASC_HudThemeBgLayer2(), ASC_HudThemeBorderBase());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "crumb_zone", x, y, w, ASC_HUD_BREADCRUMB_H, ASC_HudThemeBgRoot());

   int row_pad_x = (tight ? 8 : 10);
   int row_h = 20;
   int row_y = y + ((ASC_HUD_BREADCRUMB_H - row_h) / 2);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "crumb_focus", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "crumb_hint", "", 0, 0, 8, clrBlack);

   int crumb_x = x + row_pad_x;
   int crumb_w = (x + w) - crumb_x - row_pad_x;
   if(crumb_w < 84)
      crumb_w = 84;
   string crumb = ASC_HudBreadcrumb();
   int crumb_chars = ASC_HudCharsForWidth(crumb_w, 9);
   int trail_chars = crumb_chars - 2;
   if(trail_chars < 10)
      trail_chars = 10;
   string trail_text = ASC_HudCompactTrailText(crumb, trail_chars);
   string page_name = ASC_HudPageName(g_asc_hud.page);
   if(StringLen(trail_text) > StringLen(page_name) + 3)
     {
      int suffix_start = (int)StringLen(trail_text) - (int)StringLen(page_name);
      if(suffix_start > 2 && StringSubstr(trail_text, suffix_start, StringLen(page_name)) == page_name)
         trail_text = ASC_HudTrim(StringSubstr(trail_text, 0, suffix_start - 2));
     }
   string breadcrumb_text = (StringLen(trail_text) > 0 ? trail_text : page_name);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "crumb_title", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabelAutoFit(ASC_HUD_PREFIX + "breadcrumb",
                             breadcrumb_text,
                             crumb_x,
                             row_y + 4,
                             9,
                             8,
                             ASC_HudThemeTextSecondary(),
                             crumb_w);
  }

void ASC_HudRenderQuickActionsZone(const int x,const int y,const int w)
  {
   bool show_symbol_actions = (StringLen(g_asc_hud.selected_symbol) > 0)
                              && (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
   bool show_higher_page_refresh = ASC_HudPageShowsHigherRefreshControl(g_asc_hud.page);
   if(!show_symbol_actions && !show_higher_page_refresh)
     {
      ASC_HudHideSymbolQuickActionControls();
      return;
     }

   ASC_HudTrackFamilyVisibility(g_asc_hud.proof_quick_actions_visible, true, g_asc_hud.proof_quick_actions_visibility_changes);

   string deep_block_reason;
   bool deep_enabled = ASC_HudDeepActionContextReady(deep_block_reason);

   ASC_HudEnsureRect(ASC_HUD_PREFIX + "quick_zone", x, y, w, ASC_HUD_ACTION_H, ASC_HudThemeBgLayer3(), ASC_HudThemeBorderBase());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "quick_zone", x, y, w, ASC_HUD_ACTION_H, ASC_HudThemeBgRoot());
   int left_label_w = (w < 980 ? 126 : 142);
   if(left_label_w > (w / 3))
      left_label_w = w / 3;
   if(left_label_w < 96)
      left_label_w = 96;
   int left_label_x = x + 10;
   int left_label_y = y + 8;
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "quick_title", show_symbol_actions ? "Symbol controls" : "Page controls", left_label_x, left_label_y, 9, ASC_HudThemeTextSecondary(), left_label_w);
   int divider_x = left_label_x + left_label_w + 6;
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "quick_divider", divider_x, y + 6, 1, ASC_HUD_ACTION_H - 12, ASC_HudThemeBorderBase(), ASC_HudThemeBorderBase());

   int left = divider_x + 8;
   int right_pad = 10;
   int gap = (w < 980 ? 4 : 8);
   int btn_h = 18;
   int btn_y = y + ((ASC_HUD_ACTION_H - btn_h) / 2);
   int right = x + w - right_pad;
   int available = right - left;

   if(show_higher_page_refresh && !show_symbol_actions)
     {
      color bg; color border; color text;
      ASC_HudThemeActionButton(true, false, bg, border, text);
      if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
        {
         int btn_w = (available - gap) / 2;
         if(btn_w > 180)
            btn_w = 180;
         if(btn_w < 104)
            btn_w = 104;
         int batch_btn_w = btn_w;
         int refresh_btn_x = right - (batch_btn_w + gap + btn_w);
         int batch_btn_x = right - batch_btn_w;
         ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_page_refresh",
                             ASC_HudButtonLabelForWidth(ASC_HudHigherPageRefreshLabel(g_asc_hud.page), btn_w),
                             refresh_btn_x, btn_y, btn_w, btn_h, bg, border, text);
         bool batch_enabled = (!g_asc_hud.deep_trigger_pending);
         ASC_HudThemeActionButton(batch_enabled, true, bg, border, text);
         ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_top10_run_full",
                             ASC_HudButtonLabelForWidth("Run Full Top 10", batch_btn_w),
                             batch_btn_x, btn_y, batch_btn_w, btn_h, bg, border, text);
        }
      else
        {
         int btn_w = available;
         if(btn_w > 196)
            btn_w = 196;
         if(btn_w < 110)
            btn_w = 110;
         int btn_x = right - btn_w;
         ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_page_refresh",
                             ASC_HudButtonLabelForWidth(ASC_HudHigherPageRefreshLabel(g_asc_hud.page), btn_w),
                             btn_x, btn_y, btn_w, btn_h, bg, border, text);
         ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_top10_run_full", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
        }
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_deep", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_aurora", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_semi", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_full", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_sync", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      return;
     }

   int min_btn_w = (w < 980 ? 70 : 86);
   if(available < ((min_btn_w * 3) + (gap * 2)))
     {
      gap = 4;
      min_btn_w = 62;
     }
   int btn_w = (available - (gap * 2)) / 3;
   if(btn_w < min_btn_w)
      btn_w = min_btn_w;

   int btn_sel_x = left;
   int btn_short_x = btn_sel_x + btn_w + gap;
   int btn_full_x = btn_short_x + btn_w + gap;
   if((btn_full_x + btn_w) > right)
     {
      btn_w = (right - left - (gap * 2)) / 3;
      if(btn_w < 58)
         btn_w = 58;
      btn_short_x = btn_sel_x + btn_w + gap;
      btn_full_x = btn_short_x + btn_w + gap;
   }

   color bg; color border; color text;
   ASC_HudThemeActionButton(true, false, bg, border, text);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_aurora",
                       ASC_HudButtonLabelForWidth("Selection", btn_w),
                       btn_sel_x, btn_y, btn_w, btn_h, bg, border, text);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_sync",
                       ASC_HudButtonLabelForWidth("Shortlist", btn_w),
                       btn_short_x, btn_y, btn_w, btn_h, ASC_HudThemeBgPanelAlt(), ASC_HudThemeAccentSecondary(), ASC_HudThemeTextPrimary());

   bool full_refresh_mode = (g_asc_hud.deep_trigger_pending
                             && StringLen(g_asc_hud.selected_symbol) > 0
                             && g_asc_hud.deep_trigger_symbol == g_asc_hud.selected_symbol);
   string full_label = full_refresh_mode ? "Refresh Full" : "Run Full";
   ASC_HudThemeActionButton(deep_enabled, true, bg, border, text);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_deep",
                       ASC_HudButtonLabelForWidth(full_label, btn_w),
                       btn_full_x, btn_y, btn_w, btn_h, bg, border, text);

   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_page_refresh", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_top10_run_full", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);

   // Retire legacy symbol action buttons so the top row stays deliberate and stable.
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_semi", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_full", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudRenderCard(const string id,const string title,const string line1,const string line2,const string line3,
                       const int x,const int y,const int w,const int h,const color accent)
  {
   bool overview_card = (id == "hero" || StringFind(id, "ov_") == 0);
   bool hero_card = (id == "hero");
   bool symbol_card = (StringFind(id, "sym_") == 0);
   bool compact_w = (w < 420);
   bool compact_h = (h < 108);
   bool ultra_compact = (w < 360 || h < 92);
   int pad_left = (ultra_compact ? 8 : (compact_w ? 9 : 12));
   int pad_right = pad_left + (overview_card ? (ultra_compact ? 2 : (compact_w ? 3 : 6)) : (symbol_card ? (ultra_compact ? 3 : (compact_w ? 5 : 8)) : (ultra_compact ? 4 : (compact_w ? 6 : 10))));
   int text_w = w - pad_left - pad_right;
   if(text_w < 72)
      text_w = 72;
   int title_size = (ultra_compact ? 10 : (compact_w ? 11 : (hero_card ? 13 : (symbol_card ? 12 : 12))));
   int l1_size = (ultra_compact ? 7 : (compact_w ? (overview_card ? 7 : (symbol_card ? 8 : 9)) : (hero_card ? 9 : (overview_card ? 8 : (symbol_card ? 8 : 10)))));
   int l2_size = (ultra_compact ? 7 : (compact_w ? 7 : (overview_card ? 8 : (symbol_card ? 8 : 9))));
   int l3_size = (ultra_compact ? 7 : (compact_w ? 7 : (overview_card ? 8 : (symbol_card ? 7 : 9))));
   int top_padding = (hero_card ? (ultra_compact ? 8 : 10) : (symbol_card ? (ultra_compact ? 8 : 10) : (overview_card ? (ultra_compact ? 7 : 8) : (ultra_compact ? 8 : 10))));
   int inner_h = h - (hero_card ? (ultra_compact ? 14 : 16) : (symbol_card ? (ultra_compact ? 12 : 14) : (overview_card ? (ultra_compact ? 10 : 12) : (ultra_compact ? 14 : 20))));
   if(inner_h < 52)
      inner_h = 52;
   int row_step = inner_h / 4;
   int min_row_step = (ultra_compact ? 12 : (compact_h ? 13 : (hero_card ? 16 : (symbol_card ? 15 : (overview_card ? 14 : 16)))));
   if(row_step < min_row_step)
      row_step = min_row_step;
   int title_y = y + top_padding;
   int first_line_y = title_y + row_step;

   ASC_HudEnsureRect(ASC_HUD_PREFIX + id + "_panel", x, y, w, h, ASC_HudThemeBgCard(), accent);
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + id + "_panel", x, y, w, h, ASC_HudThemeBgRoot());
   ASC_HudEnsureRect(ASC_HUD_PREFIX + id + "_bar", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + id + "_accent", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabelAutoFit(ASC_HUD_PREFIX + id + "_title", title, x + pad_left, title_y, title_size, 9, ASC_HudThemeTextPrimary(), text_w);
   ASC_HudEnsureLabelAutoFit(ASC_HUD_PREFIX + id + "_l1", line1, x + pad_left, first_line_y, l1_size, 8, ASC_HudThemeTextPrimary(), text_w);
   ASC_HudEnsureLabelAutoFit(ASC_HUD_PREFIX + id + "_l2", line2, x + pad_left, first_line_y + row_step, l2_size, 7, ASC_HudThemeTextSecondary(), text_w);
   ASC_HudEnsureLabelAutoFit(ASC_HUD_PREFIX + id + "_l3", line3, x + pad_left, first_line_y + (row_step * 2), l3_size, 7, ASC_HudThemeTextMuted(), text_w);
  }

void ASC_HudHideCard(const string id)
  {
   ASC_HudEnsureRect(ASC_HUD_PREFIX + id + "_panel", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + id + "_bar", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + id + "_accent", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + id + "_title", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + id + "_l1", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + id + "_l2", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + id + "_l3", "", 0, 0, 8, clrBlack);
  }

void ASC_HudRenderScopeChip(const string id,
                            const string text,
                            const int x,
                            const int y,
                            const int w,
                            const color border,
                            const color text_color,
                            const int h=18,
                            const int font_size=8)
  {
   color chip_bg; color chip_border; color chip_text;
   ASC_HudThemeSemanticChip(text, false, chip_bg, chip_border, chip_text);
   if(border == ASC_HudThemeBorderWarning())
      chip_border = border;
   if(text_color == ASC_HudThemeTextPrimary())
      chip_text = text_color;
   ASC_HudEnsureRect(ASC_HUD_PREFIX + id, x, y, w, h, chip_bg, chip_border);
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + id + "_t", text, x + 6, y + ((h - font_size) / 2), font_size, chip_text, w - 10);
  }

void ASC_HudHideSymbolsScopeCard()
  {
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_card", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_divider", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_title", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_subtitle", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_path", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_meta", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_chip_4", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_chip_1_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_chip_2_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_chip_3_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_chip_4_t", "", 0, 0, 8, clrBlack);
  }

void ASC_HudRenderSymbolsScopeCard(const int x,const int y,const int w,const int h)
  {
   ASC_HudSubBucketRow selected_sub = ASC_HudSelectedSubBucketRow();
   string symbols_main_bucket_name = ASC_HudMainBucketName(g_asc_hud.selected_bucket_id);
   string symbols_sub_bucket_name = ASC_HudSubBucketDisplayName(symbols_main_bucket_name, selected_sub.name);
   bool stock_bucket = ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id);
   bool leaders_scope = (g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS);
   string scope_title = leaders_scope ? symbols_main_bucket_name : symbols_sub_bucket_name;
   string scope_subtitle = leaders_scope ? "Main-bucket leaders (top five)" : "Group Symbols Scope";
   string scope_path = leaders_scope
                       ? ("Helper: read rank first, then freshness and why-here.")
                       : ("Scope: " + ASC_HudSubsetScopeLine());
   if(!leaders_scope && stock_bucket)
     {
      string stock_scope = ASC_HudBrowseNodePath(g_asc_hud.selected_sub_bucket_key);
      if(StringLen(stock_scope) > 0)
        {
         scope_title = selected_sub.name;
         scope_subtitle = "Stock Industry Symbols Scope";
         scope_path = "Scope: " + symbols_main_bucket_name + " / " + stock_scope;
        }
     }
   string scope_visible_chip = (g_asc_hud.list_total_items > 0
                                ? StringFormat("Visible %d-%d", g_asc_hud.list_range_start, g_asc_hud.list_range_end)
                                : "Visible 0-0");
   ASC_HudScopeRankingStats ranking_stats;
   ASC_HudBuildScopeRankingStats(g_asc_hud.selected_bucket_id, (leaders_scope ? "" : g_asc_hud.selected_sub_bucket_key), ranking_stats);
   string ranking_line = (ranking_stats.ranked_available
                          ? StringFormat("Promoted %d | Ranked %d | Top #%d", ranking_stats.promoted_count, ranking_stats.ranked_count, ranking_stats.top_rank)
                          : StringFormat("Promoted %d | Ranked %d | Top rank pending", ranking_stats.promoted_count, ranking_stats.ranked_count));

   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_card", x, y, w, h, ASC_HudThemeBgCard(), ASC_HudThemeAccentCardA());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "sym_scope_card", x, y, w, h, ASC_HudThemeBgRoot());
   int title_y = y + 9;
   int subtitle_y = y + 29;
   int helper_y = y + 50;
   int divider_y = y + 43;
   if(!leaders_scope)
     {
      helper_y = y + 58;
      divider_y = y + 52;
     }
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope_divider", x + 10, divider_y, w - 20, 1, ASC_HudThemeBorderBase(), ASC_HudThemeBorderBase());
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "sym_scope_title", scope_title, x + 10, title_y, (leaders_scope ? 13 : 12), ASC_HudThemeTextPrimary(), w - 20);
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "sym_scope_subtitle", scope_subtitle, x + 10, subtitle_y, 9, ASC_HudThemeAccentSecondary(), w - 20);
   ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "sym_scope_path", scope_path, x + 10, helper_y, 9, ASC_HudThemeTextSecondary(), w - 20);
   if(leaders_scope)
      ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_meta", "", 0, 0, 8, clrBlack);
   else
      ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "sym_scope_meta", ranking_line, x + 10, y + 74, 8, ASC_HudThemeTextMuted(), w - 20);

   int chip_gap = (leaders_scope ? 10 : 8);
   int chip_y = y + h - (leaders_scope ? 28 : 22);
   int chip_w = (w - 20 - (chip_gap * 3)) / 4;
   if(chip_w < 70)
      chip_w = 70;
   if(leaders_scope)
     {
      int leaders_visible = 0;
      for(int li = 0; li < ArraySize(g_asc_hud.leader_row_indices); li++)
        {
         int shortlist_idx = g_asc_hud.leader_row_indices[li];
         if(shortlist_idx < 0 || shortlist_idx >= ArraySize(g_asc_hud_shortlist_rows))
            continue;
         int layer1_index = -1;
         ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(g_asc_hud_shortlist_rows[shortlist_idx], layer1_index);
         if(!ASC_HudLeaderRowStateIsVisible(visibility_state))
            continue;
         leaders_visible++;
        }
      ASC_HudRenderScopeChip("sym_scope_chip_1", "Leader rows " + IntegerToString(leaders_visible), x + 10, chip_y, chip_w, ASC_HudThemeBorderBase(), ASC_HudThemeTextSecondary(), 22, 9);
      ASC_HudRenderScopeChip("sym_scope_chip_2", "Promoted " + IntegerToString(ranking_stats.promoted_count), x + 10 + chip_w + chip_gap, chip_y, chip_w, ASC_HudThemeBorderEdge(), ASC_HudThemeTextPrimary(), 22, 9);
      ASC_HudRenderScopeChip("sym_scope_chip_3", "Ranked " + IntegerToString(ranking_stats.ranked_count), x + 10 + ((chip_w + chip_gap) * 2), chip_y, chip_w, ASC_HudThemeAccentSecondary(), ASC_HudThemeAccentSecondary(), 22, 9);
      ASC_HudRenderScopeChip("sym_scope_chip_4", scope_visible_chip, x + 10 + ((chip_w + chip_gap) * 3), chip_y, chip_w, ASC_HudThemeAccentPrimary(), ASC_HudThemeTextPrimary(), 22, 9);
     }
   else
     {
      ASC_HudRenderScopeChip("sym_scope_chip_1", "Universe " + IntegerToString(selected_sub.total), x + 10, chip_y, chip_w, ASC_HudThemeBorderBase(), ASC_HudThemeTextSecondary());
      ASC_HudRenderScopeChip("sym_scope_chip_2", "Open " + IntegerToString(selected_sub.open_count), x + 10 + chip_w + chip_gap, chip_y, chip_w, ASC_HudThemeBorderEdge(), ASC_HudThemeTextPrimary());
      ASC_HudRenderScopeChip("sym_scope_chip_3", "Ready " + IntegerToString(selected_sub.eligible_count), x + 10 + ((chip_w + chip_gap) * 2), chip_y, chip_w, ASC_HudThemeAccentSecondary(), ASC_HudThemeAccentSecondary());
      ASC_HudRenderScopeChip("sym_scope_chip_4", scope_visible_chip, x + 10 + ((chip_w + chip_gap) * 3), chip_y, chip_w, ASC_HudThemeAccentPrimary(), ASC_HudThemeTextPrimary());
     }
  }

void ASC_HudCollapseListRowSlot(const int row_index)
  {
   if(row_index < 0 || row_index >= ASC_HUD_ROW_SLOTS)
      return;

   string id = ASC_HUD_PREFIX + "row_" + IntegerToString(row_index);
   ASC_HudEnsureRect(id + "_panel", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_edge", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_top", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_zone", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_action_zone", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(id + "_action_div", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(id + "_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_s", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_d", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_m", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_m2", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_c1", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_c2", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureButton(id + "_btn", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudPrepareListRowShells()
  {
   if(g_asc_hud.list_row_shell_prepared)
      return;

   for(int r = 0; r < ASC_HUD_ROW_SLOTS; r++)
      ASC_HudCollapseListRowSlot(r);

   g_asc_hud.list_row_shell_prepared = true;
   g_asc_hud.list_rows_rendered = 0;
   g_asc_hud.list_rows_render_signature = "";
  }

void ASC_HudHideOverviewPanels()
  {
   if(g_asc_hud.overview_panels_hidden)
      return;

   ASC_HudHideCard("hero");
   ASC_HudHideCard("ov_runtime");
   ASC_HudHideCard("ov_universe");
   ASC_HudHideCard("ov_pipeline");
   ASC_HudHideCard("ov_attention");
   ASC_HudHideCard("ov_band_a");
   ASC_HudHideCard("ov_band_b");
   ASC_HudHideCard("ov_band_c");
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "ov_clock_panel", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "ov_clock_title", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "ov_clock_text", "", 0, 0, 8, clrBlack);
   g_asc_hud.overview_panels_hidden = true;
  }

void ASC_HudHideListPanels()
  {
   if(g_asc_hud.list_panels_hidden && g_asc_hud.symbols_scope_hidden && g_asc_hud.list_rows_rendered <= 0)
      return;

   ASC_HudHideCard("list_head");
   ASC_HudHideSymbolsScopeCard();

   int rows_to_collapse = g_asc_hud.list_rows_rendered;
   if(rows_to_collapse <= 0 && !g_asc_hud.list_row_shell_prepared)
      rows_to_collapse = ASC_HUD_ROW_SLOTS;
   if(rows_to_collapse > ASC_HUD_ROW_SLOTS)
      rows_to_collapse = ASC_HUD_ROW_SLOTS;

   for(int r = 0; r < rows_to_collapse; r++)
      ASC_HudCollapseListRowSlot(r);

   g_asc_hud.list_rows_rendered = 0;
   g_asc_hud.list_rows_render_signature = "";
   g_asc_hud.list_panels_hidden = true;
   g_asc_hud.symbols_scope_hidden = true;
  }

void ASC_HudHideSymbolOverviewPanels()
  {
   if(g_asc_hud.symbol_overview_panels_hidden)
      return;

   ASC_HudHideCard("sym_none");
   ASC_HudHideCard("sym_hero");
   ASC_HudHideCard("sym_identity");
   ASC_HudHideCard("sym_market");
   ASC_HudHideCard("sym_tick");
   ASC_HudHideCard("sym_pub");
   g_asc_hud.symbol_overview_panels_hidden = true;
  }

void ASC_HudHideStatPanels()
  {
   if(g_asc_hud.stat_panels_hidden)
      return;

   ASC_HudHideCard("stat_none");
   ASC_HudHideCard("stat_hero");
   ASC_HudHideCard("stat_help");
   ASC_HudHideCard("stat_block_a");
   ASC_HudHideCard("stat_block_b");
   ASC_HudHideCard("stat_block_c");
   ASC_HudHideCard("stat_block_d");
   g_asc_hud.stat_panels_hidden = true;
  }

void ASC_HudHideFooterPagerControls()
  {
   if(!g_asc_hud.proof_footer_pager_visible)
      return;

   ASC_HudTrackFamilyVisibility(g_asc_hud.proof_footer_pager_visible, false, g_asc_hud.proof_footer_pager_visibility_changes);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "status_strip", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "status_bar", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "pager_box", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "status_text", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_lbl", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_page", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_show", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "pager_prev", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "pager_next", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudHideSymbolQuickActionControls()
  {
   if(!g_asc_hud.proof_quick_actions_visible)
      return;

   ASC_HudTrackFamilyVisibility(g_asc_hud.proof_quick_actions_visible, false, g_asc_hud.proof_quick_actions_visibility_changes);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "quick_zone", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "quick_divider", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "quick_title", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_deep", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_aurora", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_semi", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_full", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "btn_sync", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_page_refresh", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "act_top10_run_full", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudHideSymbolLowerSectionControls()
  {
   if(!g_asc_hud.proof_symbol_lower_visible)
      return;

   ASC_HudTrackFamilyVisibility(g_asc_hud.proof_symbol_lower_visible, false, g_asc_hud.proof_symbol_lower_visibility_changes);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "stat_scope", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_actions", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_actions_lbl", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_1", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_2", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_3", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_4", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_5", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_6", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_7", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_8", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_1", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_2", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_3", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_4", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_5", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudHideSymbolSharedControls()
  {
   if(g_asc_hud.symbol_shared_hidden)
      return;

   ASC_HudHideSymbolQuickActionControls();
   ASC_HudHideSymbolLowerSectionControls();
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "action_strip", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "action_strip_edge", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "action_strip_lbl", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "action_strip_meta", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_pulse_panel", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_pulse_text", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_4", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_1_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_2_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_3_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_4_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_text", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_hint", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_scope_btn", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   g_asc_hud.symbol_shared_hidden = true;
  }

ASC_HudRenderScope ASC_HudRenderScopeForPage(const ASC_HudPage page)
  {
   if(page == ASC_HUD_PAGE_OVERVIEW)
      return ASC_HUD_SCOPE_OVERVIEW;
   if(page == ASC_HUD_PAGE_MAIN_BUCKETS
      || page == ASC_HUD_PAGE_BUCKET_LEADERS
      || page == ASC_HUD_PAGE_SUB_GROUPS
      || page == ASC_HUD_PAGE_SYMBOLS
      || page == ASC_HUD_PAGE_GLOBAL_TOP10)
      return ASC_HUD_SCOPE_LIST;
   if(page == ASC_HUD_PAGE_SYMBOL_OVERVIEW)
      return ASC_HUD_SCOPE_SYMBOL_OVERVIEW;
   if(page == ASC_HUD_PAGE_ASPECT_DETAIL)
      return ASC_HUD_SCOPE_STAT_DETAIL;
   return ASC_HUD_SCOPE_NONE;
  }

void ASC_HudResetPanelsForScopeChange(const ASC_HudRenderScope from_scope,const ASC_HudRenderScope to_scope)
  {
   if(from_scope == to_scope)
     {
      if(to_scope == ASC_HUD_SCOPE_LIST)
         ASC_HudHideListPanels();
      else if(to_scope == ASC_HUD_SCOPE_SYMBOL_OVERVIEW)
         ASC_HudHideSymbolOverviewPanels();
      else if(to_scope == ASC_HUD_SCOPE_STAT_DETAIL)
         ASC_HudHideStatPanels();
      return;
     }

   g_asc_hud.proof_scope_transition_count++;
   if(to_scope == ASC_HUD_SCOPE_LIST)
      g_asc_hud.proof_scope_entry_list_count++;
   if(to_scope == ASC_HUD_SCOPE_SYMBOL_OVERVIEW || to_scope == ASC_HUD_SCOPE_STAT_DETAIL)
      g_asc_hud.proof_scope_entry_symbol_count++;

   if(from_scope == ASC_HUD_SCOPE_OVERVIEW)
      ASC_HudHideOverviewPanels();
   else if(from_scope == ASC_HUD_SCOPE_LIST)
      ASC_HudHideListPanels();
   else if(from_scope == ASC_HUD_SCOPE_SYMBOL_OVERVIEW)
     {
      ASC_HudHideSymbolOverviewPanels();
      if(to_scope != ASC_HUD_SCOPE_STAT_DETAIL)
         ASC_HudHideSymbolSharedControls();
     }
   else if(from_scope == ASC_HUD_SCOPE_STAT_DETAIL)
     {
      ASC_HudHideStatPanels();
      if(to_scope != ASC_HUD_SCOPE_SYMBOL_OVERVIEW)
         ASC_HudHideSymbolSharedControls();
     }

   if(to_scope == ASC_HUD_SCOPE_OVERVIEW)
     {
      ASC_HudHideListPanels();
      ASC_HudHideSymbolOverviewPanels();
      ASC_HudHideStatPanels();
      ASC_HudHideSymbolSharedControls();
      ASC_HudHideFooterPagerControls();
     }
   else if(to_scope == ASC_HUD_SCOPE_LIST)
     {
      ASC_HudHideOverviewPanels();
      ASC_HudHideSymbolOverviewPanels();
      ASC_HudHideStatPanels();
      ASC_HudHideSymbolSharedControls();
      ASC_HudHideFooterPagerControls();
     }
   else if(to_scope == ASC_HUD_SCOPE_SYMBOL_OVERVIEW)
     {
      ASC_HudHideOverviewPanels();
      ASC_HudHideListPanels();
      ASC_HudHideStatPanels();
      ASC_HudHideFooterPagerControls();
     }
   else if(to_scope == ASC_HUD_SCOPE_STAT_DETAIL)
     {
      ASC_HudHideOverviewPanels();
      ASC_HudHideListPanels();
      ASC_HudHideSymbolOverviewPanels();
      ASC_HudHideFooterPagerControls();
     }
  }

bool ASC_HudNeedsPanelReset()
  {
   ASC_HudRenderScope previous_scope = ASC_HudRenderScopeForPage(g_asc_hud.last_rendered_page);
   ASC_HudRenderScope current_scope = ASC_HudRenderScopeForPage(g_asc_hud.page);
   if(previous_scope != current_scope)
      return true;

   return false;
  }



ASC_HudSubBucketRow ASC_HudSelectedSubBucketRow()
  {
   ASC_HudSubBucketRow row;
   row.key = g_asc_hud.selected_sub_bucket_key;
   row.bucket_id = g_asc_hud.selected_bucket_id;
   row.source = "runtime";
   row.name = "Active scope";
   row.sub_bucket_id = "";

   for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
     {
      if(g_asc_hud.sub_buckets[i].key == g_asc_hud.selected_sub_bucket_key)
         return g_asc_hud.sub_buckets[i];
     }

   int browse_slot = ASC_HudFindBrowseNode(g_asc_hud.selected_sub_bucket_key);
   if(browse_slot >= 0)
     {
      row.source = g_asc_hud.browse_nodes[browse_slot].source;
      row.name = g_asc_hud.browse_nodes[browse_slot].label;
      row.sub_bucket_id = g_asc_hud.browse_nodes[browse_slot].id;
      row.total = g_asc_hud.browse_nodes[browse_slot].total;
      row.open_count = g_asc_hud.browse_nodes[browse_slot].open_count;
      row.eligible_count = g_asc_hud.browse_nodes[browse_slot].eligible_count;
      return row;
     }

   int divider = StringFind(g_asc_hud.selected_sub_bucket_key, "|");
   if(divider >= 0 && divider + 1 < StringLen(g_asc_hud.selected_sub_bucket_key))
     {
      row.sub_bucket_id = StringSubstr(g_asc_hud.selected_sub_bucket_key, divider + 1);
      string human_sub = ASC_HudHumanizeIdentifier(row.sub_bucket_id);
      if(StringLen(human_sub) > 0)
         row.name = human_sub;
     }

   return row;
  }

bool ASC_HudSelectedSymbolMatches(const ASC_Layer1SymbolState &candidate,const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return false;
   if(candidate.symbol == symbol)
      return true;
   if(candidate.identity.normalized_symbol == symbol)
      return true;
   if(candidate.identity.canonical_symbol == symbol)
      return true;
   if(candidate.classification.canonical_symbol == symbol)
      return true;
   return false;
  }

bool ASC_HudFindSelectedSymbol(ASC_Layer1SymbolState &selected)
  {
   int layer1_index = ASC_HudResolveSelectedSymbolLayer1Index();
   if(layer1_index < 0)
      return false;
   return ASC_HudMaterializeSymbolState(layer1_index, selected);
  }

int ASC_HudResolveSelectedSymbolLayer1Index()
  {
   if(StringLen(g_asc_hud.selected_symbol) <= 0)
     {
      ASC_HudInvalidateSelectedSymbolCache();
      return -1;
     }

   ulong structural_revision = ASC_Layer1StructuralRevision();
   int cached_index = g_asc_hud.selected_symbol_layer1_index;
   if(g_asc_hud.selected_symbol_layer1_revision == structural_revision
      && cached_index >= 0
      && cached_index < ASC_Layer1CachedSymbolCount())
     {
      ASC_Layer1SymbolState cached_state;
      if(ASC_HudMaterializeSymbolState(cached_index, cached_state)
         && ASC_HudSelectedSymbolMatches(cached_state, g_asc_hud.selected_symbol))
         return cached_index;
     }

   int resolved_index = -1;
   ASC_HudEnsureLayer1LookupCache();
   resolved_index = ASC_HudFindLookupIndex(g_asc_hud_layer1_lookup, ASC_HudNormalizeLookupKey(g_asc_hud.selected_symbol));

   bool resolved_matches = false;
   if(resolved_index >= 0)
     {
      ASC_Layer1SymbolState resolved_state;
      if(ASC_HudMaterializeSymbolState(resolved_index, resolved_state)
         && ASC_HudSelectedSymbolMatches(resolved_state, g_asc_hud.selected_symbol))
         resolved_matches = true;
      else
         resolved_index = -1;
     }

   if(resolved_index < 0)
     {
      for(int i = 0; i < ASC_Layer1CachedSymbolCount(); i++)
        {
         ASC_Layer1SymbolState candidate;
         if(!ASC_HudMaterializeSymbolState(i, candidate))
            continue;
         if(!ASC_HudSelectedSymbolMatches(candidate, g_asc_hud.selected_symbol))
            continue;
         resolved_index = i;
         resolved_matches = true;
         break;
        }
     }

   if(resolved_index >= 0 && resolved_matches)
     {
      g_asc_hud.selected_symbol_layer1_index = resolved_index;
      g_asc_hud.selected_symbol_layer1_revision = structural_revision;
      return resolved_index;
     }

   g_asc_hud.selected_symbol_layer1_index = -1;
   g_asc_hud.selected_symbol_layer1_revision = structural_revision;
   return -1;
  }

bool ASC_HudDeepAnalysisEnabled(string &blocked_reason)
  {
   blocked_reason = "";
   if(StringLen(g_asc_hud.selected_symbol) <= 0)
     {
      blocked_reason = "Action unavailable: symbol context is stale. Please sync.";
      return false;
     }

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
     {
      blocked_reason = "Action unavailable: evidence is missing for this symbol.";
      return false;
     }

   if(!g_asc_hud.has_summary)
     {
      blocked_reason = "Action unavailable: scanner is awaiting confirmation.";
      return false;
     }

   if(ASC_DeepEnabledTimeframeCount() <= 0)
      blocked_reason = "Action context: Full Analysis controls are unavailable right now; safe timeframe defaults will be used.";

   return true;
  }

bool ASC_HudDeepActionContextReady(string &blocked_reason)
  {
   blocked_reason = "";
   if(StringLen(g_asc_hud.selected_symbol) <= 0)
     {
      blocked_reason = "Action unavailable: symbol context is stale. Please sync.";
      return false;
     }

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
     {
      blocked_reason = "Action unavailable: selected symbol evidence is unavailable.";
      return false;
     }

   return true;
  }

bool ASC_HudEmitCurrentFocusFromDeepTrigger(ASC_RuntimeState &runtime,string &notice_text)
  {
   notice_text = "";
   if(StringLen(runtime.server_root) <= 0)
     {
      notice_text = "Action unavailable: runtime output root is not ready.";
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudEmitCurrentFocusFromDeepTrigger", "runtime",
                  "deep request rejected before queue: runtime output root unavailable");
      return false;
     }

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
     {
      notice_text = "Action unavailable: selected symbol evidence is unavailable.";
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudEmitCurrentFocusFromDeepTrigger", "runtime",
                  "deep request rejected before queue: selected symbol evidence unavailable");
      return false;
     }

   bool refresh_existing = false;
   if(runtime.deep_focus_trigger_pending)
     {
      if(runtime.deep_focus_trigger_symbol == selected.symbol)
         refresh_existing = true;
      else
        {
         notice_text = StringFormat("Action blocked: Full Analysis is already queued for %s. Wait for completion before arming another symbol.",
                                    runtime.deep_focus_trigger_symbol);
         ASC_LogInfo("ASC_HUD_Manager", "ASC_HudEmitCurrentFocusFromDeepTrigger", selected.symbol,
                     "deep request rejected before queue: another symbol trigger is pending");
         return false;
        }
     }

   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudEmitCurrentFocusFromDeepTrigger", selected.symbol,
               (refresh_existing
                ? "deep request refreshed from explicit action button"
                : "deep request created from explicit action button"));
   runtime.hud_selected_symbol = selected.symbol;
   runtime.hud_selected_symbol_observed_utc = TimeGMT();
   runtime.deep_focus_trigger_pending = true;
   runtime.deep_focus_trigger_symbol = selected.symbol;
   runtime.deep_focus_trigger_canonical_symbol = selected.classification.canonical_symbol;
   if(StringLen(runtime.deep_focus_trigger_canonical_symbol) <= 0)
      runtime.deep_focus_trigger_canonical_symbol = selected.identity.canonical_symbol;
   runtime.deep_focus_trigger_normalized_symbol = selected.identity.normalized_symbol;
   runtime.deep_focus_trigger_requested_utc = runtime.hud_selected_symbol_observed_utc;
   runtime.deep_trigger_request_count++;
   runtime.deep_focus_trigger_request_seq = runtime.deep_trigger_request_count;
   runtime.deep_focus_trigger_last_status = "queued";
   runtime.deep_focus_last_symbol = selected.symbol;
   runtime.deep_focus_last_reason = (refresh_existing
                                     ? StringFormat("refreshed from explicit HUD Full Analysis action | request_seq=%d", runtime.deep_focus_trigger_request_seq)
                                     : StringFormat("queued from explicit HUD Full Analysis action | request_seq=%d", runtime.deep_focus_trigger_request_seq));

   // HUD boundary law: this path queues runtime trigger ownership only.
   // HUD does not compose or publish deep payload content locally.
   g_asc_hud.deep_trigger_pending = true;
   g_asc_hud.deep_trigger_symbol = selected.symbol;
   g_asc_hud.deep_trigger_requested_utc = runtime.deep_focus_trigger_requested_utc;
   g_asc_hud.deep_trigger_last_status = "queued";
   g_asc_hud.deep_trigger_runtime_reason = runtime.deep_focus_last_reason;
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudEmitCurrentFocusFromDeepTrigger", selected.symbol,
               (refresh_existing
                ? "deep request refreshed and queued in runtime"
                : "deep request armed and queued in runtime"));
   string entitlement_reason = "";
   if(ASC_HudDeepAnalysisEnabled(entitlement_reason))
      notice_text = (refresh_existing
                     ? "Refresh Full Analysis queued again for the selected symbol. Current Focus and dossier will update when the refreshed trigger completes."
                     : "Run Full Analysis queued for selected symbol. Current Focus and dossier will update when trigger processing completes.");
   else
      notice_text = (refresh_existing
                     ? "Refresh Full Analysis queued again for the selected symbol. If entitlement fails, the trigger will return a lawful blocked reason: "
                     : "Run Full Analysis queued for selected symbol. If entitlement fails, the trigger will return a lawful blocked reason: ")
                    + entitlement_reason;
   return true;
  }

bool ASC_HudSyncRuntimeSelectedSymbol(ASC_RuntimeState &runtime,const bool emit_log)
  {
   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
      return false;

   bool changed = !ASC_HudSelectedSymbolMatches(selected, runtime.hud_selected_symbol);
   if(changed || runtime.hud_selected_symbol_observed_utc <= 0)
      runtime.hud_selected_symbol_observed_utc = TimeGMT();
   runtime.hud_selected_symbol = selected.symbol;

   if(emit_log)
     {
      string canonical_symbol = selected.classification.canonical_symbol;
      if(StringLen(canonical_symbol) <= 0)
         canonical_symbol = selected.identity.canonical_symbol;
      if(StringLen(canonical_symbol) <= 0)
         canonical_symbol = selected.identity.normalized_symbol;
      if(StringLen(canonical_symbol) <= 0)
         canonical_symbol = selected.symbol;
      string detail = StringFormat("selected symbol observed symbol=%s canonical=%s page=%s section=%s",
                                   selected.symbol,
                                   canonical_symbol,
                                   ASC_HudPageName(g_asc_hud.page),
                                   ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section));
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudSyncRuntimeSelectedSymbol", "runtime", detail);
     }
   return true;
  }

bool ASC_HudQueueViewedCurrentFocusSync(ASC_RuntimeState &runtime,const bool show_notice)
  {
   if(!ASC_HudSyncRuntimeSelectedSymbol(runtime, true))
      return false;

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
      return false;

   bool already_pending_for_selected = (runtime.current_focus_view_pending
                                     && runtime.current_focus_view_symbol == selected.symbol);

   runtime.current_focus_view_pending = true;
   runtime.current_focus_view_symbol = selected.symbol;
   runtime.current_focus_view_requested_utc = runtime.hud_selected_symbol_observed_utc;
   if(runtime.current_focus_view_requested_utc <= 0)
      runtime.current_focus_view_requested_utc = TimeGMT();
   runtime.current_focus_view_earliest_write_utc = 0;
   runtime.current_focus_last_status = "view_queued";
   runtime.current_focus_last_reason = (already_pending_for_selected
                                        ? "selected-symbol sync refreshed while the same selected symbol is already queued"
                                        : "selected-symbol sync queued from HUD selection context");
   runtime.selected_symbol_request_count++;
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudQueueViewedCurrentFocusSync", selected.symbol,
               (already_pending_for_selected
                ? "selected-symbol sync refreshed while already pending for selected symbol"
                : "selected-symbol sync queued from HUD context"));

   if(show_notice)
      ASC_HudSetNotice(already_pending_for_selected
                       ? "Current Focus sync refreshed for the selected symbol."
                       : "Current Focus sync queued for selected symbol dossier duplication.");

   return true;
  }

void ASC_HudRenderRows(const int x,const int y,const int w,const int row_h,const int list_body_h)
  {
   ASC_HudRebuildVisibleSlotMapsIfNeeded();
   int row_limit = ASC_HudVisibleRowLimit();
   int start = g_asc_hud.list_offset;
   int row_spacing = g_asc_hud.list_row_spacing_effective;
   if(row_spacing < 0)
      row_spacing = 0;
   int effective_row_h = row_h;
   if(g_asc_hud.list_row_h_effective > 0)
      effective_row_h = g_asc_hud.list_row_h_effective;
   if(effective_row_h < 24)
      effective_row_h = 24;

   int rows_available = MathMax(0, g_asc_hud.list_total_items - start);
   int rows_drawn = MathMin(row_limit, rows_available);
   int slot_span = effective_row_h + row_spacing;
   if(slot_span <= 0)
      slot_span = effective_row_h;

   int content_used_h = (rows_drawn * effective_row_h) + (MathMax(0, rows_drawn - 1) * row_spacing);
   int remainder_px = list_body_h - content_used_h;
   if(remainder_px < 0)
      remainder_px = 0;
   int y_start = y;

   if(!g_asc_hud.list_row_shell_prepared)
      ASC_HudPrepareListRowShells();
   int slots_to_process = (rows_drawn > 0 ? rows_drawn : 1);
   bool symbol_affects_row_render = (g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS
                                     || g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS
                                     || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10);
   string signature_selected_symbol = symbol_affects_row_render ? g_asc_hud.selected_symbol : "-";
   string rows_signature = StringFormat("page=%d|start=%d|slots=%d|rows=%d|x=%d|y=%d|w=%d|rh=%d|rs=%d|body=%d|sel=%s|bucket=%s|sub=%s|browse=%s|short=%s:%I64u:%d:%d|data=%u",
                                        (int)g_asc_hud.page,
                                        start,
                                        slots_to_process,
                                        rows_drawn,
                                        x,
                                        y_start,
                                        w,
                                        effective_row_h,
                                        row_spacing,
                                        list_body_h,
                                        signature_selected_symbol,
                                        g_asc_hud.selected_bucket_id,
                                        g_asc_hud.selected_sub_bucket_key,
                                        g_asc_hud.selected_browse_node_key,
                                        g_asc_hud.last_shortlist_source,
                                        g_asc_hud.last_shortlist_revision,
                                        (int)g_asc_hud.last_shortlist_pass_utc,
                                        g_asc_hud.last_shortlist_count,
                                        g_asc_hud.last_data_fingerprint);
   if(g_asc_hud.list_rows_render_signature == rows_signature
      && g_asc_hud.list_rows_rendered == slots_to_process)
     {
      int avoided_slots = (slots_to_process > 0 ? slots_to_process : 1);
      int avoided_fields = avoided_slots * 8;
      g_asc_hud.hud_row_text_cache_hit += avoided_slots;
      g_asc_hud.hud_text_build_skipped += avoided_fields;
      g_asc_hud.hud_label_text_reused += avoided_fields;
      g_asc_hud.hud_render_string_build_avoided += avoided_fields;
      g_asc_hud.proof_string_build_avoided += avoided_fields;
      g_asc_hud.list_panels_hidden = false;
      return;
     }
   int prior_rows_rendered = g_asc_hud.list_rows_rendered;
   for(int stale = slots_to_process; stale < prior_rows_rendered && stale < ASC_HUD_ROW_SLOTS; stale++)
      ASC_HudCollapseListRowSlot(stale);

   string default_button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);

   for(int r = 0; r < slots_to_process; r++)
     {
      string id = ASC_HUD_PREFIX + "row_" + IntegerToString(r);
      int yy = y_start + (r * slot_span);
      bool has_row = false;
      bool row_warning = false;
      bool row_focused = false;
      string title = "";
      string summary = "";
      string detail = "";
      string meta = "";
      string end_primary = "";
      string end_secondary = "";
      string center_primary = "";
      string center_secondary = "";
      string chip_a = "";
      string chip_b = "";
      string chip_c = "";
      string button_text = default_button_text;
      bool selected_row = false;
      bool symbol_promoted = false;
      bool symbol_shortlisted = false;
      bool symbol_pending = false;
      bool symbol_blocked = false;

      if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
        {
         int bucket_index = ASC_HudVisibleBucketBackingIndexAt(start + r);
         if(bucket_index >= 0 && bucket_index < ArraySize(g_asc_hud.buckets))
           {
            ASC_HudBucketRow b = g_asc_hud.buckets[bucket_index];
            int eligible_count = b.total - b.unresolved_count;
            if(eligible_count < 0)
               eligible_count = 0;
            string freshness = ASC_HudListFreshnessState(g_asc_hud.latest_summary.is_stale, g_asc_hud.latest_summary.is_degraded);
            ASC_HudScopeRankingStats ranking_stats;
            ASC_HudBuildScopeRankingStats(b.id, "", ranking_stats);
            int open_pct = ASC_HudBucketOpenPercent(b);
            string tradability = ASC_HudBucketTradabilityPosture(b, ranking_stats);
            double promoted_density = (b.total > 0 ? (100.0 * (double)ranking_stats.promoted_count / (double)b.total) : 0.0);
            title = b.name;
            summary = StringFormat("Open %d/%d (%d%%) • Tradability %s",
                                   b.open_count,
                                   b.total,
                                   open_pct,
                                   tradability);
            string why_now_line = ASC_HudBucketWhyNowLine(b, ranking_stats);
            detail = StringFormat("Promoted %d (%.1f%%) | Ranked %d | Freshness %s | %s",
                                  ranking_stats.promoted_count,
                                  promoted_density,
                                  ranking_stats.ranked_count,
                                  freshness,
                                  why_now_line);
            center_primary = StringFormat("Promoted %d (%.1f%%) | Ranked %d",
                                          ranking_stats.promoted_count,
                                          promoted_density,
                                          ranking_stats.ranked_count);
            center_secondary = "Why now: " + why_now_line;
            selected_row = (b.id == g_asc_hud.selected_bucket_id);
            meta = StringFormat("Ready %d | Needs Review %d | %s", eligible_count, b.unresolved_count, ASC_HudBucketMetaText(b));
            end_primary = StringFormat("Ready %d | Review %d", eligible_count, b.unresolved_count);
            if(g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded)
               end_secondary = StringFormat("Delayed | Promoted %d", ranking_stats.promoted_count);
            else if(selected_row)
               end_secondary = StringFormat("Focus | Promoted %d", ranking_stats.promoted_count);
            else
               end_secondary = StringFormat("Healthy | Promoted %d", ranking_stats.promoted_count);
            has_row = true;
            row_warning = g_asc_hud.latest_summary.is_degraded || g_asc_hud.latest_summary.is_stale || b.unresolved_count > 0 || b.total <= 0;
            row_focused = (g_asc_hud.selected_bucket_id == b.id);
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
        {
         int subgroup_index = -1;
         bool subgroup_uses_browse_nodes = false;
         if(ASC_HudVisibleSubgroupBackingIndexAt(start + r, subgroup_index, subgroup_uses_browse_nodes) && subgroup_uses_browse_nodes)
           {
            if(subgroup_index >= 0 && subgroup_index < ArraySize(g_asc_hud.browse_nodes))
              {
               ASC_HudBrowseNode node = g_asc_hud.browse_nodes[subgroup_index];
               bool has_children = ASC_HudBrowseNodeHasChildren(node.key);
               if(has_children)
                 {
                  if(node.tier == ASC_HUD_BROWSE_STOCK_FAMILY)
                     button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page, true, ASC_HUD_BROWSE_STOCK_FAMILY);
                  else if(node.tier == ASC_HUD_BROWSE_STOCK_SECTOR)
                     button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page, true, ASC_HUD_BROWSE_STOCK_SECTOR);
                  else
                     button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
                 }
               else
                  button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page, false, node.tier);
               int promoted_count = 0;
               int ranked_count = 0;
               string leader_symbol = "";
               ASC_HudSubgroupOpportunitySnapshot(g_asc_hud.selected_bucket_id,
                                                  node.key,
                                                  true,
                                                  promoted_count,
                                                  ranked_count,
                                                  leader_symbol);
               int open_pct = ASC_HudScopeOpenPercent(node.open_count, node.total);
               double promoted_density = (node.total > 0 ? (100.0 * (double)promoted_count / (double)node.total) : 0.0);
               string tradability = ASC_HudSubgroupTradabilityPosture(node.total, node.open_count, node.eligible_count, promoted_count);
               title = node.label;
               string freshness_text = ASC_HudListFreshnessState(g_asc_hud.latest_summary.is_stale, g_asc_hud.latest_summary.is_degraded);
               string leader_text = (StringLen(leader_symbol) > 0 ? leader_symbol : "pending");
               summary = StringFormat("Leader %s | Tradability %s",
                                      leader_text,
                                      tradability);
               detail = StringFormat("Open %d/%d (%d%%) | Promoted %d (%.1f%%) | Freshness %s",
                                     node.open_count,
                                     node.total,
                                     open_pct,
                                     promoted_count,
                                     promoted_density,
                                     freshness_text);
               center_primary = StringFormat("Open %d/%d (%d%%) | Promoted %d",
                                             node.open_count,
                                             node.total,
                                             open_pct,
                                             promoted_count);
               center_secondary = "Why now: " + ASC_HudSubgroupWhyNowLine(node.total, node.open_count, promoted_count, tradability, leader_symbol);
               selected_row = (node.key == g_asc_hud.selected_browse_node_key) || (node.key == g_asc_hud.selected_sub_bucket_key);
               string source_text = "Model";
               if(StringLen(node.source) > 0 && node.source == "runtime")
                  source_text = "Runtime feed";
               end_primary = StringFormat("Breadth %d | Ranked %d | Ready %d",
                                          node.total,
                                          ranked_count,
                                          node.eligible_count);
               end_secondary = StringFormat("%s | %s",
                                            source_text,
                                            has_children ? "Group view" : "Leaf view");
               meta = StringFormat("%s | Ranked %d | Ready %d | %s",
                                   source_text,
                                   ranked_count,
                                   node.eligible_count,
                                   has_children ? "Group view" : "Leaf view");
               if(g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded)
                 {
                  meta = meta + " | Refresh delayed";
                  end_secondary = end_secondary + " | Refresh delayed";
                 }
               else if(selected_row)
                 {
                  meta = meta + " | In focus";
                  end_secondary = end_secondary + " | In focus";
                 }
               has_row = true;
               row_warning = g_asc_hud.latest_summary.is_degraded || g_asc_hud.latest_summary.is_stale;
               row_focused = selected_row;
              }
           }
         else if(ASC_HudVisibleSubgroupBackingIndexAt(start + r, subgroup_index, subgroup_uses_browse_nodes) && !subgroup_uses_browse_nodes)
           {
            button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
            if(subgroup_index >= 0 && subgroup_index < ArraySize(g_asc_hud.sub_buckets))
              {
               ASC_HudSubBucketRow sub = g_asc_hud.sub_buckets[subgroup_index];
               string main_bucket_name = ASC_HudMainBucketName(g_asc_hud.selected_bucket_id);
               int promoted_count = 0;
               int ranked_count = 0;
               string leader_symbol = "";
               ASC_HudSubgroupOpportunitySnapshot(g_asc_hud.selected_bucket_id,
                                                  sub.key,
                                                  false,
                                                  promoted_count,
                                                  ranked_count,
                                                  leader_symbol);
               int open_pct = ASC_HudScopeOpenPercent(sub.open_count, sub.total);
               double promoted_density = (sub.total > 0 ? (100.0 * (double)promoted_count / (double)sub.total) : 0.0);
               string tradability = ASC_HudSubgroupTradabilityPosture(sub.total, sub.open_count, sub.eligible_count, promoted_count);
               title = StringFormat("%s", ASC_HudSubBucketDisplayName(main_bucket_name, sub.name));
               string freshness_text = ASC_HudListFreshnessState(g_asc_hud.latest_summary.is_stale, g_asc_hud.latest_summary.is_degraded);
               string leader_text = (StringLen(leader_symbol) > 0 ? leader_symbol : "pending");
               summary = StringFormat("Leader %s | Tradability %s",
                                      leader_text,
                                      tradability);
               detail = StringFormat("Open %d/%d (%d%%) | Promoted %d (%.1f%%) | Freshness %s",
                                     sub.open_count,
                                     sub.total,
                                     open_pct,
                                     promoted_count,
                                     promoted_density,
                                     freshness_text);
               center_primary = StringFormat("Open %d/%d (%d%%) | Promoted %d",
                                             sub.open_count,
                                             sub.total,
                                             open_pct,
                                             promoted_count);
               center_secondary = "Why now: " + ASC_HudSubgroupWhyNowLine(sub.total, sub.open_count, promoted_count, tradability, leader_symbol);
               selected_row = (sub.key == g_asc_hud.selected_sub_bucket_key);
               end_primary = StringFormat("Breadth %d | Ranked %d | Ready %d",
                                          sub.total,
                                          ranked_count,
                                          sub.eligible_count);
               end_secondary = "Scope lane";
               meta = StringFormat("Ranked %d | Ready %d | %s", ranked_count, sub.eligible_count, ASC_HudSubBucketMetaText(sub));
               if(g_asc_hud.latest_summary.is_stale || g_asc_hud.latest_summary.is_degraded)
                 {
                  meta = meta + " | Refresh delayed";
                  end_secondary = end_secondary + " | Refresh delayed";
                 }
               else if(selected_row)
                 {
                  meta = meta + " | In focus";
                  end_secondary = end_secondary + " | In focus";
                 }
               has_row = true;
               row_warning = g_asc_hud.latest_summary.is_degraded || g_asc_hud.latest_summary.is_stale;
               row_focused = (g_asc_hud.selected_sub_bucket_key == sub.key);
              }
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         ASC_ShortlistSymbolSummary shortlist_entry;
         int shortlist_total = 0;
         if(ASC_HudTryGetGlobalTop10EntryByVisibleIndex(start + r, shortlist_entry, shortlist_total))
           {
            ASC_Layer1SymbolState st = shortlist_entry.state;
            datetime now_utc = TimeGMT();
            bool is_ranked = (shortlist_entry.shortlisted && shortlist_entry.rank > 0);
            bool is_promoted = (is_ranked && shortlist_entry.rank <= 3);
            string membership_state = shortlist_entry.membership_state;
            string freshness = ASC_HudSymbolPosture(st, now_utc);
            title = shortlist_entry.symbol;
            if(StringLen(title) <= 0)
               title = st.symbol;
            summary = ASC_HudGlobalTop10PlacementLine(shortlist_entry, shortlist_total);
            detail = "Why this symbol: " + ASC_HudShortlistReason(shortlist_entry);
            selected_row = (title == g_asc_hud.selected_symbol || st.symbol == g_asc_hud.selected_symbol);
            center_primary = ASC_HudGlobalTop10PremiumScopeLine(shortlist_entry, shortlist_total);
            center_secondary = "Operator read: " + ASC_HudShortlistNextStepSummary(shortlist_entry);
            end_primary = "Carry lane | " + ASC_HudEffectiveMainBucketName(st);
            end_secondary = "Fresh " + freshness + " | Premium lane";
            meta = "Source shortlist+board carry | HUD display";
            has_row = true;
            row_focused = selected_row;
            symbol_promoted = is_promoted;
            symbol_shortlisted = !is_promoted;
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         int layer1_index = ASC_HudVisibleSymbolBackingIndexAt(start + r);
         if(layer1_index >= 0)
           {
            ASC_Layer1SymbolState st;
            if(ASC_HudMaterializeSymbolState(layer1_index, st))
              {
               datetime now_utc = TimeGMT();
               string effective_main_bucket_id = ASC_HudEffectiveMainBucketId(st);
               string bucket_name = ASC_HudEffectiveMainBucketName(st);
               string sub_name_raw = ASC_HudEffectiveSubBucketName(st, effective_main_bucket_id);
               string sub_name = ASC_HudSubBucketDisplayName(bucket_name, sub_name_raw);
               string next_check = (StringLen(st.next_check) > 0 ? st.next_check : "Pending");
               string freshness = ASC_HudSymbolPosture(st, now_utc);
               ASC_ShortlistSymbolSummary shortlist_entry;
               int shortlist_rank = 0;
               int shortlist_total = 0;
               ASC_SelectionFilterEvaluation filter;
               bool has_filter = false;
               bool has_filter_packet = false;
               double filter_score = 0.0;
               bool shortlist_found = ASC_HudResolveSelectionTruth(st,
                                                                   shortlist_entry,
                                                                   shortlist_rank,
                                                                   shortlist_total,
                                                                   filter,
                                                                   has_filter,
                                                                   has_filter_packet,
                                                                   filter_score);
               bool is_ranked = (shortlist_found && shortlist_entry.shortlisted && shortlist_rank > 0);
               string snapshot_posture = has_filter_packet ? "Snapshot Ready" : "Snapshot Pending";
               string shortlist_posture = "Awaiting shortlist";
               string priority_posture = "Monitoring";
               string membership_state = shortlist_found ? shortlist_entry.membership_state : "pending";
               bool spread_sane = (has_filter && filter.spread_is_sane);
               bool fresh_now = !(st.is_degraded || st.is_stale);
               if(membership_state == "shortlisted" && is_ranked && shortlist_rank <= 3)
                 {
                  priority_posture = "Promoted";
                  shortlist_posture = "Global rank #" + IntegerToString(shortlist_rank);
                  symbol_promoted = true;
                 }
               else if(membership_state == "shortlisted" && is_ranked)
                 {
                  priority_posture = "Shortlisted";
                  shortlist_posture = "Global rank #" + IntegerToString(shortlist_rank);
                  symbol_shortlisted = true;
                 }
               else if(membership_state == "reserve")
                 {
                  priority_posture = "Reserve";
                  shortlist_posture = "Reserve";
                 }
               else if(membership_state == "pending")
                 {
                  priority_posture = "Pending Checks";
                  shortlist_posture = "Awaiting checks";
                  symbol_pending = true;
                 }
               else if(shortlist_found && (membership_state == "blocked" || membership_state == "invalid"))
                 {
                  priority_posture = "Blocked";
                  shortlist_posture = ASC_ArtifactHumanizeLabel(membership_state);
                  symbol_blocked = true;
                 }
               else if(has_filter)
                 {
                  priority_posture = "Blocked";
                  shortlist_posture = ASC_HudFilterEligibilityLabel(filter);
                  symbol_blocked = true;
                 }

               title = st.symbol;
               summary = priority_posture + " • " + ASC_HudPrimaryOpenClosedState(st.state);
               detail = "Why: " + ASC_HudSymbolWhyNowLine(shortlist_found, membership_state, has_filter, filter, fresh_now, spread_sane);
               selected_row = (st.symbol == g_asc_hud.selected_symbol);
               meta = ASC_HudSymbolWarningLine(st, has_filter, filter, shortlist_found, membership_state);
               if(StringLen(meta) <= 0)
                  meta = bucket_name + " / " + sub_name;
               if(shortlist_found)
                  meta = meta + " | " + ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total);
               if(selected_row)
                  meta = "In focus • " + meta;
               chip_a = "State " + ASC_HudPrimaryOpenClosedState(st.state) + " • Freshness " + freshness + " • " + ASC_HudAgeText(st.observed_at_utc, now_utc);
               chip_b = ASC_HudSymbolFrictionSpreadLine(has_filter, filter, has_filter_packet, shortlist_entry);
               chip_c = "Selection " + ASC_HudFilterEligibilityLabel(filter) + " • "
                        + (shortlist_found
                           ? ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total)
                           : (shortlist_posture + " • " + ASC_ArtifactHumanizeLabel(shortlist_found ? shortlist_entry.shortlist_band : "pending")));
               if(!shortlist_found)
                  chip_c = "Selection pending • Shortlist rank pending";
               if(!shortlist_found || (has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING))
                  chip_c = chip_c + " • Next " + next_check;
               if(!shortlist_found || !has_filter_packet)
                  chip_b = chip_b + " • " + snapshot_posture;
               if(w < 1080)
                 {
                  chip_a = "State " + ASC_HudPrimaryOpenClosedState(st.state)
                           + " | Fresh " + freshness
                           + " | Age " + ASC_HudAgeText(st.observed_at_utc, now_utc);
                  chip_b = ASC_HudClampText(chip_b, (w < 940 ? 44 : 56));
                  chip_c = shortlist_found
                           ? ASC_HudClampText(ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total), 68)
                           : "Selection pending";
                  if(!shortlist_found || (has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING))
                     chip_c = chip_c + " | Next " + next_check;
                 }
               has_row = true;
               row_warning = st.is_degraded
                             || st.is_stale
                             || (has_filter && !filter.spread_is_sane)
                             || (has_filter && filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
                             || (shortlist_found && (membership_state == "blocked" || membership_state == "invalid"));
               row_focused = (g_asc_hud.selected_symbol == st.symbol);
              }
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         int shortlist_idx = ASC_HudVisibleLeaderBackingIndexAt(start + r);
         if(shortlist_idx >= 0 && shortlist_idx < ArraySize(g_asc_hud_shortlist_rows))
           {
            ASC_ShortlistSymbolSummary shortlist_entry = g_asc_hud_shortlist_rows[shortlist_idx];
            int preview_layer1_index = -1;
            ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(shortlist_entry, preview_layer1_index);
            ASC_Layer1SymbolState st;
            bool using_retained_state = false;
            bool using_shortlist_fallback = false;
            int layer1_index = -1;
            ASC_HudResolveLeaderDisplayState(shortlist_entry,
                                             visibility_state,
                                             st,
                                             using_retained_state,
                                             using_shortlist_fallback,
                                             layer1_index);

            datetime now_utc = TimeGMT();
            string effective_main_bucket_id = ASC_HudEffectiveMainBucketId(st);
            string bucket_name = ASC_HudMainBucketName(effective_main_bucket_id);
            string sub_name = ASC_HudSubBucketDisplayName(bucket_name, ASC_HudEffectiveSubBucketName(st, effective_main_bucket_id));
            string shortlist_band = ASC_HudShortlistBandLabel(shortlist_entry.shortlist_band);
            int global_total = ASC_ShortlistCount(g_asc_hud_shortlist_rows);
            bool global_ranked = (shortlist_entry.rank > 0 && shortlist_entry.shortlisted);
            bool bucket_ranked = (shortlist_entry.bucket_rank > 0 && shortlist_entry.bucket_shortlisted);
            string bucket_rank_text = bucket_ranked ? ("#" + IntegerToString(shortlist_entry.bucket_rank)) : "pending";
            string global_rank_text = global_ranked ? ("#" + IntegerToString(shortlist_entry.rank) + " of " + IntegerToString(global_total)) : "pending";

            title = st.symbol;
            string visibility_label = ASC_HudLeaderRowVisibilityStateLabel(visibility_state);
            string rank_surface_label = StringFormat("Bucket %s • %s", bucket_rank_text, shortlist_band);
            string freshness_surface_label = ASC_ArtifactHumanizeLabel(visibility_label);
            summary = rank_surface_label + " • " + ASC_HudPrimaryOpenClosedState(st.state);
            string shortlist_reason = ASC_TextOrUnavailable(shortlist_entry.shortlist_reason);
            if(shortlist_reason == "unavailable")
               shortlist_reason = ASC_TextOrUnavailable(shortlist_entry.filter.reason_summary);
            detail = "Why here: " + shortlist_reason;
            if(visibility_state == ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE)
               detail = "Why here: packet warmup is still catching up • " + shortlist_reason;
            else if(visibility_state == ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE)
               detail = "Why here: retained last-good continuity is carrying this row • " + shortlist_reason;
            else if(visibility_state == ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE)
               detail = "Why here: shortlist snapshot fallback is carrying this row • " + shortlist_reason;
            selected_row = (st.symbol == g_asc_hud.selected_symbol);
            meta = "Context " + bucket_name + " / " + sub_name + " • Global " + global_rank_text;
            if(selected_row)
               meta = "In focus • " + meta;
            end_primary = "Context " + bucket_name + " / " + sub_name;
            end_secondary = "Global " + global_rank_text + " | " + freshness_surface_label;
            if(selected_row)
               end_secondary = "In focus | " + end_secondary;
            chip_a = "Rank " + bucket_rank_text + " • " + shortlist_band + " • " + ASC_HudPrimaryOpenClosedState(st.state);
            chip_b = "Fresh " + ASC_HudSymbolPosture(st, now_utc) + " • Age " + ASC_HudAgeText(st.observed_at_utc, now_utc);
            if(visibility_state == ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE)
               chip_b = "Packet warmup • freshness secondary";
            else if(visibility_state == ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE)
               chip_b = "Retained last-good • freshness secondary";
            else if(visibility_state == ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE)
               chip_b = "Snapshot fallback • freshness secondary";
            chip_c = bucket_ranked
                     ? StringFormat("Bucket membership carried %s", bucket_rank_text)
                     : "Bucket membership pending";
            if(using_shortlist_fallback)
               chip_c = chip_c + " • Snapshot lookup unresolved";
            else if(using_retained_state)
               chip_c = chip_c + " • Retained last-good";
            if(shortlist_band == "Promoted")
               symbol_promoted = true;
            else if(shortlist_band == "Shortlisted")
               symbol_shortlisted = true;
            else if(shortlist_band == "Reserve")
               symbol_pending = true;
            else if(shortlist_band == "Pending")
               symbol_pending = true;
            else if(shortlist_band == "Blocked")
               symbol_blocked = true;
            has_row = true;
            row_warning = st.is_degraded
                          || st.is_stale
                          || visibility_state == ASC_HUD_LEADER_ROW_PACKET_WARMUP_VISIBLE
                          || visibility_state == ASC_HUD_LEADER_ROW_RETAINED_LAST_GOOD_VISIBLE
                          || visibility_state == ASC_HUD_LEADER_ROW_UNRESOLVED_SNAPSHOT_VISIBLE;
            row_focused = (g_asc_hud.selected_symbol == st.symbol);
           }
        }

      if(r < row_limit && has_row)
        {
         bool main_bucket_row = (g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS);
         bool symbol_row = (g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS);
         bool leaders_row = (g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS);
         int button_w = main_bucket_row ? 102 : (symbol_row ? 90 : 98);
         color row_fill = (r % 2 == 0 ? ASC_HudThemeBgCard() : ASC_HudThemeBgCardAlt());
         color row_border = ASC_HudThemeBorderBase();
         color summary_color = ASC_HudThemeAccentSecondary();
         color detail_color = ASC_HudThemeTextSecondary();
         color button_bg = ASC_HudThemeBgPanelAlt();
         color button_border = ASC_HudThemeAccentSelected();
         color edge_color = ASC_HudThemeAccentPrimary();
         if(row_warning)
           {
            detail_color = ASC_HudThemeTextSecondary();
           }
         if(selected_row)
           {
            row_fill = ASC_HudThemeBgCardAlt();
            row_border = ASC_HudThemeBorderFocus();
            summary_color = ASC_HudThemeAccentPrimary();
            detail_color = ASC_HudThemeTextPrimary();
            button_bg = ASC_HudThemeBgCardAlt();
            button_border = ASC_HudThemeAccentPrimary();
            edge_color = ASC_HudThemeAccentPrimary();
           }
         if(symbol_row && !selected_row)
           {
            if(symbol_promoted)
              {
               summary_color = ASC_HudThemeAccentPrimary();
               edge_color = ASC_HudThemeAccentPrimary();
               row_border = ASC_HudThemeBorderEdge();
              }
            else if(symbol_shortlisted)
              {
               summary_color = ASC_HudThemeAccentSecondary();
               edge_color = ASC_HudThemeAccentSecondary();
              }
            else if(symbol_pending)
              {
               summary_color = ASC_HudThemeAccentWarning();
               edge_color = ASC_HudThemeAccentWarning();
              }
            else if(symbol_blocked)
              {
               summary_color = ASC_HudThemeTextMuted();
               edge_color = ASC_HudThemeBorderWarning();
              }
           }
         int panel_h = effective_row_h - 1;
         if(panel_h < 24)
            panel_h = 24;
         int text_w = w - (button_w + 48);
         if(text_w < 116)
           {
            button_w = MathMax(60, w - 140);
            text_w = w - (button_w + 48);
           }
         if(row_warning && !selected_row)
            row_border = ASC_HudThemeBorderEdge();
         ASC_HudEnsureRect(id + "_panel", x, yy, w, panel_h, row_fill, row_border);
         ASC_HudEnsureRect(id + "_edge", 0, 0, 0, 0, clrBlack, clrBlack);
         ASC_HudEnsureRect(id + "_top", 0, 0, 0, 0, clrBlack, clrBlack);
         ASC_HudApplySoftCorners(id + "_panel", x, yy, w, panel_h, ASC_HudThemeBgRoot());
         if(symbol_row)
           {
            ASC_HudEnsureRect(id + "_action_zone", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_action_div", 0, 0, 0, 0, clrBlack, clrBlack);
            if(leaders_row)
              {
               int lane_w = (w < 980 ? 112 : 126);
               if(lane_w > ((w * 22) / 100))
                  lane_w = (w * 22) / 100;
               if(lane_w < 94)
                  lane_w = 94;
               int action_x = x + w - lane_w - 8;
               int action_div_x = action_x - 3;
               int text_x = x + 9;
               int text_w_leader = action_x - text_x - 8;
               if(text_w_leader < 128)
                  text_w_leader = 128;

               int title_y = yy + 5;
               int rank_y = yy + 17;
               int freshness_y = yy + 28;
               int why_y = yy + 39;
               int context_y_1 = yy + 6;
               int context_y_2 = yy + 17;

               ASC_HudEnsureRect(id + "_zone", action_x - 1, yy + 3, lane_w + 1, panel_h - 6, row_fill, row_fill);
               ASC_HudEnsureRect(id + "_action_div",
                                 action_div_x,
                                 yy + 6,
                                 1,
                                 panel_h - 12,
                                 ASC_HudThemeBorderBase(),
                                 ASC_HudThemeBorderBase());
               ASC_HudEnsureRect(id + "_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
               ASC_HudEnsureRect(id + "_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
               ASC_HudEnsureRect(id + "_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
               ASC_HudEnsureLabel(id + "_c1", "", 0, 0, 8, clrBlack);
               ASC_HudEnsureLabel(id + "_c2", "", 0, 0, 8, clrBlack);
               ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);
               if(StringLen(end_primary) <= 0)
                  end_primary = "Context unavailable";
               if(StringLen(end_secondary) <= 0)
                  end_secondary = "Global rank pending";
               ASC_HudEnsureLabelAutoFit(id + "_m", end_primary, action_x + 5, context_y_1, 8, 7, ASC_HudThemeTextSecondary(), lane_w - 12);
               ASC_HudEnsureLabelAutoFit(id + "_m2", end_secondary, action_x + 5, context_y_2, 8, 7, ASC_HudThemeTextMuted(), lane_w - 12);

               ASC_HudEnsureLabelAutoFit(id + "_t", title, text_x, title_y, 12, 10, ASC_HudThemeTextPrimary(), text_w_leader);
               ASC_HudEnsureLabelAutoFit(id + "_s", summary, text_x, rank_y, 9, 8, summary_color, text_w_leader);
               ASC_HudEnsureLabelAutoFit(id + "_d", chip_b, text_x, freshness_y, 8, 7, detail_color, text_w_leader);
               ASC_HudEnsureLabelAutoFit(id + "_c1", detail, text_x, why_y, 8, 7, ASC_HudThemeTextMuted(), text_w_leader);

               int button_w_lane = lane_w - 14;
               if(button_w_lane > 88)
                  button_w_lane = 88;
               if(button_w_lane < 70)
                  button_w_lane = 70;
               int button_y = yy + panel_h - 18;
               int button_x = action_x + lane_w - button_w_lane - 5;
               ASC_HudEnsureButton(id + "_btn", button_text, button_x, button_y, button_w_lane, 16, button_bg, button_border, ASC_HudThemeTextPrimary());
              }
            else
              {
               bool narrow_symbols = (w < 980);
               int zone_w = MathMax((narrow_symbols ? 84 : 98), button_w + (narrow_symbols ? 14 : 20));
               int zone_x = x + w - zone_w - 8;
               int text_x = x + 9;
               text_w = zone_x - text_x - 6;
               if(text_w < 160)
                  text_w = 160;
               int chip_gap = narrow_symbols ? 3 : 5;
               bool tight_chip_layout = narrow_symbols && text_w < 220;
               int chip_count = tight_chip_layout ? 2 : 3;
               int chip_w = (text_w - (chip_gap * (chip_count - 1))) / chip_count;
               if(chip_w < 58)
                  chip_w = 58;
               int chip_h = narrow_symbols ? 12 : 13;
               int chip_y = yy + (narrow_symbols ? 30 : 31);
               int title_y = yy + 5;
               int summary_y = yy + 17;
               int detail_y = yy + (narrow_symbols ? 43 : 44);

               ASC_HudEnsureRect(id + "_zone", zone_x, yy + 4, zone_w, panel_h - 8, ASC_HudThemeBgLayer3(), ASC_HudThemeBgLayer3());
               string compact_meta = ASC_HudClampTextWordSafe(meta, 22);
               ASC_HudEnsureLabelAutoFit(id + "_m", compact_meta, zone_x + 4, yy + 8, 8, 7, ASC_HudThemeTextMuted(), zone_w - 8);
               ASC_HudEnsureLabel(id + "_m2", "", 0, 0, 8, clrBlack);

               color chip_bg_1; color chip_border_1; color chip_text_1;
               color chip_bg_2; color chip_border_2; color chip_text_2;
               color chip_bg_3; color chip_border_3; color chip_text_3;
               ASC_HudThemeSemanticChip(chip_a, selected_row, chip_bg_1, chip_border_1, chip_text_1);
               ASC_HudThemeSemanticChip(chip_b, selected_row, chip_bg_2, chip_border_2, chip_text_2);
               ASC_HudThemeSemanticChip(chip_c, selected_row, chip_bg_3, chip_border_3, chip_text_3);

               ASC_HudEnsureRect(id + "_chip_1", text_x, chip_y, chip_w, chip_h, chip_bg_1, chip_border_1);
               ASC_HudEnsureRect(id + "_chip_2", text_x + chip_w + chip_gap, chip_y, chip_w, chip_h, chip_bg_2, chip_border_2);
               if(chip_count >= 3)
                  ASC_HudEnsureRect(id + "_chip_3", text_x + ((chip_w + chip_gap) * 2), chip_y, chip_w, chip_h, chip_bg_3, chip_border_3);
               else
                  ASC_HudEnsureRect(id + "_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
               ASC_HudEnsureLabelClamped(id + "_c1", chip_a, text_x + 4, chip_y + 3, 7, chip_text_1, chip_w - 6);
               ASC_HudEnsureLabelClamped(id + "_c2", chip_b, text_x + chip_w + chip_gap + 4, chip_y + 3, 7, chip_text_2, chip_w - 6);
               if(chip_count >= 3)
                  ASC_HudEnsureLabelClamped(id + "_c3", chip_c, text_x + ((chip_w + chip_gap) * 2) + 4, chip_y + 3, 7, chip_text_3, chip_w - 6);
               else
                  ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);

               ASC_HudEnsureLabelClamped(id + "_t", title, text_x, title_y, 12, ASC_HudThemeTextPrimary(), text_w);
               ASC_HudEnsureLabelClamped(id + "_s", summary, text_x, summary_y, 10, summary_color, text_w);
               string detail_line = tight_chip_layout ? (detail + " | " + ASC_HudClampText(chip_c, 24)) : detail;
               ASC_HudEnsureLabelClamped(id + "_d", detail_line, text_x, detail_y, 8, detail_color, text_w);

               int button_x = zone_x + ((zone_w - button_w) / 2);
               int button_y = yy + panel_h - 18;
               ASC_HudEnsureButton(id + "_btn", button_text, button_x, button_y, button_w, 16, button_bg, button_border, ASC_HudThemeTextPrimary());
              }
           }
         else
           {
            ASC_HudEnsureRect(id + "_zone", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureLabel(id + "_c1", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_c2", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);
            if(main_bucket_row)
              {
               ASC_HudEnsureRect(id + "_action_zone", 0, 0, 0, 0, clrBlack, clrBlack);
               ASC_HudEnsureRect(id + "_action_div", 0, 0, 0, 0, clrBlack, clrBlack);
               int action_cell_w = (w < 1080 ? 142 : 154);
               int action_cell_max = w - 214;
               if(action_cell_w > action_cell_max)
                  action_cell_w = action_cell_max;
               if(action_cell_w < 124)
                  action_cell_w = 124;
               int action_x = x + w - action_cell_w - 8;
               int button_w_lane = 48;
               int button_x = action_x + action_cell_w - button_w_lane - 5;
               int metrics_x = action_x + 5;
               int metrics_w = button_x - metrics_x - 5;
               if(metrics_w < 96)
                  metrics_w = 96;
               int action_div_x = action_x - 3;
               int lane_left_x = x + 9;
               int lane_total_w = action_div_x - lane_left_x - 6;
               if(lane_total_w < 96)
                  lane_total_w = 96;
               int lane_gap = 6;
               int left_w = (lane_total_w * 50) / 100;
               if(left_w < 82)
                  left_w = 82;
               if(left_w > lane_total_w - 50)
                  left_w = lane_total_w - 50;
               int center_w = lane_total_w - left_w - lane_gap;
               if(center_w < 42)
                 {
                  center_w = 42;
                  left_w = lane_total_w - center_w - lane_gap;
                  if(left_w < 72)
                     left_w = 72;
                 }
               int center_x = lane_left_x + left_w + lane_gap;

               int title_y = yy + 5;
               int summary_y = yy + 17;
               int center_y_1 = yy + 7;
               int center_y_2 = yy + 18;
               int end_y_1 = yy + 7;
               int end_y_2 = yy + 18;
               if(StringLen(end_primary) <= 0)
                  end_primary = meta;
               if(StringLen(end_secondary) <= 0)
                  end_secondary = "Routing active";
               if(StringLen(center_primary) <= 0)
                  center_primary = detail;
               if(StringLen(center_secondary) <= 0)
                  center_secondary = "Support context unavailable.";

               ASC_HudEnsureRect(id + "_zone",
                                 metrics_x,
                                 yy + 4,
                                 action_cell_w - 5,
                                 panel_h - 8,
                                 ASC_HudThemeBgLayer3(),
                                 ASC_HudThemeBgLayer3());
               ASC_HudEnsureRect(id + "_action_zone",
                                 action_x,
                                 yy + 4,
                                 action_cell_w,
                                 panel_h - 8,
                                 ASC_HudThemeBgPanelAlt(),
                                 ASC_HudThemeBorderBase());
               ASC_HudEnsureRect(id + "_action_div",
                                 action_div_x,
                                 yy + 6,
                                 1,
                                 panel_h - 12,
                                 ASC_HudThemeBorderBase(),
                                 ASC_HudThemeBorderBase());
               ASC_HudEnsureLabelClamped(id + "_t", title, lane_left_x, title_y, 12, ASC_HudThemeTextPrimary(), left_w);
               ASC_HudEnsureLabelAutoFit(id + "_s", summary, lane_left_x, summary_y, 10, 8, summary_color, left_w);
               ASC_HudEnsureLabelAutoFit(id + "_d", center_primary, center_x, center_y_1, 8, 7, detail_color, center_w);
               ASC_HudEnsureLabelAutoFit(id + "_c1", center_secondary, center_x, center_y_2, 8, 7, ASC_HudThemeTextMuted(), center_w);
               ASC_HudEnsureLabel(id + "_c2", "", 0, 0, 8, clrBlack);
               ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);
               ASC_HudEnsureLabelAutoFit(id + "_m", end_primary, metrics_x + 6, end_y_1, 8, 7, ASC_HudThemeTextPrimary(), metrics_w - 12);
               ASC_HudEnsureLabelAutoFit(id + "_m2", end_secondary, metrics_x + 6, end_y_2, 8, 7, ASC_HudThemeTextMuted(), metrics_w - 12);
               int button_y = yy + ((panel_h - 18) / 2);
               ASC_HudEnsureButton(id + "_btn", button_text, button_x, button_y, button_w_lane, 18, button_bg, button_border, ASC_HudThemeTextPrimary());
              }
            else
              {
               int left_x = x + 9;
               int inner_w = w - 18;
               if(inner_w < 260)
                  inner_w = 260;
               int action_lane_w = (inner_w * 11) / 100;
               if(action_lane_w < 72)
                  action_lane_w = 72;
               if(action_lane_w > 92)
                  action_lane_w = 92;
               int action_x = x + w - action_lane_w - 9;

               int info_lane_w = (inner_w * 15) / 100;
               if(info_lane_w < 96)
                  info_lane_w = 96;
               if(info_lane_w > 138)
                  info_lane_w = 138;
               int info_lane_x = action_x - info_lane_w - 6;
               if(info_lane_x < x + 148)
                 {
                  info_lane_x = x + 148;
                  info_lane_w = action_x - info_lane_x - 8;
                  if(info_lane_w < 106)
                     info_lane_w = 106;
               }

               int left_total_w = info_lane_x - left_x - 6;
               if(left_total_w < 140)
                  left_total_w = 140;
               int lane_gap = 6;
               int primary_w = (left_total_w * 44) / 100;
               if(primary_w < 116)
                  primary_w = 116;
               int support_w = left_total_w - primary_w - lane_gap;
               if(support_w < 120)
                 {
                  support_w = 120;
                  primary_w = left_total_w - support_w - lane_gap;
                  if(primary_w < 96)
                    {
                     primary_w = 96;
                     support_w = left_total_w - primary_w - lane_gap;
                    }
                 }
               int support_x = left_x + primary_w + lane_gap;

               int title_y = yy + 5;
               int summary_y = yy + 17;
               int support_y_1 = yy + 7;
               int support_y_2 = yy + 18;
               int info_y_1 = yy + 7;
               int info_y_2 = yy + 18;
               if(StringLen(center_primary) <= 0)
                  center_primary = detail;
               if(StringLen(center_secondary) <= 0)
                  center_secondary = "Support details pending.";
               if(StringLen(end_primary) <= 0)
                  end_primary = meta;
               if(StringLen(end_secondary) <= 0)
                  end_secondary = "Scope active";

               ASC_HudEnsureRect(id + "_zone",
                                 info_lane_x,
                                 yy + 4,
                                 action_x + action_lane_w - info_lane_x,
                                 panel_h - 8,
                                 ASC_HudThemeBgLayer3(),
                                 ASC_HudThemeBgLayer3());
               ASC_HudEnsureRect(id + "_action_zone",
                                 action_x + 1,
                                 yy + 4,
                                 action_lane_w - 1,
                                 panel_h - 8,
                                 ASC_HudThemeBgPanelAlt(),
                                 ASC_HudThemeBorderBase());
               ASC_HudEnsureRect(id + "_action_div",
                                 action_x - 1,
                                 yy + 6,
                                 1,
                                 panel_h - 12,
                                 ASC_HudThemeBorderBase(),
                                 ASC_HudThemeBorderBase());
               ASC_HudEnsureLabelClamped(id + "_t", title, left_x, title_y, 12, ASC_HudThemeTextPrimary(), primary_w);
               ASC_HudEnsureLabelClamped(id + "_s", summary, left_x, summary_y, 10, summary_color, primary_w);
               ASC_HudEnsureLabelAutoFit(id + "_d", center_primary, support_x, support_y_1, 8, 7, detail_color, support_w);
               ASC_HudEnsureLabelAutoFit(id + "_c1", center_secondary, support_x, support_y_2, 8, 6, ASC_HudThemeTextMuted(), support_w);
               ASC_HudEnsureLabel(id + "_c2", "", 0, 0, 8, clrBlack);
               ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);
               ASC_HudEnsureLabelClamped(id + "_m", end_primary, info_lane_x + 5, info_y_1, 8, ASC_HudThemeTextPrimary(), info_lane_w - 10);
               ASC_HudEnsureLabelAutoFit(id + "_m2", end_secondary, info_lane_x + 5, info_y_2, 8, 7, ASC_HudThemeTextMuted(), info_lane_w - 10);
               int button_w_lane = action_lane_w - 16;
               if(button_w_lane > 98)
                  button_w_lane = 98;
               if(button_w_lane < 72)
                  button_w_lane = 72;
               int button_x = action_x + ((action_lane_w - button_w_lane) / 2);
               int button_y = yy + ((panel_h - 18) / 2);
               ASC_HudEnsureButton(id + "_btn", button_text, button_x, button_y, button_w_lane, 18, button_bg, button_border, ASC_HudThemeTextPrimary());
              }
           }
        }
      else
        {
         if(r == 0 && g_asc_hud.list_total_items <= 0)
           {
            bool delayed_state = (g_asc_hud.has_summary && (g_asc_hud.latest_summary.is_degraded || g_asc_hud.latest_summary.is_stale));
            color empty_border = delayed_state ? ASC_HudThemeBorderWarning() : ASC_HudThemeBorderBase();
            color empty_accent = delayed_state ? ASC_HudThemeAccentWarning() : ASC_HudThemeAccentSecondary();
            string empty_meta = delayed_state ? "State: Degraded/Delayed" : "State: Empty but healthy";
            int empty_h = MathMax(64, effective_row_h + 18);
            ASC_HudEnsureRect(id + "_panel", x, yy, w, empty_h, ASC_HudThemeBgCardAlt(), empty_border);
            ASC_HudEnsureRect(id + "_edge", x + 2, yy + 3, 3, empty_h - 6, empty_accent, empty_accent);
            ASC_HudEnsureRect(id + "_top", x + 6, yy + 3, w - 12, 1, empty_accent, empty_accent);
            ASC_HudApplySoftCorners(id + "_panel", x, yy, w, empty_h, ASC_HudThemeBgRoot());
            ASC_HudEnsureLabelClamped(id + "_t", ASC_HudListEmptyStateTitle(), x + 10, yy + 12, 12, ASC_HudThemeTextPrimary(), w - 24);
            ASC_HudEnsureLabelClamped(id + "_s", ASC_HudListEmptyStateSummary(), x + 10, yy + 31, 10, ASC_HudThemeAccentSecondary(), w - 24);
            ASC_HudEnsureLabelClamped(id + "_d", ASC_HudListEmptyStateDetail(), x + 10, yy + 49, 9, ASC_HudThemeTextSecondary(), w - 24);
            ASC_HudEnsureLabelClamped(id + "_m", empty_meta, x + 10, yy + empty_h - 14, 8, ASC_HudThemeTextMuted(), w - 24);
            ASC_HudEnsureLabel(id + "_m2", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureButton(id + "_btn", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
           }
         else
           {
            ASC_HudEnsureRect(id + "_panel", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_edge", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_top", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_zone", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_action_zone", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureRect(id + "_action_div", 0, 0, 0, 0, clrBlack, clrBlack);
            ASC_HudEnsureLabel(id + "_t", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_s", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_d", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_m", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_m2", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_c1", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_c2", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureLabel(id + "_c3", "", 0, 0, 8, clrBlack);
            ASC_HudEnsureButton(id + "_btn", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
           }
        }
     }

   g_asc_hud.list_rows_rendered = slots_to_process;
   g_asc_hud.list_rows_render_signature = rows_signature;
   g_asc_hud.list_panels_hidden = false;
  }


void ASC_HudBuildCandidateReadinessCounts(const ASC_RuntimeState &runtime,
                                          int &qualified_out,
                                          int &building_out,
                                          int &unavailable_out,
                                          int &total_out)
  {
   qualified_out = 0;
   building_out = 0;
   unavailable_out = 0;
   total_out = 0;

   if(!runtime.committed_l3_ready || ArraySize(runtime.committed_l3_rows) <= 0)
      return;

   total_out = ArraySize(runtime.committed_l3_rows);
   for(int i = 0; i < total_out; i++)
     {
      ASC_SelectionFilterEvaluation evaluation = runtime.committed_l3_rows[i].evaluation;
      if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         qualified_out++;
      else if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
         unavailable_out++;
      else
         building_out++;
     }
  }

void ASC_HudBuildShortlistReadinessCounts(int &promoted_out,
                                          int &shortlisted_out,
                                          int &reserve_out,
                                          int &pending_out,
                                          int &blocked_out,
                                          int &total_out)
  {
   promoted_out = 0;
   shortlisted_out = 0;
   reserve_out = 0;
   pending_out = 0;
   blocked_out = 0;
   total_out = ArraySize(g_asc_hud_shortlist_rows);

   for(int i = 0; i < total_out; i++)
     {
      string band = ASC_HudTrim(g_asc_hud_shortlist_rows[i].shortlist_band);
      StringToLower(band);
      if(band == "promoted")
         promoted_out++;
      else if(band == "shortlisted")
         shortlisted_out++;
      else if(band == "reserve")
         reserve_out++;
      else if(band == "pending")
         pending_out++;
      else if(band == "blocked")
         blocked_out++;
     }
  }

string ASC_HudOverviewMarketStatePosture()
  {
   if(!g_asc_hud.has_summary || g_asc_hud.latest_summary.total_symbols <= 0)
      return "Thin";
   if(g_asc_hud.latest_summary.is_degraded || g_asc_hud.latest_summary.is_stale)
      return "Disturbed";
   if(g_asc_hud.latest_summary.is_ready && g_asc_hud.latest_summary.is_complete)
      return "Ready";
   if(g_asc_hud.latest_summary.assessed_symbols <= 0)
      return "Thin";
   return "Building";
  }

string ASC_HudOverviewCandidateFilteringPosture(const ASC_RuntimeState &runtime,
                                                const int qualified_count,
                                                const int building_count,
                                                const int total_count)
  {
   if(total_count <= 0)
      return "Thin";

   bool recent_change = (runtime.committed_l3_pass_utc > 0 && (TimeGMT() - runtime.committed_l3_pass_utc) <= 15);
   if(runtime.forced_downstream_refresh_pending || recent_change)
      return (qualified_count > 0 || building_count > 0) ? "Rebalancing" : "Building";

   if(qualified_count > 0)
      return "Ready";
   if(building_count > 0)
      return "Building";
   return "Thin";
  }

string ASC_HudOverviewShortlistPosture(const ASC_RuntimeState &runtime,
                                       const int promoted_count,
                                       const int shortlisted_count,
                                       const int reserve_count,
                                       const int pending_count,
                                       const int total_count)
  {
   if(total_count <= 0)
      return "Thin";

   bool recent_change = (g_asc_hud.last_shortlist_pass_utc > 0 && (TimeGMT() - g_asc_hud.last_shortlist_pass_utc) <= 15);
   if(runtime.forced_downstream_refresh_pending || recent_change)
      return (promoted_count > 0 || shortlisted_count > 0 || reserve_count > 0) ? "Rebalancing" : "Building";

   if((promoted_count + shortlisted_count + reserve_count) <= 0)
      return "Building";
   if(pending_count > 0)
      return "Partial";
   if(g_asc_hud.last_shortlist_pass_utc > 0 && (TimeGMT() - g_asc_hud.last_shortlist_pass_utc) >= 30 && !(g_asc_hud.latest_summary.is_degraded || g_asc_hud.latest_summary.is_stale))
      return "Stable";
   return "Ready";
  }

string ASC_HudTop10SnapshotSourceLabel(const string snapshot_source)
  {
   string source = ASC_HudTrim(snapshot_source);
   StringToLower(source);
   if(source == "published_shortlist_cache")
      return "published shortlist cache";
   if(source == "committed_l4_runtime_state")
      return "committed Layer 4 runtime state";
   return "no settled snapshot";
  }

string ASC_HudTop10ReadinessProgressText(const ASC_RuntimeState &runtime,const bool batch_active,const bool snapshot_ready,const string snapshot_source,const datetime snapshot_utc)
  {
   if(batch_active)
      return StringFormat("Batch %d/%d | In flight %s",
                          runtime.top10_run_full_cursor,
                          runtime.top10_run_full_total,
                          (StringLen(runtime.top10_run_full_inflight_symbol) > 0 ? runtime.top10_run_full_inflight_symbol : "none"));

   if(snapshot_ready)
      return StringFormat("Snapshot source %s | pass %s",
                          ASC_HudTop10SnapshotSourceLabel(snapshot_source),
                          ASC_FormatUtc(snapshot_utc));

   if(runtime.publication_shortlist_ready && ArraySize(runtime.publication_shortlist_rows) <= 0)
      return "Published shortlist cache is empty for this cycle.";
   if(runtime.committed_l4_ready && ArraySize(runtime.committed_l4_rows) > 0)
      return StringFormat("Committed Layer 4 has %d lawful rows, but the published shortlist cache is still settling.",
                          ArraySize(runtime.committed_l4_rows));
   return "Awaiting settled shortlist publication for this cycle.";
  }

string ASC_HudTop10ReadinessStatusText(const ASC_RuntimeState &runtime,const bool batch_active,const bool snapshot_ready,const string snapshot_reason)
  {
   if(batch_active)
      return "Run Full batch active; operator view remains advisory until the next settled publish lands.";
   if(snapshot_ready)
      return "Ready for snapshot-only publish from the current settled truth.";
   if(runtime.l1_bootstrap_active)
      return "Warmup bootstrap still active; higher-page snapshot publish remains blocked.";
   if(!runtime.l1_warmup_ready)
      return "Warmup exit is not complete yet; higher-page snapshot publish remains blocked.";
   return "Not ready: " + snapshot_reason + ".";
  }


string ASC_HudOverviewTop10ReadinessPosture(const ASC_RuntimeState &runtime,
                                            const string market_state_posture,
                                            const string candidate_posture,
                                            const string shortlist_posture)
  {
   bool batch_active = (runtime.top10_run_full_batch_pending
                        || runtime.top10_run_full_cursor < runtime.top10_run_full_total
                        || StringLen(runtime.top10_run_full_inflight_symbol) > 0);
   if(batch_active)
      return "Running";

   string snapshot_reason = "";
   string snapshot_source = "none";
   datetime snapshot_utc = 0;
   bool snapshot_ready = ASC_HudGlobalTop10SnapshotReady(runtime, snapshot_reason, snapshot_source, snapshot_utc);
   if(snapshot_ready)
     {
      if(shortlist_posture == "Stable" && candidate_posture == "Ready" && market_state_posture == "Ready")
         return "Stable";
      return "Latched";
     }

   if(runtime.l1_bootstrap_active)
      return "Warmup";
   if(!runtime.l1_warmup_ready)
      return "Warmup";
   if(shortlist_posture == "Building" || shortlist_posture == "Partial" || shortlist_posture == "Rebalancing"
      || candidate_posture == "Building" || candidate_posture == "Rebalancing"
      || market_state_posture == "Building" || market_state_posture == "Disturbed")
      return "Settling";
   return "Blocked";
  }

void ASC_HudRenderOverviewPage(const ASC_RuntimeState &runtime,const int x,const int y,const int w)
  {
   int safe_inset = (w < 980 ? 14 : 22);
   int content_x = x + safe_inset;
   int content_w = w - (safe_inset * 2);
   if(content_w < 320)
     {
      safe_inset = 8;
      content_x = x + safe_inset;
      content_w = w - (safe_inset * 2);
     }
   int tracked = (g_asc_hud.has_summary ? g_asc_hud.latest_summary.total_symbols : 0);
   int bucket_total = ArraySize(g_asc_hud.buckets);
   int sub_bucket_total = ArraySize(g_asc_hud.sub_buckets);
   int coverage_percent = ASC_HudCoveragePercent();
   int viewport_h = g_asc_hud.viewport_h;
   bool compact_h = (viewport_h < 760);
   bool narrow_w = (content_w < 900);
   int footer_safe_bottom = g_asc_hud.viewport_h - ASC_HUD_FOOTER_H - 6;
   if(footer_safe_bottom < (y + 120))
      footer_safe_bottom = y + 120;
   string trust_posture = ASC_HudOverviewTrustPosture();
   string line1 = "Scanner status: " + trust_posture + " | " + ASC_HudReadinessSummaryText() + " | " + ASC_HudQualitySummaryText() + ".";
   string line2 = "Coverage: " + ASC_HudCoverageText() + " (" + IntegerToString(coverage_percent) + "%) | " + ASC_HudClassificationGuardLine() + ".";
   string line3 = "Primary focus: " + ASC_HudOverviewFocusBucketLine() + ".";
   int hero_h = (compact_h ? 78 : 84);
   ASC_HudRenderCard("hero", "Operator Overview", line1, line2, line3, content_x, y, content_w, hero_h, ASC_HudThemeAccentCardA());

   ASC_HudEnsureRect(ASC_HUD_PREFIX + "ov_clock_panel", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "ov_clock_title", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "ov_clock_text", "", 0, 0, 8, clrBlack);

   int card_gap_x = (narrow_w ? 10 : 12);
   int card_gap_y = (compact_h ? 8 : 10);
   int left_card_w = (content_w - card_gap_x) / 2;
   int right_card_w = content_w - card_gap_x - left_card_w;
   int top = y + hero_h + (compact_h ? 7 : 9);
   int usable_h = footer_safe_bottom - top;
   if(usable_h < 220)
      usable_h = 220;
   int band_h = 0;
   int reserve_for_band = (usable_h >= (compact_h ? 292 : 318) ? (compact_h ? 66 : 76) : 0);
   if(reserve_for_band > 0)
      band_h = reserve_for_band;
   int grid_h = usable_h - band_h;
   if(band_h > 0)
      grid_h -= (compact_h ? 8 : 10);
   if(grid_h < 188)
      grid_h = 188;
   int card_h = (grid_h - card_gap_y) / 2;
   int min_card_h = (compact_h ? 96 : 106);
   int max_card_h = (compact_h ? 122 : 136);
   if(card_h < min_card_h)
      card_h = min_card_h;
   if(card_h > max_card_h)
      card_h = max_card_h;
   int max_grid_h = footer_safe_bottom - top;
   if(max_grid_h < 2)
      max_grid_h = 2;
   if((card_h * 2 + card_gap_y + (band_h > 0 ? ((compact_h ? 8 : 10) + band_h) : 0)) > max_grid_h)
      card_h = (max_grid_h - card_gap_y - (band_h > 0 ? ((compact_h ? 8 : 10) + band_h) : 0)) / 2;
   if(card_h < 90)
      card_h = 90;
   int card_grid_bottom = top + (card_h * 2) + card_gap_y;
   int second_row_y = top + card_h + card_gap_y;
   int right_x = content_x + left_card_w + card_gap_x;
   string market_state_posture = ASC_HudOverviewMarketStatePosture();
   int candidate_qualified = 0;
   int candidate_building = 0;
   int candidate_unavailable = 0;
   int candidate_total = 0;
   ASC_HudBuildCandidateReadinessCounts(runtime,
                                        candidate_qualified,
                                        candidate_building,
                                        candidate_unavailable,
                                        candidate_total);
   string candidate_posture = ASC_HudOverviewCandidateFilteringPosture(runtime,
                                                                       candidate_qualified,
                                                                       candidate_building,
                                                                       candidate_total);
   int shortlist_promoted = 0;
   int shortlist_ranked = 0;
   int shortlist_reserve = 0;
   int shortlist_pending = 0;
   int shortlist_blocked = 0;
   int shortlist_total = 0;
   ASC_HudBuildShortlistReadinessCounts(shortlist_promoted,
                                        shortlist_ranked,
                                        shortlist_reserve,
                                        shortlist_pending,
                                        shortlist_blocked,
                                        shortlist_total);
   string shortlist_posture = ASC_HudOverviewShortlistPosture(runtime,
                                                              shortlist_promoted,
                                                              shortlist_ranked,
                                                              shortlist_reserve,
                                                              shortlist_pending,
                                                              shortlist_total);
   string top10_posture = ASC_HudOverviewTop10ReadinessPosture(runtime,
                                                               market_state_posture,
                                                               candidate_posture,
                                                               shortlist_posture);

   bool top10_batch_active = (runtime.top10_run_full_batch_pending
                              || runtime.top10_run_full_cursor < runtime.top10_run_full_total
                              || StringLen(runtime.top10_run_full_inflight_symbol) > 0);
   string top10_snapshot_reason = "";
   string top10_snapshot_source = "none";
   datetime top10_snapshot_utc = 0;
   bool top10_snapshot_ready = ASC_HudGlobalTop10SnapshotReady(runtime,
                                                               top10_snapshot_reason,
                                                               top10_snapshot_source,
                                                               top10_snapshot_utc);
   string top10_progress_text = ASC_HudTop10ReadinessProgressText(runtime,
                                                                  top10_batch_active,
                                                                  top10_snapshot_ready,
                                                                  top10_snapshot_source,
                                                                  top10_snapshot_utc);
   string top10_status_text = ASC_HudTop10ReadinessStatusText(runtime,
                                                              top10_batch_active,
                                                              top10_snapshot_ready,
                                                              top10_snapshot_reason);

   ASC_HudRenderCard("ov_runtime",
                     "Market State",
                     "Posture: " + market_state_posture + ".",
                     StringFormat("Coverage %d/%d | Open %d | Closed %d | Uncertain %d.",
                                  (g_asc_hud.has_summary ? g_asc_hud.latest_summary.assessed_symbols : 0),
                                  tracked,
                                  (g_asc_hud.has_summary ? g_asc_hud.latest_summary.open_count : 0),
                                  (g_asc_hud.has_summary ? g_asc_hud.latest_summary.closed_count : 0),
                                  (g_asc_hud.has_summary ? g_asc_hud.latest_summary.uncertain_count : 0)),
                     StringFormat("Due %d | Disturbed %d | Reason %s.",
                                  (g_asc_hud.has_summary ? g_asc_hud.latest_summary.due_symbols : 0),
                                  (g_asc_hud.has_summary ? g_asc_hud.latest_summary.degraded_symbols + g_asc_hud.latest_summary.stale_symbols : 0),
                                  ASC_HudHealthReason()),
                     content_x,
                     top,
                     left_card_w,
                     card_h,
                     ASC_HudThemeAccentCardD());

   ASC_HudRenderCard("ov_universe",
                     "Candidate Filtering",
                     "Posture: " + candidate_posture + ".",
                     StringFormat("Qualified %d | Building %d | Unavailable %d.",
                                  candidate_qualified,
                                  candidate_building,
                                  candidate_unavailable),
                     StringFormat("Committed rows %d | Refresh %s.",
                                  candidate_total,
                                  runtime.forced_downstream_refresh_pending ? "rebalancing" : "steady"),
                     right_x,
                     top,
                     right_card_w,
                     card_h,
                     ASC_HudThemeAccentCardC());

   ASC_HudRenderCard("ov_pipeline",
                     "Shortlist Selection",
                     "Posture: " + shortlist_posture + ".",
                     StringFormat("Promoted %d | Shortlisted %d | Reserve %d.",
                                  shortlist_promoted,
                                  shortlist_ranked,
                                  shortlist_reserve),
                     StringFormat("Pending %d | Blocked %d | Visible Top 10 %d.",
                                  shortlist_pending,
                                  shortlist_blocked,
                                  ASC_HudVisibleGlobalTop10Count()),
                     content_x,
                     second_row_y,
                     left_card_w,
                     card_h,
                     ASC_HudThemeAccentCardB());

   ASC_HudRenderCard("ov_attention",
                     "Global Top 10 Readiness",
                     "Posture: " + top10_posture + ".",
                     top10_progress_text + ".",
                     "Status: " + top10_status_text,
                     right_x,
                     second_row_y,
                     right_card_w,
                     card_h,
                     ASC_HudThemeAccentCardD());

   int band_top = card_grid_bottom + (compact_h ? 6 : 8);
   band_h = footer_safe_bottom - band_top;
   if(band_h >= 68)
     {
      int band_gap = (content_w < 920 ? 10 : 14);
      int band_w = (content_w - (band_gap * 2)) / 3;
      if(band_w < 86)
        {
         band_gap = 4;
         band_w = (content_w - (band_gap * 2)) / 3;
        }
      int shown_band_h = band_h;
      if(shown_band_h > (compact_h ? 76 : 86))
         shown_band_h = (compact_h ? 76 : 86);

      ASC_HudRenderCard("ov_band_a",
                        "Cadence & Freshness",
                        "Last render: " + TimeToString(g_asc_hud.last_render_utc, TIME_MINUTES|TIME_SECONDS) + ".",
                        "Clock: " + TimeToString(TimeGMT(), TIME_MINUTES|TIME_SECONDS) + ".",
                        "Scanner status: " + ASC_HudReadinessSummaryText() + ".",
                        content_x,
                        band_top,
                        band_w,
                        shown_band_h,
                        ASC_HudThemeAccentCardA());

      ASC_HudRenderCard("ov_band_b",
                        "Classification Guard",
                        "Guard status: " + ASC_HudClassificationGuardLine() + ".",
                        "Universe: " + ASC_HudCoverageText() + ".",
                        "Scope: Markets " + IntegerToString(bucket_total) + " | Groups " + IntegerToString(sub_bucket_total) + ".",
                        content_x + band_w + band_gap,
                        band_top,
                        band_w,
                        shown_band_h,
                        ASC_HudThemeAccentCardB());

      ASC_HudRenderCard("ov_band_c",
                        "Routing Posture",
                        "Focus: " + ASC_HudOverviewFocusBucketLine() + ".",
                        "Flow: " + ASC_HudOverviewShortlistFlowLine() + ".",
                        "Browse: " + ASC_HudBrowseIntegrityLine() + ".",
                        content_x + (band_w * 2) + (band_gap * 2),
                        band_top,
                        band_w,
                        shown_band_h,
                        ASC_HudThemeAccentCardC());
     }
   else
     {
      ASC_HudHideCard("ov_band_a");
      ASC_HudHideCard("ov_band_b");
      ASC_HudHideCard("ov_band_c");
     }
  }

void ASC_HudRenderSymbolActionRow(const int x,const int y,const int w,const bool include_aspects)
  {
   if(!include_aspects)
     {
      ASC_HudHideSymbolLowerSectionControls();
      return;
     }

   ASC_HudTrackFamilyVisibility(g_asc_hud.proof_symbol_lower_visible, true, g_asc_hud.proof_symbol_lower_visibility_changes);

   int row_h = ASC_HudSymbolSectionRowHeight(w);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "stat_scope", x, y, w, row_h, ASC_HudThemeBgLayer2(), ASC_HudThemeBorderBase());
   int tab_gap = (row_h > 40 ? 8 : 6);
   bool two_rows = (row_h > 40);
   int tabs_per_row = (two_rows ? 3 : 6);
   int tab_rows = (two_rows ? 2 : 1);
   int tab_w = (w - 20 - (tab_gap * (tabs_per_row - 1))) / tabs_per_row;
   if(tab_w < 88) tab_w = 88;
   int total_tabs_w = (tab_w * tabs_per_row) + (tab_gap * (tabs_per_row - 1));
   if(total_tabs_w > (w - 20))
      tab_w = ((w - 20) - (tab_gap * (tabs_per_row - 1))) / tabs_per_row;
   if(tab_w < 64)
      tab_w = 64;
   int row_x = x + 10;
   int top = y + (two_rows ? 6 : 5);
   int row_gap = (tab_rows > 1 ? 6 : 0);
   int tab_h = (tab_rows > 1 ? 20 : 22);

   bool compact_tabs = (w < 1040);
   string labels[6];
   labels[0] = "Overview";
   labels[1] = "Market Watch";
   labels[2] = "Specs";
   labels[3] = "Selection";
   labels[4] = "Shortlist";
   labels[5] = "Full Analysis";
   const ASC_HudSymbolSectionFamily sections[6] = {ASC_HUD_SYMBOL_SECTION_OVERVIEW,
                                                   ASC_HUD_SYMBOL_SECTION_MARKET_WATCH,
                                                   ASC_HUD_SYMBOL_SECTION_SPECIFICATION,
                                                   ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER,
                                                   ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT,
                                                   ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS};
   int tab_count = 6;
   for(int i = 0; i < tab_count; i++)
     {
      int row_index = i / tabs_per_row;
      int col_index = i % tabs_per_row;
      int bx = row_x + (col_index * (tab_w + tab_gap));
      int by = top + (row_index * (tab_h + row_gap));
      ASC_HudRenderSectionButton(ASC_HUD_PREFIX + "sym_stat_" + IntegerToString(i + 1), labels[i], bx, by, tab_w, tab_h, sections[i]);
     }
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_7", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
   ASC_HudEnsureButton(ASC_HUD_PREFIX + "sym_stat_8", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
  }

void ASC_HudRenderBottomRow(const int x,const int y,const int w)
  {
   string status = ASC_HudStatusStripLine();
   if(StringLen(g_asc_hud.transient_notice) > 0 && TimeGMT() <= g_asc_hud.transient_notice_until)
      status = status + " • Notice " + g_asc_hud.transient_notice;

   int strip_h = ASC_HUD_FOOTER_H;
   if(strip_h < 24)
      strip_h = 24;
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "status_strip", x, y, w, strip_h, ASC_HudThemeBgLayer3(), ASC_HudThemeBorderBase());
   ASC_HudApplySoftCorners(ASC_HUD_PREFIX + "status_strip", x, y, w, strip_h, ASC_HudThemeBgRoot());
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "status_bar", x + 8, y + 4, 3, strip_h - 8, ASC_HudThemeAccentPrimary(), ASC_HudThemeAccentPrimary());

   if(ASC_HudIsListPage())
     {
      ASC_HudTrackFamilyVisibility(g_asc_hud.proof_footer_pager_visible, true, g_asc_hud.proof_footer_pager_visibility_changes);
      int status_area_x = x + 10;
      int pager_box_w = (w >= 1180 ? 318 : (w >= 980 ? 278 : 236));
      int status_area_w = w - pager_box_w - 26;
      if(status_area_w < 110)
        {
         pager_box_w = MathMax(214, w / 2);
         status_area_w = w - pager_box_w - 26;
        }
      if(status_area_w < 104)
         status_area_w = 104;
      string status_compact = ASC_HudClampTextMiddle(status, ASC_HudCharsForWidth(status_area_w - 6, 8));
      ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "status_text", status_compact, status_area_x, y + 8, 8, ASC_HudThemeTextPrimary(), status_area_w);

      int pager_box_x = x + w - pager_box_w - 8;
      ASC_HudEnsureRect(ASC_HUD_PREFIX + "pager_box", pager_box_x, y + 2, pager_box_w, strip_h - 4, ASC_HudThemeBgPanelAlt(), ASC_HudThemeBorderBase());
      bool can_prev = (g_asc_hud.list_current_page > 1);
      bool can_next = (g_asc_hud.list_current_page < g_asc_hud.list_total_pages);
      int nav_btn_w = (pager_box_w < 280 ? 46 : 52);
      int prev_x = pager_box_x + 6;
      int next_x = pager_box_x + pager_box_w - nav_btn_w - 6;
      int readout_x = prev_x + nav_btn_w + 8;
      int readout_w = next_x - readout_x - 8;
      if(readout_w < 96)
         readout_w = 96;
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "pager_prev",
                          "Prev",
                          prev_x,
                          y + 3,
                          nav_btn_w,
                          18,
                          (can_prev ? ASC_HudThemeBgCardAlt() : ASC_HudThemeBgPanel()),
                          (can_prev ? ASC_HudThemeBorderEdge() : ASC_HudThemeBorderBase()),
                          (can_prev ? ASC_HudThemeTextPrimary() : ASC_HudThemeTextMuted()));
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "pager_next",
                          "Next",
                          next_x,
                          y + 3,
                          nav_btn_w,
                          18,
                          (can_next ? ASC_HudThemeBgCardAlt() : ASC_HudThemeBgPanel()),
                          (can_next ? ASC_HudThemeBorderEdge() : ASC_HudThemeBorderBase()),
                          (can_next ? ASC_HudThemeTextPrimary() : ASC_HudThemeTextMuted()));

      string page_line = (g_asc_hud.list_total_items > 0)
                         ? StringFormat("Page %d/%d • Rows %d-%d of %d",
                                        g_asc_hud.list_current_page,
                                        g_asc_hud.list_total_pages,
                                        g_asc_hud.list_range_start,
                                        g_asc_hud.list_range_end,
                                        g_asc_hud.list_total_items)
                         : StringFormat("Page %d/%d • Rows 0 of 0",
                                        g_asc_hud.list_current_page,
                                        g_asc_hud.list_total_pages);
      ASC_HudEnsureLabelAutoFit(ASC_HUD_PREFIX + "pager_page",
                                page_line,
                                readout_x,
                                y + 7,
                                8,
                                7,
                                ASC_HudThemeTextSecondary(),
                                readout_w);
      ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_show", "", 0, 0, 8, clrBlack);
      ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_lbl", "", 0, 0, 8, clrBlack);
     }
   else
     {
      ASC_HudTrackFamilyVisibility(g_asc_hud.proof_footer_pager_visible, false, g_asc_hud.proof_footer_pager_visibility_changes);
      ASC_HudEnsureRect(ASC_HUD_PREFIX + "pager_box", 0, 0, 0, 0, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "pager_prev", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "pager_next", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_lbl", "", 0, 0, 8, clrBlack);
      ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_page", "", 0, 0, 8, clrBlack);
      ASC_HudEnsureLabel(ASC_HUD_PREFIX + "pager_show", "", 0, 0, 8, clrBlack);
      ASC_HudEnsureLabelClamped(ASC_HUD_PREFIX + "status_text",
                                ASC_HudClampTextMiddle(status, ASC_HudCharsForWidth(w - 26, 8)),
                                x + 10,
                                y + 8,
                                8,
                                ASC_HudThemeTextPrimary(),
                                w - 20);
     }
  }

bool ASC_HudNeedsTacticalCadence()
  {
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   return (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
  }

int ASC_HudSymbolPriceDigits(const string symbol,const ASC_Layer2Packet &live_packet,const bool has_live_packet)
  {
   if(has_live_packet && live_packet.digits > 0)
      return (int)live_packet.digits;

   ASC_SymbolSpecification spec_snapshot;
   if(ASC_GetSymbolSpecification(symbol, spec_snapshot, false)
      && spec_snapshot.has_digits
      && spec_snapshot.digits >= 0)
      return (int)spec_snapshot.digits;

   return 5;
  }

bool ASC_HudRefreshSelectedSymbolTacticalFields()
  {
   if(!(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL))
      return false;

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
      return false;

   datetime now_utc = TimeGMT();
   ASC_Layer2Packet live_packet;
   bool has_packet_context = ASC_Layer2TryGetPacketBySymbol(selected.symbol, live_packet) && (live_packet.admitted || live_packet.tactical_only);
   bool has_live_packet = has_packet_context && ASC_L2PacketHasLawfulSnapshot(live_packet);
   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   ASC_SelectionFilterEvaluation filter;
   bool has_filter = false;
   bool has_filter_packet = false;
   double filter_score = 0.0;
   bool shortlist_found = ASC_HudResolveSelectionTruth(selected,
                                                       shortlist_entry,
                                                       shortlist_rank,
                                                       shortlist_total,
                                                       filter,
                                                       has_filter,
                                                       has_filter_packet,
                                                       filter_score);

   string filter_posture = has_filter ? filter.result_state_operator_text : "Awaiting Selection";
   string filter_next_step = has_filter ? filter.next_required_step : "Wait for shortlist publication.";
   string shortlist_line = shortlist_found
                           ? ASC_HudShortlistPriorityLine(shortlist_entry, shortlist_total)
                           : "Shortlist position is waiting for the next shortlist pass.";
   string shortlist_reason = shortlist_found ? ASC_HudShortlistReason(shortlist_entry) : "Shortlist position is waiting for the next lawful shortlist pass.";
   string snapshot_line = has_live_packet ? "Snapshot ready" : "Snapshot pending";
   int price_digits = ASC_HudSymbolPriceDigits(selected.symbol, live_packet, has_live_packet);
   string quote_posture = has_live_packet
                          ? ("Bid " + DoubleToString(live_packet.bid, price_digits) + " | Ask " + DoubleToString(live_packet.ask, price_digits))
                          : "Bid/Ask unavailable";
   string spread_posture = has_live_packet
                           ? StringFormat("Spread %.1f points | Snapshot age %d sec", live_packet.spread_points, live_packet.packet_age_sec)
                           : "Spread unavailable | Awaiting market-watch snapshot";
   bool has_day_packet = has_live_packet && ASC_L2PacketHasLawfulDayRange(live_packet);
   string day_change_posture = has_day_packet
                               ? ("Day change " + DoubleToString(live_packet.day_range_pct, 2) + "%")
                               : "Day change unavailable";
   string tick_age_text = ASC_HudAgeText(selected.observed_at_utc, now_utc);
   string last_live_age_text = (has_live_packet && live_packet.last_good_utc > 0)
                               ? ASC_HudAgeText(live_packet.last_good_utc, now_utc)
                               : "pending";
   string membership_state = shortlist_found ? shortlist_entry.membership_state : "pending";
   string total_posture = ASC_HudSymbolOverviewTotalPosture(selected, has_live_packet, has_filter, filter, shortlist_found, membership_state);
   string next_action = ASC_HudSymbolOverviewNextStep(selected, has_live_packet, has_filter, filter, shortlist_found, shortlist_entry);
   string tradability_state = has_filter ? (filter.tradability_is_open ? "Tradable" : "Restricted") : "Pending";
   string friction_state = has_filter ? ASC_ArtifactHumanizeLabel(ASC_TextOrUnavailable(filter.execution_friction_posture)) : "Pending";
   string spread_sanity = has_filter ? (filter.spread_is_sane ? "Sane" : "Stressed") : "Pending";
   string friction_line = "Tradability: " + tradability_state + " | Friction: " + friction_state + " | Spread sanity: " + spread_sanity;
   string session_state = ASC_HudOverviewSessionState(selected, has_live_packet, live_packet);
   string shortlist_status_line = shortlist_found
                                  ? ("Status " + ASC_ArtifactHumanizeLabel(membership_state) + " | " + ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total))
                                  : "Status pending | Overall pending | Bucket n/a | Group n/a | Raw n/a";
   string next_review = (StringLen(selected.next_check) > 0 ? selected.next_check : "pending");
   string compact_primary = ASC_HudOverviewCompactPrimaryPosture(selected, has_filter, filter, shortlist_found, membership_state, has_live_packet);
   string consumer_market_posture_text = ASC_ConsumerMarketPostureReadback(selected);
   string consumer_visible_ceiling_text = ASC_ConsumerVisibleLayerCeilingReadback(selected);
   string consumer_l34_source_text = ASC_ConsumerL34SourceIdentityReadback(selected, g_asc_hud.last_shortlist_source, shortlist_found, false);
   string consumer_path_identity_text = ASC_ConsumerPathIdentityReadback(false);

   bool changed = false;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_hero_l2",
                                         "Primary posture: " + compact_primary) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_hero_l3",
                                         "Next review: " + next_review + " | Next action: " + next_action) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_identity_l2",
                                         session_state + " | State: " + ASC_HudPrimaryOpenClosedState(selected.state)) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_identity_l3",
                                         "Market posture: " + consumer_market_posture_text + " | Visible ceiling: " + consumer_visible_ceiling_text + " | Path: " + consumer_path_identity_text) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_market_l1", friction_line) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_market_l2",
                                         has_live_packet ? ("Freshness: " + ASC_L2FreshnessToOperatorText(live_packet.freshness)
                                                            + " | Tick age: " + tick_age_text
                                                            + " | Snapshot age: " + IntegerToString(live_packet.packet_age_sec) + " sec"
                                                            + " | Last live: " + last_live_age_text)
                                                         : ("Freshness: " + ASC_HudSymbolFreshnessState(selected) + " | Tick age: " + tick_age_text + " | Awaiting market-watch snapshot")) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_market_l3", quote_posture + " | " + spread_posture + " | " + day_change_posture) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_tick_l1", "Selection posture: " + filter_posture) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_tick_l2", "Selection next-step: " + filter_next_step) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_tick_l3", "Session/tradability: " + session_state + " | " + tradability_state) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_pub_l1", "Shortlist: " + shortlist_status_line) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_pub_l2", "Summary: " + total_posture) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "sym_pub_l3", "L3/L4 source: " + consumer_l34_source_text + " | Rank owner: " + (shortlist_found ? ASC_HudRankSurfaceOwnerLine(shortlist_entry, shortlist_total) : "awaiting shortlist owner publication") + " | " + snapshot_line) || changed;

   if(g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
     {
      string quote_line_one = has_live_packet
                              ? ("Bid " + DoubleToString(live_packet.bid, price_digits) + " | Ask " + DoubleToString(live_packet.ask, price_digits))
                              : "Bid and ask are waiting for a current market-watch snapshot.";
      if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_OVERVIEW)
        {
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1",
                                               "State: " + ASC_HudPrimaryOpenClosedState(selected.state) + " | Opportunity: " + filter_posture) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2",
                                               "Freshness: " + ASC_HudSymbolFreshnessState(selected) + " | Confidence: " + ASC_L1ConfidenceToOperatorText(selected.confidence)) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", quote_line_one) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2",
                                               "Observed: " + ASC_HudAgeText(selected.observed_at_utc, now_utc) + " | Next review: " + (StringLen(selected.next_check) > 0 ? selected.next_check : "pending")) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3",
                                               shortlist_found ? ("Priority: " + ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total))
                                                               : "Priority: waiting for lawful shortlist placement.") || changed;
        }
      else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_MARKET_WATCH)
        {
         bool has_day_packet = has_live_packet && ASC_L2PacketHasLawfulDayRange(live_packet);
         bool has_spread_pct = (has_live_packet && live_packet.bid > 0.0 && live_packet.valid_spread);
         int quote_digits = ASC_HudSymbolPriceDigits(selected.symbol, live_packet, has_live_packet);
         double spread_points = has_live_packet ? live_packet.spread_points : 0.0;
         double spread_pct = 0.0;
         if(has_spread_pct)
            spread_pct = ((live_packet.spread_points * live_packet.point) / live_packet.bid) * 100.0;
         string daily_change_text = (has_live_packet && live_packet.valid_daily_change_pct)
                                    ? (DoubleToString(live_packet.daily_change_pct, 2) + "%")
                                    : (has_day_packet ? (DoubleToString(live_packet.day_range_pct, 2) + "%") : "unavailable");
         string open_close_line = has_live_packet
                                  ? ("Open " + (live_packet.valid_day_open ? DoubleToString(live_packet.day_open, quote_digits) : "unavailable")
                                     + " | Close " + (live_packet.valid_last_price ? DoubleToString(live_packet.last_price, quote_digits) : "unavailable"))
                                  : "Open/Close unavailable";
         string day_range_line = has_day_packet
                                 ? ("Day high " + DoubleToString(live_packet.day_high, quote_digits) + " | Day low " + DoubleToString(live_packet.day_low, quote_digits))
                                 : "Day high/low unavailable";
         string bid_extremes_line = has_day_packet
                                    ? ("Bid high " + DoubleToString(live_packet.day_high, quote_digits) + " | Bid low " + DoubleToString(live_packet.day_low, quote_digits))
                                    : "Bid high/low unavailable";
         string ask_extremes_line = has_day_packet
                                    ? ("Ask high " + DoubleToString(live_packet.day_high + (live_packet.valid_spread ? (live_packet.spread_points * live_packet.point) : 0.0), quote_digits)
                                       + " | Ask low " + DoubleToString(live_packet.day_low + (live_packet.valid_spread ? (live_packet.spread_points * live_packet.point) : 0.0), quote_digits))
                                    : "Ask high/low unavailable";
         string quote_time_line = has_live_packet
                                  ? ("Quote tick " + ASC_HudDateTimeText((live_packet.valid_tick_time && live_packet.tick_time_utc > 0) ? live_packet.tick_time_utc : live_packet.last_good_utc))
                                  : "Quote tick unavailable";
         string source_line = has_packet_context
                              ? (live_packet.has_packet ? "Source: live market snapshot"
                                 : ((live_packet.has_last_good || live_packet.continuity_backed) ? "Source: continuity snapshot" : "Source: market snapshot pending"))
                              : "Source: market snapshot pending";
         string freshness_line = has_live_packet
                                 ? ("Freshness " + ASC_L2FreshnessToOperatorText(live_packet.freshness)
                                    + " | Quote age " + IntegerToString(live_packet.packet_age_sec) + " sec")
                                 : ("Freshness " + ASC_HudSymbolFreshnessState(selected) + " | Quote age unavailable");
         string spread_line = has_live_packet
                              ? StringFormat("Spread %.1f points | Spread %s | Daily change %s", spread_points, has_spread_pct ? (DoubleToString(spread_pct, 3) + "%") : "unavailable", daily_change_text)
                              : "Spread is awaiting a current market-watch snapshot.";
         string execution_caution = ASC_HudMarketWatchExecutionCaution(selected, has_live_packet, live_packet, has_filter, filter);

         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", quote_line_one) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", spread_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", freshness_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", day_range_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", open_close_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", "Daily change " + daily_change_text) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", bid_extremes_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", ask_extremes_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3", quote_time_line + " | " + source_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l1", execution_caution) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l2", "Market state: " + ASC_HudPrimaryOpenClosedState(selected.state)) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l3", "Continuity-backed quote: " + ASC_HudYesNo(has_packet_context && live_packet.continuity_backed)) || changed;
        }
      else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER)
        {
         string supports_line = ASC_HudSelectionSupportsSummary(has_filter, filter);
         string blockers_line = ASC_HudSelectionBlockersSummary(has_filter, filter);
         string why_alive_line = ASC_HudSelectionWhyAliveSummary(has_filter, filter);
         string next_consequence = ASC_HudSelectionNextStepSummary(has_filter, filter);
      string score_posture_line = has_filter ? ASC_HudFilterScoreSummary(filter) : "Score posture pending shortlist snapshot.";
      string alive_line = "Candidate alive: ";
      if(!has_filter)
         alive_line += "Pending shortlist snapshot.";
         else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
            alive_line += "No; current filter gate is blocking this symbol.";
         else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
            alive_line += "Conditional; filter evidence is still building.";
         else
            alive_line += "Yes; filter gate is currently open.";
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1",
                                               alive_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2",
                                               "Why alive: " + why_alive_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3",
                                               "Score posture: " + score_posture_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", "Helping now: " + supports_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2",
                                               "Blocking now: " + blockers_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3",
                                               "Dependencies: " + (has_filter ? filter.dependencies_text : "Unavailable")) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1",
                                               "Corroboration: " + (has_filter ? filter.corroboration_text : "Unavailable")) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2",
                                               "What changes next: " + next_consequence) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3",
                                               "Next required step: " + filter_next_step) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l1",
                                               "Selection explains candidate survival and gate state only.") || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l2",
                                               ASC_HudShortlistLabel() + " explains rank, placement, and promotion context.") || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l3",
                                               ASC_HudDeepAnalysisLabel() + " explains deeper setup interpretation, not shortlist placement truth.") || changed;
        }
      else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT)
        {
         ASC_ShortlistSymbolSummary shortlist_context_entry;
         int shortlist_context_rank = 0;
         int shortlist_context_total = 0;
         bool shortlist_context_found = ASC_HudFindShortlistEntryForState(selected, shortlist_context_entry, shortlist_context_rank, shortlist_context_total);
         string state_line = shortlist_context_found
                             ? ("Shortlist state: " + ASC_ArtifactHumanizeLabel(shortlist_context_entry.membership_state)
                                + " | Band " + ASC_HudShortlistBandLabel(shortlist_context_entry.shortlist_band)
                                + " | Posture " + ASC_ArtifactHumanizeLabel(shortlist_context_entry.shortlist_posture))
                             : "Shortlist state: pending placement.";
         string rank_line = shortlist_context_found
                            ? ASC_HudShortlistRankContextLine(shortlist_context_entry, shortlist_context_total)
                            : "Overall rank pending | Bucket rank pending";
         string why_position_line = shortlist_context_found
                                    ? ASC_HudShortlistMeaningLine(shortlist_context_entry)
                                    : "Why in this position is pending shortlist placement.";
         string placement_meaning_line = shortlist_context_found
                                         ? ASC_HudShortlistBandMeaningSummary(shortlist_context_entry)
                                         : "Placement meaning: pending until shortlist placement is published.";
         string promotion_pressure_line = shortlist_context_found
                                          ? ASC_HudShortlistPromotionPressureSummary(shortlist_context_entry)
                                          : "Promotion pressure is pending shortlist placement.";
         string conflict_line = shortlist_context_found
                                ? ASC_HudShortlistConflictSummary(shortlist_context_entry)
                                : "Conflict/correlation/exposure pressure is pending shortlist placement.";
         string relative_strength_line = shortlist_context_found
                                         ? ASC_HudShortlistRelativeStrengthSummary(shortlist_context_entry)
                                         : "Relative strength context is pending shortlist placement.";
         string improve_line = shortlist_context_found
                               ? ASC_HudShortlistImproveSummary(shortlist_context_entry)
                               : "What would improve is pending shortlist placement.";
         string weaken_line = shortlist_context_found
                              ? ASC_HudShortlistWeakenSummary(shortlist_context_entry)
                              : "What would weaken is pending shortlist placement.";
         string next_path_line = shortlist_context_found
                                 ? ASC_HudShortlistLikelyPathSummary(shortlist_context_entry)
                                 : "Next likely path is pending shortlist placement.";

         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", "Placement state: " + state_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", rank_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", placement_meaning_line + " | Why: " + why_position_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", "Promotion context: " + promotion_pressure_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", "Conflict/correlation/exposure: " + conflict_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", relative_strength_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", improve_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", weaken_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3", "Next likely shortlist path: " + next_path_line) || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l1", "Shortlist explains placement, promotion context, reserve/promoted meaning, and pressure.") || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l2", "Selection survival status is upstream context, not placement meaning.") || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l3", ASC_HudDeepAnalysisLabel() + " adds setup interpretation after placement context is clear.") || changed;
        }
      else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS)
        {
         string deep_posture = ASC_HudDeepAnalysisPostureTag(selected, has_live_packet);
         string deep_gate_reason = "";
         bool deep_action_ready = ASC_HudDeepAnalysisEnabled(deep_gate_reason);
         if(!deep_action_ready && deep_posture == "Ready")
            deep_posture = "Awaiting selected symbol action context";

         string current_focus_text = "";
         bool using_stale_cache = false;
         bool has_current_focus = ASC_HudReadCurrentFocusCached(current_focus_text, using_stale_cache);
         string readback_source = has_current_focus ? (using_stale_cache ? "Current Focus [STALE CACHE]" : "Current Focus") : g_asc_hud.current_focus_cache_posture;
         string focus_symbol = has_current_focus ? g_asc_hud.cf_vm_symbol : "";
         string focus_canonical = has_current_focus ? g_asc_hud.cf_vm_canonical : "";
         string focus_deep_posture = has_current_focus ? g_asc_hud.cf_vm_deep_posture : "";
         string focus_deep_summary = has_current_focus ? g_asc_hud.cf_vm_deep_summary : "";
         string focus_score_context = has_current_focus ? g_asc_hud.cf_vm_score_context : "";
         string focus_microstructure_summary = has_current_focus ? g_asc_hud.cf_vm_microstructure : "";
         string focus_refresh_request_id = has_current_focus ? g_asc_hud.cf_vm_refresh_request_id : "";
         string focus_published = has_current_focus ? g_asc_hud.cf_vm_published : "";
         bool trigger_queued = g_asc_hud.deep_trigger_pending && ASC_HudSelectedSymbolMatches(selected, g_asc_hud.deep_trigger_symbol);
         string trigger_status_text = ASC_HudDeepTriggerStatusText(g_asc_hud.deep_trigger_last_status);
         string blocker_reason = ASC_TextOrUnavailable(g_asc_hud.deep_trigger_runtime_reason);
         if((StringLen(blocker_reason) <= 0 || blocker_reason == "Unavailable")
            && StringLen(g_asc_hud.current_focus_runtime_reason) > 0)
            blocker_reason = g_asc_hud.current_focus_runtime_reason;

         string selected_canonical = selected.classification.canonical_symbol;
         if(StringLen(selected_canonical) <= 0)
            selected_canonical = selected.identity.canonical_symbol;
         if(StringLen(selected_canonical) <= 0)
            selected_canonical = selected.identity.normalized_symbol;
         bool focus_selected_match = ASC_HudSelectedSymbolMatches(selected, focus_symbol);
         bool focus_canonical_match = (StringLen(selected_canonical) > 0
                                       && (focus_canonical == selected_canonical || focus_symbol == selected_canonical));
         bool focus_matches = (focus_selected_match || focus_canonical_match);
         if(deep_posture == "Ready")
           {
            if(has_current_focus && !focus_matches)
               deep_posture = "Awaiting selected symbol alignment";
            else if(!has_current_focus && !trigger_queued)
               deep_posture = "Awaiting selected symbol readback";
           }
         bool focus_has_completed_block = false;
         if((!has_current_focus || !focus_matches) && StringLen(readback_source) <= 0)
            readback_source = "";
         if(has_current_focus && focus_matches)
            focus_has_completed_block = g_asc_hud.cf_vm_completed_truth;
         bool deep_view_opened = (g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS);
         string lifecycle_state = ASC_HudDeepLifecycleState(selected,
                                                            g_asc_hud.deep_trigger_last_status,
                                                            trigger_queued,
                                                            focus_matches,
                                                            focus_has_completed_block,
                                                            focus_deep_posture,
                                                            deep_view_opened);
         string readiness_summary = has_current_focus && focus_matches
                                    ? g_asc_hud.cf_vm_deep_readiness_summary
                                    : "subsections ready 0/8";
         string timeframe_preview = has_current_focus && focus_matches
                                    ? g_asc_hud.cf_vm_timeframe_preview
                                    : "timeframe summary preview unavailable";
         string verification_hint = ASC_TextOrUnavailable(g_asc_hud.deep_trigger_last_status);

         string readback_line_1 = has_current_focus
                                  ? ((StringLen(readback_source) > 0 ? (readback_source + " found") : "Current Focus found")
                                     + (StringLen(focus_published) > 0 ? (" | " + focus_published) : "")
                                     + (StringLen(focus_refresh_request_id) > 0 ? (" | request=" + focus_refresh_request_id) : ""))
                                  : (trigger_queued ? "Current Focus refresh is queued from explicit Full Analysis trigger."
                                                    : "Current Focus is not yet available.");
         string readback_line_2 = (has_current_focus && focus_matches)
                                  ? ("Selected match: " + ASC_HudYesNo(focus_selected_match)
                                     + " | Symbol alias match: " + ASC_HudYesNo(focus_canonical_match)
                                     + " | Readback symbol: " + (StringLen(focus_symbol) > 0 ? focus_symbol : selected.symbol))
                                  : (has_current_focus ? ("Current Focus is still tracking " + (StringLen(focus_symbol) > 0 ? focus_symbol : "another symbol"))
                                                       : "Readback will appear after a lawful write.");
         string deep_thesis = (has_current_focus && focus_matches && focus_has_completed_block && StringLen(focus_deep_summary) > 0)
                              ? focus_deep_summary
                              : ("Posture " + deep_posture + " | Conviction contract is staged for the next packet pass.");
         string timing_trigger = "Timing/trigger: " + lifecycle_state + " | Trigger " + trigger_status_text;
         string risk_geometry = (has_current_focus && focus_matches && focus_has_completed_block && StringLen(focus_score_context) > 0)
                                ? ("Main risk/caution: " + focus_score_context)
                                : "Main risk/caution: invalidation and reward geometry are still incomplete.";
         string execution_friction = (has_current_focus && focus_matches && focus_has_completed_block && StringLen(focus_microstructure_summary) > 0)
                                     ? ("Execution friction: " + focus_microstructure_summary)
                                     : "Execution friction: spread/session/liquidity confirmation is still forming.";
         string current_read_line = "Current Full Analysis read: posture " + deep_posture + " | " + lifecycle_state;
         string thesis_line = "Main thesis: " + deep_thesis;
         string x_tf_line = "Cross-timeframe alignment: " + timeframe_preview + " | Selected match " + ASC_HudYesNo(focus_matches);
         string change_line = "Last refresh change: " + readback_line_1 + " | " + verification_hint;
         string watch_next_line = (deep_posture == "Ready")
                                  ? "Watch next: trigger confirmation, invalidation discipline, and execution quality before acting."
                                  : ((deep_posture == "Attention")
                                     ? "Watch next: wait for cleaner trigger alignment and tighter risk geometry."
                                     : "Watch next: wait for dossier refresh completion before escalating conviction.");

         current_read_line = ASC_HudTraderSafeSummary(current_read_line, "Current Full Analysis read: summary available", 108);
         thesis_line = "Main thesis: " + ASC_HudTraderSafeSummary(deep_thesis, "thesis pending", 92);
         risk_geometry = "Main risk/caution: " + ASC_HudTraderSafeSummary(focus_score_context, "invalidation and reward geometry are still incomplete", 88);
         x_tf_line = "Cross-timeframe alignment: " + ASC_HudTraderSafeSummary(timeframe_preview, "alignment summary pending", 88) + " | Selected match " + ASC_HudYesNo(focus_matches);
         change_line = "Last refresh change: " + ASC_HudTraderSafeSummary(readback_line_1 + " | " + verification_hint, "refresh delta summary pending", 96);
         watch_next_line = ASC_HudTraderSafeSummary(watch_next_line, "Watch next: wait for cleaner confirmation.", 96);
         execution_friction = ASC_HudTraderSafeSummary(execution_friction, "Execution friction: confirmation pending.", 96);

         string timing_accel = StringLen(focus_deep_posture) > 0
                               ? ("Momentum acceleration: " + focus_deep_posture)
                               : "Momentum acceleration: pending fuller readback.";
         string timing_age = "Move age: " + ASC_HudAgeText(selected.observed_at_utc, now_utc) + " | Impulse freshness: " + ASC_HudSymbolFreshnessState(selected);
         string structure_state = has_day_packet
                                  ? StringFormat("Range position: bid %.5f vs day [%.5f, %.5f]", live_packet.bid, live_packet.day_low, live_packet.day_high)
                                  : "Range position: pending live packet range snapshot.";
         string structure_liquidity = "Liquidity zone / sweep state: " + ASC_TextOrUnavailable(focus_microstructure_summary);
         string execution_quality = "Execution quality: " + ASC_HudPrimaryOpenClosedState(selected.state) + " | " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_score_context), "quality context pending", 52);
         string execution_participation = "Participation quality: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_deep_posture), "participation pending", 40);
         string execution_tradability = "Scalp/intraday tradability: " + deep_posture + " | " + ASC_HudPrimaryOpenClosedState(selected.state);
         string execution_bid_ask_spread = has_live_packet
                                           ? ("Bid/Ask/Spread: "
                                              + DoubleToString(live_packet.bid, price_digits)
                                              + " / " + DoubleToString(live_packet.ask, price_digits)
                                              + " / " + DoubleToString(live_packet.spread_points, 1) + "pt")
                                           : "Bid/Ask/Spread: pending live packet.";
         double mid_price = (has_live_packet ? ((live_packet.bid + live_packet.ask) / 2.0) : 0.0);
         double spread_pct = (has_live_packet && mid_price > 0.0) ? (100.0 * (live_packet.ask - live_packet.bid) / mid_price) : -1.0;
         string execution_spread_pct = (spread_pct >= 0.0)
                                       ? ("Spread %: " + DoubleToString(spread_pct, 3) + "%")
                                       : "Spread %: pending";
         string execution_score_line = StringLen(focus_score_context) > 0
                                       ? ("Execution score: " + ASC_HudTraderSafeSummary(focus_score_context, "pending dossier score context", 80))
                                       : "Execution score: pending dossier score context.";
         string scalp_tradable = (deep_posture == "Ready" && has_live_packet && live_packet.spread_points <= 25.0) ? "Yes" : "No";
         string intraday_tradable = ((deep_posture == "Ready" || deep_posture == "Attention") && ASC_HudPrimaryOpenClosedState(selected.state) == "Open") ? "Yes" : "No";
         string execution_tradable_line = "Scalp tradable: " + scalp_tradable + " | Intraday tradable: " + intraday_tradable;
         string execution_caution_line = "Execution caution/action: " + watch_next_line;
         string timing_trigger_line = "Trigger posture: " + timing_trigger;
         string timing_pressure_line = "Pressure shift score/posture: " + change_line;
         string timing_momentum_line = "Momentum acceleration score/posture: " + timing_accel;
         string timing_move_age_line = "Move age score/posture: " + timing_age;
         string timing_impulse_freshness_line = "Impulse freshness: " + ASC_HudSymbolFreshnessState(selected);
         string timing_time_since_impulse_line = "Time since last impulse: " + ASC_HudAgeText(selected.observed_at_utc, now_utc);
         string timing_next_path_line = (deep_posture == "Ready")
                                        ? "Next likely timing path: trigger can convert if timing remains aligned."
                                        : ((deep_posture == "Attention")
                                           ? "Next likely timing path: timing is building; watch for confirmation pivot."
                                           : "Next likely timing path: timing alignment still forming before trigger conversion.");
         string timing_caution_line = focus_matches
                                      ? ((deep_posture == "Ready")
                                         ? "Timing caution: stay disciplined on invalidation once trigger fires."
                                         : "Timing caution: avoid forcing entries before timing alignment confirms.")
                                      : "Timing caution: selected symbol is not fully aligned with the latest Full Analysis readback.";
         string structure_daily_line = has_day_packet
                                      ? ("Daily open/change: " + DoubleToString(live_packet.day_open, price_digits) + " | " + DoubleToString(live_packet.day_range_pct, 2) + "%")
                                      : "Daily open/change: pending live packet.";
         string structure_position_line = "Position in range: " + structure_state;
         string structure_dist_high_line = has_day_packet
                                          ? StringFormat("Distance to recent high: %.1f points", live_packet.day_high - live_packet.bid)
                                          : "Distance to recent high: pending";
         string structure_dist_low_line = has_day_packet
                                         ? StringFormat("Distance to recent low: %.1f points", live_packet.bid - live_packet.day_low)
                                         : "Distance to recent low: pending";
         string structure_liquidity_line = "Liquidity score/zone/posture: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_microstructure_summary), "liquidity map pending", 64);
         string structure_sweep_line = "Sweep state: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(g_asc_hud.cf_vm_sweep_state), "not flagged in current packet", 48);
         string structure_bias_line = g_asc_hud.cf_vm_bias_summary;
         string structure_alignment_line = "Alignment summary: " + x_tf_line;
         string pressure_state = risk_geometry;
         string momentum_state = timing_accel;
         string move_age_state = timing_age;
         string participation_state = execution_participation;
         string execution_state = execution_friction;
         string liquidity_state = structure_liquidity;
         string timeframe_state = x_tf_line;
         string trigger_state = timing_trigger;
         string refresh_key = selected.symbol + "|" + readback_line_1 + "|" + verification_hint;
         string changed_summary = ASC_HudDeepBuildChangeSummary(refresh_key,
                                                               pressure_state,
                                                               momentum_state,
                                                               move_age_state,
                                                               participation_state,
                                                               execution_state,
                                                               liquidity_state,
                                                               timeframe_state,
                                                               trigger_state);
         string changed_since_refresh = ASC_HudTraderSafeSummary(changed_summary, "What changed since last refresh: pending", 96);
         string changed_probe = changed_since_refresh;
         StringToLower(changed_probe);
         if(StringFind(changed_probe, "what changed:") != 0
            && StringFind(changed_probe, "what changed since last refresh:") != 0)
            changed_since_refresh = "What changed since last refresh: " + changed_since_refresh;
         string alignment_summary = "Alignment summary: " + ASC_HudTraderSafeSummary(readback_line_2, "selected symbol alignment pending", 88);

         bool timeframe_rows_applied = false;
         if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_THESIS)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", "Full Analysis status: " + current_read_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", "Last refresh/freshness: " + change_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", thesis_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", risk_geometry) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", "Trigger/timing posture: " + timing_trigger) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", "Execution/friction posture: " + execution_friction) || changed;
           }
         else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_TIMING)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", timing_trigger_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", timing_pressure_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", timing_momentum_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", timing_move_age_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", timing_impulse_freshness_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", timing_time_since_impulse_line) || changed;
           }
         else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_STRUCTURE)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", structure_daily_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", structure_position_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", structure_dist_high_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", structure_dist_low_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", structure_liquidity_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", structure_sweep_line) || changed;
           }
         else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_EXECUTION)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", execution_bid_ask_spread) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", execution_spread_pct + " | " + execution_friction) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", execution_score_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", "Liquidity quality: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_microstructure_summary), "liquidity quality pending", 56)) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", execution_participation) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", execution_tradable_line) || changed;
           }
         else
           {
            int tf_count = has_current_focus ? g_asc_hud.cf_vm_timeframe_row_count : 0;
            timeframe_rows_applied = true;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", tf_count > 0 ? g_asc_hud.cf_vm_timeframe_rows[0] : "No timeframe decision rows available yet.") || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", tf_count > 1 ? g_asc_hud.cf_vm_timeframe_rows[1] : "Awaiting additional timeframe rows.") || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", tf_count > 2 ? g_asc_hud.cf_vm_timeframe_rows[2] : "Use Timing/Structure subpages for more row context.") || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l1", tf_count > 3 ? g_asc_hud.cf_vm_timeframe_rows[3] : "Alignment snapshot: " + x_tf_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l2", tf_count > 4 ? g_asc_hud.cf_vm_timeframe_rows[4] : "Change snapshot: " + changed_since_refresh) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", tf_count > 5 ? g_asc_hud.cf_vm_timeframe_rows[5] : "Watch snapshot: " + watch_next_line) || changed;
           }

         if(timeframe_rows_applied)
           {
            int tf_count_c = has_current_focus ? g_asc_hud.cf_vm_timeframe_row_count : 0;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", tf_count_c > 6 ? g_asc_hud.cf_vm_timeframe_rows[6] : "Cross-timeframe alignment: " + x_tf_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", tf_count_c > 7 ? g_asc_hud.cf_vm_timeframe_rows[7] : changed_since_refresh) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3", tf_count_c > 8 ? g_asc_hud.cf_vm_timeframe_rows[8] : ("Next watch item: " + watch_next_line)) || changed;
           }
         else
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", "Cross-timeframe alignment: " + x_tf_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", changed_since_refresh) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3",
                                                  "Next watch item: " + watch_next_line) || changed;
           }
         if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_EXECUTION)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", execution_quality) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", execution_tradability) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3", execution_caution_line) || changed;
           }
         if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_TIMING)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", timing_next_path_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", "Next watch item: " + watch_next_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3", timing_caution_line) || changed;
           }
         if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_STRUCTURE)
           {
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l1", structure_bias_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l2", structure_alignment_line) || changed;
            changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_c_l3", "Structure caution: " + risk_geometry) || changed;
           }
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l1",
                                               "Full Analysis role: curated operator summary of the selected symbol dossier.") || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l2",
                                               "Full details stay in Current Focus and dossier artifact.") || changed;
         changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_d_l3",
                                               alignment_summary + " | Runtime: " + blocker_reason) || changed;
        }
     }

   return changed;
  }

void ASC_HudRefreshTacticalCadence()
  {
   if(!ASC_HudNeedsTacticalCadence())
      return;

   datetime now_utc = TimeGMT();
   bool changed = ASC_HudRefreshSelectedSymbolTacticalFields();

   if(changed)
     {
     g_asc_hud.proof_tactical_refresh_count++;
      g_asc_hud.last_tactical_refresh_utc = now_utc;
     if(!ASC_HudIsDirty())
       {
        ASC_HudRequestRedraw();
       }
     }
  }

bool ASC_HudIsLiveMarketWatchContext()
  {
   return (g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL
           && g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_MARKET_WATCH
           && StringLen(g_asc_hud.selected_symbol) > 0);
  }

void ASC_HudStartMarketWatchLiveFeed(const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return;
   if(g_asc_hud.market_watch_live_feed_active && g_asc_hud.market_watch_live_feed_symbol == symbol)
      return;

   g_asc_hud.market_watch_live_feed_active = true;
   g_asc_hud.market_watch_live_feed_symbol = symbol;
   g_asc_hud.market_watch_live_feed_started_utc = TimeGMT();
   g_asc_hud.market_watch_live_refresh_signature = "";
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudMarketWatchLiveFeed", symbol,
               StringFormat("market_watch_live_feed_started page=%s section=%s symbol=%s",
                            ASC_HudPageName(g_asc_hud.page),
                            ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section),
                            symbol));
  }

void ASC_HudStopMarketWatchLiveFeed(const string reason)
  {
   if(!g_asc_hud.market_watch_live_feed_active)
      return;

   string active_symbol = g_asc_hud.market_watch_live_feed_symbol;
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudMarketWatchLiveFeed", active_symbol,
               StringFormat("market_watch_live_feed_stopped reason=%s page=%s section=%s active_symbol=%s",
                            reason,
                            ASC_HudPageName(g_asc_hud.page),
                            ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section),
                            active_symbol));

   g_asc_hud.market_watch_live_feed_active = false;
   g_asc_hud.market_watch_live_feed_symbol = "";
   g_asc_hud.market_watch_live_feed_started_utc = 0;
   g_asc_hud.market_watch_live_refresh_signature = "";
   g_asc_hud.market_watch_live_last_source = "";
   g_asc_hud.market_watch_live_last_patch_ms = 0;
  }

void ASC_HudUpdateMarketWatchLiveFeedLifecycle()
  {
   if(ASC_HudIsLiveMarketWatchContext())
     {
      ASC_HudStartMarketWatchLiveFeed(g_asc_hud.selected_symbol);
      return;
     }

   string reason = "page_change";
   if(g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL && g_asc_hud.selected_symbol_section != ASC_HUD_SYMBOL_SECTION_MARKET_WATCH)
      reason = "section_change";
   else if(StringLen(g_asc_hud.selected_symbol) <= 0)
      reason = "symbol_cleared";
   ASC_HudStopMarketWatchLiveFeed(reason);
  }

void ASC_HudLogMarketWatchLiveRefresh(const ASC_Layer1SymbolState &selected,
                                      const bool admitted,
                                      const string source,
                                      const datetime last_quote_utc,
                                      const bool fallback_active)
  {
   datetime now_utc = TimeGMT();
   string signature = selected.symbol + "|" + (admitted ? "admitted" : "fallback") + "|" + source + "|" + IntegerToString((int)last_quote_utc);
   bool changed = (signature != g_asc_hud.market_watch_live_refresh_signature);
   bool periodic = (g_asc_hud.market_watch_live_last_log_utc <= 0 || (now_utc - g_asc_hud.market_watch_live_last_log_utc) >= 5);
   if(!changed && !periodic)
      return;

   g_asc_hud.market_watch_live_refresh_signature = signature;
   g_asc_hud.market_watch_live_last_log_utc = now_utc;
   g_asc_hud.market_watch_live_last_quote_utc = last_quote_utc;
   g_asc_hud.market_watch_live_last_source = source;

   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudMarketWatchLiveRefresh", selected.symbol,
               StringFormat("admitted=%s source=%s last_live_quote=%s fallback=%s",
                            admitted ? "yes" : "no",
                            source,
                            ASC_HudDateTimeText(last_quote_utc),
                            fallback_active ? "active" : "none"));
  }

bool ASC_HudRefreshMarketWatchLiveCadence()
  {
   if(!ASC_HudCanApplyCommittedContextPatch())
      return false;
   if(!ASC_HudIsLiveMarketWatchContext()
      || !g_asc_hud.market_watch_live_feed_active
      || g_asc_hud.market_watch_live_feed_symbol != g_asc_hud.selected_symbol)
      return false;

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
      return false;

   ASC_Layer2Packet live_packet;
   bool has_live_packet = ASC_Layer2TryGetPacketBySymbol(selected.symbol, live_packet)
                          && (live_packet.admitted || live_packet.tactical_only);
   string source = "live-quote-path-unavailable";
   bool fallback_active = true;
   if(has_live_packet && live_packet.has_packet)
     {
      source = "layer2-live-packet";
      fallback_active = false;
     }
   else if(has_live_packet && (live_packet.has_last_good || live_packet.continuity_backed))
      source = "layer2-continuity-cache";

   datetime last_quote_utc = 0;
   if(has_live_packet && live_packet.valid_tick_time && live_packet.tick_time_utc > 0)
      last_quote_utc = live_packet.tick_time_utc;
   else if(has_live_packet && live_packet.quote_observed_utc > 0)
      last_quote_utc = live_packet.quote_observed_utc;
   else if(has_live_packet && live_packet.last_good_utc > 0)
      last_quote_utc = live_packet.last_good_utc;

   ASC_HudLogMarketWatchLiveRefresh(selected, has_live_packet, source, last_quote_utc, fallback_active);

   g_asc_hud.proof_tactical_attempt_count++;
   bool changed = ASC_HudRefreshSelectedSymbolTacticalFields();
   if(!changed)
      return false;

   g_asc_hud.proof_tactical_refresh_count++;
   g_asc_hud.proof_selected_symbol_live_refresh_count++;
   g_asc_hud.proof_last_selected_symbol_live_refresh_utc = TimeGMT();
   g_asc_hud.last_tactical_refresh_utc = TimeGMT();
   if(!ASC_HudIsDirty())
     {
      ASC_HudRequestRedraw();
     }
   return true;
  }

bool ASC_HudRefreshClockCadence(const int heartbeat_counter)
  {
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   g_asc_hud.proof_last_tactical_heartbeat_counter = heartbeat_counter;
   if(!ASC_HudCanApplyClockPatch())
      return false;
   int clock_refresh_heartbeat = MathMax(1, ASC_HUD_CLOCK_REFRESH_HEARTBEATS);
   if(heartbeat_counter > 0 && (heartbeat_counter % clock_refresh_heartbeat) != 0)
     {
      g_asc_hud.proof_clock_skipped_due_cadence_count++;
      return false;
     }

   datetime now_utc = TimeGMT();
   string clock_text = TimeToString(now_utc, TIME_DATE|TIME_SECONDS);
   if(clock_text == g_asc_hud.proof_clock_last_visible_text_token)
     {
      g_asc_hud.hud_clock_text_unchanged++;
      g_asc_hud.hud_status_text_cache_hit++;
      g_asc_hud.hud_text_build_skipped += 2;
      g_asc_hud.hud_render_string_build_avoided += 2;
      g_asc_hud.proof_string_build_avoided += 2;
      return false;
     }
   g_asc_hud.proof_tactical_attempt_count++;
   g_asc_hud.proof_clock_update_attempt_count++;
   g_asc_hud.proof_clock_last_attempt_utc = now_utc;
   bool changed = false;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "hdr_clock_text", clock_text) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "hdr_clock_meta",
                                         ASC_HudClockMetaText(heartbeat_counter, now_utc)) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "ov_clock_text", clock_text) || changed;
   if(!changed)
      return false;

   g_asc_hud.proof_tactical_refresh_count++;
   g_asc_hud.proof_clock_refresh_count++;
   g_asc_hud.proof_clock_label_change_success_count++;
   g_asc_hud.hud_clock_minimal_update++;
   g_asc_hud.hud_full_render_avoided++;
   g_asc_hud.proof_clock_last_visible_text_token = clock_text;
   g_asc_hud.proof_clock_last_success_utc = now_utc;
   g_asc_hud.proof_clock_elapsed_since_last_success_sec = 0;
   g_asc_hud.last_tactical_refresh_utc = now_utc;
   if(!ASC_HudIsDirty())
     {
      g_asc_hud.proof_clock_redraw_requested_count++;
      ASC_HudRequestRedraw();
     }
   return true;
  }

bool ASC_HudRefreshDisplayOnlyFastPath(const int heartbeat_counter,const bool from_chart_event)
  {
   bool refresh_applied = false;
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   if(!ASC_HudCanApplyCommittedContextPatch())
     {
      g_asc_hud.proof_fast_display_guard_reject_count++;
      return false;
     }

   uint now_ms = GetTickCount();
   uint elapsed_ms = now_ms - g_asc_hud.fast_display_last_patch_ms;
   if(g_asc_hud.fast_display_last_patch_ms > 0 && elapsed_ms < ASC_HUD_FAST_DISPLAY_REFRESH_MS)
      return false;

   ulong shortlist_revision_before = g_asc_hud.last_shortlist_revision;
   int shortlist_count_before = g_asc_hud.last_shortlist_count;
   string shortlist_source_before = g_asc_hud.last_shortlist_source;
   ulong symbol_list_revision_before = g_asc_hud.selected_symbol_list_revision;
   ulong symbol_list_shortlist_revision_before = g_asc_hud.selected_symbol_list_shortlist_revision;
   uint data_fingerprint_before = g_asc_hud.last_data_fingerprint;
   uint structure_fingerprint_before = g_asc_hud.last_structure_fingerprint;
   uint tactical_fingerprint_before = g_asc_hud.last_tactical_fingerprint;

   datetime now_utc = TimeGMT();
   string clock_text = TimeToString(now_utc, TIME_DATE|TIME_SECONDS);
   if(clock_text == g_asc_hud.proof_clock_last_visible_text_token)
     {
      g_asc_hud.hud_clock_text_unchanged++;
      g_asc_hud.hud_status_text_cache_hit++;
      g_asc_hud.hud_text_build_skipped += 2;
      g_asc_hud.hud_render_string_build_avoided += 2;
      g_asc_hud.proof_string_build_avoided += 2;
      return false;
     }
   g_asc_hud.proof_tactical_attempt_count++;
   g_asc_hud.proof_clock_update_attempt_count++;
   g_asc_hud.proof_clock_last_attempt_utc = now_utc;
   bool changed = false;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "hdr_clock_text", clock_text) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "hdr_clock_meta", ASC_HudClockMetaText(heartbeat_counter, now_utc)) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "ov_clock_text", clock_text) || changed;

   bool ownership_unchanged = (shortlist_revision_before == g_asc_hud.last_shortlist_revision
                               && shortlist_count_before == g_asc_hud.last_shortlist_count
                               && shortlist_source_before == g_asc_hud.last_shortlist_source
                               && symbol_list_revision_before == g_asc_hud.selected_symbol_list_revision
                               && symbol_list_shortlist_revision_before == g_asc_hud.selected_symbol_list_shortlist_revision
                               && data_fingerprint_before == g_asc_hud.last_data_fingerprint
                               && structure_fingerprint_before == g_asc_hud.last_structure_fingerprint
                               && tactical_fingerprint_before == g_asc_hud.last_tactical_fingerprint);
   if(!ownership_unchanged)
     {
      g_asc_hud.proof_fast_display_guard_reject_count++;
      ASC_LogInfo("ASC_HUD_Manager",
                  "ASC_HudRefreshDisplayOnlyFastPath",
                  g_asc_hud.selected_symbol,
                  "fast display-only path ownership guard blocked: shortlist/symbol-list ownership changed");
      return false;
     }

   if(changed)
     {
      g_asc_hud.fast_display_last_patch_ms = now_ms;
      g_asc_hud.proof_fast_display_patch_count++;
      g_asc_hud.proof_tactical_refresh_count++;
      g_asc_hud.proof_clock_refresh_count++;
      g_asc_hud.proof_clock_label_change_success_count++;
      g_asc_hud.hud_clock_minimal_update++;
      g_asc_hud.hud_full_render_avoided++;
      g_asc_hud.proof_clock_last_visible_text_token = clock_text;
      g_asc_hud.proof_clock_last_success_utc = now_utc;
      g_asc_hud.proof_clock_elapsed_since_last_success_sec = 0;
      g_asc_hud.last_tactical_refresh_utc = now_utc;
      g_asc_hud.proof_last_tactical_heartbeat_counter = heartbeat_counter;
      if(!ASC_HudIsDirty())
        {
         g_asc_hud.proof_clock_redraw_requested_count++;
         ASC_HudRequestRedraw();
        }

      if(from_chart_event)
         g_asc_hud.last_render_snapshot_signature = ASC_HudVisibleSnapshotSignature();
      refresh_applied = true;
     }

   return refresh_applied;
  }

bool ASC_HudRefreshSelectedSymbolMicroLive()
  {
   if(!g_asc_trader_controls.hud_enabled)
      return false;
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return false;
   if(!ASC_HudCanApplyCommittedContextPatch())
      return false;

   uint now_ms = GetTickCount();
   uint elapsed_ms = now_ms - g_asc_hud.market_watch_live_last_patch_ms;
   if(g_asc_hud.market_watch_live_last_patch_ms > 0 && elapsed_ms < ASC_HUD_FAST_DISPLAY_REFRESH_MS)
      return false;

   bool changed = false;
   datetime now_utc = TimeGMT();

   bool live_symbol_scope = (g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL
                             && g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_MARKET_WATCH
                             && StringLen(g_asc_hud.selected_symbol) > 0);
   if(!live_symbol_scope)
     {
      if(changed && !ASC_HudIsDirty())
        {
         ASC_HudRequestRedraw();
        }
      return changed;
     }

   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
     {
      if(changed && !ASC_HudIsDirty())
        {
         ASC_HudRequestRedraw();
        }
      return changed;
     }

   ASC_Layer2Packet live_packet;
   bool has_packet_context = ASC_Layer2TryGetPacketBySymbol(selected.symbol, live_packet)
                             && (live_packet.admitted || live_packet.tactical_only);
   bool has_live_packet = has_packet_context && ASC_L2PacketHasLawfulSnapshot(live_packet);
   bool has_day_packet = has_packet_context && ASC_L2PacketHasLawfulDayRange(live_packet);
   int quote_digits = ASC_HudSymbolPriceDigits(selected.symbol, live_packet, has_live_packet);
   bool has_spread_pct = (has_live_packet && live_packet.bid > 0.0 && live_packet.valid_spread);
   double spread_points = has_live_packet ? live_packet.spread_points : 0.0;
   double spread_pct = 0.0;
   if(has_spread_pct)
      spread_pct = ((live_packet.spread_points * live_packet.point) / live_packet.bid) * 100.0;

   string daily_change_text = (has_live_packet && live_packet.valid_daily_change_pct)
                              ? (DoubleToString(live_packet.daily_change_pct, 2) + "%")
                              : (has_day_packet ? (DoubleToString(live_packet.day_range_pct, 2) + "%") : "unavailable");
   string quote_line_one = has_live_packet
                           ? ("Bid " + DoubleToString(live_packet.bid, quote_digits) + " | Ask " + DoubleToString(live_packet.ask, quote_digits))
                           : "Bid and ask are waiting for a current market-watch snapshot.";
   string spread_line = has_live_packet
                        ? StringFormat("Spread %.1f points | Spread %s | Daily change %s",
                                       spread_points,
                                       has_spread_pct ? (DoubleToString(spread_pct, 3) + "%") : "unavailable",
                                       daily_change_text)
                        : "Spread is awaiting a current market-watch snapshot.";
   string freshness_line = has_live_packet
                           ? ("Freshness " + ASC_L2FreshnessToOperatorText(live_packet.freshness) + " | Quote age " + IntegerToString(live_packet.packet_age_sec) + " sec")
                           : ("Freshness " + ASC_HudSymbolFreshnessState(selected) + " | Quote age unavailable");

   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l1", quote_line_one) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l2", spread_line) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_a_l3", freshness_line) || changed;
   changed = ASC_HudSetLabelTextIfExists(ASC_HUD_PREFIX + "stat_block_b_l3", "Daily change " + daily_change_text) || changed;

   if(changed)
     {
      g_asc_hud.market_watch_live_last_patch_ms = now_ms;
      g_asc_hud.proof_tactical_refresh_count++;
      g_asc_hud.proof_selected_symbol_live_refresh_count++;
      g_asc_hud.proof_last_selected_symbol_live_refresh_utc = now_utc;
      g_asc_hud.last_tactical_refresh_utc = now_utc;
      if(!ASC_HudIsDirty())
        {
         ASC_HudRequestRedraw();
        }
     }

   return changed;
  }

void ASC_HudRenderSymbolDetailPage(const int x,const int y,const int w)
  {
   ASC_Layer1SymbolState selected;
   bool has_selected = ASC_HudFindSelectedSymbol(selected);
   ASC_HudHideListPanels();

   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_pulse_panel", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_pulse_text", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_scope", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_1", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_2", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_3", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "sym_focus_chip_4", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_1_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_2_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_3_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_focus_chip_4_t", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_text", "", 0, 0, 8, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "sym_scope_hint", "", 0, 0, 8, clrBlack);

   if(!has_selected)
     {
      ASC_HudRenderCard("sym_none", "Overview", "No selected symbol", "Select a symbol from Symbols.", "", x, y, w, 92, ASC_HudThemeAccentWarning());
      return;
     }

   datetime now_utc = TimeGMT();
   string main_bucket_name = ASC_HudEffectiveMainBucketName(selected);
   string sub_bucket_name = ASC_HudEffectiveSubBucketName(selected, ASC_HudEffectiveMainBucketId(selected));
   string canonical_symbol = (StringLen(selected.classification.canonical_symbol) > 0 ? selected.classification.canonical_symbol : selected.symbol);

   ASC_Layer2Packet live_packet;
   bool has_live_packet = ASC_Layer2TryGetPacketBySymbol(selected.symbol, live_packet) && (live_packet.admitted || live_packet.tactical_only);

   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   ASC_SelectionFilterEvaluation filter;
   bool has_filter = false;
   bool has_filter_packet = false;
   double filter_score = 0.0;
   bool shortlist_found = ASC_HudResolveSelectionTruth(selected,
                                                       shortlist_entry,
                                                       shortlist_rank,
                                                       shortlist_total,
                                                       filter,
                                                       has_filter,
                                                       has_filter_packet,
                                                       filter_score);
   string filter_posture = has_filter ? filter.result_state_operator_text : "Awaiting Selection";
   string filter_next_step = has_filter ? filter.next_required_step : "Wait for shortlist publication.";
   string membership_state = shortlist_found ? shortlist_entry.membership_state : "pending";

   bool has_day_packet = has_live_packet && ASC_L2PacketHasLawfulDayRange(live_packet);
   string day_change_posture = has_day_packet
                               ? ("Day change " + DoubleToString(live_packet.day_range_pct, 2) + "%")
                               : "Day change unavailable";
   string tick_age_text = ASC_HudAgeText(selected.observed_at_utc, now_utc);
   int price_digits = ASC_HudSymbolPriceDigits(selected.symbol, live_packet, has_live_packet);

   string shortlist_line = shortlist_found
                           ? ASC_HudShortlistPriorityLine(shortlist_entry, shortlist_total)
                           : "Shortlist position is waiting for the next shortlist pass.";
   string snapshot_line = has_live_packet ? "Snapshot ready" : "Snapshot pending";
   string total_posture = ASC_HudSymbolOverviewTotalPosture(selected, has_live_packet, has_filter, filter, shortlist_found, membership_state);
   string next_action = ASC_HudSymbolOverviewNextStep(selected, has_live_packet, has_filter, filter, shortlist_found, shortlist_entry);
   string tradability_state = has_filter ? (filter.tradability_is_open ? "Tradable" : "Restricted") : "Pending";
   string friction_state = has_filter ? ASC_ArtifactHumanizeLabel(ASC_TextOrUnavailable(filter.execution_friction_posture)) : "Pending";
   string spread_sanity = has_filter ? (filter.spread_is_sane ? "Sane" : "Stressed") : "Pending";
   string friction_line = "Tradability: " + tradability_state + " | Friction: " + friction_state + " | Spread sanity: " + spread_sanity;
   string session_state = ASC_HudOverviewSessionState(selected, has_live_packet, live_packet);
   string shortlist_status_line = shortlist_found
                                  ? ("Status " + ASC_ArtifactHumanizeLabel(membership_state) + " | " + ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total))
                                  : "Status pending | Overall pending | Bucket n/a | Group n/a | Raw n/a";
   string next_review = (StringLen(selected.next_check) > 0 ? selected.next_check : "pending");
   string compact_primary = ASC_HudOverviewCompactPrimaryPosture(selected, has_filter, filter, shortlist_found, membership_state, has_live_packet);
   string consumer_market_posture_text = ASC_ConsumerMarketPostureReadback(selected);
   string consumer_visible_ceiling_text = ASC_ConsumerVisibleLayerCeilingReadback(selected);
   string consumer_l34_source_text = ASC_ConsumerL34SourceIdentityReadback(selected, g_asc_hud.last_shortlist_source, shortlist_found, false);
   string consumer_path_identity_text = ASC_ConsumerPathIdentityReadback(false);
   string shortlist_compact = shortlist_found
                              ? (ASC_ArtifactHumanizeLabel(membership_state) + " | " + ASC_HudRankSurfaceSummaryLine(shortlist_entry, shortlist_total))
                              : "Pending | Global pending | Main bucket pending | Sub-group n/a | Full field pending";
   string freshness_compact = has_live_packet
                              ? (ASC_L2FreshnessToOperatorText(live_packet.freshness) + " | Age " + IntegerToString(live_packet.packet_age_sec) + "s")
                              : (ASC_HudSymbolFreshnessState(selected) + " | Age pending");
   string next_action_compact = ASC_HudClampTextWordSafe(next_action, 44);
   string market_line1 = has_live_packet
                         ? ("Bid " + DoubleToString(live_packet.bid, price_digits)
                            + " | Ask " + DoubleToString(live_packet.ask, price_digits)
                            + " | Spr " + DoubleToString(live_packet.spread_points, 1) + "pt")
                         : "Bid/Ask pending | Spread pending";
   string market_line2 = has_live_packet
                         ? ("Freshness: " + ASC_L2FreshnessToOperatorText(live_packet.freshness) + " | Tick age " + tick_age_text + " | Snapshot " + IntegerToString(live_packet.packet_age_sec) + "s")
                         : ("Freshness: " + ASC_HudSymbolFreshnessState(selected) + " | Tick age " + tick_age_text + " | Snapshot pending");
   string market_line3 = ASC_HudClampTextWordSafe(friction_line + " | " + day_change_posture, 92);
   int sym_hero_h = (g_asc_hud.viewport_h < 760 ? 106 : 114);

   ASC_HudRenderCard("sym_hero", selected.symbol + " | Snapshot",
                     "Identity: " + main_bucket_name + " / " + sub_bucket_name + " | Canonical " + canonical_symbol,
                     "Posture: " + compact_primary + " | Shortlist: " + shortlist_compact,
                     "Freshness: " + freshness_compact + " | Next " + next_review + " | Action " + ASC_HudClampTextWordSafe(next_action_compact, 36),
                     x, y, w, sym_hero_h, ASC_HudThemeAccentCardA());

   int top = y + sym_hero_h + 12;
   int card_gap_y = 10;
   int cards_available_h = g_asc_hud.viewport_h - top - (ASC_HUD_FOOTER_H + 14);
   int card_h = (cards_available_h - card_gap_y) / 2;
   if(card_h < 104)
      card_h = 104;
   if(card_h > 148)
      card_h = 148;
   int card_gap = 10;
   int card_w = (w - card_gap) / 2;
   int second_row_y = top + card_h + card_gap_y;

   ASC_HudRenderCard("sym_identity", "Symbol State",
                     "State: " + ASC_HudPrimaryOpenClosedState(selected.state) + " | Session: " + session_state,
                     "Market posture: " + consumer_market_posture_text + " | Ceiling: " + consumer_visible_ceiling_text,
                     "Path: " + consumer_path_identity_text + " | Next " + next_review,
                     x, top, card_w, card_h, ASC_HudThemeAccentCardB());

   ASC_HudRenderCard("sym_market", "Market Snapshot",
                     market_line1,
                     market_line2,
                     market_line3,
                     x + card_w + card_gap, top, card_w, card_h, ASC_HudThemeAccentCardC());

   ASC_HudRenderCard("sym_tick", "Selection Snapshot",
                     "Posture: " + filter_posture + " | Tradability: " + tradability_state,
                     "Next step: " + ASC_HudClampTextWordSafe(filter_next_step, 88),
                     "Session: " + session_state + " | Snapshot: " + snapshot_line,
                     x, second_row_y, card_w, card_h, ASC_HudThemeAccentCardD());

   ASC_HudRenderCard("sym_pub", "Shortlist Summary",
                     "Shortlist: " + shortlist_compact,
                     "Summary: " + ASC_HudClampTextWordSafe(total_posture, 84),
                     "L3/L4 source: " + ASC_HudClampTextWordSafe(consumer_l34_source_text, 80),
                     x + card_w + card_gap, second_row_y, card_w, card_h, ASC_HudThemeAccentPrimary());
  }

void ASC_HudRenderStatDetailPage(const int x,const int y,const int w)
  {
   ASC_Layer1SymbolState selected;
   if(!ASC_HudFindSelectedSymbol(selected))
     {
      ASC_HudRenderCard("stat_none", "Section Detail", "No selected symbol", "Select a symbol from Symbols.", "", x, y, w, 92, ASC_HudThemeAccentWarning());
      return;
     }

   datetime now_utc = TimeGMT();
   string main_bucket_name = ASC_HudEffectiveMainBucketName(selected);
   string sub_bucket_name = ASC_HudEffectiveSubBucketName(selected, ASC_HudEffectiveMainBucketId(selected));
   string classification_path = ASC_HudOperatorClassificationPath(selected, true);
   string section_title = ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section);

   string summary_line = "Active section with current symbol evidence.";
   if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_MARKET_WATCH) summary_line = "Live tradability summary: spread regime, freshness, timing, and execution caution.";
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SPECIFICATION) summary_line = "Trade geometry summary: contract constraints, permissions, and restriction impact.";
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER) summary_line = "Selection posture and next-step evidence.";
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT) summary_line = "Shortlist attention summary: peer strength, promotion context, and conflict pressure.";
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS)
      summary_line = "Full Analysis " + ASC_HudDeepSubPageLabel(g_asc_hud.selected_deep_subpage) + " summary from selected symbol dossier truth.";
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_A) summary_line = "Additional workspace A is shown for visibility and is currently inactive.";
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_FUTURE_EXPANSION_B) summary_line = "Additional workspace B is shown for visibility and is currently inactive.";

   ASC_HudRenderCard("stat_hero", selected.symbol + " | " + section_title,
                     "Classification: " + classification_path,
                     summary_line,
                     "Selected symbol stays pinned while section context changes.",
                     x, y, w, 96, ASC_HudThemeAccentCardC());

   int content_top = y + 112;
   if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS)
     {
      int sub_gap = 6;
      int sub_h = 20;
      int sub_w = (w - (sub_gap * 4)) / 5;
      if(sub_w < 66)
         sub_w = 66;
      int sub_total_w = (sub_w * 5) + (sub_gap * 4);
      int sub_x = x;
      if(sub_total_w < w)
         sub_x = x + ((w - sub_total_w) / 2);
      int sub_y = y + 103;

      ASC_HudRenderDeepSubPageButton(ASC_HUD_PREFIX + "deep_sub_1", "Thesis", sub_x + (sub_w + sub_gap) * 0, sub_y, sub_w, sub_h, ASC_HUD_DEEP_SUBPAGE_THESIS);
      ASC_HudRenderDeepSubPageButton(ASC_HUD_PREFIX + "deep_sub_2", "Timing", sub_x + (sub_w + sub_gap) * 1, sub_y, sub_w, sub_h, ASC_HUD_DEEP_SUBPAGE_TIMING);
      ASC_HudRenderDeepSubPageButton(ASC_HUD_PREFIX + "deep_sub_3", "Structure", sub_x + (sub_w + sub_gap) * 2, sub_y, sub_w, sub_h, ASC_HUD_DEEP_SUBPAGE_STRUCTURE);
      ASC_HudRenderDeepSubPageButton(ASC_HUD_PREFIX + "deep_sub_4", "Execution", sub_x + (sub_w + sub_gap) * 3, sub_y, sub_w, sub_h, ASC_HUD_DEEP_SUBPAGE_EXECUTION);
      ASC_HudRenderDeepSubPageButton(ASC_HUD_PREFIX + "deep_sub_5", "Timeframes", sub_x + (sub_w + sub_gap) * 4, sub_y, sub_w, sub_h, ASC_HUD_DEEP_SUBPAGE_TIMEFRAMES);
      content_top = y + 132;
     }
   else
     {
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_1", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_2", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_3", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_4", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
      ASC_HudEnsureButton(ASC_HUD_PREFIX + "deep_sub_5", "", 0, 0, 0, 0, clrBlack, clrBlack, clrBlack);
     }
   int card_gap = (w < 980 ? 8 : 12);
   int card_w = (w - card_gap) / 2;
   int card_h = (w < 980 ? 122 : 118);
   bool show_lower_cards = false;
   string classification_posture = selected.classification.resolved ? "Resolved" : "Needs Review";
   string sub_group_value = selected.classification.resolved ? sub_bucket_name : "Not yet available";
   ASC_Layer2Packet live_packet;
   bool has_packet_context = ASC_Layer2TryGetPacketBySymbol(selected.symbol, live_packet)
                             && (live_packet.admitted || live_packet.tactical_only);
   bool has_live_packet = has_packet_context && ASC_L2PacketHasLawfulSnapshot(live_packet);
   bool has_day_packet = has_packet_context && ASC_L2PacketHasLawfulDayRange(live_packet);
   ASC_ShortlistSymbolSummary shortlist_entry_cached;
   int shortlist_rank_cached = 0;
   int shortlist_total_cached = 0;
   ASC_SelectionFilterEvaluation filter_cached;
   bool has_filter_cached = false;
   bool has_filter_packet_cached = false;
   double filter_score_cached = 0.0;
   bool shortlist_found_cached = ASC_HudResolveSelectionTruth(selected,
                                                              shortlist_entry_cached,
                                                              shortlist_rank_cached,
                                                              shortlist_total_cached,
                                                              filter_cached,
                                                              has_filter_cached,
                                                              has_filter_packet_cached,
                                                              filter_score_cached);
   int price_digits = ASC_HudSymbolPriceDigits(selected.symbol, live_packet, has_live_packet);
   string quote_line_one = has_live_packet
                           ? ("Bid " + DoubleToString(live_packet.bid, price_digits) + " | Ask " + DoubleToString(live_packet.ask, price_digits))
                           : "Bid and ask are waiting for a current market-watch snapshot.";

   if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_OVERVIEW)
     {
      string opportunity_text = has_filter_cached ? filter_cached.result_state_operator_text : "Awaiting shortlist publication";

      ASC_HudRenderCard("stat_block_a", "Overview",
                        "State: " + ASC_HudPrimaryOpenClosedState(selected.state) + " | Opportunity: " + opportunity_text,
                        "Freshness: " + ASC_HudSymbolFreshnessState(selected) + " | Confidence: " + ASC_L1ConfidenceToOperatorText(selected.confidence),
                        quote_line_one,
                        x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());
      ASC_HudRenderCard("stat_block_b", "Selected Symbol",
                        "Classification: " + ASC_HudOperatorClassificationPath(selected, true),
                        "Observed: " + ASC_HudAgeText(selected.observed_at_utc, now_utc) + " | Next review: " + (StringLen(selected.next_check) > 0 ? selected.next_check : "pending"),
                        shortlist_found_cached ? ("Priority: rank " + IntegerToString(shortlist_rank_cached) + " of " + IntegerToString(shortlist_total_cached))
                                        : "Priority: waiting for shortlist placement.",
                        x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());
      ASC_HudHideCard("stat_block_c");
      ASC_HudHideCard("stat_block_d");
     }
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_MARKET_WATCH)
     {
      bool has_spread_pct = (has_live_packet && live_packet.bid > 0.0 && live_packet.valid_spread);
      int quote_digits = ASC_HudSymbolPriceDigits(selected.symbol, live_packet, has_live_packet);
      double spread_points = has_live_packet ? live_packet.spread_points : 0.0;
      double spread_pct = 0.0;
      if(has_spread_pct)
         spread_pct = ((live_packet.spread_points * live_packet.point) / live_packet.bid) * 100.0;
      string daily_change_text = (has_live_packet && live_packet.valid_daily_change_pct)
                                 ? (DoubleToString(live_packet.daily_change_pct, 2) + "%")
                                 : (has_day_packet ? (DoubleToString(live_packet.day_range_pct, 2) + "%") : "unavailable");
      string day_range_line = has_day_packet
                              ? ("Day high " + DoubleToString(live_packet.day_high, quote_digits) + " | Day low " + DoubleToString(live_packet.day_low, quote_digits))
                              : "Day high/low unavailable";
      string open_close_line = has_live_packet
                               ? ("Open " + (live_packet.valid_day_open ? DoubleToString(live_packet.day_open, quote_digits) : "unavailable")
                                  + " | Close " + (live_packet.valid_last_price ? DoubleToString(live_packet.last_price, quote_digits) : "unavailable"))
                               : "Open/Close unavailable";
      string bid_extremes_line = has_day_packet
                                 ? ("Bid high " + DoubleToString(live_packet.day_high, quote_digits) + " | Bid low " + DoubleToString(live_packet.day_low, quote_digits))
                                 : "Bid high/low unavailable";
      string ask_extremes_line = has_day_packet
                                 ? ("Ask high " + DoubleToString(live_packet.day_high + (live_packet.valid_spread ? (live_packet.spread_points * live_packet.point) : 0.0), quote_digits)
                                    + " | Ask low " + DoubleToString(live_packet.day_low + (live_packet.valid_spread ? (live_packet.spread_points * live_packet.point) : 0.0), quote_digits))
                                 : "Ask high/low unavailable";
      string quote_time_line = has_live_packet
                               ? ("Quote tick " + ASC_HudDateTimeText((live_packet.valid_tick_time && live_packet.tick_time_utc > 0) ? live_packet.tick_time_utc : live_packet.last_good_utc))
                               : "Quote tick unavailable";
      string source_line = has_live_packet
                           ? (live_packet.has_packet ? "Source: live market snapshot"
                              : ((live_packet.has_last_good || live_packet.continuity_backed) ? "Source: continuity snapshot" : "Source: market snapshot pending"))
                           : "Source: market snapshot pending";
      string spread_line = has_live_packet
                           ? StringFormat("Spread %.1f points | Spread %s | Daily change %s", spread_points, has_spread_pct ? (DoubleToString(spread_pct, 3) + "%") : "unavailable", daily_change_text)
                           : "Spread is awaiting a current market-watch snapshot.";
      string freshness_line = has_live_packet
                              ? ("Freshness " + ASC_L2FreshnessToOperatorText(live_packet.freshness) + " | Quote age " + IntegerToString(live_packet.packet_age_sec) + " sec")
                              : ("Freshness " + ASC_HudSymbolFreshnessState(selected) + " | Quote age unavailable");
      string execution_caution = ASC_HudMarketWatchExecutionCaution(selected, has_live_packet, live_packet, has_filter_cached, filter_cached);

      ASC_HudRenderCard("stat_block_a", "Live Quote Watch",
                        quote_line_one,
                        spread_line,
                        freshness_line,
                        x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());
      ASC_HudRenderCard("stat_block_b", "Day Structure",
                        day_range_line,
                        open_close_line,
                        "Daily change " + daily_change_text,
                        x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());
      ASC_HudRenderCard("stat_block_c", "Bid/Ask Extremes",
                        bid_extremes_line,
                        ask_extremes_line,
                        quote_time_line + " | " + source_line,
                        x, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardC());
      ASC_HudRenderCard("stat_block_d", "Execution Caution",
                        execution_caution,
                        "Market state: " + ASC_HudPrimaryOpenClosedState(selected.state),
                        "Continuity-backed quote: " + ASC_HudYesNo(has_packet_context && live_packet.continuity_backed),
                        x + card_w + card_gap, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardD());
     }
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SPECIFICATION)
     {
      show_lower_cards = true;
      ASC_SymbolSessionSummary session_summary;
      bool has_session_summary = ASC_GetSymbolSessionSummary(selected.symbol, session_summary, false);
      ASC_SymbolSpecification spec_snapshot;
      bool has_spec_snapshot = ASC_GetSymbolSpecification(selected.symbol, spec_snapshot, false);
      long digits_value = 0;
      long stops_level = 0;
      long trade_mode = 0;
      long execution_mode = 0;
      long filling_mode = 0;
      long expiration_mode = 0;
      long order_mode = 0;
      long calc_mode = 0;
      long spread_float = 0;
      long swap_mode = 0;
      double point_value = 0.0;
      double tick_size = 0.0;
      double contract_size = 0.0;
      double min_volume = 0.0;
      double max_volume = 0.0;
      double volume_step = 0.0;
      double swap_long = 0.0;
      double swap_short = 0.0;
      double margin_initial = 0.0;
      double margin_maintenance = 0.0;
      string margin_currency = "";
      string profit_currency = "";
      bool has_digits = (has_packet_context && live_packet.digits > 0);
      if(has_digits)
         digits_value = live_packet.digits;
      else if(has_spec_snapshot && spec_snapshot.has_digits)
        {
         has_digits = true;
         digits_value = spec_snapshot.digits;
        }

      bool has_stops_level = (has_packet_context && live_packet.valid_stop_distance && live_packet.min_stop_distance >= 0.0);
      if(has_stops_level)
         stops_level = (long)MathRound(live_packet.min_stop_distance / MathMax(live_packet.point, 0.00000001));
      else if(has_spec_snapshot && spec_snapshot.has_stop_distance_points && spec_snapshot.stop_distance_points >= 0)
        {
         has_stops_level = true;
         stops_level = spec_snapshot.stop_distance_points;
        }
      bool has_freeze_points = (has_packet_context && live_packet.valid_freeze_distance && live_packet.freeze_distance >= 0.0 && live_packet.point > 0.0);
      long freeze_points = 0;
      if(has_freeze_points)
         freeze_points = (long)MathRound(live_packet.freeze_distance / MathMax(live_packet.point, 0.00000001));
      else if(has_spec_snapshot && spec_snapshot.has_freeze_distance_points && spec_snapshot.freeze_distance_points >= 0)
        {
         has_freeze_points = true;
         freeze_points = spec_snapshot.freeze_distance_points;
        }

      bool has_trade_mode = (has_packet_context && live_packet.valid_trade_mode);
      if(has_trade_mode)
         trade_mode = live_packet.trade_mode;
      else if(has_spec_snapshot && spec_snapshot.has_trade_mode)
        {
         has_trade_mode = true;
         trade_mode = spec_snapshot.trade_mode;
        }

      bool has_execution = (has_packet_context && live_packet.valid_execution_mode);
      if(has_execution)
         execution_mode = live_packet.execution_mode;
      else if(has_spec_snapshot && spec_snapshot.has_execution_mode)
        {
         has_execution = true;
         execution_mode = spec_snapshot.execution_mode;
        }
      bool has_filling = (has_spec_snapshot && spec_snapshot.has_filling_mode);
      if(has_filling)
         filling_mode = spec_snapshot.filling_mode;
      bool has_expiration = (has_spec_snapshot && spec_snapshot.has_expiration_mode);
      if(has_expiration)
         expiration_mode = spec_snapshot.expiration_mode;
      bool has_order_mode = (has_spec_snapshot && spec_snapshot.has_order_mode);
      if(has_order_mode)
         order_mode = spec_snapshot.order_mode;
      bool has_calc_mode = (has_spec_snapshot && spec_snapshot.has_calculation_mode);
      if(has_calc_mode)
         calc_mode = spec_snapshot.calculation_mode;
      bool has_spread_float = (has_spec_snapshot && spec_snapshot.has_spread_float_mode);
      if(has_spread_float)
         spread_float = spec_snapshot.spread_float_mode;
      bool has_swap_mode = (has_spec_snapshot && spec_snapshot.has_swap_mode);
      if(has_swap_mode)
         swap_mode = spec_snapshot.swap_mode;

      bool has_point = (has_packet_context && live_packet.point > 0.0);
      if(has_point)
         point_value = live_packet.point;
      else if(has_spec_snapshot && spec_snapshot.has_point && spec_snapshot.point > 0.0)
        {
         has_point = true;
         point_value = spec_snapshot.point;
        }

      bool has_tick_size = (has_packet_context && live_packet.valid_tick_size);
      if(has_tick_size)
         tick_size = live_packet.tick_size;
      else if(has_spec_snapshot && spec_snapshot.has_tick_size && spec_snapshot.tick_size > 0.0)
        {
         has_tick_size = true;
         tick_size = spec_snapshot.tick_size;
        }

      bool has_contract_size = (has_packet_context && live_packet.valid_contract_size);
      if(has_contract_size)
         contract_size = live_packet.contract_size;
      else if(has_spec_snapshot && spec_snapshot.has_contract_size && spec_snapshot.contract_size > 0.0)
        {
         has_contract_size = true;
         contract_size = spec_snapshot.contract_size;
        }

      bool has_min_volume = (has_packet_context && live_packet.valid_volume_min);
      if(has_min_volume)
         min_volume = live_packet.volume_min;
      else if(has_spec_snapshot && spec_snapshot.has_volume_min && spec_snapshot.volume_min > 0.0)
        {
         has_min_volume = true;
         min_volume = spec_snapshot.volume_min;
        }

      bool has_max_volume = (has_packet_context && live_packet.valid_volume_max);
      if(has_max_volume)
         max_volume = live_packet.volume_max;
      else if(has_spec_snapshot && spec_snapshot.has_volume_max && spec_snapshot.volume_max > 0.0)
        {
         has_max_volume = true;
         max_volume = spec_snapshot.volume_max;
        }

      bool has_volume_step = (has_packet_context && live_packet.valid_volume_step);
      if(has_volume_step)
         volume_step = live_packet.volume_step;
      else if(has_spec_snapshot && spec_snapshot.has_volume_step && spec_snapshot.volume_step > 0.0)
        {
         has_volume_step = true;
         volume_step = spec_snapshot.volume_step;
        }

      bool has_swap_long = (has_packet_context && live_packet.valid_swap_long);
      if(has_swap_long)
         swap_long = live_packet.swap_long;
      else if(has_spec_snapshot && spec_snapshot.has_swap_long)
        {
         has_swap_long = true;
         swap_long = spec_snapshot.swap_long;
        }
      bool has_swap_short = (has_packet_context && live_packet.valid_swap_short);
      if(has_swap_short)
         swap_short = live_packet.swap_short;
      else if(has_spec_snapshot && spec_snapshot.has_swap_short)
        {
         has_swap_short = true;
         swap_short = spec_snapshot.swap_short;
        }
      bool has_margin_initial = (has_packet_context && live_packet.valid_buy_initial_margin);
      if(has_margin_initial)
         margin_initial = live_packet.buy_initial_margin;
      else if(has_spec_snapshot && spec_snapshot.has_margin_initial)
        {
         has_margin_initial = true;
         margin_initial = spec_snapshot.margin_initial;
        }
      bool has_margin_maintenance = (has_packet_context && live_packet.valid_buy_maintenance_margin);
      if(has_margin_maintenance)
         margin_maintenance = live_packet.buy_maintenance_margin;
      else if(has_spec_snapshot && spec_snapshot.has_margin_maintenance)
        {
         has_margin_maintenance = true;
         margin_maintenance = spec_snapshot.margin_maintenance;
        }
      bool has_margin_currency = (has_packet_context && live_packet.valid_margin_currency);
      if(has_margin_currency)
         margin_currency = live_packet.margin_currency;
      else if(has_spec_snapshot && spec_snapshot.has_margin_currency)
        {
         has_margin_currency = true;
         margin_currency = spec_snapshot.margin_currency;
        }
      bool has_profit_currency = (has_packet_context && live_packet.valid_profit_currency);
      if(has_profit_currency)
         profit_currency = live_packet.profit_currency;
      else if(has_spec_snapshot && spec_snapshot.has_profit_currency)
        {
         has_profit_currency = true;
         profit_currency = spec_snapshot.profit_currency;
        }

      string spec_freshness = has_packet_context ? ASC_L2SpecificationFreshnessToOperatorText(live_packet)
                                              : (has_spec_snapshot ? "Snapshot Only (No live market-watch snapshot)" : "Unavailable");
      string session_hours_line = "";
      if(has_packet_context && StringLen(live_packet.quote_session_hours) > 0)
         session_hours_line = ASC_HudAppendCompactField(session_hours_line, "Quote sessions " + live_packet.quote_session_hours);
      if(has_packet_context && StringLen(live_packet.trade_session_hours) > 0)
         session_hours_line = ASC_HudAppendCompactField(session_hours_line, "Trade sessions " + live_packet.trade_session_hours);
      if(StringLen(session_hours_line) <= 0 && has_session_summary && session_summary.available && StringLen(session_summary.windows) > 0)
         session_hours_line = "Sessions " + session_summary.windows;

      string margin_rates_line = "";
      bool has_any_margin_rate = (has_packet_context
                                  && (live_packet.valid_buy_initial_margin_rate
                                      || live_packet.valid_buy_maintenance_margin_rate
                                      || live_packet.valid_sell_initial_margin_rate
                                      || live_packet.valid_sell_maintenance_margin_rate));
      if(has_any_margin_rate)
         margin_rates_line = "Margin rates B "
                             + (live_packet.valid_buy_initial_margin_rate ? DoubleToString(live_packet.buy_initial_margin_rate, 3) : "na")
                             + "/" + (live_packet.valid_buy_maintenance_margin_rate ? DoubleToString(live_packet.buy_maintenance_margin_rate, 3) : "na")
                             + " | S "
                             + (live_packet.valid_sell_initial_margin_rate ? DoubleToString(live_packet.sell_initial_margin_rate, 3) : "na")
                             + "/" + (live_packet.valid_sell_maintenance_margin_rate ? DoubleToString(live_packet.sell_maintenance_margin_rate, 3) : "na");

      string commission_line = "";
      if(has_packet_context && StringLen(live_packet.margin_notes) > 0)
        {
         int cidx = StringFind(live_packet.margin_notes, "commission_symbol_spec=");
         if(cidx >= 0)
           {
            string commission_slice = StringSubstr(live_packet.margin_notes, cidx);
            int divider = StringFind(commission_slice, "|");
            if(divider > 0)
               commission_slice = StringSubstr(commission_slice, 0, divider);
            string commission_lower = commission_slice;
            StringToLower(commission_lower);
            if(StringFind(commission_lower, "unavailable") < 0)
              {
               commission_line = "Commission " + commission_slice;
              }
           }
        }

      string core_line_1 = "";
      core_line_1 = has_digits ? ASC_HudAppendCompactField(core_line_1, "Digits " + IntegerToString((int)digits_value)) : core_line_1;
      core_line_1 = has_contract_size ? ASC_HudAppendCompactField(core_line_1, "Contract " + DoubleToString(contract_size, 2)) : core_line_1;
      core_line_1 = has_tick_size ? ASC_HudAppendCompactField(core_line_1, "Tick size " + DoubleToString(tick_size, 8)) : core_line_1;
      core_line_1 = (has_packet_context && live_packet.valid_tick_value) ? ASC_HudAppendCompactField(core_line_1, "Tick value " + DoubleToString(live_packet.tick_value, 6)) : core_line_1;
      core_line_1 = has_calc_mode ? ASC_HudAppendCompactField(core_line_1, "Calc " + ASC_SymbolSpecificationCalcModeText(calc_mode)) : core_line_1;
      if(StringLen(core_line_1) <= 0)
         core_line_1 = "Core contract fields are pending from symbol specification owner.";

      string permission_line_1 = "";
      permission_line_1 = has_trade_mode ? ASC_HudAppendCompactField(permission_line_1, "Trade " + ASC_HudTradeModeText(trade_mode)) : permission_line_1;
      permission_line_1 = has_execution ? ASC_HudAppendCompactField(permission_line_1, "Execution " + ASC_HudExecutionModeText(execution_mode)) : permission_line_1;
      permission_line_1 = has_filling ? ASC_HudAppendCompactField(permission_line_1, "Filling " + ASC_HudFillingModeText(true, filling_mode)) : permission_line_1;
      permission_line_1 = has_expiration ? ASC_HudAppendCompactField(permission_line_1, "Expiration " + ASC_HudExpirationModeText(true, expiration_mode)) : permission_line_1;
      permission_line_1 = has_order_mode ? ASC_HudAppendCompactField(permission_line_1, "Orders " + ASC_HudOrderModeText(true, order_mode)) : permission_line_1;
      if(StringLen(permission_line_1) <= 0)
         permission_line_1 = "Trading permission fields are pending.";

      string volume_line = "";
      volume_line = has_min_volume ? ASC_HudAppendCompactField(volume_line, "Min vol " + DoubleToString(min_volume, 2)) : volume_line;
      volume_line = has_max_volume ? ASC_HudAppendCompactField(volume_line, "Max vol " + DoubleToString(max_volume, 2)) : volume_line;
      volume_line = has_volume_step ? ASC_HudAppendCompactField(volume_line, "Step " + DoubleToString(volume_step, 2)) : volume_line;
      string risk_line = "";
      risk_line = has_stops_level ? ASC_HudAppendCompactField(risk_line, "Stops " + IntegerToString((int)stops_level)) : risk_line;
      risk_line = has_freeze_points ? ASC_HudAppendCompactField(risk_line, "Freeze " + IntegerToString((int)freeze_points)) : risk_line;
      if(StringLen(volume_line) <= 0)
         volume_line = "Volume constraints are pending.";
      if(StringLen(risk_line) <= 0)
         risk_line = "Risk control distances are pending.";

      string currency_swap_line_1 = "";
      currency_swap_line_1 = has_margin_currency ? ASC_HudAppendCompactField(currency_swap_line_1, "Margin " + margin_currency) : currency_swap_line_1;
      currency_swap_line_1 = has_profit_currency ? ASC_HudAppendCompactField(currency_swap_line_1, "Profit " + profit_currency) : currency_swap_line_1;
      string swap_line = "";
      swap_line = ((has_packet_context && live_packet.valid_swap_mode) || has_swap_mode) ? ASC_HudAppendCompactField(swap_line, "Swap type " + IntegerToString((int)swap_mode)) : swap_line;
      swap_line = has_swap_long ? ASC_HudAppendCompactField(swap_line, "Swap long " + DoubleToString(swap_long, 4)) : swap_line;
      swap_line = has_swap_short ? ASC_HudAppendCompactField(swap_line, "Swap short " + DoubleToString(swap_short, 4)) : swap_line;
      if(StringLen(currency_swap_line_1) <= 0)
         currency_swap_line_1 = "Margin/profit currency fields are pending.";
      if(StringLen(swap_line) <= 0)
         swap_line = "Swap fields are pending.";
      if(StringLen(session_hours_line) <= 0)
         session_hours_line = "Session hours are pending.";

      string conditional_line_1 = margin_rates_line;
      string conditional_line_2 = commission_line;
      string conditional_line_3 = "";
      conditional_line_3 = has_margin_initial ? ASC_HudAppendCompactField(conditional_line_3, "Init " + DoubleToString(margin_initial, 2)) : conditional_line_3;
      conditional_line_3 = has_margin_maintenance ? ASC_HudAppendCompactField(conditional_line_3, "Maint " + DoubleToString(margin_maintenance, 2)) : conditional_line_3;
      if(StringLen(conditional_line_3) > 0)
         conditional_line_3 = "Margin " + conditional_line_3;
      if(StringLen(conditional_line_1) <= 0 && StringLen(conditional_line_2) <= 0 && StringLen(conditional_line_3) <= 0)
         conditional_line_1 = "No reliable commission or margin summary fields are published.";

      ASC_HudRenderCard("stat_block_a", "Specs Overview",
                        core_line_1,
                        "",
                        "Spec freshness: " + spec_freshness,
                        x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());

      ASC_HudRenderCard("stat_block_b", "Execution + Orders",
                        permission_line_1,
                        volume_line,
                        risk_line,
                        x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());

      ASC_HudRenderCard("stat_block_c", "Currencies + Swap",
                        currency_swap_line_1,
                        swap_line,
                        session_hours_line,
                        x, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardC());

      ASC_HudRenderCard("stat_block_d", "Conditional Terms",
                        conditional_line_1,
                        conditional_line_2,
                        conditional_line_3,
                        x + card_w + card_gap, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardD());
     }
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER)
     {
      show_lower_cards = true;
      string opportunity_next_step = has_filter_cached ? filter_cached.next_required_step : "Wait for the next shortlist update.";
      string opportunity_dependencies = has_filter_cached ? filter_cached.dependencies_text : "Readiness dependencies unavailable until the next shortlist update.";
      string opportunity_corroboration = has_filter_cached ? filter_cached.corroboration_text : "Market-watch corroboration unavailable.";
      string supports_line = ASC_HudSelectionSupportsSummary(has_filter_cached, filter_cached);
      string blockers_line = ASC_HudSelectionBlockersSummary(has_filter_cached, filter_cached);
      string why_alive_line = ASC_HudSelectionWhyAliveSummary(has_filter_cached, filter_cached);
      string next_consequence = ASC_HudSelectionNextStepSummary(has_filter_cached, filter_cached);
      string score_posture_line = has_filter_cached ? ASC_HudFilterScoreSummary(filter_cached) : "Score posture pending shortlist snapshot.";
      string alive_line = "Candidate alive: ";
      if(!has_filter_cached)
         alive_line += "Pending shortlist snapshot.";
      else if(filter_cached.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
         alive_line += "No; current filter gate is blocking this symbol.";
      else if(filter_cached.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
         alive_line += "Conditional; filter evidence is still building.";
      else
         alive_line += "Yes; filter gate is currently open.";

      ASC_HudRenderCard("stat_block_a", "Selection Gate",
                        alive_line,
                        "Why alive: " + why_alive_line,
                        "Score posture: " + score_posture_line,
                        x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());
      ASC_HudRenderCard("stat_block_b", "Survival Drivers",
                        "Helping now: " + supports_line,
                        "Blocking now: " + blockers_line,
                        "Dependencies: " + opportunity_dependencies,
                        x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());
      ASC_HudRenderCard("stat_block_c", "Gate Progression",
                        "Corroboration: " + opportunity_corroboration,
                        "What changes next: " + next_consequence,
                        "Next required step: " + opportunity_next_step,
                        x, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardC());
      ASC_HudRenderCard("stat_block_d", "Decision Boundaries",
                        "Selection explains gate survival and gate state only.",
                        ASC_HudShortlistLabel() + " explains rank, placement, and promotion context.",
                        ASC_HudDeepAnalysisLabel() + " explains deeper setup interpretation, not placement truth.",
                        x + card_w + card_gap, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardD());
     }
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT)
      {
       show_lower_cards = true;
       ASC_ShortlistSymbolSummary shortlist_entry;
       int shortlist_rank = 0;
       int shortlist_total = 0;
       bool shortlist_found = ASC_HudFindShortlistEntryForState(selected, shortlist_entry, shortlist_rank, shortlist_total);

       string state_line = shortlist_found
                           ? ("Shortlist state: " + ASC_ArtifactHumanizeLabel(shortlist_entry.membership_state)
                              + " | Band " + ASC_HudShortlistBandLabel(shortlist_entry.shortlist_band)
                              + " | Posture " + ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_posture))
                           : "Shortlist state: pending placement.";
       string rank_line = shortlist_found
                          ? ASC_HudShortlistRankContextLine(shortlist_entry, shortlist_total)
                          : "Overall rank pending | Bucket rank pending";
       string why_position_line = shortlist_found
                                  ? ASC_HudShortlistMeaningLine(shortlist_entry)
                                  : "Why in this position is pending shortlist placement.";
       string placement_meaning_line = shortlist_found
                                       ? ASC_HudShortlistBandMeaningSummary(shortlist_entry)
                                       : "Placement meaning: pending until shortlist placement is published.";
       string promotion_pressure_line = shortlist_found
                                        ? ASC_HudShortlistPromotionPressureSummary(shortlist_entry)
                                        : "Promotion pressure is pending shortlist placement.";
       string conflict_line = shortlist_found
                              ? ASC_HudShortlistConflictSummary(shortlist_entry)
                              : "Conflict/correlation/exposure pressure is waiting on shortlist placement.";
       string relative_strength_line = shortlist_found
                                       ? ASC_HudShortlistRelativeStrengthSummary(shortlist_entry)
                                       : "Relative strength context is waiting on shortlist placement.";
       string improve_line = shortlist_found
                             ? ASC_HudShortlistImproveSummary(shortlist_entry)
                             : "What would improve is waiting on shortlist placement.";
       string weaken_line = shortlist_found
                            ? ASC_HudShortlistWeakenSummary(shortlist_entry)
                            : "What would weaken is waiting on shortlist placement.";
       string next_path_line = shortlist_found
                               ? ASC_HudShortlistLikelyPathSummary(shortlist_entry)
                               : "Next likely path is waiting on shortlist placement.";

       ASC_HudRenderCard("stat_block_a", "Shortlist Placement",
                         "Placement state: " + state_line,
                         rank_line,
                         placement_meaning_line + " | Why: " + why_position_line,
                         x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());
       ASC_HudRenderCard("stat_block_b", "Promotion + Conflict Context",
                         "Promotion context: " + promotion_pressure_line,
                         "Conflict/correlation/exposure: " + conflict_line,
                         relative_strength_line,
                         x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());
       ASC_HudRenderCard("stat_block_c", "Path Shift Map",
                         improve_line,
                         weaken_line,
                         "Next likely shortlist path: " + next_path_line,
                         x, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardC());
       ASC_HudRenderCard("stat_block_d", "Decision Boundaries",
                         "Shortlist explains placement, promotion context, and pressure.",
                         "Selection survival status is upstream context, not placement meaning.",
                         ASC_HudDeepAnalysisLabel() + " adds setup interpretation after placement context is clear.",
                         x + card_w + card_gap, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardD());
      }
   else if(g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS)
     {
      show_lower_cards = true;
      string deep_posture = ASC_HudDeepAnalysisPostureTag(selected, has_live_packet);
      string deep_gate_reason = "";
      bool deep_action_ready = ASC_HudDeepAnalysisEnabled(deep_gate_reason);
      if(!deep_action_ready && deep_posture == "Ready")
         deep_posture = "Awaiting selected symbol action context";

      string current_focus_text = "";
      bool using_stale_cache = false;
      bool has_current_focus = ASC_HudReadCurrentFocusCached(current_focus_text, using_stale_cache);
      string readback_source = has_current_focus ? (using_stale_cache ? "Current Focus [STALE CACHE]" : "Current Focus") : g_asc_hud.current_focus_cache_posture;
      string focus_symbol = has_current_focus ? g_asc_hud.cf_vm_symbol : "";
      string focus_canonical = has_current_focus ? g_asc_hud.cf_vm_canonical : "";
      string focus_deep_posture = has_current_focus ? g_asc_hud.cf_vm_deep_posture : "";
      string focus_deep_summary = has_current_focus ? g_asc_hud.cf_vm_deep_summary : "";
      string focus_score_context = has_current_focus ? g_asc_hud.cf_vm_score_context : "";
      string focus_microstructure_summary = has_current_focus ? g_asc_hud.cf_vm_microstructure : "";
      string focus_published = has_current_focus ? g_asc_hud.cf_vm_published : "";
      bool trigger_queued = g_asc_hud.deep_trigger_pending && ASC_HudSelectedSymbolMatches(selected, g_asc_hud.deep_trigger_symbol);
      string trigger_status_text = ASC_HudDeepTriggerStatusText(g_asc_hud.deep_trigger_last_status);
      string blocker_reason = ASC_TextOrUnavailable(g_asc_hud.deep_trigger_runtime_reason);
      if((StringLen(blocker_reason) <= 0 || blocker_reason == "Unavailable")
         && StringLen(g_asc_hud.current_focus_runtime_reason) > 0)
         blocker_reason = g_asc_hud.current_focus_runtime_reason;

      string selected_canonical = selected.classification.canonical_symbol;
      if(StringLen(selected_canonical) <= 0)
         selected_canonical = selected.identity.canonical_symbol;
      if(StringLen(selected_canonical) <= 0)
         selected_canonical = selected.identity.normalized_symbol;
      bool focus_selected_match = ASC_HudSelectedSymbolMatches(selected, focus_symbol);
      bool focus_canonical_match = (StringLen(selected_canonical) > 0
                                    && (focus_canonical == selected_canonical || focus_symbol == selected_canonical));
      bool focus_matches = (focus_selected_match || focus_canonical_match);
      if(deep_posture == "Ready")
        {
         if(has_current_focus && !focus_matches)
            deep_posture = "Awaiting selected symbol alignment";
         else if(!has_current_focus && !trigger_queued)
            deep_posture = "Awaiting selected symbol readback";
        }
      bool focus_has_completed_block = false;
      if((!has_current_focus || !focus_matches) && StringLen(readback_source) <= 0)
         readback_source = "";
      if(has_current_focus && focus_matches)
         focus_has_completed_block = g_asc_hud.cf_vm_completed_truth;
      bool deep_view_opened = (g_asc_hud.selected_symbol_section == ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS);
      string lifecycle_state = ASC_HudDeepLifecycleState(selected,
                                                         g_asc_hud.deep_trigger_last_status,
                                                         trigger_queued,
                                                         focus_matches,
                                                         focus_has_completed_block,
                                                         focus_deep_posture,
                                                         deep_view_opened);
      string readiness_summary = has_current_focus && focus_matches
                                 ? g_asc_hud.cf_vm_deep_readiness_summary
                                 : "subsections ready 0/8";
      string timeframe_preview = has_current_focus && focus_matches
                                 ? g_asc_hud.cf_vm_timeframe_preview
                                 : "timeframe summary preview unavailable";
      string verification_hint = ASC_TextOrUnavailable(g_asc_hud.deep_trigger_last_status);

      string readback_line_1 = has_current_focus
                               ? ((StringLen(readback_source) > 0 ? (readback_source + " found") : "Current Focus found") + (StringLen(focus_published) > 0 ? (" | " + focus_published) : ""))
                               : (trigger_queued ? "Current Focus refresh is queued from explicit Full Analysis trigger."
                                                 : "Current Focus is not yet available.");
      string readback_line_2 = (has_current_focus && focus_matches)
                               ? ("Selected match: " + ASC_HudYesNo(focus_selected_match)
                                  + " | Symbol alias match: " + ASC_HudYesNo(focus_canonical_match)
                                  + " | Readback symbol: " + (StringLen(focus_symbol) > 0 ? focus_symbol : selected.symbol))
                               : (has_current_focus ? ("Current Focus is still tracking " + (StringLen(focus_symbol) > 0 ? focus_symbol : "another symbol"))
                                                    : "Readback will appear after a lawful write.");
      string deep_thesis = (has_current_focus && focus_matches && focus_has_completed_block && StringLen(focus_deep_summary) > 0)
                           ? focus_deep_summary
                           : ("Posture " + deep_posture + " | Conviction contract is staged for next pass.");
      string timing_trigger = "Timing/trigger: " + lifecycle_state + " | Trigger " + trigger_status_text;
      string risk_geometry = (has_current_focus && focus_matches && focus_has_completed_block && StringLen(focus_score_context) > 0)
                             ? ("Main risk/caution: " + focus_score_context)
                             : "Main risk/caution: invalidation and reward geometry are still incomplete.";
      string execution_friction = (has_current_focus && focus_matches && focus_has_completed_block && StringLen(focus_microstructure_summary) > 0)
                                  ? ("Execution friction: " + focus_microstructure_summary)
                                  : "Execution friction: spread/session/liquidity confirmation is still forming.";
      bool deep_compact = (card_w < 360);
      string current_read_line = "Current Full Analysis read: posture " + deep_posture + " | " + lifecycle_state;
      string thesis_line = "Main thesis: " + deep_thesis;
      string x_tf_line = "Cross-timeframe alignment: " + timeframe_preview + " | Selected match " + ASC_HudYesNo(focus_matches);
      string change_line = "Last refresh change: " + readback_line_1 + " | " + verification_hint;
      string watch_next_line = (deep_posture == "Ready")
                               ? "Watch next: trigger confirmation, invalidation discipline, and execution quality before acting."
                               : ((deep_posture == "Attention")
                                  ? "Watch next: wait for cleaner trigger alignment and tighter risk geometry."
                                  : "Watch next: wait for dossier refresh completion before escalating conviction.");
      current_read_line = ASC_HudTraderSafeSummary(current_read_line, "Current Full Analysis read: summary available", 108);
      thesis_line = "Main thesis: " + ASC_HudTraderSafeSummary(deep_thesis, "thesis pending", 92);
      risk_geometry = "Main risk/caution: " + ASC_HudTraderSafeSummary(focus_score_context, "invalidation and reward geometry are still incomplete", 88);
      x_tf_line = "Cross-timeframe alignment: " + ASC_HudTraderSafeSummary(timeframe_preview, "alignment summary pending", 88) + " | Selected match " + ASC_HudYesNo(focus_matches);
      change_line = "Last refresh change: " + ASC_HudTraderSafeSummary(readback_line_1 + " | " + verification_hint, "refresh delta summary pending", 96);
      watch_next_line = ASC_HudTraderSafeSummary(watch_next_line, "Watch next: wait for cleaner confirmation.", 96);
      execution_friction = ASC_HudTraderSafeSummary(execution_friction, "Execution friction: confirmation pending.", 96);

      if(deep_compact)
        {
         thesis_line = "Main thesis: " + ASC_HudClampText(deep_thesis, 58);
         x_tf_line = "Cross-timeframe: " + ASC_HudClampText(timeframe_preview, 44) + " | Match " + ASC_HudYesNo(focus_matches);
         change_line = "Last refresh: " + ASC_HudClampText(readback_line_1, 46) + " | " + ASC_HudClampText(verification_hint, 16);
        }

      string timing_accel = StringLen(focus_deep_posture) > 0
                            ? ("Momentum acceleration: " + focus_deep_posture)
                            : "Momentum acceleration: pending fuller readback.";
      string timing_age = "Move age: " + ASC_HudAgeText(selected.observed_at_utc, now_utc) + " | Impulse freshness: " + ASC_HudSymbolFreshnessState(selected);
      string structure_state = has_day_packet
                               ? StringFormat("Range position: bid %.5f vs day [%.5f, %.5f]", live_packet.bid, live_packet.day_low, live_packet.day_high)
                               : "Range position: pending live packet range snapshot.";
      string structure_liquidity = "Liquidity zone / sweep state: " + ASC_TextOrUnavailable(focus_microstructure_summary);
      string execution_quality = "Execution quality: " + ASC_HudPrimaryOpenClosedState(selected.state) + " | " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_score_context), "quality context pending", 52);
      string execution_participation = "Participation quality: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_deep_posture), "participation pending", 40);
      string execution_tradability = "Scalp/intraday tradability: " + deep_posture + " | " + ASC_HudPrimaryOpenClosedState(selected.state);
      string execution_bid_ask_spread = has_live_packet
                                        ? ("Bid/Ask/Spread: "
                                           + DoubleToString(live_packet.bid, price_digits)
                                           + " / " + DoubleToString(live_packet.ask, price_digits)
                                           + " / " + DoubleToString(live_packet.spread_points, 1) + "pt")
                                        : "Bid/Ask/Spread: pending live packet.";
      double mid_price = (has_live_packet ? ((live_packet.bid + live_packet.ask) / 2.0) : 0.0);
      double spread_pct = (has_live_packet && mid_price > 0.0) ? (100.0 * (live_packet.ask - live_packet.bid) / mid_price) : -1.0;
      string execution_spread_pct = (spread_pct >= 0.0)
                                    ? ("Spread %: " + DoubleToString(spread_pct, 3) + "%")
                                    : "Spread %: pending";
      string execution_score_line = StringLen(focus_score_context) > 0
                                    ? ("Execution score: " + ASC_HudTraderSafeSummary(focus_score_context, "pending dossier score context", 80))
                                    : "Execution score: pending dossier score context.";
      string scalp_tradable = (deep_posture == "Ready" && has_live_packet && live_packet.spread_points <= 25.0) ? "Yes" : "No";
      string intraday_tradable = ((deep_posture == "Ready" || deep_posture == "Attention") && ASC_HudPrimaryOpenClosedState(selected.state) == "Open") ? "Yes" : "No";
      string execution_tradable_line = "Scalp tradable: " + scalp_tradable + " | Intraday tradable: " + intraday_tradable;
      string execution_caution_line = "Execution caution/action: " + watch_next_line;
      string timing_trigger_line = "Trigger posture: " + timing_trigger;
      string timing_pressure_line = "Pressure shift score/posture: " + change_line;
      string timing_momentum_line = "Momentum acceleration score/posture: " + timing_accel;
      string timing_move_age_line = "Move age score/posture: " + timing_age;
      string timing_impulse_freshness_line = "Impulse freshness: " + ASC_HudSymbolFreshnessState(selected);
      string timing_time_since_impulse_line = "Time since last impulse: " + ASC_HudAgeText(selected.observed_at_utc, now_utc);
      string timing_next_path_line = (deep_posture == "Ready")
                                     ? "Next likely timing path: trigger can convert if timing remains aligned."
                                     : ((deep_posture == "Attention")
                                        ? "Next likely timing path: timing is building; watch for confirmation pivot."
                                        : "Next likely timing path: timing alignment still forming before trigger conversion.");
      string timing_caution_line = focus_matches
                                   ? ((deep_posture == "Ready")
                                      ? "Timing caution: stay disciplined on invalidation once trigger fires."
                                      : "Timing caution: avoid forcing entries before timing alignment confirms.")
                                   : "Timing caution: selected symbol is not fully aligned with the latest Full Analysis readback.";
      string structure_daily_line = has_day_packet
                                    ? ("Daily open/change: " + DoubleToString(live_packet.day_open, price_digits) + " | " + DoubleToString(live_packet.day_range_pct, 2) + "%")
                                    : "Daily open/change: pending live packet.";
      string structure_position_line = "Position in range: " + structure_state;
      string structure_dist_high_line = has_day_packet
                                        ? StringFormat("Distance to recent high: %.1f points", live_packet.day_high - live_packet.bid)
                                        : "Distance to recent high: pending";
      string structure_dist_low_line = has_day_packet
                                       ? StringFormat("Distance to recent low: %.1f points", live_packet.bid - live_packet.day_low)
                                       : "Distance to recent low: pending";
      string structure_liquidity_line = "Liquidity score/zone/posture: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_microstructure_summary), "liquidity map pending", 64);
      string structure_sweep_line = "Sweep state: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(g_asc_hud.cf_vm_sweep_state), "not flagged in current packet", 48);
      string structure_bias_line = g_asc_hud.cf_vm_bias_summary;
      string structure_alignment_line = "Alignment summary: " + x_tf_line;
      string pressure_state = risk_geometry;
      string momentum_state = timing_accel;
      string move_age_state = timing_age;
      string participation_state = execution_participation;
      string execution_state = execution_friction;
      string liquidity_state = structure_liquidity;
      string timeframe_state = x_tf_line;
      string trigger_state = timing_trigger;
      string refresh_key = selected.symbol + "|" + readback_line_1 + "|" + verification_hint;
      string changed_summary = ASC_HudDeepBuildChangeSummary(refresh_key,
                                                            pressure_state,
                                                            momentum_state,
                                                            move_age_state,
                                                            participation_state,
                                                            execution_state,
                                                            liquidity_state,
                                                            timeframe_state,
                                                            trigger_state);
      string changed_since_refresh = ASC_HudTraderSafeSummary(changed_summary, "What changed since last refresh: pending", 96);
      string changed_probe = changed_since_refresh;
      StringToLower(changed_probe);
      if(StringFind(changed_probe, "what changed:") != 0
         && StringFind(changed_probe, "what changed since last refresh:") != 0)
         changed_since_refresh = "What changed since last refresh: " + changed_since_refresh;
      string alignment_summary = "Alignment summary: " + ASC_HudTraderSafeSummary(readback_line_2, "selected symbol alignment pending", 88);

      string card_a_title = "Full Analysis Read Summary";
      string card_a_l1 = current_read_line;
      string card_a_l2 = thesis_line;
      string card_a_l3 = risk_geometry;
      string card_b_title = "Timing + Alignment + Change";
      string card_b_l1 = timing_trigger;
      string card_b_l2 = x_tf_line;
      string card_b_l3 = change_line;
      string card_c_title = "Trader Watch Next";
      string card_c_l1 = watch_next_line;
      string card_c_l2 = changed_since_refresh;
      string card_c_l3 = "Execution friction: " + execution_friction;

      if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_THESIS)
        {
         card_a_title = "Full Analysis Summary";
         card_a_l1 = "Status: " + current_read_line;
         card_a_l2 = "Last refresh/freshness: " + change_line;
         card_a_l3 = thesis_line;
         card_b_title = "Risk + Timing + Execution";
         card_b_l1 = risk_geometry;
         card_b_l2 = "Trigger/timing posture: " + timing_trigger;
         card_b_l3 = "Execution/friction posture: " + execution_friction;
         card_c_title = "Alignment + Change + Watch";
         card_c_l1 = "Cross-timeframe alignment: " + x_tf_line;
         card_c_l2 = changed_since_refresh;
         card_c_l3 = "Next watch item: " + watch_next_line;
        }
      else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_TIMING)
        {
         card_a_title = "Timing";
         card_a_l1 = timing_trigger_line;
         card_a_l2 = timing_pressure_line;
         card_a_l3 = timing_momentum_line;
         card_b_title = "Timing Pressure";
         card_b_l1 = timing_move_age_line;
         card_b_l2 = timing_impulse_freshness_line;
         card_b_l3 = timing_time_since_impulse_line;
         card_c_title = "Timing Path + Caution";
         card_c_l1 = timing_next_path_line;
         card_c_l2 = "Next watch item: " + watch_next_line;
         card_c_l3 = timing_caution_line;
        }
      else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_STRUCTURE)
        {
         card_a_title = "Structure";
         card_a_l1 = structure_daily_line;
         card_a_l2 = structure_position_line;
         card_a_l3 = structure_dist_high_line;
         card_b_title = "Range + Liquidity Map";
         card_b_l1 = structure_dist_low_line;
         card_b_l2 = structure_liquidity_line;
         card_b_l3 = structure_sweep_line;
         card_c_title = "Bias + Alignment";
         card_c_l1 = structure_bias_line;
         card_c_l2 = structure_alignment_line;
         card_c_l3 = "Structure caution: " + risk_geometry;
        }
      else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_EXECUTION)
        {
         card_a_title = "Execution";
         card_a_l1 = execution_bid_ask_spread;
         card_a_l2 = execution_spread_pct + " | " + execution_friction;
         card_a_l3 = execution_score_line;
         card_b_title = "Execution Posture";
         card_b_l1 = "Liquidity quality: " + ASC_HudTraderSafeSummary(ASC_TextOrUnavailable(focus_microstructure_summary), "liquidity quality pending", 56);
         card_b_l2 = execution_participation;
         card_b_l3 = execution_tradable_line;
         card_c_title = "Execution Action";
         card_c_l1 = execution_quality;
         card_c_l2 = execution_tradability;
         card_c_l3 = execution_caution_line;
        }
      else if(g_asc_hud.selected_deep_subpage == ASC_HUD_DEEP_SUBPAGE_TIMEFRAMES)
        {
         int tf_count = has_current_focus ? g_asc_hud.cf_vm_timeframe_row_count : 0;
         card_a_title = "Timeframes";
         card_a_l1 = tf_count > 0 ? g_asc_hud.cf_vm_timeframe_rows[0] : "No timeframe decision rows available yet.";
         card_a_l2 = tf_count > 1 ? g_asc_hud.cf_vm_timeframe_rows[1] : "Awaiting additional timeframe rows.";
         card_a_l3 = tf_count > 2 ? g_asc_hud.cf_vm_timeframe_rows[2] : "Use Timing/Structure subpages for more row context.";
         card_b_title = "Timeframe Rows";
         card_b_l1 = tf_count > 3 ? g_asc_hud.cf_vm_timeframe_rows[3] : ("Alignment snapshot: " + x_tf_line);
         card_b_l2 = tf_count > 4 ? g_asc_hud.cf_vm_timeframe_rows[4] : ("Change snapshot: " + changed_since_refresh);
         card_b_l3 = tf_count > 5 ? g_asc_hud.cf_vm_timeframe_rows[5] : ("Watch snapshot: " + watch_next_line);
         card_c_title = "Alignment + Pressure Map";
         card_c_l1 = tf_count > 6 ? g_asc_hud.cf_vm_timeframe_rows[6] : ("Cross-timeframe alignment: " + x_tf_line);
         card_c_l2 = tf_count > 7 ? g_asc_hud.cf_vm_timeframe_rows[7] : changed_since_refresh;
         card_c_l3 = tf_count > 8 ? g_asc_hud.cf_vm_timeframe_rows[8] : ("Next watch item: " + watch_next_line);
        }

      ASC_HudRenderCard("stat_block_a", card_a_title,
                        card_a_l1,
                        card_a_l2,
                        card_a_l3,
                        x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());
      ASC_HudRenderCard("stat_block_b", card_b_title,
                        card_b_l1,
                        card_b_l2,
                        card_b_l3,
                        x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());
      ASC_HudRenderCard("stat_block_c", card_c_title,
                        card_c_l1,
                        card_c_l2,
                        card_c_l3,
                        x, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardC());
      ASC_HudRenderCard("stat_block_d", "Context Map",
                        "Full Analysis is a curated operator summary of the selected symbol dossier.",
                        "Full details stay in Current Focus and dossier artifact.",
                        alignment_summary,
                        x + card_w + card_gap, content_top + card_h + 12, card_w, card_h, ASC_HudThemeAccentCardD());
     }
   else
     {
       string scaffold_title = ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section);
       ASC_HudRenderCard("stat_block_a", scaffold_title,
                         "Status: currently inactive.",
                         "Selected symbol context remains pinned for workflow continuity.",
                         "No background action is triggered from this view.",
                         x, content_top, card_w, card_h, ASC_HudThemeAccentCardA());
       ASC_HudRenderCard("stat_block_b", scaffold_title + " Status",
                         "This page keeps the symbol workflow spine visible without pretending it is live.",
                         "This view is available for navigation and currently inactive.",
                         "Use Overview through Full Analysis for active work in this build.",
                         x + card_w + card_gap, content_top, card_w, card_h, ASC_HudThemeAccentCardB());
      ASC_HudHideCard("stat_block_d");
     }

   if(!show_lower_cards && g_asc_hud.selected_symbol_section != ASC_HUD_SYMBOL_SECTION_MARKET_WATCH
      && g_asc_hud.selected_symbol_section != ASC_HUD_SYMBOL_SECTION_SPECIFICATION
      && g_asc_hud.selected_symbol_section != ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER
      && g_asc_hud.selected_symbol_section != ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT
      && g_asc_hud.selected_symbol_section != ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS)
     {
      ASC_HudHideCard("stat_block_c");
      ASC_HudHideCard("stat_block_d");
     }
  }

void ASC_HudRender(const ASC_RuntimeState &runtime)
  {
   if(!g_asc_hud.initialized)
      return;

   g_asc_hud.telemetry_render_enter_count++;
   uint render_started_ms = GetTickCount();
   int render_start_creates = g_asc_hud.proof_cycle_object_creates;
   int render_start_deletes = g_asc_hud.proof_cycle_object_deletes;
   int render_start_text_writes = g_asc_hud.proof_cycle_text_writes;
   int render_start_style_writes = g_asc_hud.proof_cycle_style_writes;
   int render_start_redraws = g_asc_hud.proof_cycle_redraws;
   int render_start_cache_hits = g_asc_hud.proof_object_cache_hit_count;
   int render_start_cache_misses = g_asc_hud.proof_object_cache_miss_count;

   bool resize_burst_active = (g_asc_hud.resize_pending || g_asc_hud.resize_burst_active);
   bool navigation_only_dirty = (g_asc_hud.dirty_navigation && !g_asc_hud.dirty_layout && !g_asc_hud.dirty_data_light && !g_asc_hud.dirty_data_heavy);
   bool process_heavy = (g_asc_hud.dirty_data_heavy && !resize_burst_active && !navigation_only_dirty);
   bool process_light = (g_asc_hud.dirty_data_light || process_heavy);
   bool process_layout = (g_asc_hud.dirty_layout || process_heavy);
   bool telemetry_render_full_classified = (process_heavy || process_layout || g_asc_hud.resize_force_full_rebuild);

   g_asc_hud.has_summary = ASC_Layer1TryGetLatestSummary(g_asc_hud.latest_summary);
   ulong structural_revision = ASC_Layer1StructuralRevision();
   int scope_nav_flags = (ASC_HUD_NAV_DIRTY_LIST | ASC_HUD_NAV_DIRTY_PAGE | ASC_HUD_NAV_DIRTY_SYMBOL | ASC_HUD_NAV_DIRTY_DETAIL);
   bool explicit_scope_or_layout_invalidation = g_asc_hud.dirty_layout
                                                || ((g_asc_hud.dirty_navigation_flags & scope_nav_flags) != 0
                                                    && g_asc_hud.dirty_data_heavy);
   bool needs_full_rebuild = process_heavy
                             && ((g_asc_hud.last_rebuild_revision != structural_revision)
                                 || explicit_scope_or_layout_invalidation);
   if(!navigation_only_dirty && needs_full_rebuild)
     {
      string selected_scope_before_rebuild = g_asc_hud.selected_sub_bucket_key;
      bool rebuilt_symbol_scope = false;
      ASC_HudInvalidateSelectedSymbolCache();
      ASC_HudRebuildData();
      ASC_HudEnsureSelectedDefaults();
      ASC_HudRebuildBucketLeadersList();
      if(g_asc_hud.selected_sub_bucket_key != selected_scope_before_rebuild)
        {
         ASC_HudRebuildSelectedSymbolList();
         rebuilt_symbol_scope = true;
        }
      g_asc_hud.proof_full_rebuild_count++;
      if(rebuilt_symbol_scope)
         g_asc_hud.proof_symbol_list_rebuild_count++;
      g_asc_hud.last_rebuild_revision = structural_revision;
      g_asc_hud.last_rebuild_sub_bucket_key = g_asc_hud.selected_sub_bucket_key;
      g_asc_hud.last_leaders_bucket_id = g_asc_hud.selected_bucket_id;
      g_asc_hud.last_leaders_shortlist_signature = ASC_HudShortlistOrderingSignature();
     }
   else if(!navigation_only_dirty
           && process_heavy
           && g_asc_hud.last_rebuild_sub_bucket_key != g_asc_hud.selected_sub_bucket_key)
     {
      if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
        {
         ASC_HudRebuildSelectedSymbolList();
         g_asc_hud.proof_symbol_list_rebuild_count++;
         g_asc_hud.last_rebuild_sub_bucket_key = g_asc_hud.selected_sub_bucket_key;
        }
      else if(StringLen(g_asc_hud.selected_sub_bucket_key) <= 0)
         g_asc_hud.last_rebuild_sub_bucket_key = g_asc_hud.selected_sub_bucket_key;
     }

   if(!navigation_only_dirty && process_heavy && g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      string leaders_shortlist_signature = ASC_HudShortlistOrderingSignature();
      bool leaders_need_rebuild = (g_asc_hud.last_leaders_bucket_id != g_asc_hud.selected_bucket_id)
                                  || (g_asc_hud.last_leaders_shortlist_signature != leaders_shortlist_signature);
      if(leaders_need_rebuild)
        {
         ASC_HudRebuildBucketLeadersList();
         g_asc_hud.last_leaders_bucket_id = g_asc_hud.selected_bucket_id;
         g_asc_hud.last_leaders_shortlist_signature = leaders_shortlist_signature;
        }
     }

   int chart_w = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0);
   int chart_h = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0);
   if(chart_w <= 0) chart_w = 1320;
   if(chart_h <= 0) chart_h = 700;
   bool viewport_jitter_only = false;
   bool viewport_changed = ASC_HudViewportMaterialChange(g_asc_hud.viewport_w, g_asc_hud.viewport_h, chart_w, chart_h, viewport_jitter_only);
   if(viewport_changed)
      process_layout = true;
   else if(viewport_jitter_only)
      g_asc_hud.hud_viewport_jitter_ignored++;
   else
      g_asc_hud.hud_viewport_reset_avoided++;
   bool force_full_rebuild_after_resize = (g_asc_hud.resize_force_full_rebuild && viewport_changed);
   if(navigation_only_dirty)
     {
      force_full_rebuild_after_resize = false;
      if(g_asc_hud.resize_force_full_rebuild)
         g_asc_hud.hud_transition_rebuild_avoided++;
     }
   if(viewport_changed)
     {
      g_asc_hud.viewport_w = chart_w;
      g_asc_hud.viewport_h = chart_h;
     }
   else
     {
      chart_w = g_asc_hud.viewport_w;
      chart_h = g_asc_hud.viewport_h;
     }

   int root_x = 0;
   int root_y = 0;
   int root_w = chart_w;
   int root_h = chart_h;
   bool page_changed = (g_asc_hud.last_rendered_page != (ASC_HudPage)-1
                        && g_asc_hud.last_rendered_page != g_asc_hud.page);
   ASC_HudRenderScope prior_scope_for_delete = g_asc_hud.last_render_scope;
   ASC_HudRenderScope next_scope_for_delete = ASC_HudRenderScopeForPage(g_asc_hud.page);
   bool scope_changed = (prior_scope_for_delete != next_scope_for_delete);
   bool page_scope_reuse_list_shells = (page_changed
                                        && scope_changed
                                        && !viewport_changed
                                        && !process_layout
                                        && !resize_burst_active
                                        && next_scope_for_delete == ASC_HUD_SCOPE_LIST);

   if(viewport_changed && !resize_burst_active)
      ASC_HudDeletePageLocalObjects();
   else if(page_changed && scope_changed)
      g_asc_hud.proof_page_change_render_count++;
   if(page_changed)
     {
      g_asc_hud.telemetry_page_change_commit_count++;
      uint request_started_ms = g_asc_hud.telemetry_page_change_request_started_ms;
      uint commit_elapsed_ms = (request_started_ms > 0 ? (GetTickCount() - request_started_ms) : 0);
      g_asc_hud.telemetry_page_change_commit_elapsed_last_ms = commit_elapsed_ms;
      if(commit_elapsed_ms > g_asc_hud.telemetry_page_change_commit_elapsed_max_ms)
         g_asc_hud.telemetry_page_change_commit_elapsed_max_ms = commit_elapsed_ms;
      g_asc_hud.telemetry_page_change_request_started_ms = 0;
     }

   g_asc_hud.render_mutations = 0;
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "bg", root_x, root_y, root_w, root_h, ASC_HudThemeBgRoot(), ASC_HudThemeBgRoot());
   int zone_x = root_x + 1;
   int zone_w = root_w - 2;
   int cursor_y = root_y + 1;

   ASC_HudRenderScope prior_scope = g_asc_hud.last_render_scope;
   ASC_HudRenderScope next_scope = ASC_HudRenderScopeForPage(g_asc_hud.page);
   if(viewport_changed && !resize_burst_active)
      prior_scope = ASC_HUD_SCOPE_NONE;
   bool panel_reset_needed = (ASC_HudNeedsPanelReset() || viewport_changed);
   if(panel_reset_needed)
     {
      if(page_scope_reuse_list_shells)
        {
         if(prior_scope == ASC_HUD_SCOPE_OVERVIEW)
            ASC_HudHideOverviewPanels();
         else if(prior_scope == ASC_HUD_SCOPE_SYMBOL_OVERVIEW)
           {
            ASC_HudHideSymbolOverviewPanels();
            ASC_HudHideSymbolSharedControls();
           }
         else if(prior_scope == ASC_HUD_SCOPE_STAT_DETAIL)
           {
            ASC_HudHideStatPanels();
            ASC_HudHideSymbolSharedControls();
           }
         else
            ASC_HudResetPanelsForScopeChange(prior_scope, next_scope);

         if(prior_scope != ASC_HUD_SCOPE_LIST)
           {
            g_asc_hud.proof_scope_transition_count++;
            g_asc_hud.proof_scope_entry_list_count++;
            ASC_HudHideFooterPagerControls();
            g_asc_hud.overview_panels_hidden = true;
            g_asc_hud.symbol_overview_panels_hidden = true;
            g_asc_hud.stat_panels_hidden = true;
            g_asc_hud.symbol_shared_hidden = true;
            g_asc_hud.list_panels_hidden = false;
            g_asc_hud.symbols_scope_hidden = false;
            g_asc_hud.list_rows_render_signature = "";
           }
        }
      else
         ASC_HudResetPanelsForScopeChange(prior_scope, next_scope);
     }

   ASC_HudRenderHeader(zone_x, cursor_y, zone_w);
   cursor_y += ASC_HUD_HEADER_H + ASC_HUD_SHELL_GAP;
   ASC_HudRenderTopNav(zone_x, cursor_y, zone_w);
   cursor_y += ASC_HUD_TOPNAV_H + ASC_HUD_SHELL_GAP;
   ASC_HudRenderBreadcrumbZone(zone_x, cursor_y, zone_w);
   cursor_y += ASC_HUD_BREADCRUMB_H + ASC_HUD_SHELL_GAP;
   bool show_symbol_actions = (StringLen(g_asc_hud.selected_symbol) > 0)
                              && (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
   bool show_higher_page_refresh = ASC_HudPageShowsHigherRefreshControl(g_asc_hud.page);
   if(show_symbol_actions || show_higher_page_refresh)
     {
      ASC_HudRenderQuickActionsZone(zone_x, cursor_y, zone_w);
      cursor_y += ASC_HUD_ACTION_H + ASC_HUD_SHELL_GAP;
     }
   else
      ASC_HudRenderQuickActionsZone(0, 0, 0);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "transition_zone", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureRect(ASC_HUD_PREFIX + "transition_bar", 0, 0, 0, 0, clrBlack, clrBlack);
   ASC_HudEnsureLabel(ASC_HUD_PREFIX + "transition_text", "", 0, 0, 8, clrBlack);

   int footer_y = root_y + root_h - ASC_HUD_FOOTER_H - 2;
   int body_x = root_x + 10;
   int body_y = cursor_y;
   int body_w = root_w - 20;
   bool show_symbol_section_row = (StringLen(g_asc_hud.selected_symbol) > 0)
                                  && (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
   int section_row_h = ASC_HudSymbolSectionRowHeight(body_w);
   int section_row_gap = 8;
   int body_bottom = footer_y - ASC_HUD_CONTENT_GAP;
   if(show_symbol_section_row)
      body_bottom -= (section_row_h + section_row_gap);
   int body_h = body_bottom - body_y;
   if(body_h < 1)
      body_h = 1;

   if(ASC_HudIsListPage())
     {
      ASC_HudTrackFamilyVisibility(g_asc_hud.proof_list_family_visible, true, g_asc_hud.proof_list_family_visibility_changes);
      g_asc_hud.list_panels_hidden = false;
       int list_header_h = 64;
       if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
          list_header_h = 74;
       else if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
          list_header_h = 70;
       int list_body_h = body_h - list_header_h - 1;
      if(list_body_h < 40)
         list_body_h = 40;
      ASC_HudComputeListPaging(list_body_h, body_w);
      if(process_layout || !g_asc_hud.list_row_shell_prepared)
         ASC_HudPrepareListRowShells();
     }
   else
     {
      ASC_HudTrackFamilyVisibility(g_asc_hud.proof_list_family_visible, false, g_asc_hud.proof_list_family_visibility_changes);
      g_asc_hud.list_panels_hidden = true;
      g_asc_hud.symbols_scope_hidden = true;
      g_asc_hud.list_slots_visible = 0;
      g_asc_hud.list_total_items = 0;
      g_asc_hud.list_total_pages = 1;
      g_asc_hud.list_current_page = 1;
      g_asc_hud.list_range_start = 0;
      g_asc_hud.list_range_end = 0;
      g_asc_hud.list_row_h_effective = 0;
      g_asc_hud.list_row_spacing_effective = 0;
      g_asc_hud.list_pack_remainder_px = 0;
      g_asc_hud.list_rows_render_signature = "";
      g_asc_hud.list_body_h = 0;
      g_asc_hud.list_body_w = 0;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_OVERVIEW)
     {
      g_asc_hud.overview_panels_hidden = false;
      ASC_HudRenderOverviewPage(runtime, body_x, body_y, body_w);
     }
   else if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW)
     {
      g_asc_hud.symbol_overview_panels_hidden = false;
      g_asc_hud.symbol_shared_hidden = false;
      ASC_HudRenderSymbolDetailPage(body_x, body_y, body_w);
     }
   else if(g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL)
     {
      g_asc_hud.stat_panels_hidden = false;
      g_asc_hud.symbol_shared_hidden = false;
      ASC_HudRenderStatDetailPage(body_x, body_y, body_w);
     }
   else
     {
      string section_name = ASC_HudLabelMarkets();
      bool symbols_scope_rendered = false;
      string section_desc = "Market distribution | Forex | Indices | Stocks | Metals | Energy | Crypto | Unknown";
      string section_line2 = StringFormat("Open %d | Universe %d | Coverage %d/%d",
                                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.open_count : 0),
                                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.total_symbols : 0),
                                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.resolved_classification_count : 0),
                                          (g_asc_hud.has_summary ? g_asc_hud.latest_summary.total_symbols : 0));
       string section_line3 = ASC_HudSubsetScopeLine();
      if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
        {
         string selected_main_bucket_name = ASC_HudMainBucketName(g_asc_hud.selected_bucket_id);
         section_name = ASC_HudLabelLeaders();
         section_desc = StringFormat("%s leaders ordered for fast scan.", selected_main_bucket_name);
         section_line2 = StringFormat("Visible %d | Bucket top-five carry order", ArraySize(g_asc_hud.leader_row_indices));
         section_line3 = "Leaders first, then Groups, then Symbols. | " + ASC_HudPageCommandSummary(g_asc_hud.page);
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
        {
         int shortlist_total = ASC_ShortlistCount(g_asc_hud_shortlist_rows);
         section_name = ASC_HudLabelGlobalTop10();
         section_desc = "Premium diversified-overall view of the strongest current carry.";
         section_line2 = StringFormat("Visible %d of %d | Source shortlist and board carry", ASC_HudVisibleGlobalTop10Count(), shortlist_total);
         section_line3 = "Distinct from market, bucket, and group views. | " + ASC_HudPageCommandSummary(g_asc_hud.page) + " | " + ASC_HudPageRankSurfaceSummary(g_asc_hud.page);
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
        {
         section_desc = "Market routing view: breadth first, then readiness, then opportunity.";
         section_line2 = StringFormat("Open %d of %d | Focus market %s",
                                      (g_asc_hud.has_summary ? g_asc_hud.latest_summary.open_count : 0),
                                      (g_asc_hud.has_summary ? g_asc_hud.latest_summary.total_symbols : 0),
                                      ASC_HudOverviewFocusBucketName());
         section_line3 = "Choose a market, then open Leaders or Groups in the same scope. | " + ASC_HudPageCommandSummary(g_asc_hud.page);
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
        {
         string selected_main_bucket_name = ASC_HudMainBucketName(g_asc_hud.selected_bucket_id);
         section_name = ASC_HudLabelGroups();
         int visible_sub_groups = 0;
         int bucket_universe = 0;
         int bucket_open = 0;
         int bucket_eligible = 0;
         if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
           {
            section_name = ASC_HudCurrentStockBrowseHeading();
            string parent_key = ASC_HudActiveStockBrowseParentKey();
            string parent_path = ASC_HudBrowseNodePath(parent_key);
            for(int sg = 0; sg < ArraySize(g_asc_hud.browse_nodes); sg++)
               if(g_asc_hud.browse_nodes[sg].parent_key == parent_key
                  && ASC_HudBrowseNodeAllowedByControls(g_asc_hud.browse_nodes[sg]))
                 {
                  visible_sub_groups++;
                  bucket_universe += g_asc_hud.browse_nodes[sg].total;
                  bucket_open += g_asc_hud.browse_nodes[sg].open_count;
                  bucket_eligible += g_asc_hud.browse_nodes[sg].eligible_count;
                 }
            string family_scope = (StringLen(parent_path) > 0 ? parent_path : "All Stock Families");
            section_desc = StringFormat("Scope %s | Parent %s | %s ordered for quick comparison.",
                                        selected_main_bucket_name,
                                        family_scope,
                                        section_name);
            section_line2 = StringFormat("Visible %d | Open %d | Ready %d/%d",
                                         visible_sub_groups,
                                         bucket_open,
                                         bucket_eligible,
                                         bucket_universe);
            section_line3 = StringFormat("Trail: Markets > %s > %s > %s",
                                         selected_main_bucket_name,
                                         family_scope,
                                         section_name);
            section_line3 += " | " + ASC_HudPageCommandSummary(g_asc_hud.page);
           }
         else
           {
            for(int sg = 0; sg < ArraySize(g_asc_hud.sub_buckets); sg++)
               if(g_asc_hud.sub_buckets[sg].bucket_id == g_asc_hud.selected_bucket_id)
                 {
                  visible_sub_groups++;
                  bucket_universe += g_asc_hud.sub_buckets[sg].total;
                  bucket_open += g_asc_hud.sub_buckets[sg].open_count;
                  bucket_eligible += g_asc_hud.sub_buckets[sg].eligible_count;
                 }
            section_desc = StringFormat("%s groups ordered for breadth, leader context, and tradability.", selected_main_bucket_name);
            section_line2 = StringFormat("Visible %d | Open %d | Ready %d/%d", visible_sub_groups, bucket_open, bucket_eligible, bucket_universe);
            section_line3 = "Compare groups first, then open Symbols for the chosen scope. | " + ASC_HudPageCommandSummary(g_asc_hud.page);
           }
        }
      if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
        {
         ASC_HudHideCard("list_head");
         g_asc_hud.symbols_scope_hidden = false;
         int list_head_h = 74;
         ASC_HudRenderSymbolsScopeCard(body_x, body_y, body_w, list_head_h);
         int row_height = (g_asc_hud.list_row_h_effective > 0 ? g_asc_hud.list_row_h_effective : ASC_HudRowHeight());
         int rows_y = body_y + list_head_h + 3;
         ASC_HudRenderRows(body_x, rows_y, body_w, row_height, g_asc_hud.list_body_h);
         symbols_scope_rendered = true;
        }

      if(!symbols_scope_rendered)
        {
         ASC_HudHideSymbolsScopeCard();
         g_asc_hud.symbols_scope_hidden = true;
         int list_head_h = 64;
         ASC_HudRenderCard("list_head", section_name, section_desc, section_line2, section_line3, body_x, body_y, body_w, list_head_h, C'81,233,184');
         int row_height = (g_asc_hud.list_row_h_effective > 0 ? g_asc_hud.list_row_h_effective : ASC_HudRowHeight());
         if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
             row_height = MathMax(48, row_height - 2);
         int rows_y = body_y + list_head_h + 5;
         ASC_HudRenderRows(body_x, rows_y, body_w, row_height, g_asc_hud.list_body_h);
        }
     }
   if(show_symbol_section_row)
      ASC_HudRenderSymbolActionRow(body_x, body_bottom + section_row_gap, body_w, true);
   else
      ASC_HudRenderSymbolActionRow(0, 0, 0, false);

   ASC_HudRenderBottomRow(root_x + 8, footer_y, root_w - 16);

   g_asc_hud.render_id++;
   g_asc_hud.last_render_utc = TimeGMT();
   g_asc_hud.last_rendered_page = g_asc_hud.page;
   g_asc_hud.last_rendered_symbol = g_asc_hud.selected_symbol;
   g_asc_hud.last_rendered_stat = g_asc_hud.selected_stat;
   g_asc_hud.last_render_scope = next_scope;
   if(process_heavy || force_full_rebuild_after_resize)
      g_asc_hud.last_structure_fingerprint = ASC_HudStructuralFingerprint();
   if(process_light)
      g_asc_hud.last_data_fingerprint = ASC_HudDataFingerprint();
   if(process_light)
      g_asc_hud.last_tactical_fingerprint = ASC_HudTacticalFingerprint();
   if(MQLInfoInteger(MQL_DEBUG) != 0)
     {
      if(process_heavy)
         g_asc_hud.last_structure_signature = ASC_HudStructuralSignature();
      if(process_light)
         g_asc_hud.last_data_signature = ASC_HudDataSignature();
      if(process_light)
         g_asc_hud.last_tactical_signature = ASC_HudTacticalSignature();
     }
   g_asc_hud.proof_render_pass_count++;
   g_asc_hud.dirty = false;
   g_asc_hud.dirty_layout = false;
   g_asc_hud.dirty_data_light = false;
   g_asc_hud.dirty_data_heavy = false;
   g_asc_hud.queued_heavy_refresh = false;
   g_asc_hud.queued_heavy_refresh_reason = "";
   g_asc_hud.dirty_navigation = false;
   g_asc_hud.dirty_navigation_flags = ASC_HUD_NAV_DIRTY_NONE;
   if(process_layout)
     {
      g_asc_hud.chart_change_pending = false;
      g_asc_hud.chart_change_last_render_ms = GetTickCount();
      g_asc_hud.viewport_committed_w = g_asc_hud.viewport_w;
      g_asc_hud.viewport_committed_h = g_asc_hud.viewport_h;
      g_asc_hud.hud_layout_commit_count++;
     }
   if(page_changed || scope_changed)
      g_asc_hud.hud_transition_commit_count++;
   if(force_full_rebuild_after_resize)
      g_asc_hud.resize_force_full_rebuild = false;
   g_asc_hud.proof_last_render_build_ms = GetTickCount() - render_started_ms;
   g_asc_hud.proof_last_object_update_ms = g_asc_hud.proof_last_render_build_ms;
   g_asc_hud.proof_last_render_objects_created = MathMax(0, g_asc_hud.proof_cycle_object_creates - render_start_creates);
   g_asc_hud.proof_last_render_objects_deleted = MathMax(0, g_asc_hud.proof_cycle_object_deletes - render_start_deletes);
   g_asc_hud.proof_last_render_objects_updated = MathMax(0, (g_asc_hud.proof_cycle_text_writes - render_start_text_writes) + (g_asc_hud.proof_cycle_style_writes - render_start_style_writes));
   g_asc_hud.proof_last_render_redraws = MathMax(0, g_asc_hud.proof_cycle_redraws - render_start_redraws);
   g_asc_hud.proof_last_render_mutation_count = g_asc_hud.render_mutations;
   int render_cache_hits = MathMax(0, g_asc_hud.proof_object_cache_hit_count - render_start_cache_hits);
   int render_cache_misses = MathMax(0, g_asc_hud.proof_object_cache_miss_count - render_start_cache_misses);
   int render_cache_total = render_cache_hits + render_cache_misses;
   g_asc_hud.proof_last_render_object_cache_hit_ratio = (render_cache_total > 0 ? (double)render_cache_hits / (double)render_cache_total : 1.0);
   g_asc_hud.proof_last_render_scope = ASC_HudRenderScopeName(g_asc_hud.last_render_scope);
   g_asc_hud.proof_last_render_reason = (process_heavy
                                         ? "heavy"
                                         : (process_light
                                            ? "light"
                                            : (navigation_only_dirty
                                            ? StringFormat("navigation_only full=%d symbol=%d",
                                                              g_asc_hud.proof_full_rebuild_count,
                                                              g_asc_hud.proof_symbol_list_rebuild_count)
                                               : "display")));
   if(telemetry_render_full_classified)
      g_asc_hud.telemetry_render_full_count++;
   else
      g_asc_hud.telemetry_render_partial_count++;

   if(g_asc_hud.render_mutations > 0 || viewport_changed)
     {
      ASC_HudRequestRedraw();
     }
   ASC_HudFlushPendingRedraw();
   uint render_elapsed_ms = GetTickCount() - render_started_ms;
   g_asc_hud.proof_last_transition_total_ms = render_elapsed_ms;
   g_asc_hud.telemetry_render_elapsed_last_ms = render_elapsed_ms;
   if(render_elapsed_ms > g_asc_hud.telemetry_render_elapsed_max_ms)
      g_asc_hud.telemetry_render_elapsed_max_ms = render_elapsed_ms;
  }

void ASC_HudHandleRowClick(const int row_index)
  {
   int target = g_asc_hud.list_offset + row_index;

   if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
     {
      int visible = -1;
      for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
        {
         if(!ASC_HudBucketAllowedByControls(g_asc_hud.buckets[i].id))
            continue;
         visible++;
         if(visible != target)
            continue;
         g_asc_hud.selected_bucket_id = g_asc_hud.buckets[i].id;
         g_asc_hud.selected_sub_bucket_key = "";
         g_asc_hud.selected_browse_node_key = "";
         if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
            g_asc_hud.selected_browse_parent_key = "B|" + g_asc_hud.selected_bucket_id;
         else
            g_asc_hud.selected_browse_parent_key = "";
         g_asc_hud.selected_symbol = "";
         ASC_HudOpenPage(ASC_HUD_PAGE_BUCKET_LEADERS);
         return;
        }
      return;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
     {
      int visible = -1;
      for(int i = 0; i < ArraySize(g_asc_hud.leader_row_indices); i++)
        {
         int shortlist_idx = g_asc_hud.leader_row_indices[i];
         if(shortlist_idx < 0 || shortlist_idx >= ArraySize(g_asc_hud_shortlist_rows))
            continue;
         ASC_ShortlistSymbolSummary shortlist_entry = g_asc_hud_shortlist_rows[shortlist_idx];
         int layer1_index = -1;
         ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(shortlist_entry, layer1_index);
         if(!ASC_HudLeaderRowStateIsVisible(visibility_state))
            continue;
         ASC_Layer1SymbolState state;
         bool using_retained_state = false;
         bool using_shortlist_fallback = false;
         ASC_HudResolveLeaderDisplayState(shortlist_entry,
                                          visibility_state,
                                          state,
                                          using_retained_state,
                                          using_shortlist_fallback,
                                          layer1_index);
         visible++;
         if(visible != target)
            continue;
         ASC_HudLogLeadersScope("entered_scope",
                                "leader_row_indices",
                                StringFormat("row_click target=%d shortlist_idx=%d state=%s",
                                             target,
                                             shortlist_idx,
                                             ASC_HudLeaderRowVisibilityStateLabel(visibility_state)));
         g_asc_hud.selected_symbol = state.symbol;
         g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
         g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
         ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOL_OVERVIEW);
         return;
        }
      return;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
     {
      if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
        {
         string parent_key = ASC_HudActiveStockBrowseParentKey();
         ASC_HudBrowseNode node;
         if(ASC_HudVisibleBrowseNodeAt(parent_key, target, node))
           {
            g_asc_hud.selected_browse_node_key = node.key;
            if(ASC_HudBrowseNodeHasChildren(node.key))
              {
               g_asc_hud.selected_browse_parent_key = node.key;
               g_asc_hud.list_offset = 0;
               ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_LIST | ASC_HUD_NAV_DIRTY_PAGE);
               return;
              }

            g_asc_hud.selected_sub_bucket_key = node.key;
            g_asc_hud.selected_symbol = "";
            ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOLS);
            return;
           }
         return;
        }

      int visible = -1;
      for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
        {
         if(g_asc_hud.sub_buckets[i].bucket_id != g_asc_hud.selected_bucket_id)
            continue;
         visible++;
         if(visible == target)
           {
            g_asc_hud.selected_sub_bucket_key = g_asc_hud.sub_buckets[i].key;
            g_asc_hud.selected_symbol = "";
            ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOLS);
            return;
           }
        }
      return;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
     {
      ASC_ShortlistSymbolSummary shortlist_entry;
      int shortlist_total = 0;
      if(ASC_HudTryGetGlobalTop10EntryByVisibleIndex(target, shortlist_entry, shortlist_total))
        {
         string symbol = shortlist_entry.symbol;
         if(StringLen(symbol) <= 0)
            symbol = shortlist_entry.state.symbol;
         if(StringLen(symbol) > 0)
           {
            g_asc_hud.selected_symbol = symbol;
            g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
            g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
            ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOL_OVERVIEW);
           }
        }
      return;
     }

   if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
     {
      int visible = -1;
      for(int i = 0; i < ArraySize(g_asc_hud.symbol_indices); i++)
        {
         ASC_Layer1SymbolState state;
         if(!ASC_HudMaterializeSymbolState(g_asc_hud.symbol_indices[i], state))
            continue;
         visible++;
         if(visible != target)
            continue;
         g_asc_hud.selected_symbol = state.symbol;
         g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
         g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
         ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOL_OVERVIEW);
         return;
        }
     }
  }

void ASC_HudPagePrev()
  {
   int row_limit = ASC_HudVisibleRowLimit();
   if(g_asc_hud.list_current_page <= 1)
      return;
   if(g_asc_hud.list_offset >= row_limit)
      g_asc_hud.list_offset -= row_limit;
   else
      g_asc_hud.list_offset = 0;
   ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_LIST | ASC_HUD_NAV_DIRTY_PAGE);
  }

void ASC_HudPageNext()
  {
   int row_limit = ASC_HudVisibleRowLimit();
   int max_rows = g_asc_hud.list_total_items;

   if(g_asc_hud.list_current_page >= g_asc_hud.list_total_pages)
      return;

   if(g_asc_hud.list_offset + row_limit < max_rows)
      g_asc_hud.list_offset += row_limit;
   ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_LIST | ASC_HUD_NAV_DIRTY_PAGE);
  }

void ASC_HudInit()
  {
   g_asc_hud.initialized = true;
   g_asc_hud.visible = g_asc_trader_controls.hud_enabled;
   if(!g_asc_trader_controls.hud_enabled)
     {
      g_asc_hud.dirty = false;
      g_asc_hud.redraw_pending = false;
      ASC_HudDeleteObjects();
      return;
     }
   g_asc_hud.dirty = false;
   g_asc_hud.dirty_layout = false;
   g_asc_hud.dirty_data_light = false;
   g_asc_hud.dirty_data_heavy = false;
   g_asc_hud.queued_heavy_refresh = false;
   g_asc_hud.queued_heavy_refresh_reason = "";
   g_asc_hud.dirty_navigation = false;
   g_asc_hud.dirty_navigation_flags = ASC_HUD_NAV_DIRTY_NONE;
   ASC_HudMarkDirtyDataHeavy();
   g_asc_hud.page = ASC_HUD_PAGE_OVERVIEW;
   g_asc_hud.selected_bucket_id = "unknown";
   g_asc_hud.selected_sub_bucket_key = "";
   g_asc_hud.selected_browse_parent_key = "";
   g_asc_hud.selected_browse_node_key = "";
   g_asc_hud.selected_symbol = "";
   g_asc_hud.selected_symbol_layer1_index = -1;
   g_asc_hud.selected_symbol_layer1_revision = 0;
   g_asc_hud.selected_symbol_list_key = "";
   g_asc_hud.selected_symbol_list_filter_signature = "";
   g_asc_hud.selected_symbol_list_revision = 0;
   g_asc_hud.selected_symbol_list_shortlist_revision = 0;
   g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
   g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_THESIS;
   g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
   g_asc_hud.list_offset = 0;
   g_asc_hud.history_count = 0;
   g_asc_hud.forward_count = 0;
   g_asc_hud.last_data_signature = "";
   g_asc_hud.last_structure_signature = "";
   g_asc_hud.last_tactical_signature = "";
   g_asc_hud.last_data_fingerprint = 0;
   g_asc_hud.last_structure_fingerprint = 0;
   g_asc_hud.last_tactical_fingerprint = 0;
   g_asc_hud.last_shortlist_signature = "";
   g_asc_hud.last_shortlist_signature_source = "";
   g_asc_hud.last_shortlist_signature_revision = 0;
   g_asc_hud.last_shortlist_signature_pass_utc = 0;
   g_asc_hud.last_shortlist_signature_count = 0;
   g_asc_hud.shortlist_order_hash_scope_key = "";
   g_asc_hud.shortlist_order_hash_page = (ASC_HudPage)-1;
   g_asc_hud.shortlist_order_hash_source = "";
   g_asc_hud.shortlist_order_hash_revision = 0;
   g_asc_hud.shortlist_order_hash_pass_utc = 0;
   g_asc_hud.shortlist_order_hash_count = 0;
   g_asc_hud.shortlist_order_hash_value = 0;
   g_asc_hud.shortlist_order_hash_signature = "";
   ASC_HudGlobalTop10CacheInvalidate();
   g_asc_hud.last_shortlist_source = "";
   g_asc_hud.last_shortlist_revision = 0;
   g_asc_hud.last_shortlist_pass_utc = 0;
   g_asc_hud.last_shortlist_count = 0;
   g_asc_hud.has_summary = false;
   g_asc_hud.render_id = 0;
   g_asc_hud.objects_touched = 0;
   g_asc_hud.row_count = 0;
   g_asc_hud.last_render_utc = 0;
   g_asc_hud.transient_notice = "";
   g_asc_hud.transient_notice_until = 0;
   g_asc_hud.deep_trigger_pending = false;
   g_asc_hud.deep_trigger_symbol = "";
   g_asc_hud.deep_trigger_requested_utc = 0;
   g_asc_hud.deep_trigger_last_status = "idle";
   g_asc_hud.deep_trigger_last_served_utc = 0;
   g_asc_hud.deep_trigger_runtime_reason = "";
   g_asc_hud.deep_change_seeded = false;
   g_asc_hud.deep_change_refresh_key = "";
   g_asc_hud.deep_change_last_summary = "";
   g_asc_hud.deep_change_pressure = "";
   g_asc_hud.deep_change_momentum = "";
   g_asc_hud.deep_change_move_age = "";
   g_asc_hud.deep_change_participation = "";
   g_asc_hud.deep_change_execution = "";
   g_asc_hud.deep_change_liquidity = "";
   g_asc_hud.deep_change_timeframes = "";
   g_asc_hud.deep_change_trigger = "";
   g_asc_hud.current_focus_runtime_status = "";
   g_asc_hud.current_focus_runtime_reason = "";
   g_asc_hud.current_focus_runtime_live_symbol = "";
   g_asc_hud.current_focus_runtime_last_served_utc = 0;
   g_asc_hud.current_focus_cache_text = "";
   g_asc_hud.current_focus_cache_last_read_utc = 0;
   g_asc_hud.current_focus_cache_last_modified_utc = 0;
   g_asc_hud.last_rendered_page = (ASC_HudPage)-1;
   g_asc_hud.last_rendered_symbol = "";
   g_asc_hud.last_rendered_stat = ASC_HUD_STAT_NONE;
   g_asc_hud.viewport_w = 1320;
   g_asc_hud.viewport_h = 700;
   g_asc_hud.viewport_pending_w = 0;
   g_asc_hud.viewport_pending_h = 0;
   g_asc_hud.viewport_committed_w = 1320;
   g_asc_hud.viewport_committed_h = 700;
   g_asc_hud.list_slots_visible = 0;
   g_asc_hud.list_total_items = 0;
   g_asc_hud.list_total_pages = 1;
   g_asc_hud.list_current_page = 1;
   g_asc_hud.list_range_start = 0;
   g_asc_hud.list_range_end = 0;
   g_asc_hud.list_row_h_effective = 0;
   g_asc_hud.list_row_spacing_effective = 0;
   g_asc_hud.list_pack_remainder_px = 0;
   g_asc_hud.list_body_h = 0;
   g_asc_hud.list_body_w = 0;
   g_asc_hud.rebuild_tracked_symbols = 0;
   g_asc_hud.rebuild_assigned_symbols = 0;
   g_asc_hud.rebuild_fallback_symbols = 0;
   g_asc_hud.rebuild_lost_symbols = 0;
   g_asc_hud.bootstrap_active = false;
   g_asc_hud.live_entitled_count = 0;
   g_asc_hud.retention_only_count = 0;
   g_asc_hud.dossier_shell_presence_count = 0;
   g_asc_hud.dossier_rich_presence_count = -1;
   g_asc_hud.transition_until = 0;
   g_asc_hud.transition_guard_until_ms = 0;
   g_asc_hud.transition_guard_strict = false;
   g_asc_hud.transition_label = "";
   g_asc_hud.transition_from = ASC_HUD_PAGE_OVERVIEW;
   g_asc_hud.transition_to = ASC_HUD_PAGE_OVERVIEW;
   g_asc_hud.pending_navigation_transition = false;
   g_asc_hud.pending_navigation_label = "";
   g_asc_hud.pending_navigation_requested_utc = 0;
   g_asc_hud.pending_navigation_reason = "";
   g_asc_hud.pending_navigation_target_page = ASC_HUD_PAGE_OVERVIEW;
   g_asc_hud.pending_navigation_target_symbol = "";
   g_asc_hud.hud_click_acknowledged = false;
   g_asc_hud.hud_ack_label = "";
   g_asc_hud.hud_pending_render = false;
   g_asc_hud.hud_pending_target_page = "";
   g_asc_hud.hud_pending_target_symbol = "";
   g_asc_hud.hud_deferred_render_reason = "";
   g_asc_hud.current_focus_sync_deferred = false;
   g_asc_hud.current_focus_sync_deferred_symbol = "";
   g_asc_hud.current_focus_sync_deferred_utc = 0;
   g_asc_hud.current_focus_cache_state = "missing";
   g_asc_hud.current_focus_cache_posture = "Current Focus cache not warmed";
   g_asc_hud.current_focus_refresh_deferred = false;
   g_asc_hud.current_focus_refresh_deferred_reason = "";
   g_asc_hud.current_focus_refresh_deferred_utc = 0;
   g_asc_hud.view_model_page_type = "";
   g_asc_hud.view_model_bucket = "";
   g_asc_hud.view_model_sub_bucket = "";
   g_asc_hud.view_model_selected_symbol = "";
   g_asc_hud.view_model_selected_display_name = "";
   g_asc_hud.view_model_market_state_label = "";
   g_asc_hud.view_model_actionable_posture_label = "";
   g_asc_hud.view_model_currentness_label = "";
   g_asc_hud.view_model_current_focus_summary = "";
   g_asc_hud.view_model_market_board_summary = "";
   g_asc_hud.view_model_cache_posture = "";
   g_asc_hud.view_model_version = "RUN104R_NAV_SAFE_VM";
   g_asc_hud.view_model_last_built_ms = 0;
   g_asc_hud.view_model_cache_hit = false;
   g_asc_hud.view_model_cache_miss = true;
   g_asc_hud.view_model_dirty_reason = "init";
   g_asc_hud.cf_vm_symbol = "";
   g_asc_hud.cf_vm_canonical = "";
   g_asc_hud.cf_vm_deep_posture = "";
   g_asc_hud.cf_vm_deep_summary = "";
   g_asc_hud.cf_vm_score_context = "";
   g_asc_hud.cf_vm_microstructure = "";
   g_asc_hud.cf_vm_refresh_request_id = "";
   g_asc_hud.cf_vm_published = "";
   g_asc_hud.cf_vm_completed_truth = false;
   g_asc_hud.cf_vm_sweep_state = "";
   g_asc_hud.cf_vm_bias_summary = "Bias S/M/H: pending";
   g_asc_hud.cf_vm_deep_readiness_summary = "subsections ready 0/8";
   g_asc_hud.cf_vm_timeframe_preview = "timeframe summary preview unavailable";
   g_asc_hud.cf_vm_timeframe_row_count = 0;
   ArrayResize(g_asc_hud.cf_vm_timeframe_rows, 9);
   for(int init_row_i = 0; init_row_i < 9; init_row_i++)
      g_asc_hud.cf_vm_timeframe_rows[init_row_i] = "";
   g_asc_hud.queued_nav_click_pending = false;
   g_asc_hud.queued_nav_click_control = "";
   g_asc_hud.queued_nav_click_utc = 0;
   g_asc_hud.last_render_scope = ASC_HUD_SCOPE_NONE;
   g_asc_hud.render_mutations = 0;
   g_asc_hud.redraw_pending = false;
   g_asc_hud.last_render_context_signature = "";
   g_asc_hud.last_render_snapshot_signature = "";
   g_asc_hud.proof_snapshot_skip_count = 0;
   g_asc_hud.telemetry_render_enter_count = 0;
   g_asc_hud.telemetry_render_full_count = 0;
   g_asc_hud.telemetry_render_partial_count = 0;
   g_asc_hud.telemetry_render_skip_count = 0;
   g_asc_hud.telemetry_render_elapsed_last_ms = 0;
   g_asc_hud.telemetry_render_elapsed_max_ms = 0;
   g_asc_hud.telemetry_page_change_request_count = 0;
   g_asc_hud.telemetry_page_change_commit_count = 0;
   g_asc_hud.telemetry_page_change_commit_elapsed_last_ms = 0;
   g_asc_hud.telemetry_page_change_commit_elapsed_max_ms = 0;
   g_asc_hud.telemetry_page_change_request_started_ms = 0;
   g_asc_hud.telemetry_page_change_request_target = (ASC_HudPage)-1;
   g_asc_hud.telemetry_object_set_attempt_count = 0;
   g_asc_hud.telemetry_object_set_changed_count = 0;
   g_asc_hud.telemetry_object_set_noop_count = 0;
   g_asc_hud.telemetry_viewport_full_delete_count = 0;
   g_asc_hud.telemetry_redraw_flush_elapsed_last_ms = 0;
   g_asc_hud.telemetry_redraw_flush_elapsed_max_ms = 0;
   g_asc_hud.last_rebuild_revision = 0;
   g_asc_hud.last_rebuild_sub_bucket_key = "";
   g_asc_hud.last_leaders_bucket_id = "";
   g_asc_hud.last_leaders_shortlist_signature = "";
   g_asc_hud.proof_full_rebuild_count = 0;
   g_asc_hud.proof_symbol_list_rebuild_count = 0;
   g_asc_hud.proof_render_pass_count = 0;
   g_asc_hud.proof_full_redraw_count = 0;
   g_asc_hud.proof_page_change_render_count = 0;
   g_asc_hud.proof_transition_window_active_beats = 0;
   g_asc_hud.proof_transition_lock_skip_count = 0;
   g_asc_hud.proof_object_create_total = 0;
   g_asc_hud.proof_object_delete_total = 0;
   g_asc_hud.proof_text_write_total = 0;
   g_asc_hud.proof_style_write_total = 0;
   g_asc_hud.proof_cycle_object_creates = 0;
   g_asc_hud.proof_cycle_object_deletes = 0;
   g_asc_hud.proof_cycle_text_writes = 0;
   g_asc_hud.proof_cycle_style_writes = 0;
   g_asc_hud.proof_cycle_redraws = 0;
   g_asc_hud.proof_object_cache_hit_count = 0;
   g_asc_hud.proof_object_cache_miss_count = 0;
   g_asc_hud.proof_object_text_skipped_same_count = 0;
   g_asc_hud.proof_object_style_skipped_same_count = 0;
   g_asc_hud.proof_object_visibility_skipped_same_count = 0;
   g_asc_hud.proof_object_property_read_count = 0;
   g_asc_hud.proof_object_find_count = 0;
   g_asc_hud.proof_object_delete_all_count = 0;
   g_asc_hud.proof_object_delete_single_count = 0;
   g_asc_hud.proof_object_delete_scoped_count = 0;
   g_asc_hud.proof_redraw_request_count = 0;
   g_asc_hud.proof_redraw_flush_count = 0;
   g_asc_hud.proof_redraw_suppressed_no_mutation_count = 0;
   g_asc_hud.hud_obj_set_skipped = 0;
   g_asc_hud.hud_obj_set_changed = 0;
   g_asc_hud.hud_obj_create_reused = 0;
   g_asc_hud.hud_obj_delete_avoided = 0;
   g_asc_hud.hud_scoped_hide_count = 0;
   g_asc_hud.hud_redraw_avoided = 0;
   g_asc_hud.hud_clock_minimal_update = 0;
   g_asc_hud.hud_full_render_avoided = 0;
   g_asc_hud.hud_viewport_reset_avoided = 0;
   g_asc_hud.hud_viewport_jitter_ignored = 0;
   g_asc_hud.hud_layout_dirty_skipped = 0;
   g_asc_hud.hud_transition_rebuild_avoided = 0;
   g_asc_hud.hud_full_reset_reason = "none";
   g_asc_hud.hud_layout_commit_count = 0;
   g_asc_hud.hud_transition_commit_count = 0;
   g_asc_hud.proof_last_render_mutation_count = 0;
   g_asc_hud.proof_last_render_object_cache_hit_ratio = 0.0;
   g_asc_hud.proof_last_render_scope = "";
   g_asc_hud.proof_last_render_reason = "";
   g_asc_hud.proof_nav_click_count = 0;
   g_asc_hud.proof_nav_ack_count = 0;
   g_asc_hud.proof_priority_render_count = 0;
   g_asc_hud.proof_priority_service_skip_count = 0;
   g_asc_hud.proof_priority_service_skip_reason = "";
   g_asc_hud.proof_nav_fast_path_count = 0;
   g_asc_hud.proof_nav_slow_path_count = 0;
   g_asc_hud.proof_hud_file_read_count = 0;
   g_asc_hud.proof_current_focus_read_count = 0;
   g_asc_hud.hud_nav_file_reads = 0;
   g_asc_hud.hud_nav_current_focus_reads = 0;
   g_asc_hud.hud_nav_dossier_reads = 0;
   g_asc_hud.hud_nav_market_board_reads = 0;
   g_asc_hud.hud_nav_large_parse_count = 0;
   g_asc_hud.hud_nav_cache_hit_count = 0;
   g_asc_hud.hud_nav_cache_miss_count = 0;
   g_asc_hud.hud_nav_cache_deferred_count = 0;
   g_asc_hud.hud_background_cache_read_count = 0;
   g_asc_hud.hud_manual_cache_read_count = 0;
   g_asc_hud.hud_current_focus_cache_read_count = 0;
   g_asc_hud.hud_current_focus_file_read_count = 0;
   g_asc_hud.hud_deep_parse_attempt_count = 0;
   g_asc_hud.hud_deep_parse_elapsed_last_ms = 0;
   g_asc_hud.hud_deep_parse_elapsed_max_ms = 0;
   g_asc_hud.hud_view_model_hit_count = 0;
   g_asc_hud.hud_view_model_miss_count = 0;
   g_asc_hud.hud_view_model_build_ms = 0;
   g_asc_hud.hud_view_model_dirty_reason = "";
   g_asc_hud.hud_cache_stale_display_count = 0;
   g_asc_hud.hud_cache_placeholder_display_count = 0;
   g_asc_hud.hud_click_file_read_blocked_count = 0;
   g_asc_hud.hud_priority_cache_only_count = 0;
   g_asc_hud.current_focus_refresh_deferred_count = 0;
   g_asc_hud.current_focus_cache_stale_count = 0;
   g_asc_hud.deep_parse_deferred_count = 0;
   g_asc_hud.hud_cache_refresh_pending_count = 0;
   g_asc_hud.hud_priority_render_last_ms = 0;
   g_asc_hud.proof_last_click_to_ack_ms = 0;
   g_asc_hud.proof_last_click_handler_total_ms = 0;
   g_asc_hud.proof_last_deferred_render_wait_ms = 0;
   g_asc_hud.proof_last_deferred_render_ms = 0;
   g_asc_hud.proof_last_artifact_sync_deferred = false;
   g_asc_hud.proof_last_ordinary_navigation_fast_path = false;
   g_asc_hud.proof_last_control_class = "";
   g_asc_hud.proof_last_target_page = "";
   g_asc_hud.proof_last_target_symbol = "";
   g_asc_hud.proof_last_render_build_ms = 0;
   g_asc_hud.proof_last_chart_redraw_ms = 0;
   g_asc_hud.proof_last_transition_total_ms = 0;
   g_asc_hud.proof_last_object_update_ms = 0;
   g_asc_hud.proof_last_render_objects_created = 0;
   g_asc_hud.proof_last_render_objects_updated = 0;
   g_asc_hud.proof_last_render_objects_deleted = 0;
   g_asc_hud.proof_last_render_redraws = 0;
   g_asc_hud.proof_tactical_refresh_count = 0;
   g_asc_hud.proof_tactical_attempt_count = 0;
   g_asc_hud.proof_clock_refresh_count = 0;
   g_asc_hud.proof_clock_update_attempt_count = 0;
   g_asc_hud.proof_clock_label_change_success_count = 0;
   g_asc_hud.proof_clock_redraw_requested_count = 0;
   g_asc_hud.proof_clock_skipped_due_cadence_count = 0;
   g_asc_hud.proof_clock_last_attempt_utc = 0;
   g_asc_hud.proof_clock_last_success_utc = 0;
   g_asc_hud.proof_clock_last_visible_text_token = "";
   g_asc_hud.proof_clock_elapsed_since_last_success_sec = -1;
   g_asc_hud.proof_tactical_stall_beats = 0;
   g_asc_hud.proof_clock_stall_beats = 0;
   g_asc_hud.proof_last_log_utc = 0;
   g_asc_hud.last_tactical_refresh_utc = 0;
   g_asc_hud.proof_last_tactical_heartbeat_counter = 0;
   g_asc_hud.proof_last_logged_full_rebuild_count = 0;
   g_asc_hud.proof_last_logged_symbol_list_rebuild_count = 0;
   g_asc_hud.proof_last_logged_render_pass_count = 0;
   g_asc_hud.proof_last_logged_full_redraw_count = 0;
   g_asc_hud.proof_last_logged_transition_window_active_beats = 0;
   g_asc_hud.proof_last_logged_transition_lock_skip_count = 0;
   g_asc_hud.proof_last_logged_object_create_total = 0;
   g_asc_hud.proof_last_logged_object_delete_total = 0;
   g_asc_hud.proof_last_logged_text_write_total = 0;
   g_asc_hud.proof_last_logged_style_write_total = 0;
   g_asc_hud.proof_last_logged_tactical_refresh_count = 0;
   g_asc_hud.proof_last_logged_tactical_attempt_count = 0;
   g_asc_hud.proof_last_logged_clock_refresh_count = 0;
   g_asc_hud.proof_last_logged_clock_update_attempt_count = 0;
   g_asc_hud.proof_last_logged_clock_label_change_success_count = 0;
   g_asc_hud.proof_last_logged_clock_redraw_requested_count = 0;
   g_asc_hud.proof_last_logged_clock_skipped_due_cadence_count = 0;
   g_asc_hud.proof_last_logged_clock_last_attempt_utc = 0;
   g_asc_hud.proof_last_logged_clock_last_visible_text_token = "";
   g_asc_hud.proof_last_logged_clock_elapsed_since_last_success_sec = -1;
   g_asc_hud.proof_last_logged_redraw_request_count = 0;
   g_asc_hud.proof_last_logged_redraw_flush_count = 0;
   g_asc_hud.proof_last_logged_redraw_suppressed_no_mutation_count = 0;
   g_asc_hud.proof_last_logged_tactical_stall_beats = 0;
   g_asc_hud.proof_last_logged_clock_stall_beats = 0;
   g_asc_hud.proof_last_logged_summary_degraded = false;
   g_asc_hud.proof_last_logged_summary_stale = false;
   g_asc_hud.proof_last_cycle_driver_summary = "";
   g_asc_hud.proof_cached_high_frequency_summary = "";
   g_asc_hud.proof_cached_low_frequency_summary = "";
   g_asc_hud.hud_summary_build_skipped = 0;
   g_asc_hud.hud_summary_lowfreq_only = 0;
   g_asc_hud.proof_string_build_avoided = 0;
   g_asc_hud.proof_emit_gate_blocked = 0;
   g_asc_hud.hud_text_build_skipped = 0;
   g_asc_hud.hud_label_text_reused = 0;
   g_asc_hud.hud_label_set_skipped_text = 0;
   g_asc_hud.hud_row_text_cache_hit = 0;
   g_asc_hud.hud_status_text_cache_hit = 0;
   g_asc_hud.hud_clock_text_unchanged = 0;
   g_asc_hud.hud_render_string_build_avoided = 0;
   ASC_HudResetLeaderTruthAudit(g_asc_hud.leader_truth_audit);
   g_asc_hud.proof_cached_low_frequency_built_utc = 0;
   g_asc_hud.proof_scope_transition_count = 0;
   g_asc_hud.proof_scope_entry_list_count = 0;
   g_asc_hud.proof_scope_entry_symbol_count = 0;
   g_asc_hud.proof_footer_pager_visibility_changes = 0;
   g_asc_hud.proof_quick_actions_visibility_changes = 0;
   g_asc_hud.proof_symbol_lower_visibility_changes = 0;
   g_asc_hud.proof_list_family_visibility_changes = 0;
   g_asc_hud.proof_footer_pager_visible = false;
   g_asc_hud.proof_quick_actions_visible = false;
   g_asc_hud.proof_symbol_lower_visible = false;
   g_asc_hud.proof_list_family_visible = false;
   g_asc_hud.overview_panels_hidden = true;
   g_asc_hud.list_panels_hidden = true;
   g_asc_hud.symbol_overview_panels_hidden = true;
   g_asc_hud.stat_panels_hidden = true;
   g_asc_hud.symbol_shared_hidden = true;
   g_asc_hud.symbols_scope_hidden = true;
   g_asc_hud.list_row_shell_prepared = false;
   g_asc_hud.list_rows_rendered = 0;
   g_asc_hud.list_rows_render_signature = "";
   g_asc_hud.market_watch_live_refresh_signature = "";
   g_asc_hud.market_watch_live_last_log_utc = 0;
   g_asc_hud.market_watch_live_last_quote_utc = 0;
   g_asc_hud.market_watch_live_last_source = "";
   g_asc_hud.proof_selected_symbol_live_refresh_count = 0;
   g_asc_hud.proof_last_selected_symbol_live_refresh_utc = 0;
   g_asc_hud.proof_fast_display_patch_count = 0;
   g_asc_hud.proof_fast_display_guard_reject_count = 0;
   g_asc_hud.parity_diag_structure_mismatch_count = 0;
   g_asc_hud.parity_diag_data_mismatch_count = 0;
   g_asc_hud.parity_diag_tactical_mismatch_count = 0;
   g_asc_hud.parity_diag_last_logged_heartbeat = 0;
   g_asc_hud.fast_display_last_patch_ms = 0;
   g_asc_hud.market_watch_live_last_patch_ms = 0;
   g_asc_hud.market_watch_live_feed_active = false;
   g_asc_hud.market_watch_live_feed_symbol = "";
   g_asc_hud.market_watch_live_feed_started_utc = 0;
   g_asc_hud.chart_change_pending = false;
   g_asc_hud.chart_change_last_render_ms = 0;
   g_asc_hud.resize_pending = false;
   g_asc_hud.resize_burst_active = false;
   g_asc_hud.resize_force_full_rebuild = false;
   g_asc_hud.resize_last_event_ms = 0;
   g_asc_hud.viewport_pending_w = 0;
   g_asc_hud.viewport_pending_h = 0;
   g_asc_hud.resize_last_event_heartbeat = -1;
   ASC_HudInvalidateVisibleSlotMaps();
   ArrayResize(g_asc_hud.sub_bucket_lookup, 0);
   ArrayResize(g_asc_hud.browse_node_lookup, 0);
   ArrayResize(g_asc_hud.scope_ranking_cache, 0);
   ASC_HudClearObjectCache();

   ASC_HudDeleteObjects();
  }

void ASC_HudShutdown()
  {
   if(!g_asc_trader_controls.hud_enabled)
     {
      g_asc_hud.redraw_pending = false;
      ASC_HudInvalidateVisibleSlotMaps();
      ASC_HudDeleteObjects();
      g_asc_hud.initialized = false;
      g_asc_hud.visible = false;
      return;
     }
   ASC_HudFlushParityDiagnostics(g_asc_hud.parity_diag_last_logged_heartbeat, true);
   g_asc_hud.redraw_pending = false;
   ASC_HudInvalidateVisibleSlotMaps();
   ASC_HudDeleteObjects();
   g_asc_hud.initialized = false;
   g_asc_hud.visible = false;
  }

bool ASC_HudIsHighFrequencyProofCadenceDue(const ASC_RuntimeState &runtime)
  {
   int cadence_heartbeat = (g_asc_trader_controls.hud_verbose_proof ? ASC_HUD_PROOF_HF_HEARTBEAT_VERBOSE : ASC_HUD_PROOF_HF_HEARTBEAT_LIGHT);
   if(cadence_heartbeat <= 0)
      cadence_heartbeat = ASC_HUD_PROOF_HF_HEARTBEAT_LIGHT;
   return (runtime.heartbeat_counter > 0 && (runtime.heartbeat_counter % cadence_heartbeat) == 0);
  }

string ASC_HudBoolText(const bool value)
  {
   return (value ? "yes" : "no");
  }

string ASC_HudUintText(const uint value)
  {
   return IntegerToString((long)value);
  }

string ASC_HudBuildCompactTelemetrySummary(const ASC_RuntimeState &runtime,const bool rendered_now,const bool cadence_refresh)
  {
   string summary = "hb=" + IntegerToString(runtime.heartbeat_counter)
                    + " pg=" + ASC_HudPageName(g_asc_hud.page)
                    + " r=" + ASC_HudBoolText(rendered_now)
                    + " c=" + ASC_HudBoolText(cadence_refresh);
   summary += " render[e=" + IntegerToString(g_asc_hud.telemetry_render_enter_count)
              + " f=" + IntegerToString(g_asc_hud.telemetry_render_full_count)
              + " p=" + IntegerToString(g_asc_hud.telemetry_render_partial_count)
              + " s=" + IntegerToString(g_asc_hud.telemetry_render_skip_count)
              + " last_ms=" + ASC_HudUintText(g_asc_hud.telemetry_render_elapsed_last_ms)
              + " max_ms=" + ASC_HudUintText(g_asc_hud.telemetry_render_elapsed_max_ms) + "]";
   summary += " page[req=" + IntegerToString(g_asc_hud.telemetry_page_change_request_count)
              + " commit=" + IntegerToString(g_asc_hud.telemetry_page_change_commit_count)
              + " commit_last_ms=" + ASC_HudUintText(g_asc_hud.telemetry_page_change_commit_elapsed_last_ms)
              + " commit_max_ms=" + ASC_HudUintText(g_asc_hud.telemetry_page_change_commit_elapsed_max_ms)
              + " obj_delta=+" + IntegerToString(g_asc_hud.proof_last_render_objects_created)
              + "/-" + IntegerToString(g_asc_hud.proof_last_render_objects_deleted) + "]";
   summary += " obj_set[attempt=" + IntegerToString(g_asc_hud.telemetry_object_set_attempt_count)
              + " changed=" + IntegerToString(g_asc_hud.telemetry_object_set_changed_count)
              + " noop=" + IntegerToString(g_asc_hud.telemetry_object_set_noop_count)
              + " text_skip=" + IntegerToString(g_asc_hud.hud_label_set_skipped_text) + "]";
   summary += " text_cache[build_skip=" + IntegerToString(g_asc_hud.hud_text_build_skipped)
              + " reused=" + IntegerToString(g_asc_hud.hud_label_text_reused)
              + " row_hit=" + IntegerToString(g_asc_hud.hud_row_text_cache_hit)
              + " status_hit=" + IntegerToString(g_asc_hud.hud_status_text_cache_hit)
              + " clock_same=" + IntegerToString(g_asc_hud.hud_clock_text_unchanged)
              + " avoided=" + IntegerToString(g_asc_hud.hud_render_string_build_avoided) + "]";
   summary += " del[viewport_full=" + IntegerToString(g_asc_hud.telemetry_viewport_full_delete_count) + "]";
   summary += " flush[last_ms=" + ASC_HudUintText(g_asc_hud.telemetry_redraw_flush_elapsed_last_ms)
              + " max_ms=" + ASC_HudUintText(g_asc_hud.telemetry_redraw_flush_elapsed_max_ms) + "]";
   return summary;
  }

string ASC_HudBuildHighFrequencyProofSummary(const ASC_RuntimeState &runtime,const bool rendered_now,const bool cadence_refresh,const int tactical_age_sec,const int heartbeat_gap)
  {
   // SPR-07: high-frequency proof is deliberately compact. Expensive object/cache/viewport inventories
   // remain in the low-frequency/transition/error proof path so normal heartbeats do not pay the full
   // string-construction cost simply to prove a healthy steady state.
   string summary = "heartbeat=" + IntegerToString(runtime.heartbeat_counter)
                    + " page=" + ASC_HudPageName(g_asc_hud.page)
                    + " rendered_now=" + ASC_HudBoolText(rendered_now)
                    + " cadence_refresh=" + ASC_HudBoolText(cadence_refresh);

   summary += " core[hb_gap=" + IntegerToString(heartbeat_gap)
              + " tactical_age_sec=" + IntegerToString(tactical_age_sec)
              + " hb_build_avoided=" + IntegerToString(g_asc_hud.proof_string_build_avoided)
              + " emit_blocked=" + IntegerToString(g_asc_hud.proof_emit_gate_blocked)
              + " summary_skip=" + IntegerToString(g_asc_hud.hud_summary_build_skipped)
              + " lowfreq_only=" + IntegerToString(g_asc_hud.hud_summary_lowfreq_only)
              + " hud_text_build_skipped=" + IntegerToString(g_asc_hud.hud_text_build_skipped)
              + " hud_render_string_build_avoided=" + IntegerToString(g_asc_hud.hud_render_string_build_avoided) + "]";

   summary += " render[pass=" + IntegerToString(g_asc_hud.proof_render_pass_count)
              + " full=" + IntegerToString(g_asc_hud.proof_full_rebuild_count)
              + " list=" + IntegerToString(g_asc_hud.proof_symbol_list_rebuild_count)
              + " last_ms=" + ASC_HudUintText(g_asc_hud.proof_last_render_build_ms)
              + " mutations=" + IntegerToString(g_asc_hud.proof_last_render_mutation_count) + "]";

   summary += " redraw[req=" + IntegerToString(g_asc_hud.proof_redraw_request_count)
              + " flush=" + IntegerToString(g_asc_hud.proof_redraw_flush_count)
              + " avoided=" + IntegerToString(g_asc_hud.hud_redraw_avoided) + "]";

   summary += " nav[click=" + IntegerToString(g_asc_hud.proof_nav_click_count)
              + " ack=" + IntegerToString(g_asc_hud.proof_nav_ack_count)
              + " priority=" + IntegerToString(g_asc_hud.proof_priority_render_count)
              + " cache_only=" + IntegerToString(g_asc_hud.hud_priority_cache_only_count)
              + " blocked_reads=" + IntegerToString(g_asc_hud.hud_click_file_read_blocked_count) + "]";

   summary += " pressure[overdue_tactical=" + IntegerToString(g_asc_hud.proof_tactical_stall_beats)
              + " clock_stall=" + IntegerToString(g_asc_hud.proof_clock_stall_beats)
              + " transition_beats=" + IntegerToString(g_asc_hud.proof_transition_window_active_beats)
              + " skip_reason=" + ASC_TextOrUnavailable(g_asc_hud.proof_priority_service_skip_reason) + "]";
   return summary;
  }

string ASC_HudBuildLowFrequencyProofSummary()
  {
   datetime now_utc = TimeGMT();
   if(StringLen(g_asc_hud.proof_cached_low_frequency_summary) > 0
      && g_asc_hud.proof_cached_low_frequency_built_utc > 0
      && (now_utc - g_asc_hud.proof_cached_low_frequency_built_utc) < 2)
      return g_asc_hud.proof_cached_low_frequency_summary;

   string class_health = g_asc_hud.has_summary ? ASC_Layer1ClassificationHealthCompact(g_asc_hud.latest_summary) : "confirmed=0 needs_review=0 review_routed=0";
   string leader_audit = ASC_HudLeaderTruthAuditCompact();

   string summary = "scope[transitions=" + IntegerToString(g_asc_hud.proof_scope_transition_count)
                    + " list_entries=" + IntegerToString(g_asc_hud.proof_scope_entry_list_count)
                    + " symbol_entries=" + IntegerToString(g_asc_hud.proof_scope_entry_symbol_count)
                    + " footer_pager_toggles=" + IntegerToString(g_asc_hud.proof_footer_pager_visibility_changes)
                    + " quick_action_toggles=" + IntegerToString(g_asc_hud.proof_quick_actions_visibility_changes)
                    + " symbol_lower_toggles=" + IntegerToString(g_asc_hud.proof_symbol_lower_visibility_changes)
                    + " list_family_toggles=" + IntegerToString(g_asc_hud.proof_list_family_visibility_changes) + "]";

   summary += " render[mutations=" + IntegerToString(g_asc_hud.render_mutations)
              + " shortlist_rows=" + IntegerToString(ArraySize(g_asc_hud_shortlist_rows))
              + " dirty=" + ASC_HudBoolText(ASC_HudIsDirty())
              + " selected=" + (StringLen(g_asc_hud.selected_symbol) > 0 ? g_asc_hud.selected_symbol : "none")
              + " scope=" + g_asc_hud.proof_last_render_scope
              + " reason=" + g_asc_hud.proof_last_render_reason
              + " last_mutations=" + IntegerToString(g_asc_hud.proof_last_render_mutation_count)
              + " obj_delta=+" + IntegerToString(g_asc_hud.proof_last_render_objects_created)
              + "/-" + IntegerToString(g_asc_hud.proof_last_render_objects_deleted) + "]";

   summary += " classification[health=" + class_health
              + " groups=" + ASC_HudBucketDistributionCompact()
              + " subgroup_by_market=" + ASC_HudSubGroupDistributionCompact()
              + " guard=" + ASC_HudClassificationGuardLine() + "]";

   summary += " leader_audit={" + leader_audit + "}";

   summary += " object_cache[hit=" + IntegerToString(g_asc_hud.proof_object_cache_hit_count)
              + " miss=" + IntegerToString(g_asc_hud.proof_object_cache_miss_count)
              + " hit_ratio=" + DoubleToString(g_asc_hud.proof_last_render_object_cache_hit_ratio, 2) + "]";

   summary += " object_skip[text=" + IntegerToString(g_asc_hud.proof_object_text_skipped_same_count)
              + " style=" + IntegerToString(g_asc_hud.proof_object_style_skipped_same_count)
              + " visibility=" + IntegerToString(g_asc_hud.proof_object_visibility_skipped_same_count) + "]";

   summary += " readback[find=" + IntegerToString(g_asc_hud.proof_object_find_count)
              + " prop=" + IntegerToString(g_asc_hud.proof_object_property_read_count)
              + " delete_all=" + IntegerToString(g_asc_hud.proof_object_delete_all_count)
              + " delete_single=" + IntegerToString(g_asc_hud.proof_object_delete_single_count)
              + " delete_scoped=" + IntegerToString(g_asc_hud.proof_object_delete_scoped_count) + "]";

   summary += " redraw_batch[request=" + IntegerToString(g_asc_hud.proof_redraw_request_count)
              + " flush=" + IntegerToString(g_asc_hud.proof_redraw_flush_count)
              + " suppressed=" + IntegerToString(g_asc_hud.proof_redraw_suppressed_no_mutation_count) + "]";
   summary += " spr05[hud_obj_set_skipped=" + IntegerToString(g_asc_hud.hud_obj_set_skipped)
              + " hud_obj_set_changed=" + IntegerToString(g_asc_hud.hud_obj_set_changed)
              + " hud_obj_create_reused=" + IntegerToString(g_asc_hud.hud_obj_create_reused)
              + " hud_obj_delete_avoided=" + IntegerToString(g_asc_hud.hud_obj_delete_avoided)
              + " hud_scoped_hide_count=" + IntegerToString(g_asc_hud.hud_scoped_hide_count)
              + " hud_redraw_avoided=" + IntegerToString(g_asc_hud.hud_redraw_avoided)
              + " hud_clock_minimal_update=" + IntegerToString(g_asc_hud.hud_clock_minimal_update)
              + " hud_full_render_avoided=" + IntegerToString(g_asc_hud.hud_full_render_avoided) + "]";

   summary += " spr06[hud_viewport_reset_avoided=" + IntegerToString(g_asc_hud.hud_viewport_reset_avoided)
              + " hud_viewport_jitter_ignored=" + IntegerToString(g_asc_hud.hud_viewport_jitter_ignored)
              + " hud_layout_dirty_skipped=" + IntegerToString(g_asc_hud.hud_layout_dirty_skipped)
              + " hud_transition_rebuild_avoided=" + IntegerToString(g_asc_hud.hud_transition_rebuild_avoided)
              + " hud_full_reset_reason=" + g_asc_hud.hud_full_reset_reason
              + " hud_layout_commit_count=" + IntegerToString(g_asc_hud.hud_layout_commit_count)
              + " hud_transition_commit_count=" + IntegerToString(g_asc_hud.hud_transition_commit_count) + "]";

   summary += " spr07[hud_summary_build_skipped=" + IntegerToString(g_asc_hud.hud_summary_build_skipped)
              + " hud_summary_lowfreq_only=" + IntegerToString(g_asc_hud.hud_summary_lowfreq_only)
              + " proof_string_build_avoided=" + IntegerToString(g_asc_hud.proof_string_build_avoided)
              + " proof_emit_gate_blocked=" + IntegerToString(g_asc_hud.proof_emit_gate_blocked)
              + " proof_tokens_moved_lowfreq=object_cache,readback,nav_cache,classification,leader_audit,spr05,spr06"
              + "]";

   summary += " nav_cache[file_reads=" + IntegerToString(g_asc_hud.hud_nav_file_reads)
              + " cf_reads=" + IntegerToString(g_asc_hud.hud_nav_current_focus_reads)
              + " dossier_reads=" + IntegerToString(g_asc_hud.hud_nav_dossier_reads)
              + " board_reads=" + IntegerToString(g_asc_hud.hud_nav_market_board_reads)
              + " large_parse=" + IntegerToString(g_asc_hud.hud_nav_large_parse_count)
              + " hit=" + IntegerToString(g_asc_hud.hud_nav_cache_hit_count)
              + " miss=" + IntegerToString(g_asc_hud.hud_nav_cache_miss_count)
              + " deferred=" + IntegerToString(g_asc_hud.hud_nav_cache_deferred_count)
              + " bg_reads=" + IntegerToString(g_asc_hud.hud_background_cache_read_count)
              + " manual_reads=" + IntegerToString(g_asc_hud.hud_manual_cache_read_count)
              + " cache_reads=" + IntegerToString(g_asc_hud.hud_current_focus_cache_read_count)
              + " file_read_calls=" + IntegerToString(g_asc_hud.hud_current_focus_file_read_count)
              + " deep_parse_attempts=" + IntegerToString(g_asc_hud.hud_deep_parse_attempt_count)
              + " deep_parse_last_ms=" + ASC_HudUintText(g_asc_hud.hud_deep_parse_elapsed_last_ms)
              + " deep_parse_max_ms=" + ASC_HudUintText(g_asc_hud.hud_deep_parse_elapsed_max_ms)
              + " vm_hit=" + IntegerToString(g_asc_hud.hud_view_model_hit_count)
              + " vm_miss=" + IntegerToString(g_asc_hud.hud_view_model_miss_count)
              + " vm_ms=" + ASC_HudUintText(g_asc_hud.hud_view_model_build_ms)
              + " stale=" + IntegerToString(g_asc_hud.hud_cache_stale_display_count)
              + " placeholder=" + IntegerToString(g_asc_hud.hud_cache_placeholder_display_count)
              + " hud_click_file_read_blocked=" + IntegerToString(g_asc_hud.hud_click_file_read_blocked_count)
              + " hud_priority_cache_only=" + IntegerToString(g_asc_hud.hud_priority_cache_only_count)
              + " current_focus_refresh_deferred=" + IntegerToString(g_asc_hud.current_focus_refresh_deferred_count)
              + " current_focus_cache_stale=" + IntegerToString(g_asc_hud.current_focus_cache_stale_count)
              + " deep_parse_deferred=" + IntegerToString(g_asc_hud.deep_parse_deferred_count)
              + " hud_priority_render_ms=" + ASC_HudUintText(g_asc_hud.hud_priority_render_last_ms)
              + " hud_cache_refresh_pending=" + IntegerToString(g_asc_hud.hud_cache_refresh_pending_count)
              + " state=" + g_asc_hud.current_focus_cache_state + "]";

   g_asc_hud.proof_cached_low_frequency_summary = summary;
   g_asc_hud.proof_cached_low_frequency_built_utc = now_utc;
   return g_asc_hud.proof_cached_low_frequency_summary;
  }


void ASC_HudEmitProofSummary(const ASC_RuntimeState &runtime,const bool rendered_now,const bool cadence_refresh)
  {
   datetime now_utc = TimeGMT();
   bool cadence_due = ASC_HudIsHighFrequencyProofCadenceDue(runtime);
   bool hf_changed_since_log = (g_asc_hud.proof_last_logged_full_rebuild_count != g_asc_hud.proof_full_rebuild_count
                                || g_asc_hud.proof_last_logged_symbol_list_rebuild_count != g_asc_hud.proof_symbol_list_rebuild_count
                                || g_asc_hud.proof_last_logged_render_pass_count != g_asc_hud.proof_render_pass_count
                                || g_asc_hud.proof_last_logged_full_redraw_count != g_asc_hud.proof_full_redraw_count
                                || g_asc_hud.proof_last_logged_transition_window_active_beats != g_asc_hud.proof_transition_window_active_beats
                                || g_asc_hud.proof_last_logged_transition_lock_skip_count != g_asc_hud.proof_transition_lock_skip_count
                                || g_asc_hud.proof_last_logged_object_create_total != g_asc_hud.proof_object_create_total
                                || g_asc_hud.proof_last_logged_object_delete_total != g_asc_hud.proof_object_delete_total
                                || g_asc_hud.proof_last_logged_text_write_total != g_asc_hud.proof_text_write_total
                                || g_asc_hud.proof_last_logged_style_write_total != g_asc_hud.proof_style_write_total
                                || g_asc_hud.proof_last_logged_tactical_refresh_count != g_asc_hud.proof_tactical_refresh_count
                                || g_asc_hud.proof_last_logged_tactical_attempt_count != g_asc_hud.proof_tactical_attempt_count
                                || g_asc_hud.proof_last_logged_clock_refresh_count != g_asc_hud.proof_clock_refresh_count
                                || g_asc_hud.proof_last_logged_clock_update_attempt_count != g_asc_hud.proof_clock_update_attempt_count
                                || g_asc_hud.proof_last_logged_clock_label_change_success_count != g_asc_hud.proof_clock_label_change_success_count
                                || g_asc_hud.proof_last_logged_clock_redraw_requested_count != g_asc_hud.proof_clock_redraw_requested_count
                                || g_asc_hud.proof_last_logged_clock_skipped_due_cadence_count != g_asc_hud.proof_clock_skipped_due_cadence_count
                                || g_asc_hud.proof_last_logged_clock_last_attempt_utc != g_asc_hud.proof_clock_last_attempt_utc
                                || g_asc_hud.proof_last_logged_clock_last_visible_text_token != g_asc_hud.proof_clock_last_visible_text_token
                                || g_asc_hud.proof_last_logged_clock_elapsed_since_last_success_sec != g_asc_hud.proof_clock_elapsed_since_last_success_sec
                                || g_asc_hud.proof_last_logged_redraw_request_count != g_asc_hud.proof_redraw_request_count
                                || g_asc_hud.proof_last_logged_redraw_flush_count != g_asc_hud.proof_redraw_flush_count
                                || g_asc_hud.proof_last_logged_redraw_suppressed_no_mutation_count != g_asc_hud.proof_redraw_suppressed_no_mutation_count
                                || g_asc_hud.proof_last_logged_tactical_stall_beats != g_asc_hud.proof_tactical_stall_beats
                                || g_asc_hud.proof_last_logged_clock_stall_beats != g_asc_hud.proof_clock_stall_beats);
   bool low_frequency_event = (g_asc_hud.proof_scope_transition_count > 0
                               || g_asc_hud.proof_footer_pager_visibility_changes > 0
                               || g_asc_hud.proof_quick_actions_visibility_changes > 0
                               || g_asc_hud.proof_symbol_lower_visibility_changes > 0
                               || g_asc_hud.proof_list_family_visibility_changes > 0);
   bool degradation_transition = (g_asc_hud.has_summary && (g_asc_hud.latest_summary.is_degraded != g_asc_hud.proof_last_logged_summary_degraded
                                                            || g_asc_hud.latest_summary.is_stale != g_asc_hud.proof_last_logged_summary_stale));
   bool critical_transition = ((g_asc_hud.proof_last_logged_full_rebuild_count != g_asc_hud.proof_full_rebuild_count)
                               || g_asc_hud.proof_scope_transition_count > 0
                               || degradation_transition);
   bool should_log_hf = g_asc_trader_controls.hud_verbose_proof || cadence_due || critical_transition;

   if(!hf_changed_since_log && !low_frequency_event && !degradation_transition && !should_log_hf)
     {
      g_asc_hud.proof_emit_gate_blocked++;
      g_asc_hud.hud_summary_build_skipped++;
      g_asc_hud.proof_string_build_avoided += 2;
      return;
     }
   if(!critical_transition && !low_frequency_event && !g_asc_trader_controls.hud_verbose_proof && (now_utc - g_asc_hud.proof_last_log_utc) < 30)
     {
      g_asc_hud.proof_emit_gate_blocked++;
      g_asc_hud.hud_summary_build_skipped++;
      g_asc_hud.proof_string_build_avoided += 2;
      return;
     }
   if(!should_log_hf && !low_frequency_event && !degradation_transition)
     {
      g_asc_hud.proof_emit_gate_blocked++;
      g_asc_hud.hud_summary_build_skipped++;
      g_asc_hud.proof_string_build_avoided += 2;
      return;
     }

   int tactical_age_sec = (g_asc_hud.last_tactical_refresh_utc > 0 ? (int)(now_utc - g_asc_hud.last_tactical_refresh_utc) : -1);
   if(tactical_age_sec < 0)
      tactical_age_sec = -1;
   int heartbeat_gap = -1;
   if(g_asc_hud.proof_last_tactical_heartbeat_counter > 0 && runtime.heartbeat_counter >= g_asc_hud.proof_last_tactical_heartbeat_counter)
      heartbeat_gap = runtime.heartbeat_counter - g_asc_hud.proof_last_tactical_heartbeat_counter;
   if(should_log_hf)
     {
      g_asc_hud.proof_cached_high_frequency_summary = ASC_HudBuildHighFrequencyProofSummary(runtime, rendered_now, cadence_refresh, tactical_age_sec, heartbeat_gap);
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnHeartbeat", "runtime.hf", g_asc_hud.proof_cached_high_frequency_summary);
      bool compact_due = (g_asc_trader_controls.hud_verbose_proof
                          || critical_transition
                          || low_frequency_event
                          || (runtime.heartbeat_counter > 0
                              && (runtime.heartbeat_counter % (ASC_HUD_PROOF_HF_HEARTBEAT_LIGHT * 2)) == 0));
      if(compact_due)
         ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnHeartbeat", "runtime.hud_compact", ASC_HudBuildCompactTelemetrySummary(runtime, rendered_now, cadence_refresh));
     }
   if(low_frequency_event || degradation_transition)
     {
      g_asc_hud.hud_summary_lowfreq_only++;
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnHeartbeat", "runtime.lf", ASC_HudBuildLowFrequencyProofSummary());
     }

   g_asc_hud.proof_last_log_utc = now_utc;
   g_asc_hud.proof_last_logged_full_rebuild_count = g_asc_hud.proof_full_rebuild_count;
   g_asc_hud.proof_last_logged_symbol_list_rebuild_count = g_asc_hud.proof_symbol_list_rebuild_count;
   g_asc_hud.proof_last_logged_render_pass_count = g_asc_hud.proof_render_pass_count;
   g_asc_hud.proof_last_logged_full_redraw_count = g_asc_hud.proof_full_redraw_count;
   g_asc_hud.proof_last_logged_transition_window_active_beats = g_asc_hud.proof_transition_window_active_beats;
   g_asc_hud.proof_last_logged_transition_lock_skip_count = g_asc_hud.proof_transition_lock_skip_count;
   g_asc_hud.proof_last_logged_object_create_total = g_asc_hud.proof_object_create_total;
   g_asc_hud.proof_last_logged_object_delete_total = g_asc_hud.proof_object_delete_total;
   g_asc_hud.proof_last_logged_text_write_total = g_asc_hud.proof_text_write_total;
   g_asc_hud.proof_last_logged_style_write_total = g_asc_hud.proof_style_write_total;
   g_asc_hud.proof_last_logged_tactical_refresh_count = g_asc_hud.proof_tactical_refresh_count;
   g_asc_hud.proof_last_logged_tactical_attempt_count = g_asc_hud.proof_tactical_attempt_count;
   g_asc_hud.proof_last_logged_clock_refresh_count = g_asc_hud.proof_clock_refresh_count;
   g_asc_hud.proof_last_logged_clock_update_attempt_count = g_asc_hud.proof_clock_update_attempt_count;
   g_asc_hud.proof_last_logged_clock_label_change_success_count = g_asc_hud.proof_clock_label_change_success_count;
   g_asc_hud.proof_last_logged_clock_redraw_requested_count = g_asc_hud.proof_clock_redraw_requested_count;
   g_asc_hud.proof_last_logged_clock_skipped_due_cadence_count = g_asc_hud.proof_clock_skipped_due_cadence_count;
   g_asc_hud.proof_last_logged_clock_last_attempt_utc = g_asc_hud.proof_clock_last_attempt_utc;
   g_asc_hud.proof_last_logged_clock_last_visible_text_token = g_asc_hud.proof_clock_last_visible_text_token;
   g_asc_hud.proof_last_logged_clock_elapsed_since_last_success_sec = g_asc_hud.proof_clock_elapsed_since_last_success_sec;
   g_asc_hud.proof_last_logged_redraw_request_count = g_asc_hud.proof_redraw_request_count;
   g_asc_hud.proof_last_logged_redraw_flush_count = g_asc_hud.proof_redraw_flush_count;
   g_asc_hud.proof_last_logged_redraw_suppressed_no_mutation_count = g_asc_hud.proof_redraw_suppressed_no_mutation_count;
   g_asc_hud.proof_last_logged_tactical_stall_beats = g_asc_hud.proof_tactical_stall_beats;
   g_asc_hud.proof_last_logged_clock_stall_beats = g_asc_hud.proof_clock_stall_beats;
   if(g_asc_hud.has_summary)
     {
      g_asc_hud.proof_last_logged_summary_degraded = g_asc_hud.latest_summary.is_degraded;
      g_asc_hud.proof_last_logged_summary_stale = g_asc_hud.latest_summary.is_stale;
     }
   g_asc_hud.proof_scope_transition_count = 0;
   g_asc_hud.proof_scope_entry_list_count = 0;
   g_asc_hud.proof_scope_entry_symbol_count = 0;
   g_asc_hud.proof_footer_pager_visibility_changes = 0;
   g_asc_hud.proof_quick_actions_visibility_changes = 0;
   g_asc_hud.proof_symbol_lower_visibility_changes = 0;
   g_asc_hud.proof_list_family_visibility_changes = 0;
  }

void ASC_HudOnHeartbeat(const ASC_RuntimeState &runtime)
  {
   if(!g_asc_trader_controls.hud_enabled)
      return;
   if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return;

   g_asc_hud.proof_cycle_object_creates = 0;
   g_asc_hud.proof_cycle_object_deletes = 0;
   g_asc_hud.proof_cycle_text_writes = 0;
   g_asc_hud.proof_cycle_style_writes = 0;
   g_asc_hud.proof_cycle_redraws = 0;
   g_asc_hud.proof_last_cycle_driver_summary = "none";
   if(g_asc_hud.transition_until > 0 && TimeGMT() <= g_asc_hud.transition_until)
      g_asc_hud.proof_transition_window_active_beats++;

   g_asc_hud.deep_trigger_pending = runtime.deep_focus_trigger_pending;
   g_asc_hud.deep_trigger_symbol = runtime.deep_focus_trigger_symbol;
   g_asc_hud.deep_trigger_requested_utc = runtime.deep_focus_trigger_requested_utc;
   g_asc_hud.deep_trigger_last_status = runtime.deep_focus_trigger_last_status;
   g_asc_hud.deep_trigger_last_served_utc = runtime.deep_focus_trigger_last_served_utc;
   g_asc_hud.deep_trigger_runtime_reason = runtime.deep_focus_last_reason;
   g_asc_hud.current_focus_runtime_status = runtime.current_focus_last_status;
   g_asc_hud.current_focus_runtime_reason = runtime.current_focus_last_reason;
   g_asc_hud.current_focus_runtime_live_symbol = runtime.current_focus_live_symbol;
   g_asc_hud.current_focus_runtime_last_served_utc = runtime.current_focus_last_served_utc;
   g_asc_hud.bootstrap_active = runtime.l1_bootstrap_active;
   g_asc_hud.live_entitled_count = runtime.l1_l2_live_entitled_count;
   g_asc_hud.retention_only_count = runtime.l1_retention_only_count;
   g_asc_hud.dossier_shell_presence_count = runtime.dossier_shell_present_count;
   g_asc_hud.dossier_rich_presence_count = runtime.dossier_rich_present_count;
   ASC_HudAdoptRuntimeShortlistCache(runtime);
   ASC_HudUpdateMarketWatchLiveFeedLifecycle();
   if(g_asc_hud.queued_heavy_refresh)
     {
      bool consume_queued_heavy_refresh = ASC_HudPageNeedsHeavyDataset(g_asc_hud.page) || g_asc_hud.dirty_data_heavy;
      if(consume_queued_heavy_refresh)
        {
         ASC_LogInfo("ASC_HUD_Manager",
                     "ASC_HudOnHeartbeat",
                     "queued_heavy_refresh.consume",
                     StringFormat("consumed=true reason=%s", g_asc_hud.queued_heavy_refresh_reason));
         ASC_HudMarkDirtyDataHeavy();
         g_asc_hud.queued_heavy_refresh = false;
         g_asc_hud.queued_heavy_refresh_reason = "";
        }
     }

   bool clock_refresh = ASC_HudRefreshClockCadence(runtime.heartbeat_counter);
   if(ASC_HudNeedsTacticalCadence() && !clock_refresh)
      g_asc_hud.proof_clock_stall_beats++;
   else
      g_asc_hud.proof_clock_stall_beats = 0;
   datetime clock_now_utc = TimeGMT();
   if(g_asc_hud.proof_clock_last_success_utc > 0 && clock_now_utc >= g_asc_hud.proof_clock_last_success_utc)
      g_asc_hud.proof_clock_elapsed_since_last_success_sec = (int)(clock_now_utc - g_asc_hud.proof_clock_last_success_utc);
   else if(g_asc_hud.proof_clock_last_success_utc <= 0)
      g_asc_hud.proof_clock_elapsed_since_last_success_sec = -1;

   bool force_full_fingerprint_pass = (ASC_HudIsDirty()
                                       || g_asc_hud.pending_navigation_transition
                                       || g_asc_hud.queued_heavy_refresh
                                       || g_asc_hud.resize_pending
                                       || g_asc_hud.chart_change_pending);
   bool structure_due = (force_full_fingerprint_pass
                         || ASC_HudPageNeedsHeavyDataset(g_asc_hud.page)
                         || ASC_HudHeartbeatCadenceDue(runtime.heartbeat_counter, ASC_HUD_STRUCTURE_RECHECK_LIGHT_HEARTBEATS));
   bool data_due = (force_full_fingerprint_pass
                    || ASC_HudPageNeedsPerBeatDataCheck(g_asc_hud.page)
                    || ASC_HudHeartbeatCadenceDue(runtime.heartbeat_counter, ASC_HUD_DATA_RECHECK_LIGHT_HEARTBEATS));
   bool tactical_due = (force_full_fingerprint_pass
                        || ASC_HudNeedsTacticalCadence()
                        || ASC_HudHeartbeatCadenceDue(runtime.heartbeat_counter, ASC_HUD_TACTICAL_RECHECK_LIGHT_HEARTBEATS));

   bool structure_changed = false;
   if(structure_due)
     {
      uint structure_fingerprint = ASC_HudStructuralFingerprint();
      structure_changed = (structure_fingerprint != g_asc_hud.last_structure_fingerprint);
      if(structure_changed)
        {
         g_asc_hud.last_structure_fingerprint = structure_fingerprint;
         g_asc_hud.last_data_fingerprint = 0;
         g_asc_hud.last_tactical_fingerprint = 0;
         ASC_HudInvalidateSelectedSymbolCache();
         ASC_HudMarkDirtyDataHeavy();
        }
     }

   bool data_changed = false;
   if(data_due)
     {
      uint data_fingerprint = ASC_HudDataFingerprint();
      data_changed = (data_fingerprint != g_asc_hud.last_data_fingerprint);
      if(data_changed)
        {
         g_asc_hud.last_data_fingerprint = data_fingerprint;
         if(ASC_HudPageNeedsHeavyDataset(g_asc_hud.page))
            ASC_HudMarkDirtyDataHeavy();
         else
           {
            ASC_HudMarkDirtyDataLight();
            ASC_HudQueueHeavyRefresh("deferred_heavy_refresh_non_list_page");
           }
        }
     }

   bool tactical_changed = false;
   if(tactical_due)
     {
      uint tactical_fingerprint = ASC_HudTacticalFingerprint();
      tactical_changed = (tactical_fingerprint != g_asc_hud.last_tactical_fingerprint);
      if(tactical_changed)
         g_asc_hud.last_tactical_fingerprint = tactical_fingerprint;
     }

   if(ASC_HudParityDiagnosticsEnabled())
     {
      int parity_recheck_heartbeat = MathMax(1, ASC_HUD_PARITY_DIAG_RECHECK_HEARTBEATS);
      bool parity_check_due = structure_changed
                              || data_changed
                              || tactical_changed
                              || (runtime.heartbeat_counter > 0 && (runtime.heartbeat_counter % parity_recheck_heartbeat) == 0);
      if(parity_check_due)
        {
         string structure_signature = ASC_HudStructuralSignature();
         bool legacy_structure_changed = (structure_signature != g_asc_hud.last_structure_signature);
         if(legacy_structure_changed != structure_changed)
            g_asc_hud.parity_diag_structure_mismatch_count++;
         if(structure_changed)
           {
            g_asc_hud.last_structure_signature = structure_signature;
            g_asc_hud.last_data_signature = "";
            g_asc_hud.last_tactical_signature = "";
           }

         string signature = ASC_HudDataSignature();
         bool legacy_data_changed = (signature != g_asc_hud.last_data_signature);
         if(legacy_data_changed != data_changed)
            g_asc_hud.parity_diag_data_mismatch_count++;
         if(data_changed)
            g_asc_hud.last_data_signature = signature;

         string tactical_signature = ASC_HudTacticalSignature();
         bool legacy_tactical_changed = (tactical_signature != g_asc_hud.last_tactical_signature);
         if(legacy_tactical_changed != tactical_changed)
            g_asc_hud.parity_diag_tactical_mismatch_count++;
         if(tactical_changed)
            g_asc_hud.last_tactical_signature = tactical_signature;
        }

      ASC_HudFlushParityDiagnostics(runtime.heartbeat_counter);
     }

   bool shortlist_sensitive_page = (g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS
                                    || g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS
                                    || g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS
                                    || g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS
                                    || g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10);
   bool shortlist_identity_changed = (g_asc_hud.last_shortlist_signature_source != g_asc_hud.last_shortlist_source
                                      || g_asc_hud.last_shortlist_signature_revision != g_asc_hud.last_shortlist_revision
                                      || g_asc_hud.last_shortlist_signature_pass_utc != g_asc_hud.last_shortlist_pass_utc
                                      || g_asc_hud.last_shortlist_signature_count != g_asc_hud.last_shortlist_count);
   int shortlist_recheck_heartbeat = MathMax(1, ASC_HUD_SHORTLIST_SIGNATURE_RECHECK_HEARTBEATS);
   bool shortlist_recheck_due = (ASC_HudIsDirty()
                                 || shortlist_identity_changed
                                 || (runtime.heartbeat_counter % shortlist_recheck_heartbeat) == 0);
   if(shortlist_sensitive_page && shortlist_recheck_due)
     {
      string shortlist_signature = ASC_HudShortlistOrderingSignature();
      g_asc_hud.last_shortlist_signature_source = g_asc_hud.last_shortlist_source;
      g_asc_hud.last_shortlist_signature_revision = g_asc_hud.last_shortlist_revision;
      g_asc_hud.last_shortlist_signature_pass_utc = g_asc_hud.last_shortlist_pass_utc;
      g_asc_hud.last_shortlist_signature_count = g_asc_hud.last_shortlist_count;
      if(shortlist_signature != g_asc_hud.last_shortlist_signature)
        {
         g_asc_hud.last_shortlist_signature = shortlist_signature;
         ASC_HudMarkDirtyDataHeavy();
        }
     }

   bool chart_change_consumed = ASC_HudConsumeChartChangePending(runtime.heartbeat_counter);
   if(chart_change_consumed)
     {
      ASC_HudMarkDirtyLayout();
      ASC_HudShowDeferredTransition("Layout update applied");
     }

   if(ASC_HudReplayQueuedGuardedNavClick())
      ASC_HudMarkDirtyNavigation(ASC_HudNavigationFlagsForPage(g_asc_hud.page));

   if(g_asc_hud.pending_navigation_transition)
      ASC_HudMarkDirtyNavigation(ASC_HudNavigationFlagsForPage(g_asc_hud.page));

   bool rendered_now = false;
   bool cadence_refresh = clock_refresh;
   if(ASC_HudCanSkipRenderForUnchangedSnapshot())
     {
      g_asc_hud.proof_snapshot_skip_count++;
      g_asc_hud.telemetry_render_skip_count++;
      ASC_HudClearDirtyFlags();
     }
   else if(ASC_HudIsDirty())
     {
      ASC_HudRender(runtime);
      rendered_now = true;
      g_asc_hud.proof_tactical_stall_beats = 0;
      if(g_asc_hud.pending_navigation_transition)
        {
         g_asc_hud.pending_navigation_transition = false;
         g_asc_hud.pending_navigation_label = "";
         g_asc_hud.pending_navigation_requested_utc = 0;
        }
     }
   else
     {
      int refresh_before = g_asc_hud.proof_tactical_refresh_count;
      if(ASC_HudIsLiveMarketWatchContext())
         ASC_HudRefreshMarketWatchLiveCadence();
      else if(tactical_changed)
         ASC_HudRefreshTacticalCadence();
      cadence_refresh = cadence_refresh || (g_asc_hud.proof_tactical_refresh_count > refresh_before);
      if(ASC_HudNeedsTacticalCadence() && !cadence_refresh)
         g_asc_hud.proof_tactical_stall_beats++;
      else
         g_asc_hud.proof_tactical_stall_beats = 0;
     }

   string driver_summary = "dirty=" + ASC_HudBoolText(ASC_HudIsDirty());
   driver_summary += " structure=" + ASC_HudBoolText(structure_changed) + "(" + (structure_due ? "due" : "skip") + ")";
   driver_summary += " data=" + ASC_HudBoolText(data_changed) + "(" + (data_due ? "due" : "skip") + ")";
   driver_summary += " tactical=" + ASC_HudBoolText(tactical_changed) + "(" + (tactical_due ? "due" : "skip") + ")";
   driver_summary += " shortlist_recheck=" + ASC_HudBoolText(shortlist_recheck_due);
   driver_summary += " chart_change=" + ASC_HudBoolText(chart_change_consumed);
   driver_summary += " rendered=" + ASC_HudBoolText(rendered_now);
   driver_summary += " cadence=" + ASC_HudBoolText(cadence_refresh);
   driver_summary += " clock=" + ASC_HudBoolText(clock_refresh);
   driver_summary += " resize_pending=" + ASC_HudBoolText(g_asc_hud.resize_pending);
   g_asc_hud.proof_last_cycle_driver_summary = driver_summary;

   ASC_HudEmitProofSummary(runtime, rendered_now, cadence_refresh);
   ASC_HudFlushPendingRedraw();
  }

bool ASC_HudRequestForcedDownstreamRefresh(ASC_RuntimeState &runtime,
                                           string &status_reason,
                                           const string scope,
                                           const string symbol = "",
                                           const string request_reason = "operator-forced downstream refresh queued from HUD")
  {
   datetime now_utc = TimeGMT();
   string effective_scope = (StringLen(scope) > 0 ? scope : "unspecified");
   bool same_request = (runtime.forced_downstream_refresh_pending
                        && runtime.forced_downstream_refresh_scope == effective_scope
                        && runtime.forced_downstream_refresh_symbol == symbol);
   runtime.forced_downstream_refresh_request_seq++;
   runtime.forced_downstream_refresh_pending = true;
   runtime.forced_downstream_refresh_requested_utc = now_utc;
   runtime.last_chart_event_utc = now_utc;
   runtime.ui_priority_until_utc = ASC_MaxDatetime(runtime.ui_priority_until_utc,
                                                   now_utc + (ASC_HEARTBEAT_SECONDS * 4));
   runtime.forced_downstream_refresh_scope = effective_scope;
   runtime.forced_downstream_refresh_symbol = symbol;
   runtime.forced_downstream_refresh_last_status = "queued";
   runtime.forced_downstream_refresh_last_reason = request_reason;
   status_reason = same_request ? "refreshed_existing" : "queued";
   return true;
  }

bool ASC_HudRequestManualMarketBoardRefresh(ASC_RuntimeState &runtime,
                                         string &status_reason,
                                         const string trigger = "manual_hud_refresh_shortlist",
                                         const string request_reason = "manual board refresh queued from HUD Refresh Shortlist control")
  {
   datetime now_utc = TimeGMT();
   bool run_full_refresh_trigger = (trigger == "manual_hud_run_full_selected_symbol"
                                    || trigger == "manual_hud_run_full_top10");
   if(runtime.board_manual_refresh_pending || runtime.board_manual_refresh_inflight)
     {
      status_reason = "already_pending";
      if(run_full_refresh_trigger)
        {
         runtime.board_manual_refresh_trigger = trigger;
         runtime.board_manual_refresh_requested_utc = now_utc;
         runtime.board_manual_refresh_last_status = "queued";
         runtime.board_manual_refresh_last_reason = "manual board refresh coalesced onto explicit HUD Run Full family";
         runtime.publication_bundle.board_refresh_trigger = trigger;
         runtime.publication_bundle.board_refresh_requested_utc = now_utc;
        }
      else
        {
         runtime.board_manual_refresh_last_status = "duplicate";
         runtime.board_manual_refresh_last_reason = "manual board refresh request was ignored because another request is pending/inflight";
        }
      runtime.publication_bundle.board_lifecycle_state = "manual_refresh_requested";
      runtime.publication_bundle.board_publish_result = "pending";
      runtime.publication_bundle.board_publish_skip_reason = "none";
      if(runtime.publication_bundle.board_refresh_requested_utc <= 0)
         runtime.publication_bundle.board_refresh_requested_utc = now_utc;
      return false;
     }

   runtime.board_manual_refresh_request_seq++;
   runtime.board_manual_refresh_pending = true;
   runtime.board_manual_refresh_requested_utc = now_utc;
   runtime.last_chart_event_utc = now_utc;
   runtime.ui_priority_until_utc = ASC_MaxDatetime(runtime.ui_priority_until_utc,
                                                   now_utc + (ASC_HEARTBEAT_SECONDS * 4));
   runtime.board_manual_refresh_trigger = trigger;
   runtime.board_manual_refresh_last_status = "queued";
   runtime.board_manual_refresh_last_reason = request_reason;
   runtime.publication_bundle.board_lifecycle_state = "manual_refresh_requested";
   runtime.publication_bundle.board_refresh_trigger = runtime.board_manual_refresh_trigger;
   runtime.publication_bundle.board_refresh_requested_utc = now_utc;
   runtime.publication_bundle.board_publish_result = "pending";
   runtime.publication_bundle.board_publish_skip_reason = "none";
   status_reason = "queued";
   return true;
  }

void ASC_HudOnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam,ASC_RuntimeState &runtime)
  {
   if(!g_asc_trader_controls.hud_enabled)
      return;
   uint event_started_ms = GetTickCount();
   string hud_service_state = "ignored";
  if(!g_asc_hud.initialized || !g_asc_hud.visible)
      return;

   ASC_HudPage previous_page = g_asc_hud.page;
   string previous_symbol = g_asc_hud.selected_symbol;

   if(id == CHARTEVENT_CHART_CHANGE)
     {
      uint now_ms = GetTickCount();
      bool resize_already_pending = g_asc_hud.resize_pending;
      int chart_w = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0);
      int chart_h = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0);
      bool jitter_only = false;
      bool material_change = ASC_HudViewportMaterialChange(g_asc_hud.viewport_w, g_asc_hud.viewport_h, chart_w, chart_h, jitter_only);
      if(!material_change)
        {
         if(jitter_only)
            g_asc_hud.hud_viewport_jitter_ignored++;
         else
            g_asc_hud.hud_viewport_reset_avoided++;
         g_asc_hud.hud_full_reset_reason = jitter_only ? "event_viewport_jitter_ignored" : "event_viewport_unchanged";
         return;
        }

      g_asc_hud.viewport_pending_w = chart_w;
      g_asc_hud.viewport_pending_h = chart_h;
      g_asc_hud.chart_change_pending = true;
      g_asc_hud.resize_pending = true;
      g_asc_hud.resize_burst_active = true;
      g_asc_hud.resize_last_event_ms = now_ms;
      g_asc_hud.resize_last_event_heartbeat = runtime.heartbeat_counter;
      g_asc_hud.hud_full_reset_reason = "event_material_viewport_change";
      if(resize_already_pending)
         ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_NAV_MS, false);
      else
         ASC_HudArmTransitionGuard(ASC_HUD_TRANSITION_GUARD_STRICT_MS, true);
      ASC_HudShowDeferredTransition("Resizing chart...");
      return;
     }

   if(!g_asc_hud.resize_pending
      && !g_asc_hud.resize_burst_active
      && !ASC_HudTransitionGuardActive()
      && g_asc_hud.queued_nav_click_pending)
      ASC_HudReplayQueuedGuardedNavClick();

   if(id == CHARTEVENT_OBJECT_CLICK
      && StringFind(sparam, ASC_HUD_PREFIX) == 0
      && ASC_HudTransitionGuardActive())
     {
      bool strict_blocked = (g_asc_hud.transition_guard_strict && ASC_HudIsStrictTransitionGuardedControl(sparam));
      bool safe_nav_blocked = ASC_HudIsTransitionGuardedControl(sparam);
      if(strict_blocked || safe_nav_blocked)
        {
         g_asc_hud.proof_transition_lock_skip_count++;
         if(safe_nav_blocked)
            ASC_HudQueueGuardedNavReplay(sparam);
         hud_service_state = "blocked_transition_guard";
         ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", (StringLen(g_asc_hud.selected_symbol) > 0 ? g_asc_hud.selected_symbol : "none"),
                     "hud_service=" + hud_service_state
                     + " event_ms=" + ASC_HudUintText((uint)(GetTickCount() - event_started_ms))
                     + " control=" + sparam
                     + " page=" + ASC_HudPageName(g_asc_hud.page));
         return;
        }
     }

   if(id != CHARTEVENT_OBJECT_CLICK)
     {
      bool fast_path_applied = ASC_HudRefreshDisplayOnlyFastPath(runtime.heartbeat_counter, true);
      hud_service_state = fast_path_applied ? "served_fast" : "no_click_fast_path";
      ASC_HudFlushPendingRedraw();
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", (StringLen(g_asc_hud.selected_symbol) > 0 ? g_asc_hud.selected_symbol : "none"),
                     "hud_service=" + hud_service_state
                     + " event_ms=" + ASC_HudUintText((uint)(GetTickCount() - event_started_ms))
                     + " control=" + sparam
                     + " page=" + ASC_HudPageName(g_asc_hud.page));
      return;
     }

   if(StringFind(sparam, ASC_HUD_PREFIX) != 0)
      return;

   g_asc_hud.proof_nav_click_count++;

   string click_symbol = (StringLen(g_asc_hud.selected_symbol) > 0 ? g_asc_hud.selected_symbol : "none");
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
               StringFormat("click received control=%s page=%s section=%s",
                            sparam,
                            ASC_HudPageName(g_asc_hud.page),
                            ASC_HudSymbolSectionName(g_asc_hud.selected_symbol_section)));

   if(sparam == ASC_HUD_PREFIX + "btn_back"
      || sparam == ASC_HUD_PREFIX + "btn_forward"
      || sparam == ASC_HUD_PREFIX + "btn_home")
      ASC_HudTrackPageChangeRequest(g_asc_hud.page);

   bool suppress_view_sync = false;

   if(sparam == ASC_HUD_PREFIX + "btn_back")
     {
      if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS && ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
        {
         string current_parent = ASC_HudActiveStockBrowseParentKey();
         string root_parent = "B|" + g_asc_hud.selected_bucket_id;
         g_asc_hud.selected_browse_parent_key = current_parent;
         if(StringLen(current_parent) > 0 && current_parent != root_parent)
           {
            string up_parent = ASC_HudBrowseParentKey(current_parent);
            g_asc_hud.selected_browse_parent_key = (StringLen(up_parent) > 0 ? up_parent : root_parent);
            g_asc_hud.list_offset = 0;
            ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_LIST | ASC_HUD_NAV_DIRTY_PAGE);
           }
         else
            ASC_HudGoBack();
        }
      else
         ASC_HudGoBack();
     }
   else if(sparam == ASC_HUD_PREFIX + "btn_forward")
      ASC_HudGoForward();
   else if(sparam == ASC_HUD_PREFIX + "btn_home") ASC_HudGoHome();
   else if(sparam == ASC_HUD_PREFIX + "btn_buckets") ASC_HudOpenPage(ASC_HUD_PAGE_MAIN_BUCKETS);
   else if(sparam == ASC_HUD_PREFIX + "btn_sub_groups")
     {
      if(StringLen(g_asc_hud.selected_bucket_id) > 0 && ASC_HudBucketAllowedByControls(g_asc_hud.selected_bucket_id))
        {
         if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
           {
            string root_parent = "B|" + g_asc_hud.selected_bucket_id;
            if(StringLen(g_asc_hud.selected_browse_parent_key) <= 0
               || !ASC_HudBrowseNodeValidForCurrentStockState(g_asc_hud.selected_browse_parent_key, g_asc_hud.selected_bucket_id)
               || !ASC_HudBrowseNodeHasAncestor(g_asc_hud.selected_browse_parent_key, root_parent))
               g_asc_hud.selected_browse_parent_key = root_parent;
           }
         ASC_HudOpenPage(ASC_HUD_PAGE_SUB_GROUPS);
        }
      else
         ASC_HudSetNotice("Select a valid main bucket first.");
     }
   else if(sparam == ASC_HUD_PREFIX + "btn_leaders")
     {
      if(StringLen(g_asc_hud.selected_bucket_id) > 0 && ASC_HudBucketAllowedByControls(g_asc_hud.selected_bucket_id))
         ASC_HudOpenPage(ASC_HUD_PAGE_BUCKET_LEADERS);
      else
         ASC_HudSetNotice("Select a valid main bucket first.");
     }
   else if(sparam == ASC_HUD_PREFIX + "btn_symbols")
     {
      if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id)
         && StringLen(g_asc_hud.selected_sub_bucket_key) <= 0
         && StringLen(g_asc_hud.selected_browse_node_key) > 0
         && !ASC_HudBrowseNodeHasChildren(g_asc_hud.selected_browse_node_key))
         g_asc_hud.selected_sub_bucket_key = g_asc_hud.selected_browse_node_key;

      if(StringLen(g_asc_hud.selected_sub_bucket_key) > 0)
         ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOLS);
      else
         ASC_HudSetNotice("Select a sub-group first.");
     }
   else if(sparam == ASC_HUD_PREFIX + "btn_top10")
      ASC_HudOpenPage(ASC_HUD_PAGE_GLOBAL_TOP10);
    else if(sparam == ASC_HUD_PREFIX + "btn_symbol")
      {
       if(StringLen(g_asc_hud.selected_symbol) > 0)
         {
          g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
          g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
          ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOL_OVERVIEW);
         }
       else
          ASC_HudSetNotice("Select a symbol first.");
      }
    else if(sparam == ASC_HUD_PREFIX + "btn_details")
      {
       if(StringLen(g_asc_hud.selected_symbol) > 0)
          ASC_HudOpenPage(ASC_HUD_PAGE_ASPECT_DETAIL);
       else
          ASC_HudSetNotice("Select a symbol first.");
      }
   else if(sparam == ASC_HUD_PREFIX + "btn_sync")
     {
      g_asc_hud.proof_refresh_request_seq++;
      g_asc_hud.proof_shortlist_refresh_count++;
      g_asc_hud.last_leaders_bucket_id = "";
      g_asc_hud.last_leaders_shortlist_signature = "";
      g_asc_hud.last_shortlist_signature = "";
      g_asc_hud.last_shortlist_signature_source = "";
      g_asc_hud.last_shortlist_signature_revision = 0;
      g_asc_hud.last_shortlist_signature_pass_utc = 0;
      g_asc_hud.last_shortlist_signature_count = 0;
      ASC_HudGlobalTop10CacheInvalidate();
      ASC_HudAdoptRuntimeShortlistCache(runtime);
      if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
         ASC_HudRebuildBucketLeadersList();
      if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
         ASC_HudReorderSelectedSymbolsByShortlistRank();
      ASC_HudMarkDirtyDataLight();
      string board_refresh_status = "";
      string downstream_status = "not_requested";
      bool symbol_scope_refresh = (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
      bool board_refresh_queued = false;
      if(symbol_scope_refresh && StringLen(g_asc_hud.selected_symbol) > 0)
        {
         ASC_HudRequestForcedDownstreamRefresh(runtime,
                                               downstream_status,
                                               "selected_symbol_family",
                                               g_asc_hud.selected_symbol,
                                               "forced Layer 3-6 refresh queued from explicit HUD selected-symbol Refresh action");
         ASC_HudQueueViewedCurrentFocusSync(runtime, false);
         board_refresh_queued = ASC_HudRequestManualMarketBoardRefresh(runtime,
                                                                       board_refresh_status,
                                                                       "manual_hud_refresh_selected_symbol",
                                                                       "manual board refresh queued from explicit HUD selected-symbol Refresh action");
         ASC_HudSetNotice(StringFormat("Selected-symbol refresh queued on current lawful Layer 0-2 substrate. Downstream refresh=%s; Market Board=%s.",
                                       downstream_status,
                                       board_refresh_status));
        }
      else
        {
         board_refresh_queued = ASC_HudRequestManualMarketBoardRefresh(runtime, board_refresh_status, "manual_hud_refresh_shortlist", "manual board refresh queued from HUD Refresh Shortlist control");
         if(board_refresh_queued)
            ASC_HudSetNotice("Shortlist + Market Board refresh requested.");
         else
            ASC_HudSetNotice("Shortlist refreshed locally; Market Board refresh is already pending.");
        }
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudRefreshAction", click_symbol,
                  StringFormat("action=shortlist_refresh req_seq=%d board_refresh=%s board_status=%s downstream=%s board_req_seq=%d bucket=%s sub=%s symbol=%s",
                               g_asc_hud.proof_refresh_request_seq,
                               board_refresh_queued ? "queued" : "duplicate",
                               board_refresh_status,
                               downstream_status,
                               runtime.board_manual_refresh_request_seq,
                               g_asc_hud.selected_bucket_id,
                               g_asc_hud.selected_sub_bucket_key,
                               g_asc_hud.selected_symbol));
     }
   else if(sparam == ASC_HUD_PREFIX + "act_page_refresh")
     {
      string notice_text = "";
      string log_action = "";
      string board_status = "not_needed";
      ASC_HudRefreshHigherPageScope(runtime, notice_text, log_action, board_status, click_symbol);
      ASC_HudSetNotice(notice_text);
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudRefreshAction", click_symbol, log_action);
     }
   else if(sparam == ASC_HUD_PREFIX + "act_top10_run_full")
     {
      if(g_asc_hud.page != ASC_HUD_PAGE_GLOBAL_TOP10)
         ASC_HudSetNotice("Run Full Top 10 is available only on the Global Top 10 page.");
      else if(runtime.top10_run_full_batch_pending
              || runtime.top10_run_full_cursor < runtime.top10_run_full_total
              || StringLen(runtime.top10_run_full_inflight_symbol) > 0)
        {
         ASC_HudSetNotice("Run Full Top 10 batch is already active. Duplicate request ignored and active batch state preserved.");
         ASC_LogInfo("ASC_HUD_Manager", "ASC_HudRefreshAction", click_symbol,
                     StringFormat("action=top10_run_full_duplicate_ignored page=%s active_status=%s cursor=%d/%d inflight=%s reason=%s",
                                  ASC_HudPageName(g_asc_hud.page),
                                  runtime.top10_run_full_batch_status,
                                  runtime.top10_run_full_cursor,
                                  runtime.top10_run_full_total,
                                  (StringLen(runtime.top10_run_full_inflight_symbol) > 0 ? runtime.top10_run_full_inflight_symbol : "none"),
                                  runtime.top10_run_full_batch_reason));
        }
      else
        {
         datetime top10_request_utc = TimeGMT();
         string top10_cadence_reason = "";
         bool top10_cadence_due = ASC_Top10RunFullCadenceDue(runtime, top10_request_utc, top10_cadence_reason);
         runtime.last_chart_event_utc = top10_request_utc;
         runtime.ui_priority_until_utc = ASC_MaxDatetime(runtime.ui_priority_until_utc,
                                                         top10_request_utc + (ASC_HEARTBEAT_SECONDS * 4));
         if(!top10_cadence_due)
           {
            runtime.top10_run_full_batch_status = "manual_cadence_hold";
            runtime.top10_run_full_batch_reason = top10_cadence_reason;
            ASC_HudSetNotice("Global Top 10 is not due yet. Current live family remains the last confirmed complete Top 10; no hidden recompute was launched. " + top10_cadence_reason);
            ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                        "global top10 manual run-full held by cadence | admitted=no | reason=" + top10_cadence_reason + " | live_family_preserved=yes");
           }
         else
           {
            runtime.top10_run_full_batch_pending = true;
            runtime.top10_run_full_batch_requested_utc = top10_request_utc;
            runtime.top10_run_full_batch_status = "queued";
            runtime.top10_run_full_batch_reason = "queued from HUD Global Top 10 Run Full action after lawful cadence due check | " + top10_cadence_reason;
            runtime.top10_run_full_total = 0;
            runtime.top10_run_full_cursor = 0;
            ArrayResize(runtime.top10_run_full_symbols, 0);
            string top10_downstream_status = "not_requested";
            ASC_HudRequestForcedDownstreamRefresh(runtime,
                                                  top10_downstream_status,
                                                  "global_top10_family",
                                                  "",
                                                  "forced Layer 3-6 refresh queued from explicit HUD Run Full Top 10 action after lawful cadence due check");
            string top10_board_status = "not_requested";
            ASC_HudRequestManualMarketBoardRefresh(runtime,
                                                   top10_board_status,
                                                   "manual_hud_run_full_top10",
                                                   "manual board refresh queued from explicit HUD Run Full Top 10 action after lawful cadence due check");
            string top10_notice = "Run Full Top 10 queued on lawful 10-minute cadence. Runtime will stage a new family while current Top 10 remains live.";
            top10_notice += " Downstream refresh foundation=" + top10_downstream_status + ".";
            if(top10_board_status == "queued")
               top10_notice += " Market Board baseline refresh was queued for this batch family.";
            else if(top10_board_status == "already_pending")
               top10_notice += " Market Board baseline refresh was already pending for this batch family.";
            ASC_HudSetNotice(top10_notice);
            ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                        StringFormat("global top10 run-full batch request queued after cadence due check | cadence=%s | board_baseline=%s | live_family_preserved=yes",
                                     ASC_TextOrUnavailable(top10_cadence_reason),
                                     top10_board_status));
           }
        }
     }
   else if(sparam == ASC_HUD_PREFIX + "pager_prev") ASC_HudPagePrev();
   else if(sparam == ASC_HUD_PREFIX + "pager_next") ASC_HudPageNext();
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_1")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOL_OVERVIEW);
     }
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_2")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_MARKET_WATCH;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_ASPECT_DETAIL);
     }
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_3")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_SPECIFICATION;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_ASPECT_DETAIL);
     }
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_4")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_SELECTION_FILTER;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_ASPECT_DETAIL);
     }
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_5")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_SHORTLIST_CONTEXT;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_ASPECT_DETAIL);
     }
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_6")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_DEEP_ANALYSIS;
      g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_THESIS;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_ASPECT_DETAIL);
      ASC_HudSetNotice("Full Analysis view opened. Use Full Analysis to request a refreshed build for this symbol.");
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                  "deep view opened by navigation only; no deep request armed");
     }
   else if(sparam == ASC_HUD_PREFIX + "deep_sub_1")
     {
      g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_THESIS;
      ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_DETAIL | ASC_HUD_NAV_DIRTY_SYMBOL);
     }
   else if(sparam == ASC_HUD_PREFIX + "deep_sub_2")
     {
      g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_TIMING;
      ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_DETAIL | ASC_HUD_NAV_DIRTY_SYMBOL);
     }
   else if(sparam == ASC_HUD_PREFIX + "deep_sub_3")
     {
      g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_STRUCTURE;
      ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_DETAIL | ASC_HUD_NAV_DIRTY_SYMBOL);
     }
   else if(sparam == ASC_HUD_PREFIX + "deep_sub_4")
     {
      g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_EXECUTION;
      ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_DETAIL | ASC_HUD_NAV_DIRTY_SYMBOL);
     }
   else if(sparam == ASC_HUD_PREFIX + "deep_sub_5")
     {
      g_asc_hud.selected_deep_subpage = ASC_HUD_DEEP_SUBPAGE_TIMEFRAMES;
      ASC_HudMarkDirtyNavigation(ASC_HUD_NAV_DIRTY_DETAIL | ASC_HUD_NAV_DIRTY_SYMBOL);
     }
   else if(sparam == ASC_HUD_PREFIX + "sym_stat_7" || sparam == ASC_HUD_PREFIX + "sym_stat_8")
      ASC_HudSetNotice("Additional symbol sections are currently inactive in this build.");
   else if(sparam == ASC_HUD_PREFIX + "act_deep")
     {
      g_asc_hud.proof_refresh_request_seq++;
      g_asc_hud.proof_full_analysis_refresh_count++;
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                  StringFormat("action=full_analysis_refresh req_seq=%d validating selected-symbol context", g_asc_hud.proof_refresh_request_seq));
      string blocked_reason = "";
      if(ASC_HudDeepActionContextReady(blocked_reason))
        {
         string deep_notice = "";
         if(ASC_HudEmitCurrentFocusFromDeepTrigger(runtime, deep_notice))
           {
            ASC_HudQueueViewedCurrentFocusSync(runtime, false);
            string selected_downstream_status = "not_requested";
            ASC_HudRequestForcedDownstreamRefresh(runtime,
                                                  selected_downstream_status,
                                                  "selected_symbol_family",
                                                  g_asc_hud.selected_symbol,
                                                  "forced Layer 3-6 refresh queued from explicit HUD Run Full action");
            string run_full_board_status = "not_requested";
            ASC_HudRequestManualMarketBoardRefresh(runtime,
                                                   run_full_board_status,
                                                   "manual_hud_run_full_selected_symbol",
                                                   "manual board refresh queued from explicit HUD Run Full action");
            deep_notice += " Downstream refresh foundation=" + selected_downstream_status + ".";
            if(run_full_board_status == "queued")
               deep_notice += " Market Board baseline refresh was queued first for same-family child sync.";
            else if(run_full_board_status == "already_pending")
               deep_notice += " Market Board baseline refresh was already pending for this Run Full family.";
            ASC_HudSetNotice(deep_notice);
            ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                        StringFormat("full analysis request armed from explicit action button | board_baseline=%s", run_full_board_status));
           }
         else
           {
            ASC_HudSetNotice(deep_notice);
            ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                        "full analysis request rejected before queue from explicit action button");
           }
        }
      else
        {
         ASC_HudSetNotice(blocked_reason);
         ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
                     "full analysis request rejected before queue: action context not ready");
        }
     }
   else if(sparam == ASC_HUD_PREFIX + "act_aurora")
     {
      g_asc_hud.proof_refresh_request_seq++;
      g_asc_hud.proof_selection_refresh_count++;
      g_asc_hud.proof_shortlist_refresh_count++;
      // Keep click path fast: queue heavy rebuild on next heartbeat and keep this path UI-light.
      ASC_HudInvalidateSelectedSymbolCache();
      g_asc_hud.last_leaders_bucket_id = "";
      g_asc_hud.last_leaders_shortlist_signature = "";
      g_asc_hud.last_shortlist_signature = "";
      g_asc_hud.last_shortlist_signature_source = "";
      g_asc_hud.last_shortlist_signature_revision = 0;
      g_asc_hud.last_shortlist_signature_pass_utc = 0;
      g_asc_hud.last_shortlist_signature_count = 0;
      ASC_HudGlobalTop10CacheInvalidate();
      g_asc_hud.last_tactical_signature = "";
      g_asc_hud.last_tactical_fingerprint = 0;
      ASC_HudQueueHeavyRefresh("selection_then_shortlist_refresh");
      ASC_HudMarkDirtyDataLight();
      ASC_HudRequestRedraw();
      ASC_HudSetNotice("Selection and Shortlist refresh queued for next heartbeat.");
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudRefreshAction", click_symbol,
                  StringFormat("action=selection_then_shortlist_refresh req_seq=%d bucket=%s sub=%s symbol=%s",
                               g_asc_hud.proof_refresh_request_seq,
                               g_asc_hud.selected_bucket_id,
                               g_asc_hud.selected_sub_bucket_key,
                               g_asc_hud.selected_symbol));
     }
   else if(sparam == ASC_HUD_PREFIX + "act_semi")
     {
      g_asc_hud.selected_symbol_section = ASC_HUD_SYMBOL_SECTION_OVERVIEW;
      g_asc_hud.selected_stat = ASC_HudStatForSection(g_asc_hud.selected_symbol_section);
      ASC_HudOpenPage(ASC_HUD_PAGE_SYMBOL_OVERVIEW);
     }
   else if(sparam == ASC_HUD_PREFIX + "act_full")
     {
      g_asc_hud.proof_refresh_request_seq++;
      g_asc_hud.last_data_signature = "";
      g_asc_hud.last_structure_signature = "";
      g_asc_hud.last_tactical_signature = "";
      g_asc_hud.last_render_context_signature = "";
      g_asc_hud.last_render_snapshot_signature = "";
      g_asc_hud.last_data_fingerprint = 0;
      g_asc_hud.last_structure_fingerprint = 0;
      g_asc_hud.last_tactical_fingerprint = 0;
      g_asc_hud.last_rebuild_revision = 0;
      g_asc_hud.last_rebuild_sub_bucket_key = "";
      ASC_HudMarkDirtyDataHeavy();
      ASC_HudSetNotice("Sync requested.");
      ASC_LogInfo("ASC_HUD_Manager", "ASC_HudRefreshAction", click_symbol,
                  StringFormat("action=sync req_seq=%d bucket=%s sub=%s symbol=%s",
                               g_asc_hud.proof_refresh_request_seq,
                               g_asc_hud.selected_bucket_id,
                               g_asc_hud.selected_sub_bucket_key,
                               g_asc_hud.selected_symbol));
     }
  else if(StringFind(sparam, ASC_HUD_PREFIX + "row_") == 0 && StringFind(sparam, "_btn") > 0)
     {
      string tail = StringSubstr(sparam, StringLen(ASC_HUD_PREFIX + "row_"));
      int divider = StringFind(tail, "_btn");
      if(divider > 0)
        {
         int row = (int)StringToInteger(StringSubstr(tail, 0, divider));
         if(row >= 0 && row < ASC_HUD_ROW_SLOTS)
            ASC_HudHandleRowClick(row);
        }
     }

   bool was_symbol_context = (previous_page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || previous_page == ASC_HUD_PAGE_ASPECT_DETAIL);
   bool is_symbol_context = (g_asc_hud.page == ASC_HUD_PAGE_SYMBOL_OVERVIEW || g_asc_hud.page == ASC_HUD_PAGE_ASPECT_DETAIL);
   bool selected_symbol_changed = (g_asc_hud.selected_symbol != previous_symbol);
   if(selected_symbol_changed)
      ASC_HudInvalidateSelectedSymbolCache();

   string control_class = ASC_HudClassifyControl(sparam);
   g_asc_hud.proof_last_control_class = control_class;
   g_asc_hud.proof_last_target_page = ASC_HudPageName(g_asc_hud.page);
   g_asc_hud.proof_last_target_symbol = g_asc_hud.selected_symbol;
   bool ordinary_nav_control = ASC_HudControlIsOrdinaryNavigation(control_class);

   if(!suppress_view_sync
      && StringLen(g_asc_hud.selected_symbol) > 0
      && is_symbol_context
      && (selected_symbol_changed || !was_symbol_context))
     {
      ASC_HudSyncRuntimeSelectedSymbol(runtime, false);
      ASC_HudMarkCurrentFocusSyncDeferred(g_asc_hud.selected_symbol);
     }
   else if(StringLen(g_asc_hud.selected_symbol) > 0 && is_symbol_context)
     {
      // RUN103R: same-symbol section clicks keep the cached runtime pointer; no repeated selected-symbol lookup on ordinary navigation.
     }

   bool navigation_changed = (g_asc_hud.page != previous_page
                              || selected_symbol_changed
                              || g_asc_hud.dirty_navigation);
   if(navigation_changed)
     {
      string ack_label = ordinary_nav_control ? "Opening..." : "Action accepted...";
      ASC_HudAckNavigationClick(event_started_ms, ack_label, control_class, control_class);
      hud_service_state = ordinary_nav_control ? "ack_deferred_render_fast_path" : "ack_deferred_render_slow_path";
     }

   bool dirty_now = ASC_HudIsDirty();
   if(dirty_now && g_asc_hud.dirty_data_heavy)
     {
      ASC_HudShowDeferredTransition("Updating shortlist and symbols...");
      hud_service_state = "deferred_heavy_render";
     }
   else if(!navigation_changed && !dirty_now)
     {
      bool fast_path_applied = ASC_HudRefreshDisplayOnlyFastPath(runtime.heartbeat_counter, true);
      hud_service_state = fast_path_applied ? "served_fast" : "served_clean";
      ASC_HudFlushPendingRedraw();
     }
   else if(!navigation_changed && dirty_now)
     {
      ASC_HudRequestRedraw();
      hud_service_state = "deferred_render";
      ASC_HudFlushPendingRedraw();
     }
   g_asc_hud.proof_last_click_handler_total_ms = GetTickCount() - event_started_ms;
   ASC_LogInfo("ASC_HUD_Manager", "ASC_HudOnChartEvent", click_symbol,
               "hud_service=" + hud_service_state
               + " event_ms=" + ASC_HudUintText((uint)(GetTickCount() - event_started_ms))
               + " ack_ms=" + ASC_HudUintText(g_asc_hud.proof_last_click_to_ack_ms)
               + " deferred_wait_ms=" + ASC_HudUintText(g_asc_hud.proof_last_deferred_render_wait_ms)
               + " deferred_render_ms=" + ASC_HudUintText(g_asc_hud.proof_last_deferred_render_ms)
               + " control=" + sparam
               + " class=" + g_asc_hud.proof_last_control_class
               + " page_before=" + ASC_HudPageName(previous_page)
               + " page_after=" + ASC_HudPageName(g_asc_hud.page)
               + " target_symbol=" + g_asc_hud.selected_symbol
               + " dirty=" + ASC_HudBoolText(ASC_HudIsDirty())
               + " artifact_sync_deferred=" + ASC_HudBoolText(g_asc_hud.proof_last_artifact_sync_deferred)
               + " top10_status=" + runtime.top10_run_full_batch_status);
  }

#endif
