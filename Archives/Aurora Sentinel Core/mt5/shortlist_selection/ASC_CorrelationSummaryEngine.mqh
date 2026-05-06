#ifndef __ASC_CORRELATION_SUMMARY_ENGINE_MQH__
#define __ASC_CORRELATION_SUMMARY_ENGINE_MQH__

#include "ASC_ATRSummaryEngine.mqh"

struct ASC_TrueCorrelationCacheEntry
  {
   string pair_key;
   datetime computed_utc;
   bool ready;
   double score;
   int samples;
   string reason;
  };

ASC_TrueCorrelationCacheEntry g_asc_true_correlation_cache[];
const ENUM_TIMEFRAMES ASC_TRUE_CORRELATION_TIMEFRAME = PERIOD_H1;
const int ASC_TRUE_CORRELATION_LOOKBACK_BARS = 72;
const int ASC_TRUE_CORRELATION_MIN_SAMPLES = 24;
const int ASC_TRUE_CORRELATION_CACHE_SECONDS = 300;
const bool ASC_TRUE_CORRELATION_HOT_PATH_ENABLED = true;

string ASC_CorrelationNormalizeSymbol(const string value_raw)
  {
   string value = value_raw;
   StringToUpper(value);
   int dot = StringFind(value, ".");
   if(dot > 0)
      value = StringSubstr(value, 0, dot);
   StringReplace(value, "_", "");
   StringReplace(value, "-", "");
   StringReplace(value, "/", "");
   return value;
  }

string ASC_TrueCorrelationPairKey(const string left_symbol,const string right_symbol)
  {
   string left = ASC_CorrelationNormalizeSymbol(left_symbol);
   string right = ASC_CorrelationNormalizeSymbol(right_symbol);
   if(left <= right)
      return left + "|" + right;
   return right + "|" + left;
  }

int ASC_TrueCorrelationCacheFind(const string pair_key)
  {
   for(int i = 0; i < ArraySize(g_asc_true_correlation_cache); i++)
     {
      if(g_asc_true_correlation_cache[i].pair_key == pair_key)
         return i;
     }
   return -1;
  }

bool ASC_TrueCorrelationBuildClosedReturns(const string symbol,
                                           datetime &times_out[],
                                           double &returns_out[],
                                           int &bars_copied_out,
                                           string &reason_out)
  {
   ArrayResize(times_out, 0);
   ArrayResize(returns_out, 0);
   bars_copied_out = 0;

   if(!ASC_TRUE_CORRELATION_HOT_PATH_ENABLED)
     {
      reason_out = "true correlation is disabled in the ordinary Layer-4 hot path";
      return false;
     }

   if(StringLen(symbol) <= 0)
     {
      reason_out = "symbol is unavailable";
      return false;
     }

   MqlRates rates[];
   ArraySetAsSeries(rates, true);

   int requested = ASC_TRUE_CORRELATION_LOOKBACK_BARS + 2;
   int copied = CopyRates(symbol, ASC_TRUE_CORRELATION_TIMEFRAME, 1, requested, rates);
   if(copied < (ASC_TRUE_CORRELATION_MIN_SAMPLES + 1))
     {
      reason_out = StringFormat("insufficient closed bars on %s (%d)", EnumToString(ASC_TRUE_CORRELATION_TIMEFRAME), copied);
      return false;
     }

   for(int i = copied - 1; i >= 1; i--)
     {
      double prev_close = rates[i].close;
      double curr_close = rates[i - 1].close;
      if(prev_close <= 0.0 || curr_close <= 0.0)
         continue;

      int next = ArraySize(returns_out);
      ArrayResize(returns_out, next + 1);
      ArrayResize(times_out, next + 1);
      times_out[next] = rates[i - 1].time;
      returns_out[next] = (curr_close - prev_close) / prev_close;
     }

   bars_copied_out = ArraySize(returns_out);
   if(bars_copied_out < ASC_TRUE_CORRELATION_MIN_SAMPLES)
     {
      reason_out = StringFormat("insufficient aligned closed returns on %s (%d)", EnumToString(ASC_TRUE_CORRELATION_TIMEFRAME), bars_copied_out);
      ArrayResize(times_out, 0);
      ArrayResize(returns_out, 0);
      bars_copied_out = 0;
      return false;
     }

   reason_out = StringFormat("aligned closed returns ready on %s (%d)", EnumToString(ASC_TRUE_CORRELATION_TIMEFRAME), bars_copied_out);
   return true;
  }

double ASC_TrueCorrelationPearsonScore(const double &left_returns[],
                                       const double &right_returns[],
                                       const int sample_count,
                                       bool &valid_out)
  {
   valid_out = false;
   if(sample_count < ASC_TRUE_CORRELATION_MIN_SAMPLES)
      return 0.0;

   double left_sum = 0.0;
   double right_sum = 0.0;
   for(int i = 0; i < sample_count; i++)
     {
      left_sum += left_returns[i];
      right_sum += right_returns[i];
     }

   double left_mean = left_sum / sample_count;
   double right_mean = right_sum / sample_count;
   double numerator = 0.0;
   double left_var = 0.0;
   double right_var = 0.0;
   for(int i = 0; i < sample_count; i++)
     {
      double left_delta = left_returns[i] - left_mean;
      double right_delta = right_returns[i] - right_mean;
      numerator += (left_delta * right_delta);
      left_var += (left_delta * left_delta);
      right_var += (right_delta * right_delta);
     }

   if(left_var <= 0.0 || right_var <= 0.0)
      return 0.0;

   double denominator = MathSqrt(left_var * right_var);
   if(denominator <= 0.0)
      return 0.0;

   valid_out = true;
   double raw_score = numerator / denominator;
   raw_score = MathMax(-1.0, MathMin(1.0, raw_score));
   return MathAbs(raw_score);
  }

