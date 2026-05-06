#ifndef __ASC_SEMI_AUTO_MTF_CONTRACTS_MQH__
#define __ASC_SEMI_AUTO_MTF_CONTRACTS_MQH__

#include "../ASC_SemiAutoTypes.mqh"

bool ASC_L6MtfPacketIsUsable(const ASC_L6_MtfPosturePacket &packet)
  {
   return (packet.availability.valid
           && packet.availability.available
           && packet.context_timeframe_role != ""
           && packet.trigger_timeframe_role != "");
  }

#endif
