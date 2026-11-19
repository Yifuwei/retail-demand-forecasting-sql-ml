
-- 1. Weekly selling prices
CREATE TABLE IF NOT EXISTS sell_prices (
    store_id VARCHAR(20),
    item_id VARCHAR(50),
    wm_yr_wk INTEGER,
    sell_price NUMERIC(10, 4),
    PRIMARY KEY (store_id, item_id, wm_yr_wk)
);

-- 2. Training/validation sales
CREATE TABLE IF NOT EXISTS sales_validation (
    item_id VARCHAR(50),
    store_id VARCHAR(20),
    d VARCHAR(10),
    units_sold INTEGER,
    PRIMARY KEY (item_id, store_id, d)
);

-- 3. Evaluation sales
CREATE TABLE IF NOT EXISTS sales_evaluation (
    item_id VARCHAR(50),
    store_id VARCHAR(20),
    d VARCHAR(10),
    units_sold INTEGER,
    PRIMARY KEY (item_id, store_id, d)
);

-- 4. Forecast submission template
CREATE TABLE IF NOT EXISTS sample_submission (
    id VARCHAR(100),
    horizon_day INTEGER,
    forecast DOUBLE PRECISION,
    PRIMARY KEY (id, horizon_day)
);
