#ifndef ASC_HUD_MANAGER_MQH
#define ASC_HUD_MANAGER_MQH

#include "../config/ASC_Config_Defaults.mqh"
#include "../core/ASC_Core_RuntimeState.mqh"
#include "ASC_HUD_BrowseState.mqh"

#define ASC_HUD_PREFIX "ASC_HUD::"
#define ASC_HUD_MAX_LIST_ROWS 10
#define ASC_HUD_OVERVIEW_BUCKET_COUNT 6
#define ASC_HUD_CARD_COLUMNS 2
#define ASC_HUD_CARD_ROWS 3

//
// A unified row height used throughout the HUD.  Previously the row height was
// implicitly split between the layout calculations (60 px) and the visual
// construction in ASC_HUD_PrepareRows (40 px + spacing).  This mismatch
// resulted in extra blank row artefacts because the computed number of
// visible rows did not align with the physical rows that were drawn.  To
// eliminate this blank-row bug, we explicitly define a single row height
// constant and use it consistently when laying out rows and when building the
// row objects.  Any future adjustments to the row height need only change
// this one definition.
//
#define ASC_HUD_ROW_HEIGHT 46

enum ASC_HUDView
  {
   ASC_HUD_VIEW_OVERVIEW = 0,
   ASC_HUD_VIEW_MAIN_BUCKETS,
   ASC_HUD_VIEW_SUB_BUCKETS,
   ASC_HUD_VIEW_SYMBOLS,
   ASC_HUD_VIEW_SYMBOL_DETAIL,
   ASC_HUD_VIEW_STAT_DETAIL
  };

enum ASC_HUDStatView
  {
   ASC_HUD_STAT_SUMMARY = 0,
   ASC_HUD_STAT_CLASSIFICATION,
   ASC_HUD_STAT_MARKET_STATUS,
   ASC_HUD_STAT_RUNTIME
  };

struct ASC_HUDState
  {
   bool Visible;
   bool Dirty;
   ASC_HUDView CurrentView;
   ASC_HUDStatView CurrentStatView;
   string SelectedBucketId;
   string SelectedSubBucketKey;
   string SelectedSymbolKey;
   int ListPage;
   int SelectedRecordIndex;
   int VisibleRowCapacity;
   int CurrentListTotal;
   string LastRenderSignature;
   string LastDataSignature;
  };

ASC_HUDState g_asc_hud_state;

void ASC_HUD_Log(const string scope,
                 const string message)
  {
   Print("[ASC][HUD][" + scope + "] " + message);
  }


string ASC_HUD_ViewName(const ASC_HUDView view)
  {
   if(view == ASC_HUD_VIEW_OVERVIEW)      return "Overview";
   if(view == ASC_HUD_VIEW_MAIN_BUCKETS)  return "Main Buckets";
   if(view == ASC_HUD_VIEW_SUB_BUCKETS)   return "Sub-Buckets";
   if(view == ASC_HUD_VIEW_SYMBOLS)       return "Symbols";
   if(view == ASC_HUD_VIEW_SYMBOL_DETAIL) return "Symbol Detail";
   if(view == ASC_HUD_VIEW_STAT_DETAIL)   return "Detail";
   return "Overview";
  }

string ASC_HUD_StatName(const ASC_HUDStatView view)
  {
   if(view == ASC_HUD_STAT_SUMMARY)        return "Summary";
   if(view == ASC_HUD_STAT_CLASSIFICATION) return "Classification";
   if(view == ASC_HUD_STAT_MARKET_STATUS)  return "Market Status";
   if(view == ASC_HUD_STAT_RUNTIME)        return "Runtime";
   return "Summary";
  }

string ASC_HUD_MarketText(const ASC_MarketStatePosture posture)
  {
   if(posture == ASC_MARKET_STATE_OPEN)      return "Open";
   if(posture == ASC_MARKET_STATE_CLOSED)    return "Closed";
   if(posture == ASC_MARKET_STATE_UNCERTAIN) return "Market Watch";
   return "Unknown";
  }

string ASC_HUD_FreshnessText(const ASC_FreshnessPosture posture)
  {
   if(posture == ASC_FRESHNESS_FRESH)           return "Fresh";
   if(posture == ASC_FRESHNESS_AGING)           return "Aging";
   if(posture == ASC_FRESHNESS_STALE)           return "Stale";
   if(posture == ASC_FRESHNESS_PENDING_REFRESH) return "Pending Refresh";
   if(posture == ASC_FRESHNESS_DEGRADED)        return "Degraded";
   return "Unknown";
  }

string ASC_HUD_CompletenessText(const ASC_CompletenessPosture posture)
  {
   if(posture == ASC_COMPLETENESS_COMPLETE) return "Complete";
   if(posture == ASC_COMPLETENESS_PARTIAL)  return "Partial";
   if(posture == ASC_COMPLETENESS_BLOCKED)  return "Blocked";
   if(posture == ASC_COMPLETENESS_DEGRADED) return "Degraded";
   if(posture == ASC_COMPLETENESS_INVALID)  return "Invalid";
   return "Unknown";
  }

string ASC_HUD_FormatAgeText(const datetime observed_at,
                             const datetime reference_time)
  {
   if(observed_at <= 0 || reference_time <= 0 || reference_time < observed_at)
      return "Age Unknown";

   int age = (int)(reference_time - observed_at);
   if(age < 60)
      return IntegerToString(age) + " sec";
   if(age < 3600)
      return IntegerToString(age / 60) + " min";
   if(age < 86400)
      return IntegerToString(age / 3600) + " hr";
   return IntegerToString(age / 86400) + " day";
  }

void ASC_HUD_ResetState()
  {
   g_asc_hud_state.Visible = false;
   g_asc_hud_state.Dirty = true;
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_OVERVIEW;
   g_asc_hud_state.CurrentStatView = ASC_HUD_STAT_SUMMARY;
   g_asc_hud_state.SelectedBucketId = "";
   g_asc_hud_state.SelectedSubBucketKey = "";
   g_asc_hud_state.SelectedSymbolKey = "";
   g_asc_hud_state.ListPage = 0;
   g_asc_hud_state.SelectedRecordIndex = -1;
   g_asc_hud_state.VisibleRowCapacity = ASC_HUD_MAX_LIST_ROWS;
   g_asc_hud_state.CurrentListTotal = 0;
   g_asc_hud_state.LastRenderSignature = "";
   g_asc_hud_state.LastDataSignature = "";
  }

void ASC_HUD_DeletePrefixedObjects()
  {
   int total = ObjectsTotal(0, 0, -1);
   for(int i = total - 1; i >= 0; i--)
     {
      string name = ObjectName(0, i, 0, -1);
      if(StringFind(name, ASC_HUD_PREFIX) == 0)
         ObjectDelete(0, name);
     }
  }

void ASC_HUD_EnsurePanel(const string name,
                         const int x,
                         const int y,
                         const int w,
                         const int h,
                         const color fill,
                         const color border)
  {
   if(ObjectFind(0, name) < 0)
     {
      ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
      ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
     }
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, h);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, fill);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, border);
   ObjectSetInteger(0, name, OBJPROP_COLOR, fill);
   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
   ObjectSetInteger(0, name, OBJPROP_STATE, false);
  }

void ASC_HUD_CollapsePanel(const string name,
                           const color fill,
                           const color border)
  {
   if(ObjectFind(0, name) < 0)
      return;
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, 0);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, 0);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, 0);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, 0);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, fill);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, border);
   ObjectSetInteger(0, name, OBJPROP_COLOR, fill);
  }

void ASC_HUD_EnsureLabel(const string name,
                         const string text,
                         const int x,
                         const int y,
                         const color text_color,
                         const int font_size,
                         const string font_name)
  {
   if(ObjectFind(0, name) < 0)
     {
      ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
      ObjectSetInteger(0, name, OBJPROP_ZORDER, 1);
      ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
      ObjectSetString(0, name, OBJPROP_FONT, font_name);
     }
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_COLOR, text_color);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, font_size);
   ObjectSetString(0, name, OBJPROP_TEXT, text);
  }

void ASC_HUD_CollapseLabel(const string name,
                           const color text_color)
  {
   if(ObjectFind(0, name) < 0)
      return;
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, 0);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, 0);
   ObjectSetInteger(0, name, OBJPROP_COLOR, text_color);
   ObjectSetString(0, name, OBJPROP_TEXT, "");
  }

void ASC_HUD_EnsureButton(const string name,
                          const string text,
                          const int x,
                          const int y,
                          const int w,
                          const int h,
                          const color fill,
                          const color border,
                          const color text_color,
                          const int font_size)
  {
   if(ObjectFind(0, name) < 0)
     {
      ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
      ObjectSetInteger(0, name, OBJPROP_ZORDER, 2);
      ObjectSetString(0, name, OBJPROP_FONT, "Consolas");
     }
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, h);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, fill);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, border);
   ObjectSetInteger(0, name, OBJPROP_COLOR, text_color);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, font_size);
   ObjectSetInteger(0, name, OBJPROP_STATE, false);
   ObjectSetString(0, name, OBJPROP_TEXT, text);
  }

void ASC_HUD_CollapseButton(const string name,
                            const color fill,
                            const color border,
                            const color text_color)
  {
   if(ObjectFind(0, name) < 0)
      return;
   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, 0);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, 0);
   ObjectSetInteger(0, name, OBJPROP_XSIZE, 0);
   ObjectSetInteger(0, name, OBJPROP_YSIZE, 0);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, fill);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, border);
   ObjectSetInteger(0, name, OBJPROP_COLOR, text_color);
   ObjectSetString(0, name, OBJPROP_TEXT, "");
  }

string ASC_HUD_MainBucketDominantPosture(const ASC_HUDMainBucket &bucket)
  {
   // Present operator-facing posture names without the dev-only "focus" suffix.
   if(bucket.Open >= bucket.Closed && bucket.Open >= bucket.Watch && bucket.Open >= bucket.Unknown)
      return "Open";
   if(bucket.Closed >= bucket.Watch && bucket.Closed >= bucket.Unknown)
      return "Closed";
   if(bucket.Watch >= bucket.Unknown)
      return "Market Watch";
   return "Mixed";
  }

