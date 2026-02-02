# Docs Folder

## Overview
The `docs` folder in this DBT project is designated for storing documentation-related files. It helps maintain and share information about our data models, sources, and transformations, making the project more accessible to team members and stakeholders.

## Purpose
- Stores auto-generated documentation files created by DBT's `dbt docs generate` command (e.g., `index.html`, CSS, JavaScript).
- Can include custom documentation files (e.g., Markdown files) to describe the project, models, or business logic.

## Usage
### **1. Generated Documentation**
DBT allows you to generate interactive documentation for your models. Running the command below will create a set of HTML files that document the project, including model lineage (DAG), column descriptions, and source details.
```bash
dbt docs generate
```
This produces a site that can be stored in this folder. To view the generated documentation, you can run:
```bash
dbt docs serve
```
This starts a local web server to browse the documentation interactively.

### **2. Custom Documentation**
You can add your own Markdown files (`.md`) or other documentation assets in this folder to provide additional context or instructions. Examples include:
- A high-level project overview (`project_overview.md`)
- Business logic explanations (`business_rules.md`)
- Contribution guidelines (`contributing.md`)

## Example
If a model is documented in `schema.yml`:
```yaml
version: 2
models:
  - name: stg_customers
    description: "Staging table for customer data"
    columns:
      - name: customer_id
        description: "Unique identifier for a customer"
```
Running `dbt docs generate` will create an HTML documentation page for `stg_customers`, including its description and column details.

## Notes
- This folder is optional but recommended for keeping documentation organized.
- If hosting externally, copy the generated files (`index.html`, CSS, and JavaScript) to a web server or cloud storage.
- Keeping documentation up to date ensures better collaboration and understanding of the project.