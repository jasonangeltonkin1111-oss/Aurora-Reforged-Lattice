#ifndef ASC_HUD_BROWSE_STATE_MQH
#define ASC_HUD_BROWSE_STATE_MQH

#include "../core/ASC_Core_RuntimeState.mqh"
#include "../layers/ASC_Layer1_MarketState.mqh"

struct ASC_HUDMainBucket
  {
   string Id;
   string Name;
   int Total;
   int Open;
   int Closed;
   int Watch;
   int Unknown;
   int SubBucketCount;
  };

struct ASC_HUDSubBucket
  {
   string BucketId;
   string Key;
   string Name;
   int Total;
   int Open;
   int Closed;
   int Watch;
   int Unknown;
  };

struct ASC_HUDSymbolEntry
  {
   int RecordIndex;
   string SymbolKey;
   string DisplaySymbol;
   string DisplayName;
   string BucketId;
   string BucketName;
   string SubBucketKey;
   string SubBucketName;
  };

ASC_HUDMainBucket g_asc_hud_main_buckets[];
ASC_HUDSubBucket g_asc_hud_sub_buckets[];
ASC_HUDSymbolEntry g_asc_hud_symbols[];
int g_asc_hud_active_sub_bucket_indices[];
int g_asc_hud_active_symbol_indices[];
string g_asc_hud_browse_signature = "";
string g_asc_hud_active_bucket_id = "";
string g_asc_hud_active_sub_bucket_key = "";

string ASC_HUD_MainBucketName(const string bucket_id)
  {
   string value = bucket_id;
   StringToLower(value);
   if(value == "fx")      return "FX";
   if(value == "indices") return "Indices";
   if(value == "metals")  return "Metals";
   if(value == "energy")  return "Energy";
   if(value == "crypto")  return "Crypto";
   if(value == "stocks")  return "Stocks";
   return "Unresolved";
  }

string ASC_HUD_MainBucketIdFromAssetClass(const string asset_class)
  {
   if(asset_class == "FX")      return "fx";
   if(asset_class == "INDEX")   return "indices";
   if(asset_class == "METALS")  return "metals";
   if(asset_class == "ENERGY")  return "energy";
   if(asset_class == "CRYPTO")  return "crypto";
   if(asset_class == "STOCK")   return "stocks";
   return "";
  }

int ASC_HUD_MainBucketSlot(const string bucket_id)
  {
   string value = bucket_id;
   StringToLower(value);
   if(value == "fx")      return 0;
   if(value == "indices") return 1;
   if(value == "metals")  return 2;
   if(value == "energy")  return 3;
   if(value == "crypto")  return 4;
   if(value == "stocks")  return 5;
   return -1;
  }

string ASC_HUD_Trim(const string value)
  {
   int length = (int)StringLen(value);
   int start = 0;
   while(start < length)
     {
      ushort ch = (ushort)StringGetCharacter(value, start);
      if(ch != 32 && ch != 9 && ch != 13 && ch != 10)
         break;
      start++;
     }

   int end = length - 1;
   while(end >= start)
     {
      ushort ch = (ushort)StringGetCharacter(value, end);
      if(ch != 32 && ch != 9 && ch != 13 && ch != 10)
         break;
      end--;
     }

   if(end < start)
      return "";
   return StringSubstr(value, start, end - start + 1);
  }

string ASC_HUD_Title(const string value)
  {
   string work = value;
   StringReplace(work, "_", " ");
   StringReplace(work, "|", " ");
   StringReplace(work, "-", " ");

   string out = "";
   bool capitalize = true;
   int total = (int)StringLen(work);
   for(int i = 0; i < total; i++)
     {
      ushort ch = (ushort)StringGetCharacter(work, i);
      if(ch == ' ')
        {
         out += " ";
         capitalize = true;
         continue;
        }
      if(capitalize && ch >= 'a' && ch <= 'z')
        {
         out += ShortToString((short)(ch - 32));
         capitalize = false;
         continue;
        }
      if(!capitalize && ch >= 'A' && ch <= 'Z')
        {
         out += ShortToString((short)(ch + 32));
         continue;
        }
      out += ShortToString((short)ch);
      capitalize = false;
     }
   return out;
  }

string ASC_HUD_NormalizeKey(const string value)
  {
   string work = ASC_HUD_Trim(value);
   StringToUpper(work);
   string out = "";
   int total = (int)StringLen(work);
   for(int i = 0; i < total; i++)
     {
      ushort ch = (ushort)StringGetCharacter(work, i);
      if((ch >= '0' && ch <= '9') || (ch >= 'A' && ch <= 'Z'))
         out += ShortToString((short)ch);
      else if(ch == ' ' || ch == '_' || ch == '-')
         out += "_";
     }
   return out;
  }

