#ifndef __ASC_EXPLORER_HUD_MQH__
#define __ASC_EXPLORER_HUD_MQH__

#include "ASC_Common.mqh"
#include "ASC_ExplorerBuckets.mqh"
#include "ASC_Logging.mqh"

#define ASC_HUD_PREFIX "ASC_EXPLORER::"

enum ASC_ExplorerView
  {
   ASC_EXPLORER_VIEW_OVERVIEW=0,
   ASC_EXPLORER_VIEW_BUCKETS=1,
   ASC_EXPLORER_VIEW_SUB_BUCKETS=2,
   ASC_EXPLORER_VIEW_BUCKET_DETAIL=3,
   ASC_EXPLORER_VIEW_SYMBOL_DETAIL=4,
   ASC_EXPLORER_VIEW_STAT_DETAIL=5
  };

enum ASC_ExplorerStatView
  {
   ASC_EXPLORER_STAT_NONE=0,
   ASC_EXPLORER_STAT_IDENTITY=1,
   ASC_EXPLORER_STAT_MARKET_STATE=2,
   ASC_EXPLORER_STAT_TICK_QUOTE=3,
   ASC_EXPLORER_STAT_RUNTIME_PUBLICATION=4,
   ASC_EXPLORER_STAT_FUTURE_SURFACES=5
  };

struct ASC_ExplorerTheme
  {
   int margin;
   int gap;
   int padding;
   int header_height;
   int nav_height;
   int status_height;
   int rail_width;
   int row_height;
   int title_height;
   int button_height;
   color background;
   color header_fill;
   color panel_fill;
   color panel_alt_fill;
   color panel_soft_fill;
   color section_fill;
   color accent;
   color accent_alt;
   color good;
   color warning;
   color danger;
   color reserved;
   color text;
   color muted;
   color dim;
   color border;
   color rail_fill;
   color selected_fill;
   color selected_soft_fill;
  };

struct ASC_ExplorerNavState
  {
   ASC_ExplorerView current_view;
   ASC_ExplorerView history_views[24];
   int history_bucket[24];
   int history_symbol[24];
   int history_sub_bucket[24];
   int history_stat[24];
   string history_bucket_mode[24];
   string history_seed_symbol[24];
   string history_sub_bucket_key[24];
   int history_bucket_scroll[24];
   int history_detail_scroll[24];
   int history_symbol_scroll[24];
   int history_stat_scroll[24];
   int history_bucket_mode_scroll[24];
   int history_bucket_page[24];
   int history_sub_bucket_page[24];
   int history_bucket_symbol_page[24];
   int history_market_filter[24];
   int history_count;
   int bucket_scroll;
   int bucket_detail_scroll;
   int symbol_scroll;
   int stat_scroll;
   int bucket_mode_scroll;
   int bucket_page;
   int bucket_symbol_page;
   int selected_bucket_index;
   int selected_sub_bucket_index;
   int selected_symbol_index;
   string selected_sub_bucket_key;
   int sub_bucket_page;
   ASC_ExplorerBucketDisplayMode bucket_display_mode;
   ASC_ExplorerMarketFilter market_filter;
   ASC_ExplorerStatView selected_stat_view;
   string selected_seed_symbol;
   bool dirty;
   string last_render_signature;
   long last_render_tick_ms;
   datetime last_render_at;
   long last_render_started_ms;
   long last_render_duration_ms;
   long render_duration_total_ms;
   int render_sample_count;
   long render_duration_max_ms;
   datetime last_navigation_action_at;
   long last_page_switch_action_to_render_ms;
   long page_switch_action_to_render_total_ms;
   int page_switch_sample_count;
   long page_switch_action_to_render_max_ms;
   long pending_page_switch_started_ms;
   bool pending_page_switch_timing;
   string pending_page_switch_action;
   long transition_lock_started_ms;
   long transition_lock_duration_ms;
   bool transition_lock_active;
   string transition_lock_action;
   int last_prepare_heartbeat_count;
   datetime last_prepare_heartbeat_at;
   int last_prepare_batch_generation;
   int last_prepare_active_batch_id;
   int last_prepare_symbol_count;
   string last_render_reason;
   string last_skip_reason;
  };

struct ASC_ExplorerRenderDiagnostics
  {
   int render_id;
   int objects_created;
   int objects_updated;
   int objects_deleted;
   int visible_object_count;
   long header_ms;
   long nav_ms;
   long rail_ms;
   long page_ms;
   long status_ms;
   long cleanup_ms;
   string page_view_name;
   string slowest_section_name;
   long slowest_section_ms;
  };

struct ASC_ExplorerContext
  {
   long chart_id;
   string prefix;
   ASC_ExplorerTheme theme;
   ASC_ExplorerNavState nav;
   bool initialized;
   bool layout_dirty;
   int cached_chart_width;
   int cached_chart_height;
   string tracked_object_names[];
   int tracked_object_types[];
   int tracked_visible_generation[];
   int tracked_updated_generation[];
   ASC_ExplorerRenderDiagnostics render_diag;
   int render_generation;
   bool render_ok;
  };

struct ASC_ExplorerLayoutMetrics
  {
   int chart_w;
   int chart_h;
   int root_w;
   int root_h;
   int main_x;
   int main_y;
   int main_h;
   int rail_x;
   int rail_y;
   int rail_h;
   int content_w;
   int status_x;
   int status_y;
   int status_w;
  };

struct ASC_ExplorerObjectVisualState
  {
   string text;
   bool text_known;
   long corner;
   bool corner_known;
   long x;
   bool x_known;
   long y;
   bool y_known;
   long width;
   bool width_known;
   long height;
   bool height_known;
   long bg_color;
   bool bg_color_known;
   long border_color;
   bool border_color_known;
   long text_color_value;
  bool text_color_known;
   long font_size;
   bool font_size_known;
   bool back;
   bool back_known;
   bool hidden;
   bool hidden_known;
   bool selectable;
   bool selectable_known;
  };

ASC_ExplorerObjectVisualState g_asc_explorer_visual_states[];

void ASC_ExplorerThemeDefaults(ASC_ExplorerTheme &theme,const int density_mode)
  {
   theme.margin=10;
   theme.gap=(density_mode<=0 ? 6 : 8);
   theme.padding=(density_mode<=0 ? 7 : (density_mode>=2 ? 10 : 8));
   theme.header_height=(density_mode<=0 ? 72 : (density_mode>=2 ? 84 : 78));
   theme.nav_height=(density_mode<=0 ? 54 : (density_mode>=2 ? 62 : 58));
   theme.status_height=(density_mode<=0 ? 22 : (density_mode>=2 ? 28 : 24));
   theme.rail_width=0;
   theme.row_height=(density_mode<=0 ? 16 : (density_mode>=2 ? 20 : 18));
   theme.title_height=(density_mode>=2 ? 30 : 26);
   theme.button_height=(density_mode>=2 ? 24 : 22);
   theme.background=C'7,12,20';
   theme.header_fill=C'14,22,35';
   theme.panel_fill=C'18,27,40';
   theme.panel_alt_fill=C'26,39,58';
   theme.panel_soft_fill=C'12,19,31';
   theme.section_fill=C'10,17,28';
   theme.accent=C'76,173,255';
   theme.accent_alt=C'97,143,224';
   theme.good=C'88,204,144';
   theme.warning=C'224,181,90';
   theme.danger=C'232,112,98';
   theme.reserved=C'104,112,136';
   theme.text=clrWhite;
   theme.muted=C'196,204,219';
   theme.dim=C'146,155,174';
   theme.border=C'56,73,98';
   theme.rail_fill=C'13,20,31';
   theme.selected_fill=C'35,60,88';
   theme.selected_soft_fill=C'24,47,70';
  }

string ASC_ExplorerObjectName(const ASC_ExplorerContext &ctx,const string suffix)
  {
   return(ctx.prefix + suffix);
  }

void ASC_ExplorerDeleteOwnedObjects(const ASC_ExplorerContext &ctx)
  {
   int total=ObjectsTotal(ctx.chart_id,0,-1);
   for(int i=total-1;i>=0;i--)
     {
      string name=ObjectName(ctx.chart_id,i,0,-1);
      if(StringFind(name,ctx.prefix)==0)
         ObjectDelete(ctx.chart_id,name);
     }
  }

bool ASC_ExplorerObjectTracked(const string &objects[],const string name)
  {
   for(int i=0;i<ArraySize(objects);i++)
     {
      if(objects[i]==name)
         return(true);
     }
   return(false);
  }

int ASC_ExplorerTrackedObjectSlot(const ASC_ExplorerContext &ctx,const string name)
  {
   for(int i=0;i<ArraySize(ctx.tracked_object_names);i++)
     {
      if(ctx.tracked_object_names[i]==name)
         return(i);
     }
   return(-1);
  }

int ASC_ExplorerEnsureTrackedObjectSlot(ASC_ExplorerContext &ctx,const string name)
  {
   int slot=ASC_ExplorerTrackedObjectSlot(ctx,name);
   if(slot>=0)
      return(slot);
   slot=ArraySize(ctx.tracked_object_names);
   ArrayResize(ctx.tracked_object_names,slot+1);
   ArrayResize(ctx.tracked_object_types,slot+1);
   ArrayResize(ctx.tracked_visible_generation,slot+1);
   ArrayResize(ctx.tracked_updated_generation,slot+1);
   ArrayResize(g_asc_explorer_visual_states,slot+1);
   ctx.tracked_object_names[slot]=name;
   ctx.tracked_object_types[slot]=-1;
   ctx.tracked_visible_generation[slot]=0;
   ctx.tracked_updated_generation[slot]=0;
   return(slot);
  }

void ASC_ExplorerResetVisualState(ASC_ExplorerObjectVisualState &state)
  {
   state.text="";
   state.text_known=false;
   state.corner=0;
   state.corner_known=false;
   state.x=0;
   state.x_known=false;
   state.y=0;
   state.y_known=false;
   state.width=0;
   state.width_known=false;
   state.height=0;
   state.height_known=false;
   state.bg_color=0;
   state.bg_color_known=false;
   state.border_color=0;
   state.border_color_known=false;
   state.text_color_value=0;
   state.text_color_known=false;
   state.font_size=0;
   state.font_size_known=false;
   state.back=false;
   state.back_known=false;
   state.hidden=false;
   state.hidden_known=false;
   state.selectable=false;
   state.selectable_known=false;
  }

void ASC_ExplorerInvalidateObjectRegistry(ASC_ExplorerContext &ctx)
  {
   ArrayResize(ctx.tracked_object_names,0);
   ArrayResize(ctx.tracked_object_types,0);
   ArrayResize(ctx.tracked_visible_generation,0);
   ArrayResize(ctx.tracked_updated_generation,0);
   ArrayResize(g_asc_explorer_visual_states,0);
  }

void ASC_ExplorerInvalidateLayout(ASC_ExplorerContext &ctx)
  {
   ctx.layout_dirty=true;
   ctx.cached_chart_width=0;
   ctx.cached_chart_height=0;
  }

void ASC_ExplorerBeginFrame(ASC_ExplorerContext &ctx)
  {
   ctx.render_ok=true;
   ctx.render_generation++;
   if(ctx.render_generation<=0)
     {
      ctx.render_generation=1;
      for(int i=0;i<ArraySize(ctx.tracked_visible_generation);i++)
        {
         ctx.tracked_visible_generation[i]=0;
         ctx.tracked_updated_generation[i]=0;
        }
     }
   ctx.render_diag.render_id++;
   ctx.render_diag.objects_created=0;
   ctx.render_diag.objects_updated=0;
   ctx.render_diag.objects_deleted=0;
   ctx.render_diag.visible_object_count=0;
   ctx.render_diag.header_ms=0;
   ctx.render_diag.nav_ms=0;
   ctx.render_diag.rail_ms=0;
   ctx.render_diag.page_ms=0;
   ctx.render_diag.status_ms=0;
   ctx.render_diag.cleanup_ms=0;
   ctx.render_diag.page_view_name=ASC_ExplorerViewText(ctx.nav.current_view);
   ctx.render_diag.slowest_section_name="pending";
   ctx.render_diag.slowest_section_ms=0;
  }

void ASC_ExplorerMarkObjectUpdated(ASC_ExplorerContext &ctx,const int slot)
  {
   if(slot<0 || slot>=ArraySize(ctx.tracked_updated_generation))
      return;
   if(ctx.tracked_updated_generation[slot]==ctx.render_generation)
      return;
   ctx.tracked_updated_generation[slot]=ctx.render_generation;
   ctx.render_diag.objects_updated++;
  }

void ASC_ExplorerTouchObject(ASC_ExplorerContext &ctx,const string name)
  {
   int slot=ASC_ExplorerTrackedObjectSlot(ctx,name);
   if(slot<0)
      return;
   ctx.tracked_visible_generation[slot]=ctx.render_generation;
  }

void ASC_ExplorerEndFrame(ASC_ExplorerContext &ctx)
  {
   int visible_count=0;
   if(!ctx.render_ok)
     {
      for(int i=0;i<ArraySize(ctx.tracked_object_names);i++)
        {
         if(ctx.tracked_object_types[i]>=0)
            visible_count++;
        }
      ctx.render_diag.visible_object_count=visible_count;
      return;
     }
   for(int i=0;i<ArraySize(ctx.tracked_object_names);i++)
     {
      if(ctx.tracked_object_types[i]<0)
         continue;
      if(ctx.tracked_visible_generation[i]==ctx.render_generation)
        {
         visible_count++;
         continue;
        }
      ObjectDelete(ctx.chart_id,ctx.tracked_object_names[i]);
      ctx.tracked_object_types[i]=-1;
      ctx.tracked_visible_generation[i]=0;
      ctx.tracked_updated_generation[i]=0;
      ASC_ExplorerResetVisualState(g_asc_explorer_visual_states[i]);
      ctx.render_diag.objects_deleted++;
     }
   ctx.render_diag.visible_object_count=visible_count;
  }

bool ASC_ExplorerEnsureObject(ASC_ExplorerContext &ctx,const string name,const ENUM_OBJECT object_type)
  {
   int slot=ASC_ExplorerEnsureTrackedObjectSlot(ctx,name);
   if(ctx.tracked_object_types[slot]==(int)object_type)
     {
      ASC_ExplorerTouchObject(ctx,name);
      return(true);
     }

   if(ctx.tracked_object_types[slot]>=0)
      ObjectDelete(ctx.chart_id,name);

   if(ObjectFind(ctx.chart_id,name)>=0)
     {
      ENUM_OBJECT existing=(ENUM_OBJECT)ObjectGetInteger(ctx.chart_id,name,OBJPROP_TYPE);
      if(existing==object_type)
        {
         ctx.tracked_object_types[slot]=(int)object_type;
         ASC_ExplorerTouchObject(ctx,name);
         return(true);
        }
      ObjectDelete(ctx.chart_id,name);
     }
   if(!ObjectCreate(ctx.chart_id,name,object_type,0,0,0))
     {
      ctx.render_ok=false;
      return(false);
     }
   ctx.tracked_object_types[slot]=(int)object_type;
   ASC_ExplorerResetVisualState(g_asc_explorer_visual_states[slot]);
   ctx.render_diag.objects_created++;
   ASC_ExplorerMarkObjectUpdated(ctx,slot);
   ASC_ExplorerTouchObject(ctx,name);
   return(true);
  }

bool ASC_ExplorerSetInteger(ASC_ExplorerContext &ctx,const string name,const ENUM_OBJECT_PROPERTY_INTEGER prop_id,const long value)
  {
   int slot=ASC_ExplorerTrackedObjectSlot(ctx,name);
   if(slot<0)
     {
      ctx.render_ok=false;
      return(false);
     }
   bool known=false;
   long current_value=0;
   switch(prop_id)
     {
      case OBJPROP_CORNER:       known=g_asc_explorer_visual_states[slot].corner_known;       current_value=g_asc_explorer_visual_states[slot].corner;       break;
      case OBJPROP_XDISTANCE:    known=g_asc_explorer_visual_states[slot].x_known;            current_value=g_asc_explorer_visual_states[slot].x;            break;
      case OBJPROP_YDISTANCE:    known=g_asc_explorer_visual_states[slot].y_known;            current_value=g_asc_explorer_visual_states[slot].y;            break;
      case OBJPROP_XSIZE:        known=g_asc_explorer_visual_states[slot].width_known;        current_value=g_asc_explorer_visual_states[slot].width;        break;
      case OBJPROP_YSIZE:        known=g_asc_explorer_visual_states[slot].height_known;       current_value=g_asc_explorer_visual_states[slot].height;       break;
      case OBJPROP_BGCOLOR:      known=g_asc_explorer_visual_states[slot].bg_color_known;     current_value=g_asc_explorer_visual_states[slot].bg_color;     break;
      case OBJPROP_BORDER_COLOR: known=g_asc_explorer_visual_states[slot].border_color_known; current_value=g_asc_explorer_visual_states[slot].border_color; break;
      case OBJPROP_COLOR:        known=g_asc_explorer_visual_states[slot].text_color_known;        current_value=g_asc_explorer_visual_states[slot].text_color_value;        break;
      case OBJPROP_FONTSIZE:     known=g_asc_explorer_visual_states[slot].font_size_known;    current_value=g_asc_explorer_visual_states[slot].font_size;    break;
      case OBJPROP_BACK:         known=g_asc_explorer_visual_states[slot].back_known;         current_value=(g_asc_explorer_visual_states[slot].back ? 1 : 0); break;
      case OBJPROP_HIDDEN:       known=g_asc_explorer_visual_states[slot].hidden_known;       current_value=(g_asc_explorer_visual_states[slot].hidden ? 1 : 0); break;
      case OBJPROP_SELECTABLE:   known=g_asc_explorer_visual_states[slot].selectable_known;   current_value=(g_asc_explorer_visual_states[slot].selectable ? 1 : 0); break;
      default:
         return(ObjectSetInteger(ctx.chart_id,name,prop_id,value));
     }
   if(known && current_value==value)
      return(true);
   if(!ObjectSetInteger(ctx.chart_id,name,prop_id,value))
     {
      ctx.render_ok=false;
      return(false);
     }
   ASC_ExplorerMarkObjectUpdated(ctx,slot);
   switch(prop_id)
     {
      case OBJPROP_CORNER:       g_asc_explorer_visual_states[slot].corner=value;       g_asc_explorer_visual_states[slot].corner_known=true; break;
      case OBJPROP_XDISTANCE:    g_asc_explorer_visual_states[slot].x=value;            g_asc_explorer_visual_states[slot].x_known=true; break;
      case OBJPROP_YDISTANCE:    g_asc_explorer_visual_states[slot].y=value;            g_asc_explorer_visual_states[slot].y_known=true; break;
      case OBJPROP_XSIZE:        g_asc_explorer_visual_states[slot].width=value;        g_asc_explorer_visual_states[slot].width_known=true; break;
      case OBJPROP_YSIZE:        g_asc_explorer_visual_states[slot].height=value;       g_asc_explorer_visual_states[slot].height_known=true; break;
      case OBJPROP_BGCOLOR:      g_asc_explorer_visual_states[slot].bg_color=value;     g_asc_explorer_visual_states[slot].bg_color_known=true; break;
      case OBJPROP_BORDER_COLOR: g_asc_explorer_visual_states[slot].border_color=value; g_asc_explorer_visual_states[slot].border_color_known=true; break;
      case OBJPROP_COLOR:        g_asc_explorer_visual_states[slot].text_color_value=value;        g_asc_explorer_visual_states[slot].text_color_known=true; break;
      case OBJPROP_FONTSIZE:     g_asc_explorer_visual_states[slot].font_size=value;    g_asc_explorer_visual_states[slot].font_size_known=true; break;
      case OBJPROP_BACK:         g_asc_explorer_visual_states[slot].back=(value!=0);    g_asc_explorer_visual_states[slot].back_known=true; break;
      case OBJPROP_HIDDEN:       g_asc_explorer_visual_states[slot].hidden=(value!=0);  g_asc_explorer_visual_states[slot].hidden_known=true; break;
      case OBJPROP_SELECTABLE:   g_asc_explorer_visual_states[slot].selectable=(value!=0); g_asc_explorer_visual_states[slot].selectable_known=true; break;
      default: break;
     }
   return(true);
  }