ASC_MarketStateRecord ASC_HUD_SelectedRecord()
  {
   ASC_MarketStateRecord empty_record;
   int total = ArraySize(g_asc_layer1_records);
   for(int i = 0; i < total; i++)
     {
      if(g_asc_layer1_records[i].Identity.SymbolKey == g_asc_hud_state.SelectedSymbolKey)
        {
         g_asc_hud_state.SelectedRecordIndex = i;
         return g_asc_layer1_records[i];
        }
     }

   if(g_asc_hud_state.SelectedRecordIndex >= 0 && g_asc_hud_state.SelectedRecordIndex < total)
      return g_asc_layer1_records[g_asc_hud_state.SelectedRecordIndex];

   if(total > 0)
      return g_asc_layer1_records[0];

   return empty_record;
  }

string ASC_HUD_FitTextTail(const string value,
                            const int max_chars)
  {
   int total = (int)StringLen(value);
   if(max_chars <= 3)
      return "...";
   if(total <= max_chars)
      return value;
   int tail = max_chars - 3;
   if(tail < 1)
      tail = 1;
   return "..." + StringSubstr(value, total - tail);
  }

string ASC_HUD_FitText(const string value,
                       const int max_chars)
  {
   int total = (int)StringLen(value);
   if(max_chars <= 3)
      return "...";
   if(total <= max_chars)
      return value;
   return StringSubstr(value, 0, max_chars - 3) + "...";
  }

int ASC_HUD_MaxCharsForWidth(const int width,
                             const int font_size,
                             const int reserve_pixels = 0)
  {
   int usable = width - reserve_pixels;
   if(usable < 24)
      usable = 24;

   int pixels_per_char = 6;
   if(font_size <= 8)
      pixels_per_char = 5;
   else if(font_size >= 10)
      pixels_per_char = 7;

   int max_chars = usable / pixels_per_char;
   if(max_chars < 4)
      max_chars = 4;
   return max_chars;
  }

string ASC_HUD_FitTextWidth(const string value,
                            const int width,
                            const int font_size,
                            const int reserve_pixels = 0)
  {
   return ASC_HUD_FitText(value, ASC_HUD_MaxCharsForWidth(width, font_size, reserve_pixels));
  }

string ASC_HUD_FitTextTailWidth(const string value,
                                const int width,
                                const int font_size,
                                const int reserve_pixels = 0)
  {
   return ASC_HUD_FitTextTail(value, ASC_HUD_MaxCharsForWidth(width, font_size, reserve_pixels));
  }

int ASC_HUD_CurrentListTotal()
  {
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_MAIN_BUCKETS)
      return ASC_HUD_MainBucketCount();

   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS)
      return ASC_HUD_ActiveSubBucketCount();

   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS)
      return ASC_HUD_ActiveSymbolCount();

   return 0;
  }

int ASC_HUD_CurrentPageCount()
  {
   int capacity = g_asc_hud_state.VisibleRowCapacity;
   if(capacity <= 0)
      capacity = ASC_HUD_MAX_LIST_ROWS;

   int total = g_asc_hud_state.CurrentListTotal;
   if(total <= 0)
      total = ASC_HUD_CurrentListTotal();

   if(total <= 0)
      return 1;

   int pages = total / capacity;
   if((total % capacity) != 0)
      pages++;
   if(pages < 1)
      pages = 1;
   return pages;
  }

bool ASC_HUD_CanGoBack()
  {
   return(g_asc_hud_state.CurrentView != ASC_HUD_VIEW_OVERVIEW);
  }

bool ASC_HUD_CanOpenSymbolShortcut()
  {
   return(g_asc_hud_state.SelectedSymbolKey != "");
  }

bool ASC_HUD_CanOpenStatShortcut()
  {
   return(g_asc_hud_state.SelectedSymbolKey != "");
  }

string ASC_HUD_BreadcrumbText()
  {
   string path = "Overview";
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_MAIN_BUCKETS)
      return path + " > Main Buckets";

   if(g_asc_hud_state.SelectedBucketId != "")
      path += " > " + ASC_HUD_MainBucketName(g_asc_hud_state.SelectedBucketId);

   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS)
      return path + " > Sub-Buckets";

   if(g_asc_hud_state.SelectedSubBucketKey != "")
     {
      string sub_bucket_name = ASC_HUD_SubBucketNameByKey(g_asc_hud_state.SelectedSubBucketKey);
      if(sub_bucket_name != "")
         path += " > " + sub_bucket_name;
     }

   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS)
      return path + " > Symbols";

   if(g_asc_hud_state.SelectedSymbolKey != "")
      path += " > " + g_asc_hud_state.SelectedSymbolKey;

   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOL_DETAIL)
      return path + " > Symbol Detail";

   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_STAT_DETAIL)
      return path + " > " + ASC_HUD_StatName(g_asc_hud_state.CurrentStatView);

   return path;
  }

string ASC_HUD_RuntimeCardText(const ASC_RootRuntimeState &state)
  {
   string text = "Runtime\r\n";
   text += "Server: " + state.Runtime.Identity.ServerName + "\r\n";
   text += "Last Heartbeat: " + TimeToString(state.Runtime.PhaseMarkers.LastHeartbeatAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   text += "Scan Time: " + IntegerToString(state.Layer1.LastScanDurationMilliseconds) + " ms\r\n";
   text += "Output: ";
   text += (state.Publication.OutputReady ? "Ready" : "Waiting");
   text += "\r\nSummary: " + TimeToString(state.Layer1.LastSummaryPublishAt, TIME_DATE | TIME_SECONDS);
   return text;
  }

string ASC_HUD_UniverseCardText(const ASC_RootRuntimeState &state)
  {
   string text = "Universe\r\n";
   text += "Tracked: " + IntegerToString(state.Layer1.TotalSymbols) + "\r\n";
   text += "Open: " + IntegerToString(state.Layer1.OpenCount) + "\r\n";
   text += "Closed: " + IntegerToString(state.Layer1.ClosedCount) + "\r\n";
   text += "Watch: " + IntegerToString(state.Layer1.UncertainCount) + "\r\n";
   text += "Grouped: " + IntegerToString(state.Layer1.ResolvedClassificationCount);
   return text;
  }

string ASC_HUD_MainBucketCardText(const ASC_HUDMainBucket &bucket)
  {
   string text = bucket.Name + "\r\n";
   text += "Tracked: " + IntegerToString(bucket.Total) + "\r\n";
   text += "Open: " + IntegerToString(bucket.Open)
           + " | Closed: " + IntegerToString(bucket.Closed)
           + " | Watch: " + IntegerToString(bucket.Watch);
   return text;
  }

string ASC_HUD_MainBucketRowText(const ASC_HUDMainBucket &bucket,
                               const int width = 0)
  {
   string text = bucket.Name;
   text += "  |  Tracked " + IntegerToString(bucket.Total);
   text += "  |  Open " + IntegerToString(bucket.Open);
   text += "  |  Closed " + IntegerToString(bucket.Closed);
   text += "  |  Watch " + IntegerToString(bucket.Watch);
   if(width > 0)
      return ASC_HUD_FitTextWidth(text, width, 8, 12);
   return text;
  }

string ASC_HUD_SubBucketRowText(const ASC_HUDSubBucket &bucket,
                                const int width = 0)
  {
   string text = bucket.Name;
   text += "  |  Symbols " + IntegerToString(bucket.Total);
   text += "  |  Open " + IntegerToString(bucket.Open);
   text += "  |  Closed " + IntegerToString(bucket.Closed);
   text += "  |  Watch " + IntegerToString(bucket.Watch);
   if(width > 0)
      return ASC_HUD_FitTextWidth(text, width, 8, 12);
   return text;
  }

string ASC_HUD_SymbolRowText(const ASC_MarketStateRecord &record,
                             const ASC_HUDSymbolEntry &entry,
                             const int width = 0)
  {
   string line1 = entry.DisplaySymbol + "  |  ";
   line1 += ASC_HUD_MarketText(record.MarketState);
   line1 += "  |  " + ASC_HUD_FreshnessText(record.Freshness);
   line1 += "  |  " + ASC_HUD_FormatAgeText(record.ObservedAt, TimeCurrent());
   if(width > 0)
      line1 = ASC_HUD_FitTextWidth(line1, width, 8, 12);

   if(entry.DisplayName != "" && entry.DisplayName != entry.DisplaySymbol)
     {
      string line2 = entry.DisplayName;
      if(width > 0)
         line2 = ASC_HUD_FitTextWidth(line2, width, 8, 12);
      return line1 + "\r\n" + line2;
     }
   return line1;
  }

string ASC_HUD_SymbolDetailText(const ASC_MarketStateRecord &record)
  {
   string text = "Identity\r\n";
   text += "Symbol: " + record.Identity.DisplaySymbol + "\r\n";
   text += "Name: " + record.Identity.DisplayName + "\r\n";
   text += "Canonical: " + record.Identity.CanonicalSymbol + "\r\n\r\n";
   text += "Grouping\r\n";
   text += "Main Bucket: " + record.Identity.MainGroup + "\r\n";
   text += "Sub-Bucket: " + record.Identity.SubGroup + "\r\n";
   text += "Asset Class: " + record.Identity.AssetClass + "\r\n\r\n";
   text += "Market Status\r\n";
   text += "Posture: " + ASC_HUD_MarketText(record.MarketState) + "\r\n";
   text += "Freshness: " + ASC_HUD_FreshnessText(record.Freshness) + "\r\n";
   text += "Completeness: " + ASC_HUD_CompletenessText(record.Completeness) + "\r\n";
   text += "Observed: " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS) + "\r\n\r\n";
   text += "Reason\r\n";
   text += record.StatusReason;
   return text;
  }

