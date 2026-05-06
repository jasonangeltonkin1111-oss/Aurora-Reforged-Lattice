#ifndef ASC_PERSISTENCE_PATHS_MQH
#define ASC_PERSISTENCE_PATHS_MQH

#include "../config/ASC_Config_Defaults.mqh"

string ASC_PathSanitizeName(const string source_name)
  {
   string result = source_name;
   StringReplace(result, "\\", "-");
   StringReplace(result, "/", "-");
   StringReplace(result, ":", "-");
   StringReplace(result, "*", "-");
   StringReplace(result, "?", "-");
   StringReplace(result, "\"", "-");
   StringReplace(result, "<", "-");
   StringReplace(result, ">", "-");
   StringReplace(result, "|", "-");
   while(StringFind(result, "  ") >= 0)
      StringReplace(result, "  ", " ");
   StringTrimLeft(result);
   StringTrimRight(result);
   if(StringLen(result) == 0)
      result = "Unknown Server";
   return result;
  }

string ASC_PathServerRoot(const string server_name)
  {
   return ASC_PathSanitizeName(server_name);
  }

string ASC_PathSummaryFile(const string server_root)
  {
   return server_root + "/" + server_root + ".txt";
  }

string ASC_PathDossierFolder(const string server_root)
  {
   return server_root + "/" + ASC_PUBLICATION_DOSSIER_FOLDER;
  }

string ASC_PathDossierFile(const string server_root,
                           const string symbol_name)
  {
   string safe_symbol = ASC_PathSanitizeName(symbol_name);
   return ASC_PathDossierFolder(server_root) + "/" + safe_symbol + ".txt";
  }

bool ASC_PathEnsurePublicationFolders(const string server_root)
  {
   ResetLastError();
   bool root_ok = FolderCreate(server_root, FILE_COMMON);
   if(!root_ok && GetLastError() != 0)
      ResetLastError();

   ResetLastError();
   bool dossiers_ok = FolderCreate(ASC_PathDossierFolder(server_root), FILE_COMMON);
   if(!dossiers_ok && GetLastError() != 0)
      ResetLastError();

   return true;
  }


string ASC_PathTempFile(const string relative_path)
  {
   return relative_path + ".tmp";
  }

string ASC_PathLastGoodFile(const string relative_path)
  {
   return relative_path + ".lastgood";
  }

#endif // ASC_PERSISTENCE_PATHS_MQH