bool ASC_ExplorerSetString(ASC_ExplorerContext &ctx,const string name,const ENUM_OBJECT_PROPERTY_STRING prop_id,const string value)
  {
   int slot=ASC_ExplorerTrackedObjectSlot(ctx,name);
   if(slot<0)
     {
      ctx.render_ok=false;
      return(false);
     }
   if(prop_id!=OBJPROP_TEXT)
      return(ObjectSetString(ctx.chart_id,name,prop_id,value));
   if(g_asc_explorer_visual_states[slot].text_known && g_asc_explorer_visual_states[slot].text==value)
      return(true);
   if(!ObjectSetString(ctx.chart_id,name,prop_id,value))
     {
      ctx.render_ok=false;
      return(false);
     }
   g_asc_explorer_visual_states[slot].text=value;
   g_asc_explorer_visual_states[slot].text_known=true;
   ASC_ExplorerMarkObjectUpdated(ctx,slot);
   return(true);
  }

void ASC_ExplorerRefreshLayoutMetrics(ASC_ExplorerContext &ctx)
  {
   ctx.cached_chart_width=(int)ChartGetInteger(ctx.chart_id,CHART_WIDTH_IN_PIXELS,0);
   ctx.cached_chart_height=(int)ChartGetInteger(ctx.chart_id,CHART_HEIGHT_IN_PIXELS,0);
   ctx.layout_dirty=false;
  }

void ASC_ExplorerBuildLayout(const ASC_ExplorerContext &ctx,ASC_ExplorerLayoutMetrics &layout)
  {
   layout.chart_w=ctx.cached_chart_width;
   layout.chart_h=ctx.cached_chart_height;
   layout.root_w=layout.chart_w-(ctx.theme.margin*2);
   layout.root_h=layout.chart_h-(ctx.theme.margin*2);
   layout.main_x=ctx.theme.margin+ctx.theme.padding;
   layout.main_y=ctx.theme.margin+ctx.theme.header_height+ctx.theme.nav_height+(ctx.theme.gap*2);
   layout.main_h=layout.chart_h-layout.main_y-ctx.theme.status_height-ctx.theme.margin-(ctx.theme.gap*2);
   layout.rail_x=0;
   layout.rail_y=0;
   layout.rail_h=0;
   layout.content_w=layout.chart_w-(ctx.theme.margin*2)-(ctx.theme.padding*2);
   layout.status_x=layout.main_x;
   layout.status_y=layout.main_y+layout.main_h+ctx.theme.gap;
   layout.status_w=layout.content_w;
  }

bool ASC_ExplorerRect(ASC_ExplorerContext &ctx,const string id,const int x,const int y,const int w,const int h,const color fill,const color border)
  {
   string name=ASC_ExplorerObjectName(ctx,id);
   if(!ASC_ExplorerEnsureObject(ctx,name,OBJ_RECTANGLE_LABEL))
      return(false);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_XDISTANCE,x);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_YDISTANCE,y);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_XSIZE,w);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_YSIZE,h);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_BGCOLOR,fill);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_BORDER_COLOR,border);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_COLOR,border);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_BACK,false);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_HIDDEN,true);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_SELECTABLE,false);
   return(true);
  }

bool ASC_ExplorerLabel(ASC_ExplorerContext &ctx,const string id,const string text,const int x,const int y,const color text_color,const int font_size=9)
  {
   string name=ASC_ExplorerObjectName(ctx,id);
   if(!ASC_ExplorerEnsureObject(ctx,name,OBJ_LABEL))
      return(false);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_XDISTANCE,x);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_YDISTANCE,y);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_COLOR,text_color);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_FONTSIZE,font_size);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_HIDDEN,true);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_SELECTABLE,false);
   ASC_ExplorerSetString(ctx,name,OBJPROP_TEXT,text);
   return(true);
  }

bool ASC_ExplorerButton(ASC_ExplorerContext &ctx,const string id,const string text,const int x,const int y,const int w,const int h,const color fill,const bool selected=false)
  {
   string name=ASC_ExplorerObjectName(ctx,id);
   if(!ASC_ExplorerEnsureObject(ctx,name,OBJ_BUTTON))
      return(false);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_XDISTANCE,x);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_YDISTANCE,y);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_XSIZE,w);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_YSIZE,h);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_BGCOLOR,(selected ? ctx.theme.selected_fill : fill));
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_COLOR,ctx.theme.text);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_BORDER_COLOR,(selected ? ctx.theme.accent : ctx.theme.border));
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_HIDDEN,true);
   ASC_ExplorerSetInteger(ctx,name,OBJPROP_SELECTABLE,false);
   ASC_ExplorerSetString(ctx,name,OBJPROP_TEXT,text);
   return(true);
  }

int ASC_ExplorerApproxChars(const int pixel_width,const int font_size)
  {
   int divisor=(font_size>=11 ? 8 : 7);
   int chars=(pixel_width/divisor);
   if(chars<4)
      chars=4;
   return(chars);
  }

string ASC_ExplorerNormalizeText(const string value)
  {
   string clean=value;
   StringReplace(clean,"\r"," ");
   StringReplace(clean,"\n"," ");
   while(StringFind(clean,"  ")>=0)
      StringReplace(clean,"  "," ");
   return(ASC_Trim(clean));
  }

string ASC_ExplorerFitTextTail(const string value,const int pixel_width,const int font_size=9)
  {
   string clean=ASC_ExplorerNormalizeText(value);
   int limit=ASC_ExplorerApproxChars(pixel_width,font_size);
   int length=(int)StringLen(clean);
   if(length<=limit)
      return(clean);
   if(limit<=3)
      return("...");
   return("..." + StringSubstr(clean,length-(limit-3)));
  }

string ASC_ExplorerFitText(const string value,const int pixel_width,const int font_size=9)
  {
   string clean=ASC_ExplorerNormalizeText(value);
   int limit=ASC_ExplorerApproxChars(pixel_width,font_size);
   int length=(int)StringLen(clean);
   if(length<=limit)
      return(clean);
   if(limit<=3)
      return("...");

   int pipe_pos=StringFind(clean," | ");
   if(pipe_pos>0)
     {
      string first=StringSubstr(clean,0,pipe_pos);
      string rest=StringSubstr(clean,pipe_pos+3);
      int first_len=(int)StringLen(first);
      int keep_first=(limit*2)/3;
      if(keep_first<first_len)
         keep_first=first_len;
      if(keep_first>limit-6)
         keep_first=limit-6;
      if(keep_first>0 && keep_first<limit-3)
         return(ASC_ExplorerFitText(first,keep_first*7,font_size) + " | " + ASC_ExplorerFitTextTail(rest,(limit-keep_first-3)*7,font_size));
     }

   if(limit>=10)
     {
      int head=(limit-3)*2/3;
      int tail=(limit-3)-head;
      if(head<4)
         head=4;
      if(tail<3)
         tail=3;
      if((head+tail+3)<=length)
         return(StringSubstr(clean,0,head) + "..." + StringSubstr(clean,length-tail));
     }

   return(StringSubstr(clean,0,limit-3) + "...");
  }

int ASC_ExplorerFindWrapPoint(const string value,const int start,const int limit)
  {
   int length=(int)StringLen(value);
   if(start>=length)
      return(length);
   int end=start+limit;
   if(end>=length)
      return(length);
   int best=-1;
   for(int i=start;i<end;i++)
     {
      ushort ch=StringGetCharacter(value,i);
      if(ch==' ' || ch=='|' || ch=='/' || ch=='-')
         best=i;
     }
   if(best>start)
      return(best);
   return(end);
  }

void ASC_ExplorerFitTextTwoLines(const string value,const int pixel_width,string &line1,string &line2,const int font_size=9)
  {
   string clean=ASC_ExplorerNormalizeText(value);
   int limit=ASC_ExplorerApproxChars(pixel_width,font_size);
   if((int)StringLen(clean)<=limit)
     {
      line1=clean;
      line2="";
      return;
     }
   int split=ASC_ExplorerFindWrapPoint(clean,0,limit);
   line1=ASC_Trim(StringSubstr(clean,0,split));
   string remainder=ASC_Trim(StringSubstr(clean,split));
   line2=ASC_ExplorerFitText(remainder,pixel_width,font_size);
  }

string ASC_ExplorerMarketFilterText(const ASC_ExplorerMarketFilter filter)
  {
   return(filter==ASC_EXPLORER_FILTER_OPEN_ONLY ? "Open Only" : "All Symbols");
  }

string ASC_ExplorerHeaderMetaText(const ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime)
  {
   string server=(runtime.server_clean!="" ? runtime.server_clean : "Unknown");
   return("Srv " + server + " | Density " + ASC_ExplorerDensityText(settings.explorer_density_mode) + " | Explorer " + ASC_EXPLORER_SUBSYSTEM_VERSION);
  }

string ASC_ExplorerHeaderStateText(const ASC_RuntimeState &runtime)
  {
   string state=(runtime.degraded ? "Attention" : ASC_RuntimeModeText(runtime.mode));
   return(state + " | Readiness " + IntegerToString(runtime.readiness_percent) + "% | Warmup "
          + IntegerToString(runtime.initial_symbols_assessed) + "/" + IntegerToString(runtime.total_symbols_discovered));
  }

string ASC_ExplorerHeaderFlowText(const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared)
  {
   string layer1=(runtime.layer1_boot_complete ? "Layer 1 ready" : "Layer 1 warmup");
   string pressure=(prepared.diagnostics.bounded_work_pressure_summary!="" ? prepared.diagnostics.bounded_work_pressure_summary : "not sampled");
   return(layer1 + " | Pressure " + pressure);
  }

string ASC_ExplorerStatusText(const ASC_RuntimeState &runtime)
  {
   string mode=(runtime.degraded ? "Attention" : ASC_RuntimeModeText(runtime.mode));
   string scope="Assessed " + IntegerToString(runtime.initial_symbols_assessed) + "/" + IntegerToString(runtime.total_symbols_discovered);
   return(mode + " | Readiness " + IntegerToString(runtime.readiness_percent) + "% | " + scope);
  }

string ASC_ExplorerPercentText(const int numerator,const int denominator)
  {
   int tenths=ASC_PercentTenths(numerator,denominator);
   return(IntegerToString(tenths/10) + "." + IntegerToString(tenths%10) + "%");
  }

string ASC_ExplorerCountPercentText(const string label,const int numerator,const int denominator,const string basis_label="")
  {
   string text=label + " " + IntegerToString(numerator) + " / " + IntegerToString(denominator) + " (" + ASC_ExplorerPercentText(numerator,denominator) + ")";
   if(basis_label!="")
      text+=" of " + basis_label;
   return(text);
  }

struct ASC_ExplorerLayer1Overview
  {
   int discovered_count;
   int open_count;
   int closed_count;
   int uncertain_count;
   int unknown_count;
   int classified_count;
   int unresolved_count;
   int warmup_ready_count;
  };

color ASC_ExplorerStatusAccent(const ASC_ExplorerContext &ctx,const ASC_MarketStatus status,const bool resolved)
  {
   if(!resolved)
      return(ctx.theme.reserved);
   if(status==ASC_MARKET_OPEN)
      return(ctx.theme.good);
   if(status==ASC_MARKET_CLOSED)
      return(ctx.theme.warning);
   if(status==ASC_MARKET_UNCERTAIN)
      return(ctx.theme.danger);
   return(ctx.theme.reserved);
  }

void ASC_ExplorerPanelTitle(ASC_ExplorerContext &ctx,const string id,const string title,const int x,const int y,const int w,const color stripe)
  {
   ASC_ExplorerRect(ctx,id + ".title",x,y,w,ctx.theme.title_height,ctx.theme.section_fill,ctx.theme.border);
   ASC_ExplorerRect(ctx,id + ".title.stripe",x,y,5,ctx.theme.title_height,stripe,stripe);
   ASC_ExplorerLabel(ctx,id + ".title.text",ASC_ExplorerFitText(title,w-ctx.theme.padding-16,10),x+ctx.theme.padding+4,y+6,ctx.theme.text,10);
  }

void ASC_ExplorerInfoRow(ASC_ExplorerContext &ctx,const string id,const string label,const string value,const int x,const int y,const int w,const color accent)
  {
   int row_h=ctx.theme.row_height+6;
   int label_w=(w*34)/100;
   int desired=((int)StringLen(label)*7)+18;
   if(desired>label_w)
      label_w=desired;
   if(label_w<92)
      label_w=92;
   if(label_w>w-104)
      label_w=w-104;
   ASC_ExplorerRect(ctx,id + ".row",x,y,w,row_h,ctx.theme.panel_fill,ctx.theme.border);
   ASC_ExplorerRect(ctx,id + ".bar",x,y,4,row_h,accent,accent);
   ASC_ExplorerLabel(ctx,id + ".label",ASC_ExplorerFitText(label,label_w-14),x+ctx.theme.padding+2,y+4,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,id + ".value",ASC_ExplorerFitText(value,w-label_w-ctx.theme.padding-20),x+label_w+4,y+4,ctx.theme.text);
  }

int ASC_ExplorerResolveFilteredBucketSelection(const ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,ASC_BucketViewModel &bucket)
  {
   ASC_BucketViewModel filtered[];
   int source_indices[];
   int total=ASC_PreparedFilteredBuckets(prepared,ctx.nav.market_filter,filtered,source_indices);
   if(ctx.nav.selected_bucket_index<0 || ctx.nav.selected_bucket_index>=total)
      return(-1);
   bucket=filtered[ctx.nav.selected_bucket_index];
   return(total);
  }

int ASC_ExplorerResolveFilteredSubBucketSelection(const ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,const string main_bucket_id,ASC_SubBucketViewModel &sub_bucket)
  {
   ASC_SubBucketViewModel filtered[];
   int total=ASC_PreparedFilteredSubBuckets(prepared,main_bucket_id,ctx.nav.market_filter,filtered);
   if(ctx.nav.selected_sub_bucket_index<0 || ctx.nav.selected_sub_bucket_index>=total)
      return(-1);
   sub_bucket=filtered[ctx.nav.selected_sub_bucket_index];
   return(total);
  }

string ASC_ExplorerSelectedSubBucketName(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared)
  {
   ASC_BucketViewModel bucket;
   if(ASC_ExplorerResolveFilteredBucketSelection(ctx,prepared,bucket)<0)
      return("Sub-Bucket");
   ASC_SubBucketViewModel sub_bucket;
   if(ASC_ExplorerResolveFilteredSubBucketSelection(ctx,prepared,bucket.bucket_id,sub_bucket)<0)
      return("Sub-Bucket");
   return(sub_bucket.name);
  }

int ASC_ExplorerBuildVisibleBucketSymbols(const ASC_PreparedBucketState &prepared,const ASC_BucketViewModel &bucket,const ASC_ExplorerMarketFilter market_filter,ASC_BucketPreparedSymbol &visible_symbols[])
  {
   ASC_BucketPreparedSymbol resolved[];
   ASC_PreparedBucketSymbols(prepared,bucket,resolved);
   ArrayResize(visible_symbols,0);
   for(int i=0;i<ArraySize(resolved);i++)
     {
      bool include=(market_filter==ASC_EXPLORER_FILTER_ALL_SYMBOLS || resolved[i].open_now);
      if(!include)
         continue;
      int slot=ArraySize(visible_symbols);
      ArrayResize(visible_symbols,slot+1);
      visible_symbols[slot]=resolved[i];
     }
   return(ArraySize(visible_symbols));
  }

int ASC_ExplorerVisibleRows(const ASC_ExplorerContext &ctx,const int available_height,const int row_pitch)
  {
   int pitch=(row_pitch>0 ? row_pitch : (ctx.theme.row_height+ctx.theme.gap));
   int rows=(available_height/pitch);
   if(rows<1)
      rows=1;
   return(rows);
  }

string ASC_ExplorerNavVisualSignature(const ASC_ExplorerContext &ctx)
  {
   return(IntegerToString((int)ctx.nav.current_view)
          + "|b=" + IntegerToString(ctx.nav.selected_bucket_index)
          + "|sb=" + IntegerToString(ctx.nav.selected_sub_bucket_index)
          + "|sbk=" + ctx.nav.selected_sub_bucket_key
          + "|s=" + IntegerToString(ctx.nav.selected_symbol_index)
          + "|stat=" + IntegerToString((int)ctx.nav.selected_stat_view)
          + "|mode=" + IntegerToString((int)ctx.nav.bucket_display_mode)
          + "|filter=" + IntegerToString((int)ctx.nav.market_filter)
          + "|page=" + IntegerToString(ctx.nav.bucket_page)
          + "|sub_page=" + IntegerToString(ctx.nav.sub_bucket_page)
          + "|bucket_page=" + IntegerToString(ctx.nav.bucket_symbol_page)
          + "|seed=" + ctx.nav.selected_seed_symbol);
  }