string ASC_HUD_StatDetailText(const ASC_RootRuntimeState &state,
                              const ASC_MarketStateRecord &record)
  {
   if(g_asc_hud_state.CurrentStatView == ASC_HUD_STAT_SUMMARY)
      return ASC_HUD_SymbolDetailText(record);

   if(g_asc_hud_state.CurrentStatView == ASC_HUD_STAT_CLASSIFICATION)
     {
      string text = "Classification\r\n";
      text += "Resolved: ";
      text += record.Identity.ClassificationResolved ? "Yes" : "No";
      text += "\r\nConfidence: " + record.Identity.ClassificationConfidence + "\r\n";
      text += "Review: " + record.Identity.ClassificationReviewStatus + "\r\n";
      text += "Source: " + record.Identity.ClassificationSource + "\r\n\r\n";
      text += "Sector: " + record.Identity.Sector + "\r\n";
      text += "Industry: " + record.Identity.Industry + "\r\n";
      text += "Theme: " + record.Identity.ThemeBucket + "\r\n\r\n";
      text += record.Identity.ClassificationNote;
      return text;
     }

   if(g_asc_hud_state.CurrentStatView == ASC_HUD_STAT_MARKET_STATUS)
     {
      string text = "Market Status\r\n";
      text += "Current: " + ASC_HUD_MarketText(record.MarketState) + "\r\n";
      text += "Freshness: " + ASC_HUD_FreshnessText(record.Freshness) + "\r\n";
      text += "Completeness: " + ASC_HUD_CompletenessText(record.Completeness) + "\r\n";
      text += "Observed: " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS) + "\r\n";
      text += "Published: ";
      text += record.PublishedOnce ? "Yes" : "No";
      text += "\r\nLast Published: " + TimeToString(record.LastPublishedAt, TIME_DATE | TIME_SECONDS) + "\r\n\r\n";
      text += record.StatusReason;
      return text;
     }

   string runtime = "Runtime\r\n";
   runtime += "Session: " + state.Runtime.Identity.RuntimeSessionId + "\r\n";
   runtime += "Started: " + TimeToString(state.Runtime.Identity.StartedAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   runtime += "Last Heartbeat: " + TimeToString(state.Runtime.PhaseMarkers.LastHeartbeatAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   runtime += "Last Write: " + TimeToString(state.Runtime.PhaseMarkers.LastStructuralCommitAt, TIME_DATE | TIME_SECONDS) + "\r\n";
   runtime += "Last Read: " + TimeToString(state.Runtime.PhaseMarkers.LastStructuralConsumeAt, TIME_DATE | TIME_SECONDS) + "\r\n\r\n";
   runtime += "Publication Root\r\n" + state.Publication.OutputRoot;
   return runtime;
  }

void ASC_HUD_SectionPanel(const string id,
                           const string title,
                           const string line1,
                           const string line2,
                           const string line3,
                           const int x,
                           const int y,
                           const int w,
                           const int h,
                           const bool selected,
                           const color fill,
                           const color border,
                           const color accent,
                           const color text,
                           const color muted)
  {
   int text_w = w - 26;
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + id + "_panel", x, y, w, h, fill, border);
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + id + "_stripe", x, y, 5, h, accent, accent);
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_title", ASC_HUD_FitTextWidth(title, text_w, 10, 4), x + 14, y + 8, text, 10, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l1", ASC_HUD_FitTextWidth(line1, text_w, 9, 4), x + 14, y + 30, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l2", ASC_HUD_FitTextWidth(line2, text_w, 9, 4), x + 14, y + 48, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l3", ASC_HUD_FitTextWidth(line3, text_w, 9, 4), x + 14, y + 66, muted, 9, "Consolas");
  }

void ASC_HUD_HideSectionPanel(const string id)
  {
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + id + "_panel", clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + id + "_stripe", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_title", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l1", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l2", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l3", clrBlack);
  }

void ASC_HUD_DetailGridPanel(const string id,
                            const string title,
                            const string line1,
                            const string line2,
                            const string line3,
                            const string line4,
                            const int x,
                            const int y,
                            const int w,
                            const int h,
                            const color fill,
                            const color border,
                            const color accent,
                            const color text,
                            const color muted)
  {
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + id + "_panel", x, y, w, h, fill, border);
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + id + "_stripe", x, y, 5, h, accent, accent);
   int text_w = w - 28;
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_title", ASC_HUD_FitTextWidth(title, text_w, 10, 4), x + 14, y + 8, text, 10, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l1", ASC_HUD_FitTextWidth(line1, text_w, 9, 4), x + 14, y + 30, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l2", ASC_HUD_FitTextWidth(line2, text_w, 9, 4), x + 14, y + 48, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l3", ASC_HUD_FitTextWidth(line3, text_w, 9, 4), x + 14, y + 66, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + id + "_l4", ASC_HUD_FitTextWidth(line4, text_w, 9, 4), x + 14, y + 84, muted, 9, "Consolas");
  }

void ASC_HUD_HideDetailGridPanel(const string id)
  {
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + id + "_panel", clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + id + "_stripe", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_title", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l1", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l2", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l3", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + id + "_l4", clrBlack);
  }

void ASC_HUD_HideOverviewHero()
  {
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "overview_hero_panel", clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "overview_hero_stripe", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "overview_hero_title", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "overview_hero_l1", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "overview_hero_l2", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "overview_hero_l3", clrBlack);
  }

void ASC_HUD_OverviewHero(const ASC_RootRuntimeState &state,
                          const int heartbeat_count,
                          const int x,
                          const int y,
                          const int w,
                          const int h,
                          const color fill,
                          const color border,
                          const color accent,
                          const color text,
                          const color muted,
                          const color dim)
  {
   int text_w = w - 26;
   string line1 = "Heartbeat " + IntegerToString(heartbeat_count)
                  + " | Open " + IntegerToString(state.Layer1.OpenCount)
                  + " | Closed " + IntegerToString(state.Layer1.ClosedCount)
                  + " | Market Watch " + IntegerToString(state.Layer1.UncertainCount);
   string line2 = "Server " + state.Runtime.Identity.ServerName
                  + " | Scan " + IntegerToString(state.Layer1.LastScanDurationMilliseconds) + " ms"
                  + " | Grouped " + IntegerToString(state.Layer1.ResolvedClassificationCount);
   string line3 = "Use Buckets to move from market map into main buckets, sub-buckets, symbols, and detail without widening runtime authority.";

   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "overview_hero_panel", x, y, w, h, fill, border);
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "overview_hero_stripe", x, y, 5, h, accent, accent);
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "overview_hero_title", ASC_HUD_FitTextWidth(ASC_DEFAULT_PRODUCT_NAME + " — Market Map", text_w, 11, 4), x + 14, y + 8, text, 11, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "overview_hero_l1", ASC_HUD_FitTextWidth(line1, text_w, 10, 4), x + 14, y + 28, accent, 10, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "overview_hero_l2", ASC_HUD_FitTextWidth(line2, text_w, 9, 4), x + 14, y + 44, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "overview_hero_l3", ASC_HUD_FitTextWidth(line3, text_w, 9, 4), x + 14, y + 60, dim, 9, "Consolas");
  }

