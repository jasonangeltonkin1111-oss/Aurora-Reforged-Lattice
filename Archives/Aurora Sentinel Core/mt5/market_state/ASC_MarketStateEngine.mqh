#ifndef __ASC_LAYER1_MARKET_STATE_MQH__
#define __ASC_LAYER1_MARKET_STATE_MQH__

#include "../core/ASC_Constants.mqh"
#include "../logging/ASC_FunctionResults.mqh"
#include "../symbols/ASC_ClassificationAuthority.mqh"
#include "../menu/ASC_TraderControlRegistry.mqh"

enum ASC_Layer1State
  {
   ASC_L1_OPEN = 0,
   ASC_L1_CLOSED = 1,
   ASC_L1_UNCERTAIN = 2,
   ASC_L1_UNKNOWN = 3
  };

enum ASC_Layer1DueClass
  {
   ASC_L1_DUE_OPEN = 0,
   ASC_L1_DUE_CLOSED = 1,
   ASC_L1_DUE_UNCERTAIN = 2,
   ASC_L1_DUE_UNKNOWN = 3
  };

enum ASC_Layer1WakeClass
  {
   ASC_L1_WAKE_HOT = 0,
   ASC_L1_WAKE_WARM = 1,
   ASC_L1_WAKE_CALM = 2,
   ASC_L1_WAKE_DORMANT_SCHEDULED = 3
  };

struct ASC_Layer1SymbolState
  {
   string symbol;
   // L0 ownership payloads (identity/classification truth). These are carried by L1 but not
   // cadence-owned by L1 runtime scheduling.
   ASC_SymbolIdentity identity;
   ASC_SymbolClassification classification;
   bool classification_recovery_pending;
   ASC_Layer1State state;
   string state_posture;
   bool state_resolved;
   ASC_Layer1DueClass due_class;
   datetime observed_at_utc;
   string reason;
   string state_reason;
   string next_check;
   datetime next_due_utc;
   string next_due_reason;
   int confirmation_retries;
   string confidence;
   bool is_stale;
   bool is_degraded;
  };

struct ASC_Layer1PassSummary
  {
   datetime pass_utc;
   int total_symbols;
   int assessed_symbols;
   int remaining_symbols;
   int due_symbols;
   int stale_symbols;
   int degraded_symbols;
   int open_count;
   int closed_count;
   int uncertain_count;
   int unknown_count;
   int wake_hot_count;
   int wake_warm_count;
   int wake_calm_count;
   int wake_dormant_scheduled_count;
   int l2_live_entitled_count;
   int dossier_open_refresh_entitled_count;
   int retention_only_count;
   int resolved_classification_count;
   int unresolved_classification_count;
   int fallback_classification_count;
   int main_group_fx_count;
   int main_group_indices_count;
   int main_group_stocks_count;
   int main_group_metals_count;
   int main_group_energy_count;
   int main_group_crypto_count;
   int main_group_rates_count;
   int main_group_volatility_count;
   int main_group_commodities_count;
   int main_group_funds_etfs_count;
   int main_group_unknown_count;
   bool warmup_ready;
   bool is_ready;
   bool is_partial;
   bool is_complete;
   bool is_degraded;
   bool is_stale;
   datetime next_due_utc;
   string next_due_reason;
   int next_due_count;
   string cycle_posture;
   string readiness_posture;
   string publication_posture;
   string posture_note;
  };

ASC_Layer1SymbolState g_asc_l1_cache[];
ASC_Layer1PassSummary g_asc_l1_latest_summary;
bool g_asc_l1_has_summary = false;
ulong g_asc_l1_structural_revision = 0;

string g_asc_l1_account_server = "";
bool g_asc_l1_classification_recovery_sweep_armed = true;
bool g_asc_l1_classification_recovery_sweep_active = false;
bool g_asc_l1_classification_recovery_sweep_completed = false;
datetime g_asc_l1_classification_recovery_started_utc = 0;
datetime g_asc_l1_classification_recovery_completed_utc = 0;
int g_asc_l1_classification_recovery_total = 0;
int g_asc_l1_classification_recovery_done = 0;
int g_asc_l1_classification_recovery_changed = 0;
int g_asc_l1_classification_recovery_promoted_to_resolved = 0;
int g_asc_l1_classification_recovery_still_unresolved = 0;

void ASC_Layer1RebuildSummary(const datetime pass_utc,ASC_Layer1PassSummary &summary);
void ASC_Layer1ApplyStateCadence(ASC_Layer1SymbolState &state,const datetime now_utc);
string ASC_L1StateToText(const ASC_Layer1State state);

void ASC_Layer1FinalizeMarketStatePacket(ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   state.state_posture = ASC_L1StateToText(state.state);
   state.state_resolved = (state.state == ASC_L1_OPEN || state.state == ASC_L1_CLOSED);

   if(StringLen(state.reason) <= 0)
      state.reason = StringFormat("Market posture %s", state.state_posture);
   state.state_reason = state.reason;

   if(StringLen(state.confidence) <= 0)
      state.confidence = state.state_resolved ? "medium" : "low";

   ASC_Layer1ApplyStateCadence(state, now_utc);
  }

void ASC_Layer1AttachIdentityClassificationPacket(ASC_Layer1SymbolState &state)
  {
   if(StringLen(state.identity.raw_symbol) <= 0)
      state.identity.raw_symbol = state.symbol;

   if(StringLen(state.identity.normalized_symbol) <= 0)
     {
      ASC_SymbolIdentity normalized = ASC_NormalizeSymbol(state.symbol);
      state.identity.normalized_symbol = normalized.normalized_symbol;
     }

   if(StringLen(state.classification.raw_symbol) <= 0)
      state.classification.raw_symbol = state.identity.raw_symbol;
   if(StringLen(state.classification.normalized_symbol) <= 0)
      state.classification.normalized_symbol = state.identity.normalized_symbol;

   if(StringLen(state.classification.canonical_symbol) <= 0)
      state.classification.canonical_symbol = state.identity.canonical_symbol;
   if(StringLen(state.classification.canonical_symbol) <= 0)
      state.classification.canonical_symbol = state.identity.normalized_symbol;

   if(StringLen(state.identity.canonical_symbol) <= 0)
      state.identity.canonical_symbol = state.classification.canonical_symbol;
   if(StringLen(state.identity.canonical_symbol) <= 0)
      state.identity.canonical_symbol = state.identity.normalized_symbol;

   if(StringLen(state.classification.canonical_symbol) <= 0)
      state.classification.canonical_symbol = state.identity.canonical_symbol;

   state.identity.state = state.classification.resolved ? ASC_SYMBOL_CLASSIFIED : ASC_SYMBOL_NORMALIZED;
  }

string ASC_Layer1ClassificationReuseBlockReason(const ASC_SymbolClassification &classification)
  {
   if(!classification.resolved)
      return "classification_not_resolved";

   string main_bucket_id = ASC_ClassificationEffectiveMainBucketId(classification);
   if(StringLen(main_bucket_id) <= 0 || main_bucket_id == "unknown")
      return "main_bucket_unknown";

   string sub_bucket_source = classification.sub_bucket_source;
   StringTrimLeft(sub_bucket_source);
   StringTrimRight(sub_bucket_source);
   StringToLower(sub_bucket_source);
   if(StringLen(sub_bucket_source) <= 0 || sub_bucket_source == "unresolved")
      return "sub_bucket_source_unresolved";
   if(StringFind(sub_bucket_source, "fallback") >= 0)
      return "sub_bucket_source_fallback";
   if(sub_bucket_source == "upcomers_seed_immediate_bucket_v1")
      return "sub_bucket_source_seed_fallback";

   string resolution_state = classification.resolution_state;
   StringTrimLeft(resolution_state);
   StringTrimRight(resolution_state);
   StringToLower(resolution_state);
   if(StringLen(resolution_state) <= 0)
      return "resolution_state_missing";
   if(resolution_state == "unresolved" || resolution_state == "needs review" || resolution_state == "needs_review")
      return "resolution_state_unresolved";
   if(StringFind(resolution_state, "fallback") >= 0)
      return "resolution_state_fallback";
   if(StringFind(resolution_state, "reset") >= 0)
      return "resolution_state_reset";

   return "";
  }

bool ASC_Layer1ClassificationCanReuse(const ASC_SymbolClassification &classification)
  {
   return (StringLen(ASC_Layer1ClassificationReuseBlockReason(classification)) <= 0);
  }