string ASC_ExplorerSelectedSymbolRenderSignature(ASC_SymbolState &states[],const int count,const int selected_symbol_index)
  {
   if(selected_symbol_index<0 || selected_symbol_index>=count)
      return("symbol=none");
   ASC_SymbolState state=states[selected_symbol_index];
   return("symbol=" + state.symbol
          + "|status=" + IntegerToString((int)state.market_status)
          + "|session=" + ASC_BoolText(state.within_trade_session)
          + "|sessions_known=" + ASC_BoolText(state.has_trade_sessions)
          + "|tick=" + ASC_BoolText(state.has_tick)
          + "|tick_seen=" + IntegerToString((int)state.last_tick_seen_at)
          + "|tick_age=" + IntegerToString((int)state.tick_age_seconds)
          + "|next=" + IntegerToString((int)state.next_check_at)
          + "|pub=" + ASC_BoolText(state.publication_ok)
          + "|snapshot=" + IntegerToString((int)state.snapshot_readiness)
          + "|snapshot_last=" + IntegerToString((int)state.snapshot_last_built_at)
          + "|snapshot_good=" + IntegerToString((int)state.snapshot_last_good_built_at)
          + "|bid=" + DoubleToString(state.snapshot_bid,state.snapshot_digits>0 ? state.snapshot_digits : 5)
          + "|ask=" + DoubleToString(state.snapshot_ask,state.snapshot_digits>0 ? state.snapshot_digits : 5)
          + "|spread=" + DoubleToString(state.snapshot_spread_price,5)
          + "|day_hi=" + DoubleToString(state.snapshot_day_high,state.snapshot_digits>0 ? state.snapshot_digits : 5)
          + "|day_lo=" + DoubleToString(state.snapshot_day_low,state.snapshot_digits>0 ? state.snapshot_digits : 5)
          + "|filter=" + IntegerToString((int)state.filter_readiness)
          + "|shortlist=" + IntegerToString((int)state.shortlist_readiness)
          + "|rank=" + IntegerToString(state.shortlist_rank)
          + "|selected=" + ASC_BoolText(state.shortlist_selected));
  }

string ASC_ExplorerRenderSignature(const ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count)
  {
   string signature=ASC_ExplorerNavVisualSignature(ctx)
      + "|layout=" + IntegerToString(ctx.cached_chart_width) + "x" + IntegerToString(ctx.cached_chart_height)
      + "|runtime_mode=" + IntegerToString((int)runtime.mode)
      + "|readiness=" + IntegerToString(runtime.readiness_percent)
      + "|dispatcher=" + IntegerToString(runtime.last_dispatcher_lane)
      + "|hold=" + IntegerToString((int)runtime.shortlist_hold_until)
      + "|degraded=" + ASC_BoolText(runtime.degraded)
      + "|warmup=" + ASC_BoolText(runtime.warmup_minimum_met)
      + "|assessed=" + IntegerToString(runtime.initial_symbols_assessed)
      + "|total=" + IntegerToString(runtime.total_symbols_discovered)
      + "|primary_counts=" + IntegerToString(runtime.primary_bucket_symbols_assessed) + "/" + IntegerToString(runtime.primary_bucket_symbol_count)
      + "|prep_gen=" + IntegerToString(prepared.batch_generation)
      + "|resolved=" + IntegerToString(prepared.total_resolved_symbols)
      + "|unresolved=" + IntegerToString(prepared.unresolved_count);

   switch(ctx.nav.current_view)
     {
      case ASC_EXPLORER_VIEW_BUCKETS:
      case ASC_EXPLORER_VIEW_SUB_BUCKETS:
      case ASC_EXPLORER_VIEW_BUCKET_DETAIL:
         signature+="|sub_total=" + IntegerToString(ArraySize(prepared.sub_buckets));
         break;
      case ASC_EXPLORER_VIEW_SYMBOL_DETAIL:
      case ASC_EXPLORER_VIEW_STAT_DETAIL:
         signature+="|" + ASC_ExplorerSelectedSymbolRenderSignature(states,count,ctx.nav.selected_symbol_index);
         break;
      default:
         signature+="|count=" + IntegerToString(count);
         break;
     }
   return(signature);
  }

int ASC_ExplorerPageCount(const int total_items,const int rows_per_page)
  {
   if(total_items<=0)
      return(1);
   int rows=(rows_per_page>0 ? rows_per_page : 1);
   int pages=total_items/rows;
   if((total_items%rows)!=0)
      pages++;
   if(pages<1)
      pages=1;
   return(pages);
  }

void ASC_ExplorerClampPage(int &page_index,const int total_items,const int rows_per_page)
  {
   int total_pages=ASC_ExplorerPageCount(total_items,rows_per_page);
   if(page_index<0)
      page_index=0;
   if(page_index>=total_pages)
      page_index=total_pages-1;
  }

void ASC_ExplorerPushHistory(ASC_ExplorerContext &ctx)
  {
   if(ctx.nav.history_count>=ArraySize(ctx.nav.history_views))
     {
      for(int i=1;i<ctx.nav.history_count;i++)
        {
         ctx.nav.history_views[i-1]=ctx.nav.history_views[i];
         ctx.nav.history_bucket[i-1]=ctx.nav.history_bucket[i];
         ctx.nav.history_symbol[i-1]=ctx.nav.history_symbol[i];
         ctx.nav.history_sub_bucket[i-1]=ctx.nav.history_sub_bucket[i];
         ctx.nav.history_stat[i-1]=ctx.nav.history_stat[i];
         ctx.nav.history_bucket_mode[i-1]=ctx.nav.history_bucket_mode[i];
         ctx.nav.history_seed_symbol[i-1]=ctx.nav.history_seed_symbol[i];
         ctx.nav.history_sub_bucket_key[i-1]=ctx.nav.history_sub_bucket_key[i];
         ctx.nav.history_bucket_scroll[i-1]=ctx.nav.history_bucket_scroll[i];
         ctx.nav.history_detail_scroll[i-1]=ctx.nav.history_detail_scroll[i];
         ctx.nav.history_symbol_scroll[i-1]=ctx.nav.history_symbol_scroll[i];
         ctx.nav.history_stat_scroll[i-1]=ctx.nav.history_stat_scroll[i];
         ctx.nav.history_bucket_mode_scroll[i-1]=ctx.nav.history_bucket_mode_scroll[i];
         ctx.nav.history_bucket_page[i-1]=ctx.nav.history_bucket_page[i];
         ctx.nav.history_sub_bucket_page[i-1]=ctx.nav.history_sub_bucket_page[i];
         ctx.nav.history_bucket_symbol_page[i-1]=ctx.nav.history_bucket_symbol_page[i];
         ctx.nav.history_market_filter[i-1]=ctx.nav.history_market_filter[i];
        }
      ctx.nav.history_count--;
     }

   int slot=ctx.nav.history_count;
   ctx.nav.history_views[slot]=ctx.nav.current_view;
   ctx.nav.history_bucket[slot]=ctx.nav.selected_bucket_index;
   ctx.nav.history_symbol[slot]=ctx.nav.selected_symbol_index;
   ctx.nav.history_sub_bucket[slot]=ctx.nav.selected_sub_bucket_index;
   ctx.nav.history_stat[slot]=(int)ctx.nav.selected_stat_view;
   ctx.nav.history_bucket_mode[slot]=IntegerToString((int)ctx.nav.bucket_display_mode);
   ctx.nav.history_seed_symbol[slot]=ctx.nav.selected_seed_symbol;
   ctx.nav.history_sub_bucket_key[slot]=ctx.nav.selected_sub_bucket_key;
   ctx.nav.history_bucket_scroll[slot]=ctx.nav.bucket_scroll;
   ctx.nav.history_detail_scroll[slot]=ctx.nav.bucket_detail_scroll;
   ctx.nav.history_symbol_scroll[slot]=ctx.nav.symbol_scroll;
   ctx.nav.history_stat_scroll[slot]=ctx.nav.stat_scroll;
   ctx.nav.history_bucket_mode_scroll[slot]=ctx.nav.bucket_mode_scroll;
   ctx.nav.history_bucket_page[slot]=ctx.nav.bucket_page;
   ctx.nav.history_sub_bucket_page[slot]=ctx.nav.sub_bucket_page;
   ctx.nav.history_bucket_symbol_page[slot]=ctx.nav.bucket_symbol_page;
   ctx.nav.history_market_filter[slot]=(int)ctx.nav.market_filter;
   ctx.nav.history_count++;
  }

void ASC_ExplorerOpenView(ASC_ExplorerContext &ctx,const ASC_ExplorerView view)
  {
   if(ctx.nav.current_view==view)
      return;
   ASC_ExplorerPushHistory(ctx);
   ctx.nav.current_view=view;
   ctx.nav.dirty=true;
  }

void ASC_ExplorerGoHome(ASC_ExplorerContext &ctx)
  {
   string before=ASC_ExplorerNavVisualSignature(ctx);
   int history_before=ctx.nav.history_count;
   ctx.nav.current_view=ASC_EXPLORER_VIEW_OVERVIEW;
   ctx.nav.history_count=0;
   ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_NONE;
   ctx.nav.selected_seed_symbol="";
   ctx.nav.selected_sub_bucket_key="";
   ctx.nav.selected_sub_bucket_index=-1;
   ctx.nav.selected_symbol_index=-1;
   ctx.nav.bucket_display_mode=ASC_BUCKET_DISPLAY_TOP_3;
   ctx.nav.bucket_page=0;
   ctx.nav.sub_bucket_page=0;
   ctx.nav.bucket_symbol_page=0;
   ctx.nav.market_filter=ASC_EXPLORER_FILTER_ALL_SYMBOLS;
   ctx.nav.dirty=(before!=ASC_ExplorerNavVisualSignature(ctx) || history_before>0);
  }

void ASC_ExplorerGoBack(ASC_ExplorerContext &ctx)
  {
   if(ctx.nav.history_count<=0)
     {
      ASC_ExplorerGoHome(ctx);
      return;
     }

   string before=ASC_ExplorerNavVisualSignature(ctx);
   ctx.nav.history_count--;
   int slot=ctx.nav.history_count;
   ctx.nav.current_view=ctx.nav.history_views[slot];
   ctx.nav.selected_bucket_index=ctx.nav.history_bucket[slot];
   ctx.nav.selected_symbol_index=ctx.nav.history_symbol[slot];
   ctx.nav.selected_sub_bucket_index=ctx.nav.history_sub_bucket[slot];
   ctx.nav.selected_stat_view=(ASC_ExplorerStatView)ctx.nav.history_stat[slot];
   ctx.nav.bucket_display_mode=(ASC_ExplorerBucketDisplayMode)StringToInteger(ctx.nav.history_bucket_mode[slot]);
   ctx.nav.selected_seed_symbol=ctx.nav.history_seed_symbol[slot];
   ctx.nav.selected_sub_bucket_key=ctx.nav.history_sub_bucket_key[slot];
   ctx.nav.bucket_scroll=ctx.nav.history_bucket_scroll[slot];
   ctx.nav.bucket_detail_scroll=ctx.nav.history_detail_scroll[slot];
   ctx.nav.symbol_scroll=ctx.nav.history_symbol_scroll[slot];
   ctx.nav.stat_scroll=ctx.nav.history_stat_scroll[slot];
   ctx.nav.bucket_mode_scroll=ctx.nav.history_bucket_mode_scroll[slot];
   ctx.nav.bucket_page=ctx.nav.history_bucket_page[slot];
   ctx.nav.sub_bucket_page=ctx.nav.history_sub_bucket_page[slot];
   ctx.nav.bucket_symbol_page=ctx.nav.history_bucket_symbol_page[slot];
   ctx.nav.market_filter=(ASC_ExplorerMarketFilter)ctx.nav.history_market_filter[slot];
   ctx.nav.dirty=(before!=ASC_ExplorerNavVisualSignature(ctx));
  }

bool ASC_ExplorerReadDouble(const string symbol,const ENUM_SYMBOL_INFO_DOUBLE property,double &value)
  {
   value=0.0;
   return(SymbolInfoDouble(symbol,property,value));
  }

int ASC_ExplorerSymbolDigits(const string symbol)
  {
   long digits=0;
   if(!SymbolInfoInteger(symbol,SYMBOL_DIGITS,digits))
      return(5);
   return((int)digits);
  }

string ASC_ExplorerViewText(const ASC_ExplorerView view)
  {
   switch(view)
     {
      case ASC_EXPLORER_VIEW_BUCKETS: return("Main Buckets");
      case ASC_EXPLORER_VIEW_SUB_BUCKETS: return("Sub-Buckets");
      case ASC_EXPLORER_VIEW_BUCKET_DETAIL: return("Symbols");
      case ASC_EXPLORER_VIEW_SYMBOL_DETAIL: return("Symbol");
      case ASC_EXPLORER_VIEW_STAT_DETAIL: return("Details");
      default: return("Overview");
     }
  }

string ASC_ExplorerStatText(const ASC_ExplorerStatView view)
  {
   switch(view)
     {
      case ASC_EXPLORER_STAT_IDENTITY: return("Identity");
      case ASC_EXPLORER_STAT_MARKET_STATE: return("Market State");
      case ASC_EXPLORER_STAT_TICK_QUOTE: return("Tick and Quote");
      case ASC_EXPLORER_STAT_RUNTIME_PUBLICATION: return("Runtime and Publication");
      case ASC_EXPLORER_STAT_FUTURE_SURFACES: return("Current Scope");
     }
   return("Overview");
  }

void ASC_ExplorerCounts(ASC_SymbolState &states[],const int count,int &open_count,int &closed_count,int &uncertain_count,int &unknown_count,int &due_count)
  {
   open_count=0;
   closed_count=0;
   uncertain_count=0;
   unknown_count=0;
   due_count=0;
   for(int i=0;i<count;i++)
     {
      if(states[i].dirty || states[i].is_due_now)
         due_count++;
      switch(states[i].market_status)
        {
         case ASC_MARKET_OPEN: open_count++; break;
         case ASC_MARKET_CLOSED: closed_count++; break;
         case ASC_MARKET_UNCERTAIN: uncertain_count++; break;
         default: unknown_count++; break;
        }
     }
  }

void ASC_ExplorerBuildLayer1Overview(const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count,ASC_ExplorerLayer1Overview &overview,int &due_count)
  {
   overview.discovered_count=count;
   overview.open_count=0;
   overview.closed_count=0;
   overview.uncertain_count=0;
   overview.unknown_count=0;
   overview.classified_count=prepared.total_resolved_symbols;
   overview.unresolved_count=prepared.unresolved_count;
   overview.warmup_ready_count=runtime.initial_symbols_assessed;
   due_count=0;
   for(int i=0;i<count;i++)
     {
      if(states[i].dirty || states[i].is_due_now)
         due_count++;
      switch(states[i].market_status)
        {
         case ASC_MARKET_OPEN: overview.open_count++; break;
         case ASC_MARKET_CLOSED: overview.closed_count++; break;
         case ASC_MARKET_UNCERTAIN: overview.uncertain_count++; break;
         default: overview.unknown_count++; break;
        }
     }
  }

string ASC_ExplorerSelectedBucketName(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared)
  {
   ASC_BucketViewModel bucket;
   if(ASC_ExplorerResolveFilteredBucketSelection(ctx,prepared,bucket)<0)
      return("Main Bucket");
   return(bucket.name);
  }

string ASC_ExplorerSelectedSymbolName(ASC_ExplorerContext &ctx,ASC_SymbolState &states[],const int count)
  {
   if(ctx.nav.selected_symbol_index>=0 && ctx.nav.selected_symbol_index<count)
      return(states[ctx.nav.selected_symbol_index].symbol);
   if(ctx.nav.selected_seed_symbol!="")
      return(ctx.nav.selected_seed_symbol);
   return("Symbol");
  }

bool ASC_ExplorerHasFocusedSymbolView(const ASC_ExplorerContext &ctx)
  {
   return(ctx.nav.current_view==ASC_EXPLORER_VIEW_SYMBOL_DETAIL
          || ctx.nav.current_view==ASC_EXPLORER_VIEW_STAT_DETAIL);
  }

string ASC_ExplorerActiveFocusedSymbolName(ASC_ExplorerContext &ctx,ASC_SymbolState &states[],const int count)
  {
   if(!ASC_ExplorerHasFocusedSymbolView(ctx))
      return("");
   string symbol=ASC_ExplorerSelectedSymbolName(ctx,states,count);
   if(symbol=="" || symbol=="Symbol")
      return("");
   return(symbol);
  }

int ASC_ExplorerFindPreparedSymbolIndex(const ASC_PreparedBucketState &prepared,const string live_symbol)
  {
   for(int i=0;i<ArraySize(prepared.symbols);i++)
     {
      if(prepared.symbols[i].live_symbol==live_symbol || ASC_SymbolsMatchCanonical(prepared.symbols[i].live_symbol,live_symbol))
         return(i);
     }
   return(-1);
  }

string ASC_ExplorerSnapshotStatusLine(const ASC_SymbolState &state)
  {
   string status=ASC_SnapshotReadinessText(state.snapshot_readiness);
   if(state.snapshot_has_last_good)
     {
      if(state.snapshot_last_good_preserved)
         status+=" | last-good preserved";
      else
         status+=" | continuity available";
     }
   return(status);
  }

string ASC_ExplorerSymbolRoleLine(const ASC_BucketPreparedSymbol &prepared_symbol)
  {
   string role=(prepared_symbol.bucket_name!="" ? prepared_symbol.bucket_name : "Grouped symbol");
   if(prepared_symbol.secondary_group_name!="")
      role+=" | " + prepared_symbol.secondary_group_name;
   else if(prepared_symbol.theme_bucket!="")
      role+=" | " + prepared_symbol.theme_bucket;
   if(prepared_symbol.sector!="")
      role+=" | " + prepared_symbol.sector;
   return(role);
  }

string ASC_ExplorerSymbolOperatorSummary(const ASC_SymbolState &state,const ASC_BucketPreparedSymbol &prepared_symbol)
  {
   if(state.market_status==ASC_MARKET_OPEN)
     {
      if(state.shortlist_selected)
         return("Tradable now, currently shortlisted, and ready for closer operator inspection.");
      if(state.filter_eligible)
         return("Tradable now and has cleared the cheap filter gates for shortlist competition.");
      return("Tradable now, but it has not cleared the current filter path for shortlist competition.");
     }

   if(state.market_status==ASC_MARKET_UNCERTAIN)
      return("Market state is uncertain, so this symbol still needs confirmation before it can be trusted as a live opportunity.");

   if(state.market_status==ASC_MARKET_CLOSED)
      return("Currently outside its active session; keep it on the map, but not in the immediate tradable set.");

   if(prepared_symbol.bucket_name!="")
      return("Tracked inside the current market map, but broker status is still too incomplete for a stronger operator read.");

   return("Tracked by the explorer, but current broker state is still too thin for a stronger operator read.");
  }


int ASC_ExplorerFindSubBucketIndexByKey(const ASC_SubBucketViewModel &sub_buckets[],const string key)
  {
   for(int i=0;i<ArraySize(sub_buckets);i++)
     {
      if(sub_buckets[i].key==key)
         return(i);
     }
   return(-1);
  }

