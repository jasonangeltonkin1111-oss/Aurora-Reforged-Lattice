#ifndef __IO_ARL_PAYLOADHASH_MQH__
#define __IO_ARL_PAYLOADHASH_MQH__

//+------------------------------------------------------------------+
//| ARL_PayloadHash
//| Aurora Reforged Lattice — runtime IO foundation
//| Run: ARL-RUN009
//| Status: LIGHTWEIGHT SIGNATURE ONLY — no cryptographic claim.
//+------------------------------------------------------------------+
// Owner: io/payload hash
// Purpose: Owns material comparison signatures for no-change skips.
// Inputs: payload strings
// Outputs: deterministic lightweight signature text
// Forbidden: cryptographic/security claims

bool ARL_PayloadHash_Init(){ return true; }

string ARL_PayloadHash_Signature(const string payload)
  {
   uint hash = 2166136261;
   int len = StringLen(payload);
   for(int i=0; i<len; i++)
     {
      hash ^= (uint)StringGetCharacter(payload,i);
      hash *= 16777619;
     }
   return IntegerToString((int)hash) + ":" + IntegerToString(len);
  }

bool ARL_PayloadHash_Equals(const string left_payload,const string right_payload)
  {
   return (StringLen(left_payload) == StringLen(right_payload) && left_payload == right_payload);
  }

string ARL_PayloadHash_Contract(){ return "ACTIVE_LIGHTWEIGHT_SIGNATURE_NO_CRYPTO_CLAIM"; }

#endif // __IO_ARL_PAYLOADHASH_MQH__