void ASC_HUD_OverviewBucketCard(const int index,
                                const ASC_HUDMainBucket &bucket,
                                const int x,
                                const int y,
                                const int w,
                                const int h,
                                const color fill,
                                const color border,
                                const color accent,
                                const color text,
                                const color muted,
                                const color dim)
  {
   string id = ASC_HUD_PREFIX + "bucket_card_" + IntegerToString(index);
   int text_w = w - 26;
   ASC_HUD_EnsureButton(id, "", x, y, w, h, fill, border, text, 8);
   ASC_HUD_EnsurePanel(id + "_stripe", x, y, 5, h, accent, accent);
   ASC_HUD_EnsureLabel(id + "_title", ASC_HUD_FitTextWidth(bucket.Name, text_w, 10, 4), x + 14, y + 8, text, 10, "Consolas");
   ASC_HUD_EnsureLabel(id + "_l1", ASC_HUD_FitTextWidth("Tracked " + IntegerToString(bucket.Total) + " | Open " + IntegerToString(bucket.Open), text_w, 9, 4), x + 14, y + 24, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(id + "_l2", ASC_HUD_FitTextWidth("Closed " + IntegerToString(bucket.Closed) + " | Market Watch " + IntegerToString(bucket.Watch), text_w, 9, 4), x + 14, y + 40, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(id + "_l3", ASC_HUD_FitTextWidth("Unknown " + IntegerToString(bucket.Unknown) + " | " + IntegerToString(bucket.SubBucketCount) + " groups", text_w - 76, 8, 4), x + 14, y + 56, dim, 8, "Consolas");
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "bucket_open_" + IntegerToString(index), "Open", x + w - 78, y + h - 30, 64, 22, fill, border, text, 8);
   ASC_HUD_CollapseLabel(id + "_text", clrBlack);
  }

void ASC_HUD_HideOverviewCard(const int index)
  {
   string id = ASC_HUD_PREFIX + "bucket_card_" + IntegerToString(index);
   ASC_HUD_CollapseButton(id, clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(id + "_stripe", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(id + "_title", clrBlack);
   ASC_HUD_CollapseLabel(id + "_l1", clrBlack);
   ASC_HUD_CollapseLabel(id + "_l2", clrBlack);
   ASC_HUD_CollapseLabel(id + "_l3", clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "main_bucket_open_" + IntegerToString(index), clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "bucket_open_" + IntegerToString(index), clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(id + "_text", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "bucket_card_text_" + IntegerToString(index), clrBlack);
  }

void ASC_HUD_MainBucketActionCard(const int index,
                                  const ASC_HUDMainBucket &bucket,
                                  const int x,
                                  const int y,
                                  const int w,
                                  const int h,
                                  const color fill,
                                  const color border,
                                  const color accent,
                                  const color text,
                                  const color muted,
                                  const color dim)
  {
   string id = ASC_HUD_PREFIX + "main_bucket_card_" + IntegerToString(index);
   int text_w = w - 26;
   string line1 = ASC_HUD_MainBucketDominantPosture(bucket) + " | Tracked " + IntegerToString(bucket.Total);
   string line2 = "Open " + IntegerToString(bucket.Open)
                  + " | Closed " + IntegerToString(bucket.Closed)
                  + " | Market Watch " + IntegerToString(bucket.Watch);
   string line3 = "Unknown " + IntegerToString(bucket.Unknown)
                  + " | " + IntegerToString(bucket.SubBucketCount) + " sub-buckets";

   ASC_HUD_EnsureButton(id, "", x, y, w, h, fill, border, text, 8);
   ASC_HUD_EnsurePanel(id + "_stripe", x, y, 6, h, accent, accent);
   ASC_HUD_EnsureLabel(id + "_title", ASC_HUD_FitTextWidth(bucket.Name, text_w, 11, 4), x + 14, y + 10, text, 11, "Consolas");
   ASC_HUD_EnsureLabel(id + "_l1", ASC_HUD_FitTextWidth(line1, text_w, 9, 4), x + 14, y + 32, accent, 9, "Consolas");
   ASC_HUD_EnsureLabel(id + "_l2", ASC_HUD_FitTextWidth(line2, text_w, 9, 4), x + 14, y + 50, muted, 9, "Consolas");
   ASC_HUD_EnsureLabel(id + "_l3", ASC_HUD_FitTextWidth(line3, text_w - 84, 8, 4), x + 14, y + 70, dim, 8, "Consolas");
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "main_bucket_open_" + IntegerToString(index), "View", x + w - 82, y + h - 30, 68, 22, fill, border, text, 8);
  }

void ASC_HUD_HideMainBucketCard(const int index)
  {
   string id = ASC_HUD_PREFIX + "main_bucket_card_" + IntegerToString(index);
   ASC_HUD_CollapseButton(id, clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(id + "_stripe", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(id + "_title", clrBlack);
   ASC_HUD_CollapseLabel(id + "_l1", clrBlack);
   ASC_HUD_CollapseLabel(id + "_l2", clrBlack);
   ASC_HUD_CollapseLabel(id + "_l3", clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "main_bucket_open_" + IntegerToString(index), clrBlack, clrBlack, clrBlack);
  }

string ASC_HUD_RenderSignature(const ASC_RootRuntimeState &state,
                               const int chart_w,
                               const int chart_h)
  {
   int age_bucket = 0;
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS
      || g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOL_DETAIL
      || g_asc_hud_state.CurrentView == ASC_HUD_VIEW_STAT_DETAIL)
      age_bucket = (int)(TimeCurrent() / 15);

   string signature = g_asc_hud_browse_signature
                      + ":" + IntegerToString(ASC_HUD_ActiveSubBucketCount())
                      + ":" + IntegerToString(ASC_HUD_ActiveSymbolCount())
                      + ":" + IntegerToString((int)g_asc_hud_state.CurrentView)
                      + ":" + IntegerToString(g_asc_hud_state.ListPage)
                      + ":" + g_asc_hud_state.SelectedBucketId
                      + ":" + g_asc_hud_state.SelectedSubBucketKey
                      + ":" + g_asc_hud_state.SelectedSymbolKey
                      + ":" + IntegerToString((int)g_asc_hud_state.CurrentStatView)
                      + ":" + IntegerToString(chart_w)
                      + ":" + IntegerToString(chart_h)
                      + ":" + IntegerToString(age_bucket);
   return signature;
  }

void ASC_HUD_PrepareRows(const int start_x,
                         const int start_y,
                         const int width,
                         const color fill,
                         const color fill_alt,
                         const color border,
                         const color text,
                         const color muted)
  {
   for(int row = 0; row < ASC_HUD_MAX_LIST_ROWS; row++)
     {
      // Compute the Y position using the unified row height.  Each row takes
      // ASC_HUD_ROW_HEIGHT pixels of vertical space.
      int y = start_y + row * ASC_HUD_ROW_HEIGHT;
      color row_fill = (row % 2 == 0 ? fill : fill_alt);
      string row_id = ASC_HUD_PREFIX + "row_card_" + IntegerToString(row);
      // Button that covers the row; its height matches the row height minus a
      // small padding (6px) to provide breathing room between rows.
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "row_" + IntegerToString(row),
                           "",
                           start_x,
                           y,
                           width,
                           ASC_HUD_ROW_HEIGHT - 6,
                           row_fill,
                           border,
                           text,
                           8);
      ASC_HUD_EnsurePanel(row_id + "_stripe",
                          start_x,
                          y,
                          4,
                          ASC_HUD_ROW_HEIGHT - 6,
                          (row % 2 == 0 ? C'76,173,255' : C'97,143,224'),
                          (row % 2 == 0 ? C'76,173,255' : C'97,143,224'));
      ASC_HUD_EnsureLabel(row_id + "_title",
                          "",
                          start_x + 12,
                          y + 8,
                          text,
                          9,
                          "Consolas");
      ASC_HUD_EnsureLabel(row_id + "_meta",
                          "",
                          start_x + 12,
                          y + (ASC_HUD_ROW_HEIGHT / 2),
                          muted,
                          8,
                          "Consolas");
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "row_action_" + IntegerToString(row),
                           "View",
                           start_x + width - 82,
                           y + 8,
                           70,
                           24,
                           fill_alt,
                           border,
                           text,
                           8);
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "row_hint_" + IntegerToString(row),
                          "",
                          start_x + width - 156,
                          y + 12,
                          muted,
                          8,
                          "Consolas");
     }
  }

void ASC_HUD_SetRowCard(const int row,
                        const string title,
                        const string meta,
                        const string hint,
                        const string action,
                        const int width)
  {
   string row_id = ASC_HUD_PREFIX + "row_card_" + IntegerToString(row);
   ObjectSetString(0, row_id + "_title", OBJPROP_TEXT, ASC_HUD_FitTextWidth(title, width - 190, 9, 10));
   ObjectSetString(0, row_id + "_meta", OBJPROP_TEXT, ASC_HUD_FitTextWidth(meta, width - 190, 8, 10));
   ObjectSetString(0, ASC_HUD_PREFIX + "row_hint_" + IntegerToString(row), OBJPROP_TEXT, hint);
   ObjectSetString(0, ASC_HUD_PREFIX + "row_action_" + IntegerToString(row), OBJPROP_TEXT, action);
   ObjectSetString(0, ASC_HUD_PREFIX + "row_" + IntegerToString(row), OBJPROP_TEXT, "");
  }

void ASC_HUD_HideRowCard(const int row)
  {
   string row_id = ASC_HUD_PREFIX + "row_card_" + IntegerToString(row);
   ASC_HUD_CollapsePanel(row_id + "_stripe", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(row_id + "_title", clrBlack);
   ASC_HUD_CollapseLabel(row_id + "_meta", clrBlack);
  }

void ASC_HUD_RenderShell(const ASC_RootRuntimeState &state,
                         const int heartbeat_count)
  {
   int chart_w = (int)ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0);
   int chart_h = (int)ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0);
   string signature = ASC_HUD_RenderSignature(state, chart_w, chart_h);
   if(!g_asc_hud_state.Dirty && signature == g_asc_hud_state.LastRenderSignature)
      return;
   if(chart_w < 1100) chart_w = 1100;
   if(chart_h < 700)  chart_h = 700;

   int margin = 10;
   int gap = 8;
   int padding = 8;
   // Adjusted layout metrics to provide more breathing room and stronger page identity.
   // Reduce top chrome height to reclaim vertical space.  The previous header
   // (88px) and navigation bar (68px) consumed too much of the screen.  A
   // compact header and nav improve overall content density while leaving
   // room for meaningful hierarchy.
   int header_h = 72;
   int nav_h = 48;
   int status_h = 40;
   int rail_w = 0;
   // Use the unified row height constant for all row calculations to ensure
   // layout and drawing routines stay in sync.
   int row_h = ASC_HUD_ROW_HEIGHT;

   int root_w = chart_w - (margin * 2);
   int root_h = chart_h - (margin * 2);
   int main_x = margin + padding;
   int main_y = margin + header_h + nav_h + (gap * 2);
   int main_h = chart_h - main_y - status_h - margin - (gap * 2);
   int content_w = chart_w - (margin * 2) - (padding * 2);
   int content_x = main_x;
   int rail_x = content_x + content_w + gap;
   int rail_y = main_y;
   int rail_h = main_h;
   int status_y = main_y + main_h + gap;
   int status_w = chart_w - (margin * 2) - (padding * 2);

   color background = C'7,12,20';
   color header = C'14,22,35';
   color panel = C'18,27,40';
   color panel_alt = C'26,39,58';
   color panel_soft = C'12,19,31';
   color accent = C'76,173,255';
   color accent_alt = C'97,143,224';
   color good = C'88,204,144';
   color warn = C'224,181,90';
   color danger = C'232,112,98';
   color reserved = C'104,112,136';
   color text = clrWhite;
   color muted = C'196,204,219';
   color dim = C'146,155,174';
   color border = C'56,73,98';
   color selected_fill = C'35,60,88';

   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "root", margin, margin, root_w, root_h, background, border);
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "header", margin, margin, root_w, header_h, header, border);
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "nav", margin, margin + header_h + gap, root_w, nav_h, panel_alt, border);
   ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "status", main_x, status_y, status_w, status_h, panel_alt, border);

   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "title", ASC_DEFAULT_PRODUCT_NAME + " v" + ASC_DEFAULT_PRODUCT_VERSION + "  Explorer Console", main_x + 4, margin + 10, text, 14, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "subtitle", "Live market console with preserved browse depth.", main_x + 4, margin + 30, muted, 9, "Consolas");
   // Collapse the old breadcrumb echo in the header.  The navigation bar below
   // already exposes the current path, so duplicating breadcrumbs here wastes
   // vertical space.  Keeping the label defined allows existing objects to be
   // reused, but collapsing it hides the visual echo.
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "crumbs", "", main_x + 4, margin + 50, accent, 9, "Consolas");
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "crumbs", clrBlack);

   int rows_top = main_y + 54;
   // Compute the available height for the list based on the unified row height
   // plus a small buffer (similar to legacy -70) to ensure buttons below fit.
   int rows_h = main_h - 70;
   int visible_rows = (rows_h / row_h);
   if(visible_rows > ASC_HUD_MAX_LIST_ROWS) visible_rows = ASC_HUD_MAX_LIST_ROWS;
   if(visible_rows < 5) visible_rows = 5;
   g_asc_hud_state.VisibleRowCapacity = visible_rows;
   g_asc_hud_state.CurrentListTotal = ASC_HUD_CurrentListTotal();
   int page_count = ASC_HUD_CurrentPageCount();
   if(g_asc_hud_state.ListPage >= page_count)
      g_asc_hud_state.ListPage = page_count - 1;
   if(g_asc_hud_state.ListPage < 0)
      g_asc_hud_state.ListPage = 0;
   bool can_page_prev = (g_asc_hud_state.ListPage > 0);
   bool can_page_next = ((g_asc_hud_state.ListPage + 1) < page_count);
   bool can_go_back = ASC_HUD_CanGoBack();
   bool can_open_symbol = ASC_HUD_CanOpenSymbolShortcut();
   bool can_open_stat = ASC_HUD_CanOpenStatShortcut();

   int nav_y = margin + header_h + gap + 8;
   int nav_x = main_x + 4;
   int top_button_h = 30;
   int top_gap = 8;
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_back", "Back", nav_x, nav_y, 78, top_button_h, (can_go_back ? panel : panel_soft), border, (can_go_back ? text : dim), 9);
   nav_x += 78 + top_gap;
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_overview", "Home", nav_x, nav_y, 84, top_button_h, (g_asc_hud_state.CurrentView == ASC_HUD_VIEW_OVERVIEW ? selected_fill : panel), border, text, 9);
   nav_x += 84 + top_gap;
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_buckets", "Buckets", nav_x, nav_y, 102, top_button_h, ((g_asc_hud_state.CurrentView == ASC_HUD_VIEW_MAIN_BUCKETS || g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS) ? selected_fill : panel), border, text, 9);
   nav_x += 102 + top_gap;
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_symbol", "Symbol", nav_x, nav_y, 94, top_button_h, ((g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOL_DETAIL) ? selected_fill : (can_open_symbol ? panel : panel_soft)), border, (can_open_symbol ? text : dim), 9);
   nav_x += 94 + top_gap;
   ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_stat", "Details", nav_x, nav_y, 94, top_button_h, ((g_asc_hud_state.CurrentView == ASC_HUD_VIEW_STAT_DETAIL) ? selected_fill : (can_open_stat ? panel : panel_soft)), border, (can_open_stat ? text : dim), 9);

   // ------------------------------------------------------------------------
   // Page controls in navigation bar
   // When the current view has more than one page, display Prev/Page/Next controls
   // in the top navigation bar.  This mirrors the older HUD behavior and
   // improves visibility of page navigation compared to the compact status bar.
   if(page_count > 1)
     {
      int page_ctrl_gap = 6;
      int page_ctrl_h   = top_button_h;
      int nav_ctrl_total_w = 60 + 80 + 60 + (page_ctrl_gap * 2); // prev + page + next + gaps
      // Align pagination controls to the right edge of the nav bar.  Use the
      // overall margin and root width so controls hug the root panel rather
      // than the content container (main_x includes padding).
      int nav_ctrl_x   = margin + root_w - nav_ctrl_total_w;
      int nav_prev_w   = 60;
      int nav_page_w   = 80;
      int nav_next_w   = 60;

      // Ensure previous, page label, and next controls inside nav bar
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_prev", "Prev", nav_ctrl_x, nav_y, nav_prev_w, page_ctrl_h, (can_page_prev ? panel : panel_soft), border, (can_page_prev ? text : dim), 9);
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "nav_page", "Page " + IntegerToString(g_asc_hud_state.ListPage + 1) + " / " + IntegerToString(page_count), nav_ctrl_x + nav_prev_w + page_ctrl_gap + 8, nav_y + 4, muted, 9, "Consolas");
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "nav_next", "Next", nav_ctrl_x + nav_prev_w + nav_page_w + (page_ctrl_gap * 2), nav_y, nav_next_w, page_ctrl_h, (can_page_next ? panel : panel_soft), border, (can_page_next ? text : dim), 9);
     }
   else
     {
      // Collapse page controls when not needed
      ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "nav_prev", clrBlack, clrBlack, clrBlack);
      ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "nav_next", clrBlack, clrBlack, clrBlack);
      ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "nav_page", clrBlack);
     }

   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "nav_prev", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "nav_page", clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "nav_next", clrBlack, clrBlack, clrBlack);

   string nav_current = ASC_HUD_ViewName(g_asc_hud_state.CurrentView) + " | " + ASC_HUD_FitTextTailWidth(ASC_HUD_BreadcrumbText(), root_w - 320, 9, 20);
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "nav_current", nav_current, main_x + 4, nav_y + 34, muted, 9, "Consolas");

   ASC_HUD_PrepareRows(content_x + 4,
                       rows_top,
                       content_w - 8,
                       panel,
                       panel_alt,
                       border,
                       text,
                       dim);

   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "rail", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "rail_title", clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "rail_home", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "rail_back", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "rail_overview", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "rail_buckets", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "rail_symbol", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "rail_stat", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "rail_focus", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "rail_focus_text", clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "rail_actions", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "rail_actions_title", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "rail_actions_text", clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "rail_focus_footer", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "rail_focus_footer_text", clrBlack);

   // defaults: hide detail sections and overview cards until needed
   ASC_HUD_HideOverviewHero();
   ASC_HUD_HideSectionPanel("sec_a");
   ASC_HUD_HideSectionPanel("sec_b");
   ASC_HUD_HideSectionPanel("sec_c");
   ASC_HUD_HideSectionPanel("sec_d");
   for(int i = 0; i < ASC_HUD_OVERVIEW_BUCKET_COUNT; i++)
      ASC_HUD_HideOverviewCard(i);
   for(int i = 0; i < ASC_HUD_OVERVIEW_BUCKET_COUNT; i++)
      ASC_HUD_HideMainBucketCard(i);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "main_bucket_hero", clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "main_bucket_hero_bar", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "main_bucket_hero_l2", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "main_bucket_hero_l3", clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "symbol_hero", clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "symbol_hero_bar", clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "symbol_hero_title", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "symbol_hero_l1", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "symbol_hero_l2", clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "symbol_hero_l3", clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "stat_panel", clrBlack, clrBlack);
   ASC_HUD_CollapsePanel(ASC_HUD_PREFIX + "stat_panel_bar", clrBlack, clrBlack);
   ASC_HUD_HideDetailGridPanel("detail_a");
   ASC_HUD_HideDetailGridPanel("detail_b");
   ASC_HUD_HideDetailGridPanel("detail_c");
   ASC_HUD_HideDetailGridPanel("detail_d");

   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_title", ASC_HUD_FitTextWidth(ASC_HUD_ViewName(g_asc_hud_state.CurrentView), content_w - 12, 11, 12), content_x + 4, main_y - 2, text, 11, "Consolas");
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", "", content_x + 4, main_y + 18, muted, 9, "Consolas");

   for(int row = 0; row < ASC_HUD_MAX_LIST_ROWS; row++)
     {
      string row_id = ASC_HUD_PREFIX + "row_" + IntegerToString(row);
      string row_hint_id = ASC_HUD_PREFIX + "row_hint_" + IntegerToString(row);
      string row_action_id = ASC_HUD_PREFIX + "row_action_" + IntegerToString(row);
      int list_visible_rows = visible_rows;
      if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS || g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS)
        {
         int remaining = g_asc_hud_state.CurrentListTotal - (g_asc_hud_state.ListPage * visible_rows);
         if(remaining < list_visible_rows)
            list_visible_rows = remaining;
         if(list_visible_rows < 0)
            list_visible_rows = 0;
        }

      if(row < list_visible_rows && (g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS || g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS))
        {
         int row_y = rows_top + row * row_h;
         color fill = ((row % 2) == 0 ? panel : panel_alt);
         // Use unified row height for list rows to eliminate mismatched layout/painting.
         ASC_HUD_EnsureButton(row_id, "", content_x + 4, row_y, content_w - 8, ASC_HUD_ROW_HEIGHT - 6, fill, border, text, 8);
         ASC_HUD_EnsureButton(row_action_id, "View", content_x + content_w - 86, row_y + 8, 70, 24, panel_soft, border, text, 8);
         ASC_HUD_EnsureLabel(row_hint_id, "", content_x + content_w - 162, row_y + 12, dim, 8, "Consolas");
        }
      else
        {
         ASC_HUD_CollapseButton(row_id, clrBlack, clrBlack, clrBlack);
         ASC_HUD_CollapseButton(row_action_id, clrBlack, clrBlack, clrBlack);
         ASC_HUD_CollapseLabel(row_hint_id, clrBlack);
         ASC_HUD_HideRowCard(row);
        }
      ObjectSetString(0, row_id, OBJPROP_TEXT, "");
      ObjectSetString(0, row_hint_id, OBJPROP_TEXT, "");
     }

   // Overview
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_OVERVIEW)
     {
      int gap2 = gap;
      int hero_h = 74;
      int summary_w = (content_w - gap2) / 2;
      int summary_h = 80;
      int hero_y = main_y + 4;
      int summary_y = hero_y + hero_h + gap2;
      string last_heartbeat = (state.Runtime.PhaseMarkers.LastHeartbeatAt > 0 ? TimeToString(state.Runtime.PhaseMarkers.LastHeartbeatAt, TIME_DATE | TIME_SECONDS) : "Pending");
      string last_summary = (state.Layer1.LastSummaryPublishAt > 0 ? TimeToString(state.Layer1.LastSummaryPublishAt, TIME_DATE | TIME_SECONDS) : "Pending");
      string last_write = (state.Runtime.PhaseMarkers.LastStructuralCommitAt > 0 ? TimeToString(state.Runtime.PhaseMarkers.LastStructuralCommitAt, TIME_DATE | TIME_SECONDS) : "Pending");

      ASC_HUD_OverviewHero(state, heartbeat_count, content_x, hero_y, content_w, hero_h, panel_soft, border, (state.Publication.OutputReady ? good : warn), text, muted, dim);

      ASC_HUD_SectionPanel("sec_a",
                           "Runtime",
                           "Heartbeat " + IntegerToString(heartbeat_count) + " | Scan " + IntegerToString(state.Layer1.LastScanDurationMilliseconds) + " ms",
                           "Last heartbeat " + last_heartbeat,
                           "Server " + state.Runtime.Identity.ServerName,
                           content_x, summary_y, summary_w, summary_h, false, panel, border, accent, text, muted);

      ASC_HUD_SectionPanel("sec_b",
                           "Universe",
                           "Tracked " + IntegerToString(state.Layer1.TotalSymbols) + " | Open " + IntegerToString(state.Layer1.OpenCount),
                           "Closed " + IntegerToString(state.Layer1.ClosedCount) + " | Market Watch " + IntegerToString(state.Layer1.UncertainCount),
                           "Unknown " + IntegerToString(state.Layer1.UnknownCount) + " | Grouped " + IntegerToString(state.Layer1.ResolvedClassificationCount),
                           content_x + summary_w + gap2, summary_y, summary_w, summary_h, false, panel, border, accent_alt, text, muted);

      ASC_HUD_SectionPanel("sec_c",
                           "Coverage",
                           "Fresh " + IntegerToString(state.Layer1.FreshCount) + " | Stale " + IntegerToString(state.Layer1.StaleCount),
                           "Complete " + IntegerToString(state.Layer1.CompleteCount) + " | Partial " + IntegerToString(state.Layer1.PartialCount),
                           "Grouped " + IntegerToString(state.Layer1.ResolvedClassificationCount) + " | Unresolved " + IntegerToString(state.Layer1.UnknownClassificationCount),
                           content_x, summary_y + summary_h + gap2, summary_w, summary_h, false, panel, border, warn, text, muted);

      ASC_HUD_SectionPanel("sec_d",
                           "Publication",
                           (state.Publication.OutputReady ? "Output ready" : "Output waiting"),
                           "Summary " + last_summary,
                           "Last write " + last_write,
                           content_x + summary_w + gap2, summary_y + summary_h + gap2, summary_w, summary_h, false, panel, border, good, text, muted);

      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", "", content_x + 4, main_y + 18, muted, 9, "Consolas");
     }
   else if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_MAIN_BUCKETS)
     {
      int hero_h = 86;
      int gap2 = gap;
      int card_w = (content_w - gap2) / 2;
      int card_h = 104;
      int cards_y = main_y + hero_h + gap2;

      ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "main_bucket_hero", content_x, main_y, content_w, hero_h, panel_soft, border);
      ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "main_bucket_hero_bar", content_x, main_y, 6, hero_h, accent, accent);
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_title", ASC_HUD_FitTextWidth("Main Buckets", content_w - 16, 11, 8), content_x + 12, main_y + 8, text, 11, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", ASC_HUD_FitTextWidth("Open a bucket to move into its real sub-buckets. This page stays structural and does not flatten the browse tree.", content_w - 16, 9, 8), content_x + 12, main_y + 28, muted, 9, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "main_bucket_hero_l2", ASC_HUD_FitTextWidth("Grouped buckets " + IntegerToString(ASC_HUD_MainBucketCount()) + " | Classified symbols " + IntegerToString(state.Layer1.ResolvedClassificationCount) + " | Unclassified " + IntegerToString(state.Layer1.UnknownClassificationCount), content_w - 16, 9, 8), content_x + 12, main_y + 46, accent_alt, 9, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "main_bucket_hero_l3", ASC_HUD_FitTextWidth("Open leaders " + IntegerToString(state.Layer1.OpenCount) + " | Closed " + IntegerToString(state.Layer1.ClosedCount) + " | Market Watch " + IntegerToString(state.Layer1.UncertainCount), content_w - 16, 9, 8), content_x + 12, main_y + 62, dim, 9, "Consolas");

      for(int row = 0; row < visible_rows; row++)
        {
         ObjectSetString(0, ASC_HUD_PREFIX + "row_" + IntegerToString(row), OBJPROP_TEXT, "");
         ObjectSetString(0, ASC_HUD_PREFIX + "row_hint_" + IntegerToString(row), OBJPROP_TEXT, "");
        }

      for(int i = 0; i < ASC_HUD_MainBucketCount() && i < ASC_HUD_OVERVIEW_BUCKET_COUNT; i++)
        {
         int col = (i % 2);
         int row = (i / 2);
         int x = content_x + col * (card_w + gap2);
         int y = cards_y + row * (card_h + gap2);
         if(y + card_h > status_y - 4)
            break;

         color card_fill = ((row % 2) == 0 ? panel : panel_alt);
         color card_accent = accent_alt;
         if(g_asc_hud_main_buckets[i].Open > 0)
            card_accent = good;
         else if(g_asc_hud_main_buckets[i].Watch > 0 || g_asc_hud_main_buckets[i].Unknown > 0)
            card_accent = warn;
         else if(g_asc_hud_main_buckets[i].Closed > 0)
            card_accent = danger;

         ASC_HUD_MainBucketActionCard(i,
                                      g_asc_hud_main_buckets[i],
                                      x,
                                      y,
                                      card_w,
                                      card_h,
                                      card_fill,
                                      border,
                                      card_accent,
                                      text,
                                      muted,
                                      dim);
        }
     }
   else if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS)
     {
      int total = ASC_HUD_ActiveSubBucketCount();
      int start = g_asc_hud_state.ListPage * visible_rows;
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_title", ASC_HUD_FitTextWidth(ASC_HUD_MainBucketName(g_asc_hud_state.SelectedBucketId), content_w - 12, 11, 12), content_x + 4, main_y - 2, text, 11, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", ASC_HUD_FitTextWidth("Choose a sub-bucket to open its symbol list. The page keeps the same browse path and layout.", content_w - 12, 9, 8), content_x + 4, main_y + 18, muted, 9, "Consolas");
      for(int row = 0; row < visible_rows; row++)
        {
         int pos = start + row;
         if(pos >= total)
            break;
         int idx = g_asc_hud_active_sub_bucket_indices[pos];
         ASC_HUDSubBucket active_bucket = g_asc_hud_sub_buckets[idx];
         ASC_HUD_SetRowCard(row,
                           active_bucket.Name,
                           "Symbols " + IntegerToString(active_bucket.Total) + " | Open " + IntegerToString(active_bucket.Open) + " | Closed " + IntegerToString(active_bucket.Closed) + " | Market Watch " + IntegerToString(active_bucket.Watch),
                           "Symbol List",
                           "View",
                           content_w);
        }
     }
   else if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS)
     {
      int total = ASC_HUD_ActiveSymbolCount();
      int start = g_asc_hud_state.ListPage * visible_rows;
      string sub_name = ASC_HUD_SubBucketNameByKey(g_asc_hud_state.SelectedSubBucketKey);
      if(sub_name == "")
         sub_name = "Symbols";
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_title", ASC_HUD_FitTextWidth(sub_name, content_w - 12, 11, 12), content_x + 4, main_y - 2, text, 11, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", ASC_HUD_FitTextWidth("Choose a symbol to open its market view.", content_w - 12, 9, 8), content_x + 4, main_y + 18, muted, 9, "Consolas");
      for(int row = 0; row < visible_rows; row++)
        {
         int pos = start + row;
         if(pos >= total)
            break;
         int idx = g_asc_hud_active_symbol_indices[pos];
         ASC_HUDSymbolEntry entry = g_asc_hud_symbols[idx];
         ASC_MarketStateRecord record = g_asc_layer1_records[entry.RecordIndex];
         string status_meta = ASC_HUD_MarketText(record.MarketState) + " | " + ASC_HUD_FreshnessText(record.Freshness) + " | " + ASC_HUD_FormatAgeText(record.ObservedAt, TimeCurrent());
         if(entry.DisplayName != "" && entry.DisplayName != entry.DisplaySymbol)
            status_meta += " | " + entry.DisplayName;
         ASC_HUD_SetRowCard(row,
                           entry.DisplaySymbol,
                           status_meta,
                           "Market View",
                           "Open",
                           content_w);
        }
     }
   else if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOL_DETAIL)
     {
      ASC_MarketStateRecord record = ASC_HUD_SelectedRecord();
      int gap2 = gap;
      int hero_h = 92;
      int section_w = (content_w - gap2) / 2;
      int section_h = 102;
      int base_y = main_y + hero_h + gap2;

      string symbol_name = (record.Identity.DisplaySymbol == "" ? g_asc_hud_state.SelectedSymbolKey : record.Identity.DisplaySymbol);
      ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "symbol_hero", content_x, main_y, content_w, hero_h, panel_soft, border);
      ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "symbol_hero_bar", content_x, main_y, 5, hero_h, accent, accent);
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "symbol_hero_title", ASC_HUD_FitTextWidth(symbol_name, content_w - 28, 11, 8), content_x + 14, main_y + 8, text, 11, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "symbol_hero_l1", ASC_HUD_FitTextWidth(record.Identity.DisplayName, content_w - 28, 9, 8), content_x + 14, main_y + 30, muted, 9, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "symbol_hero_l2", ASC_HUD_FitTextWidth("Market " + ASC_HUD_MarketText(record.MarketState) + " | Freshness " + ASC_HUD_FreshnessText(record.Freshness) + " | Completeness " + ASC_HUD_CompletenessText(record.Completeness), content_w - 28, 9, 8), content_x + 14, main_y + 48, dim, 9, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "symbol_hero_l3", ASC_HUD_FitTextWidth("Observed " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS) + " | Classification " + (record.Identity.ClassificationResolved ? "Resolved" : "Unresolved"), content_w - 28, 9, 8), content_x + 14, main_y + 66, dim, 9, "Consolas");

      ASC_HUD_SectionPanel("sec_a", "Identity", "Symbol " + symbol_name, "Canonical " + record.Identity.CanonicalSymbol, "Asset Class " + record.Identity.AssetClass, content_x, base_y, section_w, section_h, false, panel, border, accent, text, muted);
      ASC_HUD_SectionPanel("sec_b", "Grouping", "Main Bucket " + record.Identity.MainGroup, "Sub-Bucket " + record.Identity.SubGroup, "Theme " + record.Identity.ThemeBucket, content_x + section_w + gap2, base_y, section_w, section_h, false, panel, border, accent_alt, text, muted);
      ASC_HUD_SectionPanel("sec_c", "Market Status", "Posture " + ASC_HUD_MarketText(record.MarketState), "Freshness " + ASC_HUD_FreshnessText(record.Freshness), "Completeness " + ASC_HUD_CompletenessText(record.Completeness), content_x, base_y + section_h + gap2, section_w, section_h, false, panel, border, good, text, muted);
      ASC_HUD_SectionPanel("sec_d", "Publication", "Published " + (record.PublishedOnce ? "Yes" : "No"), "Last Published " + TimeToString(record.LastPublishedAt, TIME_DATE | TIME_SECONDS), "Output Ready " + (state.Publication.OutputReady ? "Yes" : "No"), content_x + section_w + gap2, base_y + section_h + gap2, section_w, section_h, false, panel, border, warn, text, muted);

      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "stat_summary", "Summary", content_x + section_w - 84, base_y + section_h - 28, 74, 22, panel_alt, border, text, 8);
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "stat_classification", "View", content_x + content_w - 84, base_y + section_h - 28, 74, 22, panel_alt, border, text, 8);
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "stat_market", "View", content_x + section_w - 84, base_y + section_h + gap2 + section_h - 28, 74, 22, panel_alt, border, text, 8);
      ASC_HUD_EnsureButton(ASC_HUD_PREFIX + "stat_runtime", "View", content_x + content_w - 84, base_y + section_h + gap2 + section_h - 28, 74, 22, panel_alt, border, text, 8);

      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", ASC_HUD_FitTextWidth(record.StatusReason, content_w - 12, 9, 8), content_x + 4, base_y + (section_h + gap2) * 2 + 8, muted, 9, "Consolas");
     }
   else if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_STAT_DETAIL)
     {
      ASC_MarketStateRecord record = ASC_HUD_SelectedRecord();
      int hero_h = 62;
      int card_gap = gap;
      int card_w = (content_w - card_gap) / 2;
      int card_h = 108;
      int cards_y = main_y + hero_h + card_gap;
      ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "stat_panel", content_x, main_y, content_w, main_h - 4, panel, border);
      ASC_HUD_EnsurePanel(ASC_HUD_PREFIX + "stat_panel_bar", content_x, main_y, 5, hero_h, accent_alt, accent_alt);
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_title", ASC_HUD_FitTextWidth(ASC_HUD_StatName(g_asc_hud_state.CurrentStatView), content_w - 20, 11, 8), content_x + 14, main_y + 8, text, 11, "Consolas");
      ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "content_text", ASC_HUD_FitTextWidth(record.Identity.DisplaySymbol + " | " + record.Identity.DisplayName, content_w - 20, 9, 8), content_x + 14, main_y + 30, muted, 9, "Consolas");

      if(g_asc_hud_state.CurrentStatView == ASC_HUD_STAT_SUMMARY)
        {
         ASC_HUD_DetailGridPanel("detail_a", "Identity", "Symbol " + record.Identity.DisplaySymbol, "Name " + record.Identity.DisplayName, "Canonical " + record.Identity.CanonicalSymbol, "Asset Class " + record.Identity.AssetClass, content_x, cards_y, card_w, card_h, panel_soft, border, accent, text, muted);
         ASC_HUD_DetailGridPanel("detail_b", "Grouping", "Main Bucket " + record.Identity.MainGroup, "Sub-Bucket " + record.Identity.SubGroup, "Theme " + record.Identity.ThemeBucket, "Classification " + (record.Identity.ClassificationResolved ? "Resolved" : "Review Needed"), content_x + card_w + card_gap, cards_y, card_w, card_h, panel_soft, border, accent_alt, text, muted);
         ASC_HUD_DetailGridPanel("detail_c", "Market Status", "State " + ASC_HUD_MarketText(record.MarketState), "Freshness " + ASC_HUD_FreshnessText(record.Freshness), "Completeness " + ASC_HUD_CompletenessText(record.Completeness), "Observed " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS), content_x, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, good, text, muted);
         ASC_HUD_DetailGridPanel("detail_d", "Publication", "Published " + (record.PublishedOnce ? "Yes" : "No"), "Last Published " + TimeToString(record.LastPublishedAt, TIME_DATE | TIME_SECONDS), "Output Ready " + (state.Publication.OutputReady ? "Yes" : "No"), "Summary Update " + TimeToString(state.Layer1.LastSummaryPublishAt, TIME_DATE | TIME_SECONDS), content_x + card_w + card_gap, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, warn, text, muted);
        }
      else if(g_asc_hud_state.CurrentStatView == ASC_HUD_STAT_CLASSIFICATION)
        {
         ASC_HUD_DetailGridPanel("detail_a", "Classification", "Resolved " + (record.Identity.ClassificationResolved ? "Yes" : "No"), "Confidence " + record.Identity.ClassificationConfidence, "Review " + record.Identity.ClassificationReviewStatus, "Source " + record.Identity.ClassificationSource, content_x, cards_y, card_w, card_h, panel_soft, border, accent, text, muted);
         ASC_HUD_DetailGridPanel("detail_b", "Structure", "Main Bucket " + record.Identity.MainGroup, "Sub-Bucket " + record.Identity.SubGroup, "Sector " + record.Identity.Sector, "Industry " + record.Identity.Industry, content_x + card_w + card_gap, cards_y, card_w, card_h, panel_soft, border, accent_alt, text, muted);
         ASC_HUD_DetailGridPanel("detail_c", "Theme", "Theme " + record.Identity.ThemeBucket, "Subtype " + record.Identity.Subtype, "Canonical " + record.Identity.CanonicalSymbol, "Display " + record.Identity.DisplaySymbol, content_x, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, good, text, muted);
         ASC_HUD_DetailGridPanel("detail_d", "Classification Note", record.Identity.ClassificationNote, "", "", "", content_x + card_w + card_gap, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, warn, text, muted);
        }
      else if(g_asc_hud_state.CurrentStatView == ASC_HUD_STAT_MARKET_STATUS)
        {
         ASC_HUD_DetailGridPanel("detail_a", "Current State", "State " + ASC_HUD_MarketText(record.MarketState), "Freshness " + ASC_HUD_FreshnessText(record.Freshness), "Completeness " + ASC_HUD_CompletenessText(record.Completeness), "Observed " + TimeToString(record.ObservedAt, TIME_DATE | TIME_SECONDS), content_x, cards_y, card_w, card_h, panel_soft, border, accent, text, muted);
         ASC_HUD_DetailGridPanel("detail_b", "Publication", "Published " + (record.PublishedOnce ? "Yes" : "No"), "Last Published " + TimeToString(record.LastPublishedAt, TIME_DATE | TIME_SECONDS), "Summary Update " + TimeToString(state.Layer1.LastSummaryPublishAt, TIME_DATE | TIME_SECONDS), "Output Ready " + (state.Publication.OutputReady ? "Yes" : "No"), content_x + card_w + card_gap, cards_y, card_w, card_h, panel_soft, border, accent_alt, text, muted);
         ASC_HUD_DetailGridPanel("detail_c", "Reason", record.StatusReason, "", "", "", content_x, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, good, text, muted);
         ASC_HUD_DetailGridPanel("detail_d", "Coverage", "Open " + IntegerToString(state.Layer1.OpenCount), "Closed " + IntegerToString(state.Layer1.ClosedCount), "Market Watch " + IntegerToString(state.Layer1.UncertainCount), "Grouped " + IntegerToString(state.Layer1.ResolvedClassificationCount), content_x + card_w + card_gap, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, warn, text, muted);
        }
      else
        {
         ASC_HUD_DetailGridPanel("detail_a", "Runtime Session", "Session " + state.Runtime.Identity.RuntimeSessionId, "Started " + TimeToString(state.Runtime.Identity.StartedAt, TIME_DATE | TIME_SECONDS), "Last Heartbeat " + TimeToString(state.Runtime.PhaseMarkers.LastHeartbeatAt, TIME_DATE | TIME_SECONDS), "Scan Time " + IntegerToString(state.Layer1.LastScanDurationMilliseconds) + " ms", content_x, cards_y, card_w, card_h, panel_soft, border, accent, text, muted);
         ASC_HUD_DetailGridPanel("detail_b", "Runtime Flow", "Last Write " + TimeToString(state.Runtime.PhaseMarkers.LastStructuralCommitAt, TIME_DATE | TIME_SECONDS), "Last Read " + TimeToString(state.Runtime.PhaseMarkers.LastStructuralConsumeAt, TIME_DATE | TIME_SECONDS), "Output Ready " + (state.Publication.OutputReady ? "Yes" : "No"), "Server " + state.Runtime.Identity.ServerName, content_x + card_w + card_gap, cards_y, card_w, card_h, panel_soft, border, accent_alt, text, muted);
         ASC_HUD_DetailGridPanel("detail_c", "Publication Root", state.Publication.OutputRoot, "", "", "", content_x, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, good, text, muted);
         ASC_HUD_DetailGridPanel("detail_d", "Universe", "Tracked " + IntegerToString(state.Layer1.TotalSymbols), "Open " + IntegerToString(state.Layer1.OpenCount), "Closed " + IntegerToString(state.Layer1.ClosedCount), "Market Watch " + IntegerToString(state.Layer1.UncertainCount), content_x + card_w + card_gap, cards_y + card_h + card_gap, card_w, card_h, panel_soft, border, warn, text, muted);
        }
     }

   // Collapse pager controls in the status bar.  Pagination controls are now
   // presented in the navigation bar for better visibility.  Keep the
   // definitions here in case future passes need to restore the bottom pager.
   int pager_y = status_y + 4;
   int pager_button_w = 76;
   int pager_label_w = 124;
   int pager_next_x = main_x + status_w - pager_button_w;
   int pager_label_x = pager_next_x - pager_label_w - 8;
   int pager_prev_x = pager_label_x - pager_button_w - 8;
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "nav_prev", clrBlack, clrBlack, clrBlack);
   ASC_HUD_CollapseLabel(ASC_HUD_PREFIX + "nav_page", clrBlack);
   ASC_HUD_CollapseButton(ASC_HUD_PREFIX + "nav_next", clrBlack, clrBlack, clrBlack);

   string status = (state.Publication.OutputReady ? "Runtime active" : "Waiting for output landing")
                   + " | Open " + IntegerToString(state.Layer1.OpenCount)
                   + " | Closed " + IntegerToString(state.Layer1.ClosedCount)
                   + " | Market Watch " + IntegerToString(state.Layer1.UncertainCount)
                   + " | Grouped " + IntegerToString(state.Layer1.ResolvedClassificationCount)
                   + " | Scan " + IntegerToString(state.Layer1.LastScanDurationMilliseconds) + " ms";
   ASC_HUD_EnsureLabel(ASC_HUD_PREFIX + "status_text", ASC_HUD_FitTextWidth(status, status_w - 250, 9, 8), main_x + 10, status_y + 8, text, 9, "Consolas");

   ChartRedraw();
   g_asc_hud_state.Dirty = false;
   g_asc_hud_state.Visible = true;
   g_asc_hud_state.LastRenderSignature = signature;
  }

