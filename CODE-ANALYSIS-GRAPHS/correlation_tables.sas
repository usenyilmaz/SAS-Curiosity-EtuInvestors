/* =====================================================================
   PROJECT: Macroeconomic Correlation Analysis Across 15 Cryptocurrencies
   AUTHOR: Ural (as part of SAS Curiosity Cup 2026 Project)
   PURPOSE: Analyze 1-month lagged effects of Fed Funds, M2, and DXY 
            on various crypto prices and visualize the distribution.
   ===================================================================== */

%macro analyze_crypto_market;

    /* Define the list of cryptocurrencies and their respective file paths */
    %let coins = BTC ETH XRP XLM BNB ADA LINK ATOM CRO DOGE TRX EOS IOTA LTC XMR;
    %let paths = /home/u64447590/BTC/btc_ready.csv 
                 /home/u64447590/ETH/eth_ready.csv 
                 /home/u64447590/XRP/XRP_ready.csv 
                 /home/u64447590/Stellar/Stellar_ready.csv
                 /home/u64447590/BNB/BinanceCoin_ready.csv
                 /home/u64447590/ADA/Cardano_ready.csv
                 /home/u64447590/LINK/Chainlink_ready.csv
                 /home/u64447590/ATOM/Cosmos_ready.csv
                 /home/u64447590/CRO/Cronos_ready.csv
                 /home/u64447590/DOGE/Dogecoin_ready.csv
                 /home/u64447590/TRON/Tron_ready.csv
                 /home/u64447590/EOS/EOS_ready.csv
                 /home/u64447590/IOTA/IOTA_ready.csv
                 /home/u64447590/LTC/Litecoin_ready.csv
                 /home/u64447590/XMR/Monero_ready.csv;

    /* Clear any existing results table to start fresh */
    proc datasets lib=work nolist; delete all_correlations_results; quit;

    /* Start the loop for 15 cryptocurrencies */
    %do i = 1 %to 15;
        %let current_coin = %scan(&coins, &i);
        %let current_path = %scan(&paths, &i, %str( ));

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
        
        /* Capture the output table to use for the histogram later */
        ods output PearsonCorr=work.current_corr;
        proc corr data=work.temp_processed pearson nosimple;
            var Log_Price;
            with Lag_Fed Lag_M2 Lag_Dxy;
        run;
        
        

        /* 3. STEP: Consolidate Results for Global Visualization */
        data work.current_corr;
            set work.current_corr;
            length Cryptocurrency $10;
            Cryptocurrency = "&current_coin";
            drop Variable;
        run;
        
        /* STEP 3: Consolidate and Rename Columns for Clarity */
        data work.current_corr;
            set work.current_corr;
            length Cryptocurrency $10;
            Cryptocurrency = "&current_coin";
            
            /* Rename SAS default names to descriptive titles */
            rename Log_Price = Correlation_r
                   PLog_Price = P_Value
                   NLog_Price = Sample_Size;
                   
            drop Variable;
        run;

        proc append base=all_correlations_results data=work.current_corr force; run;
        
        /* Clear the title for the next iteration */
        title; 
    %end;

    /* 4. STEP: Histogram Visualization of Market-Wide Correlations */
    title "Distribution of Macroeconomic Sensitivities Across the Crypto Market";
    proc sgplot data=all_correlations_results;
        /* Visualizing the distribution of M2 Supply Correlations as a primary example */
        histogram Lag_M2 / fillattrs=(color=vibg) transparency=0.4 name="M2Dist" legendlabel="M2 Correlation Dist.";
        density Lag_M2 / type=kernel lineattrs=(color=darkgreen thickness=2);
        
        xaxis label="Pearson Correlation Coefficient (r) with 1-Month Lag";
        yaxis label="Count of Cryptocurrencies";
        keylegend "M2Dist";
    run;
    title;

%mend analyze_crypto_market;

/* Execute the entire analysis procedure */
%analyze_crypto_market;