string ASC_HUD_StockRegionalKey(const ASC_SymbolIdentity &identity)
  {
   string primary = ASC_HUD_NormalizeKey(identity.Subtype);
   string theme = ASC_HUD_NormalizeKey(identity.ThemeBucket);
   string canonical = identity.CanonicalSymbol;
   StringToUpper(canonical);

   if(theme == "US" || theme == "UNITED_STATES" || StringFind(canonical, ".US") > 0)
      return "stocks|US_STOCKS";
   if(theme == "EU" || theme == "EUROPE" || StringFind(canonical, ".DE") > 0 || StringFind(canonical, ".PA") > 0)
      return "stocks|EU_STOCKS";
   if(theme == "HK" || theme == "HONG_KONG" || StringFind(canonical, ".HK") > 0)
      return "stocks|HK_STOCKS";
   if(primary != "")
      return "stocks|" + primary;
   if(theme != "")
      return "stocks|" + theme;
   return "stocks|OTHER";
  }

string ASC_HUD_StockRegionalName(const ASC_SymbolIdentity &identity)
  {
   string key = ASC_HUD_StockRegionalKey(identity);
   if(key == "stocks|US_STOCKS") return "US Stocks";
   if(key == "stocks|EU_STOCKS") return "EU Stocks";
   if(key == "stocks|HK_STOCKS") return "HK Stocks";

   int sep = StringFind(key, "|");
   if(sep >= 0)
      return ASC_HUD_Title(StringSubstr(key, sep + 1));
   return "Other Stocks";
  }

string ASC_HUD_SubBucketKeyForIdentity(const ASC_SymbolIdentity &identity)
  {
   string bucket_id = ASC_HUD_MainBucketIdFromAssetClass(identity.AssetClass);
   if(bucket_id == "")
      return "";

   if(bucket_id == "stocks")
      return ASC_HUD_StockRegionalKey(identity);

   string subgroup = ASC_HUD_Trim(identity.SubGroup);
   if(subgroup == "" || subgroup == "Unresolved")
      return bucket_id + "|OTHER";
   return bucket_id + "|" + ASC_HUD_NormalizeKey(subgroup);
  }

string ASC_HUD_SubBucketNameForIdentity(const ASC_SymbolIdentity &identity)
  {
   string bucket_id = ASC_HUD_MainBucketIdFromAssetClass(identity.AssetClass);
   if(bucket_id == "stocks")
      return ASC_HUD_StockRegionalName(identity);

   string subgroup = ASC_HUD_Trim(identity.SubGroup);
   if(subgroup == "" || subgroup == "Unresolved")
      return "Other " + ASC_HUD_MainBucketName(bucket_id);
   return subgroup;
  }

void ASC_HUD_InitMainBuckets()
  {
   ArrayResize(g_asc_hud_main_buckets, 6);
   string ids[6] = {"fx", "indices", "metals", "energy", "crypto", "stocks"};
   for(int i = 0; i < 6; i++)
     {
      g_asc_hud_main_buckets[i].Id = ids[i];
      g_asc_hud_main_buckets[i].Name = ASC_HUD_MainBucketName(ids[i]);
      g_asc_hud_main_buckets[i].Total = 0;
      g_asc_hud_main_buckets[i].Open = 0;
      g_asc_hud_main_buckets[i].Closed = 0;
      g_asc_hud_main_buckets[i].Watch = 0;
      g_asc_hud_main_buckets[i].Unknown = 0;
      g_asc_hud_main_buckets[i].SubBucketCount = 0;
     }
  }

int ASC_HUD_FindSubBucketSlot(const string key)
  {
   for(int i = 0; i < ArraySize(g_asc_hud_sub_buckets); i++)
      if(g_asc_hud_sub_buckets[i].Key == key)
         return i;
   return -1;
  }

void ASC_HUD_SortSubBuckets()
  {
   int total = ArraySize(g_asc_hud_sub_buckets);
   for(int i = 1; i < total; i++)
     {
      ASC_HUDSubBucket key = g_asc_hud_sub_buckets[i];
      int j = i - 1;
      while(j >= 0 && StringCompare(g_asc_hud_sub_buckets[j].Name, key.Name) > 0)
        {
         g_asc_hud_sub_buckets[j + 1] = g_asc_hud_sub_buckets[j];
         j--;
        }
      g_asc_hud_sub_buckets[j + 1] = key;
     }
  }

