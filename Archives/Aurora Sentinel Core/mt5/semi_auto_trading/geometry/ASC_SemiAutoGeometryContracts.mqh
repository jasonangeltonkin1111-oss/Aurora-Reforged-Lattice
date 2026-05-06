#ifndef __ASC_SEMI_AUTO_GEOMETRY_CONTRACTS_MQH__
#define __ASC_SEMI_AUTO_GEOMETRY_CONTRACTS_MQH__

#include "../ASC_SemiAutoTypes.mqh"

bool ASC_L6GeometryPacketIsUsable(const ASC_L6_GeometryCandidatePacket &packet)
  {
   return (packet.availability.valid
           && packet.availability.available
           && packet.primary_candidate_supported
           && packet.geometry_validity != ASC_L6_GEOMETRY_INVALID);
  }


bool ASC_L6PatternPacketIsConsumerOnlyPrepared(const ASC_L6_AdvancedPatternPacket &packet)
  {
   return (packet.boundary_preserved
           && packet.lane_availability != ASC_L6_PATTERN_LANE_UNAVAILABLE
           && StringLen(packet.candidate_pattern_family) > 0
           && packet.supportive_weight >= 0.0
           && StringFind(packet.boundary_note, "consumer-only") >= 0
           && StringFind(packet.boundary_note, "no Board override") >= 0);
  }


bool ASC_L6MaturityPacketPreservesBoundary(const ASC_L6_MaturityPacket &packet)
  {
   return (StringLen(packet.maturity_state) > 0
           && StringLen(packet.trigger_family_state) > 0
           && StringFind(packet.maturity_boundary_note, "Selected-symbol only") >= 0
           && StringFind(packet.maturity_boundary_note, "consumer-only") >= 0
           && StringFind(packet.maturity_boundary_note, "no Board override") >= 0);
  }


bool ASC_L6HandoffPacketIsConsumable(const ASC_L6_HandoffPacket &packet)
  {
   return (packet.packet_valid
           && packet.packet_lawful
           && packet.handoff_available
           && packet.handoff_availability_state == "handoff_ready_for_future_layer7_interpretation");
  }

#endif