void ASC_ExplorerSyncSelectionState(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count)
  {
   ASC_BucketViewModel filtered_buckets[];
   int source_indices[];
   int bucket_total=ASC_PreparedFilteredBuckets(prepared,ctx.nav.market_filter,filtered_buckets,source_indices);
   if(bucket_total<=0)
     {
      ctx.nav.selected_bucket_index=-1;
      ctx.nav.selected_sub_bucket_index=-1;
      ctx.nav.selected_sub_bucket_key="";
      ctx.nav.selected_symbol_index=-1;
      return;
     }
   if(ctx.nav.selected_bucket_index<0)
      ctx.nav.selected_bucket_index=0;
   if(ctx.nav.selected_bucket_index>=bucket_total)
      ctx.nav.selected_bucket_index=bucket_total-1;

   ASC_SubBucketViewModel filtered_sub_buckets[];
   int sub_total=ASC_PreparedFilteredSubBuckets(prepared,filtered_buckets[ctx.nav.selected_bucket_index].bucket_id,ctx.nav.market_filter,filtered_sub_buckets);
   if(sub_total<=0)
     {
      ctx.nav.selected_sub_bucket_index=-1;
      ctx.nav.selected_sub_bucket_key="";
      ctx.nav.bucket_symbol_page=0;
     }
   else
     {
      int resolved_index=-1;
      if(ctx.nav.selected_sub_bucket_key!="")
         resolved_index=ASC_ExplorerFindSubBucketIndexByKey(filtered_sub_buckets,ctx.nav.selected_sub_bucket_key);
      if(resolved_index<0 && ctx.nav.selected_sub_bucket_index>=0 && ctx.nav.selected_sub_bucket_index<sub_total)
         resolved_index=ctx.nav.selected_sub_bucket_index;
      if(resolved_index<0)
         resolved_index=0;
      ctx.nav.selected_sub_bucket_index=resolved_index;
      ctx.nav.selected_sub_bucket_key=filtered_sub_buckets[resolved_index].key;
    }

   if(ctx.nav.selected_symbol_index<0 && ctx.nav.selected_seed_symbol!="")
     {
      for(int i=0;i<count;i++)
        {
         if(states[i].symbol==ctx.nav.selected_seed_symbol || ASC_SymbolsMatchCanonical(states[i].symbol,ctx.nav.selected_seed_symbol))
           {
            ctx.nav.selected_symbol_index=i;
            break;
           }
        }
     }
   if(ctx.nav.selected_symbol_index>=count)
      ctx.nav.selected_symbol_index=-1;
  }

string ASC_ExplorerBreadcrumbText(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count)
  {
   string path="Home / Overview";
   if(ctx.nav.current_view==ASC_EXPLORER_VIEW_BUCKETS)
      path="Home / Main Buckets";
   else if(ctx.nav.current_view==ASC_EXPLORER_VIEW_SUB_BUCKETS)
      path="Home / Main Buckets / " + ASC_ExplorerSelectedBucketName(ctx,prepared);
   else if(ctx.nav.current_view==ASC_EXPLORER_VIEW_BUCKET_DETAIL)
      path="Home / Main Buckets / " + ASC_ExplorerSelectedBucketName(ctx,prepared) + " / " + ASC_ExplorerSelectedSubBucketName(ctx,prepared);
   else if(ctx.nav.current_view==ASC_EXPLORER_VIEW_SYMBOL_DETAIL)
      path="Home / Main Buckets / " + ASC_ExplorerSelectedBucketName(ctx,prepared) + " / " + ASC_ExplorerSelectedSubBucketName(ctx,prepared) + " / " + ASC_ExplorerSelectedSymbolName(ctx,states,count);
   else if(ctx.nav.current_view==ASC_EXPLORER_VIEW_STAT_DETAIL)
      path="Home / Main Buckets / " + ASC_ExplorerSelectedBucketName(ctx,prepared) + " / " + ASC_ExplorerSelectedSubBucketName(ctx,prepared) + " / " + ASC_ExplorerSelectedSymbolName(ctx,states,count) + " / " + ASC_ExplorerStatText(ctx.nav.selected_stat_view);
   return(path);
  }

void ASC_ExplorerSummaryCard(ASC_ExplorerContext &ctx,const string id,const string title,const string line1,const string line2,const string line3,const int x,const int y,const int w,const int h,const color accent)
  {
   ASC_ExplorerRect(ctx,id + ".card",x,y,w,h,ctx.theme.panel_fill,ctx.theme.border);
   ASC_ExplorerRect(ctx,id + ".bar",x,y,6,h,accent,accent);
   ASC_ExplorerLabel(ctx,id + ".title",ASC_ExplorerFitText(title,w-24,10),x+14,y+6,ctx.theme.text,10);
   ASC_ExplorerLabel(ctx,id + ".line1",ASC_ExplorerFitText(line1,w-24),x+14,y+24,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,id + ".line2",ASC_ExplorerFitText(line2,w-24),x+14,y+24+ctx.theme.row_height,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,id + ".line3",ASC_ExplorerFitText(line3,w-24),x+14,y+24+(ctx.theme.row_height*2),ctx.theme.muted);
  }

string ASC_ExplorerBucketSymbolTraceLine(const ASC_BucketPreparedSymbol &prepared_symbol,ASC_SymbolState &states[],const int count)
  {
   bool filter_eligible=false;
   bool shortlist_selected=false;
   if(prepared_symbol.symbol_state_index>=0 && prepared_symbol.symbol_state_index<count)
     {
      filter_eligible=states[prepared_symbol.symbol_state_index].filter_eligible;
      shortlist_selected=states[prepared_symbol.symbol_state_index].shortlist_selected;
     }
   string review=(prepared_symbol.review_status=="" ? "N/A" : prepared_symbol.review_status);
   return("Filter " + ASC_BoolText(filter_eligible) + " | Shortlist " + ASC_BoolText(shortlist_selected) + " | Review " + review);
  }


void ASC_ExplorerRenderOverview(ASC_ExplorerContext &ctx,const ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count,const int x,const int y,const int w,const int h)
  {
   ASC_ExplorerLayer1Overview overview;
   int due_count=0;
   int eligible_count=0;
   int shortlist_count=0;
   ASC_ExplorerBuildLayer1Overview(runtime,prepared,states,count,overview,due_count);
   for(int i=0;i<count;i++)
     {
      if(states[i].filter_eligible && states[i].filter_readiness==ASC_FILTER_ELIGIBLE)
         eligible_count++;
      if(states[i].shortlist_selected && states[i].shortlist_readiness==ASC_SHORTLIST_SELECTED)
         shortlist_count++;
     }

   int gap=ctx.theme.gap;
   int hero_h=80;
   if(hero_h>h/3)
      hero_h=h/3;
   int body_y=y+hero_h+gap;
   int body_h=h-hero_h-gap;
   if(body_h<120)
      body_h=120;
   int card_w=(w-gap)/2;
   int card_h=(body_h-gap)/2;
   if(card_h<72)
      card_h=72;

   color hero_accent=(runtime.degraded ? ctx.theme.warning : (runtime.mode==ASC_RUNTIME_WARMUP ? ctx.theme.warning : ctx.theme.good));
   ASC_ExplorerRect(ctx,"overview.hero",x,y,w,hero_h,ctx.theme.panel_soft_fill,ctx.theme.border);
   ASC_ExplorerRect(ctx,"overview.hero.bar",x,y,5,hero_h,hero_accent,hero_accent);
   ASC_ExplorerLabel(ctx,"overview.hero.title",ASC_PRODUCT_NAME + " — Market Map",x+14,y+8,ctx.theme.text,11);
   ASC_ExplorerLabel(ctx,"overview.hero.line1",ASC_ExplorerFitText("Mode " + ASC_RuntimeModeText(runtime.mode) + " | Ready " + IntegerToString(runtime.readiness_percent) + "% | Open " + IntegerToString(overview.open_count) + " | Eligible " + IntegerToString(eligible_count) + " | Shortlist " + IntegerToString(shortlist_count),w-28,10),x+14,y+28,hero_accent,10);
   ASC_ExplorerLabel(ctx,"overview.hero.line2",ASC_ExplorerFitText("Warmup " + IntegerToString(runtime.initial_symbols_assessed) + "/" + IntegerToString(runtime.total_symbols_discovered) + " | Layer 1 boot " + ASC_BoolText(runtime.layer1_boot_complete) + " | Server " + runtime.server_clean,w-28),x+14,y+28+ctx.theme.row_height,ctx.theme.dim);
   ASC_ExplorerLabel(ctx,"overview.hero.line3",ASC_ExplorerFitText("Use Buckets to move from market map to working groups, then open Symbol for live state and Details for diagnostics.",w-28),x+14,y+28+(ctx.theme.row_height*2),ctx.theme.dim);

   ASC_ExplorerSummaryCard(ctx,"overview.runtime","Runtime","Mode " + ASC_RuntimeModeText(runtime.mode),"Readiness " + IntegerToString(runtime.readiness_percent) + "% | Render " + ASC_ExplorerTimingMsText(ctx.nav.last_render_duration_ms),"Explorer " + ASC_EXPLORER_SUBSYSTEM_VERSION + " | Server " + runtime.server_clean,x,body_y,card_w,card_h,hero_accent);
   ASC_ExplorerSummaryCard(ctx,"overview.universe","Universe","Tracked " + IntegerToString(overview.discovered_count),"Open " + IntegerToString(overview.open_count) + " | Closed " + IntegerToString(overview.closed_count) + " | Uncertain " + IntegerToString(overview.uncertain_count),"Grouped " + IntegerToString(overview.classified_count) + " | Unresolved " + IntegerToString(overview.unresolved_count),x+card_w+gap,body_y,card_w,card_h,ctx.theme.accent_alt);
   ASC_ExplorerSummaryCard(ctx,"overview.pipeline","Pipeline","Due now " + IntegerToString(due_count),"Eligible " + IntegerToString(eligible_count) + " | Shortlist " + IntegerToString(shortlist_count),"Hydration batches " + IntegerToString(prepared.diagnostics.promoted_batch_count) + "/" + IntegerToString(ASC_PREPARED_BATCH_COUNT),x,body_y+card_h+gap,card_w,card_h,ctx.theme.accent);
   ASC_ExplorerSummaryCard(ctx,"overview.attention","Attention","Degraded " + ASC_BoolText(runtime.degraded),"Layer 1 boot " + ASC_BoolText(runtime.layer1_boot_complete),"Last heartbeat " + ASC_DateTimeText(runtime.last_heartbeat_at),x+card_w+gap,body_y+card_h+gap,card_w,card_h,(runtime.degraded ? ctx.theme.warning : ctx.theme.good));
  }

void ASC_ExplorerRenderPageButtons(ASC_ExplorerContext &ctx,const string id_prefix,const int page_index,const int page_count,const int x,const int y,const int max_width)
  {
   ASC_ExplorerRenderPager(ctx,id_prefix,page_index,page_count,x,y,max_width);
  }

void ASC_ExplorerRenderBucketList(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,const int x,const int y,const int w,const int h)
  {
   ASC_ExplorerSyncSelectionState(ctx,prepared,g_symbols,g_symbol_count);
   ASC_BucketViewModel filtered[];
   int source_indices[];
   int total=ASC_PreparedFilteredBuckets(prepared,ctx.nav.market_filter,filtered,source_indices);

   int row_h=(ctx.theme.row_height*3)+18;
   int intro_h=(ctx.theme.row_height*2)+16;
   int footer_h=ctx.theme.button_height+ctx.theme.gap+4;
   int available=(h-ctx.theme.title_height-intro_h-footer_h-(ctx.theme.gap*3));
   int rows_per_page=ASC_ExplorerVisibleRows(ctx,available,row_h+ctx.theme.gap);
   int total_pages=ASC_ExplorerPageCount(total,rows_per_page);
   ASC_ExplorerClampPage(ctx.nav.bucket_page,total,rows_per_page);

   ASC_ExplorerPanelTitle(ctx,"buckets.panel","Main Buckets",x,y,w,ctx.theme.accent);
   ASC_ExplorerRect(ctx,"buckets.intro",x,y+ctx.theme.title_height,w,intro_h,ctx.theme.panel_soft_fill,ctx.theme.border);
   string filter_note=(ctx.nav.market_filter==ASC_EXPLORER_FILTER_OPEN_ONLY ? "Open Only shows groups that already contain open tracked symbols from prepared truth." : "All Symbols shows the current prepared grouping view; this is downstream organization and does not control Layer 1 warmup or boot state.");
   if(prepared.unresolved_count>0)
      filter_note+=" Unresolved live symbols: " + IntegerToString(prepared.unresolved_count) + ".";
   string buckets_note_l1="";
   string buckets_note_l2="";
   ASC_ExplorerFitTextTwoLines(filter_note,w-(ctx.theme.padding*2)-8,buckets_note_l1,buckets_note_l2);
   ASC_ExplorerLabel(ctx,"buckets.note.1",buckets_note_l1,x+ctx.theme.padding,y+ctx.theme.title_height+6,ctx.theme.muted);
   if(buckets_note_l2!="")
      ASC_ExplorerLabel(ctx,"buckets.note.2",buckets_note_l2,x+ctx.theme.padding,y+ctx.theme.title_height+6+ctx.theme.row_height,ctx.theme.dim);

   int start=ctx.nav.bucket_page*rows_per_page;
   int end=start+rows_per_page;
   if(end>total)
      end=total;
   int row_y=y+ctx.theme.title_height+intro_h+ctx.theme.gap;
   for(int i=start;i<end;i++)
     {
      int visual=i-start;
      int card_y=row_y+(visual*(row_h+ctx.theme.gap));
      int live_visible=ASC_PreparedVisibleBucketCount(filtered[i],ctx.nav.market_filter);
      bool selected=(i==ctx.nav.selected_bucket_index);
      color fill=(selected ? ctx.theme.selected_soft_fill : ctx.theme.panel_fill);
      color accent=(live_visible>0 ? ctx.theme.good : ctx.theme.warning);
      ASC_ExplorerRect(ctx,"buckets.card." + IntegerToString(i),x,card_y,w,row_h,fill,accent);
      ASC_ExplorerLabel(ctx,"buckets.name." + IntegerToString(i),ASC_ExplorerFitText(filtered[i].name,w-160,10),x+14,card_y+6,ctx.theme.text,10);
      int eligible_count=ASC_PreparedBucketEligibleCount(g_prepared_buckets,filtered[i],g_symbols,g_symbol_count);
      string truth_line="Status " + filtered[i].progress_label + " | Open " + IntegerToString(filtered[i].open_symbol_count) + " / " + IntegerToString(filtered[i].resolved_symbol_count) + " (" + ASC_ExplorerPercentText(filtered[i].open_symbol_count,filtered[i].resolved_symbol_count) + ") of grouped | Eligible " + IntegerToString(eligible_count) + " | Universe share " + ASC_ExplorerPercentText(filtered[i].resolved_symbol_count,prepared.total_resolved_symbols) + " | " + filtered[i].note;
      if(filtered[i].progress_state==ASC_PREPARED_BUCKET_BACKGROUND_ENRICH_PENDING)
         truth_line+=" | richer detail still syncing";
      else if(filtered[i].progress_state==ASC_PREPARED_BUCKET_PREPARING)
         truth_line+=" | syncing now";
      if(ctx.nav.market_filter==ASC_EXPLORER_FILTER_OPEN_ONLY)
         truth_line="Status " + filtered[i].progress_label + " | Open visible " + IntegerToString(live_visible) + "/" + IntegerToString(filtered[i].resolved_symbol_count) + " (" + ASC_ExplorerPercentText(live_visible,filtered[i].resolved_symbol_count) + ") of grouped | Eligible " + IntegerToString(eligible_count) + " | " + filtered[i].note;
      ASC_ExplorerLabel(ctx,"buckets.summary." + IntegerToString(i),ASC_ExplorerFitText(truth_line,w-160),x+14,card_y+24,accent);
      ASC_ExplorerButton(ctx,"action.bucket." + IntegerToString(i),"View",x+w-82,card_y+((row_h-ctx.theme.button_height)/2),70,ctx.theme.button_height,ctx.theme.accent,selected);
     }

   if(total<=0)
      ASC_ExplorerLabel(ctx,"buckets.empty","No buckets satisfy the current operator filter yet.",x+ctx.theme.padding,row_y+6,ctx.theme.warning);

   int footer_y=y+h-footer_h;
   if(total_pages>1)
     {
      ASC_ExplorerRenderPager(ctx,"action.bucket_page",ctx.nav.bucket_page,total_pages,x+ctx.theme.padding,footer_y,w-(ctx.theme.padding*2));
     }
  }


