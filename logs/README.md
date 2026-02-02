# Logs Folder

## Overview
The `logs` folder in this DBT project is used to store log files generated during DBT execution. It provides visibility into the operations performed by DBT, aiding in debugging and monitoring.

## Purpose
- Contains detailed logs of DBT runs, including model compilation, query execution, and any errors or warnings.
- Useful for troubleshooting issues, auditing processes, or analyzing performance.

## Usage
### **1. Log File Storage**
- By default, DBT writes logs to `dbt.log` in this folder when logging is enabled.
- Logs capture detailed execution information such as:
  - Start and end times of DBT runs
  - SQL compilation and execution details
  - Warnings and errors encountered during execution

### **2. Configuring Log Path**
You can explicitly set the log path in `dbt_project.yml`:
```yaml
log-path: "logs"
```
Or specify it dynamically via the command line:
```bash
dbt run --log-path logs
```

## Example Content
A typical `dbt.log` file might include:
```text
2025-03-17 10:00:00 [INFO] Running with dbt=1.5.0
2025-03-17 10:00:01 [DEBUG] Compiling model stg_customers
2025-03-17 10:00:02 [INFO] Executing query for stg_customers
2025-03-17 10:00:03 [WARNING] Model stg_orders took longer than expected
2025-03-17 10:00:04 [ERROR] Failed to execute model stg_payments due to syntax error
```

## Notes
- This folder is optional but recommended for centralizing log output.
- If no `log-path` is specified, logs are written to the console instead.
- Check this folder when:
  - Debugging failed runs
  - Investigating unexpected behavior
  - Monitoring performance over time
- Log files may grow large over time. Consider setting up log rotation or periodic cleanup if needed.