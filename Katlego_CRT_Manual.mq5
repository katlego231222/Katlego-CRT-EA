//+------------------------------------------------------------------+
//| Katlego CRT Manual - For Phone Manual Trading                    |
//+------------------------------------------------------------------+
#property copyright "katlego231222"
#property version   "2.0"
#property indicator_chart_window
input double SupplyHigh = 4191.0;
input double SupplyLow = 4186.0;
input double DemandHigh = 4154.0;
input double DemandLow = 4151.0;
input bool EnablePush = true;
int OnInit(){return(INIT_SUCCEEDED);}
int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[], const double &open[], const double &high[], const double &low[], const double &close[], const long &tick_volume[], const long &volume[], const int &spread[]){
 double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);
 double h1_high=iHigh(_Symbol,PERIOD_H1,1);
 double h1_low=iLow(_Symbol,PERIOD_H1,1);
 ObjectCreate(0,"CRT_SUPPLY_FIXED",OBJ_RECTANGLE,0,0,0,0,0);
 ObjectSetInteger(0,"CRT_SUPPLY_FIXED",OBJPROP_TIME1,iTime(_Symbol,PERIOD_H1,10));
 ObjectSetInteger(0,"CRT_SUPPLY_FIXED",OBJPROP_TIME2,iTime(_Symbol,PERIOD_H1,0)+7200);
 ObjectSetDouble(0,"CRT_SUPPLY_FIXED",OBJPROP_PRICE1,SupplyHigh);
 ObjectSetDouble(0,"CRT_SUPPLY_FIXED",OBJPROP_PRICE2,SupplyLow);
 ObjectSetInteger(0,"CRT_SUPPLY_FIXED",OBJPROP_COLOR,clrRed);
 ObjectSetInteger(0,"CRT_SUPPLY_FIXED",OBJPROP_FILL,true);
 ObjectSetInteger(0,"CRT_SUPPLY_FIXED",OBJPROP_BACK,true);
 ObjectCreate(0,"CRT_DEMAND_FIXED",OBJ_RECTANGLE,0,0,0,0,0);
 ObjectSetInteger(0,"CRT_DEMAND_FIXED",OBJPROP_TIME1,iTime(_Symbol,PERIOD_H1,10));
 ObjectSetInteger(0,"CRT_DEMAND_FIXED",OBJPROP_TIME2,iTime(_Symbol,PERIOD_H1,0)+7200);
 ObjectSetDouble(0,"CRT_DEMAND_FIXED",OBJPROP_PRICE1,DemandHigh);
 ObjectSetDouble(0,"CRT_DEMAND_FIXED",OBJPROP_PRICE2,DemandLow);
 ObjectSetInteger(0,"CRT_DEMAND_FIXED",OBJPROP_COLOR,clrGreen);
 ObjectSetInteger(0,"CRT_DEMAND_FIXED",OBJPROP_FILL,true);
 ObjectSetInteger(0,"CRT_DEMAND_FIXED",OBJPROP_BACK,true);
 double o1=iOpen(_Symbol,PERIOD_M5,1); double c1=iClose(_Symbol,PERIOD_M5,1);
 double o2=iOpen(_Symbol,PERIOD_M5,2); double c2=iClose(_Symbol,PERIOD_M5,2);
 bool bull=(c1>o1 && c2<o2 && c1>o2); bool bear=(c1<o1 && c2>o2 && c1<o2);
 if(bid>=DemandLow && bid<=DemandHigh+3 && bull){ Alert("BUY XAUUSD 0.02 lot DEMAND!"); if(EnablePush) SendNotification("BUY XAUUSD DEMAND ZONE"); }
 if(bid<=SupplyHigh && bid>=SupplyLow-3 && bear){ Alert("SELL XAUUSD 0.02 lot SUPPLY!"); if(EnablePush) SendNotification("SELL XAUUSD SUPPLY ZONE"); }
 return(rates_total);}
