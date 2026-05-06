#ifndef __DOSSIERS_ARL_DOSSIERWRITER_MQH__
#define __DOSSIERS_ARL_DOSSIERWRITER_MQH__

//+------------------------------------------------------------------+
//| ARL_DossierWriter
//| Aurora Reforged Lattice — MT5 scaffold
//| Run: ARL-RUN004
//| Status: SCAFFOLD ONLY — no trading, no signal, no execution.
//+------------------------------------------------------------------+
// Owner: dossiers/writer
// Purpose: Owns dossier publication through io publisher.
// Inputs: dossier payload
// Outputs: Dossier_Current.txt
// Forbidden: direct file overwrite
// Anti-cosmetic rule: this module must earn its place through a real
// runtime contract, output contract, acceptance test, or lock file
// before future implementation is treated as complete.

bool ARL_DossierWriter_Build(){ return true; }
string ARL_DossierWriter_Contract(){ return "SCAFFOLD"; }

#endif // __DOSSIERS_ARL_DOSSIERWRITER_MQH__
