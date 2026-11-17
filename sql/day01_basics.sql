-- Week 1 Day 1
-- Basic SQL Practice

CREATE TABLE sales (
    item_id TEXT,
    store_id TEXT,
    units_sold INTEGER
);

INSERT INTO sales VALUES
('FOODS_001', 'CA_1', 12),
('FOODS_002', 'CA_1', 8),
('FOODS_003', 'CA_1', 20),
('FOODS_001', 'CA_2', 15),
('FOODS_002', 'CA_2', 5);

-- 1. View all records
SELECT * FROM sales;

-- 2. Filter sales greater than 10
SELECT * FROM sales
WHERE units_sold > 10;

-- 3. Sort by sales volume
SELECT * FROM sales
ORDER BY units_sold DESC;

-- 4. Count records
SELECT COUNT(*) FROM sales;

-- 5. Count distinct products
SELECT COUNT(DISTINCT item_id) FROM sales;
