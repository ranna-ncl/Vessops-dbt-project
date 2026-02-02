# DBT Macros

## Overview
Macros in DBT (Data Build Tool) are reusable pieces of Jinja code, similar to functions in other programming languages. They help eliminate repetitive code across multiple models and improve maintainability.

Macros are typically stored in `.sql` files within the `macros/` directory and can contain one or more macro definitions.

## Creating a Macro
A macro is defined using the Jinja `macro` tag. Below is an example of a simple macro that converts cents to dollars:

```sql
-- File: macros/cents_to_dollars.sql

{% macro cents_to_dollars(column_name, scale=2) %}
    ({{ column_name }} / 100)::numeric(16, {{ scale }})
{% endmacro %}
```

## Using a Macro
Once defined, macros can be used in your models. Here is an example of how to use the `cents_to_dollars` macro in a DBT model:

```sql
-- File: models/stg_payments.sql

select
  id as payment_id,
  {{ cents_to_dollars('amount') }} as amount_usd
from app_data.payments
```

### Compiled SQL Output
When DBT compiles the above model, the macro expands into:

```sql
select
  id as payment_id,
  (amount / 100)::numeric(16, 2) as amount_usd
from app_data.payments
```

## Using Macros from Packages
DBT allows using macros from external packages such as `dbt-utils`. When using a macro from a package, prefix it with the package name:

```sql
select
  field_1,
  field_2,
  field_3,
  field_4,
  field_5,
  count(*)
from my_table
{{ dbt_utils.dimensions(5) }}
```

Similarly, you can qualify macros from your own project using your package name (useful for package authors).

## Best Practices
- Use Jinja's whitespace control (`-{%` and `%}-`) to format macros neatly.
- Keep macros modular and reusable.
- Document each macro for clarity.
- Store macros in appropriately named files based on their functionality.

For more details, refer to the [official DBT documentation](https://docs.getdbt.com/docs/building-a-dbt-project/jinja-macros).

---

This `README.md` provides an overview of macros in DBT, how to define and use them, and best practices to follow when working with them.
