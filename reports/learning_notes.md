
# SQL + ML Learning Journal

## Week 1 — Day 1

Date: 2026-11-17

### Course
IBM — Databases and SQL for Data Science with Python

### Topics Covered
- Introduction to Databases
- SELECT statements
- COUNT, DISTINCT，LIMIT，OFFSET

### Practical Work
- Created GitHub repository
- Created SQL practice file
- Practised querying a sample sales table

### What I Learned
Seems it doesn't matter whether they are capital letters 
Basic syntax of SELECT，COUNT, DISTINCT，LIMIT，OFFSET
Limit need to put after Where

### Problems Encountered
not yet

### Next Steps
- Learn relational database concepts
- Explore the M5 dataset

Use this cheat sheet for various SQL commands and their syntax, descriptions, and examples.

![Screenshot 2026-11-17 144830](..\images\Screenshot 2026-11-17 144830.png)

![Screenshot 2026-11-17 144803](..\images\Screenshot 2026-11-17 144803.png)

![Screenshot 2026-11-17 144821](..\images\Screenshot 2026-11-17 144821.png)

## Week 1 Day 2

## CREATE TABLE

**Syntax (MySQL/DB2):**

`CREATE TABLE table_name (col1 datatype optional keyword, col2 datatype optional keyword,col3 datatype optional keyword,..., coln datatype optional keyword)`

`CREATE TABLE employee ( employee_id char(2) PRIMARY KEY, first_name varchar(30) NOT NULL, mobile int);`

## ALTER TABLE - ADD COLUMN

`ALTER TABLE table_name ADD column_name_1 datatype....ADD COLUMN column_name_n datatype; `

## ALTER TABLE - ALTER COLUMN

`ALTER TABLE table_name MODIFY column_name_1 new_data_type;`

## ALTER TABLE - DROP COLUMN

`ALTER TABLE table_name DROP COLUMN column_name_1 ;`

## ALTER TABLE - RENAME COLUMN

`ALTER TABLE table_name CHANGE COLUMN current_column_name new_column_name datatype [optional keywords];`

`ALTER TABLE employee CHANGE COLUMN first_name name VARCHAR(255);`

## TRUNCATE TABLE

`TRUNCATE TABLE table_name;`

## DROP TABLE

`DROP TABLE table_name ;`



## Week 1 Day 3

## 1. SQL syntax quick reference

| Keyword    | Purpose                     | Example                        |
| ---------- | --------------------------- | ------------------------------ |
| `SELECT`   | Select columns              | `SELECT item_id, sell_price`   |
| `FROM`     | Choose table                | `FROM sell_prices`             |
| `WHERE`    | Filter rows before grouping | `WHERE sell_price > 10`        |
| `DISTINCT` | Remove duplicates           | `SELECT DISTINCT store_id`     |
| `LIMIT`    | Limit returned rows         | `LIMIT 10`                     |
| `ORDER BY` | Sort rows                   | `ORDER BY sell_price DESC`     |
| `GROUP BY` | Group rows                  | `GROUP BY store_id`            |
| `HAVING`   | Filter grouped results      | `HAVING COUNT(*) > 100`        |
| `AS`       | Alias                       | `AVG(sell_price) AS avg_price` |

**Written clause order:** `SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT`.

```sql
SELECT store_id,
       COUNT(*) AS records,
       AVG(sell_price) AS avg_price
FROM sell_prices
WHERE sell_price > 5
GROUP BY store_id
HAVING COUNT(*) > 100
ORDER BY avg_price DESC
LIMIT 10;
```

## 2. Filtering with WHERE

```sql
-- Exact match
SELECT * FROM sell_prices WHERE store_id = 'CA_1' LIMIT 10;

-- Combine conditions
SELECT * FROM sell_prices
WHERE store_id = 'CA_1' AND sell_price >= 5
LIMIT 10;

-- Set membership (specific values only)
SELECT * FROM sell_prices WHERE store_id IN ('CA_1', 'CA_2') LIMIT 10;

-- Inclusive interval
SELECT * FROM sell_prices WHERE sell_price BETWEEN 10 AND 25 LIMIT 10;

-- Text pattern
SELECT * FROM sell_prices WHERE item_id LIKE 'HOBBIES%' LIMIT 10;

-- Non-null values
SELECT * FROM sell_prices WHERE sell_price IS NOT NULL LIMIT 10;
```

**Quiz trap:** `IN (10, 25)` matches only 10 or 25; `BETWEEN 10 AND 25` includes every value in that range, including endpoints.

## 3. Sorting

```sql
SELECT * FROM sell_prices ORDER BY sell_price ASC LIMIT 10;
SELECT * FROM sell_prices ORDER BY sell_price DESC LIMIT 10;
SELECT * FROM sell_prices ORDER BY store_id ASC, sell_price DESC LIMIT 20;
```

`ASC` = ascending (default); `DESC` = descending.

