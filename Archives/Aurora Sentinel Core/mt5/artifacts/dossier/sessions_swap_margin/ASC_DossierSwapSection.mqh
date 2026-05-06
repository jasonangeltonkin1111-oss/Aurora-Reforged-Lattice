#ifndef __ASC_DOSSIERSWAPSECTION_MQH__
#define __ASC_DOSSIERSWAPSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierSwapSection(const string swap_type,
                                   const string swap_long,
                                   const string swap_short,
                                   const string swap_monday,
                                   const string swap_tuesday,
                                   const string swap_wednesday,
                                   const string swap_thursday,
                                   const string swap_friday,
                                   const string swap_notes,
                                   const bool swap_values_available,
                                   const bool swap_schedule_available,
                                   ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 9);
   values[0] = swap_type;
   values[1] = swap_long;
   values[2] = swap_short;
   values[3] = swap_monday;
   values[4] = swap_tuesday;
   values[5] = swap_wednesday;
   values[6] = swap_thursday;
   values[7] = swap_friday;
   values[8] = swap_notes;

   status_out.section_name = "swap";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 9 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !swap_values_available || !swap_schedule_available)
      status_out.posture = "fallback";
   if(!swap_values_available && !swap_schedule_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("swap_values_available=%s swap_schedule_available=%s",
                                  swap_values_available ? "yes" : "no",
                                  swap_schedule_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Swap\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Swap Type: %s\n", swap_type);
   section += StringFormat("Swap Long: %s\n", swap_long);
   section += StringFormat("Swap Short: %s\n", swap_short);
   section += StringFormat("Swap Monday: %s\n", swap_monday);
   section += StringFormat("Swap Tuesday: %s\n", swap_tuesday);
   section += StringFormat("Swap Wednesday: %s\n", swap_wednesday);
   section += StringFormat("Swap Thursday: %s\n", swap_thursday);
   section += StringFormat("Swap Friday: %s\n", swap_friday);
   section += StringFormat("Swap Notes: %s\n", swap_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
