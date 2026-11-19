
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