bool ASC_Layer1ClassificationLooksUnknownOrUnresolved(const ASC_SymbolClassification &classification)
  {
   if(!classification.resolved)
      return true;
   if(ASC_ClassificationEffectiveMainBucketId(classification) == "unknown")
      return true;

   string resolution_state = classification.resolution_state;
   StringTrimLeft(resolution_state);
   StringTrimRight(resolution_state);
   StringToLower(resolution_state);
   if(resolution_state == "unresolved" || resolution_state == "needs review" || resolution_state == "needs_review")
      return true;

   return false;
  }

string ASC_Layer1ClassificationRecoveryCompact()
  {
   string sweep_state = "inactive";
   if(g_asc_l1_classification_recovery_sweep_active)
      sweep_state = "active";
   else if(g_asc_l1_classification_recovery_sweep_completed)
      sweep_state = "complete";

   return StringFormat("state=%s done=%d/%d changed=%d promoted=%d unresolved=%d bridge=%s",
                       sweep_state,
                       g_asc_l1_classification_recovery_done,
                       g_asc_l1_classification_recovery_total,
                       g_asc_l1_classification_recovery_changed,
                       g_asc_l1_classification_recovery_promoted_to_resolved,
                       g_asc_l1_classification_recovery_still_unresolved,
                       ASC_ClassificationBridgeSourcePath());
  }

void ASC_Layer1PrepareClassificationRecoverySweep(const datetime now_utc)
  {
   int total = ArraySize(g_asc_l1_cache);
   g_asc_l1_classification_recovery_sweep_armed = false;
   g_asc_l1_classification_recovery_sweep_active = true;
   g_asc_l1_classification_recovery_sweep_completed = false;
   g_asc_l1_classification_recovery_started_utc = now_utc;
   g_asc_l1_classification_recovery_completed_utc = 0;
   g_asc_l1_classification_recovery_total = total;
   g_asc_l1_classification_recovery_done = 0;
   g_asc_l1_classification_recovery_changed = 0;
   g_asc_l1_classification_recovery_promoted_to_resolved = 0;
   g_asc_l1_classification_recovery_still_unresolved = 0;

   if(total <= 0)
     {
      g_asc_l1_classification_recovery_sweep_active = false;
      g_asc_l1_classification_recovery_sweep_completed = true;
      g_asc_l1_classification_recovery_completed_utc = now_utc;
      return;
     }

   for(int i = 0; i < total; i++)
     {
      g_asc_l1_cache[i].classification_recovery_pending = true;
      g_asc_l1_cache[i].next_due_utc = 0;
      g_asc_l1_cache[i].next_due_reason = "classification-recovery-sweep";
     }
  }

void ASC_Layer1ApplyClassificationRecoveryResult(const ASC_Layer1SymbolState &before_state,
                                                 const ASC_Layer1SymbolState &after_state)
  {
   if(!g_asc_l1_classification_recovery_sweep_active || !before_state.classification_recovery_pending)
      return;

   g_asc_l1_classification_recovery_done++;

   bool before_unknown_or_unresolved = ASC_Layer1ClassificationLooksUnknownOrUnresolved(before_state.classification);
   bool after_unknown_or_unresolved = ASC_Layer1ClassificationLooksUnknownOrUnresolved(after_state.classification);
   bool classification_changed = (before_state.classification.main_bucket_id != after_state.classification.main_bucket_id
                                  || before_state.classification.sub_bucket_id != after_state.classification.sub_bucket_id
                                  || before_state.classification.sub_bucket_source != after_state.classification.sub_bucket_source
                                  || before_state.classification.resolution_state != after_state.classification.resolution_state
                                  || before_state.classification.resolved != after_state.classification.resolved);
   if(classification_changed)
      g_asc_l1_classification_recovery_changed++;

   if(before_unknown_or_unresolved && !after_unknown_or_unresolved && after_state.classification.resolved)
      g_asc_l1_classification_recovery_promoted_to_resolved++;

   if(after_unknown_or_unresolved)
      g_asc_l1_classification_recovery_still_unresolved++;

   if(g_asc_l1_classification_recovery_done >= g_asc_l1_classification_recovery_total)
     {
      g_asc_l1_classification_recovery_sweep_active = false;
      g_asc_l1_classification_recovery_sweep_completed = true;
      g_asc_l1_classification_recovery_completed_utc = after_state.observed_at_utc;
     }
  }

string ASC_Layer1AccountServer()
  {
   if(StringLen(g_asc_l1_account_server) <= 0)
      g_asc_l1_account_server = AccountInfoString(ACCOUNT_SERVER);
   return g_asc_l1_account_server;
  }

void ASC_Layer1RefreshLatestSummary(const datetime pass_utc)
  {
   ASC_Layer1RebuildSummary(pass_utc, g_asc_l1_latest_summary);
   g_asc_l1_has_summary = true;
  }


string ASC_L1StateToText(const ASC_Layer1State state)
  {
   switch(state)
     {
      case ASC_L1_OPEN:
         return "open";
      case ASC_L1_CLOSED:
         return "closed";
      case ASC_L1_UNCERTAIN:
         return "uncertain";
      default:
         return "unknown";
     }
  }

string ASC_L1StateToOperatorText(const ASC_Layer1State state)
  {
   switch(state)
     {
      case ASC_L1_OPEN:
         return "Open";
      case ASC_L1_CLOSED:
         return "Closed";
      case ASC_L1_UNCERTAIN:
         return "Uncertain";
      default:
         return "Unknown";
     }
  }

string ASC_L1DueClassToText(const ASC_Layer1DueClass due_class)
  {
   switch(due_class)
     {
      case ASC_L1_DUE_OPEN:
         return "open";
      case ASC_L1_DUE_CLOSED:
         return "closed";
      case ASC_L1_DUE_UNCERTAIN:
         return "uncertain";
      default:
         return "unknown";
     }
  }

string ASC_L1WakeClassToText(const ASC_Layer1WakeClass wake_class)
  {
   switch(wake_class)
     {
      case ASC_L1_WAKE_HOT:
         return "hot";
      case ASC_L1_WAKE_WARM:
         return "warm";
      case ASC_L1_WAKE_CALM:
         return "calm";
      default:
         return "dormant-but-scheduled";
     }
  }

string ASC_L1DueReasonToOperatorText(const string reason)
  {
   if(reason == "unknown-priority" || reason == "awaiting-first-check")
      return "Unknown";
   if(reason == "uncertain-confirmation" || reason == "awaiting-confirmation" || reason == "uncertain-bounded-backoff")
      return "Awaiting Confirmation";
   if(reason == "open-maintenance")
      return "Open";
   if(reason == "closed-wake-recheck" || reason == "closed-calm-wake" || reason == "closed-dormant-scheduled")
      return "Closed";
   if(reason == "scheduled-recheck")
      return "Scheduled Recheck";
   return "Awaiting Confirmation";
  }

string ASC_L1ConfidenceToOperatorText(const string confidence)
  {
   string value = confidence;
   StringToLower(value);
   if(value == "high")
      return "High";
   if(value == "medium")
      return "Medium";
   if(value == "low")
      return "Low";
   return "Unknown";
  }

string ASC_L1ReasonToOperatorText(const string reason)
  {
   if(reason == "Market state unavailable")
      return "Awaiting confirmation: market-state evidence is unavailable.";
   if(reason == "Session appears closed")
      return "Closed confirmed from current session posture.";
   if(reason == "Awaiting first tick")
      return "Awaiting confirmation: first live tick not observed yet.";
   if(reason == "Awaiting confirmation (no current tick)")
      return "Awaiting confirmation: no current live tick is available.";
   return reason;
  }

string ASC_L1FreshnessToOperatorText(const ASC_Layer1SymbolState &state)
  {
   if(state.is_degraded)
      return "Degraded";
   if(state.is_stale)
      return "Stale";
   return "Fresh";
  }

