/* Adapted from CODE-ANALYSIS-GRAPHS/Histograms.sas (M2 Money Supply half).
   Same structure as the FED Funds chart bundle; this one exercises the
   "M2 Money" WHERE filter and a different reference-line color.

   Edits versus the upstream:
   - Path rewritten from /home/u64447590/ALL_CORRELATIONS_RESULTS.csv to
     ./input/ALL_CORRELATIONS_RESULTS.csv.
   - PROC IMPORT takes a string literal (upstream used a FILENAME assignment).
   - Fillattrs color rewritten from CXRRGGBB hex to the closest named SAS
     color (mediumseagreen for M2).
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

/* 5. M2 Money Supply histogram with Mean line */
title "M2 Money Supply histogram";
proc sgplot data=crypto_data;
    where Label contains "M2 Money";
    vbar Cryptocurrency / response=Correlation_r
                          datalabel
                          categoryorder=respasc
                          fillattrs=(color=mediumseagreen);
    yaxis label="Pearson Correlation Coefficient (r)";
    xaxis label="Cryptocurrency Symbol";

    refline 0 / axis=y lineattrs=(thickness=1 color=black);

    /* Mean (mu) reference line */
    refline &m2_mean / axis=y lineattrs=(thickness=2 color=darkblue pattern=dash)
                       label="Mean (&m2_mean)" labelloc=inside;
run;
title;

proc print data=means_data; run;