void ASC_ExplorerRenderSubBucketList(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,const int x,const int y,const int w,const int h)
  {
   ASC_ExplorerSyncSelectionState(ctx,prepared,g_symbols,g_symbol_count);
   ASC_BucketViewModel bucket;
   if(ASC_ExplorerResolveFilteredBucketSelection(ctx,prepared,bucket)<0)
     {
      ASC_ExplorerRect(ctx,"subbuckets.empty",x,y,w,h,ctx.theme.panel_fill,ctx.theme.border);
      ASC_ExplorerLabel(ctx,"subbuckets.empty.title","Sub-Buckets",x+ctx.theme.padding,y+8,ctx.theme.text,11);
      ASC_ExplorerLabel(ctx,"subbuckets.empty.note","No main bucket currently matches the operator filter.",x+ctx.theme.padding,y+32,ctx.theme.warning);
      return;
     }

   ASC_SubBucketViewModel filtered[];
   int total=ASC_PreparedFilteredSubBuckets(prepared,bucket.bucket_id,ctx.nav.market_filter,filtered);

   int row_h=(ctx.theme.row_height*3)+18;
   int intro_h=(ctx.theme.row_height*2)+16;
   int footer_h=ctx.theme.button_height+ctx.theme.gap+4;
   int available=(h-ctx.theme.title_height-intro_h-footer_h-(ctx.theme.gap*3));
   int rows_per_page=ASC_ExplorerVisibleRows(ctx,available,row_h+ctx.theme.gap);
   int total_pages=ASC_ExplorerPageCount(total,rows_per_page);
   ASC_ExplorerClampPage(ctx.nav.sub_bucket_page,total,rows_per_page);

   ASC_ExplorerPanelTitle(ctx,"subbuckets.panel",bucket.name + " / Groups",x,y,w,ctx.theme.accent);
   ASC_ExplorerRect(ctx,"subbuckets.intro",x,y+ctx.theme.title_height,w,intro_h,ctx.theme.panel_soft_fill,ctx.theme.border);
   string filter_note="These groups refine the selected main bucket so the operator can move from broad market map to a usable working set.";
   if(ctx.nav.market_filter==ASC_EXPLORER_FILTER_OPEN_ONLY)
      filter_note+=" Open Only hides groups with no live open symbols.";
   else
      filter_note+=" All Symbols keeps the full current grouping visible, even when some names are only context right now.";
   string sub_note_l1="";
   string sub_note_l2="";
   ASC_ExplorerFitTextTwoLines(filter_note,w-(ctx.theme.padding*2)-8,sub_note_l1,sub_note_l2);
   ASC_ExplorerLabel(ctx,"subbuckets.note.1",sub_note_l1,x+ctx.theme.padding,y+ctx.theme.title_height+6,ctx.theme.muted);
   if(sub_note_l2!="")
      ASC_ExplorerLabel(ctx,"subbuckets.note.2",sub_note_l2,x+ctx.theme.padding,y+ctx.theme.title_height+6+ctx.theme.row_height,ctx.theme.dim);

   int start=ctx.nav.sub_bucket_page*rows_per_page;
   int end=start+rows_per_page;
   if(end>total)
      end=total;
   int row_y=y+ctx.theme.title_height+intro_h+ctx.theme.gap;
   for(int i=start;i<end;i++)
     {
      int visual=i-start;
      int card_y=row_y+(visual*(row_h+ctx.theme.gap));
      bool selected=(i==ctx.nav.selected_sub_bucket_index);
      color fill=(selected ? ctx.theme.selected_soft_fill : ctx.theme.panel_fill);
      color accent=(filtered[i].open_symbol_count>0 ? ctx.theme.good : ctx.theme.warning);
      ASC_ExplorerRect(ctx,"subbuckets.card." + IntegerToString(i),x,card_y,w,row_h,fill,accent);
      ASC_ExplorerLabel(ctx,"subbuckets.name." + IntegerToString(i),ASC_ExplorerFitText(filtered[i].name,w-160,10),x+14,card_y+6,ctx.theme.text,10);
      int eligible_count=ASC_PreparedSubBucketEligibleCount(g_prepared_buckets,filtered[i],g_symbols,g_symbol_count);
      string sub_summary="Open " + IntegerToString(filtered[i].open_symbol_count) + " / " + IntegerToString(filtered[i].total_symbol_count) + " | Eligible " + IntegerToString(eligible_count) + " | " + filtered[i].note;
      ASC_ExplorerLabel(ctx,"subbuckets.summary." + IntegerToString(i),ASC_ExplorerFitText(sub_summary,w-160),x+14,card_y+24,accent);
      ASC_ExplorerButton(ctx,"action.sub_bucket." + IntegerToString(i),"View",x+w-82,card_y+((row_h-ctx.theme.button_height)/2),70,ctx.theme.button_height,ctx.theme.accent,selected);
     }

   if(total<=0)
      ASC_ExplorerLabel(ctx,"subbuckets.empty.note2","No sub-buckets satisfy the current operator filter yet.",x+ctx.theme.padding,row_y+6,ctx.theme.warning);

   int footer_y=y+h-footer_h;
   if(total_pages>1)
     {
      ASC_ExplorerRenderPager(ctx,"action.sub_bucket_page",ctx.nav.sub_bucket_page,total_pages,x+ctx.theme.padding,footer_y,w-(ctx.theme.padding*2));
     }
  }

void ASC_ExplorerRenderBucketDetail(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,const int x,const int y,const int w,const int h)
  {
   ASC_ExplorerSyncSelectionState(ctx,prepared,g_symbols,g_symbol_count);
   ASC_BucketViewModel bucket;
   if(ASC_ExplorerResolveFilteredBucketSelection(ctx,prepared,bucket)<0)
     {
      ASC_ExplorerRect(ctx,"bucket.detail.empty",x,y,w,h,ctx.theme.panel_fill,ctx.theme.border);
      ASC_ExplorerLabel(ctx,"bucket.detail.empty.title","Symbol List",x+ctx.theme.padding,y+8,ctx.theme.text,11);
      ASC_ExplorerLabel(ctx,"bucket.detail.empty.note","No main bucket currently matches the operator filter.",x+ctx.theme.padding,y+32,ctx.theme.warning);
      return;
     }

   ASC_SubBucketViewModel sub_bucket;
   if(ASC_ExplorerResolveFilteredSubBucketSelection(ctx,prepared,bucket.bucket_id,sub_bucket)<0)
     {
      ASC_ExplorerRect(ctx,"bucket.detail.sub.empty",x,y,w,h,ctx.theme.panel_fill,ctx.theme.border);
      ASC_ExplorerLabel(ctx,"bucket.detail.sub.empty.title","Symbol List",x+ctx.theme.padding,y+8,ctx.theme.text,11);
      ASC_ExplorerLabel(ctx,"bucket.detail.sub.empty.note","No sub-bucket currently matches the operator filter.",x+ctx.theme.padding,y+32,ctx.theme.warning);
      return;
     }

   int footer_h=ctx.theme.button_height+ctx.theme.gap+4;
   int row_h=(ctx.theme.row_height*3)+18;
   int available=(h-ctx.theme.title_height-footer_h-(ctx.theme.gap*3)-40);
   int rows_per_page=ASC_ExplorerVisibleRows(ctx,available,row_h+ctx.theme.gap);

   ASC_BucketPreparedSymbol visible_symbols[];
   ASC_PreparedSubBucketSymbols(prepared,sub_bucket,ctx.nav.market_filter,visible_symbols);
   int capped_total=ArraySize(visible_symbols);
   ASC_ExplorerClampPage(ctx.nav.bucket_symbol_page,capped_total,rows_per_page);
   int lane_start=ctx.nav.bucket_symbol_page*rows_per_page;
   int lane_end=lane_start+rows_per_page;
   if(lane_end>capped_total)
      lane_end=capped_total;
   int symbol_pages=ASC_ExplorerPageCount(capped_total,rows_per_page);

   int sub_bucket_eligible_count=ASC_PreparedSubBucketEligibleCount(g_prepared_buckets,sub_bucket,g_symbols,g_symbol_count);
   ASC_ExplorerPanelTitle(ctx,"bucket.detail.header",bucket.name + " / " + sub_bucket.name + " / Symbols",x,y,w,ctx.theme.accent);
   ASC_ExplorerRect(ctx,"bucket.detail.meta",x,y+ctx.theme.title_height,w,56,ctx.theme.panel_soft_fill,ctx.theme.border);
   string bucket_meta_left="Group Open " + IntegerToString(sub_bucket.open_symbol_count) + " / " + IntegerToString(sub_bucket.total_symbol_count) + " | Eligible " + IntegerToString(sub_bucket_eligible_count);
   string bucket_meta_right_l1="";
   string bucket_meta_right_l2="";
   ASC_ExplorerFitTextTwoLines(sub_bucket.note,w-(ctx.theme.padding*2)-8,bucket_meta_right_l1,bucket_meta_right_l2);
   ASC_ExplorerLabel(ctx,"bucket.detail.meta.left",ASC_ExplorerFitText(bucket_meta_left,w-(ctx.theme.padding*2)-8),x+ctx.theme.padding,y+ctx.theme.title_height+6,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,"bucket.detail.meta.right.1",bucket_meta_right_l1,x+ctx.theme.padding,y+ctx.theme.title_height+6+ctx.theme.row_height,ctx.theme.dim);
   if(bucket_meta_right_l2!="")
      ASC_ExplorerLabel(ctx,"bucket.detail.meta.right.2",bucket_meta_right_l2,x+ctx.theme.padding,y+ctx.theme.title_height+6+(ctx.theme.row_height*2),ctx.theme.dim);

   int list_y=y+ctx.theme.title_height+56+ctx.theme.gap;
   for(int i=lane_start;i<lane_end;i++)
     {
      int visual=i-lane_start;
      int card_y=list_y+(visual*(row_h+ctx.theme.gap));
      color accent=ASC_ExplorerStatusAccent(ctx,visible_symbols[i].market_status,true);
      ASC_ExplorerRect(ctx,"bucket.detail.seed." + IntegerToString(i),x,card_y,w,row_h,ctx.theme.panel_fill,accent);
      ASC_ExplorerLabel(ctx,"bucket.detail.seed.sym." + IntegerToString(i),ASC_ExplorerFitText(visible_symbols[i].live_symbol,w-160,10),x+14,card_y+6,ctx.theme.text,10);
      string symbol_summary="State " + ASC_MarketStatusText(visible_symbols[i].market_status) + " | Group " + (visible_symbols[i].bucket_name=="" ? bucket.name : visible_symbols[i].bucket_name) + " | Eligible/Shortlist " + ASC_ExplorerBucketSymbolTraceLine(visible_symbols[i],g_symbols,g_symbol_count);
      ASC_ExplorerLabel(ctx,"bucket.detail.seed.summary." + IntegerToString(i),ASC_ExplorerFitText(symbol_summary,w-160),x+14,card_y+24,ctx.theme.muted);
      ASC_ExplorerButton(ctx,"action.seed_symbol." + IntegerToString(i),"Detail",x+w-82,card_y+((row_h-ctx.theme.button_height)/2),70,ctx.theme.button_height,ctx.theme.accent,false);
     }

   if(capped_total<=0)
      ASC_ExplorerLabel(ctx,"bucket.detail.emptylane",ASC_ExplorerFitText("No symbols are visible for this sub-bucket under the current operator filter.",w-24),x+ctx.theme.padding,list_y+6,ctx.theme.warning);

   int footer_y=y+h-footer_h;
   if(symbol_pages>1)
     {
      ASC_ExplorerRenderPager(ctx,"action.bucket_symbol_page",ctx.nav.bucket_symbol_page,symbol_pages,x+ctx.theme.padding,footer_y,w-(ctx.theme.padding*2));
     }
  }

void ASC_ExplorerSectionPanel(ASC_ExplorerContext &ctx,const string id,const string title,const string l1,const string l2,const string l3,const int x,const int y,const int w,const int h,const bool selected,const color accent)
  {
   color stripe=(accent==C'0,0,0' ? ctx.theme.accent : accent);
   ASC_ExplorerRect(ctx,id + ".panel",x,y,w,h,(selected ? ctx.theme.selected_fill : ctx.theme.panel_fill),ctx.theme.border);
   ASC_ExplorerRect(ctx,id + ".stripe",x,y,6,h,stripe,stripe);
   ASC_ExplorerLabel(ctx,id + ".title",ASC_ExplorerFitText(title,w-24,10),x+14,y+6,ctx.theme.text,10);
   ASC_ExplorerLabel(ctx,id + ".l1",ASC_ExplorerFitText(l1,w-24),x+14,y+24,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,id + ".l2",ASC_ExplorerFitText(l2,w-24),x+14,y+24+ctx.theme.row_height,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,id + ".l3",ASC_ExplorerFitText(l3,w-24),x+14,y+24+(ctx.theme.row_height*2),ctx.theme.muted);
  }

void ASC_ExplorerRenderSymbolDetail(ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,ASC_SymbolState &states[],const int count,const int x,const int y,const int w,const int h)
  {
   ASC_ExplorerSyncSelectionState(ctx,g_prepared_buckets,states,count);
   if(count<=0 || ctx.nav.selected_symbol_index<0 || ctx.nav.selected_symbol_index>=count)
     {
      ASC_ExplorerRect(ctx,"symbol.seed.panel",x,y,w,h,ctx.theme.panel_fill,ctx.theme.border);
      ASC_ExplorerLabel(ctx,"symbol.seed.title","Symbol",x+ctx.theme.padding,y+8,ctx.theme.text,11);
      ASC_ExplorerLabel(ctx,"symbol.seed.text",ASC_ExplorerFitText("Live symbol detail is not available for the selected bucket reference yet.",w-24),x+ctx.theme.padding,y+32,ctx.theme.warning);
      ASC_ExplorerInfoRow(ctx,"symbol.seed.row1","Identity",(ctx.nav.selected_seed_symbol=="" ? "Reference pending" : ctx.nav.selected_seed_symbol),x+ctx.theme.padding,y+62,w-(ctx.theme.padding*2),ctx.theme.reserved);
      ASC_ExplorerInfoRow(ctx,"symbol.seed.row2","Market Status","Live market status appears only when the selected reference resolves to a tracked symbol.",x+ctx.theme.padding,y+92,w-(ctx.theme.padding*2),ctx.theme.warning);
      ASC_ExplorerInfoRow(ctx,"symbol.seed.row3","Publication","This shell keeps publication structure visible without inventing broker truth.",x+ctx.theme.padding,y+122,w-(ctx.theme.padding*2),ctx.theme.accent_alt);
      ASC_ExplorerInfoRow(ctx,"symbol.seed.row4","Analysis Scope","Snapshot, filter, and shortlist status appear here when the selected symbol is live and tracked.",x+ctx.theme.padding,y+152,w-(ctx.theme.padding*2),ctx.theme.reserved);
      return;
     }

   ASC_SymbolState state=states[ctx.nav.selected_symbol_index];
   int prepared_symbol_index=ASC_ExplorerFindPreparedSymbolIndex(g_prepared_buckets,state.symbol);
   ASC_BucketPreparedSymbol prepared_symbol={};
   if(prepared_symbol_index>=0)
      prepared_symbol=g_prepared_buckets.symbols[prepared_symbol_index];
   int digits=ASC_ExplorerSymbolDigits(state.symbol);
   MqlTick tick={};
   bool have_tick=SymbolInfoTick(state.symbol,tick);
   double bid=0.0,ask=0.0,day_high=0.0,day_low=0.0,point=0.0;
   long spread_points=0;
   ASC_ExplorerReadDouble(state.symbol,SYMBOL_BID,bid);
   ASC_ExplorerReadDouble(state.symbol,SYMBOL_ASK,ask);
   ASC_ExplorerReadDouble(state.symbol,SYMBOL_BIDHIGH,day_high);
   ASC_ExplorerReadDouble(state.symbol,SYMBOL_BIDLOW,day_low);
   ASC_ExplorerReadDouble(state.symbol,SYMBOL_POINT,point);
   SymbolInfoInteger(state.symbol,SYMBOL_SPREAD,spread_points);
   double spread_value=(ask>=bid ? (ask-bid) : 0.0);
   string spread_text=(spread_points>0 ? IntegerToString((int)spread_points) + " points" : (point>0.0 ? DoubleToString(spread_value/point,1) + " points" : DoubleToString(spread_value,digits)));
   string operator_summary=ASC_ExplorerSymbolOperatorSummary(state,prepared_symbol);
   string role_line=ASC_ExplorerSymbolRoleLine(prepared_symbol);
   string session_line=(state.within_trade_session ? "Inside broker session" : (state.has_trade_sessions ? "Outside broker session" : "Session data unavailable"));

   int gap=ctx.theme.gap;
   int hero_h=(ctx.theme.row_height>=20 ? 94 : 88);
   int section_w=(w-gap)/2;
   int section_h=(h-hero_h-(gap*3)-28)/2;
   if(section_h<76)
      section_h=76;
   int base_y=y+hero_h+gap;
   int footer_y=base_y+(section_h+gap)*2;

   ASC_ExplorerRect(ctx,"symbol.hero",x,y,w,hero_h,ctx.theme.panel_soft_fill,ctx.theme.border);
   ASC_ExplorerRect(ctx,"symbol.hero.bar",x,y,5,hero_h,ASC_ExplorerStatusAccent(ctx,state.market_status,true),ASC_ExplorerStatusAccent(ctx,state.market_status,true));
   ASC_ExplorerLabel(ctx,"symbol.hero.title",ASC_ExplorerFitText(state.symbol,w-220,11),x+14,y+8,ctx.theme.text,11);
   ASC_ExplorerLabel(ctx,"symbol.hero.line1",ASC_ExplorerFitText(operator_summary,w-28),x+14,y+30,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,"symbol.hero.line2",ASC_ExplorerFitText("Market " + ASC_MarketStatusText(state.market_status) + " | Session " + session_line + " | Publication " + (state.publication_ok ? "Promoted" : "Pending"),w-28),x+14,y+30+ctx.theme.row_height,ctx.theme.dim);
   ASC_ExplorerLabel(ctx,"symbol.hero.line3",ASC_ExplorerFitText("Bid " + DoubleToString(bid,digits) + " | Ask " + DoubleToString(ask,digits) + " | Spread " + spread_text + " | Next Check " + ASC_DateTimeText(state.next_check_at),w-28),x+14,y+30+(ctx.theme.row_height*2),ctx.theme.dim);

   ASC_ExplorerSectionPanel(ctx,"symbol.identity","Identity","Symbol " + state.symbol,"Server " + runtime.server_clean,role_line,x,base_y,section_w,section_h,(ctx.nav.selected_stat_view==ASC_EXPLORER_STAT_IDENTITY),ctx.theme.accent);
   ASC_ExplorerSectionPanel(ctx,"symbol.market","Market State","State " + ASC_MarketStatusText(state.market_status),"Session " + session_line,"Next Check " + ASC_DateTimeText(state.next_check_at),x+section_w+gap,base_y,section_w,section_h,(ctx.nav.selected_stat_view==ASC_EXPLORER_STAT_MARKET_STATE),ASC_ExplorerStatusAccent(ctx,state.market_status,true));
   ASC_ExplorerSectionPanel(ctx,"symbol.quote","Tick and Quote","Bid " + DoubleToString(bid,digits),"Ask " + DoubleToString(ask,digits),"Spread " + spread_text,x,base_y+section_h+gap,section_w,section_h,(ctx.nav.selected_stat_view==ASC_EXPLORER_STAT_TICK_QUOTE),ctx.theme.accent_alt);
   ASC_ExplorerSectionPanel(ctx,"symbol.runtime","Eligibility and Publication","Snapshot " + ASC_ExplorerSnapshotStatusLine(state),"Filter " + ASC_FilterReadinessText(state.filter_readiness),"Shortlist " + ASC_ShortlistReadinessText(state.shortlist_readiness),x+section_w+gap,base_y+section_h+gap,section_w,section_h,(ctx.nav.selected_stat_view==ASC_EXPLORER_STAT_RUNTIME_PUBLICATION),ctx.theme.good);

   ASC_ExplorerButton(ctx,"action.stat.identity","Open",x+section_w-84,base_y+section_h-30,74,ctx.theme.button_height,ctx.theme.panel_alt_fill);
   ASC_ExplorerButton(ctx,"action.stat.market","Open",x+w-84,base_y+section_h-30,74,ctx.theme.button_height,ctx.theme.panel_alt_fill);
   ASC_ExplorerButton(ctx,"action.stat.quote","Open",x+section_w-84,base_y+section_h+gap+section_h-30,74,ctx.theme.button_height,ctx.theme.panel_alt_fill);
   ASC_ExplorerButton(ctx,"action.stat.runtime","Open",x+w-84,base_y+section_h+gap+section_h-30,74,ctx.theme.button_height,ctx.theme.panel_alt_fill);
   ASC_ExplorerRect(ctx,"symbol.footer",x,footer_y,w,24,ctx.theme.panel_fill,ctx.theme.border);
   ASC_ExplorerLabel(ctx,"symbol.footer.text",ASC_ExplorerFitText("Current explorer scope: market state, snapshot, candidate filter, and shortlist status. Deeper analysis is intentionally outside this HUD.",w-110),x+ctx.theme.padding,footer_y+4,ctx.theme.muted);
   ASC_ExplorerButton(ctx,"action.stat.future","Scope",x+w-76,footer_y+1,64,20,ctx.theme.panel_alt_fill);
   ASC_ExplorerLabel(ctx,"symbol.tick.meta",ASC_ExplorerFitText("Day High " + DoubleToString(day_high,digits) + " | Day Low " + DoubleToString(day_low,digits) + " | Market Watch Update " + (have_tick ? ASC_DateTimeText((datetime)tick.time) : "Not Yet Available"),w-24),x+ctx.theme.padding,footer_y+26,ctx.theme.muted);
  }