string ASC_L1PostureToOperatorText(const ASC_Layer1SymbolState &state)
  {
   if(state.state == ASC_L1_OPEN)
     {
      if(state.is_degraded)
         return "Open (degraded freshness)";
      if(state.is_stale)
         return "Open (stale freshness)";
      return "Open";
     }

   if(state.state == ASC_L1_CLOSED)
     {
      if(StringFind(state.reason, "Dormant") >= 0)
         return "Closed (dormant scheduled recheck)";
      if(StringFind(state.reason, "continuity retained") >= 0)
         return "Closed (continuity retained)";
      return "Closed";
     }

   if(state.state == ASC_L1_UNCERTAIN)
     {
      if(state.is_degraded)
         return "Uncertain (degraded confirmation)";
      if(state.is_stale)
         return "Uncertain (stale confirmation)";
      return "Uncertain";
     }

   if(state.is_degraded)
      return "Unknown (degraded evidence)";
   if(state.is_stale)
      return "Unknown (stale evidence)";
   return "Unknown";
  }

string ASC_L1SessionStatusToOperatorText(const ASC_Layer1SymbolState &state)
  {
   if(state.state == ASC_L1_CLOSED)
     {
      if(StringFind(state.reason, "Dormant") >= 0)
         return "Closed confirmed with dormant recheck posture.";
      if(StringFind(state.reason, "continuity retained") >= 0)
         return "Closed confirmed from retained continuity evidence.";
      return ASC_L1ReasonToOperatorText(state.reason);
     }

   if(state.state == ASC_L1_OPEN)
     {
      if(state.is_degraded)
         return "Open confirmed, but freshness is degraded.";
      if(state.is_stale)
         return "Open confirmed, but freshness is stale.";
      return ASC_L1ReasonToOperatorText(state.reason);
     }

   if(state.state == ASC_L1_UNCERTAIN)
     {
      if(state.is_degraded)
         return "Awaiting confirmation under degraded evidence posture.";
      if(state.is_stale)
         return "Awaiting confirmation after stale market-state evidence.";
      return ASC_L1ReasonToOperatorText(state.reason);
     }

   if(state.is_degraded)
      return "Awaiting confirmation: market-state evidence is degraded.";
   if(state.is_stale)
      return "Awaiting confirmation: market-state evidence is stale.";
   return ASC_L1ReasonToOperatorText(state.reason);
  }

string ASC_L1TimingStatusNotesToOperatorText(const ASC_Layer1SymbolState &state)
  {
   if(state.next_due_reason == "unknown-priority" || state.next_due_reason == "awaiting-first-check")
     {
      if(state.is_degraded)
         return "First confirmation is still pending under degraded evidence.";
      if(state.is_stale)
         return "First confirmation is still pending under stale evidence.";
      return "First confirmation is still pending.";
     }

   if(state.next_due_reason == "uncertain-confirmation" || state.next_due_reason == "awaiting-confirmation")
     {
      if(state.is_stale)
         return "Confirmation retry is scheduled because market-state evidence is stale.";
      return "Confirmation retry is scheduled.";
     }

   if(state.next_due_reason == "uncertain-bounded-backoff")
     {
      if(state.is_degraded || state.is_stale)
         return "Bounded confirmation backoff is active because the latest market-state evidence stayed stale or degraded.";
      return "Bounded confirmation backoff is active.";
     }

   if(state.next_due_reason == "open-maintenance")
     {
      if(state.is_degraded || state.is_stale)
         return "Open-market maintenance is scheduled, but freshness remains guarded.";
      return "Open-market maintenance refresh is scheduled.";
     }

   if(state.next_due_reason == "closed-dormant-scheduled")
      return "Dormant closed-market recheck is scheduled.";

   if(state.next_due_reason == "closed-calm-wake-recheck" || state.next_due_reason == "closed-calm-wake" || state.next_due_reason == "closed-dormant-scheduled")
      return "Closed-market recheck is scheduled.";

   if(state.next_due_reason == "scheduled-recheck")
      return "Scheduled market-state recheck is queued.";

   return ASC_L1DueReasonToOperatorText(state.next_due_reason);
  }

string ASC_L1EvidenceRecheckState(const ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   if(StringLen(state.symbol) <= 0)
      return "not_applicable";

   if(state.is_degraded)
      return "dependency_blocked";
   if(state.is_stale)
      return "stale_but_recoverable";

   bool due_now = (state.next_due_utc <= 0 || state.next_due_utc <= now_utc);
   if(state.state == ASC_L1_OPEN && state.confidence == "high" && !due_now)
      return "recovered_to_supported";
   if(state.state == ASC_L1_CLOSED && !due_now)
      return "not_applicable";
   if(state.state == ASC_L1_UNCERTAIN)
      return due_now ? "refresh_due" : "retry_scheduled";
   if(state.state == ASC_L1_UNKNOWN)
      return due_now ? "refresh_due" : "refresh_pending";
   if(due_now)
      return "refresh_due";

   return "refresh_pending";
  }

string ASC_L1EvidenceRecheckBridgeDetail(const ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   return "l1_evidence_recheck_bridge=present"
          + StringFormat(" | l1_evidence_recheck_state=%s", ASC_L1EvidenceRecheckState(state, now_utc))
          + StringFormat(" | l1_next_due_reason=%s", state.next_due_reason)
          + StringFormat(" | l1_next_due_utc=%d", (int)state.next_due_utc)
          + " | l1_existing_cadence_only=yes"
          + " | l1_unavailable_not_permanent_gate=yes"
          + " | l1_no_heavy_refresh_loop=yes";
  }

string ASC_BoolToYesNo(const bool value)
  {
   if(value)
      return "yes";
  return "no";
  }

void ASC_Layer1AccumulateMainGroupCount(ASC_Layer1PassSummary &summary,const string main_group_id_raw)
  {
   string main_group_id = main_group_id_raw;
   StringToLower(main_group_id);
   if(main_group_id == "fx")
      summary.main_group_fx_count++;
   else if(main_group_id == "indices")
      summary.main_group_indices_count++;
   else if(main_group_id == "stocks")
      summary.main_group_stocks_count++;
   else if(main_group_id == "metals")
      summary.main_group_metals_count++;
   else if(main_group_id == "energy")
      summary.main_group_energy_count++;
   else if(main_group_id == "crypto")
      summary.main_group_crypto_count++;
   else if(main_group_id == "rates")
      summary.main_group_rates_count++;
   else if(main_group_id == "volatility")
      summary.main_group_volatility_count++;
   else if(main_group_id == "commodities")
      summary.main_group_commodities_count++;
   else if(main_group_id == "funds_etfs")
      summary.main_group_funds_etfs_count++;
   else
      summary.main_group_unknown_count++;
  }

string ASC_Layer1MainGroupDistributionCompact(const ASC_Layer1PassSummary &summary)
  {
   return StringFormat("fx=%d indices=%d stocks=%d metals=%d energy=%d crypto=%d rates=%d vol=%d comm=%d funds=%d unknown=%d",
                       summary.main_group_fx_count,
                       summary.main_group_indices_count,
                       summary.main_group_stocks_count,
                       summary.main_group_metals_count,
                       summary.main_group_energy_count,
                       summary.main_group_crypto_count,
                       summary.main_group_rates_count,
                       summary.main_group_volatility_count,
                       summary.main_group_commodities_count,
                       summary.main_group_funds_etfs_count,
                       summary.main_group_unknown_count);
  }

string ASC_Layer1ClassificationHealthCompact(const ASC_Layer1PassSummary &summary)
  {
   return StringFormat("resolved=%d unresolved=%d fallback=%d",
                       summary.resolved_classification_count,
                       summary.unresolved_classification_count,
                       summary.fallback_classification_count);
  }

void ASC_Layer1ResetCache(const int total)
  {
   g_asc_l1_account_server = "";
   g_asc_l1_structural_revision++;
   ArrayResize(g_asc_l1_cache, total);
   for(int i = 0; i < total; i++)
     {
      g_asc_l1_cache[i].symbol = "";
      g_asc_l1_cache[i].identity = ASC_NormalizeSymbol("");
      ASC_ClassificationReset(g_asc_l1_cache[i].classification, g_asc_l1_cache[i].identity);
      g_asc_l1_cache[i].classification_recovery_pending = true;
      g_asc_l1_cache[i].state = ASC_L1_UNKNOWN;
      g_asc_l1_cache[i].state_posture = "unknown";
      g_asc_l1_cache[i].state_resolved = false;
      g_asc_l1_cache[i].due_class = ASC_L1_DUE_UNKNOWN;
      g_asc_l1_cache[i].observed_at_utc = 0;
      g_asc_l1_cache[i].reason = "Awaiting first check";
      g_asc_l1_cache[i].state_reason = g_asc_l1_cache[i].reason;
      g_asc_l1_cache[i].next_check = "scan-required";
      g_asc_l1_cache[i].next_due_utc = 0;
      g_asc_l1_cache[i].next_due_reason = "awaiting-first-check";
      g_asc_l1_cache[i].confirmation_retries = 0;
      g_asc_l1_cache[i].confidence = "n/a";
      g_asc_l1_cache[i].is_stale = true;
      g_asc_l1_cache[i].is_degraded = false;
     }
  }