bool ASC_TrySummaryTrueCorrelationScore(const string anchor_symbol,
                                        const string peer_symbol,
                                        double &score_out,
                                        int &samples_out,
                                        string &reason_out)
  {
   score_out = 0.0;
   samples_out = 0;
   reason_out = "true correlation is not computed in the ordinary Layer-4 hot path";

   if(StringLen(anchor_symbol) <= 0 || StringLen(peer_symbol) <= 0)
     {
      reason_out = "anchor or peer symbol is unavailable";
      return false;
     }

   string pair_key = ASC_TrueCorrelationPairKey(anchor_symbol, peer_symbol);
   int cache_index = ASC_TrueCorrelationCacheFind(pair_key);
   if(cache_index < 0)
     {
      cache_index = ArraySize(g_asc_true_correlation_cache);
      ArrayResize(g_asc_true_correlation_cache, cache_index + 1);
      g_asc_true_correlation_cache[cache_index].pair_key = pair_key;
      g_asc_true_correlation_cache[cache_index].computed_utc = 0;
      g_asc_true_correlation_cache[cache_index].ready = false;
      g_asc_true_correlation_cache[cache_index].score = 0.0;
      g_asc_true_correlation_cache[cache_index].samples = 0;
      g_asc_true_correlation_cache[cache_index].reason = "awaiting first computation";
     }

   datetime now_utc = TimeGMT();
   if(g_asc_true_correlation_cache[cache_index].ready
      && g_asc_true_correlation_cache[cache_index].computed_utc > 0
      && (now_utc - g_asc_true_correlation_cache[cache_index].computed_utc) <= ASC_TRUE_CORRELATION_CACHE_SECONDS)
     {
      score_out = g_asc_true_correlation_cache[cache_index].score;
      samples_out = g_asc_true_correlation_cache[cache_index].samples;
      reason_out = g_asc_true_correlation_cache[cache_index].reason;
      return true;
     }

   datetime anchor_times[];
   datetime peer_times[];
   double anchor_returns[];
   double peer_returns[];
   int anchor_count = 0;
   int peer_count = 0;
   string anchor_reason = "";
   string peer_reason = "";

   if(!ASC_TrueCorrelationBuildClosedReturns(anchor_symbol, anchor_times, anchor_returns, anchor_count, anchor_reason))
     {
      g_asc_true_correlation_cache[cache_index].computed_utc = now_utc;
      g_asc_true_correlation_cache[cache_index].ready = false;
      g_asc_true_correlation_cache[cache_index].score = 0.0;
      g_asc_true_correlation_cache[cache_index].samples = 0;
      g_asc_true_correlation_cache[cache_index].reason = anchor_reason;
      reason_out = anchor_reason;
      return false;
     }

   if(!ASC_TrueCorrelationBuildClosedReturns(peer_symbol, peer_times, peer_returns, peer_count, peer_reason))
     {
      g_asc_true_correlation_cache[cache_index].computed_utc = now_utc;
      g_asc_true_correlation_cache[cache_index].ready = false;
      g_asc_true_correlation_cache[cache_index].score = 0.0;
      g_asc_true_correlation_cache[cache_index].samples = 0;
      g_asc_true_correlation_cache[cache_index].reason = peer_reason;
      reason_out = peer_reason;
      return false;
     }

   double aligned_left[];
   double aligned_right[];
   ArrayResize(aligned_left, 0);
   ArrayResize(aligned_right, 0);

   int left_index = 0;
   int right_index = 0;
   while(left_index < ArraySize(anchor_times) && right_index < ArraySize(peer_times))
     {
      if(anchor_times[left_index] == peer_times[right_index])
        {
         int next = ArraySize(aligned_left);
         ArrayResize(aligned_left, next + 1);
         ArrayResize(aligned_right, next + 1);
         aligned_left[next] = anchor_returns[left_index];
         aligned_right[next] = peer_returns[right_index];
         left_index++;
         right_index++;
         continue;
        }

      if(anchor_times[left_index] < peer_times[right_index])
        {
         left_index++;
         continue;
        }

      right_index++;
     }

   samples_out = ArraySize(aligned_left);
   bool valid_score = false;
   score_out = ASC_TrueCorrelationPearsonScore(aligned_left, aligned_right, samples_out, valid_score);
   if(!valid_score)
     {
      reason_out = StringFormat("insufficient aligned pair samples on %s (%d)", EnumToString(ASC_TRUE_CORRELATION_TIMEFRAME), samples_out);
      g_asc_true_correlation_cache[cache_index].computed_utc = now_utc;
      g_asc_true_correlation_cache[cache_index].ready = false;
      g_asc_true_correlation_cache[cache_index].score = 0.0;
      g_asc_true_correlation_cache[cache_index].samples = samples_out;
      g_asc_true_correlation_cache[cache_index].reason = reason_out;
      return false;
     }

   reason_out = StringFormat("abs Pearson aligned closed-return correlation on %s (%d samples)", EnumToString(ASC_TRUE_CORRELATION_TIMEFRAME), samples_out);
   g_asc_true_correlation_cache[cache_index].computed_utc = now_utc;
   g_asc_true_correlation_cache[cache_index].ready = true;
   g_asc_true_correlation_cache[cache_index].score = score_out;
   g_asc_true_correlation_cache[cache_index].samples = samples_out;
   g_asc_true_correlation_cache[cache_index].reason = reason_out;
   return true;
  }

#endif
