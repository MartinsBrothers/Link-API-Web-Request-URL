//+------------------------------------------------------------------+
//| ExampleIndicator.mq4                                            |
//| Example Indicator using Advanced Library                       |
//+------------------------------------------------------------------+
#property copyright "Example Indicator"
#property version   "1.00"
#property strict
#property indicator_chart_window

#include <MyAdvancedLibrary.mqh>

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
    Print("Example Indicator using Advanced Library");
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
    // Example: Display position count on chart
    int positions = GetPositionCount();
    Comment("Active Positions: ", positions, 
            "\nTotal Profit: $", GetTotalProfit());
    
    return(rates_total);
}