bool ASC_Layer1MaterialStateChanged(const ASC_Layer1SymbolState &before_state,const ASC_Layer1SymbolState &after_state)
  {
   if(before_state.symbol != after_state.symbol)
      return true;
   if(before_state.state != after_state.state)
      return true;
   if(before_state.classification.main_bucket_id != after_state.classification.main_bucket_id)
      return true;
   if(before_state.classification.main_bucket_name != after_state.classification.main_bucket_name)
      return true;
   if(before_state.classification.sub_bucket_id != after_state.classification.sub_bucket_id)
      return true;
   if(before_state.classification.sub_bucket_name != after_state.classification.sub_bucket_name)
      return true;
   if(before_state.classification.sub_bucket_source != after_state.classification.sub_bucket_source)
      return true;
   if(before_state.classification.resolved != after_state.classification.resolved)
      return true;
   if(before_state.is_stale != after_state.is_stale)
      return true;
   if(before_state.is_degraded != after_state.is_degraded)
      return true;
   return false;
  }

string ASC_Layer1DueText(const datetime now_utc,const datetime due_utc)
  {
   if(due_utc <= 0)
      return "scan-required";

   int delta = (int)(due_utc - now_utc);
   if(delta <= 0)
      return "due-now";

   return StringFormat("in %d sec", delta);
  }

void ASC_Layer1ScheduleNextDue(ASC_Layer1SymbolState &state,const datetime now_utc,const int seconds,const string reason)
  {
   int local_seconds = seconds;
   if(local_seconds < 1)
      local_seconds = 1;

   state.next_due_utc = now_utc + local_seconds;
   state.next_due_reason = reason;
   state.next_check = ASC_Layer1DueText(now_utc, state.next_due_utc);
  }

int ASC_Layer1UniverseScale(const int total_symbols)
  {
   if(total_symbols >= 1000)
      return 4;
   if(total_symbols >= 400)
      return 3;
   if(total_symbols >= 120)
      return 2;
   return 1;
  }

int ASC_Layer1AdaptiveCadenceSeconds(const ASC_Layer1SymbolState &state,const int base_seconds)
  {
   int total_symbols = ArraySize(g_asc_l1_cache);
   int scale = ASC_Layer1UniverseScale(total_symbols);
   int seconds = base_seconds;

   if(state.state == ASC_L1_CLOSED)
     {
      int closed_step = MathMax(15, base_seconds / 2);
      seconds = base_seconds + ((scale - 1) * closed_step);
      if(StringFind(state.reason, "Dormant") >= 0
         || StringFind(state.reason, "continuity retained") >= 0
         || state.reason == "Session appears closed")
         seconds += MathMax(base_seconds, 180);
     }
   else if(state.state == ASC_L1_OPEN)
     {
      int open_step = MathMax(5, base_seconds / 4);
      seconds = base_seconds + ((scale - 1) * open_step);
     }
   else if(state.state == ASC_L1_UNCERTAIN)
     {
      if(state.confirmation_retries >= g_asc_trader_controls.l1_confirmation_retry_cap)
        {
         int bounded_retry = g_asc_trader_controls.l1_recheck_uncertain_sec * MathMax(1, scale);
         seconds = MathMin(base_seconds, bounded_retry);
        }
      else
         seconds = base_seconds;
     }
   else if(state.state == ASC_L1_UNKNOWN)
      seconds = MathMax(1, base_seconds - (scale - 1));

   return ASC_ClampInt(seconds, 1, 7200);
  }

bool ASC_Layer1IsWarmupReady(const ASC_Layer1PassSummary &summary)
  {
   if(summary.total_symbols <= 0)
      return false;
   if(summary.assessed_symbols < MathMin(summary.total_symbols, g_asc_trader_controls.partial_write_min_assessed))
      return false;
   if(summary.unknown_count > g_asc_trader_controls.l1_warmup_unknown_max)
      return false;
   if(summary.uncertain_count > g_asc_trader_controls.l1_warmup_uncertain_max)
      return false;
   return true;
  }


// RUN078R: post-warmup materiality helper.
// Minor isolated degraded symbols should not collapse a settled L1 summary into degraded/disturbed.
// Unknown/uncertain safety limits remain hard blockers and are intentionally evaluated separately.
int ASC_Layer1MaterialDegradedSymbolLimit(const ASC_Layer1PassSummary &summary)
  {
   int assessed = MathMax(0, summary.assessed_symbols);
   if(assessed <= 0)
      return 0;

   // Small absolute floor plus a bounded 2% assessed-universe allowance.
   // This keeps one non-critical degraded symbol from blocking Steady after warmup,
   // while still treating clustered degradation as material.
   int percent_limit = (int)MathFloor((double)assessed * 0.02);
   int limit = MathMax(1, percent_limit);
   return limit;
  }

bool ASC_Layer1HasMaterialDegradation(const ASC_Layer1PassSummary &summary)
  {
   if(summary.unknown_count > g_asc_trader_controls.l1_ready_unknown_max)
      return true;
   if(summary.uncertain_count > g_asc_trader_controls.l1_ready_uncertain_max)
      return true;
   if(summary.degraded_symbols <= 0)
      return false;

   int material_limit = ASC_Layer1MaterialDegradedSymbolLimit(summary);
   return (summary.degraded_symbols > material_limit);
  }

string ASC_Layer1ReadinessPosture(const ASC_Layer1PassSummary &summary)
  {
   if(summary.is_degraded)
      return "degraded";
   if(summary.is_stale)
      return "stale";
   if(summary.is_ready && summary.is_complete)
      return "steady";
   if(summary.is_ready)
      return "ready";
   return "partial";
  }

string ASC_Layer1PublicationPosture(const ASC_Layer1PassSummary &summary)
  {
   if(summary.is_degraded)
      return "degraded";
   if(summary.is_stale)
      return "stale";
   if(summary.is_complete)
      return "fresh";
   return "partial";
  }

string ASC_Layer1OperatorSummaryReason(const ASC_Layer1PassSummary &summary)
  {
   if(summary.is_degraded)
     {
      if(summary.degraded_symbols > ASC_Layer1MaterialDegradedSymbolLimit(summary))
         return "Material market-state degradation requires confirmation.";
      if(summary.unknown_count > g_asc_trader_controls.l1_ready_unknown_max)
         return "Market coverage is partial.";
      if(summary.uncertain_count > g_asc_trader_controls.l1_ready_uncertain_max)
         return "Awaiting confirmation on some symbols.";
      return "Some market-state checks need confirmation.";
     }

   if(summary.is_stale)
      return "Latest scanner update is delayed.";

   if(summary.is_partial)
      return "Market coverage is still building.";

   if(summary.is_ready && summary.is_complete)
      return "Scanner checks are current.";

   return "Scanner checks are in progress.";
  }

void ASC_Layer1ApplyStateCadence(ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   switch(state.state)
     {
      case ASC_L1_OPEN:
         state.due_class = ASC_L1_DUE_OPEN;
         ASC_Layer1ScheduleNextDue(state,
                                   now_utc,
                                   ASC_Layer1AdaptiveCadenceSeconds(state, g_asc_trader_controls.l1_recheck_open_sec),
                                   "open-maintenance");
         break;
      case ASC_L1_CLOSED:
        {
         state.due_class = ASC_L1_DUE_CLOSED;
         string closed_reason = "closed-calm-wake";
         if(StringFind(state.reason, "Dormant") >= 0
            || StringFind(state.reason, "continuity retained") >= 0
            || state.reason == "Session appears closed")
            closed_reason = "closed-dormant-scheduled";
         ASC_Layer1ScheduleNextDue(state,
                                   now_utc,
                                   ASC_Layer1AdaptiveCadenceSeconds(state, g_asc_trader_controls.l1_recheck_closed_sec),
                                   closed_reason);
         break;
        }
      case ASC_L1_UNCERTAIN:
         state.due_class = ASC_L1_DUE_UNCERTAIN;
         if(state.confirmation_retries >= g_asc_trader_controls.l1_confirmation_retry_cap)
            ASC_Layer1ScheduleNextDue(state,
                                      now_utc,
                                      ASC_Layer1AdaptiveCadenceSeconds(state, g_asc_trader_controls.l1_recheck_open_sec),
                                      "uncertain-bounded-backoff");
         else
            ASC_Layer1ScheduleNextDue(state,
                                      now_utc,
                                      ASC_Layer1AdaptiveCadenceSeconds(state, g_asc_trader_controls.l1_recheck_uncertain_sec),
                                      "uncertain-confirmation");
         break;
      default:
         state.due_class = ASC_L1_DUE_UNKNOWN;
         ASC_Layer1ScheduleNextDue(state,
                                   now_utc,
                                   ASC_Layer1AdaptiveCadenceSeconds(state, g_asc_trader_controls.l1_recheck_unknown_sec),
                                   "unknown-priority");
         break;
     }
  }

