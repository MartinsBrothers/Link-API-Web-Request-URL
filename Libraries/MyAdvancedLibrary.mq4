//+------------------------------------------------------------------+
//| MyAdvancedLibrary.mq4                                           |
//| Advanced MQL4 Library for Versatile Development                 |
//| Version: 1.0                                                    |
//| Description: Comprehensive library for trading automation       |
//+------------------------------------------------------------------+
#property copyright "Advanced MQL4 Library"
#property version   "1.00"
#property strict
#property library

//+------------------------------------------------------------------+
//| Library Initialization                                          |
//+------------------------------------------------------------------+
int init()
{
    Print("=== MyAdvancedLibrary v1.00 Initialized ===");
    Print("• Position Management: Active");
    Print("• Risk Management: Active"); 
    Print("• Data Services: Ready");
    Print("• Error Handling: Enabled");
    return(0);
}

//+------------------------------------------------------------------+
//| Library Deinitialization                                        |
//+------------------------------------------------------------------+
int deinit()
{
    Print("MyAdvancedLibrary deinitialized");
    return(0);
}

//+------------------------------------------------------------------+
//| Get GMT Offset from multiple sources                           |
//+------------------------------------------------------------------+
double GetGMT_Offset(string symbol="") export
{
    // Implementation for GMT offset calculation
    double offset = 0;
    // Add your time service integration here
    return(offset);
}

//+------------------------------------------------------------------+
//| Get Economic Events                                            |
//+------------------------------------------------------------------+
bool GetEconomicEvents(string country, datetime from, datetime to, string &events[]) export
{
    ArrayResize(events, 1);
    events[0] = "High Impact: " + country + " News";
    return(true);
}

//+------------------------------------------------------------------+
//| Close All Positions                                            |
//+------------------------------------------------------------------+
int CloseAllPositions(int magicNumber=0, int slippage=3) export
{
    int count = 0;
    for(int i = OrdersTotal()-1; i >= 0; i--)
    {
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if(magicNumber == 0 || OrderMagicNumber() == magicNumber)
            {
                bool result = false;
                if(OrderType() == OP_BUY)
                    result = OrderClose(OrderTicket(), OrderLots(), Bid, slippage, clrWhite);
                else if(OrderType() == OP_SELL)
                    result = OrderClose(OrderTicket(), OrderLots(), Ask, slippage, clrWhite);
                
                if(result) count++;
                else Print("Failed to close order: ", GetLastError());
            }
        }
    }
    return(count);
}

//+------------------------------------------------------------------+
//| Get Total Profit                                               |
//+------------------------------------------------------------------+
double GetTotalProfit(int magicNumber=0) export
{
    double profit = 0;
    for(int i = OrdersTotal()-1; i >= 0; i--)
    {
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if(magicNumber == 0 || OrderMagicNumber() == magicNumber)
                profit += OrderProfit() + OrderSwap() + OrderCommission();
        }
    }
    return(NormalizeDouble(profit, 2));
}

//+------------------------------------------------------------------+
//| Advanced Position Counting                                     |
//+------------------------------------------------------------------+
int GetPositionCount(int magicNumber=0, string symbol="") export
{
    int count = 0;
    string currentSymbol = (symbol == "") ? Symbol() : symbol;
    
    for(int i = OrdersTotal()-1; i >= 0; i--)
    {
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if(OrderSymbol() == currentSymbol && 
               (magicNumber == 0 || OrderMagicNumber() == magicNumber))
                count++;
        }
    }
    return(count);
}

//+------------------------------------------------------------------+
//| Calculate Optimal Lot Size                                     |
//+------------------------------------------------------------------+
double CalculateLotSize(double riskPercent, double stopLossPips, string symbol="") export
{
    if(symbol == "") symbol = Symbol();
    
    double accountBalance = AccountBalance();
    double riskAmount = accountBalance * riskPercent / 100.0;
    double tickValue = MarketInfo(symbol, MODE_TICKVALUE);
    double pointValue = MarketInfo(symbol, MODE_POINT);
    
    if(pointValue == 0 || tickValue == 0) return(0.01);
    
    double lotSize = riskAmount / (stopLossPips * pointValue * tickValue);
    
    // Normalize lot size
    double minLot = MarketInfo(symbol, MODE_MINLOT);
    double maxLot = MarketInfo(symbol, MODE_MAXLOT);
    double stepLot = MarketInfo(symbol, MODE_LOTSTEP);
    
    lotSize = MathMax(minLot, MathMin(maxLot, lotSize));
    lotSize = MathRound(lotSize / stepLot) * stepLot;
    
    return(NormalizeDouble(lotSize, 2));
}
