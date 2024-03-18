class CreateSqlViews < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW sales_count_by_agent AS
      SELECT agent_id, name, COUNT(*) AS total_sales
      FROM sold_properties
      GROUP BY agent_id, name;

      CREATE OR REPLACE VIEW sales_count_by_seller AS
      SELECT seller_id, name, COUNT(*) AS total_sales
      FROM sold_properties
      GROUP BY seller_id, name;

      CREATE OR REPLACE VIEW bought_count_by_buyer AS
      SELECT buyer_id, name, COUNT(*) AS total_bought
      FROM sold_properties
      GROUP BY buyer_id, name;

      CREATE OR REPLACE VIEW sold_properties_by_city AS
      SELECT city, COUNT(*) AS total_sales
      FROM sold_properties
      GROUP BY city;

      CREATE OR REPLACE VIEW sold_properties_by_sale_price AS
      SELECT sale_price, COUNT(*) AS total_sales
      FROM sold_properties
      GROUP BY sale_price;

      CREATE OR REPLACE VIEW sold_properties_by_characteristics AS
      SELECT bedrooms, has_pool, COUNT(*) AS total_sales
      FROM sold_properties
      GROUP BY bedrooms, has_pool;

      CREATE OR REPLACE VIEW top_agent_by_sales_value AS
      SELECT agent_id, SUM(sale_price) AS total_sales_value
      FROM sold_properties
      WHERE EXTRACT(YEAR FROM sale_date) = EXTRACT(YEAR FROM CURRENT_DATE)
      GROUP BY agent_id
      ORDER BY total_sales_value DESC
      LIMIT 1;

      CREATE OR REPLACE VIEW avg_sale_price_and_time_on_market_by_agent AS
      SELECT sold_properties.agent_id, AVG(sale_price) AS avg_sale_price, AVG(EXTRACT(DAY FROM age(sale_date, publication_date))) AS avg_days_on_market
      FROM sold_properties
      JOIN available_properties ON sold_properties.id = available_properties.id
      WHERE EXTRACT(YEAR FROM sale_date) = EXTRACT(YEAR FROM CURRENT_DATE)
      GROUP BY sold_properties.agent_id;
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS sales_count_by_agent;
      DROP VIEW IF EXISTS sales_count_by_seller;
      DROP VIEW IF EXISTS bought_count_by_buyer;
      DROP VIEW IF EXISTS sold_properties_by_city;
      DROP VIEW IF EXISTS sold_properties_by_sale_price;
      DROP VIEW IF EXISTS sold_properties_by_characteristics;
      DROP VIEW IF EXISTS top_agent_by_sales_value;
      DROP VIEW IF EXISTS avg_sale_price_and_time_on_market_by_agent;
    SQL
  end
end
