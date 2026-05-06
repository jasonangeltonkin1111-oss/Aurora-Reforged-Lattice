#ifndef ASC_TYPES_HUD_MQH
#define ASC_TYPES_HUD_MQH

#include "ASC_Enums.mqh"

// Stage 1 HUD/source scaffolding only.
// This defines surface shape without implementing richer HUD behavior.

enum ASC_HUDSourcePlane
  {
   ASC_HUD_SOURCE_STRUCTURAL = 0,
   ASC_HUD_SOURCE_TACTICAL
  };

struct ASC_HUDPageState
  {
   string PageKey;
   string FocusSymbolKey;
   ASC_HUDSourcePlane PrimaryPlane;
   bool Frozen;
   datetime LastTransitionAt;
  };

struct ASC_HUDStatusState
  {
   bool Visible;
   string StatusLine;
   string DetailLine;
  };

#endif // ASC_TYPES_HUD_MQH
