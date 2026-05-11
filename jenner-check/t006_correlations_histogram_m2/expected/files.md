Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them.

This bundle is the M2-Money-Supply half of `Histograms.sas`. Same shape as the FED Funds bundle — PROC SUMMARY + CALL SYMPUTX + WHERE-filtered SGPLOT — with the M2 mean (0.0779) feeding the reference line.

## Files

| name | content_type | notes |
|------|-------------|-------|
| ods_output/sgplot.svg | image/svg+xml | M2 Money Supply correlation bar chart with zero and mean reference lines |

## Datasets

| name | rows | columns |
|------|------|---------|
| crypto_data | 45 | Label, Correlation_r, P_Value, Sample_Size, Cryptocurrency |
| means_data | 3 | Label, _TYPE_, _FREQ_, mean_r |
