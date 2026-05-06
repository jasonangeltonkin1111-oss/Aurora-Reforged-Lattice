#ifndef __ASC_MENU_MODEL_MQH__
#define __ASC_MENU_MODEL_MQH__

#include "../core/ASC_Types.mqh"

struct ASC_MenuSection
  {
   string section_name;
   ASC_MenuSafetyClass safety_class;
   string runtime_owner;
  };

int ASC_BuildTraderMenuSections(ASC_MenuSection &sections[])
  {
   ArrayResize(sections, 12);

   sections[0].section_name = "HUD & Display";
   sections[1].section_name = "Market Board";
   sections[2].section_name = "Current Focus";
   sections[3].section_name = "Dossier";
   sections[4].section_name = "Layer 1 Market State";
   sections[5].section_name = "Layer 2 Snapshot";
   sections[6].section_name = "Selection Filter";
   sections[7].section_name = "Shortlist Context";
   sections[8].section_name = "Deep Analysis";
   sections[9].section_name = "Bucket Browse Controls";
   sections[10].section_name = "Advanced Controls";
   sections[11].section_name = "Reserved / Future Scaffolds";

   for(int i = 0; i < 9; i++)
      sections[i].safety_class = ASC_MENU_SAFE_RUNTIME;

   sections[9].safety_class = ASC_MENU_SAFE_RUNTIME;
   sections[10].safety_class = ASC_MENU_DANGEROUS_RECONFIGURE;
   sections[11].safety_class = ASC_MENU_NON_USER_FACING;

   sections[0].runtime_owner = "HUD consumer";
   sections[1].runtime_owner = "Market Board artifact writer";
   sections[2].runtime_owner = "Current Focus artifact writer";
   sections[3].runtime_owner = "Dossier artifact writer";
   sections[4].runtime_owner = "Layer 1 runtime";
   sections[5].runtime_owner = "Layer 2 (open-symbol snapshot owner)";
   sections[6].runtime_owner = "Selection Filter runtime";
   sections[7].runtime_owner = "Shortlist selection runtime";
   sections[8].runtime_owner = "Deep selective analysis runtime";
   sections[9].runtime_owner = "HUD bucket browse filtering";
   sections[10].runtime_owner = "Dispatcher/governor";
   sections[11].runtime_owner = "Future expansion placeholders only";

   return ArraySize(sections);
  }

#endif
