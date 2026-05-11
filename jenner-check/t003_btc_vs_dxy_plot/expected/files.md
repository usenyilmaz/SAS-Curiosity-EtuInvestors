Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them.

This bundle is the BTC vs Dollar Index (DXY) comparison plot. The SGPLOT uses a logarithmic primary Y axis for BTC price and a linear secondary axis for DXY, exactly as the upstream script defines.

## Files

| name | content_type | notes |
|------|-------------|-------|
| ods_output/sgplot.svg | image/svg+xml | dual-axis time series: BTC price (log) + DXY |

## Datasets

| name | rows | columns |
|------|------|---------|
| work.btc_data | 49 | Date_sas, Price_num, Dollar_num |
