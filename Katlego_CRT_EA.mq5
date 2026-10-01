//+------------------------------------------------------------------+
//| Katlego-CRT-EA - CRT H1 + Supply/Demand + M5 Entry              |
//| XAUUSDm 0.02 Lot SL 3$ TP 6$                                     |
//+------------------------------------------------------------------+
#property copyright "katlego231222"
#property version   "1.10"
#include <Trade/Trade.mqh>
input double LotSize=0.02;
input int Magic=231222;
input double SL_Dollar=3.0;
input double TP_Dollar=6.0;
input ENUM_TIMEFRAMES EntryTF=PERIOD_M5;
CTrade trade;
int OnInit(){trade.SetExpertMagicNumber(Magic);return(INIT_SUCCEEDED);}
void OnTick(){
 if(PositionsTotal()>0)return;
 double h1_high=iHigh(_Symbol,PERIOD_H1,1);
 double h1_low=iLow(_Symbol,PERIOD_H1,1);
 double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
 double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
 double o1=iOpen(_Symbol,EntryTF,1);
 double c1=iClose(_Symbol,EntryTF,1);
 double o2=iOpen(_Symbol,EntryTF,2);
 double c2=iClose(_Symbol,EntryTF,2);
 bool bull=(c1>o1 && c2<o2 && c1>o2);
 bool bear=(c1<o1 && c2>o2 && c1<o2);
 bool sweepLow=iLow(_Symbol,PERIOD_H1,0)<h1_low;
 bool sweepHigh=iHigh(_Symbol,PERIOD_H1,0)>h1_high;
 if(sweepLow && bid>h1_low && bid<h1_low+3.0 && bull){
  trade.Buy(LotSize,_Symbol,ask,ask-SL_Dollar,ask+TP_Dollar,"CRT BUY");}
 if(sweepHigh && bid<h1_high && bid>h1_high-3.0 && bear){
  trade.Sell(LotSize,_Symbol,bid,bid+SL_Dollar,bid-TP_Dollar,"CRT SELL");}
}
