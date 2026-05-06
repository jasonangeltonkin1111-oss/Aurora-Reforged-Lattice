#ifndef __ASC_DIRECTORY_SETUP_MQH__
#define __ASC_DIRECTORY_SETUP_MQH__

#include "../io/ASC_FileIO.mqh"
#include "../io/ASC_WorkbenchPaths.mqh"
#include "../core/ASC_Constants.mqh"

bool ASC_PrepareRuntimeFolders(const string server_root)
  {
   bool root_ok = ASC_EnsureDirectory(server_root);
   bool dossiers_ok = ASC_EnsureDirectory(server_root + "\\" + ASC_DOSSIER_FOLDER);
   bool workbench_ok = ASC_EnsureDirectory(ASC_WorkbenchRoot(server_root));
   bool temp_ok = ASC_EnsureDirectory(ASC_WorkbenchTemp(server_root));
   bool failed_ok = ASC_EnsureDirectory(ASC_WorkbenchFailed(server_root));
   bool logs_ok = ASC_EnsureDirectory(ASC_WorkbenchLogs(server_root));

   return (root_ok && dossiers_ok && workbench_ok && temp_ok && failed_ok && logs_ok);
  }

#endif