void ASC_ExplorerRenderStatDetail(ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,ASC_SymbolState &states[],const int count,const int x,const int y,const int w,const int h)
  {
   ASC_ExplorerRect(ctx,"stat.panel",x,y,w,h,ctx.theme.panel_fill,ctx.theme.border);
   ASC_ExplorerLabel(ctx,"stat.title","Details",x+ctx.theme.padding,y+8,ctx.theme.text,11);
   ASC_ExplorerLabel(ctx,"stat.subtitle",ASC_ExplorerFitText(ASC_ExplorerStatText(ctx.nav.selected_stat_view),w-24),x+ctx.theme.padding,y+28,ctx.theme.muted);
   int info_top=y+58;
   int visible=ASC_ExplorerVisibleRows(ctx,h-92,30);
   if(visible>4)
      visible=4;
   int max_scroll=(4>visible ? 4-visible : 0);
   if(ctx.nav.stat_scroll<0)
      ctx.nav.stat_scroll=0;
   if(ctx.nav.stat_scroll>max_scroll)
      ctx.nav.stat_scroll=max_scroll;

   if(count<=0 || ctx.nav.selected_symbol_index<0 || ctx.nav.selected_symbol_index>=count)
     {
      ASC_ExplorerLabel(ctx,"stat.empty",ASC_ExplorerFitText("Live stat detail is not available for the selected reference symbol yet.",w-24),x+ctx.theme.padding,y+48,ctx.theme.warning);
      ASC_ExplorerInfoRow(ctx,"stat.seed.row1","Reference Symbol",(ctx.nav.selected_seed_symbol=="" ? "Reference pending" : ctx.nav.selected_seed_symbol),x+ctx.theme.padding,y+78,w-(ctx.theme.padding*2),ctx.theme.reserved);
      ASC_ExplorerInfoRow(ctx,"stat.seed.row2","Current Scope","Details are available once the selected reference resolves to a tracked symbol; deeper analysis surfaces are not active here.",x+ctx.theme.padding,y+108,w-(ctx.theme.padding*2),ctx.theme.warning);
      return;
     }

   ASC_SymbolState state=states[ctx.nav.selected_symbol_index];
   string line1="";
   string line2="";
   string line3="";
   string line4="";
   string label1="State";
   string label2="Session";
   string label3="Next Check";
   string label4="Reason";

   switch(ctx.nav.selected_stat_view)
     {
      case ASC_EXPLORER_STAT_IDENTITY:
         label1="Symbol";
         label2="Server";
         label3="Group Status";
         label4="Scope";
         line1=state.symbol;
         line2=runtime.server_clean;
         line3="This symbol is already connected to the current market map and navigation path.";
         line4="Symbols stay outside grouped views until identity is reliable enough to trust.";
         break;
      case ASC_EXPLORER_STAT_MARKET_STATE:
         label1="State";
         label2="Session";
         label3="Next Check";
         label4="Reason";
         line1=ASC_MarketStatusText(state.market_status);
         line2=(state.within_trade_session ? "Inside broker trade session" : (state.has_trade_sessions ? "Outside broker trade session" : "Session data unavailable"));
         line3=ASC_DateTimeText(state.next_check_at);
         line4=state.next_check_reason;
         break;
      case ASC_EXPLORER_STAT_TICK_QUOTE:
         label1="Tick Present";
         label2="Tick Age";
         label3="Scope";
         label4="Guardrail";
         line1=ASC_BoolText(state.has_tick);
         line2=(state.tick_age_seconds>=0 ? IntegerToString((int)state.tick_age_seconds) + " seconds" : "Not Yet Available");
         line3="Explorer quote detail stays lightweight and current.";
         line4="Heavy history work stays outside this explorer surface.";
         break;
      case ASC_EXPLORER_STAT_RUNTIME_PUBLICATION:
         label1="Snapshot";
         label2="Filter";
         label3="Shortlist";
         label4="Publication";
         line1=ASC_ExplorerSnapshotStatusLine(state);
         line2=ASC_FilterReadinessText(state.filter_readiness);
         line3=ASC_ShortlistReadinessText(state.shortlist_readiness);
         line4=(state.publication_ok ? "Current dossier write promoted" : "Awaiting a successful dossier promotion");
         break;
      default:
         label1="Snapshot";
         label2="Filtering";
         label3="Shortlist";
         label4="Next Stage";
         line1="Open-symbol snapshot is active only when the symbol is open.";
         line2="Candidate filtering is active as a bounded gate over current symbol truth.";
         line3="Shortlist selection is active as bounded admission, not deep analysis.";
         line4="Deeper analysis is not part of this HUD surface.";
         break;
     }

   string labels[4];
   string values[4];
   labels[0]=label1; labels[1]=label2; labels[2]=label3; labels[3]=label4;
   values[0]=line1; values[1]=line2; values[2]=line3; values[3]=line4;
   for(int row=0;row<visible && (ctx.nav.stat_scroll+row)<4;row++)
     {
      int idx=ctx.nav.stat_scroll+row;
      ASC_ExplorerInfoRow(ctx,"stat.line" + IntegerToString(idx),labels[idx],values[idx],x+ctx.theme.padding,info_top+(row*30),w-(ctx.theme.padding*2),ctx.theme.accent_alt);
     }
  }

string ASC_ExplorerWarmupBannerText(const ASC_RuntimeState &runtime)
  {
   string progress=IntegerToString(runtime.readiness_percent) + "%";
   if(runtime.mode==ASC_RUNTIME_WARMUP || !runtime.warmup_minimum_met)
      return("Warmup active — Layer 1 initial market scan is still establishing broad market-state truth | assessed " + IntegerToString(runtime.initial_symbols_assessed) + "/" + IntegerToString(runtime.total_symbols_discovered) + " (" + ASC_ExplorerPercentText(runtime.initial_symbols_assessed,runtime.total_symbols_discovered) + ") of discovered | readiness " + progress + ".");
   return("Layer 1 market status is ready for steady cadence | assessed " + IntegerToString(runtime.initial_symbols_assessed) + "/" + IntegerToString(runtime.total_symbols_discovered) + " discovered symbols | readiness " + progress + ".");
  }

string ASC_ExplorerWarmupModeText(const ASC_RuntimeState &runtime)
  {
   if(runtime.mode==ASC_RUNTIME_WARMUP || !runtime.warmup_minimum_met)
      return("Warmup active — Layer 1 initial market scan in progress");
   return("Market status ready — dispatcher running steady Layer 1 cadence");
  }

string ASC_ExplorerPrimaryBucketLoadingText(const ASC_RuntimeState &runtime)
  {
   return("Informational grouping view only | priority-set assessed " + IntegerToString(runtime.primary_bucket_symbols_assessed)
          + "/" + IntegerToString(runtime.primary_bucket_symbol_count) + " (" + ASC_ExplorerPercentText(runtime.primary_bucket_symbols_assessed,runtime.primary_bucket_symbol_count) + ") | warmup/boot does not depend on this grouping state.");
  }

string ASC_ExplorerBackgroundCompletionText(const ASC_RuntimeState &runtime)
  {
   return("Prepared bucket and explorer surfaces are downstream of Layer 1 truth and do not control warmup or boot state.");
  }

string ASC_ExplorerTimingMsText(const long value)
  {
   if(value<=0)
      return("Pending");
   return(IntegerToString((int)value) + " ms");
  }

void ASC_ExplorerTrackSection(ASC_ExplorerContext &ctx,const string section_name,const long elapsed_ms)
  {
   if(elapsed_ms<=ctx.render_diag.slowest_section_ms)
      return;
   ctx.render_diag.slowest_section_ms=elapsed_ms;
   ctx.render_diag.slowest_section_name=section_name;
  }

bool ASC_ExplorerShouldPrepareRenderState(const ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,const int count)
  {
   if(ctx.nav.last_prepare_heartbeat_count!=runtime.heartbeats_since_boot)
      return(true);
   if(ctx.nav.last_prepare_heartbeat_at!=runtime.last_heartbeat_at)
      return(true);
   if(ctx.nav.last_prepare_batch_generation!=prepared.batch_generation)
      return(true);
   if(ctx.nav.last_prepare_active_batch_id!=prepared.active_batch_id)
      return(true);
   if(ctx.nav.last_prepare_symbol_count!=count)
      return(true);
   return(false);
  }

void ASC_ExplorerMarkPreparedRenderState(ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,const int count)
  {
   ctx.nav.last_prepare_heartbeat_count=runtime.heartbeats_since_boot;
   ctx.nav.last_prepare_heartbeat_at=runtime.last_heartbeat_at;
   ctx.nav.last_prepare_batch_generation=prepared.batch_generation;
   ctx.nav.last_prepare_active_batch_id=prepared.active_batch_id;
   ctx.nav.last_prepare_symbol_count=count;
  }

void ASC_ExplorerPrepareRenderState(ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count)
  {
   if(!ASC_ExplorerShouldPrepareRenderState(ctx,runtime,prepared,count))
      return;
   // Explorer must remain a pure consumer of already-owned runtime/prepared truth.
   // Prepared live-state refresh stays under runtime ownership, not HUD-trigger ownership.
   ASC_ExplorerMarkPreparedRenderState(ctx,runtime,prepared,count);
  }

void ASC_ExplorerRenderPager(ASC_ExplorerContext &ctx,const string action_prefix,const int page_index,const int page_count,const int x,const int y,const int width)
  {
   if(page_count<=1)
      return;
   int edge_w=56;
   if((edge_w*2)+ctx.theme.gap+96>width)
      edge_w=(width-(ctx.theme.gap+96))/2;
   if(edge_w<40)
      edge_w=40;
   bool at_first=(page_index<=0);
   bool at_last=(page_index>=(page_count-1));
   int summary_x=x+edge_w+ctx.theme.gap;
   int summary_w=width-(edge_w*2)-(ctx.theme.gap*2);
   if(summary_w<96)
      summary_w=96;
   ASC_ExplorerButton(ctx,action_prefix + ".prev","Prev",x,y,edge_w,ctx.theme.button_height,(at_first ? ctx.theme.panel_soft_fill : ctx.theme.panel_alt_fill),false);
   ASC_ExplorerLabel(ctx,action_prefix + ".summary.text",ASC_ExplorerFitText("Page " + IntegerToString(page_index+1) + " / " + IntegerToString(page_count),summary_w),summary_x+8,y+6,ctx.theme.text);
   ASC_ExplorerButton(ctx,action_prefix + ".next","Next",x+width-edge_w,y,edge_w,ctx.theme.button_height,(at_last ? ctx.theme.panel_soft_fill : ctx.theme.panel_alt_fill),false);
  }

void ASC_ExplorerMarkPageSwitchTiming(ASC_ExplorerContext &ctx,const string action_name)
  {
   ctx.nav.last_navigation_action_at=TimeCurrent();
   ctx.nav.pending_page_switch_started_ms=GetTickCount();
   ctx.nav.pending_page_switch_timing=true;
   ctx.nav.pending_page_switch_action=action_name;
  }

int ASC_ExplorerTransitionLockDurationMs(const string action_name)
  {
   if(action_name=="action.home" || action_name=="action.back")
      return(120);
   if(StringFind(action_name,"action.bucket.")==0
      || StringFind(action_name,"action.sub_bucket.")==0
      || StringFind(action_name,"action.seed_symbol.")==0
      || StringFind(action_name,"action.stat.")==0)
      return(160);
   if(StringFind(action_name,"action.bucket_page.")==0
      || StringFind(action_name,"action.sub_bucket_page.")==0
      || StringFind(action_name,"action.bucket_symbol_page.")==0)
      return(90);
   if(StringFind(action_name,"action.mode.")==0
      || StringFind(action_name,"action.filter.")==0)
      return(110);
   return(120);
  }

bool ASC_ExplorerTransitionLockAllowEarlyRelease(const string action_name)
  {
   if(action_name=="action.home" || action_name=="action.back" || action_name=="action.refresh" || action_name=="action.density")
      return(true);
   if(StringFind(action_name,"action.bucket_page.")==0
      || StringFind(action_name,"action.sub_bucket_page.")==0
      || StringFind(action_name,"action.bucket_symbol_page.")==0
      || StringFind(action_name,"action.market_filter.")==0
      || StringFind(action_name,"action.bucket_mode.")==0)
      return(true);
   return(false);
  }

void ASC_ExplorerStartTransitionLock(ASC_ExplorerContext &ctx,const string action_name)
  {
   ctx.nav.transition_lock_started_ms=GetTickCount();
   ctx.nav.transition_lock_duration_ms=ASC_ExplorerTransitionLockDurationMs(action_name);
   ctx.nav.transition_lock_active=(ctx.nav.transition_lock_duration_ms>0);
   ctx.nav.transition_lock_action=action_name;
  }

bool ASC_ExplorerTransitionLockActive(ASC_ExplorerContext &ctx)
  {
   if(!ctx.nav.transition_lock_active)
      return(false);
   if(ctx.nav.transition_lock_started_ms<=0 || ctx.nav.transition_lock_duration_ms<=0)
     {
      ctx.nav.transition_lock_active=false;
      ctx.nav.transition_lock_action="";
      return(false);
     }

   long elapsed=GetTickCount()-ctx.nav.transition_lock_started_ms;
   if(elapsed<0 || elapsed>=ctx.nav.transition_lock_duration_ms)
     {
      ctx.nav.transition_lock_active=false;
      ctx.nav.transition_lock_action="";
      ctx.nav.transition_lock_started_ms=0;
      ctx.nav.transition_lock_duration_ms=0;
      return(false);
     }
   return(true);
  }

void ASC_ExplorerMaybeReleaseTransitionLockAfterRender(ASC_ExplorerContext &ctx)
  {
   if(!ctx.nav.transition_lock_active)
      return;
   if(!ASC_ExplorerTransitionLockAllowEarlyRelease(ctx.nav.transition_lock_action))
      return;
   if(ctx.nav.last_render_at<=0)
      return;
   ctx.nav.transition_lock_active=false;
   ctx.nav.transition_lock_action="";
   ctx.nav.transition_lock_started_ms=0;
   ctx.nav.transition_lock_duration_ms=0;
  }

void ASC_ExplorerMaybeStartPageSwitchTiming(ASC_ExplorerContext &ctx,const string action_name,const ASC_ExplorerView before_view,const int before_bucket,const int before_symbol,const ASC_ExplorerStatView before_stat)
  {
   if(ctx.nav.current_view!=before_view
      || ctx.nav.selected_bucket_index!=before_bucket
      || ctx.nav.selected_symbol_index!=before_symbol
      || ctx.nav.selected_stat_view!=before_stat)
      ASC_ExplorerMarkPageSwitchTiming(ctx,action_name);
  }

void ASC_ExplorerDebugLogTiming(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,ASC_Logger &logger)
  {
   if(ctx.nav.last_render_duration_ms>=ASC_DEBUG_RENDER_THRESHOLD_MS)
     {
      string dominant=(prepared.diagnostics.bucket_prep_total_ms>ctx.nav.last_render_duration_ms+ASC_DEBUG_DOMINANT_DELTA_MS ? "prep" : (ctx.nav.last_render_duration_ms>prepared.diagnostics.bucket_prep_total_ms+ASC_DEBUG_DOMINANT_DELTA_MS ? "hud" : "mixed"));
      logger.Debug("Diagnostics","render time over threshold | render=" + IntegerToString((int)ctx.nav.last_render_duration_ms) + "ms | prep=" + IntegerToString((int)prepared.diagnostics.bucket_prep_total_ms) + "ms | dominant=" + dominant + " | view=" + ASC_ExplorerViewText(ctx.nav.current_view));
     }
   if(ctx.nav.last_page_switch_action_to_render_ms>=ASC_DEBUG_PAGE_SWITCH_THRESHOLD_MS)
      logger.Debug("Diagnostics","page-switch latency over threshold | action=" + (ctx.nav.pending_page_switch_action=="" ? "none" : ctx.nav.pending_page_switch_action) + " | latency=" + IntegerToString((int)ctx.nav.last_page_switch_action_to_render_ms) + "ms | render=" + IntegerToString((int)ctx.nav.last_render_duration_ms) + "ms | prep=" + IntegerToString((int)prepared.diagnostics.bucket_prep_total_ms) + "ms");
  }

void ASC_ExplorerDebugLogFilterVisibility(ASC_ExplorerContext &ctx,const ASC_PreparedBucketState &prepared,ASC_Logger &logger)
  {
   static int s_last_open_visible=-1;
   if(ctx.nav.market_filter!=ASC_EXPLORER_FILTER_OPEN_ONLY)
      return;
   int open_visible=ASC_PreparedVisibleOpenBucketTotal(prepared);
   if(open_visible<=0)
      logger.Debug("Diagnostics","filter-visible bucket count under Open Only = 0 | verify no zero-open buckets are shown");
   if(s_last_open_visible>=0 && open_visible!=s_last_open_visible)
      logger.Debug("Diagnostics","filter-visible bucket count changed unexpectedly | filter=Open Only | visible=" + IntegerToString(s_last_open_visible) + "->" + IntegerToString(open_visible));
   s_last_open_visible=open_visible;
   for(int i=0;i<ArraySize(prepared.buckets);i++)
     {
      bool visible=ASC_PreparedBucketVisible(prepared.buckets[i],ASC_EXPLORER_FILTER_OPEN_ONLY);
      if(visible && prepared.buckets[i].open_symbol_count<=0)
         logger.Debug("Diagnostics","filter-visible bucket count changed unexpectedly | filter=Open Only | bucket=" + prepared.buckets[i].bucket_id + " | open_count=" + IntegerToString(prepared.buckets[i].open_symbol_count));
     }
  }

