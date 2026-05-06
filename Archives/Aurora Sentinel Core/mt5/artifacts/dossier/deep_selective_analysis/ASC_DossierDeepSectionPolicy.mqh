#ifndef __ASC_DOSSIER_DEEP_SECTION_POLICY_MQH__
#define __ASC_DOSSIER_DEEP_SECTION_POLICY_MQH__

bool ASC_DossierDeepPolicyNormalPathShellOnly()
  {
   return true;
  }

bool ASC_DossierDeepPolicyAllowFreshPayloadProjection(const bool has_deep_result,
                                                      const ASC_DeepSelectiveAnalysisResult &deep_result)
  {
   if(!has_deep_result)
      return false;
   if(!deep_result.built)
      return false;
   if(!deep_result.lawful)
      return false;
   if(StringLen(deep_result.block_text) <= 0)
      return false;
   return true;
  }

bool ASC_DossierDeepPolicyAllowPreservedPayloadAccess(const string server_root,
                                                      const string canonical_symbol)
  {
   return (StringLen(server_root) > 0 && StringLen(canonical_symbol) > 0);
  }

bool ASC_DossierDeepPolicyHasCompletedMarker(const string text)
  {
   string lowered = text;
   StringToLower(lowered);
   return (StringFind(lowered, "deep analysis status: completed") >= 0
           || StringFind(lowered, "deep selective analysis [l5]: completed") >= 0
           || StringFind(lowered, "deep analysis outcome: completed") >= 0);
  }

bool ASC_DossierDeepPolicyHasBlockedPlaceholderMarker(const string text)
  {
   string lowered = text;
   StringToLower(lowered);

   string blocked_markers[];
   ArrayResize(blocked_markers, 11);
   blocked_markers[0] = "deep analysis status: not yet available";
   blocked_markers[1] = "deep selective analysis [l5]: not yet available";
   blocked_markers[2] = "deep analysis outcome: unavailable";
   blocked_markers[3] = "deep analysis outcome: not yet available";
   blocked_markers[4] = "awaiting_explicit_completion";
   blocked_markers[5] = "request-awaiting";
   blocked_markers[6] = "deep analysis has not yet been requested";
   blocked_markers[7] = "waiting for explicit deep analysis completion";
   blocked_markers[8] = "no completed deep analysis is currently available";
   blocked_markers[9] = "no completed deep analysis has been published yet";
   blocked_markers[10] = "deep_analysis_outcome=unavailable_until_explicit_completion";
   for(int i = 0; i < ArraySize(blocked_markers); i++)
      if(StringFind(lowered, blocked_markers[i]) >= 0)
         return true;

   return false;
  }

#endif