void ASC_HUD_ClearStatus()
  {
   ASC_HUD_DeletePrefixedObjects();
   Comment("");
   ASC_HUD_ResetState();
  }

void ASC_HUD_ShowStatus(const ASC_RootRuntimeState &state,
                        const int heartbeat_count,
                        const bool comment_enabled)
  {
   if(!comment_enabled)
     {
      ASC_HUD_ClearStatus();
      return;
     }

   if(!g_asc_hud_state.Visible && g_asc_hud_state.LastRenderSignature == "")
      ASC_HUD_ResetState();

   bool browse_changed = (g_asc_hud_state.LastDataSignature != g_asc_hud_browse_signature);
   if(browse_changed)
     {
      g_asc_hud_state.LastDataSignature = g_asc_hud_browse_signature;
      g_asc_hud_state.Dirty = true;
     }

   ASC_HUD_PrepareActiveBrowse(g_asc_hud_state.SelectedBucketId, g_asc_hud_state.SelectedSubBucketKey);
   if(g_asc_hud_state.SelectedSymbolKey != "" && !ASC_HUD_BrowseHasSymbolKey(g_asc_hud_state.SelectedSymbolKey))
      g_asc_hud_state.SelectedSymbolKey = ASC_HUD_FirstActiveSymbolKey();

   ASC_HUD_RenderShell(state, heartbeat_count);
  }

