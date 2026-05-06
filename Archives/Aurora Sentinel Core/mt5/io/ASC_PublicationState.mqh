#ifndef __ASC_PUBLICATION_STATE_MQH__
#define __ASC_PUBLICATION_STATE_MQH__

#include "../core/ASC_Types.mqh"

string ASC_PublicationStateLabel(const ASC_PublicationState state)
  {
   switch(state)
     {
      case ASC_PUBLICATION_PENDING:    return "pending";
      case ASC_PUBLICATION_FRESH:      return "fresh";
      case ASC_PUBLICATION_STALE:      return "stale";
      case ASC_PUBLICATION_DEGRADED:   return "degraded";
      case ASC_PUBLICATION_CONTINUITY: return "continuity";
      case ASC_PUBLICATION_FAILURE:    return "failure";
     }
   return "pending";
  }

#endif