void ASC_HUD_SortSymbols()
  {
   int total = ArraySize(g_asc_hud_symbols);
   for(int i = 1; i < total; i++)
     {
      ASC_HUDSymbolEntry key = g_asc_hud_symbols[i];
      int j = i - 1;
      while(j >= 0)
        {
         string left = g_asc_hud_symbols[j].DisplaySymbol + "|" + g_asc_hud_symbols[j].DisplayName;
         string right = key.DisplaySymbol + "|" + key.DisplayName;
         if(StringCompare(left, right) <= 0)
            break;
         g_asc_hud_symbols[j + 1] = g_asc_hud_symbols[j];
         j--;
        }
      g_asc_hud_symbols[j + 1] = key;
     }
  }

string ASC_HUD_BrowseDataSignature(const ASC_RootRuntimeState &state)
  {
   string signature = IntegerToString(ArraySize(g_asc_layer1_records))
                      + ":" + IntegerToString(state.Layer1.TotalSymbols)
                      + ":" + IntegerToString(state.Layer1.OpenCount)
                      + ":" + IntegerToString(state.Layer1.ClosedCount)
                      + ":" + IntegerToString(state.Layer1.UncertainCount)
                      + ":" + IntegerToString(state.Layer1.ResolvedClassificationCount)
                      + ":" + IntegerToString(state.Layer1.UnknownClassificationCount)
                      + ":" + IntegerToString((int)state.Layer1.LastScanAt)
                      + ":" + IntegerToString((int)state.Layer1.LastSummaryPublishAt);
   return signature;
  }

void ASC_HUD_RebuildBrowseData()
  {
   ASC_HUD_InitMainBuckets();
   int total_records = ArraySize(g_asc_layer1_records);
   ArrayResize(g_asc_hud_sub_buckets, 0, 64);
   ArrayResize(g_asc_hud_symbols, 0, total_records);
   for(int i = 0; i < total_records; i++)
     {
      ASC_MarketStateRecord record = g_asc_layer1_records[i];
      string bucket_id = ASC_HUD_MainBucketIdFromAssetClass(record.Identity.AssetClass);
      if(bucket_id == "")
         continue;

      int main_slot = ASC_HUD_MainBucketSlot(bucket_id);
      if(main_slot >= 0)
        {
         g_asc_hud_main_buckets[main_slot].Total++;
         if(record.MarketState == ASC_MARKET_STATE_OPEN) g_asc_hud_main_buckets[main_slot].Open++;
         else if(record.MarketState == ASC_MARKET_STATE_CLOSED) g_asc_hud_main_buckets[main_slot].Closed++;
         else if(record.MarketState == ASC_MARKET_STATE_UNCERTAIN) g_asc_hud_main_buckets[main_slot].Watch++;
         else g_asc_hud_main_buckets[main_slot].Unknown++;
        }

      string sub_key = ASC_HUD_SubBucketKeyForIdentity(record.Identity);
      string sub_name = ASC_HUD_SubBucketNameForIdentity(record.Identity);
      int slot = ASC_HUD_FindSubBucketSlot(sub_key);
      if(slot < 0)
        {
         slot = ArraySize(g_asc_hud_sub_buckets);
         ArrayResize(g_asc_hud_sub_buckets, slot + 1, 64);
         g_asc_hud_sub_buckets[slot].BucketId = bucket_id;
         g_asc_hud_sub_buckets[slot].Key = sub_key;
         g_asc_hud_sub_buckets[slot].Name = sub_name;
         g_asc_hud_sub_buckets[slot].Total = 0;
         g_asc_hud_sub_buckets[slot].Open = 0;
         g_asc_hud_sub_buckets[slot].Closed = 0;
         g_asc_hud_sub_buckets[slot].Watch = 0;
         g_asc_hud_sub_buckets[slot].Unknown = 0;
        }

      g_asc_hud_sub_buckets[slot].Total++;
      if(record.MarketState == ASC_MARKET_STATE_OPEN) g_asc_hud_sub_buckets[slot].Open++;
      else if(record.MarketState == ASC_MARKET_STATE_CLOSED) g_asc_hud_sub_buckets[slot].Closed++;
      else if(record.MarketState == ASC_MARKET_STATE_UNCERTAIN) g_asc_hud_sub_buckets[slot].Watch++;
      else g_asc_hud_sub_buckets[slot].Unknown++;

      int new_index = ArraySize(g_asc_hud_symbols);
      ArrayResize(g_asc_hud_symbols, new_index + 1, total_records);
      g_asc_hud_symbols[new_index].RecordIndex = i;
      g_asc_hud_symbols[new_index].SymbolKey = record.Identity.SymbolKey;
      g_asc_hud_symbols[new_index].DisplaySymbol = record.Identity.DisplaySymbol;
      g_asc_hud_symbols[new_index].DisplayName = record.Identity.DisplayName;
      g_asc_hud_symbols[new_index].BucketId = bucket_id;
      g_asc_hud_symbols[new_index].BucketName = ASC_HUD_MainBucketName(bucket_id);
      g_asc_hud_symbols[new_index].SubBucketKey = sub_key;
      g_asc_hud_symbols[new_index].SubBucketName = sub_name;
     }

   ASC_HUD_SortSubBuckets();
   ASC_HUD_SortSymbols();

   for(int i = 0; i < ArraySize(g_asc_hud_sub_buckets); i++)
     {
      int main_slot = ASC_HUD_MainBucketSlot(g_asc_hud_sub_buckets[i].BucketId);
      if(main_slot >= 0)
         g_asc_hud_main_buckets[main_slot].SubBucketCount++;
     }
  }

