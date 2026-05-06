#ifndef __ASC_SERVER_PATHS_MQH__
#define __ASC_SERVER_PATHS_MQH__

#include "../core/ASC_Constants.mqh"

string ASC_ServerRootPath()
  {
   string server = AccountInfoString(ACCOUNT_SERVER);
   if(StringLen(server) <= 0)
      server = "UnknownServer";
   return ASC_RUNTIME_ROOT_FOLDER + "\\" + server;
  }

#endif
