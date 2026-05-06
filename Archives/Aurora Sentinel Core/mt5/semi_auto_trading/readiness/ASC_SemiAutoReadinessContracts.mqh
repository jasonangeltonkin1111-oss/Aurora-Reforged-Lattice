#ifndef __ASC_SEMI_AUTO_READINESS_CONTRACTS_MQH__
#define __ASC_SEMI_AUTO_READINESS_CONTRACTS_MQH__

#include "../ASC_SemiAutoTypes.mqh"

bool ASC_L6ReadinessPacketIsUsable(const ASC_L6_ReadinessPacket &packet)
  {
   return (packet.availability.valid
           && packet.readiness_reason_summary != ""
           && packet.readiness_class_text != "");
  }

#endif