void ASC_HUD_OpenOverview()
  {
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_OVERVIEW;
   g_asc_hud_state.ListPage = 0;
   g_asc_hud_state.Dirty = true;
   ASC_HUD_Log("nav", "opened overview");
  }

void ASC_HUD_OpenBuckets()
  {
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_MAIN_BUCKETS;
   g_asc_hud_state.ListPage = 0;
   g_asc_hud_state.Dirty = true;
   ASC_HUD_Log("nav", "opened main buckets");
  }

void ASC_HUD_OpenSubBuckets(const string bucket_id)
  {
   g_asc_hud_state.SelectedBucketId = bucket_id;
   g_asc_hud_state.SelectedSubBucketKey = "";
   ASC_HUD_PrepareActiveBrowse(bucket_id, "");
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_SUB_BUCKETS;
   g_asc_hud_state.ListPage = 0;
   g_asc_hud_state.Dirty = true;
   ASC_HUD_Log("nav", "opened sub-buckets for " + bucket_id);
  }

void ASC_HUD_OpenSymbols(const string bucket_id,
                         const string sub_bucket_key)
  {
   g_asc_hud_state.SelectedBucketId = bucket_id;
   g_asc_hud_state.SelectedSubBucketKey = sub_bucket_key;
   ASC_HUD_PrepareActiveBrowse(bucket_id, sub_bucket_key);
   if(g_asc_hud_state.SelectedSymbolKey == "" || !ASC_HUD_BrowseHasSymbolKey(g_asc_hud_state.SelectedSymbolKey))
      g_asc_hud_state.SelectedSymbolKey = ASC_HUD_FirstActiveSymbolKey();
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_SYMBOLS;
   g_asc_hud_state.ListPage = 0;
   g_asc_hud_state.Dirty = true;
   ASC_HUD_Log("nav", "opened symbols for " + sub_bucket_key);
  }

