Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them.

This bundle is the Ethereum-vs-FED-Funds comparison plot. The SGPLOT uses a logarithmic primary Y axis for ETH price and a linear secondary axis for the FED Funds rate, exactly as the upstream script defines.

## Files

| name | content_type | notes |
|------|-------------|-------|
| ods_output/sgplot.svg | image/svg+xml | dual-axis time series: ETH price (log) + FED Funds rate |

## Datasets

| name | rows | columns |
|------|------|---------|
| work.eth_fed | 49 | Date_sas, Price_num, Fed_num |
