# Athens Urban Water Consumption Analytics

An end-to-end data engineering and analytics project based on public urban water consumption data published by **EYDAP** for Athens, Greece.

The goal is to build a reproducible SQL Server pipeline for data integration, validation, analytical modeling, SQL analysis, and Power BI reporting.

> **Status:** In Progress  
> **Current Phase:** Source Integration and Validation

---

## Technology Stack

- SQL Server
- T-SQL
- ETL
- Power BI

> Python is intentionally out of scope for this project.

---

## Dataset Overview

The project combines two source periods covering **January 2021 to March 2025**.

| Metric | Result |
|---|---:|
| Combined source rows | 260,138 |
| Integrated target rows | 260,067 |
| Aggregated groups | 71 |
| Consumption classes | 5 |

Main fields include:

- Postal code and area names
- Consumption class
- Total water consumption
- Consumption days
- Number of connections
- Average daily consumption
- Reference year and month

---

## Project Architecture

```text
Source Data
    ↓
Raw & Staging
    ↓
Translation & Integration
    ↓
Validation & Cleaning
    ↓
Analytical Model
    ↓
SQL Analysis
    ↓
Power BI
```

---

## Current Progress

Completed so far:

- Imported both source datasets into SQL Server
- Created RAW, staging, and translation structures
- Performed initial data profiling
- Investigated candidate keys and source-data grain
- Combined both source periods
- Identified and aggregated 71 multi-row groups
- Loaded 260,067 rows into the integrated target table
- Reconciled the main source and target row counts
- Performed initial NULL and geographic relationship checks

The current focus is completing source-to-target validation before data cleaning and analytical modeling.

---

## Key Findings

- No full-row duplicates were identified
- The initially tested candidate keys are not universally unique
- Postal codes do not have a one-to-one relationship with area names
- Missing geographic values exist
- `AreaGreek` and `AreaEnglish` follow the same NULL pattern
- `AverageDailyConsumption` is treated as a non-additive measure
- The final analytical grain is still being validated

Missing area values are not filled using postal code alone because one postal code may correspond to multiple areas.

---

## Validation Approach

The integrated dataset is being checked through:

- Source-to-target row-count reconciliation
- Duplicate checks at the selected grain
- Measure and aggregation validation
- Average daily consumption validation
- NULL-distribution comparison
- Date-range and consumption-class checks

---

## Planned Analytical Model

The planned design is a Star Schema containing:

- `FactWaterConsumption`
- `DimDate`
- `DimGeography`
- `DimConsumptionClass`

The model will be finalized after validation of the analytical grain and geographic relationships.

---

## Roadmap

- [x] Import source datasets
- [x] Create staging and translation structures
- [x] Perform initial data profiling
- [x] Investigate candidate keys and data grain
- [x] Integrate both source periods
- [x] Aggregate multi-row groups
- [x] Perform initial validation
- [ ] Complete detailed source-to-target validation
- [ ] Confirm the final analytical grain
- [ ] Clean and transform the data
- [ ] Build the Star Schema
- [ ] Develop analytical SQL queries
- [ ] Build the Power BI report
- [ ] Document final insights

---

## Current Limitations

- The final analytical grain is still under validation
- Postal code does not uniquely identify an area
- Geographic and population enrichment has not been finalized
- The analytical model and Power BI report are not yet complete

---

## Project Goal

The final project will demonstrate:

- SQL Server data engineering
- ETL and data validation
- Data-quality assessment
- Analytical data modeling
- SQL analysis
- Power BI reporting
