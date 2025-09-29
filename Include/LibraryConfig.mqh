//+------------------------------------------------------------------+
//| LibraryConfig.mqh                                               |
//| Configuration settings for the library                         |
//| Version: 1.0                                                    |
//+------------------------------------------------------------------+

#ifndef LIBRARY_CONFIG_MQH
#define LIBRARY_CONFIG_MQH

// Time service configuration
struct TimeSourceConfig
{
    string primarySource;
    string fallbackSources[5];
    int    cacheTimeout;
    bool   autoUpdate;
};

// Economic data configuration  
struct EconomicConfig
{
    string sources[6];
    string countries[10];
    int    updateInterval;
    bool   filterHighImpact;
};

// Risk management configuration
struct RiskConfig
{
    double maxRiskPercent;
    double maxLotSize;
    double minLotSize;
    bool   useDynamicLots;
    int    maxPositions;
};

// Default configurations
TimeSourceConfig timeConfig = 
{
    "https://gmt-offset.online/",
    {"http://timesrv.online/", "http://valerytrading.com/", "https://www.worldtimeserver.com/", "https://www.xe.com/", ""},
    300,
    true
};

EconomicConfig economicConfig =
{
    {"https://www.economies.com/", "https://www.investing.com/", "https://www.dailyfx.com/", 
     "http://calendar.fxstreet.com/", "https://ec.forexprostools.com/", "https://smartfx.com/"},
    {"USD", "EUR", "GBP", "JPY", "CHF", "CAD", "AUD", "NZD", "CNY", ""},
    3600,
    true
};

RiskConfig riskConfig =
{
    2.0,    // maxRiskPercent
    10.0,   // maxLotSize  
    0.01,   // minLotSize
    true,   // useDynamicLots
    5       // maxPositions
};

#endif
