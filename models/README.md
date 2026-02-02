# DBT Models Folder Structure Guide

This guide explains the purpose and usage of the `models` folder and its common subfolders—`staging`, `intermediate`, and `marts`—in a DBT (Data Build Tool) project. These components form a layered approach to data transformation, helping you organize your SQL models effectively.

## Overview

In DBT, the `models` folder is the heart of your project, where all SQL transformation logic resides. It contains `.sql` files that define how raw data is transformed into meaningful, business-ready datasets. To manage complexity, it’s typically organized into subfolders like `staging`, `intermediate`, and `marts`, each serving a distinct role in the data pipeline.

### The Models Folder
- **Purpose**: Houses all SQL models that transform raw data into structured outputs, acting as the central hub for your data logic.
- **What It Does**:
  - Defines tables or views in your data warehouse.
  - Uses DBT’s `{{ ref('model_name') }}` syntax to reference other models or sources.
  - Supports materializations (e.g., `table`, `view`, `incremental`) to control how data is stored.
- **Key Features**:
  - Can include any number of subfolders for organization.
  - Configurable via `dbt_project.yml` (e.g., setting materialization defaults).
  - Integrates with DBT’s testing and documentation features.
- **Why It’s Useful**: Provides a single location to manage all transformations, making it easy to scale and maintain your project.
- **Example**: A `models` folder might contain `staging/stg_customers.sql`, `intermediate/int_orders_joined.sql`, and `marts/fct_sales.sql`.

## Subfolder Details

### 1. Staging Folder
- **Purpose**: Cleans and standardizes raw data from source systems (e.g., databases, APIs, or files) to create a reliable base layer.
- **Key Tasks**:
  - Renames columns for consistency.
  - Casts data types (e.g., strings to integers).
  - Filters out irrelevant or bad data.
  - Handles null values or basic formatting.
- **Input**: Raw source data (defined in `sources.yml`).
- **Output**: Lightly transformed tables ready for downstream use.
- **Naming Convention**: Files start with `stg_` (e.g., `stg_customers.sql`).
- **Example**:
  - Raw table: `raw_salesforce_customers` (inconsistent names, mixed types).
  - Model: `stg_salesforce_customers` (standardized columns like `customer_id`, `first_name`).

### 2. Intermediate Folder
- **Purpose**: Performs complex transformations or joins on staging data, acting as a bridge to final outputs.
- **Key Tasks**:
  - Joins multiple staging models.
  - Applies specific business logic not suited for staging.
  - Pre-computes calculations to simplify downstream models.
- **Input**: Staging models (e.g., `stg_orders`, `stg_customers`).
- **Output**: Intermediate tables that reduce redundancy or complexity.
- **Naming Convention**: Files start with `int_` (e.g., `int_orders_joined.sql`).
- **Example**:
  - Input: `stg_orders` and `stg_customers`.
  - Model: `int_orders_with_customer_details` (joined data with calculated fields like `order_age_in_days`).

### 3. Marts Folder
- **Purpose**: Produces final, business-ready datasets optimized for analysis, reporting, or dashboards.
- **Key Tasks**:
  - Aggregates data into metrics or KPIs (e.g., total sales).
  - Structures data into facts and dimensions (e.g., star schemas).
  - Tailors outputs for specific business needs.
- **Input**: Intermediate or staging models.
- **Output**: Final tables split into:
  - **Facts**: Transactional data (e.g., `fct_sales.sql`).
  - **Dimensions**: Descriptive data (e.g., `dim_customers.sql`).
- **Naming Convention**: 
  - Facts start with `fct_` (e.g., `fct_sales.sql`).
  - Dimensions start with `dim_` (e.g., `dim_products.sql`).
- **Example**:
  - Input: `int_orders_with_customer_details`.
  - Models: 
    - `fct_sales` (sales by region and month).
    - `dim_customers` (deduplicated customer attributes).

## Data Flow
- **Pipeline**: `Staging` → `Intermediate` → `Marts`.
  - **Staging**: Prepares raw data.
  - **Intermediate**: Builds modular transformations.
  - **Marts**: Delivers end-user datasets.
- **Example**:
  1. `stg_salesforce_orders.sql`: Cleans raw orders.
  2. `int_orders_with_customers.sql`: Joins orders with customers.
  3. `fct_sales.sql`: Aggregates sales for a dashboard.

## Why Use This Structure?
- **Organization**: The `models` folder and its subfolders separate concerns for better maintainability.
- **Reusability**: Encourages modular, reusable models across the pipeline.
- **Efficiency**: Optimizes transformations and materializations for performance.
- **Clarity**: Aligns with data engineering best practices (e.g., dimensional modeling).

## Getting Started
To set up your `models` folder in a DBT project:
1. Create the `models` folder in your project root.
2. Add `staging`, `intermediate`, and `marts` subfolders (or customize as needed).
3. Write SQL models following the naming conventions.
4. Use `{{ ref('model_name') }}` to reference upstream models or `{{ source('source_name', 'table_name') }}` for raw data.
5. Configure materializations in `dbt_project.yml` or individual `.sql` files (e.g., `{{ config(materialized='table') }}`).

For more details, see the [DBT Documentation](https://docs.getdbt.com/).