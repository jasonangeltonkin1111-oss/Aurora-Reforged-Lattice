#ifndef __ASC_HUD_OBJECT_CACHE_INDEX_MQH__
#define __ASC_HUD_OBJECT_CACHE_INDEX_MQH__

// Mechanical HUD object-cache / index bookkeeping seam only.
// This helper must not become a truth owner, page router, or UI-meaning surface.

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

bool ASC_HudCommitObjectSignature(const string name,const string signature)
  {
   int slot = ASC_HudFindObjectCache(name);
   if(slot >= 0)
     {
      if(g_asc_hud.object_cache[slot].signature == signature)
         return false;
      g_asc_hud.object_cache[slot].signature = signature;
     }
   else
     {
      int old = ArraySize(g_asc_hud.object_cache);
      ASC_HudEnsureObjectCacheIndexCapacity(old + 1);
      ArrayResize(g_asc_hud.object_cache, old + 1);
      g_asc_hud.object_cache[old].name = name;
      g_asc_hud.object_cache[old].signature = signature;
      ASC_HudInsertObjectCacheIndexEntry(name, old);
     }

   g_asc_hud.render_mutations++;
   return true;
  }

#endif // __ASC_HUD_OBJECT_CACHE_INDEX_MQH__
