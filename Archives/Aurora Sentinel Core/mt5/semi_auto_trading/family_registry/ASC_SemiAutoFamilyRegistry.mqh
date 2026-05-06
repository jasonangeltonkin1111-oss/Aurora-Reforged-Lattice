#ifndef __ASC_SEMI_AUTO_FAMILY_REGISTRY_MQH__
#define __ASC_SEMI_AUTO_FAMILY_REGISTRY_MQH__

#include "../ASC_SemiAutoContracts.mqh"

struct ASC_L6_FamilyRegistryEntry
  {
   ASC_L6_FamilyId family_id;
   string family_name;
   bool enabled_for_scaffold;
   string contract_state;
  };

int ASC_L6BuildScaffoldFamilyRegistry(ASC_L6_FamilyRegistryEntry &entries[])
  {
   ArrayResize(entries, 6);

   entries[0].family_id = ASC_L6_FAMILY_CONTINUATION;
   entries[0].family_name = "continuation";
   entries[0].enabled_for_scaffold = true;
   entries[0].contract_state = "stub_only";

   entries[1].family_id = ASC_L6_FAMILY_REVERSAL;
   entries[1].family_name = "reversal";
   entries[1].enabled_for_scaffold = true;
   entries[1].contract_state = "stub_only";

   entries[2].family_id = ASC_L6_FAMILY_RECLAIM;
   entries[2].family_name = "reclaim";
   entries[2].enabled_for_scaffold = true;
   entries[2].contract_state = "stub_only";

   entries[3].family_id = ASC_L6_FAMILY_FAILED_BREAK;
   entries[3].family_name = "failed_break";
   entries[3].enabled_for_scaffold = true;
   entries[3].contract_state = "stub_only";

   entries[4].family_id = ASC_L6_FAMILY_BALANCE_ROTATION;
   entries[4].family_name = "balance_rotation";
   entries[4].enabled_for_scaffold = false;
   entries[4].contract_state = "placeholder_only";

   entries[5].family_id = ASC_L6_FAMILY_BREAKOUT_EXPANSION;
   entries[5].family_name = "breakout_expansion";
   entries[5].enabled_for_scaffold = false;
   entries[5].contract_state = "placeholder_only";

   return ArraySize(entries);
  }

#endif
