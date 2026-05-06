#ifndef __ASC_RUNTIME_CLOCK_MQH__
#define __ASC_RUNTIME_CLOCK_MQH__

datetime ASC_RuntimeUtcNow()
  {
   return TimeGMT();
  }

#endif