void ASC_HUD_OpenSymbolDetail(const string symbol_key)
  {
   g_asc_hud_state.SelectedSymbolKey = symbol_key;
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_SYMBOL_DETAIL;
   g_asc_hud_state.Dirty = true;
   ASC_HUD_Log("nav", "opened symbol detail for " + symbol_key);
  }

void ASC_HUD_OpenStatDetail(const ASC_HUDStatView stat_view)
  {
   g_asc_hud_state.CurrentStatView = stat_view;
   g_asc_hud_state.CurrentView = ASC_HUD_VIEW_STAT_DETAIL;
   g_asc_hud_state.Dirty = true;
   ASC_HUD_Log("nav", "opened stat detail " + ASC_HUD_StatName(stat_view));
  }

void ASC_HUD_PageDelta(const int delta)
  {
   int max_page = ASC_HUD_CurrentPageCount() - 1;
   if(max_page < 0)
      max_page = 0;

   int next_page = g_asc_hud_state.ListPage + delta;
   if(next_page < 0)
      next_page = 0;
   if(next_page > max_page)
      next_page = max_page;

   if(next_page != g_asc_hud_state.ListPage)
     {
      g_asc_hud_state.ListPage = next_page;
      g_asc_hud_state.Dirty = true;
      ASC_HUD_Log("nav", "changed page to " + IntegerToString(next_page + 1) + " of " + IntegerToString(max_page + 1));
     }
  }

