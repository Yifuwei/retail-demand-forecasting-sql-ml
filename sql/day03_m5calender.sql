SELECT
    item_id,
    store_id,
    wm_yr_wk,
    sell_price
FROM sell_prices
WHERE sell_price > 10
ORDER BY sell_price
LIMIT 20;