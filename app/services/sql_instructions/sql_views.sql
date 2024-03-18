-- Reports for the application
-- 1. Count of sold properties by agent
CREATE OR REPLACE VIEW sales_count_by_agent AS
SELECT agent_id, COUNT(*) AS total_sales
FROM sold_properties
GROUP BY agent_id, name;

-- 2. Count of sold properties by seller
CREATE OR REPLACE VIEW sales_count_by_seller AS
SELECT seller_id, COUNT(*) AS total_sales
FROM sold_properties
GROUP BY seller_id, name;

-- 3. Count of bought properties by buyer
CREATE OR REPLACE VIEW bought_count_by_buyer AS
SELECT buyer_id, COUNT(*) AS total_bought
FROM bought_properties
GROUP BY buyer_id, name;

-- 4. Sold properties by city
CREATE OR REPLACE VIEW sold_properties_by_city AS
SELECT city, COUNT(*) AS total_sales
FROM sold_properties
GROUP BY city;

-- 5. Sold properties by sale price
CREATE OR REPLACE VIEW sold_properties_by_sale_price AS
SELECT sale_price, COUNT(*) AS total_sales
FROM sold_properties
GROUP BY sale_price;

-- 6. Sold properties by characteristics like amount of bedrooms and if it has a pool
CREATE OR REPLACE VIEW sold_properties_by_characteristics AS
SELECT bedrooms, pool, COUNT(*) AS total_sales
FROM sold_properties
GROUP BY bedrooms, pool;

-- 7. Agent that sold the most amount of properties in the year by the total price
CREATE OR REPLACE VIEW top_agent_by_sales_value AS
SELECT agent_id, SUM(sale_price) AS total_sales_value
FROM sold_properties
WHERE EXTRACT(YEAR FROM sale_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY agent_id
ORDER BY total_sales_value DESC
LIMIT 1;

-- 8. For each agent, the average sale price of the properties sold in the year and the time it took to sell them
CREATE OR REPLACE VIEW avg_sale_price_and_time_on_market_by_agent AS
SELECT agent_id, AVG(sale_price) AS avg_sale_price, AVG(EXTRACT(DAY FROM age(sale_date, listing_date))) AS avg_days_on_market
FROM sold_properties
JOIN available_properties ON sold_properties.id = available_properties.id
WHERE EXTRACT(YEAR FROM sale_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY agent_id;