void ASC_ExplorerCommitTiming(ASC_ExplorerContext &ctx,ASC_PreparedBucketState &prepared)
  {
   ctx.nav.last_render_duration_ms=GetTickCount()-ctx.nav.last_render_started_ms;
   ctx.nav.render_duration_total_ms+=ctx.nav.last_render_duration_ms;
   ctx.nav.render_sample_count++;
   if(ctx.nav.last_render_duration_ms>ctx.nav.render_duration_max_ms)
      ctx.nav.render_duration_max_ms=ctx.nav.last_render_duration_ms;
   if(ctx.nav.pending_page_switch_timing)
     {
      ctx.nav.last_page_switch_action_to_render_ms=GetTickCount()-ctx.nav.pending_page_switch_started_ms;
      ctx.nav.page_switch_action_to_render_total_ms+=ctx.nav.last_page_switch_action_to_render_ms;
      ctx.nav.page_switch_sample_count++;
      if(ctx.nav.last_page_switch_action_to_render_ms>ctx.nav.page_switch_action_to_render_max_ms)
         ctx.nav.page_switch_action_to_render_max_ms=ctx.nav.last_page_switch_action_to_render_ms;
      ctx.nav.pending_page_switch_timing=false;
     }
   ctx.nav.last_render_at=TimeCurrent();
   prepared.diagnostics.hud_render_ms=ctx.nav.last_render_duration_ms;
   prepared.diagnostics.page_switch_action_to_render_ms=ctx.nav.last_page_switch_action_to_render_ms;
  }

int ASC_ExplorerSelectedButtonFill(const bool selected,const ASC_ExplorerContext &ctx)
  {
   return(selected ? ctx.theme.selected_fill : ctx.theme.panel_fill);
  }

void ASC_ExplorerRenderTopButton(ASC_ExplorerContext &ctx,const string id,const string text,const int x,const int y,const int w,const bool selected)
  {
   ASC_ExplorerButton(ctx,id,text,x,y,w,ctx.theme.button_height,ctx.theme.panel_fill,selected);
  }

void ASC_ExplorerRenderHeader(ASC_ExplorerContext &ctx,const ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,const int chart_w)
  {
   int x=ctx.theme.margin;
   int y=ctx.theme.margin;
   int w=chart_w-(ctx.theme.margin*2);
   int inner_x=x+ctx.theme.padding;
   int inner_w=w-(ctx.theme.padding*2);
   color state_color=(runtime.degraded ? ctx.theme.warning : (runtime.mode==ASC_RUNTIME_WARMUP || !runtime.warmup_minimum_met ? ctx.theme.warning : ctx.theme.good));

   ASC_ExplorerRect(ctx,"header.strip",x,y,w,ctx.theme.header_height,ctx.theme.header_fill,ctx.theme.border);
   ASC_ExplorerLabel(ctx,"header.main",ASC_PRODUCT_NAME + " — Operator HUD",inner_x,y+6,ctx.theme.text,12);
   ASC_ExplorerLabel(ctx,"header.state",ASC_ExplorerFitText("Mode " + ASC_RuntimeModeText(runtime.mode) + " | Ready " + IntegerToString(runtime.readiness_percent) + "% | Open groups " + IntegerToString(ASC_PreparedVisibleOpenBucketTotal(prepared)) + " | View " + ASC_ExplorerViewText(ctx.nav.current_view),inner_w,10),inner_x,y+26,state_color,10);
   ASC_ExplorerLabel(ctx,"header.progress",ASC_ExplorerFitText("Warmup " + IntegerToString(runtime.initial_symbols_assessed) + "/" + IntegerToString(runtime.total_symbols_discovered) + " | Layer 1 boot " + ASC_BoolText(runtime.layer1_boot_complete) + " | Server " + runtime.server_clean,inner_w),inner_x,y+26+ctx.theme.row_height,ctx.theme.muted);
   ASC_ExplorerLabel(ctx,"header.meta",ASC_ExplorerFitText("Explorer " + ASC_EXPLORER_SUBSYSTEM_VERSION + " | Hydration " + IntegerToString(prepared.diagnostics.promoted_batch_count) + "/" + IntegerToString(ASC_PREPARED_BATCH_COUNT) + " batches promoted",inner_w),inner_x,y+26+(ctx.theme.row_height*2),ctx.theme.dim);
  }

void ASC_ExplorerRenderNavStrip(ASC_ExplorerContext &ctx,const ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count,const int chart_w)
  {
   int y=ctx.theme.margin+ctx.theme.header_height+ctx.theme.gap;
   int nav_x=ctx.theme.margin;
   int nav_w=chart_w-(ctx.theme.margin*2);
   ASC_ExplorerRect(ctx,"nav.strip",nav_x,y,nav_w,ctx.theme.nav_height,ctx.theme.panel_alt_fill,ctx.theme.border);

   int button_y=y+6;
   int button_x=nav_x+ctx.theme.padding;
   int gap=ctx.theme.gap;
   int small_w=52;
   int medium_w=72;
   int filter_w=48;

   ASC_ExplorerRenderTopButton(ctx,"action.back","Back",button_x,button_y,small_w,false);
   button_x+=small_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.home","Home",button_x,button_y,small_w,(ctx.nav.current_view==ASC_EXPLORER_VIEW_OVERVIEW));
   button_x+=small_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.buckets","Buckets",button_x,button_y,medium_w,(ctx.nav.current_view==ASC_EXPLORER_VIEW_BUCKETS || ctx.nav.current_view==ASC_EXPLORER_VIEW_SUB_BUCKETS || ctx.nav.current_view==ASC_EXPLORER_VIEW_BUCKET_DETAIL));
   button_x+=medium_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.symbol_detail","Symbol",button_x,button_y,medium_w,(ctx.nav.current_view==ASC_EXPLORER_VIEW_SYMBOL_DETAIL));
   button_x+=medium_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.stat_detail","Details",button_x,button_y,medium_w,(ctx.nav.current_view==ASC_EXPLORER_VIEW_STAT_DETAIL));
   button_x+=medium_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.market_filter.all","All",button_x,button_y,filter_w,(ctx.nav.market_filter==ASC_EXPLORER_FILTER_ALL_SYMBOLS));
   button_x+=filter_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.market_filter.open","Open",button_x,button_y,filter_w,(ctx.nav.market_filter==ASC_EXPLORER_FILTER_OPEN_ONLY));
   button_x+=filter_w+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.refresh","Sync",button_x,button_y,58,false);
   button_x+=58+gap;
   ASC_ExplorerRenderTopButton(ctx,"action.density","Density",button_x,button_y,72,false);

   string current=ASC_ExplorerViewText(ctx.nav.current_view) + " | Filter " + ASC_ExplorerMarketFilterText(ctx.nav.market_filter) + " | Density " + ASC_ExplorerDensityText(settings.explorer_density_mode);
   if(settings.explorer_show_breadcrumbs && ctx.nav.current_view!=ASC_EXPLORER_VIEW_OVERVIEW)
      current+=" | " + ASC_ExplorerFitTextTail(ASC_ExplorerBreadcrumbText(ctx,prepared,states,count),nav_w/3);
   ASC_ExplorerLabel(ctx,"nav.current",ASC_ExplorerFitText(current,nav_w-(ctx.theme.padding*2),10),nav_x+ctx.theme.padding,y+button_y-y+ctx.theme.button_height+7,ctx.theme.text,10);
  }

void ASC_ExplorerRenderControlRail(ASC_ExplorerContext &ctx,const ASC_RuntimeSettings &settings,ASC_SymbolState &states[],const int count,const int x,const int y,const int w,const int h)
  {
  }

void ASC_ExplorerRenderStatusStrip(ASC_ExplorerContext &ctx,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,const int x,const int y,const int w,const int chart_w,const int chart_h)
  {
   bool transition_locked=ASC_ExplorerTransitionLockActive(ctx);
   string line=(runtime.degraded ? "Attention" : ASC_RuntimeModeText(runtime.mode));
   line+=" | Ready " + IntegerToString(runtime.readiness_percent) + "%";
   line+=" | Page " + ASC_ExplorerViewText(ctx.nav.current_view);
   if(transition_locked)
      line+=" | Transition Lock";
   line+=" | Render " + ASC_ExplorerTimingMsText(ctx.nav.last_render_duration_ms);
   line+=" | Updated " + ASC_DateTimeText(ctx.nav.last_render_at);
   ASC_ExplorerRect(ctx,"status.strip",x,y,w,ctx.theme.status_height,ctx.theme.panel_alt_fill,ctx.theme.border);
   ASC_ExplorerRect(ctx,"status.bar",x,y,5,ctx.theme.status_height,(runtime.degraded ? ctx.theme.warning : ctx.theme.good),(runtime.degraded ? ctx.theme.warning : ctx.theme.good));
   ASC_ExplorerLabel(ctx,"status.text",ASC_ExplorerFitText(line,w-26),x+ctx.theme.padding+4,y+5,(runtime.degraded ? ctx.theme.warning : ctx.theme.muted));
  }

void ASC_ExplorerRender(ASC_ExplorerContext &ctx,const ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime,ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count,ASC_Logger &logger)
  {
   ctx.nav.last_render_started_ms=GetTickCount();
   if(!settings.explorer_enabled)
     {
      logger.Info("Explorer","render skipped because explorer is disabled");
      return;
     }

   if(ctx.layout_dirty || ctx.cached_chart_width<=0 || ctx.cached_chart_height<=0)
      ASC_ExplorerRefreshLayoutMetrics(ctx);
   int chart_w=ctx.cached_chart_width;
   int chart_h=ctx.cached_chart_height;
   if(chart_w<480 || chart_h<300)
     {
      logger.Warn("Explorer","render aborted because chart is too small: " + IntegerToString(chart_w) + "x" + IntegerToString(chart_h));
      return;
     }

   ASC_ExplorerThemeDefaults(ctx.theme,settings.explorer_density_mode);
   ASC_ExplorerBeginFrame(ctx);
   ASC_ExplorerLayoutMetrics layout;
   ASC_ExplorerBuildLayout(ctx,layout);
   int root_w=layout.root_w;
   int root_h=layout.root_h;
   if(root_w<440 || root_h<260)
     {
      logger.Warn("Explorer","fallback render activated for root size " + IntegerToString(root_w) + "x" + IntegerToString(root_h));
      ASC_ExplorerRect(ctx,"root.compact",ctx.theme.margin,ctx.theme.margin,root_w,root_h,ctx.theme.background,ctx.theme.border);
      ASC_ExplorerLabel(ctx,"compact.title","ASC Explorer HUD",ctx.theme.margin+12,ctx.theme.margin+12,ctx.theme.text,11);
      ASC_ExplorerLabel(ctx,"compact.server",ASC_ExplorerFitText("Server " + runtime.server_clean + " | View " + ASC_ExplorerViewText(ctx.nav.current_view),root_w-24),ctx.theme.margin+12,ctx.theme.margin+32,ctx.theme.muted);
      ASC_ExplorerLabel(ctx,"compact.state",ASC_ExplorerFitText("Filter " + ASC_ExplorerMarketFilterText(ctx.nav.market_filter) + " | Mode " + ASC_BucketDisplayModeText(ctx.nav.bucket_display_mode),root_w-24),ctx.theme.margin+12,ctx.theme.margin+50,(ctx.nav.market_filter==ASC_EXPLORER_FILTER_OPEN_ONLY ? ctx.theme.good : ctx.theme.dim));
      ASC_ExplorerLabel(ctx,"compact.status",ASC_ExplorerFitText((runtime.degraded ? "Degraded runtime" : ASC_RuntimeModeText(runtime.mode)) + " | Readiness " + IntegerToString(runtime.readiness_percent) + "% | Chart " + IntegerToString(chart_w) + "x" + IntegerToString(chart_h),root_w-24),ctx.theme.margin+12,ctx.theme.margin+68,(runtime.degraded ? ctx.theme.warning : (runtime.mode==ASC_RUNTIME_WARMUP ? ctx.theme.warning : ctx.theme.good)));
      ASC_ExplorerEndFrame(ctx);
      if(ctx.render_ok)
         ChartRedraw(ctx.chart_id);
      ASC_ExplorerCommitTiming(ctx,prepared);
      ASC_ExplorerDebugLogTiming(ctx,prepared,logger);
      ASC_ExplorerDebugLogFilterVisibility(ctx,prepared,logger);
      if(ctx.render_ok)
         ctx.nav.dirty=false;
      return;
     }
   logger.Debug("Explorer","render entry server=" + runtime.server_clean + ", view=" + ASC_ExplorerViewText(ctx.nav.current_view) + ", filter=" + ASC_ExplorerMarketFilterText(ctx.nav.market_filter) + ", mode=" + ASC_BucketDisplayModeText(ctx.nav.bucket_display_mode) + ", chart=" + IntegerToString(chart_w) + "x" + IntegerToString(chart_h) + ", reason=" + (ctx.nav.last_render_reason=="" ? "unknown" : ctx.nav.last_render_reason));
   ASC_ExplorerRect(ctx,"root",ctx.theme.margin,ctx.theme.margin,root_w,root_h,ctx.theme.background,ctx.theme.border);
   long section_started=GetTickCount();
   ASC_ExplorerRenderHeader(ctx,settings,runtime,prepared,chart_w);
   ctx.render_diag.header_ms=GetTickCount()-section_started;
   ASC_ExplorerTrackSection(ctx,"header",ctx.render_diag.header_ms);
   section_started=GetTickCount();
   ASC_ExplorerRenderNavStrip(ctx,settings,runtime,prepared,states,count,chart_w);
   ctx.render_diag.nav_ms=GetTickCount()-section_started;
   ASC_ExplorerTrackSection(ctx,"nav",ctx.render_diag.nav_ms);
   ctx.render_diag.rail_ms=0;

   section_started=GetTickCount();
   switch(ctx.nav.current_view)
     {
      case ASC_EXPLORER_VIEW_BUCKETS:
         ASC_ExplorerRenderBucketList(ctx,prepared,layout.main_x,layout.main_y,layout.content_w,layout.main_h);
         break;
      case ASC_EXPLORER_VIEW_SUB_BUCKETS:
         ASC_ExplorerRenderSubBucketList(ctx,prepared,layout.main_x,layout.main_y,layout.content_w,layout.main_h);
         break;
      case ASC_EXPLORER_VIEW_BUCKET_DETAIL:
         ASC_ExplorerRenderBucketDetail(ctx,prepared,layout.main_x,layout.main_y,layout.content_w,layout.main_h);
         break;
      case ASC_EXPLORER_VIEW_SYMBOL_DETAIL:
         ASC_ExplorerRenderSymbolDetail(ctx,runtime,states,count,layout.main_x,layout.main_y,layout.content_w,layout.main_h);
         break;
      case ASC_EXPLORER_VIEW_STAT_DETAIL:
         ASC_ExplorerRenderStatDetail(ctx,runtime,states,count,layout.main_x,layout.main_y,layout.content_w,layout.main_h);
         break;
      default:
         ASC_ExplorerRenderOverview(ctx,settings,runtime,prepared,states,count,layout.main_x,layout.main_y,layout.content_w,layout.main_h);
         break;
     }

   ctx.render_diag.page_ms=GetTickCount()-section_started;
   ASC_ExplorerTrackSection(ctx,ctx.render_diag.page_view_name,ctx.render_diag.page_ms);
   section_started=GetTickCount();
   ASC_ExplorerRenderStatusStrip(ctx,runtime,prepared,layout.status_x,layout.status_y,layout.status_w,chart_w,chart_h);
   ctx.render_diag.status_ms=GetTickCount()-section_started;
   ASC_ExplorerTrackSection(ctx,"status",ctx.render_diag.status_ms);
   section_started=GetTickCount();
   ASC_ExplorerEndFrame(ctx);
   ctx.render_diag.cleanup_ms=GetTickCount()-section_started;
   ASC_ExplorerTrackSection(ctx,"cleanup",ctx.render_diag.cleanup_ms);
   if(ctx.render_ok)
      ChartRedraw(ctx.chart_id);
   else
      logger.Warn("Explorer","render incomplete; last-good frame kept alive");
   ASC_ExplorerCommitTiming(ctx,prepared);
   ASC_ExplorerDebugLogTiming(ctx,prepared,logger);
   ASC_ExplorerDebugLogFilterVisibility(ctx,prepared,logger);
   if(ctx.render_ok)
     {
      ctx.nav.dirty=false;
      ctx.nav.last_render_signature=ASC_ExplorerRenderSignature(ctx,runtime,prepared,states,count);
      ctx.nav.last_render_tick_ms=GetTickCount();
     }
  }

void ASC_ExplorerInit(ASC_ExplorerContext &ctx,const long chart_id)
  {
   ctx.chart_id=chart_id;
   ctx.prefix=ASC_HUD_PREFIX;
   ASC_ExplorerThemeDefaults(ctx.theme,1);
   ctx.layout_dirty=true;
   ctx.cached_chart_width=0;
   ctx.cached_chart_height=0;
   ctx.nav.current_view=ASC_EXPLORER_VIEW_OVERVIEW;
   ctx.nav.history_count=0;
   ctx.nav.bucket_scroll=0;
   ctx.nav.bucket_detail_scroll=0;
   ctx.nav.symbol_scroll=0;
   ctx.nav.stat_scroll=0;
   ctx.nav.bucket_mode_scroll=0;
   ctx.nav.bucket_page=0;
   ctx.nav.sub_bucket_page=0;
   ctx.nav.bucket_symbol_page=0;
   ctx.nav.selected_bucket_index=0;
   ctx.nav.selected_sub_bucket_index=-1;
   ctx.nav.selected_symbol_index=-1;
   ctx.nav.selected_sub_bucket_key="";
   ctx.nav.bucket_display_mode=ASC_BUCKET_DISPLAY_TOP_3;
   ctx.nav.market_filter=ASC_EXPLORER_FILTER_ALL_SYMBOLS;
   ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_NONE;
   ctx.nav.selected_seed_symbol="";
   ctx.nav.dirty=true;
   ctx.nav.last_render_signature="";
   ctx.nav.last_render_tick_ms=0;
   ctx.nav.last_render_at=0;
   ctx.nav.last_render_started_ms=0;
   ctx.nav.last_render_duration_ms=0;
   ctx.nav.render_duration_total_ms=0;
   ctx.nav.render_sample_count=0;
   ctx.nav.render_duration_max_ms=0;
   ctx.nav.last_navigation_action_at=0;
   ctx.nav.last_page_switch_action_to_render_ms=0;
   ctx.nav.page_switch_action_to_render_total_ms=0;
   ctx.nav.page_switch_sample_count=0;
   ctx.nav.page_switch_action_to_render_max_ms=0;
   ctx.nav.pending_page_switch_started_ms=0;
   ctx.nav.pending_page_switch_timing=false;
   ctx.nav.pending_page_switch_action="";
   ctx.nav.transition_lock_started_ms=0;
   ctx.nav.transition_lock_duration_ms=0;
   ctx.nav.transition_lock_active=false;
   ctx.nav.transition_lock_action="";
   ctx.nav.last_prepare_heartbeat_count=-1;
   ctx.nav.last_prepare_heartbeat_at=0;
   ctx.nav.last_prepare_batch_generation=-1;
   ctx.nav.last_prepare_active_batch_id=-1;
   ctx.nav.last_prepare_symbol_count=-1;
   ctx.nav.last_render_reason="";
   ctx.nav.last_skip_reason="";
   ArrayResize(ctx.tracked_object_names,0);
   ArrayResize(ctx.tracked_object_types,0);
   ArrayResize(ctx.tracked_visible_generation,0);
   ArrayResize(ctx.tracked_updated_generation,0);
   ArrayResize(g_asc_explorer_visual_states,0);
   ctx.render_generation=0;
   ctx.render_ok=true;
   ctx.render_diag.render_id=0;
   ctx.render_diag.objects_created=0;
   ctx.render_diag.objects_updated=0;
   ctx.render_diag.objects_deleted=0;
   ctx.render_diag.visible_object_count=0;
   ctx.render_diag.header_ms=0;
   ctx.render_diag.nav_ms=0;
   ctx.render_diag.rail_ms=0;
   ctx.render_diag.page_ms=0;
   ctx.render_diag.status_ms=0;
   ctx.render_diag.cleanup_ms=0;
   ctx.render_diag.page_view_name="Overview";
   ctx.render_diag.slowest_section_name="pending";
   ctx.render_diag.slowest_section_ms=0;
   ctx.initialized=true;
  }

