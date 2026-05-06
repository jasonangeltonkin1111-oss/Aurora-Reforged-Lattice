#ifndef __ASC_WORKBENCH_PATHS_MQH__
#define __ASC_WORKBENCH_PATHS_MQH__

#include "../core/ASC_Constants.mqh"

string ASC_WorkbenchRoot(const string server_root)
  {
   return server_root + "\\" + ASC_WORKBENCH_FOLDER;
  }

string ASC_WorkbenchTemp(const string server_root)
  {
   return ASC_WorkbenchRoot(server_root) + "\\" + ASC_TEMP_FOLDER;
  }

string ASC_WorkbenchFailed(const string server_root)
  {
   return ASC_WorkbenchRoot(server_root) + "\\" + ASC_FAILED_FOLDER;
  }

string ASC_WorkbenchLogs(const string server_root)
  {
   return ASC_WorkbenchRoot(server_root) + "\\" + ASC_LOGS_FOLDER;
  }

#endif
