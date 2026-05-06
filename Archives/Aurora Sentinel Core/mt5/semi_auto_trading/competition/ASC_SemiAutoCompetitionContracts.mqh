#ifndef __ASC_SEMI_AUTO_COMPETITION_CONTRACTS_MQH__
#define __ASC_SEMI_AUTO_COMPETITION_CONTRACTS_MQH__

#include "../ASC_SemiAutoTypes.mqh"

bool ASC_L6CompetitionPacketIsUsable(const ASC_L6_FamilyCompetitionPacket &packet)
  {
   return (packet.availability.valid && packet.availability.available);
  }

#endif
