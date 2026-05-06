#ifndef __ASC_HUD_READ_MODEL_RENDER_INPUT_MQH__
#define __ASC_HUD_READ_MODEL_RENDER_INPUT_MQH__

// Prepared HUD list-row read-model / render-input assembly seam only.
// This helper consumes already-owned HUD truth and prepares draw packets.
// It must not become a truth owner, page router, click router, or render orchestrator.

struct ASC_HudPreparedListRowRenderInput
  {
   bool has_row;
   bool row_warning;
   bool row_focused;
   bool selected_row;
   bool symbol_promoted;
   bool symbol_shortlisted;
   bool symbol_pending;
   bool symbol_blocked;
   string title;
   string summary;
   string detail;
   string meta;
   string end_primary;
   string end_secondary;
   string center_primary;
   string center_secondary;
   string chip_a;
   string chip_b;
   string chip_c;
   string button_text;
  };

bool ASC_HudBuildPreparedListRow(const int visible_index,const int viewport_w,ASC_HudPreparedListRowRenderInput &row)
  {
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
   string button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
   bool selected_row = false;
   bool symbol_promoted = false;
   bool symbol_shortlisted = false;
   bool symbol_pending = false;
   bool symbol_blocked = false;

      if(g_asc_hud.page == ASC_HUD_PAGE_MAIN_BUCKETS)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         int visible = -1;
         for(int i = 0; i < ArraySize(g_asc_hud.buckets); i++)
           {
            ASC_HudBucketRow b = g_asc_hud.buckets[i];
            if(!ASC_HudBucketAllowedByControls(b.id))
               continue;
            visible++;
            if(visible != visible_index)
               continue;
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
            detail = StringFormat("Promoted %d (%.1f%%) | Ranked %d | Freshness %s | %s",
                                  ranking_stats.promoted_count,
                                  promoted_density,
                                  ranking_stats.ranked_count,
                                  freshness,
                                  ASC_HudBucketWhyNowLine(b, ranking_stats));
            center_primary = StringFormat("Promoted %d (%.1f%%) | Ranked %d",
                                          ranking_stats.promoted_count,
                                          promoted_density,
                                          ranking_stats.ranked_count);
            center_secondary = "Why now: " + ASC_HudBucketWhyNowLine(b, ranking_stats);
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
            break;
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_SUB_GROUPS)
        {
         if(ASC_HudIsStockBucketId(g_asc_hud.selected_bucket_id))
           {
            string parent_key = ASC_HudActiveStockBrowseParentKey();
            ASC_HudBrowseNode node;
            if(ASC_HudVisibleBrowseNodeAt(parent_key, visible_index, node))
              {
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
               string source_text = "Src Model";
               if(StringLen(node.source) > 0 && node.source == "runtime")
                  source_text = "Src Runtime";
               end_primary = StringFormat("Breadth %d | Ranked %d | Ready %d",
                                          node.total,
                                          ranked_count,
                                          node.eligible_count);
               end_secondary = StringFormat("%s | %s",
                                            source_text,
                                            has_children ? "Group lane" : "Leaf lane");
               meta = StringFormat("%s | Ranked %d | Ready %d | %s",
                                   source_text,
                                   ranked_count,
                                   node.eligible_count,
                                   has_children ? "Group level" : "Leaf level");
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
         else
           {
            button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
            int visible = -1;
            for(int i = 0; i < ArraySize(g_asc_hud.sub_buckets); i++)
              {
               if(g_asc_hud.sub_buckets[i].bucket_id != g_asc_hud.selected_bucket_id)
                  continue;
               visible++;
               if(visible != visible_index)
                  continue;

               ASC_HudSubBucketRow sub = g_asc_hud.sub_buckets[i];
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
               break;
              }
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_GLOBAL_TOP10)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         ASC_ShortlistSymbolSummary shortlist_entry;
         int shortlist_total = 0;
         if(ASC_HudTryGetGlobalTop10EntryByVisibleIndex(visible_index, shortlist_entry, shortlist_total))
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
            end_primary = "Diversified overall carry | Bucket " + ASC_HudEffectiveMainBucketName(st);
            end_secondary = "Freshness " + freshness + " | Row type premium overall surface";
            meta = "Owner path: lawful diversified overall shortlist/board carry only | HUD consumer-only | No local re-rank.";
            has_row = true;
            row_focused = selected_row;
            symbol_promoted = is_promoted;
            symbol_shortlisted = !is_promoted;
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_SYMBOLS)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         int visible = -1;
         for(int i = 0; i < ArraySize(g_asc_hud.symbol_indices); i++)
           {
            ASC_Layer1SymbolState st;
            if(ASC_HudMaterializeSymbolState(g_asc_hud.symbol_indices[i], st))
              {
               visible++;
               if(visible != visible_index)
                  continue;
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
               if(viewport_w < 1080)
                 {
                  chip_a = "State " + ASC_HudPrimaryOpenClosedState(st.state)
                           + " | Fresh " + freshness
                           + " | Age " + ASC_HudAgeText(st.observed_at_utc, now_utc);
                  chip_b = ASC_HudClampText(chip_b, (viewport_w < 940 ? 44 : 56));
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
               break;
              }
           }
        }
      else if(g_asc_hud.page == ASC_HUD_PAGE_BUCKET_LEADERS)
        {
         button_text = ASC_HudBrowseRowButtonLabel(g_asc_hud.page);
         int visible = -1;
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
            ASC_ShortlistSymbolSummary shortlist_entry = g_asc_hud_shortlist_rows[shortlist_idx];
            int preview_layer1_index = -1;
            ASC_HudLeaderRowVisibilityState visibility_state = ASC_HudLeaderRowVisibilityStateForEntry(shortlist_entry, preview_layer1_index);
            if(!ASC_HudLeaderRowStateIsVisible(visibility_state))
               continue;
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
            visible++;
            if(visible != visible_index)
               continue;

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
            break;
           }
        }

   row.has_row = has_row;
   row.row_warning = row_warning;
   row.row_focused = row_focused;
   row.selected_row = selected_row;
   row.symbol_promoted = symbol_promoted;
   row.symbol_shortlisted = symbol_shortlisted;
   row.symbol_pending = symbol_pending;
   row.symbol_blocked = symbol_blocked;
   row.title = title;
   row.summary = summary;
   row.detail = detail;
   row.meta = meta;
   row.end_primary = end_primary;
   row.end_secondary = end_secondary;
   row.center_primary = center_primary;
   row.center_secondary = center_secondary;
   row.chip_a = chip_a;
   row.chip_b = chip_b;
   row.chip_c = chip_c;
   row.button_text = button_text;
   return has_row;
  }

#endif // __ASC_HUD_READ_MODEL_RENDER_INPUT_MQH__