bool ASC_L1EntitlesLayer2LiveRefresh(const ASC_Layer1SymbolState &state)
  {
   return (state.state == ASC_L1_OPEN && !state.is_stale && !state.is_degraded);
  }

bool ASC_L1EntitlesDossierOpenRefresh(const ASC_Layer1SymbolState &state)
  {
   return (state.state == ASC_L1_OPEN);
  }

bool ASC_L1IsRetentionOnly(const ASC_Layer1SymbolState &state)
  {
   return (state.state != ASC_L1_OPEN || state.is_stale || state.is_degraded);
  }

ASC_Layer1WakeClass ASC_L1WakeClassForSymbol(const ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   switch(state.state)
     {
      case ASC_L1_OPEN:
         if(state.next_due_utc <= 0 || state.next_due_utc <= now_utc)
            return ASC_L1_WAKE_HOT;
         return ASC_L1_WAKE_WARM;
      case ASC_L1_CLOSED:
        {
         if(StringFind(state.reason, "Dormant") >= 0)
            return ASC_L1_WAKE_DORMANT_SCHEDULED;
         return ASC_L1_WAKE_CALM;
        }
      case ASC_L1_UNCERTAIN:
         if(state.confirmation_retries >= g_asc_trader_controls.l1_confirmation_retry_cap)
            return ASC_L1_WAKE_WARM;
         return ASC_L1_WAKE_HOT;
      default:
         return ASC_L1_WAKE_HOT;
     }
  }

void ASC_Layer1RebuildSummary(const datetime pass_utc,ASC_Layer1PassSummary &summary)
  {
   summary.pass_utc = pass_utc;
   summary.total_symbols = ArraySize(g_asc_l1_cache);
   summary.assessed_symbols = 0;
   summary.remaining_symbols = 0;
   summary.due_symbols = 0;
   summary.stale_symbols = 0;
   summary.degraded_symbols = 0;
   summary.open_count = 0;
   summary.closed_count = 0;
   summary.uncertain_count = 0;
   summary.unknown_count = 0;
   summary.wake_hot_count = 0;
   summary.wake_warm_count = 0;
   summary.wake_calm_count = 0;
   summary.wake_dormant_scheduled_count = 0;
   summary.l2_live_entitled_count = 0;
   summary.dossier_open_refresh_entitled_count = 0;
   summary.retention_only_count = 0;
   summary.resolved_classification_count = 0;
   summary.unresolved_classification_count = 0;
   summary.fallback_classification_count = 0;
   summary.main_group_fx_count = 0;
   summary.main_group_indices_count = 0;
   summary.main_group_stocks_count = 0;
   summary.main_group_metals_count = 0;
   summary.main_group_energy_count = 0;
   summary.main_group_crypto_count = 0;
   summary.main_group_rates_count = 0;
   summary.main_group_volatility_count = 0;
   summary.main_group_commodities_count = 0;
   summary.main_group_funds_etfs_count = 0;
   summary.main_group_unknown_count = 0;
   summary.warmup_ready = false;
   summary.is_ready = false;
   summary.is_partial = true;
   summary.is_complete = false;
   summary.is_degraded = false;
   summary.is_stale = false;
   summary.next_due_utc = 0;
   summary.next_due_reason = "awaiting-first-check";
   summary.next_due_count = 0;
   summary.cycle_posture = "partial";
   summary.readiness_posture = "partial";
   summary.publication_posture = "partial";
   summary.posture_note = "Market coverage is still building.";

   int next_due_unknown = 0;
   int next_due_uncertain = 0;
   int next_due_open = 0;
   int next_due_closed = 0;
   datetime current_next_due_utc = 0;

   for(int i = 0; i < summary.total_symbols; i++)
     {
      ASC_Layer1SymbolState state = g_asc_l1_cache[i];
      if(StringLen(state.symbol) <= 0)
        {
         summary.remaining_symbols++;
         summary.unknown_count++;
         continue;
        }

      summary.assessed_symbols++;
      switch(state.state)
        {
         case ASC_L1_OPEN:
            summary.open_count++;
            break;
         case ASC_L1_CLOSED:
            summary.closed_count++;
            break;
         case ASC_L1_UNCERTAIN:
            summary.uncertain_count++;
            break;
         default:
            summary.unknown_count++;
            break;
        }

      if(state.classification.resolved)
         summary.resolved_classification_count++;
      else
         summary.unresolved_classification_count++;
      if(state.classification.sub_bucket_source == "upcomers_seed_immediate_bucket_v1")
         summary.fallback_classification_count++;
      ASC_Layer1AccumulateMainGroupCount(summary, ASC_ClassificationEffectiveMainBucketId(state.classification));

      ASC_Layer1WakeClass wake_class = ASC_L1WakeClassForSymbol(state, pass_utc);
      switch(wake_class)
        {
         case ASC_L1_WAKE_HOT:
            summary.wake_hot_count++;
            break;
         case ASC_L1_WAKE_WARM:
            summary.wake_warm_count++;
            break;
         case ASC_L1_WAKE_CALM:
            summary.wake_calm_count++;
            break;
         default:
            summary.wake_dormant_scheduled_count++;
            break;
        }

      if(ASC_L1EntitlesLayer2LiveRefresh(state))
         summary.l2_live_entitled_count++;
      if(ASC_L1EntitlesDossierOpenRefresh(state))
         summary.dossier_open_refresh_entitled_count++;
      if(ASC_L1IsRetentionOnly(state))
         summary.retention_only_count++;

      if(state.is_stale)
         summary.stale_symbols++;
      if(state.is_degraded)
         summary.degraded_symbols++;

      bool is_due = (state.state == ASC_L1_UNKNOWN || state.next_due_utc <= 0 || state.next_due_utc <= pass_utc);
      if(is_due)
         summary.due_symbols++;

      if(state.next_due_utc <= 0)
        {
         current_next_due_utc = 0;
         summary.next_due_utc = 0;
         summary.next_due_count = 0;
         next_due_unknown = 0;
         next_due_uncertain = 0;
         next_due_open = 0;
         next_due_closed = 0;
        }
      else if(current_next_due_utc == 0 || state.next_due_utc < current_next_due_utc)
        {
         current_next_due_utc = state.next_due_utc;
         summary.next_due_utc = state.next_due_utc;
         summary.next_due_count = 0;
         next_due_unknown = 0;
         next_due_uncertain = 0;
         next_due_open = 0;
         next_due_closed = 0;
        }

      if(current_next_due_utc > 0 && state.next_due_utc == current_next_due_utc)
        {
         summary.next_due_count++;
         switch(state.due_class)
           {
            case ASC_L1_DUE_UNKNOWN:
               next_due_unknown++;
               break;
            case ASC_L1_DUE_UNCERTAIN:
               next_due_uncertain++;
               break;
            case ASC_L1_DUE_OPEN:
               next_due_open++;
               break;
            case ASC_L1_DUE_CLOSED:
               next_due_closed++;
               break;
           }
        }
     }

   if(next_due_unknown > 0)
      summary.next_due_reason = "unknown-priority";
   else if(next_due_uncertain > 0)
      summary.next_due_reason = "awaiting-confirmation";
   else if(next_due_open > 0)
      summary.next_due_reason = "open-maintenance";
   else if(next_due_closed > 0)
      summary.next_due_reason = "closed-calm-wake";
   else if(summary.next_due_utc <= 0)
      summary.next_due_reason = "awaiting-first-check";
   else
      summary.next_due_reason = "scheduled-recheck";

   // RUN077R: maintenance-due symbols alone do not make settled coverage partial.
   // Unknown/uncertain due states and remaining unassessed symbols still block completeness.
   bool material_due_symbols = (next_due_unknown > 0 || next_due_uncertain > 0);
   summary.is_complete = (summary.remaining_symbols == 0 && !material_due_symbols && summary.assessed_symbols >= MathMin(summary.total_symbols, g_asc_trader_controls.partial_write_min_assessed));
   summary.is_partial = !summary.is_complete;
   summary.is_stale = (summary.stale_symbols > g_asc_trader_controls.l1_stale_symbol_max);

   // RUN078R: material degradation threshold.
   // Unknown/uncertain limits remain safety-sensitive hard blockers.
   // Degraded-symbol count becomes material only when it exceeds the bounded threshold,
   // so one isolated non-critical degraded symbol no longer blocks post-warmup Steady.
   bool material_degradation = ASC_Layer1HasMaterialDegradation(summary);
   summary.is_degraded = material_degradation;
   summary.warmup_ready = ASC_Layer1IsWarmupReady(summary);
   summary.is_ready = (summary.warmup_ready && summary.unknown_count <= g_asc_trader_controls.l1_ready_unknown_max && summary.uncertain_count <= g_asc_trader_controls.l1_ready_uncertain_max && !material_degradation && !summary.is_stale);

   if(summary.is_complete)
      summary.cycle_posture = "complete";
   else if(summary.assessed_symbols <= 0)
      summary.cycle_posture = "pending";
   else
      summary.cycle_posture = "partial";

   summary.readiness_posture = ASC_Layer1ReadinessPosture(summary);
   summary.publication_posture = ASC_Layer1PublicationPosture(summary);

   if(summary.is_ready && summary.is_complete)
      summary.posture_note = "Scanner checks are current.";
   else if(summary.is_degraded)
      summary.posture_note = "Scanner checks are degraded: " + ASC_Layer1OperatorSummaryReason(summary);
   else if(summary.is_stale)
      summary.posture_note = "Scanner checks are stale: " + ASC_Layer1OperatorSummaryReason(summary);
   else if(summary.warmup_ready)
      summary.posture_note = "Market coverage is still building.";
  }