void ASC_ExplorerShutdown(ASC_ExplorerContext &ctx)
  {
   if(!ctx.initialized)
      return;
   ASC_ExplorerDeleteOwnedObjects(ctx);
   ASC_ExplorerInvalidateObjectRegistry(ctx);
   ctx.render_generation=0;
   ctx.initialized=false;
  }

string ASC_ExplorerBuildRenderReason(const bool force,const bool dirty,const bool layout_dirty,const bool signature_changed,const bool cadence_due)
  {
   string reason="";
   if(force)
      reason="force";
   if(dirty)
      reason+=(reason=="" ? "dirty" : "+dirty");
   if(layout_dirty)
      reason+=(reason=="" ? "layout" : "+layout");
   if(signature_changed)
      reason+=(reason=="" ? "signature" : "+signature");
   if(cadence_due)
      reason+=(reason=="" ? "cadence" : "+cadence");
   if(reason=="")
      reason="none";
   return(reason);
  }

void ASC_ExplorerMaybeRender(ASC_ExplorerContext &ctx,const ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime,ASC_PreparedBucketState &prepared,ASC_SymbolState &states[],const int count,const bool force,ASC_Logger &logger)
  {
   if(!ctx.initialized || !settings.explorer_enabled)
     {
      if(settings.explorer_enabled)
         logger.Warn("Explorer","maybe-render called before init");
      return;
     }
   ASC_ExplorerPrepareRenderState(ctx,runtime,prepared,states,count);
   datetime now=TimeCurrent();
   long elapsed_ms=(ctx.nav.last_render_tick_ms>0 ? (GetTickCount()-ctx.nav.last_render_tick_ms) : 2147483647);
   string signature=ASC_ExplorerRenderSignature(ctx,runtime,prepared,states,count);
   bool signature_changed=(signature!=ctx.nav.last_render_signature);
   int cadence_ms=(settings.explorer_refresh_seconds>0 ? settings.explorer_refresh_seconds*1000 : 1000);
   bool cadence_due=(ctx.nav.last_render_at<=0 || elapsed_ms>=cadence_ms);
   bool hot_force=(force && elapsed_ms<500 && !ctx.nav.dirty && !ctx.layout_dirty && !signature_changed);
   if(hot_force)
     {
      ctx.nav.last_skip_reason="hot-force-skip";
      return;
     }
   if(!ctx.nav.dirty && !ctx.layout_dirty && !signature_changed && !cadence_due)
     {
      ctx.nav.last_skip_reason="steady-skip";
      return;
     }
   ctx.nav.last_render_reason=ASC_ExplorerBuildRenderReason(force,ctx.nav.dirty,ctx.layout_dirty,signature_changed,cadence_due);
   ctx.nav.last_skip_reason="";
   logger.Debug("Explorer","render scheduled | reason=" + ctx.nav.last_render_reason + " | elapsed_ms=" + IntegerToString((int)elapsed_ms) + " | view=" + ASC_ExplorerViewText(ctx.nav.current_view));
   ASC_ExplorerRender(ctx,settings,runtime,prepared,states,count,logger);
  }

void ASC_ExplorerHandleAction(ASC_ExplorerContext &ctx,ASC_RuntimeSettings &settings,const ASC_RuntimeState &runtime,const ASC_PreparedBucketState &prepared,const string object_name,ASC_SymbolState &states[],const int count,ASC_Logger &logger)
  {
   string action=object_name;
   StringReplace(action,ctx.prefix,"");
   string before_signature=ASC_ExplorerNavVisualSignature(ctx);
   ASC_ExplorerView before_view=ctx.nav.current_view;
   int before_bucket=ctx.nav.selected_bucket_index;
   int before_symbol=ctx.nav.selected_symbol_index;
   ASC_ExplorerStatView before_stat=ctx.nav.selected_stat_view;

   if(action=="action.home")
      ASC_ExplorerGoHome(ctx);
   else if(action=="action.back")
      ASC_ExplorerGoBack(ctx);
   else if(action=="action.overview")
      ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_OVERVIEW);
   else if(action=="action.buckets")
      ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_BUCKETS);
   else if(action=="action.bucket_detail")
     {
      ctx.nav.selected_seed_symbol="";
      ctx.nav.selected_symbol_index=-1;
      ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_NONE;
      if(ctx.nav.selected_sub_bucket_key!="" || ctx.nav.selected_sub_bucket_index>=0)
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_BUCKET_DETAIL);
      else
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SUB_BUCKETS);
     }
   else if(action=="action.symbol_detail")
     {
      if(ctx.nav.selected_symbol_index>=0 || ctx.nav.selected_seed_symbol!="")
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SYMBOL_DETAIL);
      else if(ctx.nav.selected_sub_bucket_key!="" || ctx.nav.selected_sub_bucket_index>=0)
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_BUCKET_DETAIL);
      else
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SUB_BUCKETS);
     }
   else if(action=="action.stat_detail")
     {
      if(ctx.nav.selected_stat_view!=ASC_EXPLORER_STAT_NONE)
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_STAT_DETAIL);
      else if(ctx.nav.selected_symbol_index>=0 || ctx.nav.selected_seed_symbol!="")
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SYMBOL_DETAIL);
      else if(ctx.nav.selected_sub_bucket_key!="" || ctx.nav.selected_sub_bucket_index>=0)
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_BUCKET_DETAIL);
      else
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SUB_BUCKETS);
     }
   else if(action=="action.refresh")
     {
      ctx.nav.dirty=true;
      ctx.nav.last_render_signature="";
     }
   else if(action=="action.density")
     {
      settings.explorer_density_mode=(settings.explorer_density_mode>=2 ? 0 : settings.explorer_density_mode+1);
      ASC_ExplorerInvalidateLayout(ctx);
      ctx.nav.dirty=true;
     }
   else if(action=="action.bucket_mode.top3")
     {
      if(ctx.nav.bucket_display_mode!=ASC_BUCKET_DISPLAY_TOP_3 || ctx.nav.bucket_symbol_page!=0)
        {
         ctx.nav.bucket_display_mode=ASC_BUCKET_DISPLAY_TOP_3;
         ctx.nav.bucket_symbol_page=0;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_mode.top5")
     {
      if(ctx.nav.bucket_display_mode!=ASC_BUCKET_DISPLAY_TOP_5 || ctx.nav.bucket_symbol_page!=0)
        {
         ctx.nav.bucket_display_mode=ASC_BUCKET_DISPLAY_TOP_5;
         ctx.nav.bucket_symbol_page=0;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_mode.all")
     {
      if(ctx.nav.bucket_display_mode!=ASC_BUCKET_DISPLAY_ALL || ctx.nav.bucket_symbol_page!=0)
        {
         ctx.nav.bucket_display_mode=ASC_BUCKET_DISPLAY_ALL;
         ctx.nav.bucket_symbol_page=0;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.market_filter.all")
     {
      string before=ASC_ExplorerNavVisualSignature(ctx);
      if(ctx.nav.market_filter!=ASC_EXPLORER_FILTER_ALL_SYMBOLS || ctx.nav.bucket_page!=0 || ctx.nav.sub_bucket_page!=0 || ctx.nav.bucket_symbol_page!=0)
        {
         ctx.nav.market_filter=ASC_EXPLORER_FILTER_ALL_SYMBOLS;
         ctx.nav.bucket_page=0;
         ctx.nav.sub_bucket_page=0;
         ctx.nav.bucket_symbol_page=0;
         ASC_ExplorerSyncSelectionState(ctx,prepared,states,count);
         ctx.nav.dirty=(before!=ASC_ExplorerNavVisualSignature(ctx));
        }
     }
   else if(action=="action.market_filter.open")
     {
      string before=ASC_ExplorerNavVisualSignature(ctx);
      if(ctx.nav.market_filter!=ASC_EXPLORER_FILTER_OPEN_ONLY || ctx.nav.bucket_page!=0 || ctx.nav.sub_bucket_page!=0 || ctx.nav.bucket_symbol_page!=0)
        {
         ctx.nav.market_filter=ASC_EXPLORER_FILTER_OPEN_ONLY;
         ctx.nav.bucket_page=0;
         ctx.nav.sub_bucket_page=0;
         ctx.nav.bucket_symbol_page=0;
         ASC_ExplorerSyncSelectionState(ctx,prepared,states,count);
         ctx.nav.dirty=(before!=ASC_ExplorerNavVisualSignature(ctx));
         int open_visible=ASC_PreparedVisibleOpenBucketTotal(prepared);
         logger.Debug("Diagnostics","filter-visible bucket count under Open Only | visible=" + IntegerToString(open_visible));
        }
     }
   else if(action=="action.bucket_page.prev")
     {
      if(ctx.nav.bucket_page>0)
        {
         ctx.nav.bucket_page--;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_page.home")
     {
      if(ctx.nav.bucket_page!=0)
        {
         ctx.nav.bucket_page=0;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_page.next")
     {
      ctx.nav.bucket_page++;
      ctx.nav.dirty=true;
     }
   else if(action=="action.bucket_page.last")
     {
      if(ctx.nav.bucket_page!=2147483647)
        {
         ctx.nav.bucket_page=2147483647;
         ctx.nav.dirty=true;
        }
     }
   else if(StringFind(action,"action.bucket_page.")==0)
     {
      int target_page=(int)StringToInteger(StringSubstr(action,StringLen("action.bucket_page.")));
      if(ctx.nav.bucket_page!=target_page)
        {
         ctx.nav.bucket_page=target_page;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.sub_bucket_page.prev")
     {
      if(ctx.nav.sub_bucket_page>0)
        {
         ctx.nav.sub_bucket_page--;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.sub_bucket_page.home")
     {
      if(ctx.nav.sub_bucket_page!=0)
        {
         ctx.nav.sub_bucket_page=0;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.sub_bucket_page.next")
     {
      ctx.nav.sub_bucket_page++;
      ctx.nav.dirty=true;
     }
   else if(action=="action.sub_bucket_page.last")
     {
      if(ctx.nav.sub_bucket_page!=2147483647)
        {
         ctx.nav.sub_bucket_page=2147483647;
         ctx.nav.dirty=true;
        }
     }
   else if(StringFind(action,"action.sub_bucket_page.")==0)
     {
      int target_page=(int)StringToInteger(StringSubstr(action,StringLen("action.sub_bucket_page.")));
      if(ctx.nav.sub_bucket_page!=target_page)
        {
         ctx.nav.sub_bucket_page=target_page;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_symbol_page.prev")
     {
      if(ctx.nav.bucket_symbol_page>0)
        {
         ctx.nav.bucket_symbol_page--;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_symbol_page.home")
     {
      if(ctx.nav.bucket_symbol_page!=0)
        {
         ctx.nav.bucket_symbol_page=0;
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.bucket_symbol_page.next")
     {
      ctx.nav.bucket_symbol_page++;
      ctx.nav.dirty=true;
     }
   else if(action=="action.bucket_symbol_page.last")
     {
      if(ctx.nav.bucket_symbol_page!=2147483647)
        {
         ctx.nav.bucket_symbol_page=2147483647;
         ctx.nav.dirty=true;
        }
     }
   else if(StringFind(action,"action.bucket_symbol_page.")==0)
     {
      int target_page=(int)StringToInteger(StringSubstr(action,StringLen("action.bucket_symbol_page.")));
      if(ctx.nav.bucket_symbol_page!=target_page)
        {
         ctx.nav.bucket_symbol_page=target_page;
         ctx.nav.dirty=true;
        }
     }
   else if(StringFind(action,"action.bucket.")==0)
     {
      int target_bucket=(int)StringToInteger(StringSubstr(action,StringLen("action.bucket.")));
      string before=ASC_ExplorerNavVisualSignature(ctx);
      if(ctx.nav.selected_bucket_index!=target_bucket || ctx.nav.current_view!=ASC_EXPLORER_VIEW_SUB_BUCKETS)
        {
         ctx.nav.selected_bucket_index=target_bucket;
         ctx.nav.selected_sub_bucket_index=-1;
         ctx.nav.selected_sub_bucket_key="";
         ctx.nav.sub_bucket_page=0;
         ctx.nav.bucket_symbol_page=0;
         ctx.nav.selected_seed_symbol="";
         ctx.nav.selected_symbol_index=-1;
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_NONE;
         ASC_ExplorerSyncSelectionState(ctx,prepared,states,count);
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SUB_BUCKETS);
         if(before!=ASC_ExplorerNavVisualSignature(ctx))
            ctx.nav.dirty=true;
        }
     }
   else if(StringFind(action,"action.sub_bucket.")==0)
     {
      int target_sub_bucket=(int)StringToInteger(StringSubstr(action,StringLen("action.sub_bucket.")));
      string before=ASC_ExplorerNavVisualSignature(ctx);
      if(ctx.nav.selected_sub_bucket_index!=target_sub_bucket || ctx.nav.current_view!=ASC_EXPLORER_VIEW_BUCKET_DETAIL)
        {
         ctx.nav.selected_sub_bucket_index=target_sub_bucket;
         ASC_BucketViewModel bucket;
         if(ASC_ExplorerResolveFilteredBucketSelection(ctx,prepared,bucket)>=0)
           {
            ASC_SubBucketViewModel filtered[];
            if(ASC_PreparedFilteredSubBuckets(prepared,bucket.bucket_id,ctx.nav.market_filter,filtered)>ctx.nav.selected_sub_bucket_index
               && ctx.nav.selected_sub_bucket_index>=0)
               ctx.nav.selected_sub_bucket_key=filtered[ctx.nav.selected_sub_bucket_index].key;
           }
         ctx.nav.bucket_symbol_page=0;
         ctx.nav.selected_seed_symbol="";
         ctx.nav.selected_symbol_index=-1;
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_NONE;
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_BUCKET_DETAIL);
         if(before!=ASC_ExplorerNavVisualSignature(ctx))
            ctx.nav.dirty=true;
        }
     }
   else if(StringFind(action,"action.seed_symbol.")==0)
     {
      int seed_index=(int)StringToInteger(StringSubstr(action,StringLen("action.seed_symbol.")));
      ASC_BucketViewModel bucket;
      ASC_SubBucketViewModel sub_bucket;
      if(ASC_ExplorerResolveFilteredBucketSelection(ctx,prepared,bucket)<0)
         return;
      if(ASC_ExplorerResolveFilteredSubBucketSelection(ctx,prepared,bucket.bucket_id,sub_bucket)<0)
         return;
      ASC_BucketPreparedSymbol visible_symbols[];
      ASC_PreparedSubBucketSymbols(prepared,sub_bucket,ctx.nav.market_filter,visible_symbols);
      if(seed_index<0 || seed_index>=ArraySize(visible_symbols))
         return;
      string before=ASC_ExplorerNavVisualSignature(ctx);
      ctx.nav.selected_symbol_index=visible_symbols[seed_index].symbol_state_index;
      ctx.nav.selected_seed_symbol=visible_symbols[seed_index].live_symbol;
      ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_IDENTITY;
      ctx.nav.symbol_scroll=0;
      ctx.nav.stat_scroll=0;
      ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_SYMBOL_DETAIL);
      if(before!=ASC_ExplorerNavVisualSignature(ctx))
         ctx.nav.dirty=true;
     }
   else if(action=="action.stat.identity")
     {
      if(ctx.nav.selected_stat_view!=ASC_EXPLORER_STAT_IDENTITY || ctx.nav.current_view!=ASC_EXPLORER_VIEW_STAT_DETAIL || ctx.nav.stat_scroll!=0)
        {
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_IDENTITY;
         ctx.nav.stat_scroll=0;
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_STAT_DETAIL);
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.stat.market")
     {
      if(ctx.nav.selected_stat_view!=ASC_EXPLORER_STAT_MARKET_STATE || ctx.nav.current_view!=ASC_EXPLORER_VIEW_STAT_DETAIL || ctx.nav.stat_scroll!=0)
        {
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_MARKET_STATE;
         ctx.nav.stat_scroll=0;
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_STAT_DETAIL);
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.stat.quote")
     {
      if(ctx.nav.selected_stat_view!=ASC_EXPLORER_STAT_TICK_QUOTE || ctx.nav.current_view!=ASC_EXPLORER_VIEW_STAT_DETAIL || ctx.nav.stat_scroll!=0)
        {
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_TICK_QUOTE;
         ctx.nav.stat_scroll=0;
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_STAT_DETAIL);
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.stat.runtime")
     {
      if(ctx.nav.selected_stat_view!=ASC_EXPLORER_STAT_RUNTIME_PUBLICATION || ctx.nav.current_view!=ASC_EXPLORER_VIEW_STAT_DETAIL || ctx.nav.stat_scroll!=0)
        {
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_RUNTIME_PUBLICATION;
         ctx.nav.stat_scroll=0;
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_STAT_DETAIL);
         ctx.nav.dirty=true;
        }
     }
   else if(action=="action.stat.future")
     {
      if(ctx.nav.selected_stat_view!=ASC_EXPLORER_STAT_FUTURE_SURFACES || ctx.nav.current_view!=ASC_EXPLORER_VIEW_STAT_DETAIL || ctx.nav.stat_scroll!=0)
        {
         ctx.nav.selected_stat_view=ASC_EXPLORER_STAT_FUTURE_SURFACES;
         ctx.nav.stat_scroll=0;
         ASC_ExplorerOpenView(ctx,ASC_EXPLORER_VIEW_STAT_DETAIL);
         ctx.nav.dirty=true;
        }
     }
   else
      return;

   ASC_ExplorerMaybeStartPageSwitchTiming(ctx,action,before_view,before_bucket,before_symbol,before_stat);
   if(before_signature!=ASC_ExplorerNavVisualSignature(ctx))
      ASC_ExplorerStartTransitionLock(ctx,action);
   logger.Debug("Explorer","action " + action + " dispatched");
  }

#endif
