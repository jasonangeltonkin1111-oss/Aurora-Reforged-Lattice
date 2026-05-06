#ifndef __ASC_DOSSIER_CONTRACTS_MQH__
#define __ASC_DOSSIER_CONTRACTS_MQH__

#include "../ASC_ArtifactContracts.mqh"

enum ASC_DossierProductMode
  {
   ASC_DOSSIER_MODE_OPEN_MARKET = 0,
   ASC_DOSSIER_MODE_CLOSED_MARKET = 1,
   ASC_DOSSIER_MODE_DEEP_OVERRIDE = 2
  };

ASC_ArtifactContract ASC_DossierContract(const string server_root,const string canonical_symbol)
  {
   ASC_ArtifactContract contract;
   contract.family = ASC_ARTIFACT_DOSSIER;
   contract.artifact_name = "Symbol Dossier";
   contract.target_path = server_root + "\\" + ASC_DOSSIER_FOLDER + "\\" + canonical_symbol + ".txt";
   contract.publication_state = ASC_PUBLICATION_PENDING;
   return contract;
  }

void ASC_DossierCanonicalSectionOrder(string &sections[])
  {
   ArrayResize(sections, 12);
   sections[0] = "OPERATOR SNAPSHOT";
   sections[1] = "PUBLICATION HEALTH";
   sections[2] = "SYMBOL IDENTITY [L0]";
   sections[3] = "MARKET STATE [L1]";
   sections[4] = "MARKET WATCH [L2]";
   sections[5] = "TRADING CONDITIONS & CONTRACT [L2]";
   sections[6] = "SESSIONS, SWAP & MARGIN [L2]";
   sections[7] = "CANDIDATE FILTERING [L3]";
   sections[8] = "SHORTLIST SELECTION [L4]";
   sections[9] = "DEEP SELECTIVE ANALYSIS [L5]";
   sections[10] = "TRADER CONTEXT";
   sections[11] = "CHANGE TRACE";
  }

void ASC_DossierCanonicalRequiredTokens(string &required_tokens[])
  {
   ArrayResize(required_tokens, 13);
   required_tokens[0] = "Publication Id:";
   required_tokens[1] = "Publication UTC:";
   required_tokens[2] = "AURORA SENTINEL SCANNER — SYMBOL DOSSIER";
   required_tokens[3] = "OPERATOR SNAPSHOT";
   required_tokens[4] = "PUBLICATION HEALTH";
   required_tokens[5] = "SYMBOL IDENTITY [L0]";
   required_tokens[6] = "MARKET STATE [L1]";
   required_tokens[7] = "MARKET WATCH [L2]";
   required_tokens[8] = "TRADING CONDITIONS & CONTRACT [L2]";
   required_tokens[9] = "SESSIONS, SWAP & MARGIN [L2]";
   required_tokens[10] = "CANDIDATE FILTERING [L3]";
   required_tokens[11] = "SHORTLIST SELECTION [L4]";
   required_tokens[12] = "DEEP SELECTIVE ANALYSIS [L5]";
  }

void ASC_DossierClosedCanonicalRequiredTokens(string &required_tokens[])
  {
   ArrayResize(required_tokens, 10);
   required_tokens[0] = "Publication Id:";
   required_tokens[1] = "Publication UTC:";
   required_tokens[2] = "AURORA SENTINEL SCANNER — SYMBOL DOSSIER";
   required_tokens[3] = "OPERATOR SNAPSHOT";
   required_tokens[4] = "PUBLICATION HEALTH";
   required_tokens[5] = "SYMBOL IDENTITY [L0]";
   required_tokens[6] = "MARKET STATE [L1]";
   required_tokens[7] = "MARKET WATCH [L2]";
   required_tokens[8] = "TRADING CONDITIONS & CONTRACT [L2]";
   required_tokens[9] = "SESSIONS, SWAP & MARGIN [L2]";
  }

void ASC_DossierCanonicalSubgroupOrder(const string section_name,string &subgroups[])
  {
   ArrayResize(subgroups, 0);

   if(section_name == "SYMBOL IDENTITY [L0]")
     {
      ArrayResize(subgroups, 3);
      subgroups[0] = "Core Identity";
      subgroups[1] = "Classification";
      subgroups[2] = "Symbol Metadata";
      return;
     }

   if(section_name == "MARKET STATE [L1]")
     {
      ArrayResize(subgroups, 2);
      subgroups[0] = "State Overview";
      subgroups[1] = "State Timing";
      return;
     }

   if(section_name == "MARKET WATCH [L2]")
     {
      ArrayResize(subgroups, 3);
      subgroups[0] = "Quote Snapshot";
      subgroups[1] = "Day Structure";
      subgroups[2] = "Volatility & Liquidity";
      return;
     }

   if(section_name == "TRADING CONDITIONS & CONTRACT [L2]")
     {
      ArrayResize(subgroups, 3);
      subgroups[0] = "Contract Specs";
      subgroups[1] = "Trading Permissions";
      subgroups[2] = "Volume Rules";
      return;
     }

   if(section_name == "SESSIONS, SWAP & MARGIN [L2]")
     {
      ArrayResize(subgroups, 3);
      subgroups[0] = "Sessions";
      subgroups[1] = "Swap";
      subgroups[2] = "Margin";
      return;
     }

   if(section_name == "CANDIDATE FILTERING [L3]")
     {
      ArrayResize(subgroups, 3);
      subgroups[0] = "Candidate Score & Eligibility";
      subgroups[1] = "Dependencies & Friction";
      subgroups[2] = "Candidate Inputs";
      return;
     }

   if(section_name == "SHORTLIST SELECTION [L4]")
     {
      ArrayResize(subgroups, 3);
      subgroups[0] = "Shortlist Rank & Score";
      subgroups[1] = "Shortlist Stability & Pressure";
      subgroups[2] = "Peer Similarity & Exposure";
      return;
     }

   if(section_name == "DEEP SELECTIVE ANALYSIS [L5]")
     {
      ArrayResize(subgroups, 8);
      subgroups[0] = "Deep Analysis Overview";
      subgroups[1] = "Cross-Timeframe Summary";
      subgroups[2] = "Timeframe Analytic Summary";
      subgroups[3] = "Decision Support";
      subgroups[4] = "OHLC by Enabled Timeframe";
      subgroups[5] = "Recent Tick Activity";
      subgroups[6] = "Live Spread Rollover";
      subgroups[7] = "Preservation State";
      return;
     }
  }

#endif