int ASC_Layer1SecondOfDay(const datetime value)
  {
   if(value < 0)
      return -1;

   MqlDateTime parts;
   TimeToStruct(value, parts);
   int seconds = (parts.hour * 3600) + (parts.min * 60) + parts.sec;
   if(seconds < 0)
      seconds = 0;
   if(seconds > 86399)
      seconds = 86399;
   return seconds;
  }

string ASC_Layer1SessionClockText(const int seconds)
  {
   if(seconds < 0)
      return "unavailable";
   int safe_seconds = seconds;
   if(safe_seconds > 86399)
      safe_seconds = 86399;
   int hour = safe_seconds / 3600;
   int minute = (safe_seconds % 3600) / 60;
   return StringFormat("%02d:%02d", hour, minute);
  }

bool ASC_Layer1SecondWithinSession(const int now_seconds,
                                   const int from_seconds,
                                   const int to_seconds)
  {
   if(now_seconds < 0 || from_seconds < 0 || to_seconds < 0)
      return true;

   if(from_seconds == 0 && to_seconds == 0)
      return true;

   if(to_seconds == from_seconds)
      return true;

   if(to_seconds > from_seconds)
      return (now_seconds >= from_seconds && now_seconds <= to_seconds);

   return (now_seconds >= from_seconds || now_seconds <= to_seconds);
  }

bool ASC_Layer1TradeSessionActiveNow(const string symbol,
                                     const datetime server_now,
                                     bool &session_known,
                                     string &session_detail)
  {
   session_known = false;
   session_detail = "trade_session_unavailable";

   if(StringLen(symbol) <= 0 || server_now <= 0)
      return true;

   MqlDateTime now_parts;
   TimeToStruct(server_now, now_parts);
   ENUM_DAY_OF_WEEK dow = (ENUM_DAY_OF_WEEK)now_parts.day_of_week;
   int now_seconds = (now_parts.hour * 3600) + (now_parts.min * 60) + now_parts.sec;

   for(uint session_index = 0; session_index < 24; session_index++)
     {
      datetime from_time = 0;
      datetime to_time = 0;
      if(!SymbolInfoSessionTrade(symbol, dow, session_index, from_time, to_time))
         continue;

      session_known = true;
      int from_seconds = ASC_Layer1SecondOfDay(from_time);
      int to_seconds = ASC_Layer1SecondOfDay(to_time);
      string window_text = ASC_Layer1SessionClockText(from_seconds) + "-" + ASC_Layer1SessionClockText(to_seconds);

      if(ASC_Layer1SecondWithinSession(now_seconds, from_seconds, to_seconds))
        {
         session_detail = "trade_session_active " + window_text;
         return true;
        }

      if(session_detail == "trade_session_unavailable")
         session_detail = "trade_session_inactive " + window_text;
      else
         session_detail += "," + window_text;
     }

   if(!session_known)
     {
      session_detail = "trade_session_unavailable";
      return true;
     }

   return false;
  }