bool ASC_HUD_PrepareBrowseData(const ASC_RootRuntimeState &state)
  {
   string signature = ASC_HUD_BrowseDataSignature(state);
   if(signature == g_asc_hud_browse_signature)
      return false;

   ASC_HUD_RebuildBrowseData();
   g_asc_hud_browse_signature = signature;
   g_asc_hud_active_bucket_id = "";
   g_asc_hud_active_sub_bucket_key = "";
   ArrayResize(g_asc_hud_active_sub_bucket_indices, 0);
   ArrayResize(g_asc_hud_active_symbol_indices, 0);
   return true;
  }

void ASC_HUD_PrepareActiveBrowse(const string bucket_id,
                                 const string sub_bucket_key)
  {
   if(bucket_id == g_asc_hud_active_bucket_id && sub_bucket_key == g_asc_hud_active_sub_bucket_key)
      return;

   g_asc_hud_active_bucket_id = bucket_id;
   g_asc_hud_active_sub_bucket_key = sub_bucket_key;
   int sub_total = ArraySize(g_asc_hud_sub_buckets);
   int symbol_total = ArraySize(g_asc_hud_symbols);

   ArrayResize(g_asc_hud_active_sub_bucket_indices, sub_total);
   ArrayResize(g_asc_hud_active_symbol_indices, symbol_total);

   int sub_count = 0;
   for(int i = 0; i < sub_total; i++)
     {
      if(g_asc_hud_sub_buckets[i].BucketId != bucket_id)
         continue;
      g_asc_hud_active_sub_bucket_indices[sub_count] = i;
      sub_count++;
     }
   ArrayResize(g_asc_hud_active_sub_bucket_indices, sub_count);

   int symbol_count = 0;
   for(int i = 0; i < symbol_total; i++)
     {
      if(g_asc_hud_symbols[i].BucketId != bucket_id)
         continue;
      if(sub_bucket_key != "" && g_asc_hud_symbols[i].SubBucketKey != sub_bucket_key)
         continue;
      g_asc_hud_active_symbol_indices[symbol_count] = i;
      symbol_count++;
     }
   ArrayResize(g_asc_hud_active_symbol_indices, symbol_count);
  }

int ASC_HUD_MainBucketCount()
  {
   return ArraySize(g_asc_hud_main_buckets);
  }

int ASC_HUD_ActiveSubBucketCount()
  {
   return ArraySize(g_asc_hud_active_sub_bucket_indices);
  }

int ASC_HUD_ActiveSymbolCount()
  {
   return ArraySize(g_asc_hud_active_symbol_indices);
  }

string ASC_HUD_SubBucketNameByKey(const string key)
  {
   for(int i = 0; i < ArraySize(g_asc_hud_sub_buckets); i++)
      if(g_asc_hud_sub_buckets[i].Key == key)
         return g_asc_hud_sub_buckets[i].Name;
   return "";
  }

bool ASC_HUD_BrowseHasSymbolKey(const string symbol_key)
  {
   for(int i = 0; i < ArraySize(g_asc_hud_symbols); i++)
      if(g_asc_hud_symbols[i].SymbolKey == symbol_key)
         return true;
   return false;
  }

string ASC_HUD_FirstActiveSymbolKey()
  {
   if(ArraySize(g_asc_hud_active_symbol_indices) <= 0)
      return "";
   return g_asc_hud_symbols[g_asc_hud_active_symbol_indices[0]].SymbolKey;
  }

#endif // ASC_HUD_BROWSE_STATE_MQH