## 4. Aggregation, GROUP BY and HAVING

| Function                              | Meaning                     |
| ------------------------------------- | --------------------------- |
| `COUNT(*)`                            | Number of rows              |
| `COUNT(DISTINCT item_id)`             | Number of distinct products |
| `SUM(sell_price)`                     | Sum of recorded prices      |
| `AVG(sell_price)`                     | Average recorded price      |
| `MIN(sell_price)` / `MAX(sell_price)` | Minimum / maximum           |
| `ROUND(value, 2)`                     | Round to two decimal places |

```sql
SELECT store_id,
       COUNT(*) AS price_records,
       COUNT(DISTINCT item_id) AS products,
       ROUND(AVG(sell_price), 2) AS avg_price
FROM sell_prices
GROUP BY store_id
ORDER BY avg_price DESC;
```

`AVG(sell_price)` here is an average across **weekly price records**, not an equally weighted average across unique products.

```sql
SELECT store_id, AVG(sell_price) AS avg_price
FROM sell_prices
WHERE sell_price > 5
GROUP BY store_id
HAVING AVG(sell_price) > 10;
```

`WHERE` filters individual rows; `HAVING` filters groups after aggregation.

## 5. PostgreSQL / pgAdmin checks

In pgAdmin, connect to `retail_ml`, open **Query Tool**, and run:

```sql
-- Confirm number of imported records
SELECT COUNT(*) FROM sell_prices;

-- Inspect a few rows
SELECT * FROM sell_prices LIMIT 10;

-- Inspect table schema
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'sell_prices'
ORDER BY ordinal_position;
```

**Confirmed in this session:** `sell_prices` has **6,841,121 rows**. The table has these columns:

| Column       | PostgreSQL type   |
| ------------ | ----------------- |
| `store_id`   | character varying |
| `item_id`    | character varying |
| `wm_yr_wk`   | integer           |
| `sell_price` | numeric           |

The `calendar` table has also been imported. There is **no need to reimport the price sample** into the already populated `sell_prices` table.

### Import troubleshooting

- In **Import/Export Data**, select CSV format, `Header = Yes`, delimiter `,` and appropriate columns.
- Open **View Processes** and the failed task's log to inspect the actual error.
- `duplicate key value` may indicate data already exists (if a matching unique/primary key is defined).
- `invalid input syntax` often indicates a type mismatch.
- `could not open file` may indicate a path or permissions issue.
- Check `SELECT COUNT(*)` before attempting another import.

## 6. Pandas: read and sample CSV

Windows paths containing `\U` can cause a Python `unicodeescape` syntax error. Use a raw string (`r"..."`) or forward slashes.

```python
import pandas as pd

prices = pd.read_csv(
    r"C:\Users\Yifu Wei\Downloads\m5-forecasting-accuracy\sell_prices.csv"
)

store = prices[prices["store_id"] == "CA_1"]
items = store["item_id"].drop_duplicates().head(10)
sample = store[store["item_id"].isin(items)].copy()

sample.to_csv("sell_prices_sample.csv", index=False)
print(sample.shape)
print(sample.head())
```

- `drop_duplicates()` removes repeated values.
- `head(10)` selects the first 10 entries.
- `isin(items)` checks membership.
- `.copy()` creates a separate DataFrame.
- `index=False` prevents an extra index column in CSV.
- Ten products can generate **many rows**, because prices are recorded by week.

## 7. JOIN preview (next lesson)

```sql
SELECT c.date,
       p.store_id,
       p.item_id,
       p.sell_price
FROM calendar AS c
INNER JOIN sell_prices AS p
    ON c.wm_yr_wk = p.wm_yr_wk
WHERE p.store_id = 'CA_1'
  AND p.item_id = 'HOBBIES_1_001'
ORDER BY c.date
LIMIT 20;
```

- `INNER JOIN` returns rows matching the `ON` condition in both tables.
- `c` and `p` are table aliases.
- `wm_yr_wk` connects calendar dates to weekly prices.
- **Granularity matters:** `calendar` is daily; `sell_prices` is product-store-week. A weekly price can appear on multiple calendar dates after joining. This is expected, not necessarily a data-quality error.
- Before modelling, decide whether one row represents a **product-store-day** or a **product-store-week** to avoid incorrect aggregation and leakage.

## 8. Quick self-test

1. Which clause sorts prices from high to low?
2. What is the difference between `IN (10, 25)` and `BETWEEN 10 AND 25`?
3. Which clause filters groups by average price?
4. What does `COUNT(DISTINCT item_id)` count?
5. Which field connects M5 `calendar` and `sell_prices`?

<details>
<summary>Answers</summary>


1. `ORDER BY sell_price DESC`
2. `IN` selects two exact values; `BETWEEN` selects an inclusive range.
3. `HAVING AVG(sell_price) > ...`
4. The number of distinct item IDs.
5. `wm_yr_wk`.







