#ifndef __ASC_DOSSIER_TIMEFRAME_PRESSURE_SECTION_MQH__
#define __ASC_DOSSIER_TIMEFRAME_PRESSURE_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierTimeframePressureSection(const string context_timeframe_role,
                                                const string bias_timeframe_role,
                                                const string trigger_timeframe_role,
                                                const string short_term_bias,
                                                const string mid_term_bias,
                                                const string higher_timeframe_bias,
                                                const string alignment,
                                                const string mtf_conflict_class,
                                                const string path_viability_posture,
                                                const string reversal_pressure_posture,
                                                const string allowed_style_hint,
                                                const string expansion_compression_carry,
                                                const string directional_pressure_summary,
                                                const bool owner_truth_available,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 13);
   values[0] = context_timeframe_role;
   values[1] = bias_timeframe_role;
   values[2] = trigger_timeframe_role;
   values[3] = short_term_bias;
   values[4] = mid_term_bias;
   values[5] = higher_timeframe_bias;
   values[6] = alignment;
   values[7] = mtf_conflict_class;
   values[8] = path_viability_posture;
   values[9] = reversal_pressure_posture;
   values[10] = allowed_style_hint;
   values[11] = expansion_compression_carry;
   values[12] = directional_pressure_summary;

   status_out.section_name = "semi_auto_timeframe_pressure";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 13 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = owner_truth_available ? "success" : "skipped";
   status_out.note = "consumer-only Layer-6 timeframe pressure map fed from the dormant packet chain";

   string section = "------------------------------------------------------------------------------\n";
   section += "Timeframe Pressure Map\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Context Timeframe Role: %s\n", context_timeframe_role);
   section += StringFormat("Bias Timeframe Role: %s\n", bias_timeframe_role);
   section += StringFormat("Trigger Timeframe Role: %s\n", trigger_timeframe_role);
   section += StringFormat("Short-Term Bias: %s\n", short_term_bias);
   section += StringFormat("Mid-Term Bias: %s\n", mid_term_bias);
   section += StringFormat("Higher-Timeframe Bias: %s\n", higher_timeframe_bias);
   section += StringFormat("Alignment: %s\n", alignment);
   section += StringFormat("MTF Conflict Class: %s\n", mtf_conflict_class);
   section += StringFormat("Path Viability Posture: %s\n", path_viability_posture);
   section += StringFormat("Reversal Pressure Posture: %s\n", reversal_pressure_posture);
   section += StringFormat("Allowed Style Hint: %s\n", allowed_style_hint);
   section += StringFormat("Expansion / Compression Carry: %s\n", expansion_compression_carry);
   section += StringFormat("Directional Pressure Summary: %s\n", directional_pressure_summary);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
