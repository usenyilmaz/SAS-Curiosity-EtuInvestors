Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them.

This bundle reads `btc_ready.csv` (Symbol; Date; Price; …; M2SLCHANGE; DOLLARINDEX in European format with `;` separator and `,` decimal point), parses the comma-decimals via `translate(... '.', ',')` + `input(... best32.)`, and produces a two-axis SGPLOT with BTC price (log Y axis) on the primary and M2 supply change on the secondary axis.

## Files

| name | content_type | notes |
|------|-------------|-------|
| ods_output/sgplot.svg | image/svg+xml | dual-axis time series: BTC price (log) + M2 supply |

## Datasets

| name | rows | columns |
|------|------|---------|
| work.btc_m2 | 49 | Date_sas, Price_num, M2_num |