ASC_Layer1SymbolState ASC_Layer1EvaluateSymbol(const string symbol,
                                               const datetime now_utc,
                                               const ASC_Layer1SymbolState &previous_state,
                                               const bool force_reclassification,
                                               int &retry_selected,
                                               int &retry_exhausted)
  {
   ASC_Layer1SymbolState state;
   state.symbol = symbol;

   bool reuse_identity = (previous_state.symbol == symbol && StringLen(previous_state.symbol) > 0);
   bool reuse_classification = (reuse_identity
                                && !force_reclassification
                                && ASC_Layer1ClassificationCanReuse(previous_state.classification));
   if(reuse_identity)
     {
      state.identity = previous_state.identity;
      state.classification_recovery_pending = previous_state.classification_recovery_pending;
      if(reuse_classification)
         state.classification = previous_state.classification;
      else
        {
         state.identity = ASC_NormalizeSymbol(symbol);
         ASC_LookupClassification(ASC_Layer1AccountServer(), state.identity, state.classification);
        }
     }
   else
     {
      state.identity = ASC_NormalizeSymbol(symbol);
      ASC_LookupClassification(ASC_Layer1AccountServer(), state.identity, state.classification);
      state.classification_recovery_pending = previous_state.classification_recovery_pending;
     }
   ASC_Layer1AttachIdentityClassificationPacket(state);
   state.classification_recovery_pending = false;
   state.observed_at_utc = now_utc;
   state.next_due_utc = 0;
   state.next_due_reason = "scan-required";
   state.confirmation_retries = previous_state.confirmation_retries;
   state.is_stale = false;
   state.is_degraded = false;
   state.due_class = ASC_L1_DUE_UNKNOWN;

   long trade_mode = 0;
   bool has_trade_mode = SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE, trade_mode);
   MqlTick tick;
   bool has_tick = SymbolInfoTick(symbol, tick);

   bool continuity_open = (previous_state.state == ASC_L1_OPEN || previous_state.state == ASC_L1_CLOSED);
   datetime server_now = TimeCurrent();
   if(server_now <= 0)
      server_now = now_utc;
   bool trade_session_known = false;
   string trade_session_detail = "trade_session_unavailable";
   bool trade_session_active = ASC_Layer1TradeSessionActiveNow(symbol,
                                                               server_now,
                                                               trade_session_known,
                                                               trade_session_detail);

   if(!has_trade_mode)
     {
      state.state = ASC_L1_UNKNOWN;
      state.reason = "Market state unavailable";
      state.confirmation_retries = 0;
      state.confidence = "low";
      state.is_stale = true;
      state.is_degraded = true;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   if(trade_mode == SYMBOL_TRADE_MODE_DISABLED || trade_mode == SYMBOL_TRADE_MODE_CLOSEONLY)
     {
      state.state = ASC_L1_CLOSED;
      state.reason = "Session appears closed";
      state.confirmation_retries = 0;
      state.confidence = "high";
      state.is_stale = false;
      state.is_degraded = false;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   if(trade_session_known && !trade_session_active)
     {
      state.state = ASC_L1_CLOSED;
      state.reason = "Session appears closed (" + trade_session_detail + ")";
      state.confirmation_retries = 0;
      state.confidence = "high";
      state.is_stale = false;
      state.is_degraded = false;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   datetime quote_time = 0;
   long quote_time_raw = 0;
   if(SymbolInfoInteger(symbol, SYMBOL_TIME, quote_time_raw))
      quote_time = (datetime)quote_time_raw;

   if(!has_tick)
     {
      bool prior_closed = (previous_state.state == ASC_L1_CLOSED);
      bool dormant_quote = (quote_time > 0 && (now_utc - quote_time) >= g_asc_trader_controls.l1_tick_freshness_sec);

      if(prior_closed && dormant_quote)
        {
         state.state = ASC_L1_CLOSED;
         state.reason = StringFormat("Closed continuity retained (last quote %d sec ago)", (int)(now_utc - quote_time));
         state.confirmation_retries = 0;
         state.confidence = "medium";
         state.is_stale = false;
         state.is_degraded = false;
         ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
         return state;
        }

      state.state = continuity_open ? ASC_L1_UNCERTAIN : ASC_L1_UNKNOWN;
      state.reason = continuity_open ? "Awaiting confirmation (no current tick)" : "Awaiting first tick";
      state.confirmation_retries = continuity_open ? previous_state.confirmation_retries + 1 : 0;
      if(state.state == ASC_L1_UNCERTAIN)
        {
         retry_selected++;
         if(state.confirmation_retries > g_asc_trader_controls.l1_confirmation_retry_cap)
           {
            state.confirmation_retries = g_asc_trader_controls.l1_confirmation_retry_cap;
            retry_exhausted++;
            state.is_degraded = true;
           }
        }
      state.confidence = continuity_open ? "medium" : "low";
      state.is_stale = true;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   int age = (int)(server_now - tick.time);
   if(age < 0)
     {
      int future_age = -age;
      state.state = ASC_L1_UNCERTAIN;
      state.reason = StringFormat("Awaiting confirmation (tick time ahead of server clock by %d sec)", future_age);
      state.confirmation_retries = previous_state.confirmation_retries + 1;
      retry_selected++;
      state.confidence = "low";
      state.is_stale = true;
      state.is_degraded = true;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   if(age <= g_asc_trader_controls.l1_tick_freshness_sec)
     {
      state.state = ASC_L1_OPEN;
      state.reason = StringFormat("Open confirmed from recent tick (%d sec)", age);
      state.confirmation_retries = 0;
      state.confidence = "high";
      state.is_stale = false;
      state.is_degraded = false;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   bool prior_closed = (previous_state.state == ASC_L1_CLOSED);
   bool strongly_dormant = (age >= (g_asc_trader_controls.l1_stale_age_sec * 2));
   if(prior_closed && age >= g_asc_trader_controls.l1_tick_freshness_sec)
     {
      state.state = ASC_L1_CLOSED;
      state.reason = StringFormat("Closed continuity retained (tick age %d sec)", age);
      state.confirmation_retries = 0;
      state.confidence = "medium";
      state.is_stale = false;
      state.is_degraded = false;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   state.state = ASC_L1_UNCERTAIN;
   state.reason = StringFormat("Awaiting confirmation (tick age %d sec)", age);
   state.confirmation_retries = previous_state.confirmation_retries + 1;
   retry_selected++;
   if(state.confirmation_retries > g_asc_trader_controls.l1_confirmation_retry_cap)
     {
      state.confirmation_retries = g_asc_trader_controls.l1_confirmation_retry_cap;
      retry_exhausted++;
      state.is_degraded = !strongly_dormant;
     }

   if(strongly_dormant && previous_state.state != ASC_L1_OPEN && state.confirmation_retries >= g_asc_trader_controls.l1_confirmation_retry_cap)
     {
      state.state = ASC_L1_CLOSED;
      state.reason = StringFormat("Dormant market posture inferred (tick age %d sec)", age);
      state.confirmation_retries = 0;
      state.confidence = "medium";
      state.is_stale = false;
      state.is_degraded = false;
      ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
      return state;
     }

   state.confidence = (state.confirmation_retries >= g_asc_trader_controls.l1_confirmation_retry_cap) ? "low" : "medium";
   state.is_stale = (age >= g_asc_trader_controls.l1_stale_age_sec);
   ASC_Layer1FinalizeMarketStatePacket(state, now_utc);
   return state;
  }

bool ASC_Layer1IsDueForScan(const ASC_Layer1SymbolState &state,const datetime now_utc)
  {
   if(StringLen(state.symbol) <= 0)
      return true;

   if(state.next_due_utc <= 0)
      return true;

   return (state.next_due_utc <= now_utc);
  }

int ASC_Layer1CountDueSymbols(const datetime now_utc)
  {
   int total = ArraySize(g_asc_l1_cache);
   int due = 0;
   for(int i = 0; i < total; i++)
     {
      if(ASC_Layer1IsDueForScan(g_asc_l1_cache[i], now_utc))
         due++;
     }
   return due;
  }

datetime ASC_Layer1FindNextDueUtc()
  {
   datetime next_due = 0;
   int total = ArraySize(g_asc_l1_cache);
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState state = g_asc_l1_cache[i];
      if(StringLen(state.symbol) <= 0 || state.next_due_utc <= 0)
         return 0;

      if(next_due == 0 || state.next_due_utc < next_due)
         next_due = state.next_due_utc;
     }
   return next_due;
  }

void ASC_Layer1DueAndNextDueAccounting(const datetime now_utc,
                                       int &due_count,
                                       datetime &next_due_utc,
                                       string &next_due_reason,
                                       int &next_due_count)
  {
   due_count = 0;
   next_due_utc = 0;
   next_due_reason = "awaiting-first-check";
   next_due_count = 0;

   bool next_due_indeterminate = false;
   int total = ArraySize(g_asc_l1_cache);
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState state = g_asc_l1_cache[i];
      bool due_now = ASC_Layer1IsDueForScan(state, now_utc);
      if(due_now)
         due_count++;

      if(StringLen(state.symbol) <= 0 || state.next_due_utc <= 0)
        {
         next_due_indeterminate = true;
         continue;
        }

      if(next_due_utc == 0 || state.next_due_utc < next_due_utc)
        {
         next_due_utc = state.next_due_utc;
         next_due_reason = state.next_due_reason;
         next_due_count = 1;
        }
      else if(state.next_due_utc == next_due_utc)
         next_due_count++;
     }

   if(next_due_indeterminate)
     {
      next_due_utc = 0;
      next_due_reason = "awaiting-first-check";
      next_due_count = 0;
     }
   else if(next_due_utc <= 0)
     {
      next_due_reason = "scheduled-recheck";
      next_due_count = 0;
     }
  }


string ASC_Layer1ResolverLifecycleDetail(const datetime now_utc,
                                        const bool bootstrap_active,
                                        const int due_selected,
                                        const int retry_selected,
                                        const int retry_exhausted,
                                        const int remaining_due,
                                        const datetime next_due_utc,
                                        const string next_due_reason,
                                        const int next_due_count)
  {
   int warmup_pending = 0;
   int retry_pending = 0;
   int session_closed_sleep = 0;
   int tick_missing = 0;
   int tick_stale = 0;
   int session_unknown = 0;
   int stale_or_degraded = 0;
   int persistent_unavailable = 0;

   for(int i = 0; i < ArraySize(g_asc_l1_cache); i++)
     {
      ASC_Layer1SymbolState state = g_asc_l1_cache[i];
      if(StringLen(state.symbol) <= 0)
         continue;

      string reason = state.reason;
      if(bootstrap_active && (state.state == ASC_L1_UNKNOWN || state.state == ASC_L1_UNCERTAIN || state.is_stale || state.is_degraded))
         warmup_pending++;
      if(state.state == ASC_L1_UNCERTAIN)
         retry_pending++;
      if(state.state == ASC_L1_CLOSED)
         session_closed_sleep++;
      if(state.state == ASC_L1_UNKNOWN)
         session_unknown++;
      if(StringFind(reason, "no current tick") >= 0 || StringFind(reason, "first tick") >= 0)
         tick_missing++;
      if(StringFind(reason, "tick age") >= 0 || state.is_stale)
         tick_stale++;
      if(state.is_stale || state.is_degraded)
         stale_or_degraded++;
      if(state.is_degraded && state.confirmation_retries >= g_asc_trader_controls.l1_confirmation_retry_cap)
         persistent_unavailable++;
     }

   string resolver_status = "not_due";
   if(due_selected > 0)
      resolver_status = "attempted";
   else if(remaining_due > 0)
      resolver_status = "due";
   else if(retry_pending > 0)
      resolver_status = "still_pending";

   string unavailable_state = "no_gap_found";
   if(bootstrap_active && warmup_pending > 0)
      unavailable_state = "warmup_pending";
   else if(retry_pending > 0)
      unavailable_state = "retry_pending";
   else if(persistent_unavailable > 0)
      unavailable_state = "persistent_unavailable";
   else if(tick_missing > 0)
      unavailable_state = "tick_missing";
   else if(tick_stale > 0)
      unavailable_state = "tick_stale";
   else if(session_unknown > 0)
      unavailable_state = "session_unknown";
   else if(session_closed_sleep > 0)
      unavailable_state = "session_closed_sleep";

   string downstream_authority = (persistent_unavailable > 0 || retry_exhausted > 0) ? "degraded" : ((retry_pending > 0 || stale_or_degraded > 0 || warmup_pending > 0) ? "pending" : "clean");
   string artifact_projection = (downstream_authority == "clean") ? "allowed" : "qualified";

   return StringFormat("resolver_domain=market_state | unavailable_state=%s | resolver_owner=l1_market_state | resolver_status=%s | retry_due_utc=%s | last_attempt_utc=%s | attempt_count=%d | expiry_policy=%s | downstream_authority=%s | artifact_projection=%s | warmup_pending=%d | retry_pending=%d | session_closed_sleep=%d | tick_missing=%d | tick_stale=%d | session_unknown=%d | persistent_unavailable=%d | next_due_reason=%s | next_due_count=%d | behavior_change=no",
                       unavailable_state,
                       resolver_status,
                       ASC_FormatUtc(next_due_utc),
                       ASC_FormatUtc(now_utc),
                       retry_selected,
                       bootstrap_active ? "warmup_only" : "cadence_retry",
                       downstream_authority,
                       artifact_projection,
                       warmup_pending,
                       retry_pending,
                       session_closed_sleep,
                       tick_missing,
                       tick_stale,
                       session_unknown,
                       persistent_unavailable,
                       next_due_reason,
                       next_due_count);
  }

void ASC_Layer1ScanSlice(const datetime now_utc,
                         const int cursor,
                         const int symbol_budget,
                         const bool bootstrap_active,
                         int &next_cursor,
                         int &slice_count,
                         int &remaining,
                         bool &cycle_complete,
                         int &due_selected,
                         int &retry_selected,
                         int &retry_exhausted,
                         datetime &next_due_utc,
                         ASC_FunctionResult &scan_result)
  {
   int total = SymbolsTotal(true);
   if(total < 0)
      total = 0;

   if(ArraySize(g_asc_l1_cache) != total)
      ASC_Layer1ResetCache(total);
   if(g_asc_l1_classification_recovery_sweep_armed)
      ASC_Layer1PrepareClassificationRecoverySweep(now_utc);

   int local_budget = symbol_budget;
   if(local_budget <= 0)
      local_budget = 1;

   int local_cursor = cursor;
   if(local_cursor < 0)
      local_cursor = 0;
   if(total > 0 && local_cursor >= total)
      local_cursor = local_cursor % total;
   if(total <= 0)
      local_cursor = 0;

   slice_count = 0;
   due_selected = 0;
   retry_selected = 0;
   retry_exhausted = 0;
   int uncertain_selected = 0;
   int closed_selected = 0;
   int traversed = 0;
   int probe = local_cursor;
   while(total > 0 && traversed < total && slice_count < local_budget)
     {
      ASC_Layer1SymbolState cached = g_asc_l1_cache[probe];
      string symbol = cached.symbol;
      if(StringLen(symbol) <= 0)
        {
         symbol = SymbolName(probe, true);
         cached.symbol = symbol;
         if(StringLen(symbol) > 0)
            g_asc_l1_cache[probe].symbol = symbol;
        }

      if(ASC_Layer1IsDueForScan(cached, now_utc))
        {
         int uncertain_cap = bootstrap_active ? MathMax(1, local_budget / 8) : MathMax(1, local_budget / 4);
         int closed_cap = bootstrap_active ? MathMax(1, local_budget / 10) : MathMax(1, local_budget / 6);
         if(cached.state == ASC_L1_UNCERTAIN && uncertain_selected >= uncertain_cap)
           {
            probe++;
            if(probe >= total)
               probe = 0;
            traversed++;
            continue;
           }
         if(cached.state == ASC_L1_CLOSED && closed_selected >= closed_cap)
           {
            probe++;
            if(probe >= total)
               probe = 0;
            traversed++;
            continue;
           }

         if(StringLen(symbol) <= 0)
           {
            if(g_asc_l1_classification_recovery_sweep_active && cached.classification_recovery_pending)
              {
               ASC_Layer1SymbolState skipped = cached;
               skipped.classification_recovery_pending = false;
               skipped.observed_at_utc = now_utc;
               ASC_Layer1ApplyClassificationRecoveryResult(cached, skipped);
               g_asc_l1_cache[probe] = skipped;
              }
            probe++;
            if(probe >= total)
               probe = 0;
            traversed++;
            continue;
           }

         bool force_reclassification = (g_asc_l1_classification_recovery_sweep_active && cached.classification_recovery_pending);
         ASC_Layer1SymbolState evaluated = ASC_Layer1EvaluateSymbol(symbol,
                                                                    now_utc,
                                                                    cached,
                                                                    force_reclassification,
                                                                    retry_selected,
                                                                    retry_exhausted);
         ASC_Layer1ApplyClassificationRecoveryResult(cached, evaluated);
         if(ASC_Layer1MaterialStateChanged(cached, evaluated))
            g_asc_l1_structural_revision++;
         g_asc_l1_cache[probe] = evaluated;
         slice_count++;
         due_selected++;
         if(evaluated.state == ASC_L1_UNCERTAIN)
            uncertain_selected++;
         if(evaluated.state == ASC_L1_CLOSED)
            closed_selected++;
        }

      probe++;
      if(probe >= total)
         probe = 0;
      traversed++;
     }

   next_cursor = probe;
   string next_due_reason = "awaiting-first-check";
   int next_due_count = 0;
   ASC_Layer1DueAndNextDueAccounting(now_utc,
                                     remaining,
                                     next_due_utc,
                                     next_due_reason,
                                     next_due_count);
   cycle_complete = (total <= 0 || remaining == 0);

   string detail = StringFormat("slice_scanned=%d due_selected=%d retry_selected=%d retry_exhausted=%d uncertain_selected=%d closed_selected=%d bootstrap=%s cursor_in=%d cursor_out=%d total=%d due_remaining=%d next_due_count=%d next_due_reason=%s cycle_complete=%s",
                                slice_count,
                                due_selected,
                                retry_selected,
                                retry_exhausted,
                                uncertain_selected,
                                closed_selected,
                                bootstrap_active ? "yes" : "no",
                                cursor,
                                next_cursor,
                                total,
                                remaining,
                                next_due_count,
                                next_due_reason,
                                ASC_BoolToYesNo(cycle_complete));
   detail += " classification_recovery={" + ASC_Layer1ClassificationRecoveryCompact() + "}";
   detail += " | " + ASC_Layer1ResolverLifecycleDetail(now_utc,
                                                       bootstrap_active,
                                                       due_selected,
                                                       retry_selected,
                                                       retry_exhausted,
                                                       remaining,
                                                       next_due_utc,
                                                       next_due_reason,
                                                       next_due_count);

   ASC_FunctionResultFinish(scan_result,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            detail,
                            "runtime:market_state");
  }

bool ASC_Layer1TryGetLatestSummary(ASC_Layer1PassSummary &summary)
  {
   if(!g_asc_l1_has_summary)
      return false;

   summary = g_asc_l1_latest_summary;
   return true;
  }

int ASC_Layer1CachedSymbolCount()
  {
   return ArraySize(g_asc_l1_cache);
  }

ulong ASC_Layer1StructuralRevision()
  {
   return g_asc_l1_structural_revision;
  }

bool ASC_Layer1GetCachedSymbol(const int index,ASC_Layer1SymbolState &state)
  {
   if(index < 0 || index >= ArraySize(g_asc_l1_cache))
      return false;

   state = g_asc_l1_cache[index];
   return true;
  }

#endif
