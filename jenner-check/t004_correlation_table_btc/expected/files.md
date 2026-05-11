Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them.

This bundle exercises a single iteration of the macro loop in `correlation_tables.sas`: read the merged BTC dataset, take `log(Price)` and 1-month lagged Fed/M2/DXY values via `LAG1`, then run `PROC CORR pearson nosimple` with `var Log_Price; with Lag_Fed Lag_M2 Lag_Dxy;`. Jenner produces the standard `corr_heatmap.spec.json` + `corr_heatmap.svg` from the run.

## Files

| name | content_type | notes |
|------|-------------|-------|
| ods_output/corr_heatmap.spec.json | application/json | computed Pearson coefficients between Log_Price and each lagged macro |
| ods_output/corr_heatmap.svg | image/svg+xml | rendered heatmap |

## Datasets

| name | rows | columns |
|------|------|---------|
| work.temp_processed | 49 | Symbol, Date_str, Price_str, Vol, Mcap, Fed_str, M2_str, Dxy_str, Price_num, Log_Price, Lag_Fed, Lag_M2, Lag_Dxy |
