/* Adapted from CODE-ANALYSIS-GRAPHS/Histograms.sas (FED Funds half only).
   The upstream script renders three bar charts (FED, M2, DXY) from a single
   summary table; this bundle exercises the FED-Funds chart and the
   PROC SUMMARY / CALL SYMPUTX block that feeds the reference line.

   Edits versus the upstream:
   - Path rewritten from /home/u64447590/ALL_CORRELATIONS_RESULTS.csv to
     ./input/ALL_CORRELATIONS_RESULTS.csv.
   - Upstream uses `filename csv_file ...; proc import datafile=csv_file`;
     here we pass the literal path to PROC IMPORT.
   - Fillattrs color rewritten from CXRRGGBB hex to the closest named SAS
     color (steelblue for FED).
*/

/* 1. Import the dataset from the specified path */
proc import datafile="./input/ALL_CORRELATIONS_RESULTS.csv"
    out=crypto_data
    dbms=csv
    replace;
    getnames=yes;
run;

/* 2. Calculate the mean correlation for each macro parameter */
proc summary data=crypto_data nway;
    class Label;
    var Correlation_r;
    output out=means_data mean=mean_r;
run;

/* 3. Store mean values into macro variables for use in plots */
data _null_;
    set means_data;
    if index(Label, "Fed Funds") then call symputx('fed_mean', mean_r);
    else if index(Label, "M2 Money") then call symputx('m2_mean', mean_r);
    else if index(Label, "Dollar Index") then call symputx('dxy_mean', mean_r);
run;

/* 4. FED Funds histogram with Mean line */
title "FED Funds histogram";
proc sgplot data=crypto_data;
    where Label contains "Fed Funds";
    vbar Cryptocurrency / response=Correlation_r
                          datalabel
                          categoryorder=respasc
                          fillattrs=(color=steelblue);
    yaxis label="Pearson Correlation Coefficient (r)";
    xaxis label="Cryptocurrency Symbol";

    /* Zero reference line */
    refline 0 / axis=y lineattrs=(thickness=1 color=black);

    /* Mean (mu) reference line */
    refline &fed_mean / axis=y lineattrs=(thickness=2 color=darkred pattern=dash)
                        label="Mean (&fed_mean)" labelloc=inside;
run;
title;

proc print data=means_data; run;
