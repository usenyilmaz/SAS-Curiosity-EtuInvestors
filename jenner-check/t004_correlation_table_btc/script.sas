/* Adapted from CODE-ANALYSIS-GRAPHS/correlation_tables.sas (one iteration of the macro loop).
   The upstream script iterates over 15 coins; this bundle exercises the single-coin core:
   read the merged _ready.csv, build Lag_Fed/Lag_M2/Lag_Dxy via LAG1, and run PROC CORR
   with VAR Log_Price and WITH Lag_Fed Lag_M2 Lag_Dxy. */

%let current_coin = BTC;
%let current_path = ./input/btc_ready.csv;

/* 1. STEP: Data Cleaning and Feature Engineering (Lagging) */
data work.temp_processed;
    infile "&current_path" dlm=';' firstobs=2 dsd;
    input Symbol $ Date_str $ Price_str $ Vol $ Mcap $ Fed_str $ M2_str $ Dxy_str $;

    /* Convert comma-decimals to standard numeric format */
    Price_num = input(translate(Price_str, '.', ','), best32.);
    Log_Price = log(Price_num);

    /* Apply 1-month lag to macro variables to see the delayed impact */
    Lag_Fed = lag1(input(translate(Fed_str, '.', ','), best32.));
    Lag_M2  = lag1(input(translate(M2_str, '.', ','), best32.));
    Lag_Dxy = lag1(input(translate(Dxy_str, '.', ','), best32.));

    label Lag_Fed = "Fed Funds Rate (1M Lag)"
          Lag_M2  = "M2 Money Supply (1M Lag)"
          Lag_Dxy = "Dollar Index - DXY (1M Lag)";
run;

/* 2. STEP: Statistical Analysis with Dynamic Titles */
title "Pearson Correlation Analysis: &current_coin vs. Macroeconomic Parameters";
proc corr data=work.temp_processed pearson nosimple;
    var Log_Price;
    with Lag_Fed Lag_M2 Lag_Dxy;
run;
title;
