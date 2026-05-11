Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them.

This bundle imports `ALL_CORRELATIONS_RESULTS.csv` (the table the upstream loop produces in `correlation_tables.sas`), aggregates by Label via PROC SUMMARY CLASS=Label, and renders a per-cryptocurrency vbar chart filtered to the Fed Funds rows with reference lines at zero and at the macro-wide mean (set via PROC SUMMARY → CALL SYMPUTX → `&fed_mean`).

## Files

| name | content_type | notes |
|------|-------------|-------|
| ods_output/sgplot.svg | image/svg+xml | FED Funds correlation bar chart with zero and mean reference lines |

## Datasets

| name | rows | columns |
|------|------|---------|
| crypto_data | 45 | Label, Correlation_r, P_Value, Sample_Size, Cryptocurrency |
| means_data | 3 | Label (Fed/M2/DXY), _TYPE_, _FREQ_, mean_r |
