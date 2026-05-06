#ifndef __ASC_SERVER_PATHS_MQH__
#define __ASC_SERVER_PATHS_MQH__

#include "ASC_Common.mqh"

bool ASC_PathExists(const string relative_path)
  {
   if(relative_path=="")
      return(false);
   return(FileIsExist(relative_path,FILE_COMMON));
  }

bool ASC_EnsureFolder(const string relative_path)
  {
   if(relative_path=="")
      return(false);

   if(FolderCreate(relative_path,FILE_COMMON))
      return(true);
   return(FileIsExist(relative_path,FILE_COMMON));
  }

bool ASC_ResolveServerPaths(ASC_ServerPaths &paths)
  {
   paths.server_raw=AccountInfoString(ACCOUNT_SERVER);
   paths.server_clean=ASC_CleanServerName(paths.server_raw);

   string namespaced_root="AuroraSentinel";
   string namespaced_server=ASC_JoinPath(namespaced_root,paths.server_clean);
   string legacy_server=paths.server_clean;

   string legacy_runtime=ASC_JoinPath(legacy_server,paths.server_clean + " Runtime State.txt");
   string legacy_scheduler=ASC_JoinPath(legacy_server,paths.server_clean + " Scheduler State.txt");
   string legacy_summary=ASC_JoinPath(legacy_server,paths.server_clean + " Summary Top 5 per Basket.txt");
   string legacy_dev=ASC_JoinPath(legacy_server,"Dev");
   string legacy_log=ASC_JoinPath(legacy_dev,paths.server_clean + " Foundation Log.txt");

   bool legacy_exists=(ASC_PathExists(legacy_server)
      || ASC_PathExists(legacy_runtime)
      || ASC_PathExists(legacy_scheduler)
      || ASC_PathExists(legacy_summary)
      || ASC_PathExists(legacy_dev)
      || ASC_PathExists(legacy_log));

   paths.using_legacy_layout=legacy_exists;
   paths.root_folder=(legacy_exists ? "" : namespaced_root);
   paths.server_folder=(legacy_exists ? legacy_server : namespaced_server);
   paths.layout_label=(legacy_exists ? "legacy-rootless" : "namespaced-root");
   paths.universe_folder=ASC_JoinPath(paths.server_folder,"Symbol Universe");
   paths.dev_folder=ASC_JoinPath(paths.server_folder,"Dev");
   paths.runtime_state_file=ASC_JoinPath(paths.server_folder,paths.server_clean + " Runtime State.txt");
   paths.scheduler_state_file=ASC_JoinPath(paths.server_folder,paths.server_clean + " Scheduler State.txt");
   paths.summary_file=ASC_JoinPath(paths.server_folder,paths.server_clean + " Summary Top 5 per Basket.txt");
   paths.log_file=ASC_JoinPath(paths.dev_folder,paths.server_clean + " Foundation Log.txt");
   paths.persistence_audit_file=ASC_JoinPath(paths.dev_folder,paths.server_clean + " Persistence Audit.txt");

   if(!legacy_exists)
     {
      if(!ASC_EnsureFolder(namespaced_root))
         return(false);
     }
   if(!ASC_EnsureFolder(paths.server_folder))
      return(false);
   if(!ASC_EnsureFolder(paths.universe_folder))
      return(false);
   if(!ASC_EnsureFolder(paths.dev_folder))
      return(false);
   return(true);
  }

#endif
