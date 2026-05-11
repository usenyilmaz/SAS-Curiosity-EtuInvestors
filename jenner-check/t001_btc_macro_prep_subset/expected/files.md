Files and datasets emitted by this run. URLs are tied to a single run on the Jenner API workspace and expire when the run is reaped; re-running the bundle regenerates them. Sample inputs sit under `./input/` in this bundle.

This bundle imports three macroeconomic series (FED Funds, M2 Money Supply, US Dollar Index) plus a Bitcoin daily history file, normalizes them to a monthly grain, and merges the four streams on Date. The PROC PRINT at the end shows the merged `btc_ready` table.

## Datasets

| name | rows | columns |
|------|------|---------|
| fedfunds | 19 | Date, FEDFUNDS |
| m2slchange | 19 | Date, M2SLCHANGE |
| dollarindex | 19 | Date, DOLLARINDEX |
| btc_raw | 94 | SNo, Name, Symbol, Date, High, Low, Open, Close, Volume, Marketcap |
| btc_firstday | 3 | Symbol, Date, Price, Volume, Marketcap |
| btc_ready | 3 | Symbol, Date, Price, Volume, Marketcap, FEDFUNDS, M2SLCHANGE, DOLLARINDEX |
