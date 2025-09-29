//+------------------------------------------------------------------+
//| MyAdvancedLibrary.mqh                                           |
//| Include file for easy library usage                            |
//| Version: 1.0                                                    |
//+------------------------------------------------------------------+

#ifndef MY_ADVANCED_LIBRARY_MQH
#define MY_ADVANCED_LIBRARY_MQH

// Import library functions
#import "MyAdvancedLibrary.ex4"
    // Data Services
    double GetGMT_Offset(string symbol="");
    bool GetEconomicEvents(string country, datetime from, datetime to, string &events[]);
    
    // Position Management
    int CloseAllPositions(int magicNumber=0, int slippage=3);
    double GetTotalProfit(int magicNumber=0);
    int GetPositionCount(int magicNumber=0, string symbol="");
    
    // Risk Management
    double CalculateLotSize(double riskPercent, double stopLossPips, string symbol="");
#import

//+------------------------------------------------------------------+
//| Advanced Library Helper Class                                  |
//+------------------------------------------------------------------+
class CAdvancedLib
{
private:
    string m_lastError;

public:
    // Constructor
    CAdvancedLib() { m_lastError = ""; }
    
    // Market Analysis
    static bool IsTrending(int period=14, double threshold=30.0)
    {
        double rsi = iRSI(Symbol(), 0, period, PRICE_CLOSE, 0);
        return (rsi > (50 + threshold) || rsi < (50 - threshold));
    }
    
    // Time Utilities
    static bool IsTradingHours(int startHour=1, int endHour=23)
    {
        int currentHour = TimeHour(TimeCurrent());
        return (currentHour >= startHour && currentHour < endHour);
    }
    
    // Price Utilities
    static double GetPipValue(string symbol="")
    {
        if(symbol == "") symbol = Symbol();
        double point = MarketInfo(symbol, MODE_POINT);
        double tickValue = MarketInfo(symbol, MODE_TICKVALUE);
        return(tickValue / point);
    }
    
    // Error Handling
    string GetLastError() const { return m_lastError; }
    void SetLastError(string error) { m_lastError = error; }
    
    // Risk Management
    static double CalculatePositionSize(double entryPrice, double stopLoss, double riskPercent=1.0)
    {
        double accountBalance = AccountBalance();
        double riskAmount = accountBalance * riskPercent / 100.0;
        double riskPips = MathAbs(entryPrice - stopLoss) / MarketInfo(Symbol(), MODE_POINT);
        double pipValue = GetPipValue();
        
        if(pipValue == 0 || riskPips == 0) return(0.01);
        
        return NormalizeDouble(riskAmount / (riskPips * pipValue), 2);
    }
};

#endif