void ASC_HUD_Back()
  {
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_STAT_DETAIL)
     {
      g_asc_hud_state.CurrentView = ASC_HUD_VIEW_SYMBOL_DETAIL;
      g_asc_hud_state.Dirty = true;
      ASC_HUD_Log("nav", "returned to symbol detail");
      return;
     }
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOL_DETAIL)
     {
      g_asc_hud_state.CurrentView = ASC_HUD_VIEW_SYMBOLS;
      g_asc_hud_state.Dirty = true;
      ASC_HUD_Log("nav", "returned to symbols");
      return;
     }
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS)
     {
      g_asc_hud_state.CurrentView = ASC_HUD_VIEW_SUB_BUCKETS;
      g_asc_hud_state.ListPage = 0;
      g_asc_hud_state.Dirty = true;
      ASC_HUD_Log("nav", "returned to sub-buckets");
      return;
     }
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS)
     {
      g_asc_hud_state.CurrentView = ASC_HUD_VIEW_MAIN_BUCKETS;
      g_asc_hud_state.ListPage = 0;
      g_asc_hud_state.Dirty = true;
      ASC_HUD_Log("nav", "returned to main buckets");
      return;
     }
   if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_MAIN_BUCKETS)
     {
      ASC_HUD_OpenOverview();
      return;
     }
  }

void ASC_HUD_HandleChartEvent(const int id,
                              const long &lparam,
                              const double &dparam,
                              const string &sparam)
  {
   if(id != CHARTEVENT_OBJECT_CLICK)
      return;

   if(sparam == ASC_HUD_PREFIX + "nav_overview" || sparam == ASC_HUD_PREFIX + "rail_home" || sparam == ASC_HUD_PREFIX + "rail_overview") { ASC_HUD_OpenOverview(); return; }
   if(sparam == ASC_HUD_PREFIX + "nav_buckets" || sparam == ASC_HUD_PREFIX + "rail_buckets")  { ASC_HUD_OpenBuckets(); return; }
   if(sparam == ASC_HUD_PREFIX + "nav_back" || sparam == ASC_HUD_PREFIX + "rail_back")     { if(ASC_HUD_CanGoBack()) ASC_HUD_Back(); return; }
   if(sparam == ASC_HUD_PREFIX + "nav_prev")     { ASC_HUD_PageDelta(-1); return; }
   if(sparam == ASC_HUD_PREFIX + "nav_next")     { ASC_HUD_PageDelta(1); return; }
   if(sparam == ASC_HUD_PREFIX + "nav_symbol" || sparam == ASC_HUD_PREFIX + "rail_symbol")
     {
      if(ASC_HUD_CanOpenSymbolShortcut())
         ASC_HUD_OpenSymbolDetail(g_asc_hud_state.SelectedSymbolKey);
      return;
     }
   if(sparam == ASC_HUD_PREFIX + "nav_stat" || sparam == ASC_HUD_PREFIX + "rail_stat")
     {
      if(ASC_HUD_CanOpenStatShortcut())
        {
         if(g_asc_hud_state.CurrentView != ASC_HUD_VIEW_STAT_DETAIL)
            g_asc_hud_state.CurrentStatView = ASC_HUD_STAT_SUMMARY;
         ASC_HUD_OpenStatDetail(g_asc_hud_state.CurrentStatView);
        }
      return;
     }
   if(sparam == ASC_HUD_PREFIX + "stat_summary")        { ASC_HUD_OpenStatDetail(ASC_HUD_STAT_SUMMARY); return; }
   if(sparam == ASC_HUD_PREFIX + "stat_classification") { ASC_HUD_OpenStatDetail(ASC_HUD_STAT_CLASSIFICATION); return; }
   if(sparam == ASC_HUD_PREFIX + "stat_market")         { ASC_HUD_OpenStatDetail(ASC_HUD_STAT_MARKET_STATUS); return; }
   if(sparam == ASC_HUD_PREFIX + "stat_runtime")        { ASC_HUD_OpenStatDetail(ASC_HUD_STAT_RUNTIME); return; }

   for(int i = 0; i < ASC_HUD_OVERVIEW_BUCKET_COUNT; i++)
     {
      if((sparam == ASC_HUD_PREFIX + "bucket_card_" + IntegerToString(i)
          || sparam == ASC_HUD_PREFIX + "bucket_open_" + IntegerToString(i)
          || sparam == ASC_HUD_PREFIX + "main_bucket_card_" + IntegerToString(i)
          || sparam == ASC_HUD_PREFIX + "main_bucket_open_" + IntegerToString(i))
         && i < ASC_HUD_MainBucketCount())
        {
         ASC_HUD_OpenSubBuckets(g_asc_hud_main_buckets[i].Id);
         return;
        }
     }

   for(int row = 0; row < ASC_HUD_MAX_LIST_ROWS; row++)
     {
      if(sparam != ASC_HUD_PREFIX + "row_" + IntegerToString(row)
         && sparam != ASC_HUD_PREFIX + "row_action_" + IntegerToString(row))
         continue;

      if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_MAIN_BUCKETS)
        {
         int pos = g_asc_hud_state.ListPage * g_asc_hud_state.VisibleRowCapacity + row;
         if(pos >= 0 && pos < ASC_HUD_MainBucketCount())
            ASC_HUD_OpenSubBuckets(g_asc_hud_main_buckets[pos].Id);
         return;
        }

      if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SUB_BUCKETS)
        {
         int count = ASC_HUD_ActiveSubBucketCount();
         int pos = g_asc_hud_state.ListPage * g_asc_hud_state.VisibleRowCapacity + row;
         if(pos >= 0 && pos < count)
            ASC_HUD_OpenSymbols(g_asc_hud_state.SelectedBucketId, g_asc_hud_sub_buckets[g_asc_hud_active_sub_bucket_indices[pos]].Key);
         return;
        }

      if(g_asc_hud_state.CurrentView == ASC_HUD_VIEW_SYMBOLS)
        {
         int count = ASC_HUD_ActiveSymbolCount();
         int pos = g_asc_hud_state.ListPage * g_asc_hud_state.VisibleRowCapacity + row;
         if(pos >= 0 && pos < count)
            ASC_HUD_OpenSymbolDetail(g_asc_hud_symbols[g_asc_hud_active_symbol_indices[pos]].SymbolKey);
         return;
        }
     }
  }

#endif // ASC_HUD_MANAGER_MQH
