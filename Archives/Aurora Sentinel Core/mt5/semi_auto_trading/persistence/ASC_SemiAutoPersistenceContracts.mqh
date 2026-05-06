#ifndef __ASC_SEMI_AUTO_PERSISTENCE_CONTRACTS_MQH__
#define __ASC_SEMI_AUTO_PERSISTENCE_CONTRACTS_MQH__

#include "../ASC_SemiAutoTypes.mqh"

struct ASC_L6_PersistenceIntent
  {
   bool dossier_publish_requested;
   bool current_focus_publish_requested;
   bool market_board_publish_requested;
   string persistence_note;
  };

void ASC_ResetSemiAutoPersistenceIntent(ASC_L6_PersistenceIntent &intent)
  {
   intent.dossier_publish_requested = false;
   intent.current_focus_publish_requested = false;
   intent.market_board_publish_requested = false;
   intent.persistence_note = "dormant scaffold only; no publication ownership";
  }

#endif
