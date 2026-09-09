# Athens Urban Water Consumption Analytics

End-to-end data analytics and data engineering project based on
EYDAP urban water consumption data.

## Project Status

🚧 Currently in progress

Current phase:
Data Understanding & Grain Investigation

## Technology Stack

- SQL Server
- T-SQL
- ETL
- Power BI

Python is intentionally out of scope for this project.

## Project Architecture

RAW
 ↓
STAGING
 ↓
TRANSFORMATION
 ↓
ANALYTICAL DATABASE
 ↓
SQL ANALYSIS
 ↓
POWER BI

## Current Focus

The current objective is to understand the source data before designing
the final analytical model.

The most important question is:

> What exactly does one row represent?

## Current Findings

- 260,138 records across both datasets
- Coverage from 2021-01 to 2025-03
- 5 observed consumption classes
- No full-row duplicates observed
- PostalCode → AreaEnglish is not one-to-one
- PostalCode + Zone + Month is not unique
- PostalCode + AreaEnglish + Zone + Month is not universally unique
- Geographic missing values exist

## Current Open Questions

- What is the true grain of the data?
- Why does the candidate key fail?
- What does NumberOfConnections represent?
- What exactly does AreaEnglish represent?
- Why can one PostalCode correspond to multiple areas?
- Can population be safely joined?
- Is AverageDailyConsumption consistently derived?

## Project Roadmap

- [x] SQL Server RAW database
- [x] SQL Server DW database
- [x] Staging tables
- [x] Initial data profiling
- [x] Candidate key investigation
- [ ] Determine true grain
- [ ] Finalize geography model
- [ ] Design fact table
- [ ] Design dimensions
- [ ] Build ETL
- [ ] Analytical SQL
- [ ] Power BI
- [ ] Final business insights
