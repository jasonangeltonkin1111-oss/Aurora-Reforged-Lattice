#ifndef __ASC_DOSSIER_SCAFFOLD_MQH__
#define __ASC_DOSSIER_SCAFFOLD_MQH__

void ASC_DossierCanonicalFieldLabels(string &labels[])
  {
   ArrayResize(labels, 0);

   string canonical_labels[] =
     {
      "Generated:","Last Successful Publish:","Artifact Revision:","State Revision:","Continuity Status:","Freshness Status:","Selected Symbol Status:","Deep Analysis Status:",
      "Primary Read:","Primary Risk:","Primary Opportunity:","Primary Constraint:","Primary Next Check:","One-Line Summary:",
      "Publication Status:","Last Published:","Last Good Fallback:","Current Bundle Status:","Continuity Mode:","Missing / Delayed Areas:","Integrity Notes:",
      "Symbol:","Display Name:","Broker Symbol Name:","Asset Type:","Instrument Family:","Calculation Type:","Chart Mode:",
      "Advanced Classification Status:","Advanced Main Bucket:","Advanced Sub-Group:","Advanced Asset Class:","Advanced Classification Source:","Advanced Classification Confidence:",
      "Broker Main Bucket:","Broker Sector:","Broker Industry:","Broker Exchange:","Broker Country:","Broker Classification Notes:",
      "Resolved Main Bucket:","Resolved Sub-Group:","Resolved Asset Class:","Classification Resolution Rule:","Classification Conflict Status:","Classification Notes:",
      "Exchange:","Sector:","Industry:","Country:","ISIN:","Base Currency:","Quote Currency:","Margin Currency:","Digits:","Point:","Contract Profile Summary:",
      "Market Status:","Tradability Status:","Session Status:","Open / Closed / Uncertain:","Open / Closed / Uncertain Reason:",
      "Last Checked:","Next Check Due:","State Freshness:","State Confidence:","Bid / Ask Presence:","State Notes:",
      "Bid:","Ask:","Last:","Spread:","Spread %:","Last Tick Time:","Tick Age:","Quote Freshness:","Observed Time:","Quote Continuity Status:",
      "Daily Open:","Daily High:","Daily Low:","Daily Change %:","Day Range:","Day Range %:","Intraday Range Position:","Market Direction Snapshot:","Price Action Snapshot:",
      "ATR Value:","ATR %:","Spread / ATR:","Volatility Posture:","Friction Posture:","Liquidity Posture:","Market Watch Notes:",
      "Digits:","Point:","Contract Size:","Tick Size:","Tick Value:","Spread Type:","Calculation Mode:","Contract Notes:",
      "Trade Mode:","Execution Mode:","Filling Mode:","Expiration Mode:","GTC Mode:","Orders Allowed:","Trade Permission Status:","Broker Validation Status:",
      "Minimum Volume:","Maximum Volume:","Volume Step:","Stops Level:","Freeze Level:","Position Rule Notes:",
      "Quote Session Status:","Trade Session Status:","Quote Sessions:","Trade Sessions:","Session Notes:",
      "Swap Type:","Swap Long:","Swap Short:","Swap Monday:","Swap Tuesday:","Swap Wednesday:","Swap Thursday:","Swap Friday:","Swap Notes:",
      "Margin Mode:","Margin Hedged:","Margin Buy Initial:","Margin Buy Maintenance:","Margin Sell Initial:","Margin Sell Maintenance:","Margin Notes:",
      "Candidate State:","Eligibility Posture:","Evidence Freshness:","Score / Context Summary:","Decision Posture:",
      "Blocking Factors:","Required Dependencies:","Missing Corroboration:","Next Evidence Step:","Constraint Notes:",
      "Spread Check:","Freshness Check:","State Check:","Liquidity Check:","Volatility Context:","Quality Check:","Input Notes:",
      "Shortlist Status:","Authority Rank:","Score Stack:","Rank/Posture:","Rank Summary:","Promotion / Bucket:",
      "Authority Hold:","Stability / Bucket:","Replacement Pressure:","Selection Continuity:","Shortlist Notes:",
      "Peer Similarity Score:","Closest Peers:","Farthest Peers:","Exposure Conflict Status:","Open / Pending Conflict Notes:","Portfolio Conflict Notes:",
      "Deep Analysis Status:","Trigger Status:","Last Triggered:","Coverage Status:","Eligible for Deep Analysis:","Reason if Not Eligible:","Deep Analysis Continuity:","Preservation Status:",
      "Enabled Timeframes:","Bars per Timeframe:","Coverage Sufficiency:","Missing Timeframes:","Coverage Notes:",
      "Higher-Timeframe Structure:","Trend Structure:","Range / Expansion Structure:","Impulse / Pullback Structure:","Break / Reclaim / Rejection Notes:","OHLC Evidence Status:",
      "Nearest Support:","Nearest Resistance:","Key Reaction Zones:","Session Extremes:","Gap / Void / Imbalance Notes:","Price Map Notes:",
      "Tick Evidence Status:","Spread Evidence Status:","Microstructure Notes:","Quote Stability:","Spread Stability:","Execution Friction:","Microstructure Risk Notes:",
      "Market Regime:","Volatility Regime:","Liquidity Regime:","Session Regime:","Context Quality:","Context Notes:",
      "Cross-Market Alignment:","Related Symbols:","Conflict Symbols:","Beta / Proxy Notes:","Peer Context Notes:",
      "Directional Bias Support:","Continuation Support:","Reversal Risk:","Breakout Support:","Fade Risk:","Invalidation Context:","Trade Framing Notes:",
      "What Matters Most:","Best Supporting Evidence:","Biggest Warning:","What Is Still Missing:","What To Check Next:","Handoff Summary:",
      "Risk Context:","Execution Constraints:","Open Trade Conflict:","Pending Order Conflict:","Watchlist Priority:","What Changed Recently:","What Needs Recheck:",
      "Latest Meaningful Change:","Previous Meaningful Change:","State Transition Notes:","Selection Transition Notes:","Publication Transition Notes:","Deep Analysis Transition Notes:"
     };

   ArrayResize(labels, ArraySize(canonical_labels));
   for(int i = 0; i < ArraySize(canonical_labels); i++)
      labels[i] = canonical_labels[i];
  }

#endif
